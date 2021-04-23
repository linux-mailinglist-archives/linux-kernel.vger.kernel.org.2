Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3104368D39
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 08:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240645AbhDWGia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 02:38:30 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:42808 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWGi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 02:38:29 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 13N6bWCt008041; Fri, 23 Apr 2021 15:37:32 +0900
X-Iguazu-Qid: 34trpShQIL3mJzL9dg
X-Iguazu-QSIG: v=2; s=0; t=1619159852; q=34trpShQIL3mJzL9dg; m=JcyYP3KROQ8IPtwGt4642etF122VhPv1oSBRnFeNGyA=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1510) id 13N6bTZU032573
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 15:37:30 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id AEFD5100123;
        Fri, 23 Apr 2021 15:37:29 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 13N6bTlV027483;
        Fri, 23 Apr 2021 15:37:29 +0900
From:   Punit Agrawal <punit1.agrawal@toshiba.co.jp>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jolly Shah <jolly.shah@xilinx.com>,
        Quanyang Wang <quanyang.wang@windriver.com>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: zynqmp: fix compile testing without ZYNQMP_FIRMWARE
References: <20210421134844.3297838-1-arnd@kernel.org>
        <871rb2swd9.fsf@kokedama.swc.toshiba.co.jp>
        <01e78b64-8ad1-dfc8-9fc0-6afff4841492@xilinx.com>
Date:   Fri, 23 Apr 2021 15:37:25 +0900
In-Reply-To: <01e78b64-8ad1-dfc8-9fc0-6afff4841492@xilinx.com> (Michal Simek's
        message of "Thu, 22 Apr 2021 12:54:00 +0200")
X-TSB-HOP: ON
Message-ID: <87v98dqzfe.fsf@kokedama.swc.toshiba.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Simek <michal.simek@xilinx.com> writes:

> Hi,
>
> On 4/22/21 7:48 AM, Punit Agrawal wrote:
>> Hi Arnd,
>> 
>> Thanks for the fix.
>> 
>> Arnd Bergmann <arnd@kernel.org> writes:
>> 
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> When the firmware code is disabled, the incomplete error handling
>>> in the clk driver causes compile-time warnings:
>>>
>>> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
>>> drivers/clk/zynqmp/pll.c:147:29: error: 'fbdiv' is used uninitialized [-Werror=uninitialized]
>>>   147 |         rate =  parent_rate * fbdiv;
>>>       |                 ~~~~~~~~~~~~^~~~~~~
>>> In function 'zynqmp_pll_get_mode',
>>>     inlined from 'zynqmp_pll_recalc_rate' at drivers/clk/zynqmp/pll.c:148:6:
>>> drivers/clk/zynqmp/pll.c:61:27: error: 'ret_payload' is used uninitialized [-Werror=uninitialized]
>>>    61 |         return ret_payload[1];
>>>       |                ~~~~~~~~~~~^~~
>>> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
>>> drivers/clk/zynqmp/pll.c:53:13: note: 'ret_payload' declared here
>>>    53 |         u32 ret_payload[PAYLOAD_ARG_CNT];
>>>       |             ^~~~~~~~~~~
>>> drivers/clk/zynqmp/clk-mux-zynqmp.c: In function 'zynqmp_clk_mux_get_parent':
>>> drivers/clk/zynqmp/clk-mux-zynqmp.c:57:16: error: 'val' is used uninitialized [-Werror=uninitialized]
>>>    57 |         return val;
>>>       |                ^~~
>> 
>> 
>> Not sure what I am missing but I couldn't reproduce these warnings. I
>> tried a few different ways to toggle CONFIG_ZYNQMP_FIRMWARE.
>> 
>> Regardless...
>
> Me too. Can you share your .config file?
>
>> 
>>> As it was apparently intentional to support this for compile testing
>>> purposes, change the code to have just enough error handling for the
>>> compiler to not notice the remaining bugs.
>>>
>>> Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/clk/zynqmp/clk-mux-zynqmp.c | 4 +++-
>>>  drivers/clk/zynqmp/pll.c            | 8 ++++++--
>>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
>>> index 06194149be83..2afded3c7c11 100644
>>> --- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
>>> +++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
>>> @@ -50,9 +50,11 @@ static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
>>>  
>>>  	ret = zynqmp_pm_clock_getparent(clk_id, &val);
>>>  
>>> -	if (ret)
>>> +	if (ret) {
>>>  		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
>>>  			     __func__, clk_name, ret);
>>> +		return ret;
>
> return should be u8 and this can be negative value. That's why I think
> this should be fixed differently and all users should be checked that it
> is handled like that.
>
>
>>> +	}
>>>  
>>>  	return val;
>>>  }
>>> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
>>> index abe6afbf3407..67d2a2d260c1 100644
>>> --- a/drivers/clk/zynqmp/pll.c
>>> +++ b/drivers/clk/zynqmp/pll.c
>>> @@ -54,9 +54,11 @@ static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
>>>  	int ret;
>>>  
>>>  	ret = zynqmp_pm_get_pll_frac_mode(clk_id, ret_payload);
>>> -	if (ret)
>>> +	if (ret) {
>>>  		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
>>>  			     __func__, clk_name, ret);
>>> +		return ret;
>>> +	}
>
> Return should be enum pll_mode which is 0 or 1 which is likely not done
> here.
>
>>>  
>>>  	return ret_payload[1];
>>>  }
>>> @@ -140,9 +142,11 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
>>>  	int ret;
>>>  
>>>  	ret = zynqmp_pm_clock_getdivider(clk_id, &fbdiv);
>>> -	if (ret)
>>> +	if (ret) {
>>>  		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
>>>  			     __func__, clk_name, ret);
>>> +		return -1ul;
>>> +	}
>
> Same here.
>
>
>>>  
>>>  	rate =  parent_rate * fbdiv;
>>>  	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
>> 
>> The changes make sense in that the functions error out sensibly when the
>> zynqmp firmware driver is not enabled.
>> 
>> Acked-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>
> I think code should be checked that these error values are handled how
> they should be handled.

I only looked at it from the point of view of getting rid of the
warnings - based on the commit log, Arnd's patch is only taking care of
the compiler warnings when the driver is built with
CONFIG_COMPILE_TEST=y and likely CONFIG_ZYNQMP_FIRMWARE=n.

In practice, the code should not be hit at runtime due to the dependency
on the firmware driver. Even then, a better fix would indeed be taking
the returned values at call sites into account.

[...]
