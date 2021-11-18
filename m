Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D5A456173
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhKRRaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbhKRR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:29:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E35C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:26:52 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso6392518pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ffg8RENMvUuNEkBhbj1rA+p5DmTOHVu6yl2demT0EE4=;
        b=fb17491S/0gCnhjw+z0N6OqW92Tpeno6JI0c/csN8eX8CnIeKqlHLLnbYOpgouQx5q
         /vtBplywQdcqf0PQ3Qwot2PPxBcx3YU6PQ2GCes4CuxMTHWYtAK1HKc0+3i8o7FAbRpY
         01mzWpo1DwrHuAepeXOHU6IF2mjHq+r09yhUe01Lh42slxYx0G0lRzkQWMNGjzL1ixPw
         Yxp4dRABOXdkmw/u3rWxmnxmfcPPSBUfUvSfP63GYg4Rz2jZ16TtwkMYE1Imud86YSZ+
         +iPhSMPj46izY9h6v8K7QFlyNbHHE3x4LMg3ekEun1ZTGngs9MDjCwXVWFVLZIWKo/FG
         wJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ffg8RENMvUuNEkBhbj1rA+p5DmTOHVu6yl2demT0EE4=;
        b=ckyES6yc0VwOb1LZ7MmhWllaUInP6kq79r8Vg4Y+fw1w8A3jOhEVIeHItEHqPj1xI7
         fCf+f6fJLPr/2AYj+sYC3E684f++5TmcQaW3SVjTVe0I3iOkkCCRJL5EiPiHIrZTGEu5
         hviqCQdJ8dYDlp7gkwd7FhdnXKIML+GKjm0dcQb8fb286Qo/7OfRZDtaDVC8H7mTdACw
         m+8IfE6TY+e7Uzal49r70GISJL6ofJqIMbrupocCadNEhh5jQNKte0b0FgSKTuCmRha1
         cbtjHesxxl8rqv61t0r0wfccAmopwJNz8RsrsZQxdoSDZevkOnpCUIRPqe+2bPdbOLZb
         g9BQ==
X-Gm-Message-State: AOAM531YUY5P/4j3K972En2x1zqOqH6DbjcwzrKrigNyQa+67xKjQCmO
        Ks3XI2vhoa/UwUWCgNyaXJO3Ew==
X-Google-Smtp-Source: ABdhPJwT015s86rLy9F8ng6d55iG1IPThLw+nvpC0UIAsjoQ/rL8E+JpvJUMBGsEjaoL3VO27U59zg==
X-Received: by 2002:a17:902:e548:b0:141:f4ae:d2bd with SMTP id n8-20020a170902e54800b00141f4aed2bdmr69754101plf.41.1637256411831;
        Thu, 18 Nov 2021 09:26:51 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id z22sm233489pfe.93.2021.11.18.09.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:26:50 -0800 (PST)
Date:   Thu, 18 Nov 2021 10:26:48 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: char: Add pr_fmt() to prefix messages
Message-ID: <20211118172648.GC2530497@p14s>
References: <20211108135945.3364-1-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108135945.3364-1-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 02:59:45PM +0100, Arnaud Pouliquen wrote:
> Make all messages to be prefixed in a unified way.
> Add pr_fmt() to achieve this.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_char.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> index b5907b80727c..d6214cb66026 100644
> --- a/drivers/rpmsg/rpmsg_char.c
> +++ b/drivers/rpmsg/rpmsg_char.c
> @@ -9,6 +9,9 @@
>   * Based on rpmsg performance statistics driver by Michal Simek, which in turn
>   * was based on TI & Google OMX rpmsg driver.
>   */
> +
> +#define pr_fmt(fmt)	KBUILD_MODNAME ": " fmt
> +
>  #include <linux/cdev.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
> @@ -550,7 +553,7 @@ static int rpmsg_chrdev_init(void)
>  
>  	ret = alloc_chrdev_region(&rpmsg_major, 0, RPMSG_DEV_MAX, "rpmsg");
>  	if (ret < 0) {
> -		pr_err("rpmsg: failed to allocate char dev region\n");
> +		pr_err("failed to allocate char dev region\n");
>  		return ret;
>  	}
>  
> @@ -563,7 +566,7 @@ static int rpmsg_chrdev_init(void)
>  
>  	ret = register_rpmsg_driver(&rpmsg_chrdev_driver);
>  	if (ret < 0) {
> -		pr_err("rpmsgchr: failed to register rpmsg driver\n");
> +		pr_err("failed to register rpmsg driver\n");

This probably the right thing to do - I will pick up this patch.

Thanks,
Mathieu

>  		class_destroy(rpmsg_class);
>  		unregister_chrdev_region(rpmsg_major, RPMSG_DEV_MAX);
>  	}
> -- 
> 2.17.1
> 
