Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35664372D53
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhEDPxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhEDPxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:53:09 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 08:52:13 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 10so8054783pfl.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 08:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aK6w36TXS1lTDUWJSQW5HJvsLC/htSSC9JiL+C6PdRY=;
        b=s12t9WAsDoTLVhlDwC7JyXO0JKrTsup4RgX3JFrI7w39JZpLkCA5Apsz015Dv8Ny+B
         QjT0o+cFM63prvDOKjQlRzezWmEBAR1S4ASeJyJUePMHwmue8EgPzOoBzYPUFfb2oppj
         whKe299q/XO8GjnH56YqU0EQG2Tuc4ugOItYiVt9+0bJUpBB8nz1t+cawL5aLpoEwdPm
         afDvXt1MpVeAW+C82jTfFECYjSsdBy83nflltQIgD4q8L3qVUvRWSicXrkkvRtbm4t6u
         0iW33Gw2HKrvVV7VZBpeIAQPDLyL3F3R/e0kf7TAvQAeUQVh/eh3QDd/u4rqeABZ/pNQ
         OO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aK6w36TXS1lTDUWJSQW5HJvsLC/htSSC9JiL+C6PdRY=;
        b=c8gAmT1tJGHUHnMu3Qsm/OxuXU7oc45MQlzVfVXNJ3xRd2xKJMObEhKIEhlIxIHM9d
         Qky9520HOZhm9d0aUiSj9FRlVTOYmTCdQyGI+2abIhG8wwr+hME1FZ+OuuL0H8SZ5oST
         DCtfTleHZsgVXNt1NhlDeUhWD50VplB7aIPQo+iFld8guvckSOpkv7NcQYbqxjI7yaoh
         J8BgVhPr/bFTOpFACCUCphjDAorxVk9Wk8xGjZP5UU0XiuaOX6Jrb39QuUAhMUIMJwFq
         QzbNG8AZZQQJfqVg+Af7U5N2xbCaaTlJmMMw2Ih7eUkngU+L2mnbz0dDBWuTKTGlucCO
         OePQ==
X-Gm-Message-State: AOAM53221x2IFfE/8iTPhU6H8YtxBlJ3arZfs4UMq/rEEtPUDn/f8MXZ
        cV5jiunXN0o/E0UG4c6CtpfpzA==
X-Google-Smtp-Source: ABdhPJyBdoMb21arlZ4uNuFPhvdS2j0XFQGbJ5CW7RF5d7VcVfHtBNq1fHRZn8svCTpKNQ8wAo1RhQ==
X-Received: by 2002:aa7:839a:0:b029:27a:8c0b:3f5e with SMTP id u26-20020aa7839a0000b029027a8c0b3f5emr23884672pfm.69.1620143533266;
        Tue, 04 May 2021 08:52:13 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id x13sm15675606pja.3.2021.05.04.08.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 08:52:12 -0700 (PDT)
Date:   Tue, 4 May 2021 09:52:10 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v3 1/6] rpmsg: char: Export eptdev create an destroy
 functions
Message-ID: <20210504155210.GA1734971@xps15>
References: <20210429135507.8264-1-arnaud.pouliquen@foss.st.com>
 <20210429135507.8264-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429135507.8264-2-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 03:55:02PM +0200, Arnaud Pouliquen wrote:
> To prepare the split of the code related to the control (ctrldev)
> and the endpoint (eptdev) devices in 2 separate files:
> 
> - Rename and export the functions in rpmsg_char.h.
> 
> - Suppress the dependency with the rpmsg_ctrldev struct in the
>   rpmsg_eptdev_create function.
> 
> - The rpmsg class is provided as parameter in rpmsg_chrdev_create_eptdev,
>   because the class is associated to the control part.
> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> ---
> Update from v2:
> 
> - rename functions from rpmsg_chrdev_create/destroy_eptdev to
>   rpmsg_chrdev_eptdev_create/destroy
> ---
>  drivers/rpmsg/rpmsg_char.c | 18 ++++++++------
>  drivers/rpmsg/rpmsg_char.h | 49 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 7 deletions(-)
>  create mode 100644 drivers/rpmsg/rpmsg_char.h
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index e4e54f515af6..3c53ece557a9 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> + * Copyright (C) 2021, STMicroelectronics
>   * Copyright (c) 2016, Linaro Ltd.
>   * Copyright (c) 2012, Michal Simek <monstr@monstr.eu>
>   * Copyright (c) 2012, PetaLogix
> @@ -15,6 +16,8 @@
>  #include <linux/rpmsg.h>
>  #include <linux/skbuff.h>
>  
> +#include "rpmsg_char.h"
> +
>  #define RPMSG_DEV_MAX	(MINORMASK + 1)
>  
>  static dev_t rpmsg_major;
> @@ -69,7 +72,7 @@ struct rpmsg_eptdev {
>  	wait_queue_head_t readq;
>  };
>  
> -static int rpmsg_eptdev_destroy(struct device *dev, void *data)
> +int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
>  {
>  	struct rpmsg_eptdev *eptdev = dev_to_eptdev(dev);
>  
> @@ -88,6 +91,7 @@ static int rpmsg_eptdev_destroy(struct device *dev, void *data)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(rpmsg_chrdev_eptdev_destroy);
>  
>  static int rpmsg_ept_cb(struct rpmsg_device *rpdev, void *buf, int len,
>  			void *priv, u32 addr)
> @@ -271,7 +275,7 @@ static long rpmsg_eptdev_ioctl(struct file *fp, unsigned int cmd,
>  	if (cmd != RPMSG_DESTROY_EPT_IOCTL)
>  		return -EINVAL;
>  
> -	return rpmsg_eptdev_destroy(&eptdev->dev, NULL);
> +	return rpmsg_chrdev_eptdev_destroy(&eptdev->dev, NULL);
>  }
>  
>  static const struct file_operations rpmsg_eptdev_fops = {
> @@ -330,10 +334,9 @@ static void rpmsg_eptdev_release_device(struct device *dev)
>  	kfree(eptdev);
>  }
>  
> -static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
> +int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
>  			       struct rpmsg_channel_info chinfo)
>  {
> -	struct rpmsg_device *rpdev = ctrldev->rpdev;
>  	struct rpmsg_eptdev *eptdev;
>  	struct device *dev;
>  	int ret;
> @@ -353,7 +356,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>  
>  	device_initialize(dev);
>  	dev->class = rpmsg_class;
> -	dev->parent = &ctrldev->dev;
> +	dev->parent = parent;
>  	dev->groups = rpmsg_eptdev_groups;
>  	dev_set_drvdata(dev, eptdev);
>  
> @@ -396,6 +399,7 @@ static int rpmsg_eptdev_create(struct rpmsg_ctrldev *ctrldev,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL(rpmsg_chrdev_eptdev_create);
>  
>  static int rpmsg_ctrldev_open(struct inode *inode, struct file *filp)
>  {
> @@ -435,7 +439,7 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>  	chinfo.src = eptinfo.src;
>  	chinfo.dst = eptinfo.dst;
>  
> -	return rpmsg_eptdev_create(ctrldev, chinfo);
> +	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
>  };
>  
>  static const struct file_operations rpmsg_ctrldev_fops = {
> @@ -521,7 +525,7 @@ static void rpmsg_chrdev_remove(struct rpmsg_device *rpdev)
>  	int ret;
>  
>  	/* Destroy all endpoints */
> -	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_eptdev_destroy);
> +	ret = device_for_each_child(&ctrldev->dev, NULL, rpmsg_chrdev_eptdev_destroy);
>  	if (ret)
>  		dev_warn(&rpdev->dev, "failed to nuke endpoints: %d\n", ret);
>  
> diff --git a/drivers/rpmsg/rpmsg_char.h b/drivers/rpmsg/rpmsg_char.h
> new file mode 100644
> index 000000000000..facd324290a4
> --- /dev/null
> +++ b/drivers/rpmsg/rpmsg_char.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Copyright (C) STMicroelectronics 2021.
> + */
> +
> +#ifndef __RPMSG_CHRDEV_H__
> +#define __RPMSG_CHRDEV_H__
> +
> +#if IS_REACHABLE(CONFIG_RPMSG_CHAR)
> +/**
> + * rpmsg_chrdev_eptdev_create() - register char device based on an endpoint
> + * @rpdev:  prepared rpdev to be used for creating endpoints
> + * @parent: parent device
> + * @chinfo: assiated endpoint channel information.

s/assiated/associated

> + *
> + * This function create a new rpmsg char endpoint device to instantiate a new
> + * endpoint based on chinfo information.
> + */
> +int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
> +			       struct rpmsg_channel_info chinfo);
> +
> +/**
> + * rpmsg_chrdev_eptdev_destroy() - destroy created char device endpoint.
> + * @data: private data associated to the endpoint device
> + *
> + * This function destroys a rpmsg char endpoint device created by the RPMSG_DESTROY_EPT_IOCTL
> + * control.
> + */
> +int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data);
> +
> +#else  /*IS_REACHABLE(CONFIG_RPMSG_CHAR) */
> +
> +static inline int rpmsg_chrdev_eptdev_create(struct rpmsg_device *rpdev, struct device *parent,
> +					     struct rpmsg_channel_info chinfo)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline int rpmsg_chrdev_eptdev_destroy(struct device *dev, void *data)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return 0;
> +}
> +
> +#endif /*IS_REACHABLE(CONFIG_RPMSG_CHAR) */
> +
> +#endif /*__RPMSG_CHRDEV_H__ */
> -- 
> 2.17.1
> 
