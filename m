Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152DB3A89E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 22:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFOUDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 16:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOUDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 16:03:10 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E18AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:01:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e1so9031880pld.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mK+dfw12PspGdiDN7Aja8xm932jImZhUu7ubIXVtJsU=;
        b=JvEedf9F3D9MeBwaBi93hXBFxl6ykGnIO8M/fT1+3W23aYtEtMwyReUX6yig0en4/U
         +b6A+77kNIUzuP4YyHnffUicj+SsMqtektA7i6226Dlze3k09BefmU/8Lsyk9TD1gtpI
         s60V889fOAVIMfDL5SswZ8Dno9ARipANCYaI6nBNhZj5neYsb0bcgkcY9WH9SRLgmS4f
         UKofDiqKgBFywPonoEqQWjXucD7SIQE7uIa84/xw7wkIXq/lqPDyQXbb1zUieTRScxoe
         iiOL6znAeWWdzau5+bHeM7MG3bRbBvT5MPzOyEOao3ey640KHCG62Asl70Ked62XaoJU
         LvVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mK+dfw12PspGdiDN7Aja8xm932jImZhUu7ubIXVtJsU=;
        b=SSwvdFak/IVpKbQSi9rNpcK2z/m4BAATaARCbZjO6gOmkbMqHXNsX3l+iZA8o5HYG8
         uy1gCLvTtat+0E5niCei2V54PIbyRZJltffx/mgQqjAMx+8GeOtZEXD51qhTurFW4S2Z
         pRYOB1Pr6qc5fE7p0JoBpxC42yX5QD/d8+TSf+2vT4/LZBiWk7dsdFsGguvt25omkBqU
         BRIFk1/zFMs+EdACmZAV3ufsVoLVTnd6/77sfIYUfDMOBcwxQAvSNrgC7wLCtxdDEd87
         byMp5uFaAfMoLDH6VWKienneywoYa00yHXzLluoazwT+Zw0UrhW+/iJTIxIRlRgRxLXT
         tOlQ==
X-Gm-Message-State: AOAM531CRqmgsWwpJEFg8oWXfpDwOtEEjIgW4q6zVauilWrb/057uZLZ
        oVjtQTjDva3MXR82nbBGR0L5Tg==
X-Google-Smtp-Source: ABdhPJy9OFWieDH+w6Dl/3tdrj3B3eDZo8MuDjBTUM/GngXfeh+0a9bRd6P3eVzDzCFrqRdv3CRcWg==
X-Received: by 2002:a17:903:2c3:b029:11b:cbb9:edfb with SMTP id s3-20020a17090302c3b029011bcbb9edfbmr5871567plk.12.1623787265465;
        Tue, 15 Jun 2021 13:01:05 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x20sm5817pfu.205.2021.06.15.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 13:01:04 -0700 (PDT)
Date:   Tue, 15 Jun 2021 14:01:02 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
Subject: Re: [PATCH 3/4] rpmsg: char: Introduce the "rpmsg-raw" channel
Message-ID: <20210615200102.GE604521@p14s>
References: <20210607173032.30133-1-arnaud.pouliquen@foss.st.com>
 <20210607173032.30133-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607173032.30133-4-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 07:30:31PM +0200, Arnaud Pouliquen wrote:
> Allows to probe the endpoint device on a remote name service announcement,
> by registering a rpmsg_driverfor the "rpmsg-raw" channel.
> 
> With this patch the /dev/rpmsgX interface can be instantiated by the remote
> firmware.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 54 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 52 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 4199ac1bee10..3b850b218eb0 100644
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
> @@ -416,6 +418,40 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>  }
>  EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>  
> +static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
> +{
> +	struct rpmsg_channel_info chinfo;
> +
> +	memcpy(chinfo.name, RPMSG_CHAR_DEVNAME, sizeof(RPMSG_CHAR_DEVNAME));
> +	chinfo.src = rpdev->src;
> +	chinfo.dst = rpdev->dst;
> +
> +	return __rpmsg_chrdev_eptdev_create(rpdev, &rpdev->dev, chinfo, true);

I am a little puzzled here as to why we need different modes... Why can't we
simply call rpmsg_chrdev_eptdev_create() and let the endpoint be created on
open() and destroyed on release() as per the current implementation?

I'd rather keep things simple for the refactoring and introduce new features
later if need be.

As I said, it may be that I don't understand the usecase.

Thanks,
Mathieu

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
> +	.drv = {
> +		.name = "rpmsg_chrdev",
> +	},
> +};
> +
>  static int rpmsg_chrdev_init(void)
>  {
>  	int ret;
> @@ -429,16 +465,30 @@ static int rpmsg_chrdev_init(void)
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
