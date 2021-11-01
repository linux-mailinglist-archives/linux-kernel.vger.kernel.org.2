Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F58441EE4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhKAQ7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhKAQ7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:59:43 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADB2C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:57:10 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id n11so17693832oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nsS/0Rl8lV1MqhAr3I/tx4m9hBCBcMuxVc4GrA1ZK4c=;
        b=jXV+W3M4Qjhq5IjWhdgfLxBBGVrmhSNsyUKKEV1oLZ6X9kj7ceKMousk6cIeGfzvl6
         w+GUbdKFxLCiH/TYVsJ4MsGMJTeT2rEjP07aG3W77QavYvHM4tPL1sk4ZZza3PxOP+X5
         uRFsrjodKrGphkNNW6yjECiZSumUoCt5CuQsjK0UwVvDEWzSFWk0Rl6CU2CI7okVzHqT
         1L5XQKEVUuBm81wJ94IQGPzqwZgngyazTZ0PlKTHGTfeu1xa1GYmiUfpC2/h/UWkYWeo
         7MDY5kx7BVRafO44EcLiJxJNQ0NhuKorZyzPkwFdMP5cPxGbo3CmqnfT7BbwIQVEYGS0
         gb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsS/0Rl8lV1MqhAr3I/tx4m9hBCBcMuxVc4GrA1ZK4c=;
        b=YqwUOXwg/hjpMc2iRj2oeRR4Ju6vlUp2TAAGql4BzFtCZ48nzEHd0LEMzzc4KxgcMG
         4mrFvJX4CUXXefulYQ+xIiQInJQBIaydmofoW0cTEPuINfPy2snwk/DJCDLM9/j5ewpH
         NN2EYhoWrH4U7lSdQH0lKBIiEwOn6pnqRLiRLJR7qg/Vc/NUEDMqO+DPK/FkhTdvJ7UE
         eGPEMvIgIHOU1sIbGs6V9jI3NzfwEZ9u3J25/ti7E02CWNGsQO/mh6cqsk2aWBFU3TCD
         jlDBjTx4HK3CvlEuk6K7rMyu/S51AqPpFL7y/S1n/yyvh2QK935HeR/x02tQ2vjJkEk1
         1iXw==
X-Gm-Message-State: AOAM532y3lU03p52L2TR/kvm8kj6ddXKwznz5GuNw6cu3v+RcbiZXtqL
        Dqdrwdqjd1asK17G+fqLxNHyjw==
X-Google-Smtp-Source: ABdhPJyC74haUvkgcIgZCE1hmj3NWzQzN+JUcZGVMIqLH17gobR/37RPx14Y3QDWT7lGHf2vUA+vpw==
X-Received: by 2002:a05:6808:1a1b:: with SMTP id bk27mr92123oib.55.1635785829794;
        Mon, 01 Nov 2021 09:57:09 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u20sm1455647oiw.5.2021.11.01.09.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:57:09 -0700 (PDT)
Date:   Mon, 1 Nov 2021 11:57:04 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, julien.massot@iot.bzh
Subject: Re: [PATCH v6 02/10] rpmsg: create the rpmsg class in core instead
 of in rpmsg char
Message-ID: <YYAcYLxEmbwJShg7@builder.lan>
References: <20211022125426.2579-1-arnaud.pouliquen@foss.st.com>
 <20211022125426.2579-3-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022125426.2579-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22 Oct 07:54 CDT 2021, Arnaud Pouliquen wrote:

> Migrate the creation of the rpmsg class from the rpmsg_char
> to the core that the class is usable by all rpmsg services.
> 
> Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 14 ++------------
>  drivers/rpmsg/rpmsg_core.c | 26 ++++++++++++++++++++++++--
>  include/linux/rpmsg.h      | 10 ++++++++++
>  3 files changed, 36 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 941c5c54dd72..327ed739a3a7 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -28,7 +28,6 @@
>  #define RPMSG_DEV_MAX	(MINORMASK + 1)
>  
>  static dev_t rpmsg_major;
> -static struct class *rpmsg_class;
>  
>  static DEFINE_IDA(rpmsg_ctrl_ida);
>  static DEFINE_IDA(rpmsg_ept_ida);
> @@ -362,7 +361,7 @@ int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent
>  	init_waitqueue_head(&eptdev->readq);
>  
>  	device_initialize(dev);
> -	dev->class = rpmsg_class;
> +	dev->class = rpmsg_get_class();
>  	dev->parent = parent;
>  	dev->groups = rpmsg_eptdev_groups;
>  	dev_set_drvdata(dev, eptdev);
> @@ -482,7 +481,7 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>  	dev = &ctrldev->dev;
>  	device_initialize(dev);
>  	dev->parent = &rpdev->dev;
> -	dev->class = rpmsg_class;
> +	dev->class = rpmsg_get_class();
>  
>  	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
>  	ctrldev->cdev.owner = THIS_MODULE;
> @@ -558,17 +557,9 @@ static int rpmsg_chrdev_init(void)
>  		return ret;
>  	}
>  
> -	rpmsg_class = class_create(THIS_MODULE, "rpmsg");
> -	if (IS_ERR(rpmsg_class)) {
> -		pr_err("failed to create rpmsg class\n");
> -		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
> -		return PTR_ERR(rpmsg_class);
> -	}
> -
>  	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
>  	if (ret < 0) {
>  		pr_err("rpmsgchr: failed to register rpmsg driver\n");
> -		class_destroy(rpmsg_class);
>  		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>  	}
>  
> @@ -579,7 +570,6 @@ postcore_initcall(rpmsg_chrdev_init);
>  static void rpmsg_chrdev_exit(void)
>  {
>  	unregister_rpmsg_driver(&rpmsg_chrdev_driver);
> -	class_destroy(rpmsg_class);
>  	unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>  }
>  module_exit(rpmsg_chrdev_exit);
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 9151836190ce..53162038254d 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -20,6 +20,8 @@
>  
>  #include "rpmsg_internal.h"
>  
> +static struct class *rpmsg_class;
> +
>  /**
>   * rpmsg_create_channel() - create a new rpmsg channel
>   * using its name and address info.
> @@ -296,6 +298,19 @@ __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  }
>  EXPORT_SYMBOL(rpmsg_poll);
>  
> +/**
> + * rpmsg_get_class() - get reference to the sysfs rpmsg class
> + *
> + * This function return the pointer to the "rpmsg" class created by the rpmsg core.
> + *
> + * Returns the struct class pointer
> + */
> +struct class *rpmsg_get_class(void)

What value does this helper function add? Can't we just expose
rpmsg_class directly?

> +{
> +	return rpmsg_class;
> +}
> +EXPORT_SYMBOL(rpmsg_get_class);
> +
>  /**
>   * rpmsg_trysend_offchannel() - send a message using explicit src/dst addresses
>   * @ept: the rpmsg endpoint
> @@ -629,10 +644,17 @@ static int __init rpmsg_init(void)
>  {
>  	int ret;
>  
> +	rpmsg_class = class_create(THIS_MODULE, "rpmsg");
> +	if (IS_ERR(rpmsg_class)) {
> +		pr_err("failed to create rpmsg class\n");
> +		return PTR_ERR(rpmsg_class);
> +	}
> +
>  	ret = bus_register(&rpmsg_bus);
> -	if (ret)
> +	if (ret) {
>  		pr_err("failed to register rpmsg bus: %d\n", ret);
> -
> +		class_destroy(rpmsg_class);
> +	}
>  	return ret;
>  }
>  postcore_initcall(rpmsg_init);
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h

Isn't this just going to be used by rpmsg_char and rpmsg_ctrl? Do we
really need to expose it in the client-facing API?

Regards,
Bjorn

> index a8dcf8a9ae88..6fe51549d931 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -186,6 +186,8 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  			poll_table *wait);
>  
> +struct class *rpmsg_get_class(void);
> +
>  #else
>  
>  static inline int rpmsg_register_device(struct rpmsg_device *rpdev)
> @@ -296,6 +298,14 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
>  	return 0;
>  }
>  
> +static inline struct class *rpmsg_get_class(void)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return NULL;
> +}
> +
>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>  
>  /* use a macro to avoid include chaining to get THIS_MODULE */
> -- 
> 2.17.1
> 
