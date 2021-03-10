Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A10333FA4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 14:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhCJNwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 08:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbhCJNvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 08:51:51 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2974C061761
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:51:50 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y13so8644730pfr.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 05:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X5tC2Q2Mgd4xeS1P2G/D3ZsBHgb7pQQku+/Xa9vdroE=;
        b=IzrtVVwpFhu3zRWczCd8AWhwxOpHEvd7iiEQYaSj8eZXbnf16kagqYDORkOdlEyLro
         ibCxfjOJzYGG4zi52Aap/EUEGu3bZr83SZdOX90yJiTm6v1HIFfjnItgLK6vsF3luZhC
         j7Q3XGTuAo5B/v3LEagZGf+D9yV8FXfGScU7lgppdIi7JpPthP9XlysOTvdHwV0IFhEF
         Ybuo4ciE9ez4oq3GhdJckCW50yIKAg4j0/xeddTDhf+vbFUk6xJeHf3mTY2i3fx8GC+g
         0d8qEgEjHIZuRJIm49jfsLRh7tM8W4SWecpL+/WvKVLKHUJZRdOC1MfcgGQd4dO9IPRP
         8trg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X5tC2Q2Mgd4xeS1P2G/D3ZsBHgb7pQQku+/Xa9vdroE=;
        b=oBa7LFx7XIDNC0ZvEg3jgLSgcVcFvgDMwqabDkVUxCyJWpUGwPXCou4MKNLOXSmEYv
         BGiMVH33lJUnnEmxag9e3An3LH0M6uMz2NFb3M9HqpM9SA1Q2xnm/i5TVREY+4rZWRly
         cS/dDKtAyOATOJj347mA2dM+nko1XyEMt2b7hOErO4atU2wbcFvaOUvLsD3smuLTF85O
         O9YXRuXWNHvHhBKpV1iduWXLI5hu2H3rT8Ov620IjsvCBsNumQjyZD1TAoypbm5sO+Pe
         oq/zh0Hq2ZORXx+f8UJBkgxJIgBgtQ2fhWERirAjsZ9tWb2NDLg87mb2xZOh9F4sKbp9
         HuDQ==
X-Gm-Message-State: AOAM532oMy4zDjx7Tzh8ciNASH0Ssoc7oEir13YzHFyx8ZxldjQ8yaGu
        VtxoZWnpeIrwCfZ8Ew8xjEup
X-Google-Smtp-Source: ABdhPJwrlt/66sTaD0Wszt9Lr1/5EnGE6QG2yKtSG3bVEzxmh8bWPSGFSvQU3fuV8bs9YCMm4lLczQ==
X-Received: by 2002:a65:5bca:: with SMTP id o10mr3014262pgr.248.1615384310081;
        Wed, 10 Mar 2021 05:51:50 -0800 (PST)
Received: from thinkpad ([103.66.79.59])
        by smtp.gmail.com with ESMTPSA id k67sm10597262pgk.28.2021.03.10.05.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 05:51:49 -0800 (PST)
Date:   Wed, 10 Mar 2021 19:21:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH v3] bus: mhi: core: Add missing checks for MMIO register
 entries
Message-ID: <20210310135144.GM30275@thinkpad>
References: <1615315490-36017-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615315490-36017-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:44:50AM -0800, Bhaumik Bhatt wrote:
> As per documentation, fields marked as (required) in an MHI
> controller structure need to be populated by the controller driver
> before calling mhi_register_controller(). Ensure all required
> pointers and non-zero fields are present in the controller before
> proceeding with the registration.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  v3: removed fw_image as not all controllers require it
>  v2: removed iova_start and iova_stop as they can be zero
> 
>  drivers/bus/mhi/core/init.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 272f350..d8882b3 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -879,12 +879,10 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  	u32 soc_info;
>  	int ret, i;
>  
> -	if (!mhi_cntrl)
> -		return -EINVAL;
> -
> -	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
> +	if (!mhi_cntrl || !mhi_cntrl->cntrl_dev || !mhi_cntrl->regs ||
> +	    !mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
>  	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
> -	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs)
> +	    !mhi_cntrl->write_reg || !mhi_cntrl->nr_irqs || !mhi_cntrl->irq)
>  		return -EINVAL;
>  
>  	ret = parse_config(mhi_cntrl, config);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
