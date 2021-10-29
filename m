Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFCB44008C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 18:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhJ2Qt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 12:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhJ2Qtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 12:49:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AC7C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 09:47:26 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mgV2I-0005zT-3l; Fri, 29 Oct 2021 18:47:22 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH V2] clk: imx: gate off peripheral clock slice
To:     Abel Vesa <abel.vesa@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Peng Fan <peng.fan@nxp.com>, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
References: <20211025122902.1151-1-peng.fan@oss.nxp.com>
 <YXaeOa9CsT3cd/u+@ryzen>
Message-ID: <d3fd4bdf-6e3d-7752-dcc2-293fc5e6f469@pengutronix.de>
Date:   Fri, 29 Oct 2021 18:47:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YXaeOa9CsT3cd/u+@ryzen>
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

Hello Peng, Abel,

On 25.10.21 14:08, Abel Vesa wrote:
> On 21-10-25 20:29:02, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> The Peripheral clocks are default enabled when SoC power on, and
>> bootloader not gate off the clocks when booting Linux Kernel.
>>
>> So Linux Kernel is not aware the peripheral clocks are enabled and
>> still take them as disabled because of enable count is zero.
>>
>> Then Peripheral clock's source without clock gated off could be
>> changed when have assigned-parents in device tree
>>
>> However, per i.MX8M* reference mannual, "Peripheral clock slices must
>> be stopped to change the clock source", so need to gate off the
>> the peripheral clock when registering the clocks to avoid glitch.
>>
>> Tested boot on i.MX8MM/P-EVK board

I just noticed this breaks earlycon on an i.MX8MN, I assume because
the earlycon driver will access unclocked registers.

On the i.MX8MN, I also noticed that disabling usb_phy_ref hangs the
system, whether via sysfs or via this patch. Still trying to figure
that one out.

Cheers,
Ahmad

>> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>
>> V2:
>>  Add Fixes tag
>>
>>  drivers/clk/imx/clk-composite-8m.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-composite-8m.c
>> index 2dfd6149e528..ee41fbf90589 100644
>> --- a/drivers/clk/imx/clk-composite-8m.c
>> +++ b/drivers/clk/imx/clk-composite-8m.c
>> @@ -184,6 +184,7 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>>  	struct clk_mux *mux = NULL;
>>  	const struct clk_ops *divider_ops;
>>  	const struct clk_ops *mux_ops;
>> +	u32 val;
>>  
>>  	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
>>  	if (!mux)
>> @@ -216,8 +217,14 @@ struct clk_hw *__imx8m_clk_hw_composite(const char *name,
>>  		div->width = PCG_PREDIV_WIDTH;
>>  		divider_ops = &imx8m_clk_composite_divider_ops;
>>  		mux_ops = &clk_mux_ops;
>> -		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED))
>> +		if (!(composite_flags & IMX_COMPOSITE_FW_MANAGED)) {
>>  			flags |= CLK_SET_PARENT_GATE;
>> +			if (!(flags & CLK_IS_CRITICAL)) {
>> +				val = readl(reg);
>> +				val &= ~BIT(PCG_CGC_SHIFT);
>> +				writel(val, reg);
>> +			}
>> +		}
> 
> Though I'm usually against special cases like this one. I think the clock
> core needs some generic flag that would read the state from HW on probe
> and/or another generic flag for disabling on probe.
> 
> But for now, I'm OK with this:
> 
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> 
>>  	}
>>  
>>  	div->lock = &imx_ccm_lock;
>> -- 
>> 2.30.0
>>
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
