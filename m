Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7766A393DD0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 09:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235909AbhE1H20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 03:28:26 -0400
Received: from mail.v3.sk ([167.172.186.51]:49470 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235838AbhE1H2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 03:28:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id BFABCE149E;
        Fri, 28 May 2021 07:20:16 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FCyTieu7pB7o; Fri, 28 May 2021 07:20:14 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 9AC34E14C8;
        Fri, 28 May 2021 07:20:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5oYQl01BQKVL; Fri, 28 May 2021 07:20:14 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id EFF21E149E;
        Fri, 28 May 2021 07:20:13 +0000 (UTC)
Date:   Fri, 28 May 2021 09:26:36 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     nizamhaider786@gmail.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] char: pcmcia: scr24x_cs: Fix failure handling of
 device_create()
Message-ID: <YLCbLND0Q+H2zL38@demiurge.local>
References: <20210527193429.696-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527193429.696-1-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

much better now, thank you.

Acked-by: Lubomir Rintel <lkundrak@v3.sk>

There's one small remark below.

On Fri, May 28, 2021 at 01:04:29AM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Ignored error in device_create() and pcmcia_enable_device()
> this patch implements proper error handling.
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
> V3 -> V4: Added label and moved the cleanup code
> V2 -> V3: Added description, Changelog and removed whitespace error
> V1 -> V2: Split the patch into two parts and addressed review comments
> ---
>  drivers/char/pcmcia/scr24x_cs.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
> index 47feb39af34c..ba84b4dd13d3 100644
> --- a/drivers/char/pcmcia/scr24x_cs.c
> +++ b/drivers/char/pcmcia/scr24x_cs.c
> @@ -233,6 +233,7 @@ static int scr24x_probe(struct pcmcia_device *link)
>  {
>  	struct scr24x_dev *dev;
>  	int ret;
> +	struct device *dev_ret;
>  
>  	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
>  	if (!dev)
> @@ -271,22 +272,28 @@ static int scr24x_probe(struct pcmcia_device *link)
>  		goto err;
>  
>  	ret = pcmcia_enable_device(link);
> -	if (ret < 0) {
> -		pcmcia_disable_device(link);
> -		goto err;
> -	}
> +	if (ret < 0)
> +		goto err_device;
>  
> -	device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
> +	dev_ret = device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
>  		      NULL, "scr24x%d", dev->devno);
> +	if (IS_ERR(dev_ret)) {
> +		dev_err(&link->dev, "device_create failed for %d\n",
> +			dev->devno);
> +		goto err_device;
> +	}
>  
>  	dev_info(&link->dev, "SCR24x Chip Card Interface\n");
>  	return 0;
>  
> +err_device:
> +	pcmcia_disable_device(link);
> +	cdev_del(&dev->c_dev);
>  err:
>  	if (dev->devno < SCR24X_DEVS)
>  		clear_bit(dev->devno, scr24x_minors);
>  	kfree (dev);
> -	return ret;
> +	return -ENODEV;

Why -ENODEV? Couldn't we propagate the original error with something
like "ret = PTR_ERR(dev_ret);" just before the "goto err_device"?

Thank you,
Lubo

>  }
>  
>  static void scr24x_remove(struct pcmcia_device *link)
> -- 
> 2.17.1
> 
