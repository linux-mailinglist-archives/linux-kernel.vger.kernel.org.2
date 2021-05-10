Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7311F37812C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 12:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhEJKXQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 May 2021 06:23:16 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:37389 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbhEJKXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 06:23:15 -0400
X-Originating-IP: 90.89.138.59
Received: from xps13 (lfbn-tou-1-1325-59.w90-89.abo.wanadoo.fr [90.89.138.59])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 63400240003;
        Mon, 10 May 2021 10:22:08 +0000 (UTC)
Date:   Mon, 10 May 2021 12:22:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     dingsenjie@163.com
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, dingsenjie <dingsenjie@yulong.com>
Subject: Re: [PATCH] mtd: devices: Remove superfluous "break"
Message-ID: <20210510122207.03a6154b@xps13>
In-Reply-To: <20210409030900.40296-1-dingsenjie@163.com>
References: <20210409030900.40296-1-dingsenjie@163.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dingsenjie@163.com,

dingsenjie@163.com wrote on Fri,  9 Apr 2021 11:09:00 +0800:

> From: dingsenjie <dingsenjie@yulong.com>
> 
> Remove superfluous "break", as there is a "return" before them.
                                                            ^
                                                            it

> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>

                      ^
Please use your real name here.

> ---
>  drivers/mtd/devices/ms02-nv.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/ms02-nv.c b/drivers/mtd/devices/ms02-nv.c
> index fb4a6aa..08f76ff 100644
> --- a/drivers/mtd/devices/ms02-nv.c
> +++ b/drivers/mtd/devices/ms02-nv.c
> @@ -286,7 +286,6 @@ static int __init ms02nv_init(void)
>  		break;
>  	default:
>  		return -ENODEV;
> -		break;
>  	}
>  
>  	for (i = 0; i < ARRAY_SIZE(ms02nv_addrs); i++)

Thanks,
Miquèl
