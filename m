Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 196573CBFDF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 01:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhGPX5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 19:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGPX5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 19:57:50 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339E1C061760
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 16:54:55 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u11so12950462oiv.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 16:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJGdspG2J1Lj8nevb/Lj+7rawdMA9S4WQ8v9/yvZMvo=;
        b=OkAzUjq+SaObhfByR+nUx5mgIQ3Mj2gMLVbecs/XMcl0FGNc538qnz06xKozYcDCH+
         T2G34oXtNn6K04Y3tJ/tzc7PAdF9ohrL/VszWgflvy/59nrcZM586yOU9z2qwdFfSxoz
         4rk+f/B2DvrfjOHw/2DRWu8foTSqwez0nexmMgwvUX65nMDUUOljQtPVEw1W9PqI6ixE
         uznwYPTE3PqGoglVJ3dT1PRSWyK40h86fx7eCXlJDVoUh4MiYQtlU7+rJSkLsB6WuQIX
         nb89ZRwBzc8ZP5sHAnolgZ4W7sX2x8Gm6XH2a9mu82raDwbjxpywlhcj7DuniAbxeSgJ
         oaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJGdspG2J1Lj8nevb/Lj+7rawdMA9S4WQ8v9/yvZMvo=;
        b=dlIBkmaHg4akLRIklp7DP10Al5akIBiESt+XKbxi2IFdJwWff5aPwSp2StlDp9souL
         RcVVjWysmANHADv/9YRC2vPMFQROqiqIO27LYQ9hIy6ajgySi22ZoSFN7B62ofbh0Cxb
         anN1tvCsGmJbnmqNsPG67Xdr2/NyADnDb8WqL8EnZHX2240tNpPxjBhqnFe7KU3nb3s9
         qH50AZOYCA/uhkV+ld9W1D6eAxk2bwEw/+tWQ+YOzjniNGj7SkY7HVBuMygnJOKpU3ex
         7cUAykYXssCo32ds3QpkC0gqME7Nc8PiWIb4lmmZr123IttGsQXssr7YsWMm1h5hH+oE
         xypw==
X-Gm-Message-State: AOAM530cpucoX7Dw5v1A0dbaEUMqjxdnPr2YTGLSAj2bGKkca4pmcU8m
        4nwIcFYZC0BXK0M3I0d/mATUpg==
X-Google-Smtp-Source: ABdhPJzPb0xrQfYz/QsYG3LsjhsCqhhunDjTyM/p4U47JfwRJ5DQarU6cR+d2fPgJkfLT6b+EUMmLQ==
X-Received: by 2002:aca:dc44:: with SMTP id t65mr9803129oig.76.1626479694464;
        Fri, 16 Jul 2021 16:54:54 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b10sm2434834oiy.4.2021.07.16.16.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 16:54:54 -0700 (PDT)
Date:   Fri, 16 Jul 2021 18:54:51 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sarthak Garg <sartgarg@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        stummala@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH V1 2/2] mmc: sdhci-msm: Use maximum possible data timeout
 value
Message-ID: <YPIcSx90JqhVn3A1@yoga>
References: <1626444182-2187-1-git-send-email-sartgarg@codeaurora.org>
 <1626444182-2187-3-git-send-email-sartgarg@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626444182-2187-3-git-send-email-sartgarg@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 16 Jul 09:03 CDT 2021, Sarthak Garg wrote:

> The Qcom SD controller defines the usage of 0xF in data
> timeout counter register (0x2E) which is actually a reserved
> bit as per specification. This would result in maximum of 21.26 secs
> timeout value.
> 
> Some SDcard taking more time than 2.67secs (timeout value corresponding
> to 0xE) and with that observed data timeout errors.
> So increasing the timeout value to max possible timeout.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

The From: of the email says you wrote the patch, but the first person to
certify its origin is Sahitya. Did you perhaps write this together? If
so you should have a:

Co-developed-by: Sahitya

If Sahitya wrote the patch, certifies its origin and then you picks it
up and certify that you got it from Sahitya, then you should write it as
you did - but you should have retained Sahitya as author...

Regards,
Bjorn

> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index e44b7a6..19e4673 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2696,6 +2696,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  
>  	msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>  
> +	/* Set the timeout value to max possible */
> +	host->max_timeout_count = 0xF;
> +
>  	pm_runtime_get_noresume(&pdev->dev);
>  	pm_runtime_set_active(&pdev->dev);
>  	pm_runtime_enable(&pdev->dev);
> -- 
> 2.7.4
> 
