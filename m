Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3913AF913
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 01:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhFUXSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 19:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFUXSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 19:18:51 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:16:36 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x22so7865652pll.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 16:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o38KzSQf9bk0w4H1R0wVtOAX95R/HHsV6qoW4ydXw+4=;
        b=Y52wWIe+5PSkZscV4l4zndjTceFusvppikvaZXHKCtsxUv1L8hByVc26U04LgF7QIg
         XpKk5xmflRzxBgkJxQPYwo6/5Adnf6f8dnNwNCWvDJ3TGa9xMuGXF5/rkQJIVL6bYj/8
         IshpVIuUWX6RQhpEKrbFTPmDDGCs2260NApQqevq9I2GR7csiOovxNE6ItezXrtaCqWB
         rbNLX3FkKHgZsIb1aLqGLZLazCt6SLL0cOEGFiv6XD3UHRnVvANYDC7z8oAi7aENWxJj
         HMVSKkNPecKOW6tDlvGmXMRpSdp8C0XGajSKA8U2wcZ/zpogBS679AAIQDZhl1TGbLFo
         73VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o38KzSQf9bk0w4H1R0wVtOAX95R/HHsV6qoW4ydXw+4=;
        b=BevGpK57/p1f/CE8GrGEsBt+qfPciGXGX9/e22xNM5+ZFjFqkhUWUT+X4z/xL9Kn7w
         utCZdRqSGtz3H+wg8K5GGK4apJf+llZ4N5UJwVNN83e2Hbky7XS+0w2+7W4lsVgmn9zj
         +oJPVQlPOVBmBWFSOD8urr51Gr8LmgfChrbL9bKCxR+IhKlGxun7VNJme4uOEdLk5zeD
         lSAQzFKYIXvlxm1WK9+is4qhy0jGXX/aGBKZNmT7lFNDPe1d3YdnL4tJjlHFJYLBcyei
         8tN1lFsZDAk0tkOrkKS3Et7P8WLHOzsoMEPSbeuLTl842N66Gy8CD9O9CmnM98y/Emm/
         hanQ==
X-Gm-Message-State: AOAM53084yJykYrcKI+8LkmLNvTYEhuxccB7XZpXSWHhBlYDvdNLk7cm
        YPUgJaH1FM+X8cREiHGTKQ/2TQ==
X-Google-Smtp-Source: ABdhPJzvZNwZ5ttzMbcP5RAWrMfd1TwySMuBxZi2MrHX6mW1Virrq+UUkD7969Grh1YJRoBbIrn48A==
X-Received: by 2002:a17:902:c1cd:b029:121:3424:fcd5 with SMTP id c13-20020a170902c1cdb02901213424fcd5mr19098076plc.77.1624317396394;
        Mon, 21 Jun 2021 16:16:36 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z17sm16635456pfq.218.2021.06.21.16.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:16:35 -0700 (PDT)
Date:   Mon, 21 Jun 2021 17:16:33 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2 1/1] rpmsg: ctrl: Introduce new
 RPMSG_CREATE/RELEASE_DEV_IOCTL controls
Message-ID: <20210621231633.GC980846@p14s>
References: <20210621125800.27696-1-arnaud.pouliquen@foss.st.com>
 <20210621125800.27696-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621125800.27696-2-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2021 at 02:58:00PM +0200, Arnaud Pouliquen wrote:
> Allow the user space application to create and release an rpmsg device
> by adding RPMSG_CREATE_DEV_IOCTL and RPMSG_RELEASE_DEV_IOCTL ioctrls to
> the /dev/rpmsg_ctrl interface
> 
> The RPMSG_CREATE_DEV_IOCTL Ioctl can be used to instantiate a local rpmsg
> device.
> Depending on the back-end implementation, the associated rpmsg driver is
> probed and a NS announcement can be sent to the remote processor.
> 
> The RPMSG_RELEASE_DEV_IOCTL allows the user application to release a
> rpmsg device created either by the remote processor or with the
> RPMSG_CREATE_DEV_IOCTL call.
> Depending on the back-end implementation, the associated rpmsg driver is
> removed and a NS destroy rpmsg can be sent to the remote processor.
> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_ctrl.c | 37 +++++++++++++++++++++++++++++++++----
>  include/uapi/linux/rpmsg.h | 10 ++++++++++
>  2 files changed, 43 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index eeb1708548c1..cb19e32d05e1 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -23,6 +23,7 @@
>  #include <uapi/linux/rpmsg.h>
>  
>  #include "rpmsg_char.h"
> +#include "rpmsg_internal.h"
>  
>  static dev_t rpmsg_major;
>  
> @@ -37,11 +38,13 @@ static DEFINE_IDA(rpmsg_minor_ida);
>   * @rpdev:	underlaying rpmsg device
>   * @cdev:	cdev for the ctrl device
>   * @dev:	device for the ctrl device
> + * @ctrl_lock:	serialize the ioctrls.
>   */
>  struct rpmsg_ctrldev {
>  	struct rpmsg_device *rpdev;
>  	struct cdev cdev;
>  	struct device dev;
> +	struct mutex ctrl_lock;
>  };
>  
>  static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
> @@ -70,9 +73,8 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>  	void __user *argp = (void __user *)arg;
>  	struct rpmsg_endpoint_info eptinfo;
>  	struct rpmsg_channel_info chinfo;
> -
> -	if (cmd != RPMSG_CREATE_EPT_IOCTL)
> -		return -EINVAL;
> +	struct rpmsg_device *rpdev;
> +	int ret = 0;
>  
>  	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
>  		return -EFAULT;
> @@ -82,7 +84,33 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>  	chinfo.src = eptinfo.src;
>  	chinfo.dst = eptinfo.dst;
>  
> -	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
> +	mutex_lock(&ctrldev->ctrl_lock);

Have you been able to verify the VFS layer doesn't take care of serializing
ioctl() and file accesses in general?  I did a quick search in the drivers/
directory and the vast majority of implementations don't use a lock.

Thanks,
Mathieu

> +	switch (cmd) {
> +	case RPMSG_CREATE_EPT_IOCTL:
> +		ret = rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
> +		break;
> +
> +	case RPMSG_CREATE_DEV_IOCTL:
> +		rpdev = rpmsg_create_channel(ctrldev->rpdev, &chinfo);
> +		if (!rpdev) {
> +			dev_err(&ctrldev->dev, "failed to create %s channel\n", chinfo.name);
> +			ret = -ENXIO;
> +		}
> +		break;
> +
> +	case RPMSG_RELEASE_DEV_IOCTL:
> +		ret = rpmsg_release_channel(ctrldev->rpdev, &chinfo);
> +		if (ret)
> +			dev_err(&ctrldev->dev, "failed to release %s channel (%d)\n",
> +				chinfo.name, ret);
> +		break;
> +
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&ctrldev->ctrl_lock);
> +
> +	return ret;
>  };
>  
>  static const struct file_operations rpmsg_ctrldev_fops = {
> @@ -119,6 +147,7 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
>  	device_initialize(dev);
>  	dev->parent = &rpdev->dev;
>  
> +	mutex_init(&ctrldev->ctrl_lock);
>  	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
>  	ctrldev->cdev.owner = THIS_MODULE;
>  
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index f5ca8740f3fb..1637e68177d9 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -33,4 +33,14 @@ struct rpmsg_endpoint_info {
>   */
>  #define RPMSG_DESTROY_EPT_IOCTL	_IO(0xb5, 0x2)
>  
> +/**
> + * Instantiate a new local rpmsg service device.
> + */
> +#define RPMSG_CREATE_DEV_IOCTL	_IOW(0xb5, 0x3, struct rpmsg_endpoint_info)
> +
> +/**
> + * Release a local rpmsg device.
> + */
> +#define RPMSG_RELEASE_DEV_IOCTL	_IOW(0xb5, 0x4, struct rpmsg_endpoint_info)
> +
>  #endif
> -- 
> 2.17.1
> 
