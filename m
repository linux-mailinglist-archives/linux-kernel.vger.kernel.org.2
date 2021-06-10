Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B699E3A3089
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhFJQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhFJQ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:26:44 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630CFC0617A6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:24:33 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so258362otk.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9/DjL0W8Kwc85dQlaMu4c0C34K4lltZtD4h1qCOOSvA=;
        b=GaLND5jkIwSD9jqV/WpZxE4UH/wDlAtJgzmNhw2y3/Yik2Y7wRnhsf/Hpa3prXNU7l
         gOgNYfJiFmKSO9ODUjt3FSMB/O6WZ1Gm3Nboha3ZyMK95v+F+QnXMtZkfnroSEUrMN9l
         bEEi6880t7FZkekAemX8VzWlnIFCmyPHSwEtuyWP7ocptfO3Hu1nYtjimy2k07sbT91y
         YpxFzEg5lGlY3EIesAAHzKt14IeQ03eqDNzAk6TwT37z+djMaP1rpZh0eq7AKkLY0is2
         HKOmZCvdkUp6rxWv8g993B086e1HnTBKRe185Vjai1/1c/ioY+HXhbhMJWV4z67FNUkC
         GAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9/DjL0W8Kwc85dQlaMu4c0C34K4lltZtD4h1qCOOSvA=;
        b=CjxEj4yBr2v5lHRWdyqzEz52sTFXs6U7JtngGUilRuUJUdKw4k+WMLk2bFMuY7r5ZE
         LqlTUHrZuXB1mps3hDLkRexzBbMbx28b2H9DTDviQWVdy3UIruMRRO7KcaDHsISnyGRn
         zoqEuUDueESAlIJY0wbC9KZYu+lS06b4zfKhzQpDya93X+tj7fmcvAv9Cqsi/lMhNTUb
         w8hcqEARRV1M25JUrDjpNjEmgzDpH/BJoV8WMowJ7OPlcjLToB38lQAiNXwYmaQzyCoI
         37wiEzhthoRCsZmC6I2Vv2QkMRa6TL4t0JFTAflfPxzXBEIhsIBCa7IQSgHGSaHFuMSL
         Sihw==
X-Gm-Message-State: AOAM531hEYcCCUXSD7zq+Rw3DuHW7o/4wfmrqEiQsrLBUFe/QIu1Q3Vx
        IwZGTdOhFrl9kl3ghbe4DUYnww==
X-Google-Smtp-Source: ABdhPJwfnxifl7NsnrkIcbZ5Me40GCrphfoKbb7052rshFeC50yHN9obmyMANzozB5bwc0TkY/3uqw==
X-Received: by 2002:a05:6830:18c2:: with SMTP id v2mr3042879ote.153.1623342272660;
        Thu, 10 Jun 2021 09:24:32 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id y16sm694225oto.60.2021.06.10.09.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:24:32 -0700 (PDT)
Date:   Thu, 10 Jun 2021 11:24:30 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom_smd: Fix up PM8950 regulator
 configuration
Message-ID: <YMI8vopmXGb3Hl+G@builder.lan>
References: <20210225213745.117498-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225213745.117498-1-konrad.dybcio@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Feb 15:37 CST 2021, Konrad Dybcio wrote:

> Following changes have been made:
> 
> - S5, L4, L18, L20 and L21 were removed (S5 is managed by
> SPMI, whereas the rest seems not to exist [or at least it's blocked
> by Sony Loire /MSM8956/ RPM firmware])
> 
> - Supply maps have were adjusted to reflect regulator changes.

Please describe why, not what in your commit message.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  drivers/regulator/qcom_smd-regulator.c | 35 +++++++++++++-------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index bb944ee5fe3b..5188f58b4718 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -843,32 +843,31 @@ static const struct rpm_regulator_data rpm_pm8950_regulators[] = {
>  	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pm8950_hfsmps, "vdd_s2" },
>  	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pm8950_hfsmps, "vdd_s3" },
>  	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pm8950_hfsmps, "vdd_s4" },
> -	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pm8950_ftsmps2p5, "vdd_s5" },
> +	/* S5 is managed via SPMI. */

Why isn't it sufficient to just omit s5 from DT then?

>  	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pm8950_hfsmps, "vdd_s6" },
>  
>  	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pm8950_ult_nldo, "vdd_l1_l19" },
>  	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pm8950_ult_nldo, "vdd_l2_l23" },
>  	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pm8950_ult_nldo, "vdd_l3" },
> -	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pm8950_ult_pldo, "vdd_l4_l5_l6_l7_l16" },
> -	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8950_pldo_lv, "vdd_l4_l5_l6_l7_l16" },
> -	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8950_pldo_lv, "vdd_l4_l5_l6_l7_l16" },
> -	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8950_pldo_lv, "vdd_l4_l5_l6_l7_l16" },
> +	/* L4 seems not to exist. */

No LDO4 at all? Or it's one of those regulators where the RPM interface
just says no (in your firmware)?

> +	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pm8950_pldo_lv, "vdd_l5_l6_l7_l16" },

The fact that it's not possible to modify l4 doesn't mean that the input
pin isn't named  "vdd_l4_l5...".

Regards,
Bjorn

> +	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pm8950_pldo_lv, "vdd_l5_l6_l7_l16" },
> +	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pm8950_pldo_lv, "vdd_l5_l6_l7_l16" },
>  	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pm8950_ult_pldo, "vdd_l8_l11_l12_l17_l22" },
>  	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18" },
>  	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pm8950_ult_nldo, "vdd_l9_l10_l13_l14_l15_l18"},
> -	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8950_ult_pldo, "vdd_l8_l11_l12_l17_l22"},
> -	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8950_ult_pldo, "vdd_l8_l11_l12_l17_l22"},
> -	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18"},
> -	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18"},
> -	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18"},
> -	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8950_ult_pldo, "vdd_l4_l5_l6_l7_l16"},
> -	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8950_ult_pldo, "vdd_l8_l11_l12_l17_l22"},
> -	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18"},
> -	{ "l19", QCOM_SMD_RPM_LDOA, 18, &pm8950_pldo, "vdd_l1_l19"},
> -	{ "l20", QCOM_SMD_RPM_LDOA, 18, &pm8950_pldo, "vdd_l20"},
> -	{ "l21", QCOM_SMD_RPM_LDOA, 18, &pm8950_pldo, "vdd_l21"},
> -	{ "l22", QCOM_SMD_RPM_LDOA, 18, &pm8950_pldo, "vdd_l8_l11_l12_l17_l22"},
> -	{ "l23", QCOM_SMD_RPM_LDOA, 18, &pm8950_pldo, "vdd_l2_l23"},
> +	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pm8950_ult_pldo, "vdd_l8_l11_l12_l17_l22" },
> +	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pm8950_ult_pldo, "vdd_l8_l11_l12_l17_l22" },
> +	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18" },
> +	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18" },
> +	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pm8950_ult_pldo, "vdd_l9_l10_l13_l14_l15_l18" },
> +	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pm8950_ult_pldo, "vdd_l5_l6_l7_l16" },
> +	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pm8950_ult_pldo, "vdd_l8_l11_l12_l17_l22" },
> +	/* L18 seems not to exist. */
> +	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pm8950_pldo, "vdd_l1_l19" },
> +	/* L20 & L21 seem not to exist. */
> +	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pm8950_pldo, "vdd_l8_l11_l12_l17_l22" },
> +	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pm8950_pldo, "vdd_l2_l23" },
>  	{}
>  };
>  
> -- 
> 2.30.1
> 
