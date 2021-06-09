Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810D03A1436
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbhFIMW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:22:57 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:39191 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239763AbhFIMWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:22:44 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id EE21BCECCD;
        Wed,  9 Jun 2021 14:28:47 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] NULL check value returned by alloc_skb
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210609091149.12557-1-find.dhiraj@gmail.com>
Date:   Wed, 9 Jun 2021 14:20:48 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <55C683FF-DC9D-4D38-8BFF-D97685462E1C@holtmann.org>
References: <20210609091149.12557-1-find.dhiraj@gmail.com>
To:     Dhiraj Shah <find.dhiraj@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhiraj,

> Return error ENOMEM if alloc_skb() failed.
> 
> Signed-off-by: Dhiraj Shah <find.dhiraj@gmail.com>
> ---
> drivers/bluetooth/virtio_bt.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
> index c804db7e90f8..5f82574236c0 100644
> --- a/drivers/bluetooth/virtio_bt.c
> +++ b/drivers/bluetooth/virtio_bt.c
> @@ -34,6 +34,8 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
> 	int err;
> 
> 	skb = alloc_skb(1000, GFP_KERNEL);
> +	if (!skb)
> +		return -ENOMEM;
> 	sg_init_one(sg, skb->data, 1000);
> 
> 	err = virtqueue_add_inbuf(vq, sg, 1, skb, GFP_KERNEL);

a similar patch is already upstream in bluetooth-next.

Regards

Marcel

