Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F5333CC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 05:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbhCPER5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 00:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbhCPERs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 00:17:48 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A85BC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 21:17:47 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so2974557pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 21:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L9ULtcqGYTnWawh4D1wXvHmxmJ7k2IGAJbXzUghtJMs=;
        b=IRi5oSOI4BQYL409WOfrFSXKkfeafVCD5PgI7TqP7oDk3s+vCWdE2KUhYIGaMIG5Oj
         gKHYJiQwZ+XrxcKQi8kOcDOzfy8lV6KQWePFHD5B2LjluHQroAX9ZPI5D5LnxbbkH5jr
         yiVQTgpPg7W1jLU1I1xPIC7XpYX4uBy5ngGDOrhl7/5fW9CWRidS29wnKUmizsGngqHK
         fHDB8TEVmo2XVT1dDCkI5a3eGq5DoNUCwSN9GUyEzLlxUjG5yC8Nr1sysLB3Zr/MUoFw
         TXf2dG1x50cmeEJj0dATxt8S0+Y4C/8ZKE2WWNMlKK1wqIJybCOgPtmpG95NeAtXMt5N
         mPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L9ULtcqGYTnWawh4D1wXvHmxmJ7k2IGAJbXzUghtJMs=;
        b=MgHUnJdFh9oRbvKlNkbD7RFRA+BW2n08ZVLd63y4vv3VZrkVxDa853fvGOW48Yuw9/
         Rntp7azIa7hlqeZglJ8dHkfMkcyLULXjzBAi0L0mmESYOoW7IHU7w+xNUCuRMhPcGopL
         EwU3cUr9ON82mJhHacOngr5HK/vEOOTKWz/mcgJ1fzSZ5uoHcfR5JwtOePRtgApVwbZy
         p12RdQaoCV3OkAMTfz0kzqTvfMY2rxLDdaPJ7xswJvuBgYrxfiqh70DteK8zTqKwALP5
         rMCsAp8y0y51a4koWZf1jtt0OXSyKQef/SXvkf/kWOykYbiOOQGc/Dd08+9nhKePAzJN
         33IQ==
X-Gm-Message-State: AOAM532BUICt2Kwq0EjMjk8pd3Q96bhJAx3NdRT/2pUDfcO6X80ZwqKM
        LIZj2Tu1Xst9igxCpgPEL2LJ
X-Google-Smtp-Source: ABdhPJxaSL9vQK4+t5ToAAf4Ts3kKd4oJ9MuAuPien88UqWov5j8i5jBNnazX5SNNNZ1afHvraCAtw==
X-Received: by 2002:a17:90a:4d07:: with SMTP id c7mr2728272pjg.104.1615868267033;
        Mon, 15 Mar 2021 21:17:47 -0700 (PDT)
Received: from thinkpad ([103.66.79.72])
        by smtp.gmail.com with ESMTPSA id l19sm1107820pjt.16.2021.03.15.21.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 21:17:46 -0700 (PDT)
Date:   Tue, 16 Mar 2021 09:47:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/6] clk: actions: Fix bisp_factor_table based clocks on
 Owl S500 SoC
Message-ID: <20210316041739.GC1798@thinkpad>
References: <cover.1615221459.git.cristian.ciocaltea@gmail.com>
 <13576ddb604a9097603d95cd2605275c20fb2f56.1615221459.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13576ddb604a9097603d95cd2605275c20fb2f56.1615221459.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 07:18:28PM +0200, Cristian Ciocaltea wrote:
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

Nice!

> Additionally, since SENSOR[0-1] are not gated, unset the OWL_GATE_HW
> configuration and drop the CLK_IGNORE_UNUSED flag in their definitions.
> 

No. You should not screen the functionality exposed by the hw, that's what the
purpose of these CLK_ flags.

Other than that, this patch looks good to me.

> Fixes: ed6b4795ece4 ("clk: actions: Add clock driver for S500 SoC")
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> ---
>  drivers/clk/actions/owl-s500.c | 48 ++++++++++++++++++++++------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/clk/actions/owl-s500.c b/drivers/clk/actions/owl-s500.c
> index 69cd959205f5..abe8874353de 100644
> --- a/drivers/clk/actions/owl-s500.c
> +++ b/drivers/clk/actions/owl-s500.c
> @@ -138,9 +138,16 @@ static struct clk_factor_table sd_factor_table[] = {
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
> @@ -154,6 +161,13 @@ static struct clk_div_table rmii_ref_div_table[] = {
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
> @@ -189,39 +203,39 @@ static OWL_DIVIDER(rmii_ref_clk, "rmii_ref_clk", "ethernet_pll_clk", CMU_ETHERNE
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
> -			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
> -			OWL_FACTOR_HW(CMU_SENSORCLK, 0, 3, 0, bisp_factor_table),
> -			CLK_IGNORE_UNUSED);
> +			{ 0 },
> +			OWL_DIVIDER_HW(CMU_SENSORCLK, 0, 4, 0, std12rate_div_table),
> +			0);
>  
> -static OWL_COMP_FACTOR(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
> +static OWL_COMP_DIV(sensor1_clk, "sensor1_clk", sensor_clk_mux_p,
>  			OWL_MUX_HW(CMU_SENSORCLK, 4, 1),
> -			OWL_GATE_HW(CMU_DEVCLKEN0, 14, 0),
> -			OWL_FACTOR_HW(CMU_SENSORCLK, 8, 3, 0, bisp_factor_table),
> -			CLK_IGNORE_UNUSED);
> +			{ 0 },
> +			OWL_DIVIDER_HW(CMU_SENSORCLK, 8, 4, 0, std12rate_div_table),
> +			0);
>  
>  static OWL_COMP_FACTOR(sd0_clk, "sd0_clk", sd_clk_mux_p,
>  			OWL_MUX_HW(CMU_SD0CLK, 9, 1),
> -- 
> 2.30.1
> 
