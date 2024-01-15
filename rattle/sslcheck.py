##pip install requests pyOpenSSL slack_sdk



import ssl
import socket
import datetime
import requests
from slack_sdk import WebClient
from slack_sdk.errors import SlackApiError

def get_ssl_expiry_date(domain, port):
    context = ssl.create_default_context()
    conn = context.wrap_socket(socket.create_connection((domain, port)), server_hostname=domain)
    ssl_info = conn.getpeercert()
    expiry_date_str = ssl_info['notAfter']
    expiry_date = datetime.datetime.strptime(expiry_date_str, "%b %d %H:%M:%S %Y %Z")
    return expiry_date

def send_slack_alert(webhook_url, message):
    client = WebClient(token=webhook_url)
    try:
        response = client.chat_postMessage(channel="#general", text=message)
        assert response["message"]["text"] == message
    except SlackApiError as e:
        print(f"Error sending Slack message: {e.response['error']}")

def main():
    domains = [
        {"domain": "loco.gg", "port": 443},
        {"domain": "getloconow.com", "port": 443},
        # Add more domains as needed
    ]

    slack_webhook_url = "YOUR_SLACK_WEBHOOK_URL"

    for domain_info in domains:
        domain = domain_info["domain"]
        port = domain_info["port"]

        expiry_date = get_ssl_expiry_date(domain, port)
        days_until_expiry = (expiry_date - datetime.datetime.now()).days

        if days_until_expiry < 15:
            message = f"SSL certificate for {domain}:{port} will expire in {days_until_expiry} days."
            send_slack_alert(slack_webhook_url, message)
        else:
            print(f"The SSL certificate for {domain}:{port} is valid for {days_until_expiry} days.")

if __name__ == "__main__":
    main()
