Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711BD439571
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 13:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhJYMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhJYMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 08:01:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4857EC061745
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 04:59:18 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1meydF-0007zT-Ky; Mon, 25 Oct 2021 13:59:13 +0200
Subject: Re: [PATCH V2] clk: imx: gate off peripheral clock slice
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        mturquette@baylibre.com, abel.vesa@nxp.com, s.hauer@pengutronix.de
Cc:     Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20211025122902.1151-1-peng.fan@oss.nxp.com>
 <fc1ac63d-30c3-f309-7631-212ffa3f9de0@pengutronix.de>
Message-ID: <3eda3c8b-636b-9b83-a2f5-434fd2bdc832@pengutronix.de>
Date:   Mon, 25 Oct 2021 13:59:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <fc1ac63d-30c3-f309-7631-212ffa3f9de0@pengutronix.de>
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

On 25.10.21 13:54, Ahmad Fatoum wrote:
> On 25.10.21 14:29, Peng Fan (OSS) wrote:
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
>>
>> Fixes: d3ff9728134e ("clk: imx: Add imx composite clock")
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> 
> I've been running an i.MX8MM-based system with this patch for a few days
> so far and no apparent issues:
> 
> Tested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>

I see now that the duration of test isn't as important as the number
of boots (as this is a probe-time change). Still, I booted it a dozen
or so times and didn't notice anything different.

> 
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
>>  	}
>>  
>>  	div->lock = &imx_ccm_lock;
>>
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
