Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5C732ABF1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 21:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447359AbhCBU55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 15:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1580524AbhCBSEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 13:04:23 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBBFC0611C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:01:14 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id t29so14312120pfg.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UBInWvC4UtsMqMVlbtixev5AhwLr9Odk/zIdyxeWBVE=;
        b=gkKGSNWCsOVvAVoe6dY3Z32WGzDgmFBGW2Rdy7IGyI+X06lJHhsUEJnYKADiJ+JwDz
         KZa4BRTCoHDaMLCWkJ3VXKKsiTKWIDKvMbwuY+xaQ6rzeikYjM4sBUKsNOTFnUMUOsNR
         o6Qlyjx7EVKBp4wxt/L+lmHVpdomxhCqLVSYVGlAoij6YB1NgtrudvLPLPduMz/06TQX
         /zXj3i/TR5iMmw/f0irj/FtJLyZUhjeAXxmRB/HDFZ0+hB6yS++YHwHv9NI+SjSpXrD/
         yFUjZlgvAsbweDBQcQ000ZDcSzfSazOk8QnGzA7XPoc7/gVoJ/gzN85rz06qgjWIiqcR
         NE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBInWvC4UtsMqMVlbtixev5AhwLr9Odk/zIdyxeWBVE=;
        b=jXMKmmA7CYmkbh8bl8A3hrYLELqAhgLM1j925d2IX19DubZmAtU8UjvHdOLJ6kpxGX
         P3uIvaa4IHUIXRE4qYj+YNPpsP27EQQcNPDtDkKdLaQpBJKaT1PafTc98F5H7P3VOSIa
         XGcXQHR/uc6bxJCw+7gzzdwXfaupovDSW4cobzpgEgn7swTFCtVKAGphcPhkayj5hDKt
         pZfKX6Pmft9S/srJSVSD+sfat6WuBe+IVeKPL+NcSE+onw+3M41Gr8A1Ujn0UB5VR9Zv
         IK/FoUmUDL5YYmJoS0ITtR5ntnnsIZU1YNVNgPa5QOGQ2JltncmTG2f9Ew+FHm6yGrTL
         G4sg==
X-Gm-Message-State: AOAM531Jre8mkZY7nZkGVPCon/fz9jpQo8RcP3qCOJY74I/IbI0JPT7w
        aHOBGa/nps6FoDyRpVqM8TxDgw==
X-Google-Smtp-Source: ABdhPJzG0wzLzTI1eJKKGZkec00/EiMDhEKSsK3bDtPIQa/dNEuZiqt855r5ju1GLQpivCBDKuVbsw==
X-Received: by 2002:a63:585d:: with SMTP id i29mr19092274pgm.10.1614708074117;
        Tue, 02 Mar 2021 10:01:14 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id q15sm20198751pfk.181.2021.03.02.10.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 10:01:13 -0800 (PST)
Date:   Tue, 2 Mar 2021 11:01:11 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 05/16] rpmsg: char: dissociate the control device from
 the rpmsg class
Message-ID: <20210302180111.GB3791957@xps15>
References: <20210219111501.14261-1-arnaud.pouliquen@foss.st.com>
 <20210219111501.14261-6-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219111501.14261-6-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 12:14:50PM +0100, Arnaud Pouliquen wrote:
> The RPMsg control device is a RPMsg device, it is already
> referenced in the RPMsg bus. There is only an interest to
> reference the ept char devices in the rpmsg class.
> This patch prepares the code split of the control and end point
> devices in two separate files.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index 78a6d19fdf82..23e369a00531 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -485,7 +485,6 @@ static int rpmsg_chrdev_probe(struct rpmsg_device *rpdev)
>  	dev = &ctrldev->dev;
>  	device_initialize(dev);
>  	dev->parent = &rpdev->dev;
> -	dev->class = rpmsg_class;

This may break user space...  It has been around for so long that even if the
information is redundant we have to keep it.

>  
>  	cdev_init(&ctrldev->cdev, &rpmsg_ctrldev_fops);
>  	ctrldev->cdev.owner = THIS_MODULE;
> -- 
> 2.17.1
> 
