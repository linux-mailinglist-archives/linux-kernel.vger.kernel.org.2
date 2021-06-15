Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2A03A8824
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbhFORzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhFORzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:55:44 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68152C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:53:38 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n12so12073651pgs.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qYdWcRQM4y5ppqD8DVn9IzKuN6FZdzqCct08fJM4mR0=;
        b=FsbuFP7IJTe2Ec/7O4Pyca3eLrgZ/zmcJHMVTZGpVzofZbVTKfo9azMmUqBLdfwq81
         07NNr1fTDon6nHXHWsR6cnTMVzS5cZhLOGb0OOkQP8pvdvxQRFiHNTOhcwtj5osllzQK
         r77W5Wlx9xsoei57zIiTkL6KELCBNOKKbcZLLBrwOUzt555jK8FLE9Ei9GkdIvbvN8M5
         2DZeaH2fAy77PO89CljgvP6egfVSsiUAOSo+GCifsvjPyaOyaKgCQXGakKQSzI3Wyy8t
         9IcwVQBApJ71KKNb2X2EPYGzVoz6bDG/E+MA32R4X2zV+kRwV5hK80Ksq2rvAALCYYeM
         Kyiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qYdWcRQM4y5ppqD8DVn9IzKuN6FZdzqCct08fJM4mR0=;
        b=VfgV3ug5ru66QebmO1fMORgMCaF4wWqctm2hxvPQ0UD08nliyCInmtSv0KuW4CWZNF
         ElZ72bja1iWXIjFVHZ6wJKu+XJMc6X0MmhnOmhAz9a81yc3G+VpsKPtDAlokTuM+3Csk
         aAp7TIWGoyi0kueLf4NSN+xY356bRhIpUt65Fh6TKzSf2F8TsctSvkwGFUFlRZ2T+Vwj
         UPwOY7WpmA7f+P6jGiolujdZm+Ksg42R4T1kQwW2+9vLZwha+pYMl87pghuqpv48/jJP
         rrlx1n+vzHNvXnTmxyFZ1nhHayuD64gWsioVV5DZEk3N7nMWA1BPDJmJ4/9iD0cLjaH1
         RGtg==
X-Gm-Message-State: AOAM532uZQtMiB3VtwIlO9iNAOtqrcNBSGymRhFcAB0Am1xgk/VTVAVV
        J+NxtuFtRwIuiWKG4TPldzEDQw==
X-Google-Smtp-Source: ABdhPJwsU4R2fp87erP/gI6ivQmNCb+AeFlVb5bzuxDA8fUjqHdwsXzTkItERIUs7aBx+upuh4lnEQ==
X-Received: by 2002:aa7:8f28:0:b029:2f4:9245:4ed with SMTP id y8-20020aa78f280000b02902f4924504edmr5378477pfr.24.1623779617576;
        Tue, 15 Jun 2021 10:53:37 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t14sm17721523pgm.9.2021.06.15.10.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:53:36 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:53:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/4] rpmsg: ctrl: Introduce RPMSG_CREATE_DEV_IOCTL
Message-ID: <20210615175334.GD604521@p14s>
References: <20210604091406.15901-1-arnaud.pouliquen@foss.st.com>
 <20210604091406.15901-2-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604091406.15901-2-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:14:03AM +0200, Arnaud Pouliquen wrote:
> Implement the RPMSG_CREATE_DEV_IOCTL to allow the user application to
> initiate a communication through a new rpmsg channel.
> This Ioctl can be used to instantiate a local rpmsg device.
> Depending on the back-end implementation, the associated rpmsg driver is
> probed and a NS announcement can be sent to the remote processor.
> 
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_ctrl.c | 30 ++++++++++++++++++++++++++----
>  include/uapi/linux/rpmsg.h |  5 +++++
>  2 files changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index eeb1708548c1..4aa962df3661 100644
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
> @@ -82,7 +84,26 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>  	chinfo.src = eptinfo.src;
>  	chinfo.dst = eptinfo.dst;
>  
> -	return rpmsg_chrdev_eptdev_create(ctrldev->rpdev, &ctrldev->dev, chinfo);
> +	mutex_lock(&ctrldev->ctrl_lock);

Do we need a lock here?  I thought the character device layer would guarantee
accesses on a file handler would be atomic...  Am I wrong?

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
> +	default:
> +		ret = -EINVAL;
> +	}
> +	mutex_unlock(&ctrldev->ctrl_lock);
> +
> +	return ret;
>  };
>  
>  static const struct file_operations rpmsg_ctrldev_fops = {
> @@ -119,6 +140,7 @@ static int rpmsg_ctrldev_probe(struct rpmsg_device *rpdev)
>  	device_initialize(dev);
>  	dev->parent = &rpdev->dev;
>  
> +	mutex_init(&ctrldev->ctrl_lock);
>  	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
>  	ctrldev->cdev.owner = THIS_MODULE;
>  
> diff --git a/include/uapi/linux/rpmsg.h b/include/uapi/linux/rpmsg.h
> index f5ca8740f3fb..f9d5a74e7801 100644
> --- a/include/uapi/linux/rpmsg.h
> +++ b/include/uapi/linux/rpmsg.h
> @@ -33,4 +33,9 @@ struct rpmsg_endpoint_info {
>   */
>  #define RPMSG_DESTROY_EPT_IOCTL	_IO(0xb5, 0x2)
>  
> +/**
> + * Instantiate a rpmsg service device.
> + */
> +#define RPMSG_CREATE_DEV_IOCTL	_IOW(0xb5, 0x3, struct rpmsg_endpoint_info)
> +
>  #endif
> -- 
> 2.17.1
> 
