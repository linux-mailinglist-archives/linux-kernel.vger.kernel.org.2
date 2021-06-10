Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC7763A2E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 16:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhFJOfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 10:35:53 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36731 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbhFJOfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 10:35:52 -0400
Received: by mail-pl1-f170.google.com with SMTP id x10so1122917plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 07:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Cd2W8TOIgpOf1z4OGqH/3rBspOukbuxO7R8hv8hZEok=;
        b=Vr4L/ooG51SPZk+BpTj8d3Dhl1MPAmW12L/bcFgrUWXomaGDgNIne38p4Bg9qIam6a
         IbjJ8u/l/xYi1fQqs1g8O7t3W9cxDCRT5kZS/tWfjizizPkPYCb18eSZFMHwdyNTtQ54
         DW9S4FB4cnqKT5sqNvviUXdL1+8+ufi3ziOr3q4Rs0uTKopYfpKH70CTulAV3faobYzv
         ns3RltWPZMezuTIKGqZLTdTIiI8SoOwcC+b3d5ERYmdvB4F82Hyt4V3UsnrV3ol9Dp1W
         j/5Oa0hh+mv3r6f+QHOLvDGPy3s89T+wY3jKJBxn21vk7jOCsH+9a/QF85/GhS4M1J0u
         d/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cd2W8TOIgpOf1z4OGqH/3rBspOukbuxO7R8hv8hZEok=;
        b=HoW6m/7O4Ssh6/upvdLEjFON0mdOuc9EKApP3WfSuFF9JaeCTk1YUnxIiTZeiSBpdh
         M1eu+sDrdmmWuEs63YMCxnzr/YTC6psBPeAaNmVgI9rfUKhhwPCtmb0syIcnmI4kbrVu
         94UZw/DjGqR1/p26rlo0QIPIva0p8q08Q3OVItlRhwaduIW4NBf16Z35OLX1Qy2fwmjY
         YlKNKq95S/DtSL2IvZ+G51HCgb9oGypAarLPdsAUU80tpGXubqMM5kLs3xsxtjh4Ah2O
         WOdiIvDBK4aSqTTEJGjOdNFYttJdm92cv1yYmjgQAxiBE+4vxpmdNenznGYp+ahHS7FL
         rSBA==
X-Gm-Message-State: AOAM530FNFgGLkDqFV+ktQ4lOuNxqwwpCZSzvA8tylnj2EfKVG5/l2gb
        yk2NT2Zog4CgONLqm54bvFGR
X-Google-Smtp-Source: ABdhPJxNoILIsN8CwvQBVsBvPsJzIbXbbrpiAL77q3s8DI3eveLia7tMeqCgBT5x0WYEfg0Jp83zAA==
X-Received: by 2002:a17:90b:2112:: with SMTP id kz18mr3553629pjb.58.1623335564050;
        Thu, 10 Jun 2021 07:32:44 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d9e:80ad:d341:9a16:2c5c:2249])
        by smtp.gmail.com with ESMTPSA id l128sm3056864pgl.18.2021.06.10.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 07:32:43 -0700 (PDT)
Date:   Thu, 10 Jun 2021 20:02:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] clk: actions: Fix bisp_factor_table based clocks
 on Owl S500 SoC
Message-ID: <20210610143235.GB315240@thinkpad>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
 <288f7a0a677a6bd8a3007b8b126f5a4637ec772e.1622119892.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288f7a0a677a6bd8a3007b8b126f5a4637ec772e.1622119892.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 04:16:41PM +0300, Cristian Ciocaltea wrote:
> The following clocks of the Actions Semi Owl S500 SoC have been defined
> to use a shared clock factor table 'bisp_factor_table[]': DE[1-2], VCE,
> VDE, BISP, SENSOR[0-1]
> 
> There are several issues involved in this approach:
> 
> * 'bisp_factor_table[]' describes the configuration of a regular 8-rates
>   divider, so its usage is redundant. Additionally, judging by the BISP
>   clock context, it is incomplete since it maps only 8 out of 12
>   possible entries.
> 
> * The clocks mentioned above are not identical in terms of the available
>   rates, therefore cannot rely on the same factor table. Specifically,
>   BISP and SENSOR* are standard 12-rate dividers so their configuration
>   should rely on a proper clock div table, while VCE and VDE require a
>   factor table that is a actually a subset of the one needed for DE[1-2]
>   clocks.
> 
> Let's fix this by implementing the following:
> 
> * Add new factor tables 'de_factor_table' and 'hde_factor_table' to
>   properly handle DE[1-2], VCE and VDE clocks.
> 
> * Add a common div table 'std12rate_div_table' for BISP and SENSOR[0-1]
>   clocks converted to OWL_COMP_DIV.
> 
> * Drop the now unused 'bisp_factor_table[]'.
> 
> Additionally, drop the CLK_IGNORE_UNUSED flag for SENSOR[0-1] since
> there is no reason to always keep ON those clocks.
> 
> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v2:
>  - Re-added OWL_GATE_HW to SENSOR[0-1], according to the datasheet they
>    are gated, even though the vendor implementation states the opposite
> 
>  drivers/clk/actions/owl-s500.c | 44 ++++++++++++++++++++++------------
>  1 file changed, 29 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 42abdf964044..42d6899755e6 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -140,9 +140,16 @@ static struct clk_factor_table sd_factor_table[] = {
>  	{ 0, 0, 0 },
>  };
>  
> -static struct clk_factor_table bisp_factor_table[] = {
> -	{ 0, 1, 1 }, { 1, 1, 2 }, { 2, 1, 3 }, { 3, 1, 4 },
> -	{ 4, 1, 5 }, { 5, 1, 6 }, { 6, 1, 7 }, { 7, 1, 8 },
> +static struct clk_factor_table de_factor_table[] = {
> +	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 2, 5 },
> +	{ 4, 1, 3 }, { 5, 1, 4 }, { 6, 1, 6 }, { 7, 1, 8 },
> +	{ 8, 1, 12 },
> +	{ 0, 0, 0 },
> +};
> +
> +static struct clk_factor_table hde_factor_table[] = {
> +	{ 0, 1, 1 }, { 1, 2, 3 }, { 2, 1, 2 }, { 3, 2, 5 },
> +	{ 4, 1, 3 }, { 5, 1, 4 }, { 6, 1, 6 }, { 7, 1, 8 },
>  	{ 0, 0, 0 },
>  };
>  
> @@ -156,6 +163,13 @@ static struct clk_div_table rmii_ref_div_table[] = {
>  	{ 0, 0 },
>  };
>  
> +static struct clk_div_table std12rate_div_table[] = {
> +	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
> +	{ 4, 5 }, { 5, 6 }, { 6, 7 }, { 7, 8 },
> +	{ 8, 9 }, { 9, 10 }, { 10, 11 }, { 11, 12 },
> +	{ 0, 0 },
> +};
> +
>  static struct clk_div_table i2s_div_table[] = {
>  	{ 0, 1 }, { 1, 2 }, { 2, 3 }, { 3, 4 },
>  	{ 4, 6 }, { 5, 8 }, { 6, 12 }, { 7, 16 },
> @@ -191,39 +205,39 @@ static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNE
>  
>  /* factor clocks */
>  static OWL_FACTOR(ahb_clk, "ahb_clk", "h_clk", CMU_BUSCLK1, 2, 2, ahb_factor_table, 0, 0);
> -static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 3, bisp_factor_table, 0, 0);
> -static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 3, bisp_factor_table, 0, 0);
> +static OWL_FACTOR(de1_clk, "de_clk1", "de_clk", CMU_DECLK, 0, 4, de_factor_table, 0, 0);
> +static OWL_FACTOR(de2_clk, "de_clk2", "de_clk", CMU_DECLK, 4, 4, de_factor_table, 0, 0);
>  
>  /* composite clocks */
>  static OWL_COMP_FACTOR(vce_clk, "vce_clk", hde_clk_mux_p,
>  			OWL_MUX_HW(CMU_VCECLK, 4, 2),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 26, 0),
> -			OWL_FACTOR_HW(CMU_VCECLK, 0, 3, 0, bisp_factor_table),
> +			OWL_FACTOR_HW(CMU_VCECLK, 0, 3, 0, hde_factor_table),
>  			0);
>  
>  static OWL_COMP_FACTOR(vde_clk, "vde_clk", hde_clk_mux_p,
>  			OWL_MUX_HW(CMU_VDECLK, 4, 2),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 25, 0),
> -			OWL_FACTOR_HW(CMU_VDECLK, 0, 3, 0, bisp_factor_table),
> +			OWL_FACTOR_HW(CMU_VDECLK, 0, 3, 0, hde_factor_table),
>  			0);
>  
> -static OWL_COMP_FACTOR(bisp_clk, "bisp_clk", bisp_clk_mux_p,
> +static OWL_COMP_DIV(bisp_clk, "bisp_clk", bisp_clk_mux_p,
>  			OWL_MUX_HW(CMU_BISPCLK, 4, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
> -			OWL_FACTOR_HW(CMU_BISPCLK, 0, 3, 0, bisp_factor_table),
> +			OWL_DIVIDER_HW(CMU_BISPCLK, 0, 4, 0, std12rate_div_table),
>  			0);
>  
> -static OWL_COMP_FACTOR(sensor0_clk, "sensor0_clk", sensor_clk_mux_p,
> +static OWL_COMP_DIV(sensor0_clk, "sensor0_clk", sensor_clk_mux_p,
>  			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
> -			OWL_FACTOR_HW(CMU_SENSORCLK, 0, 3, 0, bisp_factor_table),
> -			CLK_IGNORE_UNUSED);
> +			OWL_DIVIDER_HW(CMU_SENSORCLK, 0, 4, 0, std12rate_div_table),
> +			0);
>  
> -static OWL_COMP_FACTOR(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
> +static OWL_COMP_DIV(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
>  			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
>  			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
> -			OWL_FACTOR_HW(CMU_SENSORCLK, 8, 3, 0, bisp_factor_table),
> -			CLK_IGNORE_UNUSED);
> +			OWL_DIVIDER_HW(CMU_SENSORCLK, 8, 4, 0, std12rate_div_table),
> +			0);
>  
>  static OWL_COMP_FACTOR(sd0_clk, "sd0_clk", sd_clk_mux_p,
>  			OWL_MUX_HW(CMU_SD0CLK, 9, 1),
> -- 
> 2.31.1
> 
