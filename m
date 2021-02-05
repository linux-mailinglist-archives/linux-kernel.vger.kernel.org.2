Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1178310C2A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhBENtQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 Feb 2021 08:49:16 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:45983 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBENpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:45:46 -0500
Received: from relay3-d.mail.gandi.net (unknown [217.70.183.195])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id A9F513C48F6
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 13:28:23 +0000 (UTC)
X-Originating-IP: 90.89.227.234
Received: from xps13 (lfbn-tou-1-1424-234.w90-89.abo.wanadoo.fr [90.89.227.234])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 3CD6D6000B;
        Fri,  5 Feb 2021 13:26:19 +0000 (UTC)
Date:   Fri, 5 Feb 2021 14:26:18 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] drivers: mtd: Better word replace a not so good word in
 the file mtd_blkdevs.c
Message-ID: <20210205142618.116852a0@xps13>
In-Reply-To: <20210205124151.1386271-1-unixbhaskar@gmail.com>
References: <20210205124151.1386271-1-unixbhaskar@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote on Fri,  5 Feb 2021
18:11:51 +0530:

> s/fucking/invite/
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/mtd/mtd_blkdevs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index fb8e12d590a1..756a0995e474 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -523,7 +523,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>  	int ret;
> 
>  	/* Register the notifier if/when the first device type is
> -	   registered, to prevent the link/init ordering from fucking
> +	   registered, to prevent the link/init ordering from invite
>  	   us over. */

invite us over?

I'm not a native English speaker but this does not bring any value to
my ears. Worse, I don't even get the point. Better rewrite the comment
entirely than just swapping "fucking" with a random word, no?

Thanks,
Miquèl
