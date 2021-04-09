Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1D3359592
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhDIGfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbhDIGf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:35:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD33C061762
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 23:35:17 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so2677175pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 23:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TnG4sGQ6LUuX94v2u/GtNVFnPxsXdb8dXdt5hEAnnbY=;
        b=Bq0fUzUndsH+kggeMaeAR7oFoocn4+zxhKeF5/Hm7UDvlyNO6L086dlfhWFIFT56GV
         VtyVOMvGPqj8x0liiqwzpYCZPhLxCbkZXeUiToE6t8aNvKBT7VewnBSS4Xb8YKNTcXkR
         B+2bLjafhYQUkl1zVmMYkwyOYU2wA1BWkZaijAOw1TAMf1cTENr1IU447cQy7nzDE9vx
         N+u73Lm3FNIffLXmY83uls2qnFrgspIeaZA6D8lhZXsAxBPobp5IlK6UTLKCkKFZvIkH
         Dpv8smwMMyFkEC02gysI+sGhQ7JHPkFrW4i6PpdkwAt0Fge5iZ91fALxzoduiMFVmjFP
         bHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TnG4sGQ6LUuX94v2u/GtNVFnPxsXdb8dXdt5hEAnnbY=;
        b=nXZt0GmSlDBGk/WFOOaV7Oy8Gjj3efkZIEOj7f5f0OHOsVe1fCnYxGP+ZuXbwrLUdF
         fu8IQJ7ywWTpcPEEChTe5JoXBnMO0MNF3sSxKZVsRJpbu2eb0LOZQvXPiRDF9XrUnrxU
         BumAaDH4PfRgjRHh3AY7fijHcWvNN/JEG458s2xIkr2C2ub/QgaWC6sjoEAs1PuWzuRv
         BNyo0S9lVMLck2KOXdFFFeXxRDQQVTjWZZjvcaGVowzspRNH+ffEc69DamTUsir7T/QE
         qHJplLz7mpu9dCvfZGEUrWij2iuCFeKKvZPwX2DTp91vHAThHN85ZX/Y9AUQl7q4H4tE
         2rew==
X-Gm-Message-State: AOAM532kGcVXXKEXfKLJ4WWozf18xipkmQOc3oFiRYgSooVADeQXWphO
        iYlnc9gobz1pmx7nyuiVRLZd
X-Google-Smtp-Source: ABdhPJwBtmTAo1JxGBCsS5eOol/++K0aGYBu+1Xep9WmlbJRDIpQoTLeQegPsaNWNgV1T99lGwoQBw==
X-Received: by 2002:a17:90a:ad84:: with SMTP id s4mr277651pjq.153.1617950116533;
        Thu, 08 Apr 2021 23:35:16 -0700 (PDT)
Received: from work ([103.77.37.131])
        by smtp.gmail.com with ESMTPSA id w4sm1137107pjk.55.2021.04.08.23.35.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Apr 2021 23:35:16 -0700 (PDT)
Date:   Fri, 9 Apr 2021 12:05:12 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jia Yang <jiayang5@huawei.com>
Cc:     adrian.hunter@intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mmc: sdhci-msm: Remove unnecessary error log
Message-ID: <20210409063512.GD4376@work>
References: <20210409015424.3277212-1-jiayang5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210409015424.3277212-1-jiayang5@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 09:54:24AM +0800, Jia Yang wrote:
> devm_ioremap_resource() has recorded error log, so it's
> unnecessary to record log again.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jia Yang <jiayang5@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/mmc/host/sdhci-msm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index d170c919e6e4..e44b7a66b73c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1863,7 +1863,6 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  	struct mmc_host *mmc = msm_host->mmc;
>  	struct device *dev = mmc_dev(mmc);
>  	struct resource *res;
> -	int err;
>  
>  	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
>  		return 0;
> @@ -1881,11 +1880,8 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  	}
>  
>  	msm_host->ice_mem = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(msm_host->ice_mem)) {
> -		err = PTR_ERR(msm_host->ice_mem);
> -		dev_err(dev, "Failed to map ICE registers; err=%d\n", err);
> -		return err;
> -	}
> +	if (IS_ERR(msm_host->ice_mem))
> +		return PTR_ERR(msm_host->ice_mem);
>  
>  	if (!sdhci_msm_ice_supported(msm_host))
>  		goto disable;
> -- 
> 2.25.1
> 
