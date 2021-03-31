Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C628E35042F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhCaQJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 12:09:00 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57208 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233727AbhCaQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 12:08:45 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12VG3Pdb009583;
        Wed, 31 Mar 2021 18:08:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=oKoyF9170/Sw3fRKhbwfHK7hcm7iCrqivE11drJszh4=;
 b=eaEuOfKW5QWqD2NBf+ON1hwMhH6KpMM5PHzYV98IVh1xWzQ5zjU/qUeuARRdOqtXRewX
 JYUugI/6FjQbOqs/aH+mdlAyzLAqmsT4z0840FvLy6xrmRqkbsIpyh4V940OONIE31Sl
 GDFryBlzI4EHbhLLfa/DVCj3gtTsRKPpd9UtmZmOu18zOl1UrVALO3Rz+vjVJJPEM81b
 bhamGZmsgS9daXwyj43papb8QAbJJmfehg+03sWHCHQNaUuEBXuDnr//WYbsM8RO8cSK
 UhLcGfkOB2+Z0SMVDxlRIqA9BLPSkKXmqNBH34xQSupXpqIKbwIWhh1V5+zgddaK0qfe uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37maamwtj8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 Mar 2021 18:08:35 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EB66D10002A;
        Wed, 31 Mar 2021 18:08:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D9D3F21CA7E;
        Wed, 31 Mar 2021 18:08:34 +0200 (CEST)
Received: from lmecxl0573.lme.st.com (10.75.127.50) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 31 Mar
 2021 18:08:34 +0200
Subject: Re: [PATCH v3 6/7] clk: st: clkgen-fsyn: embed soc clock outputs
 within compatible data
To:     Alain Volmat <avolmat@me.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210330205125.25708-1-avolmat@me.com>
 <20210330205125.25708-7-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
Message-ID: <f2bbb7a2-a36e-5357-feb3-487d0b43989a@foss.st.com>
Date:   Wed, 31 Mar 2021 18:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210330205125.25708-7-avolmat@me.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-31_08:2021-03-31,2021-03-31 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 3/30/21 10:51 PM, Alain Volmat wrote:
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
> v2: clk-s-c0-fs0-ch0 do not need to be CLK_IS_CRITICAL
> 
>  drivers/clk/st/clkgen-fsyn.c | 113 +++++++++++++++++++++++++++++++----
>  1 file changed, 101 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
> index dd6062e043e0..164285d6be97 100644
> --- a/drivers/clk/st/clkgen-fsyn.c
> +++ b/drivers/clk/st/clkgen-fsyn.c
> @@ -66,6 +66,16 @@ struct clkgen_quadfs_data {
>  			unsigned long *);
>  };
>  
> +struct clkgen_clk_out {
> +	const char *name;
> +	unsigned long flags;
> +};
> +
> +struct clkgen_quadfs_data_clks {
> +	struct clkgen_quadfs_data *data;
> +	const struct clkgen_clk_out *outputs;
> +};
> +
>  static const struct clk_ops st_quadfs_pll_c32_ops;
>  
>  static int clk_fs660c32_dig_get_params(unsigned long input,
> @@ -115,6 +125,18 @@ static const struct clkgen_quadfs_data st_fs660c32_C = {
>  	.get_rate	= clk_fs660c32_dig_get_rate,
>  };
>  
> +static const struct clkgen_clk_out st_fs660c32_C_clks[] = {
> +	{ .name = "clk-s-c0-fs0-ch0",	},
> +	{ .name = "clk-s-c0-fs0-ch1",	},
> +	{ .name = "clk-s-c0-fs0-ch2",	},
> +	{ .name = "clk-s-c0-fs0-ch3",	},
> +};
> +
> +static const struct clkgen_quadfs_data_clks st_fs660c32_C_data = {
> +	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_C,
> +	.outputs	= st_fs660c32_C_clks,
> +};
> +
>  static const struct clkgen_quadfs_data st_fs660c32_D = {
>  	.nrst_present = true,
>  	.nrst	= { CLKGEN_FIELD(0x2a0, 0x1, 0),
> @@ -156,6 +178,46 @@ static const struct clkgen_quadfs_data st_fs660c32_D = {
>  	.get_params	= clk_fs660c32_dig_get_params,
>  	.get_rate	= clk_fs660c32_dig_get_rate,};
>  
> +static const struct clkgen_quadfs_data_clks st_fs660c32_D_data = {
> +	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
> +};
> +
> +static const struct clkgen_clk_out st_fs660c32_D0_clks[] = {
> +	{ .name = "clk-s-d0-fs0-ch0",	},
> +	{ .name = "clk-s-d0-fs0-ch1",	},
> +	{ .name = "clk-s-d0-fs0-ch2",	},
> +	{ .name = "clk-s-d0-fs0-ch3",	},
> +};
> +
> +static const struct clkgen_quadfs_data_clks st_fs660c32_D0_data = {
> +	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
> +	.outputs	= st_fs660c32_D0_clks,
> +};
> +
> +static const struct clkgen_clk_out st_fs660c32_D2_clks[] = {
> +	{ .name = "clk-s-d2-fs0-ch0",	},
> +	{ .name = "clk-s-d2-fs0-ch1",	},
> +	{ .name = "clk-s-d2-fs0-ch2",	},
> +	{ .name = "clk-s-d2-fs0-ch3",	},
> +};
> +
> +static const struct clkgen_quadfs_data_clks st_fs660c32_D2_data = {
> +	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
> +	.outputs	= st_fs660c32_D2_clks,
> +};
> +
> +static const struct clkgen_clk_out st_fs660c32_D3_clks[] = {
> +	{ .name = "clk-s-d3-fs0-ch0",	},
> +	{ .name = "clk-s-d3-fs0-ch1",	},
> +	{ .name = "clk-s-d3-fs0-ch2",	},
> +	{ .name = "clk-s-d3-fs0-ch3",	},
> +};
> +
> +static const struct clkgen_quadfs_data_clks st_fs660c32_D3_data = {
> +	.data	= (struct clkgen_quadfs_data *)&st_fs660c32_D,
> +	.outputs	= st_fs660c32_D3_clks,
> +};
> +
>  /**
>   * DOC: A Frequency Synthesizer that multiples its input clock by a fixed factor
>   *
> @@ -857,7 +919,7 @@ static struct clk * __init st_clk_register_quadfs_fsynth(
>  
>  static void __init st_of_create_quadfs_fsynths(
>  		struct device_node *np, const char *pll_name,
> -		struct clkgen_quadfs_data *quadfs, void __iomem *reg,
> +		struct clkgen_quadfs_data_clks *quadfs, void __iomem *reg,
>  		spinlock_t *lock)
>  {
>  	struct clk_onecell_data *clk_data;
> @@ -881,9 +943,15 @@ static void __init st_of_create_quadfs_fsynths(
>  		const char *clk_name;
>  		unsigned long flags = 0;
>  
> -		if (of_property_read_string_index(np, "clock-output-names",
> -						  fschan, &clk_name)) {
> -			break;
> +		if (quadfs->outputs) {
> +			clk_name = quadfs->outputs[fschan].name;
> +			flags = quadfs->outputs[fschan].flags;
> +		} else {
> +			if (of_property_read_string_index(np,
> +							"clock-output-names",
> +							fschan, &clk_name))
> +				break;
> +			of_clk_detect_critical(np, fschan, &flags);
>  		}
>  
>  		/*
> @@ -892,10 +960,8 @@ static void __init st_of_create_quadfs_fsynths(
>  		if (*clk_name == '\0')
>  			continue;
>  
> -		of_clk_detect_critical(np, fschan, &flags);
> -
>  		clk = st_clk_register_quadfs_fsynth(clk_name, pll_name,
> -						    quadfs, reg, fschan,
> +						    quadfs->data, reg, fschan,
>  						    flags, lock);
>  
>  		/*
> @@ -915,7 +981,7 @@ static void __init st_of_create_quadfs_fsynths(
>  }
>  
>  static void __init st_of_quadfs_setup(struct device_node *np,
> -		struct clkgen_quadfs_data *data)
> +		struct clkgen_quadfs_data_clks *datac)
>  {
>  	struct clk *clk;
>  	const char *pll_name, *clk_parent_name;
> @@ -940,7 +1006,7 @@ static void __init st_of_quadfs_setup(struct device_node *np,
>  
>  	spin_lock_init(lock);
>  
> -	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name, data,
> +	clk = st_clk_register_quadfs_pll(pll_name, clk_parent_name, datac->data,
>  			reg, lock);
>  	if (IS_ERR(clk))
>  		goto err_exit;
> @@ -950,7 +1016,7 @@ static void __init st_of_quadfs_setup(struct device_node *np,
>  			__clk_get_name(clk_get_parent(clk)),
>  			(unsigned int)clk_get_rate(clk));
>  
> -	st_of_create_quadfs_fsynths(np, pll_name, data, reg, lock);
> +	st_of_create_quadfs_fsynths(np, pll_name, datac, reg, lock);
>  
>  err_exit:
>  	kfree(pll_name); /* No longer need local copy of the PLL name */
> @@ -958,12 +1024,35 @@ static void __init st_of_quadfs_setup(struct device_node *np,
>  
>  static void __init st_of_quadfs660C_setup(struct device_node *np)
>  {
> -	st_of_quadfs_setup(np, (struct clkgen_quadfs_data *) &st_fs660c32_C);
> +	st_of_quadfs_setup(np,
> +		(struct clkgen_quadfs_data_clks *) &st_fs660c32_C_data);
>  }
>  CLK_OF_DECLARE(quadfs660C, "st,quadfs-pll", st_of_quadfs660C_setup);
>  
>  static void __init st_of_quadfs660D_setup(struct device_node *np)
>  {
> -	st_of_quadfs_setup(np, (struct clkgen_quadfs_data *) &st_fs660c32_D);
> +	st_of_quadfs_setup(np,
> +		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D_data);
>  }
>  CLK_OF_DECLARE(quadfs660D, "st,quadfs", st_of_quadfs660D_setup);
> +
> +static void __init st_of_quadfs660D0_setup(struct device_node *np)
> +{
> +	st_of_quadfs_setup(np,
> +		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D0_data);
> +}
> +CLK_OF_DECLARE(quadfs660D0, "st,quadfs-d0", st_of_quadfs660D0_setup);
> +
> +static void __init st_of_quadfs660D2_setup(struct device_node *np)
> +{
> +	st_of_quadfs_setup(np,
> +		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D2_data);
> +}
> +CLK_OF_DECLARE(quadfs660D2, "st,quadfs-d2", st_of_quadfs660D2_setup);
> +
> +static void __init st_of_quadfs660D3_setup(struct device_node *np)
> +{
> +	st_of_quadfs_setup(np,
> +		(struct clkgen_quadfs_data_clks *) &st_fs660c32_D3_data);
> +}
> +CLK_OF_DECLARE(quadfs660D3, "st,quadfs-d3", st_of_quadfs660D3_setup);
> 

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
