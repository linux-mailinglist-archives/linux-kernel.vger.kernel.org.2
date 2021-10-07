Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F92425623
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbhJGPKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242336AbhJGPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:10:32 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04055C061762
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 08:08:39 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so7933569otj.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Hrbn7HeDVBItXq37cXoiSlOzODR88RZ0Wmp2wj5QlJ0=;
        b=SpTjCXmDid/RKM6QSJAQjtDvbrjmKs1IJ7WpwTCofbiwUX19vKia/Q1rnK2AbQsWlV
         hbkJ8rRF1EU1LkHHV0Tdf0Kd8W9/fQ9HCL1Vj0DSQHAG4rltlquEwAyc3yPoka55UVg3
         t74BaoTibEVMo3r/NXkOYHKasrnHizfftnJBb9L6Ev89wuJpiRdjDqgK3z2kMMGdJtu6
         7z0iTnZ8LZ6/eZ3nVCZYN/r4eKkuRUdPlh4/CkQuSiwsO5iHPcZsyt5dOCDo1TqcFU7w
         MXWllvds7uE1Zd/B7ECOsDZqIUB1+PQdWyB0jLstfK41BIxNatFOwU5rovZP/wd/QgGo
         6how==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Hrbn7HeDVBItXq37cXoiSlOzODR88RZ0Wmp2wj5QlJ0=;
        b=l//uns2KXasERMK4DLFAdnacWL1O7NvVpecPSB7GffFUu3GaCE+JA9KDsqQUrueyYh
         P26V7W3aQRrx7cQZrG4Wv3DD+cmL87qNByIyW9s3opWVUxQ3m5PCP9XkpybhUJpocdB3
         J34+ScGvQj1gfPzlMVsipMYkVFEdsjHdkExgrD0257FNcGwGmT+La2Lr309braANagGN
         507g+UcVHM5nRuRa4IXs60U2oJyuqCzD6m5fm7rNQAFnaQubGqMbF9lIJb4YsIpCbYpi
         3NJxZxZzkhsFyGa5TODefAXIfAPQR1rf0YqvJihciMnzEs6Othcd9V5FmX843tZ1P1qz
         YN1Q==
X-Gm-Message-State: AOAM5328rGIb0BhV71i53ilyVbNiSRiSlLVS5dY6zIm95WpYsSLO3QSo
        XqAelhfjrILjMlG1FPNjPEVgSg==
X-Google-Smtp-Source: ABdhPJwgKxkrkyMdSU/YV9SU/5JdV14CPC0V9hSvFXrASivVUmdvhPWqbWsv48v6nmimD7HHkWWTWw==
X-Received: by 2002:a05:6830:793:: with SMTP id w19mr3926234ots.23.1633619318308;
        Thu, 07 Oct 2021 08:08:38 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id n13sm71937otf.3.2021.10.07.08.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 08:08:37 -0700 (PDT)
Date:   Thu, 7 Oct 2021 08:10:17 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] clk: qcom: videocc-sm8250: use runtime PM for the
 clock controller
Message-ID: <YV8N2S0It+UqzA9F@ripper>
References: <20210829154757.784699-1-dmitry.baryshkov@linaro.org>
 <20210829154757.784699-5-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829154757.784699-5-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 29 Aug 08:47 PDT 2021, Dmitry Baryshkov wrote:

> On sm8250 dispcc and videocc registers are powered up by the MMCX power
> domain. Use runtime PM calls to make sure that required power domain is
> powered on while we access clock controller's registers.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/clk/qcom/videocc-sm8250.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
> index 7b435a1c2c4b..8617454e4a77 100644
> --- a/drivers/clk/qcom/videocc-sm8250.c
> +++ b/drivers/clk/qcom/videocc-sm8250.c
> @@ -6,6 +6,7 @@
>  #include <linux/clk-provider.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  
>  #include <dt-bindings/clock/qcom,videocc-sm8250.h>
> @@ -364,13 +365,31 @@ static const struct of_device_id video_cc_sm8250_match_table[] = {
>  };
>  MODULE_DEVICE_TABLE(of, video_cc_sm8250_match_table);
>  
> +static void video_cc_sm8250_pm_runtime_disable(void *data)
> +{
> +	pm_runtime_disable(data);
> +}
> +
>  static int video_cc_sm8250_probe(struct platform_device *pdev)
>  {
>  	struct regmap *regmap;
> +	int ret;
> +
> +	pm_runtime_enable(&pdev->dev);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, video_cc_sm8250_pm_runtime_disable, &pdev->dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = pm_runtime_resume_and_get(&pdev->dev);
> +	if (ret)
> +		return ret;
>  
>  	regmap = qcom_cc_map(pdev, &video_cc_sm8250_desc);
> -	if (IS_ERR(regmap))
> +	if (IS_ERR(regmap)) {
> +		pm_runtime_put(&pdev->dev);
>  		return PTR_ERR(regmap);
> +	}
>  
>  	clk_lucid_pll_configure(&video_pll0, regmap, &video_pll0_config);
>  	clk_lucid_pll_configure(&video_pll1, regmap, &video_pll1_config);
> @@ -379,7 +398,11 @@ static int video_cc_sm8250_probe(struct platform_device *pdev)
>  	regmap_update_bits(regmap, 0xe58, BIT(0), BIT(0));
>  	regmap_update_bits(regmap, 0xeec, BIT(0), BIT(0));
>  
> -	return qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
> +	ret = qcom_cc_really_probe(pdev, &video_cc_sm8250_desc, regmap);
> +
> +	pm_runtime_put(&pdev->dev);
> +
> +	return ret;
>  }
>  
>  static struct platform_driver video_cc_sm8250_driver = {
> -- 
> 2.33.0
> 
