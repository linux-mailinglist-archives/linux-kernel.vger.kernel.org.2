Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CA43A8810
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFORuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbhFORue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:50:34 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D43C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:48:27 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id k5so118917pjj.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 10:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1zxWWH5viqfAr6sUMJsjqthPFquxVNQ/+2gZK8GZHEU=;
        b=W1KDjeJo1cBehCZp2FSA8WVvWq4LYFsAmqIeEOVO58/J/QguNi9YAWBPsskjFVIbpx
         0LPXzEcxwXLZ+tgAuxVMYfJXbBeQXUCUZUqWn/U9K9TDHIL/WCN1Ho1sBP7WyqZSgZPo
         WlV48EsL9I0E2wgh0EEHPKDyn/eqvJXS8jAiMfnl+I+2dZjS5MiGV71YSVpY+R0JQTtE
         6VXYyI9ol518Gak+0Q/+2iZ6VlubHQxfIfDdA9ZkJW1Nho8mZxglpB5/FK/XdZCaPdZM
         m81n9n8dF/h4dWf4QILpUcpHShIEB/nIoy0jdLM088PCEh0Y8r3FZlx5PhGgYnwj+rq+
         B+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1zxWWH5viqfAr6sUMJsjqthPFquxVNQ/+2gZK8GZHEU=;
        b=j1Cfzp9CAdHusNz0mHWYsn86qqwFoai0/uEEndLHYLU9IPlWs1KxWtdjATYSa/j//q
         sMv11/187AioP8QLMoDtiqVyfWpDtYR+fUs3k20NEtz2kpmtGGSVL8lFFV/C+h+vOqvq
         B8CW9IPMvrLUf+Dc4waUY3kH9CpaPu3GKpcyAzhlVy4YwgvgYMR60W8NqLlkGw8ppVRy
         0fWrCFXJ5bWrdY6J56LD+BatoJLWeLHolXMkHsmLB6ubhrkGZOpBfZC/5s4cs3530c+R
         0Jzmu7mfq8GZUyDMWSJhx7WSThihRFoDDUELymKWB+ykqQDaSEgi9xu3cPHX0QIdFQht
         cyzw==
X-Gm-Message-State: AOAM533R2uIawkxJ/bg+or5qPP5ata6xlT9aHwsD85WCsgd4ddKg1a0A
        4azPT9XF2qFz+qL9Bk2IONqk2Q==
X-Google-Smtp-Source: ABdhPJyszR7HGXp7Wtg+9mMiJpdT9xu41oqbEma8mNjUvAEcaTvlZie+cr1iuLr904fwvWGPoqFQww==
X-Received: by 2002:a17:90a:5998:: with SMTP id l24mr358719pji.169.1623779307427;
        Tue, 15 Jun 2021 10:48:27 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 11sm16696147pge.57.2021.06.15.10.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:48:26 -0700 (PDT)
Date:   Tue, 15 Jun 2021 11:48:24 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 4/4] rpmsg: Add a removable attribute to the rpmsg device
Message-ID: <20210615174824.GC604521@p14s>
References: <20210604091406.15901-1-arnaud.pouliquen@foss.st.com>
 <20210604091406.15901-5-arnaud.pouliquen@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210604091406.15901-5-arnaud.pouliquen@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2021 at 11:14:06AM +0200, Arnaud Pouliquen wrote:
> Adds a new attribute to the rpmsg device to expose in sysfs the
> the removability of an rpmsg device.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/rpmsg/rpmsg_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index e5daee4f9373..b2543ef4a92f 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -413,6 +413,7 @@ rpmsg_show_attr(src, src, "0x%x\n");
>  rpmsg_show_attr(dst, dst, "0x%x\n");
>  rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
>  rpmsg_string_attr(driver_override, driver_override);
> +rpmsg_show_attr(removable, us_removable ? "true" : "false", "%s\n");
>  
>  static ssize_t modalias_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
> @@ -435,6 +436,7 @@ static struct attribute *rpmsg_dev_attrs[] = {
>  	&dev_attr_src.attr,
>  	&dev_attr_announce.attr,
>  	&dev_attr_driver_override.attr,
> +	&dev_attr_removable.attr,

And this patch shouldn't be needed if we move forward with my recommendation on
patch 3/4.

>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(rpmsg_dev);
> -- 
> 2.17.1
> 
