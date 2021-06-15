Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A069C3A880E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhFORsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhFORsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:48:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:46:38 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e20so12116434pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wddwTSMBbde5fomYmsiyLam28xGB6dPV0cf1qnti6ic=;
        b=RZ9l3hLv315HQzf74YqNq66u68piUTOQ4YEdk1ODigk1fSGwtzivrrZDNRdC1PncLw
         +/svDhoxXmOGWyK2ocUeeV1vZ8t1+fkxrXImy6iXlOkYFGKuQpCv64AD6tFy/HrX6iz/
         FnYgYtfx1j9DWUArUfF8//Mgo2ORXezFC+sLEZfdj2kkVJcO6a39Mfo8cnX7n3S0RPeR
         hu/b0fiIPcVSkZy5gZ9+Eu/CxoRGngDnWRIvC+oopFUYiWzDsM1qPXttNasNrcocf/AG
         0LsHVkwMMwAdporoK9/ao3Xrys5wzNeDwqsGMNCHhiheVgm/cCF2btVyKUVfQaAEnsXM
         PAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wddwTSMBbde5fomYmsiyLam28xGB6dPV0cf1qnti6ic=;
        b=lRRgfCXZ0Ad3l1eY/IvoriEvLbEbzUsJ81/JrbwaVQjdRGN/5/DYTbFAzzHQ8L6201
         t8VlFnvo1sTTx7phqBeAgMtU1YKtBLabvw+FKi+/cqfrfer8VkgLd7k4FEU0vsFljTuY
         mPMxI+NZrq/OvxKe+UWc5k67npHghgtkPN6WLPbfDm/0TuNGWmEKox7DwphHA70uICQV
         hldPgWkLQDV22r4dJpAgrsfVse3T7R/d9pjJ30YVNtewZ04DI+fPd8EvN3nmakiv3TH8
         7navabkjyxWvIfkc7jUXBPEFtOGN4yaXhipU5TDs1Y8GdnhLRG6/qTDwOyHvo7jOt/XK
         k5uw==
X-Gm-Message-State: AOAM530RklzV81HSvOt3kG2GMi+ccEr+XcfTowYMiKRGy1fZx0yJnHBA
        qXgq5tOAjyuCf4j4YiWhcgTCVQ==
X-Google-Smtp-Source: ABdhPJwFCtkBDaxNtqg+71URNkezF2YmFzdj1QOm2PfqazbyIO6ce3Jmtz4NDXGXw9U1bAuAzSYkhw==
X-Received: by 2002:a05:6a00:d65:b029:2ec:2bfa:d0d1 with SMTP id n37-20020a056a000d65b02902ec2bfad0d1mr5502974pfv.14.1623779197593;
        Tue, 15 Jun 2021 10:46:37 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f15sm16463659pgg.23.2021.06.15.10.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:46:36 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:46:34 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 3/4] rpmsg: ctrl: Add check on rpmsg device removability
 from user space
Message-ID: <20210615174634.GB604521@p14s>
References: <20210604091406.15901-1-arnaud.pouliquen@foss.st.com>
 <20210604091406.15901-4-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604091406.15901-4-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:14:05AM +0200, Arnaud Pouliquen wrote:
> Using the RPMSG_RELEASE_DEV_IOCTL is possible to remove any
> rpmsg device (such as the rpmsg ns or the rpmsg ctrldev).
> 
> Add a new field to store the removability of the device.
> 
> By default the rpmsg device can not be removed by user space. It is
> set to 1 by the rpmsg ctrl on RPMSG_CREATE_DEV_IOCTL request, but
> could also be set by an rpmsg driver during probe.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_ctrl.c | 17 ++++++++++++++++-
>  include/linux/rpmsg.h      |  2 ++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_ctrl.c b/drivers/rpmsg/rpmsg_ctrl.c
> index cb19e32d05e1..e93c6ec49038 100644
> --- a/drivers/rpmsg/rpmsg_ctrl.c
> +++ b/drivers/rpmsg/rpmsg_ctrl.c
> @@ -74,6 +74,7 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>  	struct rpmsg_endpoint_info eptinfo;
>  	struct rpmsg_channel_info chinfo;
>  	struct rpmsg_device *rpdev;
> +	struct device *dev;
>  	int ret = 0;
>  
>  	if (copy_from_user(&eptinfo, argp, sizeof(eptinfo)))
> @@ -95,11 +96,25 @@ static long rpmsg_ctrldev_ioctl(struct file *fp, unsigned int cmd,
>  		if (!rpdev) {
>  			dev_err(&ctrldev->dev, "failed to create %s channel\n", chinfo.name);
>  			ret = -ENXIO;
> +		} else {
> +			/* Allow user space to release the device. */
> +			rpdev->us_removable = 1;

As a rule of thumb I try really hard to avoid introducing new flags.  In this case we
can attain the same result by looking at chinfo->name, chinfo->src and
chinfo->dst.  I would introduce a new inline function in rpmsg_internal.h,
something like rpmsg_chrdev_is_ctrl_dev(), and compare the specifics in chinfo
to rpdev->id.name, rpdev->src and rpdev->dst.  If they all match then the
operation is refused.

That way we don't introduce a new flag and there is also no need to call
rpmsg_find_device() twice.

Thanks,
Mathieu

>  		}
>  		break;
>  
>  	case RPMSG_RELEASE_DEV_IOCTL:
> -		ret = rpmsg_release_channel(ctrldev->rpdev, &chinfo);
> +		dev = rpmsg_find_device(ctrldev->rpdev->dev.parent, &chinfo);
> +		if (!dev)
> +			ret =  -ENXIO;
> +
> +		/* Verify that rpmsg device removal is allowed. */
> +		if (!ret) {
> +			rpdev = to_rpmsg_device(dev);
> +			if (!rpdev->us_removable)
> +				ret = -EACCES;
> +		}
> +		if (!ret)
> +			ret = rpmsg_release_channel(ctrldev->rpdev, &chinfo);
>  		if (ret)
>  			dev_err(&ctrldev->dev, "failed to release %s channel (%d)\n",
>  				chinfo.name, ret);
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index d97dcd049f18..3642aad1a789 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -47,6 +47,7 @@ struct rpmsg_channel_info {
>   * @ept: the rpmsg endpoint of this channel
>   * @announce: if set, rpmsg will announce the creation/removal of this channel
>   * @little_endian: True if transport is using little endian byte representation
> + * @us_removable: True if userspace application has permission to remove the rpmsg device
>   */
>  struct rpmsg_device {
>  	struct device dev;
> @@ -57,6 +58,7 @@ struct rpmsg_device {
>  	struct rpmsg_endpoint *ept;
>  	bool announce;
>  	bool little_endian;
> +	bool us_removable;
>  
>  	const struct rpmsg_device_ops *ops;
>  };
> -- 
> 2.17.1
> 
