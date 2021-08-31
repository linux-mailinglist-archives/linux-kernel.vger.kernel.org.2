Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 822063FCBD0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbhHaQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhHaQwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 12:52:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FEFC061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:51:20 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w19so25252959oik.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ny3pPNhYxScY0O7v4HQkOGbeAQGBp/GJhu0ybiyIqbw=;
        b=YGNMfl03eR+fgH36dgemFP2Z0AvbzX+q4FmisSQEqEDze57EQC5t3fVTfyyRw1fk0l
         tDUI6mPXVXacU06MYyPKj9Y65d/4Ei72UvXeeeUd4rFOkwGee10KLmTRZ64QHDgQi5xx
         IxhovYfmpqho83LzlwsES6GDaP7pmcGz/6f7LZscgzfPhbxjQsSMGaP6FwpfX7YLorEf
         xPkyVdanqMCba/DxbFgboyij92Fj8RaEnzo15Thz7gSGyzxjtb5P2RMx9NMUK/symnOj
         /6kc75e+H9VRNA8yCLPLEz2c5z5UtGTcA9OrAXJDPMqqbsrHD3Sjct5mano690Gr6a+k
         rJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ny3pPNhYxScY0O7v4HQkOGbeAQGBp/GJhu0ybiyIqbw=;
        b=uOdyba716FyrvuYgH71l+bZ/JwAphnaRq4pLylJxi3Ow5PFoNM3tcH3dGQpn2iAgvD
         Ga54ToNRwuGyh1mgUE9DwQvZvpAYP/JB9HwxSO8RdMjhzFBBJm9ye7KnvnuNhKCB8wWW
         dPsn/jYB+dNeTToniWdnQ3ro9kFDKHsqNW13CztEhEOnuYTqmkCZ3NzC6MPTncmE+Lj3
         BQgSfVyiOpbZDJupeL/UjKBA2JM9CRuXTJJgJr/y/51x48Y9Hc806se25aJyA5Kk2zci
         Po/1K+AhtTI3iYDX4llvJ5h4mUkWE9KehBhAu7yKXIgHS0caBvMym/rvFNPhlzz4jc84
         /DFA==
X-Gm-Message-State: AOAM530yg3hMfHyRGkPrud1xekPmHmyb3CFq0q4xPjl+rutvlv2KZCSy
        ceOJR5giWFJ75DpK5L+Yisx5ZQ==
X-Google-Smtp-Source: ABdhPJxG+dwPTTaUteeRkyAarG9UrTrZCCyITW2JHmDVyhPBLs2Pa2Be69o8aXrRq76hyqr9uUuojA==
X-Received: by 2002:aca:eb8c:: with SMTP id j134mr4015501oih.158.1630428680203;
        Tue, 31 Aug 2021 09:51:20 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id o126sm3081197oig.21.2021.08.31.09.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 09:51:19 -0700 (PDT)
Date:   Tue, 31 Aug 2021 09:52:28 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh-regulator: fix pm8009-1 ldo7
 resource name
Message-ID: <YS5eTOOlN5zYIGgq@ripper>
References: <20210831161843.1044580-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831161843.1044580-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 31 Aug 09:18 PDT 2021, Dmitry Baryshkov wrote:

> Fix a typo in the pm8009 LDO7 declaration, it uses resource name ldo%s6
> instead of ldo%s7.
> 
> Fixes: 951384cabc5d ("regulator: qcom-rpmh-regulator: add pm8009-1 chip revision")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_drm.c         | 6 ++++++
>  drivers/regulator/qcom-rpmh-regulator.c | 2 +-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
> index 764f4b81017e..486a653e2fea 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -114,6 +114,11 @@ static enum drm_mode_status dp_connector_mode_valid(
>  	return dp_display_validate_mode(dp_disp, mode->clock);
>  }
>  
> +static struct drm_encoder *dp_connector_best_encoder(struct drm_connector *connector)
> +{
> +	return to_dp_connector(connector)->dp_display->encoder;
> +}
> +
>  static const struct drm_connector_funcs dp_connector_funcs = {
>  	.detect = dp_connector_detect,
>  	.fill_modes = drm_helper_probe_single_connector_modes,
> @@ -126,6 +131,7 @@ static const struct drm_connector_funcs dp_connector_funcs = {
>  static const struct drm_connector_helper_funcs dp_connector_helper_funcs = {
>  	.get_modes = dp_connector_get_modes,
>  	.mode_valid = dp_connector_mode_valid,
> +	.best_encoder = dp_connector_best_encoder,
>  };

This part doesn't belong here.

>  
>  /* connector initialization */
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index 6cca910a76de..7f458d510483 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -991,7 +991,7 @@ static const struct rpmh_vreg_init_data pm8009_1_vreg_data[] = {
>  	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l4"),
>  	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_pldo,      "vdd-l5-l6"),
>  	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_pldo,      "vdd-l5-l6"),
> -	RPMH_VREG("ldo7",   "ldo%s6",  &pmic5_pldo_lv,   "vdd-l7"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7"),

This looks good though!

Please drop the lingering DRM part and add my R-b.

Thanks,
Bjorn

>  	{}
>  };
>  
> -- 
> 2.33.0
> 
