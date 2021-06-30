Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1B33B89E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 22:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbhF3Uzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 16:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbhF3Uzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 16:55:39 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08B2C0617A8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:53:08 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s14so3763174pfg.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 13:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d9T9e25p90hnahZI/XHUP5v2qF1RQYbtkY6xr1j/vfE=;
        b=zeqSy28EbrNu1G8GySqxk5v25xKd0lZehGsfXmsfCSZkeqGRBOeAwdwdFH/v5F9ka+
         uxNi6AI8FWoy+mL6rOdfHZPTDQbu0w/mjaXJdEaVBqSz53yjkxQxOAIFXKpgqdpQKZwf
         qBgIpKlBC/jgcKDYo5iV5JVYZUrm0A3WuxyeKoANspl7G9eJ6ew+ppPpTGC3TeQIrRfm
         PlRh0QM0iTm3uLnoAma1MAt+IH35RgpV/MzFkyLrlXSqK9KmkKm9lJaYrBrSnu2jVhAr
         XFQIugfQiyhYD1Om+5txUXAUnaDPJ31dt1W9d7HPuoJnQ3cDuTstSr9iFLYbu0P29k99
         4E4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d9T9e25p90hnahZI/XHUP5v2qF1RQYbtkY6xr1j/vfE=;
        b=a9gcdQYg4h4x463qr3scLu8m0dUYIyxhHtziHOxXnDOIuq5qq1k5uqfLwOYVelJAYA
         wPiIMyziFhWrorw2tlf/WBW4LP0ik7Wzytq8df2mjYWtCPaH/qobSyUIxF4MicOf7Xhk
         pRye8NcGmWzsSxABVY4waBGj/RUvPlZVG8mYzLa50W4VY2wM3E7sHekJfEUrz3GMLoCH
         GNgGIVrGNvhBDid4rp1Wb+Sw5l75hOg/jXHB6NZcOq8/79iRE/iRi31EYIrQky9/PS6f
         mTrroD4I8LwdOKx9Iz/LALrsW8xPWWsPeqCiuUoZ82CXHRg8B4GfRhRSJRclFzV6GpfS
         TjsQ==
X-Gm-Message-State: AOAM533eYojCCR8RcoKaWACyhCq8F62PlF18nBhx1v2iwXNJY0DTXmk5
        GI1yynEQonrV1rmNI7utGQ4/ow==
X-Google-Smtp-Source: ABdhPJwxr2oAcQi1U2XicvjZgSQSqQpv+Lv0sdEhNFZ2xUFT+hgMKCDGVd9bXEp2SehOINQmtbUaMw==
X-Received: by 2002:aa7:8b56:0:b029:2b9:77be:d305 with SMTP id i22-20020aa78b560000b02902b977bed305mr37754864pfd.61.1625086388389;
        Wed, 30 Jun 2021 13:53:08 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c72sm4106741pfb.145.2021.06.30.13.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 13:53:07 -0700 (PDT)
Date:   Wed, 30 Jun 2021 14:53:05 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
Subject: Re: [PATCH v2 4/4] rpmsg: char: Introduce the "rpmsg-raw" channel
Message-ID: <20210630205305.GD1290178@p14s>
References: <20210623150504.14450-1-arnaud.pouliquen@foss.st.com>
 <20210623150504.14450-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623150504.14450-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 05:05:04PM +0200, Arnaud Pouliquen wrote:
> Allows to probe the endpoint device on a remote name service announcement,
> by registering a rpmsg_driverfor the "rpmsg-raw" channel.
> 
> With this patch the /dev/rpmsgX interface can be instantiated by the remote
> firmware.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
> update vs V1:
> - management of the default endpoint creation in the driver probe.
> 
> ---
>  drivers/rpmsg/rpmsg_char.c | 75 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 73 insertions(+), 2 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index a75dce1e29d8..3748de00c97b 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -25,6 +25,8 @@
>  
>  #include "rpmsg_char.h"
>  
> +#define RPMSG_CHAR_DEVNAME "rpmsg-raw"
> +
>  static dev_t rpmsg_major;
>  static struct class *rpmsg_class;
>  
> @@ -421,6 +423,61 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>  }
>  EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>  
> +static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_channel_info chinfo;
> +	struct rpmsg_eptdev *eptdev;
> +	struct rpmsg_endpoint *ept;
> +
> +	memcpy(chinfo.name, RPMSG_CHAR_DEVNAME, sizeof(RPMSG_CHAR_DEVNAME));
> +	chinfo.src = rpdev->src;
> +	chinfo.dst = rpdev->dst;
> +
> +	eptdev =  __rpmsg_chrdev_eptdev_create(rpdev, &rpdev->dev, chinfo);
> +	if (IS_ERR(eptdev))
> +		return PTR_ERR(eptdev);
> +
> +	/*
> +	 * Create the default endpoint associated to the rpmsg device and provide rpmsg_eptdev
> +	 * structure as callback private data.
> +	 */
> +	ept = rpmsg_create_default_ept(rpdev, rpmsg_ept_cb, eptdev, eptdev->chinfo);
> +	if (!ept) {
> +		dev_err(&rpdev->dev, "failed to create %s\n", eptdev->chinfo.name);
> +		put_device(&eptdev->dev);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Do not allow the creation and release of an endpoint on /dev/rpmsgX open and close,
> +	 * reuse the default endpoint instead
> +	 */
> +	eptdev->static_ept = true;
> +
> +	return 0;
> +}
> +
> +static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
> +{
> +	int ret;
> +
> +	ret = device_for_each_child(&rpdev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
> +	if (ret)
> +		dev_warn(&rpdev->dev, "failed to destroy endpoints: %d\n", ret);
> +}
> +
> +static struct rpmsg_device_id rpmsg_chrdev_id_table[] = {
> +	{ .name	= RPMSG_CHAR_DEVNAME },
> +	{ },
> +};
> +
> +static struct rpmsg_driver rpmsg_chrdev_driver = {
> +	.probe = rpmsg_chrdev_probe,
> +	.remove = rpmsg_chrdev_remove,
> +	.id_table = rpmsg_chrdev_id_table,
> +	.drv.name = "rpmsg_chrdev",
> +};
> +
>  static int rpmsg_chrdev_init(void)
>  {
>  	int ret;
> @@ -434,16 +491,30 @@ static int rpmsg_chrdev_init(void)
>  	rpmsg_class = class_create(THIS_MODULE, "rpmsg");
>  	if (IS_ERR(rpmsg_class)) {
>  		pr_err("failed to create rpmsg class\n");
> -		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
> -		return PTR_ERR(rpmsg_class);
> +		ret = PTR_ERR(rpmsg_class);
> +		goto free_region;
> +	}
> +
> +	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
> +	if (ret < 0) {
> +		pr_err("rpmsg: failed to register rpmsg raw driver\n");
> +		goto free_class;
>  	}
>  
>  	return 0;
> +
> +free_class:
> +	class_destroy(rpmsg_class);
> +free_region:
> +	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
> +
> +	return ret;
>  }
>  postcore_initcall(rpmsg_chrdev_init);
>  
>  static void rpmsg_chrdev_exit(void)
>  {
> +	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
>  	class_destroy(rpmsg_class);
>  	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>  }
> -- 
> 2.17.1
> 
