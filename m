Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23C3C2951
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 20:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhGIS6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 14:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhGIS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 14:58:10 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6946C0613DD
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 11:55:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u11so13404234oiv.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uB9Eme5ZVBV7EnqQMMLYyAMl/eqDXMgXY7i7Hw0mKEs=;
        b=d/bcCehuBJn2d5ELJK1ULtS7j+/2lTPxvJVjr3DmntKvjNVfJxq0FhhIwA9aHOF2VX
         KWN+HE9FuUeYGQnhxoYTvDlsNLmZOhnCYV9FpfMRimPX20aysF37Y3n/QPcAnxUiRrWy
         Fjp2l0QqoOAJKU7LE7jybbhxpv2j/qNSXu0F1HNLDPwn+ChKmhdxaknYwFkv8vX+/x9I
         Pdl/HYfnVmKM00aClOSH4udWXT2nk6qflavGzMxKUmNtDLnGicz4twI9u0IwRB2tCbm+
         YiMxgmvrkZREKNex8vMOUgVfhvU7kin+735VlbqiG3Zup5VvNhZnlhX1fCn1IUVq0jeg
         GQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uB9Eme5ZVBV7EnqQMMLYyAMl/eqDXMgXY7i7Hw0mKEs=;
        b=gN+A+OaM8cVvh2+/lXO6JwUK1BHixD6RQ+BKxO/4vEz4VI/npNpbXyu5qIXSRAzO9r
         joikrTv+hJRYzNAOoROf8gTNvl+iNWInqvwjoNBvuLUjxanIuXDHHQpA91xP3Zhoii6f
         nfHHvqpNVnGUJdcEm6Kat8ezYDdvoU9Z6QbZFsU2MvVR/jr0mYsCEzcJ1G9zEtSCr3Te
         20gQi1c9N95lnlTfFwAYpgfnAiIVFKEyt7XhdpUc7Y5VYsjxMzyh0bKMdq96/dmD5muU
         0cOIjFqJn+RsW/nR/4jHpMmtnQyFrLWQFBmZtRLBP75avFKGhkkQ1WzaqOiosDJJvuqX
         Mu8Q==
X-Gm-Message-State: AOAM5338u0+nH8KRIIQNZ87ZKpfb2LPDDMeIiEgDYMiheg5fpwCI8qbQ
        DPRRj3rmkktcf3Yr6vP5pSibGQ==
X-Google-Smtp-Source: ABdhPJzCEqCusHOgpOD/C7bb+a/2dnNpEdSnz6mJFimLIERNNw654/5qKRCQE7P+dxPA/RFOR23VWg==
X-Received: by 2002:a54:4513:: with SMTP id l19mr329034oil.36.1625856926173;
        Fri, 09 Jul 2021 11:55:26 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id j23sm1387888oie.9.2021.07.09.11.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 11:55:25 -0700 (PDT)
Date:   Fri, 9 Jul 2021 13:55:23 -0500
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
Subject: Re: [PATCH v3 5/7] arm64: dts: qcom: sm8250: remove mmcx regulator
Message-ID: <YOibmxZ8IwGncqjS@yoga>
References: <20210709173202.667820-1-dmitry.baryshkov@linaro.org>
 <20210709173202.667820-6-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709173202.667820-6-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Jul 12:32 CDT 2021, Dmitry Baryshkov wrote:

> Switch dispcc and videocc into using MMCX domain directly. Drop the now
> unused mmcx regulator.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 4c0de12aaba6..2a468b85dc09 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -271,13 +271,6 @@ memory@80000000 {
>  		reg = <0x0 0x80000000 0x0 0x0>;
>  	};
>  
> -	mmcx_reg: mmcx-reg {
> -		compatible = "regulator-fixed-domain";
> -		power-domains = <&rpmhpd SM8250_MMCX>;
> -		required-opps = <&rpmhpd_opp_low_svs>;
> -		regulator-name = "MMCX";
> -	};
> -
>  	pmu {
>  		compatible = "arm,armv8-pmuv3";
>  		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
> @@ -2362,7 +2355,7 @@ videocc: clock-controller@abf0000 {
>  			clocks = <&gcc GCC_VIDEO_AHB_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK>,
>  				 <&rpmhcc RPMH_CXO_CLK_A>;
> -			mmcx-supply = <&mmcx_reg>;
> +			power-domains = <&rpmhpd SM8250_MMCX>;
>  			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao";
>  			#clock-cells = <1>;
>  			#reset-cells = <1>;
> @@ -2627,7 +2620,7 @@ opp-358000000 {
>  		dispcc: clock-controller@af00000 {
>  			compatible = "qcom,sm8250-dispcc";
>  			reg = <0 0x0af00000 0 0x10000>;
> -			mmcx-supply = <&mmcx_reg>;
> +			power-domains = <&rpmhpd SM8250_MMCX>;
>  			clocks = <&rpmhcc RPMH_CXO_CLK>,
>  				 <&dsi0_phy 0>,
>  				 <&dsi0_phy 1>,
> -- 
> 2.30.2
> 
