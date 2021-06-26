Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2D3B4CEC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jun 2021 07:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhFZGB5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Jun 2021 02:01:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39068 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhFZGBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jun 2021 02:01:53 -0400
Received: from smtpclient.apple (p5b3d2eb8.dip0.t-ipconnect.de [91.61.46.184])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7AAA8CED1E;
        Sat, 26 Jun 2021 07:59:30 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/1] Bluetooth: btusb: Record debug log for Mediatek Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210616191540.4487-1-mark-yw.chen@mediatek.com>
Date:   Sat, 26 Jun 2021 07:59:30 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <73A590F6-4EAF-44AC-8803-769F7919712C@holtmann.org>
References: <20210616191540.4487-1-mark-yw.chen@mediatek.com>
To:     Mark-YW.Chen@mediatek.com
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> Mediatek Bluetooth Controller send the fw log via EP2, this patch
> create callback(data->recv_acl) for processing acl packet.
> 
> 1. create callback(data->recv_acl) for processing acl packet.
> 2. Add btusb_recv_acl_mtk to dispatch acl packet.
> 3. Send mediatek debug log and coredump via hci_recv_diag channel.
> 4. The upper layerd can use hci_channel_minitor to receive
>   these packets.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 23 ++++++++++++++++++++++-
> 1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b015dcecfb13..0a86713f496b 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -569,6 +569,7 @@ struct btusb_data {
> 	int suspend_count;
> 
> 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> +	int (*recv_acl)(struct hci_dev *hdev, struct sk_buff *skb);
> 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
> 
> 	int (*setup_on_usb)(struct hci_dev *hdev);
> @@ -776,7 +777,7 @@ static int btusb_recv_bulk(struct btusb_data *data, void *buffer, int count)
> 
> 		if (!hci_skb_expect(skb)) {
> 			/* Complete frame */
> -			hci_recv_frame(data->hdev, skb);
> +			data->recv_acl(data->hdev, skb);
> 			skb = NULL;
> 		}
> 	}
> @@ -3851,6 +3852,24 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	struct btusb_data *data = hci_get_drvdata(hdev);
> +	int err;
> +

since this is guaranteed to be a complete ACL packet now, use the ACL header struct and compare the handle. Which also means you can nicely use a switch statement here.

> +	if (skb->data[0] == 0x6f && skb->data[1] == 0xfc) {

This needs a comment on why you disable auto-suspend here.

> +		usb_disable_autosuspend(data->udev);
> +		err = hci_recv_diag(data->hdev, skb);
> +	} else if ((skb->data[0] == 0xff || skb->data[0] == 0xfe) &&
> +		   skb->data[1] == 0x05) {
> +		err = hci_recv_diag(data->hdev, skb);

I would also comment on what type of diagnostic message each of these are.

> +	} else {
> +		err = hci_recv_frame(data->hdev, skb);
> +	}
> +
> +	return err;
> +}
> +
> MODULE_FIRMWARE(FIRMWARE_MT7663);
> MODULE_FIRMWARE(FIRMWARE_MT7668);
> 
> @@ -4542,6 +4561,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		data->recv_event = hci_recv_frame;
> 		data->recv_bulk = btusb_recv_bulk;
> 	}

Extra empty line before this statement.

> +	data->recv_acl = hci_recv_frame;
> 
> 	hdev = hci_alloc_dev();
> 	if (!hdev)
> @@ -4669,6 +4689,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->setup = btusb_mtk_setup;
> 		hdev->shutdown = btusb_mtk_shutdown;
> 		hdev->manufacturer = 70;
> +		data->recv_acl = btusb_recv_acl_mtk;
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
> 	}

Regards

Marcel

