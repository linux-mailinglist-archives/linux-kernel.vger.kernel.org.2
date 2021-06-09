Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771613A1D91
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 21:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFITTw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Jun 2021 15:19:52 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42502 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFITTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:19:51 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 19970CECD6;
        Wed,  9 Jun 2021 21:25:52 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH 1/2] Bluetooth: btusb: Record debug log for Mediatek Chip.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210609190734.30088-1-mark-yw.chen@mediatek.com>
Date:   Wed, 9 Jun 2021 21:17:52 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>, chris.lu@mediatek.com,
        will-cy.lee@mediatek.com, Sean Wang <sean.wang@mediatek.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        michaelfsun@google.com, shawnku@google.com, jemele@google.com
Content-Transfer-Encoding: 8BIT
Message-Id: <35B0FA64-903D-4747-8D39-4FA48D30A680@holtmann.org>
References: <20210609190734.30088-1-mark-yw.chen@mediatek.com>
To:     mark-yw.chen@mediatek.com
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

> 1. Add btusb_recv_bulk_mtk to receive debug log.
> 2. Send the debug log via hci_recv_diag channel.
> 3. The upper layerd use hci_channel_minitor to receive
>   these packets.
> 
> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> ---
> drivers/bluetooth/btusb.c | 67 +++++++++++++++++++++++++++++++++++++++
> 1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index b015dcecfb13..2a55ae0a5f8c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -3851,6 +3851,72 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btusb_recv_bulk_mtk(struct btusb_data *data, void *buffer, int count)
> +{
> +	struct sk_buff *skb;
> +	unsigned long flags;
> +	int err = 0;
> +
> +	spin_lock_irqsave(&data->rxlock, flags);
> +	skb = data->acl_skb;
> +
> +	while (count) {
> +		int len;
> +
> +		if (!skb) {
> +			skb = bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
> +			if (!skb) {
> +				err = -ENOMEM;
> +				break;
> +			}
> +
> +			hci_skb_pkt_type(skb) = HCI_ACLDATA_PKT;
> +			hci_skb_expect(skb) = HCI_ACL_HDR_SIZE;
> +		}
> +
> +		len = min_t(uint, hci_skb_expect(skb), count);
> +		skb_put_data(skb, buffer, len);
> +
> +		count -= len;
> +		buffer += len;
> +		hci_skb_expect(skb) -= len;
> +
> +		if (skb->len == HCI_ACL_HDR_SIZE) {
> +			__le16 dlen = hci_acl_hdr(skb)->dlen;
> +
> +			/* Complete ACL header */
> +			hci_skb_expect(skb) = __le16_to_cpu(dlen);
> +
> +			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
> +				kfree_skb(skb);
> +				skb = NULL;
> +
> +				err = -EILSEQ;
> +				break;
> +			}
> +		}
> +
> +		if (!hci_skb_expect(skb)) {
> +			/* Complete frame */
> +			if (skb->data[0] == 0x6f && skb->data[1] == 0xfc) {
> +				usb_disable_autosuspend(data->udev);
> +				hci_recv_diag(data->hdev, skb);
> +			} else if ((skb->data[0] == 0xfe || skb->data[0] == 0xff) &&
> +				   skb->data[1] == 0x05) {
> +				hci_recv_diag(data->hdev, skb);
> +			} else {
> +				hci_recv_frame(data->hdev, skb);
> +			}
> +			skb = NULL;
> +		}
> +	}
> +
> +	data->acl_skb = skb;
> +	spin_unlock_irqrestore(&data->rxlock, flags);
> +
> +	return err;
> +}
> +
> MODULE_FIRMWARE(FIRMWARE_MT7663);
> MODULE_FIRMWARE(FIRMWARE_MT7668);
> 
> @@ -4669,6 +4735,7 @@ static int btusb_probe(struct usb_interface *intf,
> 		hdev->setup = btusb_mtk_setup;
> 		hdev->shutdown = btusb_mtk_shutdown;
> 		hdev->manufacturer = 70;
> +		data->recv_bulk = btusb_recv_bulk_mtk;
> 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);

NO. The recv_bulk was meant for cases when bulk was faster and needed to redirected as interrupt/event data. Doing a complete copy of btusb_recv_bulk is not acceptable. You need to introduce data->recv_acl.

Regards

Marcel

