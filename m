Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286743C323F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jul 2021 05:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhGJDaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 23:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhGJDaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 23:30:21 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF0A2C0613E8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jul 2021 20:27:36 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id w15-20020a056830144fb02904af2a0d96f3so11570359otp.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jul 2021 20:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X1gcWkzNfMqYNuA6BaS7pw1fsaPMJocofokE86AgNww=;
        b=og7wiXl5+bIhatPwpp+AZWkufvcpEfb/YDCgNEPT1kI8vBFGe0G6ingHJXUry+2Lh+
         U2y9ZTUqAo2iTYXXI09nRCV3qwGmSNWEOhdrqFfgiZjONEMb6iC/8BqmOYk5grq9bvvg
         aD0vhSPwJEFVdPGjIOihzA/2C5heBkR0EZUd4QhU+1NxKUh7ulJVFOGiEMQ4NZiznkwD
         zUasPEeCRB8sZ3Jx3aFCChpFO/joTcQH7KLQzfmZ9NH/b6TEeCr612xgj/4+4k3Yppdf
         ht2Y1eyaiMoTCQEoOVStfmiVkvmfevSgnABdC+BMQEJA93z4CjViv97D99qpsfO3IyrZ
         jzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X1gcWkzNfMqYNuA6BaS7pw1fsaPMJocofokE86AgNww=;
        b=E+k/qhbK7mQ/zLfua1HDavqcD7rrBR3LEcZD+1nG/4uot12EYKmu2wQkUXU/GgiqY2
         MJBVKTafrmLuNJnXaw95a/FlfU+JygVzSnreOB83mC5M1xFEteCmbsjtrN4fEShn6VhI
         /SXlA8Jw/RQRuVYNC+CWMrpnCu97JViNiFKABo3UJaC8OPSr/q43rOVkTWN3P0bWPxAI
         60L8No2DVVt1VZph8zxrPV/bH9b9BsXsXRa1U9y+gMtE4A1Hymtv7nDI2QyxcV1tI3rE
         QHhdBGL55Tgi++VMs5KlW1SKf4iJVdp73UoDJpSZg7lyNLdO+0i2bUnztNQefU1rrOYw
         aNVg==
X-Gm-Message-State: AOAM530KKbJEC1ccICZ8HJ1XvOlmmiYd2xR0w9B/Xmsy4zdk9/Ui8SG7
        vv4tlxaush/WzJ8fmFkzvbVe+g==
X-Google-Smtp-Source: ABdhPJy+F7ti4GFSS4/XkjgqKKfd+c4SmgI7dTnjhYEi3edWr95ZBT46olKe7jmczaYHeRQWI2pRsw==
X-Received: by 2002:a9d:6ad2:: with SMTP id m18mr16226008otq.78.1625887656224;
        Fri, 09 Jul 2021 20:27:36 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q26sm1577073oiw.25.2021.07.09.20.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 20:27:35 -0700 (PDT)
Date:   Fri, 9 Jul 2021 22:27:33 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     quic_vamslank@quicinc.com
Cc:     agross@kernel.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH 4/5] clk: qcom: Add support for SDX65 RPMh clocks
Message-ID: <YOkTpXTxyfVF14Ak@yoga>
References: <20210709200339.17638-1-quic_vamslank@quicinc.com>
 <20210709200339.17638-5-quic_vamslank@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709200339.17638-5-quic_vamslank@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Jul 15:03 CDT 2021, quic_vamslank@quicinc.com wrote:

> From: Vamsi krishna Lanka <quic_vamslank@quicinc.com>
> 
> Add support for clocks maintained by RPMh in SDX65 SoCs.
> 

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Vamsi Krishna Lanka <quic_vamslank@quicinc.com>
> ---
>  drivers/clk/qcom/clk-rpmh.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
> index 91dc390a583b..f3769b86e5d0 100644
> --- a/drivers/clk/qcom/clk-rpmh.c
> +++ b/drivers/clk/qcom/clk-rpmh.c
> @@ -477,6 +477,32 @@ static const struct clk_rpmh_desc clk_rpmh_sm8250 = {
>  	.num_clks = ARRAY_SIZE(sm8250_rpmh_clocks),
>  };
>  
> +DEFINE_CLK_RPMH_ARC(sdx65, bi_tcxo, bi_tcxo_ao, "xo.lvl", 0x3, 4);
> +DEFINE_CLK_RPMH_VRM(sdx65, ln_bb_clk1, ln_bb_clk1_ao, "lnbclka1", 4);
> +DEFINE_CLK_RPMH_VRM(sdx65, rf_clk4, rf_clk4_ao, "rfclka4", 1);
> +
> +static struct clk_hw *sdx65_rpmh_clocks[] = {
> +	[RPMH_CXO_CLK]          = &sdx65_bi_tcxo.hw,
> +	[RPMH_CXO_CLK_A]        = &sdx65_bi_tcxo_ao.hw,
> +	[RPMH_LN_BB_CLK1]       = &sdx65_ln_bb_clk1.hw,
> +	[RPMH_LN_BB_CLK1_A]     = &sdx65_ln_bb_clk1_ao.hw,
> +	[RPMH_RF_CLK1]          = &sdm845_rf_clk1.hw,
> +	[RPMH_RF_CLK1_A]        = &sdm845_rf_clk1_ao.hw,
> +	[RPMH_RF_CLK2]          = &sdm845_rf_clk2.hw,
> +	[RPMH_RF_CLK2_A]        = &sdm845_rf_clk2_ao.hw,
> +	[RPMH_RF_CLK3]          = &sdm845_rf_clk3.hw,
> +	[RPMH_RF_CLK3_A]        = &sdm845_rf_clk3_ao.hw,
> +	[RPMH_RF_CLK4]          = &sdx65_rf_clk4.hw,
> +	[RPMH_RF_CLK4_A]        = &sdx65_rf_clk4_ao.hw,
> +	[RPMH_IPA_CLK]          = &sdm845_ipa.hw,
> +	[RPMH_QPIC_CLK]         = &sdx55_qpic_clk.hw,
> +};
> +
> +static const struct clk_rpmh_desc clk_rpmh_sdx65 = {
> +	.clks = sdx65_rpmh_clocks,
> +	.num_clks = ARRAY_SIZE(sdx65_rpmh_clocks),
> +};
> +
>  DEFINE_CLK_RPMH_VRM(sm8350, div_clk1, div_clk1_ao, "divclka1", 2);
>  DEFINE_CLK_RPMH_VRM(sm8350, rf_clk4, rf_clk4_ao, "rfclka4", 1);
>  DEFINE_CLK_RPMH_VRM(sm8350, rf_clk5, rf_clk5_ao, "rfclka5", 1);
> @@ -618,6 +644,7 @@ static const struct of_device_id clk_rpmh_match_table[] = {
>  	{ .compatible = "qcom,sc8180x-rpmh-clk", .data = &clk_rpmh_sc8180x},
>  	{ .compatible = "qcom,sdm845-rpmh-clk", .data = &clk_rpmh_sdm845},
>  	{ .compatible = "qcom,sdx55-rpmh-clk",  .data = &clk_rpmh_sdx55},
> +	{ .compatible = "qcom,sdx65-rpmh-clk",  .data = &clk_rpmh_sdx65},
>  	{ .compatible = "qcom,sm8150-rpmh-clk", .data = &clk_rpmh_sm8150},
>  	{ .compatible = "qcom,sm8250-rpmh-clk", .data = &clk_rpmh_sm8250},
>  	{ .compatible = "qcom,sm8350-rpmh-clk", .data = &clk_rpmh_sm8350},
> -- 
> 2.32.0
> 
