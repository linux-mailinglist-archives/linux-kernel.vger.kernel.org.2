Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4C563E0493
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhHDPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239187AbhHDPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:42:59 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B14C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:42:46 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id z6-20020a0568302906b02904f268d34f86so1703452otu.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nerYHUdRdbYFzlQjp5pBoYJPHBZ2ZgnUm5+kWyeZxBY=;
        b=wfdGZd9XHdfd+zP+YSLJJy7gG32dbhFR9Efzf5TPu93R2J3HjQjBtPeqdPenpYcxl4
         4sdHcsot6An9sJ247y+29GAJu3C70lIL7Lr0gJLkRE/Q3EX8DZQkYvs70b5pBZ/tDBGL
         5n8ibsLIRbE82UQjyVia08aPqJ84YkaEqPHeDKksMFbacZWbjQix1hNH4SDZI0zneveJ
         pY1L+Jksj0DNcGmM0VD8DrdMe07s56PSrmpWVF2q97iYj4zjFpwXpeH1rBOpmVKHJ+ba
         sQtWjymrSDd1DK/TVjRA049weJexV5hQsYAehJzR1B0Tk57pO+HL85+iYFQ72iiag+vf
         pCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nerYHUdRdbYFzlQjp5pBoYJPHBZ2ZgnUm5+kWyeZxBY=;
        b=seTR+259GBne5itHwQfzAPkid0phXYBZykzML5CraIwW/ZfP5VPvhziJKT/ZeJ80/h
         4dyplJRYN30kj091eBZdqpLSrCIMtVN1dxVkRR3GbaGJecHeCNIxiRizZhJMHVsA8DXD
         Gt+B24VketfzUJ+7KCmxnozPEdrQoDb8qRh4KkuMrYPEfwEc5zMnLoJ/3CAO2OS+5zli
         usA/LksGMJvg5XRWCeZuSCf0vCpNQL7kH5I5JOGBr0/mDPMwFSuYkWSr5b8BIL1CZnYA
         ZfD/uEJXaGRKP2NhVSx/VfCV3jTO6AUFFPlsliFO2sl3HVSPGpVPAlWZJ6KL29RxeCh3
         vMkw==
X-Gm-Message-State: AOAM5335Q1UoxRuFEwhkLcsbtKLQa+/Wukj6EHgWAGlw4SeuyKeY6/M2
        Bf3/cY6OcyzqyJ1yVB3tbgkjhA==
X-Google-Smtp-Source: ABdhPJwypfzyjnmpuMLC/38I3EdRmDzEz0C1h58e8QbTD79cwWkNXJVGZpXVfOiEOIwzfxQFJzcT6w==
X-Received: by 2002:a9d:190e:: with SMTP id j14mr287443ota.48.1628091766082;
        Wed, 04 Aug 2021 08:42:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q15sm446187otf.70.2021.08.04.08.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:42:45 -0700 (PDT)
Date:   Wed, 4 Aug 2021 10:42:43 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: blacklist Qualcomm sm8150 in cpufreq-dt-platdev
Message-ID: <YQq1c8UYb78qJjxm@builder.lan>
References: <20210804133451.2503674-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804133451.2503674-1-thara.gopinath@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04 Aug 08:34 CDT 2021, Thara Gopinath wrote:

> The Qualcomm sm8150 platform uses the qcom-cpufreq-hw driver, so
> add it to the cpufreq-dt-platdev driver's blocklist.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index 9d5a38a91f10..231e585f6ba2 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -141,6 +141,7 @@ static const struct of_device_id blocklist[] __initconst = {
>  	{ .compatible = "qcom,sc7280", },
>  	{ .compatible = "qcom,sc8180x", },
>  	{ .compatible = "qcom,sdm845", },
> +	{ .compatible = "qcom,sm8150", },
>  
>  	{ .compatible = "st,stih407", },
>  	{ .compatible = "st,stih410", },
> -- 
> 2.25.1
> 
