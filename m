Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DACC738E17E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhEXHZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 03:25:16 -0400
Received: from mail.v3.sk ([167.172.186.51]:43768 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232128AbhEXHZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 03:25:15 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 00F3DE145F;
        Mon, 24 May 2021 07:07:55 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id M_3ZIanHL_tU; Mon, 24 May 2021 07:07:54 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id A2634E1470;
        Mon, 24 May 2021 07:07:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SIFC3JLIp83A; Mon, 24 May 2021 07:07:54 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 6CE54E145F;
        Mon, 24 May 2021 07:07:54 +0000 (UTC)
Date:   Mon, 24 May 2021 09:14:18 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     nizamhaider786@gmail.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] char: pcmcia: scr24x_cs: Fix failure handling
 Handled failure cases of pcmcia_enable_device() and device_create()
Message-ID: <YKtSSiSNEKx6h1Pp@demiurge.local>
References: <20210523151111.2968-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523151111.2968-1-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/2] char: pcmcia: scr24x_cs: Fix failure handling
>  Handled failure cases of pcmcia_enable_device() and device_create()

Here you also manaded to squish the subject line and the patch
description together. Please break them into two.

On Sun, May 23, 2021 at 08:41:10PM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
>  drivers/char/pcmcia/scr24x_cs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
> index 47feb39..cad1990 100644
> --- a/drivers/char/pcmcia/scr24x_cs.c
> +++ b/drivers/char/pcmcia/scr24x_cs.c
> @@ -233,6 +233,7 @@ static int scr24x_probe(struct pcmcia_device *link)
>  {
>  	struct scr24x_dev *dev;
>  	int ret;
> +       struct device *dev_ret;

Looks like a whitespace error here?

>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
> @@ -272,12 +273,20 @@ static int scr24x_probe(struct pcmcia_device *link)
>  
>  	ret = pcmcia_enable_device(link);
>  	if (ret < 0) {
> +	        cdev_del(&dev->c_dev);

Also here? (a tab followed by spaces).

>  		pcmcia_disable_device(link);
>  		goto err;
>  	}
>  
> -	device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
> +	dev_ret = device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
>  		      NULL, "scr24x%d", dev->devno);
> +        if (IS_ERR(dev_ret)) {
> +                printk(KERN_ERR "device_create failed for %d\n",
> +                               dev->devno);
> +                cdev_del(&dev->c_dev);
> +                pcmcia_disable_device(link);
> +                goto err;
> +       }

...and also here.

In general, please try keeping the formatting consistent with the rest of
the file. Indentation is generally done with tabs.

>  	dev_info(&link->dev, "SCR24x Chip Card Interface\n");
>  	return 0;

Thank you,
Lubo
