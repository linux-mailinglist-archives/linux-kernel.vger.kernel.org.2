Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D785D3F080A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238689AbhHRP3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238837AbhHRP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:29:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC0CC0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:28:45 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mGNUh-0004Wz-Dq; Wed, 18 Aug 2021 17:28:43 +0200
Subject: Re: [PATCH] clk: imx8m: fix clock tree update of TF-A managed clocks
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20210810151432.9228-1-a.fatoum@pengutronix.de>
 <YR0j21KspR618YLK@ryzen>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <93de171b-a4d3-e1da-a5e0-4c50e7a97c5d@pengutronix.de>
Date:   Wed, 18 Aug 2021 17:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YR0j21KspR618YLK@ryzen>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Abel,

On 18.08.21 17:14, Abel Vesa wrote:
> On 21-08-10 17:14:33, Ahmad Fatoum wrote:
>> On the i.MX8M*, the TF-A exposes a SiP (Silicon Provider) service
>> for DDR frequency scaling. The imx8m-ddrc-devfreq driver calls the
>> SiP and then does clk_set_parent on the DDR muxes to synchronize
>> the clock tree.
>>
>> Since 936c383673b9 ("clk: imx: fix composite peripheral flags"),
>> these TF-A managed muxes have SET_PARENT_GATE set, which results
>> in imx8m-ddrc-devfreq's clk_set_parent after SiP failing with -EBUSY:
>>
>> 	echo 25000000 > userspace/set_freq
>> 	imx8m-ddrc-devfreq 3d400000.memory-controller: failed to set
>> 		dram_apb parent: -16
>>
>> Fix this by adding a new i.MX composite flag for firmware managed
>> clocks, which clears SET_PARENT_GATE.
>>
>> This is safe to do, because updating the Linux clock tree to reflect
>> reality will always be glitch-free.
>>
>> Fixes: 936c383673b9 ("clk: imx: fix composite peripheral flags")
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> I'm OK with this.
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

Thanks for the review.

> BTW, let me know if you are interested in the interconnect+devfreq
> (the replacement for NXP's internal busfreq). I have a new version of
> that patchset which I intend to send soon for review.

Ye, add me to CC and I'll give it at least a test. It sounds like you
recently worked with devfreq? I am wondering why you didn't run into this issue.

Cheers,
Ahmad

> 
>> ---
>> To: Abel Vesa <abel.vesa@nxp.com>
>> To: Michael Turquette <mturquette@baylibre.com>
>> To: Stephen Boyd <sboyd@kernel.org>
>> To: Shawn Guo <shawnguo@kernel.org>
>> To: Sascha Hauer <s.hauer@pengutronix.de>
>> To: Pengutronix Kernel Team <kernel@pengutronix.de>
>> To: Fabio Estevam <festevam@gmail.com>
>> To: NXP Linux Team <linux-imx@nxp.com>
>> To: Peng Fan <peng.fan@nxp.com>
>> To: Leonard Crestez <leonard.crestez@nxp.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-clk@vger.kernel.org
>> ---
>>  drivers/clk/imx/clk-composite-8m.c |  3 ++-
>>  drivers/clk/imx/clk-imx8mm.c       |  7 ++++---
>>  drivers/clk/imx/clk-imx8mn.c       |  7 ++++---
>>  drivers/clk/imx/clk-imx8mq.c       |  7 ++++---
>>  drivers/clk/imx/clk.h              | 16 ++++++++++++++--
>>  5 files changed, 28 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
>> index 2c309e3dc8e3..04e728538cef 100644
>> --- a/drivers/clk/imx/clk-composite-8m.c
>> +++ b/drivers/clk/imx/clk-composite-8m.c
>> @@ -216,7 +216,8 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>>  		div->width = PCG_PREDIV_WIDTH;
>>  		divider_ops = &imx8m_clk_composite_divider_ops;
>>  		mux_ops = &clk_mux_ops;
>> -		flags |= CLK_SET_PARENT_GATE;
>> +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
>> +			flags |= CLK_SET_PARENT_GATE;
>>  	}
>>  
>>  	div->lock = &imx_ccm_lock;
>> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
>> index f1919fafb124..73cc9805ec59 100644
>> --- a/drivers/clk/imx/clk-imx8mm.c
>> +++ b/drivers/clk/imx/clk-imx8mm.c
>> @@ -470,10 +470,11 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
>>  
>>  	/*
>>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
>> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
>> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
>> +	 * as div value should always be read from hardware
>>  	 */
>> -	hws[IMX8MM_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
>> -	hws[IMX8MM_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mm_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
>> +	hws[IMX8MM_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mm_dram_alt_sels, base + 0xa000);
>> +	hws[IMX8MM_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mm_dram_apb_sels, base + 0xa080);
>>  
>>  	/* IP */
>>  	hws[IMX8MM_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mm_vpu_g1_sels, base + 0xa100);
>> diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
>> index 88f6630cd472..0a76f969b28b 100644
>> --- a/drivers/clk/imx/clk-imx8mn.c
>> +++ b/drivers/clk/imx/clk-imx8mn.c
>> @@ -453,10 +453,11 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
>>  
>>  	/*
>>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
>> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
>> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
>> +	 * as div value should always be read from hardware
>>  	 */
>> -	hws[IMX8MN_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
>> -	hws[IMX8MN_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mn_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
>> +	hws[IMX8MN_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mn_dram_alt_sels, base + 0xa000);
>> +	hws[IMX8MN_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mn_dram_apb_sels, base + 0xa080);
>>  
>>  	hws[IMX8MN_CLK_DISP_PIXEL] = imx8m_clk_hw_composite("disp_pixel", imx8mn_disp_pixel_sels, base + 0xa500);
>>  	hws[IMX8MN_CLK_SAI2] = imx8m_clk_hw_composite("sai2", imx8mn_sai2_sels, base + 0xa600);
>> diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
>> index c491bc9c61ce..83cc2b1c3294 100644
>> --- a/drivers/clk/imx/clk-imx8mq.c
>> +++ b/drivers/clk/imx/clk-imx8mq.c
>> @@ -449,11 +449,12 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
>>  
>>  	/*
>>  	 * DRAM clocks are manipulated from TF-A outside clock framework.
>> -	 * Mark with GET_RATE_NOCACHE to always read div value from hardware
>> +	 * The fw_managed helper sets GET_RATE_NOCACHE and clears SET_PARENT_GATE
>> +	 * as div value should always be read from hardware
>>  	 */
>>  	hws[IMX8MQ_CLK_DRAM_CORE] = imx_clk_hw_mux2_flags("dram_core_clk", base + 0x9800, 24, 1, imx8mq_dram_core_sels, ARRAY_SIZE(imx8mq_dram_core_sels), CLK_IS_CRITICAL);
>> -	hws[IMX8MQ_CLK_DRAM_ALT] = __imx8m_clk_hw_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000, CLK_GET_RATE_NOCACHE);
>> -	hws[IMX8MQ_CLK_DRAM_APB] = __imx8m_clk_hw_composite("dram_apb", imx8mq_dram_apb_sels, base + 0xa080, CLK_IS_CRITICAL | CLK_GET_RATE_NOCACHE);
>> +	hws[IMX8MQ_CLK_DRAM_ALT] = imx8m_clk_hw_fw_managed_composite("dram_alt", imx8mq_dram_alt_sels, base + 0xa000);
>> +	hws[IMX8MQ_CLK_DRAM_APB] = imx8m_clk_hw_fw_managed_composite_critical("dram_apb", imx8mq_dram_apb_sels, base + 0xa080);
>>  
>>  	/* IP */
>>  	hws[IMX8MQ_CLK_VPU_G1] = imx8m_clk_hw_composite("vpu_g1", imx8mq_vpu_g1_sels, base + 0xa100);
>> diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
>> index 7571603bee23..e144f983fd8c 100644
>> --- a/drivers/clk/imx/clk.h
>> +++ b/drivers/clk/imx/clk.h
>> @@ -530,8 +530,9 @@ struct clk_hw *imx_clk_hw_cpu(const char *name, const char *parent_name,
>>  		struct clk *div, struct clk *mux, struct clk *pll,
>>  		struct clk *step);
>>  
>> -#define IMX_COMPOSITE_CORE	BIT(0)
>> -#define IMX_COMPOSITE_BUS	BIT(1)
>> +#define IMX_COMPOSITE_CORE		BIT(0)
>> +#define IMX_COMPOSITE_BUS		BIT(1)
>> +#define IMX_COMPOSITE_FW_MANAGED	BIT(2)
>>  
>>  struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>>  					    const char * const *parent_names,
>> @@ -567,6 +568,17 @@ struct clk_hw *imx8m_clk_hw_composite_flags(const char *name,
>>  		ARRAY_SIZE(parent_names), reg, 0, \
>>  		flags | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
>>  
>> +#define __imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, flags) \
>> +	imx8m_clk_hw_composite_flags(name, parent_names, \
>> +		ARRAY_SIZE(parent_names), reg, IMX_COMPOSITE_FW_MANAGED, \
>> +		flags | CLK_GET_RATE_NOCACHE | CLK_SET_RATE_NO_REPARENT | CLK_OPS_PARENT_ENABLE)
>> +
>> +#define imx8m_clk_hw_fw_managed_composite(name, parent_names, reg) \
>> +	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, 0)
>> +
>> +#define imx8m_clk_hw_fw_managed_composite_critical(name, parent_names, reg) \
>> +	__imx8m_clk_hw_fw_managed_composite(name, parent_names, reg, CLK_IS_CRITICAL)
>> +
>>  #define __imx8m_clk_composite(name, parent_names, reg, flags) \
>>  	to_clk(__imx8m_clk_hw_composite(name, parent_names, reg, flags))
>>  
>> -- 
>> 2.30.2
>>
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
