Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9E31A0AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhBLOeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:34:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229580AbhBLOeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:34:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A9E664E3D;
        Fri, 12 Feb 2021 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613140399;
        bh=xn8eIL2QPali4UJ82x4MM/cPK1TOo8yaggTJVLNOc8k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NJB9/6CbYmHvpYGtgJcLCuwkQLRAsFc3q3MGcO4J+dDu/aVcrES/BAYJYHHlaJ71m
         htRTJ3bfJwzoe1tz8AOjVJTgaZ9moTOcw9eeQaVM6fkDsrPSFBWJm3HmAx597p6Q3Y
         DzBWRoZ4jwFx6mo9cFJFCVuyWf08WQd8PHYxNVnMxz5l3Xfb3M2HY/zMKYz+f7hFF7
         o1qVOjefMfnlLU//0KtUKemGlL7+ZSTm0YUPloADul/yWu0h9GfAcezDM0RW/oacyS
         59uk3CFlJVlAf1N2U/3VSdn9Qk3BG/6LmpqhwC9n+ayKLkYmVfXZdDaq1+j2dOnYxF
         IWehZgKIQxQ8A==
Subject: Re: [PATCH] clk: socfpga: agilex: add clock driver for eASIC N5X
 platform
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210105192956.2059505-1-dinguyen@kernel.org>
 <161301273585.1254594.15922396130376508467@swboyd.mtv.corp.google.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <2131f1b9-6929-9b28-1d82-7e55e6abf6ba@kernel.org>
Date:   Fri, 12 Feb 2021 08:33:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <161301273585.1254594.15922396130376508467@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/21 9:05 PM, Stephen Boyd wrote:
> Quoting Dinh Nguyen (2021-01-05 11:29:56)
>> Add support for Intel's eASIC N5X platform. The clock manager driver for
>> the N5X is very similar to the Agilex platform, we can re-use most of
>> the Agilex clock driver.
>>
>> This patch makes the necessary changes for the driver to differentiate
>> between the Agilex and the N5X platforms.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
>> ---
> 
> Sorry this patch fell off my radar.
> 
> I ran checkpatch
> 
> WARNING: function definition argument 'struct platform_device *' should also have an identifier name
> #135: FILE: drivers/clk/socfpga/clk-agilex.c:500:
> +       int (*probe_func)(struct platform_device *);
> 
> WARNING: Statements terminations use 1 semicolon
> #140: FILE: drivers/clk/socfpga/clk-agilex.c:505:
> +       return  probe_func(pdev);;
> 
> WARNING: DT compatible string "intel,n5x-clkmgr" appears un-documented -- check ./Documentation/devicetree/bindings/
> #147: FILE: drivers/clk/socfpga/clk-agilex.c:511:
> +       { .compatible = "intel,n5x-clkmgr",
> 
> WARNING: struct clk_ops should normally be const
> #290: FILE: drivers/clk/socfpga/clk-pll-s10.c:166:
> +static struct clk_ops n5x_clk_pll_ops = {
> 
> WARNING: struct clk_ops should normally be const
> #296: FILE: drivers/clk/socfpga/clk-pll-s10.c:172:
> +static struct clk_ops agilex_clk_pll_ops = {
> 
> WARNING: function definition argument 'const struct stratix10_pll_clock *' should also have an identifier name
> #367: FILE: drivers/clk/socfpga/stratix10-clk.h:78:
> +struct clk *n5x_register_pll(const struct stratix10_pll_clock *,
> 
> WARNING: function definition argument 'void __iomem *' should also have an identifier name
> #367: FILE: drivers/clk/socfpga/stratix10-clk.h:78:
> +struct clk *n5x_register_pll(const struct stratix10_pll_clock *,
> 
> WARNING: function definition argument 'const struct n5x_perip_c_clock *' should also have an identifier name
> #371: FILE: drivers/clk/socfpga/stratix10-clk.h:82:
> +struct clk *n5x_register_periph(const struct n5x_perip_c_clock *,
> 
> WARNING: function definition argument 'void __iomem *' should also have an identifier name
> #371: FILE: drivers/clk/socfpga/stratix10-clk.h:82:
> +struct clk *n5x_register_periph(const struct n5x_perip_c_clock *,
> 
> Can you fix these up and resend?
> 
>>   drivers/clk/socfpga/clk-agilex.c     | 88 +++++++++++++++++++++++++++-
>>   drivers/clk/socfpga/clk-periph-s10.c | 53 +++++++++++++++++
>>   drivers/clk/socfpga/clk-pll-s10.c    | 85 ++++++++++++++++++++++++++-
>>   drivers/clk/socfpga/stratix10-clk.h  | 15 +++++
>>   4 files changed, 238 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clk/socfpga/clk-periph-s10.c b/drivers/clk/socfpga/clk-periph-s10.c
>> index 397b77b89b16..135581c41c05 100644
>> --- a/drivers/clk/socfpga/clk-periph-s10.c
>> +++ b/drivers/clk/socfpga/clk-periph-s10.c
>> @@ -15,6 +15,21 @@
>>   
>>   #define to_periph_clk(p) container_of(p, struct socfpga_periph_clk, hw.hw)
>>   
>> +static unsigned long n5x_clk_peri_c_clk_recalc_rate(struct clk_hw *hwclk,
>> +                                            unsigned long parent_rate)
>> +{
>> +       struct socfpga_periph_clk *socfpgaclk = to_periph_clk(hwclk);
>> +       unsigned long div;
>> +       unsigned long shift = socfpgaclk->shift;
>> +       u32 val;
>> +
>> +       val = readl(socfpgaclk->hw.reg);
>> +       val &= (0x1F << shift);
> 
> Prefer lowercase hex.
> 
>> +       div = (val >> shift) + 1;
>> +
>> +       return parent_rate / div;
>> +}
>> +
>>   static unsigned long clk_peri_c_clk_recalc_rate(struct clk_hw *hwclk,
>>                                               unsigned long parent_rate)
>>   {
>> @@ -63,6 +78,11 @@ static u8 clk_periclk_get_parent(struct clk_hw *hwclk)
>>          return parent;
>>   }
>>   
>> +static const struct clk_ops n5x_peri_c_clk_ops = {
>> +       .recalc_rate = n5x_clk_peri_c_clk_recalc_rate,
>> +       .get_parent = clk_periclk_get_parent,
>> +};
>> +
>>   static const struct clk_ops peri_c_clk_ops = {
>>          .recalc_rate = clk_peri_c_clk_recalc_rate,
>>          .get_parent = clk_periclk_get_parent,
>> @@ -107,6 +127,39 @@ struct clk *s10_register_periph(const struct stratix10_perip_c_clock *clks,
>>          return clk;
>>   }
>>   
>> +struct clk *n5x_register_periph(const struct n5x_perip_c_clock *clks,
>> +                               void __iomem *regbase)
>> +{
>> +       struct clk *clk;
>> +       struct socfpga_periph_clk *periph_clk;
>> +       struct clk_init_data init;
>> +       const char *name = clks->name;
>> +       const char *parent_name = clks->parent_name;
>> +
>> +       periph_clk = kzalloc(sizeof(*periph_clk), GFP_KERNEL);
>> +       if (WARN_ON(!periph_clk))
>> +               return NULL;
>> +
>> +       periph_clk->hw.reg = regbase + clks->offset;
>> +       periph_clk->shift = clks->shift;
>> +
>> +       init.name = name;
>> +       init.ops = &n5x_peri_c_clk_ops;
>> +       init.flags = clks->flags;
>> +
>> +       init.num_parents = clks->num_parents;
>> +       init.parent_names = parent_name ? &parent_name : NULL;
>> +
>> +       periph_clk->hw.hw.init = &init;
>> +
>> +       clk = clk_register(NULL, &periph_clk->hw.hw);
> 
> Can you use clk_hw_register?
> 

Thanks for the review. If you don't mind, changing this to use 
clk_hw_register will need a few modifications to the driver, I'd like to 
submit that in a separate patch series after this.

Thanks,
Dinh
