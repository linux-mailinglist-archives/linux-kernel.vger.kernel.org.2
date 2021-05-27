Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C90392E35
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbhE0MqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234699AbhE0MqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:46:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A08EA606A5;
        Thu, 27 May 2021 12:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622119475;
        bh=yWXD/JVcL8Eya4d7EJft0H5iYuwpntsDRCo+6p+YUKA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bc0u1G0s1jQsrw6nzv0Gdr7QTgvTZlQsZY1Wa4CxQx1bpVGjfvIZAXS2c6Jp8Dai9
         XxEGKNUF3UcsiYPopA2ChS02pUBT5nqDFhSxdAdF8N+cPWy8uEths53ENxStsqkpTs
         HmeZTWWmPKf1Xpwgb++mFaPZexcdlvupcfKCxMpE=
Date:   Thu, 27 May 2021 14:44:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nizamhaider786@gmail.com
Cc:     lkundrak@v3.sk, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] char: pcmcia: scr24x_cs: Fix failure handling of
 device_create()
Message-ID: <YK+UMJoRHokxMS4/@kroah.com>
References: <20210524215202.495-1-nizamhaider786@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524215202.495-1-nizamhaider786@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 03:22:01AM +0530, nizamhaider786@gmail.com wrote:
> From: Nijam Haider <nizamhaider786@gmail.com>
> 
> Ignored error in device_create() and pcmcia_enable_device()
> this patch implements proper error handling.
> 
> Signed-off-by: Nijam Haider <nizamhaider786@gmail.com>
> ---
> V2 -> V3: Added description, Changelog and removed whitespace error
> V1 -> V2: Split the patch into two parts and addressed review comments
> ---
>  drivers/char/pcmcia/scr24x_cs.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/pcmcia/scr24x_cs.c b/drivers/char/pcmcia/scr24x_cs.c
> index 47feb39af34c..b48e79356611 100644
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
> @@ -272,12 +273,20 @@ static int scr24x_probe(struct pcmcia_device *link)
>  
>  	ret = pcmcia_enable_device(link);
>  	if (ret < 0) {
> +		cdev_del(&dev->c_dev);
>  		pcmcia_disable_device(link);
>  		goto err;
>  	}
>  
> -	device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
> +	dev_ret = device_create(scr24x_class, NULL, MKDEV(MAJOR(scr24x_devt), dev->devno),
>  		      NULL, "scr24x%d", dev->devno);
> +	if (IS_ERR(dev_ret)) {
> +		dev_err(&link->dev, "device_create failed for %d\n",
> +			dev->devno);
> +		cdev_del(&dev->c_dev);
> +		pcmcia_disable_device(link);
> +		goto err;
> +	}

The "better" way to do this is to have more err_: labels that do the
unwinding for you, so that you do not have to duplicate the same logic
in multiple places, like you are doing here.

Can you change this patch to do that instead?  Should be shorter overall
than this one and easier to maintain over time.

thanks,

greg k-h
