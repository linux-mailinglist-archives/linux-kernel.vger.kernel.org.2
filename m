Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5CF350432
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233878AbhCaQJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:09:38 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:53848 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233805AbhCaQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:09:02 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VG2Itp032076;
        Wed, 31 Mar 2021 18:08:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=gXvFtPAdFevSxzBvTjuJ6QfUhTPwTIb46qpuVx+G/ws=;
 b=ZsnplR4ad2z8WGChFLnSfaC3wB6fFJsI591OvnBMJc1OnrK31a4R9YQGws3cL3QB8diH
 C3W1s+hMUvKslaR6Kf6fFTzOiZwQ+XS5mlgzT5cJiYCWSgNVrNSXgcPu8Qr8DacaCXmf
 ztx3RSXTWtAprUcYEJciGPghdeBmY7M5d1hP2WTuetAPECFnsdfF8qj7CR/rWUSW40So
 lfDB7Sn3TOq7Y8QSrKO6u2Qj4dETyGZoIcRQTmum9e2/AP0Neolw+NexPzcpFZiluoDz
 ltp4mI6xLjTeNcZgkhZ6qN5G/PUxGw//Fayi0xO+NlatOtbEZ4ymjMpasPKsXpzeQ/wk IA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37maa2ns9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 18:08:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F328B10002A;
        Wed, 31 Mar 2021 18:08:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3CB3215EFB;
        Wed, 31 Mar 2021 18:08:12 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.48) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 18:08:12 +0200
Subject: Re: [PATCH v3 4/7] clk: st: clkgen-pll: embed soc clock outputs
 within compatible data
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210330205125.25708-1-avolmat@me.com>
 <20210330205125.25708-5-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <26922407-d471-cd72-c68c-ca9d0dc16394@foss.st.com>
Date:   Wed, 31 Mar 2021 18:08:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330205125.25708-5-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_08:2021-03-31,2021-03-31 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain
 3/30/21 10:51 PM, Alain Volmat wrote:
> In order to avoid relying on the old style description via the DT
> clock-output-names, add compatible data describing the flexgen
> outputs clocks for all STiH407/STiH410 and STiH418 SOCs.
> 
> In order to ease transition between the two methods, this commit
> introduce the new compatible without removing the old method.
> Once DTs will be fixed, the method relying on DT clock-output-names
> will be removed from this driver as well as old compatibles.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v3: avoid CLK_IS_CRITICAL. PLL are enabled whenever necessary thanks to
>     child clock
> v2: clk-s-a0-pll-odf-0 don't need to be CLK_IS_CRITICAL
>     mark several clock as CLK_IS_CRITICAL
> 
>  drivers/clk/st/clkgen-pll.c | 120 +++++++++++++++++++++++++++++++-----
>  1 file changed, 106 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> index f6c56ca90c7d..b36e4d803636 100644
> --- a/drivers/clk/st/clkgen-pll.c
> +++ b/drivers/clk/st/clkgen-pll.c
> @@ -57,6 +57,17 @@ struct clkgen_pll_data {
>  	const struct clk_ops *ops;
>  };
>  
> +struct clkgen_clk_out {
> +	const char *name;
> +	unsigned long flags;
> +};
> +
> +struct clkgen_pll_data_clks {
> +	struct clkgen_pll_data *data;
> +	const struct clkgen_clk_out *outputs;
> +};
> +
> +
>  static const struct clk_ops stm_pll3200c32_ops;
>  static const struct clk_ops stm_pll3200c32_a9_ops;
>  static const struct clk_ops stm_pll4600c28_ops;
> @@ -74,6 +85,28 @@ static const struct clkgen_pll_data st_pll3200c32_cx_0 = {
>  	.ops		= &stm_pll3200c32_ops,
>  };
>  
> +static const struct clkgen_pll_data_clks st_pll3200c32_cx_0_legacy_data = {
> +	.data	= (struct clkgen_pll_data *)&st_pll3200c32_cx_0,
> +};
> +
> +static const struct clkgen_clk_out st_pll3200c32_ax_0_clks[] = {
> +	{ .name = "clk-s-a0-pll-odf-0", },
> +};
> +
> +static const struct clkgen_pll_data_clks st_pll3200c32_a0_data = {
> +	.data		= (struct clkgen_pll_data *)&st_pll3200c32_cx_0,
> +	.outputs	= st_pll3200c32_ax_0_clks,
> +};
> +
> +static const struct clkgen_clk_out st_pll3200c32_cx_0_clks[] = {
> +	{ .name = "clk-s-c0-pll0-odf-0", },
> +};
> +
> +static const struct clkgen_pll_data_clks st_pll3200c32_c0_data = {
> +	.data		= (struct clkgen_pll_data *)&st_pll3200c32_cx_0,
> +	.outputs	= st_pll3200c32_cx_0_clks,
> +};
> +
>  static const struct clkgen_pll_data st_pll3200c32_cx_1 = {
>  	/* 407 C0 PLL1 */
>  	.pdn_status	= CLKGEN_FIELD(0x2c8,	0x1,			8),
> @@ -87,6 +120,19 @@ static const struct clkgen_pll_data st_pll3200c32_cx_1 = {
>  	.ops		= &stm_pll3200c32_ops,
>  };
>  
> +static const struct clkgen_pll_data_clks st_pll3200c32_cx_1_legacy_data = {
> +	.data	= (struct clkgen_pll_data *)&st_pll3200c32_cx_1,
> +};
> +
> +static const struct clkgen_clk_out st_pll3200c32_cx_1_clks[] = {
> +	{ .name = "clk-s-c0-pll1-odf-0", },
> +};
> +
> +static const struct clkgen_pll_data_clks st_pll3200c32_c1_data = {
> +	.data		= (struct clkgen_pll_data *)&st_pll3200c32_cx_1,
> +	.outputs	= st_pll3200c32_cx_1_clks,
> +};
> +
>  static const struct clkgen_pll_data st_pll3200c32_407_a9 = {
>  	/* 407 A9 */
>  	.pdn_status	= CLKGEN_FIELD(0x1a8,	0x1,			0),
> @@ -104,6 +150,15 @@ static const struct clkgen_pll_data st_pll3200c32_407_a9 = {
>  	.ops		= &stm_pll3200c32_a9_ops,
>  };
>  
> +static const struct clkgen_clk_out st_pll3200c32_407_a9_clks[] = {
> +	{ .name = "clockgen-a9-pll-odf", },
> +};
> +
> +static const struct clkgen_pll_data_clks st_pll3200c32_407_a9_data = {
> +	.data		= (struct clkgen_pll_data *)&st_pll3200c32_407_a9,
> +	.outputs	= st_pll3200c32_407_a9_clks,
> +};
> +
>  static struct clkgen_pll_data st_pll4600c28_418_a9 = {
>  	/* 418 A9 */
>  	.pdn_status	= CLKGEN_FIELD(0x1a8,	0x1,			0),
> @@ -120,6 +175,15 @@ static struct clkgen_pll_data st_pll4600c28_418_a9 = {
>  	.ops		= &stm_pll4600c28_ops,
>  };
>  
> +static const struct clkgen_clk_out st_pll4600c28_418_a9_clks[] = {
> +	{ .name = "clockgen-a9-pll-odf", },
> +};
> +
> +static const struct clkgen_pll_data_clks st_pll4600c28_418_a9_data = {
> +	.data		= (struct clkgen_pll_data *)&st_pll4600c28_418_a9,
> +	.outputs	= st_pll4600c28_418_a9_clks,
> +};
> +
>  /**
>   * DOC: Clock Generated by PLL, rate set and enabled by bootloader
>   *
> @@ -684,7 +748,7 @@ static struct clk * __init clkgen_odf_register(const char *parent_name,
>  
>  
>  static void __init clkgen_c32_pll_setup(struct device_node *np,
> -		struct clkgen_pll_data *data)
> +		struct clkgen_pll_data_clks *datac)
>  {
>  	struct clk *clk;
>  	const char *parent_name, *pll_name;
> @@ -704,14 +768,14 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
>  
>  	of_clk_detect_critical(np, 0, &pll_flags);
>  
> -	clk = clkgen_pll_register(parent_name, data, pll_base, pll_flags,
> -				  np->name, data->lock);
> +	clk = clkgen_pll_register(parent_name, datac->data, pll_base, pll_flags,
> +				  np->name, datac->data->lock);
>  	if (IS_ERR(clk))
>  		return;
>  
>  	pll_name = __clk_get_name(clk);
>  
> -	num_odfs = data->num_odfs;
> +	num_odfs = datac->data->num_odfs;
>  
>  	clk_data = kzalloc(sizeof(*clk_data), GFP_KERNEL);
>  	if (!clk_data)
> @@ -729,14 +793,21 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
>  		const char *clk_name;
>  		unsigned long odf_flags = 0;
>  
> -		if (of_property_read_string_index(np, "clock-output-names",
> -						  odf, &clk_name))
> -			return;
> +		if (datac->outputs) {
> +			clk_name = datac->outputs[odf].name;
> +			odf_flags = datac->outputs[odf].flags;
> +		} else {
> +			if (of_property_read_string_index(np,
> +							  "clock-output-names",
> +							  odf, &clk_name))
> +				return;
>  
> -		of_clk_detect_critical(np, odf, &odf_flags);
> +			of_clk_detect_critical(np, odf, &odf_flags);
> +		}
>  
> -		clk = clkgen_odf_register(pll_name, pll_base, data, odf_flags,
> -				odf, &clkgena_c32_odf_lock, clk_name);
> +		clk = clkgen_odf_register(pll_name, pll_base, datac->data,
> +				odf_flags, odf, &clkgena_c32_odf_lock,
> +				clk_name);
>  		if (IS_ERR(clk))
>  			goto err;
>  
> @@ -754,27 +825,48 @@ static void __init clkgen_c32_pll_setup(struct device_node *np,
>  static void __init clkgen_c32_pll0_setup(struct device_node *np)
>  {
>  	clkgen_c32_pll_setup(np,
> -			(struct clkgen_pll_data *) &st_pll3200c32_cx_0);
> +		(struct clkgen_pll_data_clks *) &st_pll3200c32_cx_0_legacy_data);
>  }
>  CLK_OF_DECLARE(c32_pll0, "st,clkgen-pll0", clkgen_c32_pll0_setup);
>  
> +static void __init clkgen_c32_pll0_a0_setup(struct device_node *np)
> +{
> +	clkgen_c32_pll_setup(np,
> +		(struct clkgen_pll_data_clks *) &st_pll3200c32_a0_data);
> +}
> +CLK_OF_DECLARE(c32_pll0_a0, "st,clkgen-pll0-a0", clkgen_c32_pll0_a0_setup);
> +
> +static void __init clkgen_c32_pll0_c0_setup(struct device_node *np)
> +{
> +	clkgen_c32_pll_setup(np,
> +		(struct clkgen_pll_data_clks *) &st_pll3200c32_c0_data);
> +}
> +CLK_OF_DECLARE(c32_pll0_c0, "st,clkgen-pll0-c0", clkgen_c32_pll0_c0_setup);
> +
>  static void __init clkgen_c32_pll1_setup(struct device_node *np)
>  {
>  	clkgen_c32_pll_setup(np,
> -			(struct clkgen_pll_data *) &st_pll3200c32_cx_1);
> +		(struct clkgen_pll_data_clks *) &st_pll3200c32_cx_1_legacy_data);
>  }
>  CLK_OF_DECLARE(c32_pll1, "st,clkgen-pll1", clkgen_c32_pll1_setup);
>  
> +static void __init clkgen_c32_pll1_c0_setup(struct device_node *np)
> +{
> +	clkgen_c32_pll_setup(np,
> +		(struct clkgen_pll_data_clks *) &st_pll3200c32_c1_data);
> +}
> +CLK_OF_DECLARE(c32_pll1_c0, "st,clkgen-pll1-c0", clkgen_c32_pll1_c0_setup);
> +
>  static void __init clkgen_c32_plla9_setup(struct device_node *np)
>  {
>  	clkgen_c32_pll_setup(np,
> -			(struct clkgen_pll_data *) &st_pll3200c32_407_a9);
> +		(struct clkgen_pll_data_clks *) &st_pll3200c32_407_a9_data);
>  }
>  CLK_OF_DECLARE(c32_plla9, "st,stih407-clkgen-plla9", clkgen_c32_plla9_setup);
>  
>  static void __init clkgen_c28_plla9_setup(struct device_node *np)
>  {
>  	clkgen_c32_pll_setup(np,
> -			(struct clkgen_pll_data *) &st_pll4600c28_418_a9);
> +		(struct clkgen_pll_data_clks *) &st_pll4600c28_418_a9_data);
>  }
>  CLK_OF_DECLARE(c28_plla9, "st,stih418-clkgen-plla9", clkgen_c28_plla9_setup);
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
