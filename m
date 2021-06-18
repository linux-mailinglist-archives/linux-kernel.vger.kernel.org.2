Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734BF3AD1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbhFRSI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhFRSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:08:55 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45D5C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:06:44 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 5-20020a9d01050000b02903c700c45721so10528493otu.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 11:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OEKJM9vIqp0HzyKXj3PmRgH2R1YDj6D4MPV9OcuTS9o=;
        b=a3ckPvSP/3evWGcvch+X4B/q2twhoRag+Kw7B/APoE2ES7pLi52jI/cKMD6xwk7u/S
         mDVI+JJjy9RfZsbkbFj6iVB6+eOIpDU7hx/FKrTSocLzsy3kKHOBy5dIr1I/Qe9nnksV
         3mtOXVsLr4dcelH+dWmV+I1jtsgoVZtsDrTDuREIuPv2BVBGYX66QzqP8G/5zC3q7XJC
         3O4sMyq90iD8cKgbIu8K4KxKFWbLSfIEDX+Ck85+0PUiWJMxNT9yiRcpJNY81VnjDkxD
         giEmxia8Y7cFk46n7QNqKK3VaJMVg8I+//iRyawfatcPly1WaGG1CRVv0H/a3J0LGkLZ
         K2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OEKJM9vIqp0HzyKXj3PmRgH2R1YDj6D4MPV9OcuTS9o=;
        b=bk5YXUPscnz2t6t+R95vhmYTxjFIelcqxdRPv0hp3XfnB1yCgR5rlsGQ7lwxYkCGLp
         2hxQ3OGuOF1+OGxApJIkcco5DApRFF3qqRlPwra4sbxJ3Wuu78tvMWV7k3Ivw+lN5Op7
         h2/zSfK2H0CyIXkpsoZZR8xy9cZsHxWgt3Lsfd4h2KqHPci/VHTCbMSmC+jm5hCIVyVP
         Tta/Ucms8CDg6WwWpMsFYztJCrSz2/wcrlSQCpWalaxsVElklQfUBjUIoBikYzc1d+pj
         le12ycLKH99736ZMplZXN2OYG3eqVeJ+8qTk8dsh92N3/VKtZCLYWWiFM/Vj6i9qzVOT
         IICQ==
X-Gm-Message-State: AOAM533xwjwF1Q+S9j0/cua69wQhfW7IyV8/Jomt6FBnbEakHtALiaN9
        Pa8BCbViL7mjNappoRfm39KBlQ==
X-Google-Smtp-Source: ABdhPJzBzlY9T26KUGOr/F4uK6/WOLYLE33cfL2bZqHmXN/Dv/pWim6wpK9xUU+I+wbqFy8X287D9g==
X-Received: by 2002:a9d:585:: with SMTP id 5mr10634495otd.12.1624039604035;
        Fri, 18 Jun 2021 11:06:44 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id h11sm1949471otg.43.2021.06.18.11.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:06:43 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:06:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/5] regulator: qcom-rpmh: Add new regulator found on
 SA8155p adp board
Message-ID: <YMzgsRdrhGZonzd1@builder.lan>
References: <20210617051712.345372-1-bhupesh.sharma@linaro.org>
 <20210617051712.345372-6-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617051712.345372-6-bhupesh.sharma@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Jun 00:17 CDT 2021, Bhupesh Sharma wrote:

> SA8155p-adp board supports a new regulator - pmm8155au.
> 
> The output power management circuits in this regulator include:
> - FTS510 smps,
> - HFS510 smps, and
> - LDO510 linear regulators
> 
> Add support for the same.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/regulator/qcom-rpmh-regulator.c | 36 +++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
> index af41a517da99..6cca910a76de 100644
> --- a/drivers/regulator/qcom-rpmh-regulator.c
> +++ b/drivers/regulator/qcom-rpmh-regulator.c
> @@ -883,6 +883,38 @@ static const struct rpmh_vreg_init_data pm8150l_vreg_data[] = {
>  	{}
>  };
>  
> +static const struct rpmh_vreg_init_data pmm8155au_vreg_data[] = {
> +	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
> +	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
> +	RPMH_VREG("smps3",  "smp%s3",  &pmic5_ftsmps510, "vdd-s3"),
> +	RPMH_VREG("smps4",  "smp%s4",  &pmic5_hfsmps510, "vdd-s4"),
> +	RPMH_VREG("smps5",  "smp%s5",  &pmic5_hfsmps510, "vdd-s5"),
> +	RPMH_VREG("smps6",  "smp%s6",  &pmic5_ftsmps510, "vdd-s6"),
> +	RPMH_VREG("smps7",  "smp%s7",  &pmic5_ftsmps510, "vdd-s7"),
> +	RPMH_VREG("smps8",  "smp%s8",  &pmic5_ftsmps510, "vdd-s8"),
> +	RPMH_VREG("smps9",  "smp%s9",  &pmic5_ftsmps510, "vdd-s9"),
> +	RPMH_VREG("smps10", "smp%s10", &pmic5_ftsmps510, "vdd-s10"),
> +	RPMH_VREG("ldo1",   "ldo%s1",  &pmic5_nldo,      "vdd-l1-l8-l11"),
> +	RPMH_VREG("ldo2",   "ldo%s2",  &pmic5_pldo,      "vdd-l2-l10"),
> +	RPMH_VREG("ldo3",   "ldo%s3",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
> +	RPMH_VREG("ldo4",   "ldo%s4",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
> +	RPMH_VREG("ldo5",   "ldo%s5",  &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
> +	RPMH_VREG("ldo6",   "ldo%s6",  &pmic5_nldo,      "vdd-l6-l9"),
> +	RPMH_VREG("ldo7",   "ldo%s7",  &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo8",   "ldo%s8",  &pmic5_nldo,      "vdd-l1-l8-l11"),
> +	RPMH_VREG("ldo9",   "ldo%s9",  &pmic5_nldo,      "vdd-l6-l9"),
> +	RPMH_VREG("ldo10",  "ldo%s10", &pmic5_pldo,      "vdd-l2-l10"),
> +	RPMH_VREG("ldo11",  "ldo%s11", &pmic5_nldo,      "vdd-l1-l8-l11"),
> +	RPMH_VREG("ldo12",  "ldo%s12", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo13",  "ldo%s13", &pmic5_pldo,      "vdd-l13-l16-l17"),
> +	RPMH_VREG("ldo14",  "ldo%s14", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo15",  "ldo%s15", &pmic5_pldo_lv,   "vdd-l7-l12-l14-l15"),
> +	RPMH_VREG("ldo16",  "ldo%s16", &pmic5_pldo,      "vdd-l13-l16-l17"),
> +	RPMH_VREG("ldo17",  "ldo%s17", &pmic5_pldo,      "vdd-l13-l16-l17"),
> +	RPMH_VREG("ldo18",  "ldo%s18", &pmic5_nldo,      "vdd-l3-l4-l5-l18"),
> +	{}
> +};
> +
>  static const struct rpmh_vreg_init_data pm8350_vreg_data[] = {
>  	RPMH_VREG("smps1",  "smp%s1",  &pmic5_ftsmps510, "vdd-s1"),
>  	RPMH_VREG("smps2",  "smp%s2",  &pmic5_ftsmps510, "vdd-s2"),
> @@ -1177,6 +1209,10 @@ static const struct of_device_id __maybe_unused rpmh_regulator_match_table[] = {
>  		.compatible = "qcom,pmc8180c-rpmh-regulators",
>  		.data = pm8150l_vreg_data,
>  	},
> +	{
> +		.compatible = "qcom,pmm8155au-rpmh-regulators",
> +		.data = pmm8155au_vreg_data,
> +	},
>  	{
>  		.compatible = "qcom,pmx55-rpmh-regulators",
>  		.data = pmx55_vreg_data,
> -- 
> 2.31.1
> 
