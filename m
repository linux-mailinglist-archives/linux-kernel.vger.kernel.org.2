Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D6042A8CF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbhJLPxe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Oct 2021 11:53:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:36465 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbhJLPxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:53:24 -0400
Received: from smtpclient.apple (p4fefcb73.dip0.t-ipconnect.de [79.239.203.115])
        by mail.holtmann.org (Postfix) with ESMTPSA id 49D3ECECE1;
        Tue, 12 Oct 2021 17:51:21 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH btusb] Fix application of sizeof to pointer
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211012020113.176098-1-davidcomponentone@gmail.com>
Date:   Tue, 12 Oct 2021 17:51:21 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
Content-Transfer-Encoding: 8BIT
Message-Id: <001E47DE-BD44-41A8-B21B-DD5CE10F5CAB@holtmann.org>
References: <20211012020113.176098-1-davidcomponentone@gmail.com>
To:     davidcomponentone@gmail.com
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

> The coccinelle check report:
> "./drivers/bluetooth/btusb.c:2239:36-42:
> ERROR: application of sizeof to pointer".
> Using the "sizeof(bdaddr_t)" to fix it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>
> ---
> drivers/bluetooth/btusb.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 75c83768c257..ecc56723aa5f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2236,7 +2236,7 @@ static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t *bdaddr)
> 	struct sk_buff *skb;
> 	long ret;
> 
> -	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr), bdaddr, HCI_INIT_TIMEOUT);
> +	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr_t), bdaddr, HCI_INIT_TIMEOUT);

in a different review, I said, just use 6 as all the other drivers do.

Regards

Marcel

