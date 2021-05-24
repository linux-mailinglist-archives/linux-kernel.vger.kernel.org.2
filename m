Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E0B38E165
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbhEXHUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:20:15 -0400
Received: from mail.v3.sk ([167.172.186.51]:43716 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232266AbhEXHUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:20:14 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Mon, 24 May 2021 03:20:14 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 08C9EE0737;
        Mon, 24 May 2021 07:03:39 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VSD9_7FxsSvv; Mon, 24 May 2021 07:03:38 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 994D2E1346;
        Mon, 24 May 2021 07:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id t53xqlHnorBN; Mon, 24 May 2021 07:03:38 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 53D74E0737;
        Mon, 24 May 2021 07:03:38 +0000 (UTC)
Date:   Mon, 24 May 2021 09:10:02 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     nizamhaider786@gmail.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] char: pcmcia: scr24x_cs: Fix redundant fops Removed
 redundant fops assignment, which was already done in cdev_init()
Message-ID: <YKtRSiVK1QEJasP+@demiurge.local>
References: <20210523151111.2968-1-nizamhaider786@gmail.com>
 <20210523151111.2968-2-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523151111.2968-2-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2021 at 08:41:11PM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 

Thank you for this. Needs another spin though:

> Subject: [PATCH 2/2] char: pcmcia: scr24x_cs: Fix redundant fops Removed
                                                                  ^
It seems like you accidentally removed a line break here ---------|,
squishing the subject and patch description together.

>  redundant fops assignment, which was already done in cdev_init()

Regards,
Lubo

> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
>  drivers/char/pcmcia/scr24x_cs.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
> index cad1990..0265d72 100644
> --- a/drivers/char/pcmcia/scr24x_cs.c
> +++ b/drivers/char/pcmcia/scr24x_cs.c
> @@ -266,7 +266,6 @@ static int scr24x_probe(struct pcmcia_device *link)
>  
>  	cdev_init(&dev->c_dev, &scr24x_fops);
>  	dev->c_dev.owner = THIS_MODULE;
> -	dev->c_dev.ops = &scr24x_fops;
>  	ret = cdev_add(&dev->c_dev, MKDEV(MAJOR(scr24x_devt), dev->devno), 1);
>  	if (ret < 0)
>  		goto err;
> -- 
> 2.7.4
> 
