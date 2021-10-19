Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A34433E73
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234929AbhJSScu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Oct 2021 14:32:50 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:46132 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232833AbhJSScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 14:32:48 -0400
Received: from smtpclient.apple (p54899aa7.dip0.t-ipconnect.de [84.137.154.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6F92BCED07;
        Tue, 19 Oct 2021 20:30:34 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix memory leak in
 virtbt_rx_handle()
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211015225048.342949-1-soenke.huster@eknoes.de>
Date:   Tue, 19 Oct 2021 20:30:34 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <9DD7F001-3560-4A97-ACC4-36C385560135@holtmann.org>
References: <20211015225048.342949-1-soenke.huster@eknoes.de>
To:     Soenke Huster <soenke.huster@eknoes.de>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soenke,

> On the reception of packets with a packet type that is not processed by
> the virtbt driver, the memory of the allocated socket buffers is never
> freed. Add a default case that frees these to avoid a memory leak.
> 
> Signed-off-by: Soenke Huster <soenke.huster@eknoes.de>
> ---
> drivers/bluetooth/virtio_bt.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index 57908ce4fae8..2de0f54ada73 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -202,6 +202,8 @@ static void virtbt_rx_handle(struct virtio_bluetooth *vbt, struct sk_buff *skb)
> 		hci_skb_pkt_type(skb) = pkt_type;
> 		hci_recv_frame(vbt->hdev, skb);
> 		break;
> +	default:
> +		kfree_skb(skb);

I prefer that even default cases have a break;.

Regards

Marcel

