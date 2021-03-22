Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB603440C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 13:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhCVMVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 08:21:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229933AbhCVMVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 08:21:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 40A946198B;
        Mon, 22 Mar 2021 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616415672;
        bh=80YmYN0VUetsLlX0A6XnYg0BZUOx/dDSaKDFcZNaPIk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=uO6hhPAT4jI4T/qNpf5oeiDmvPtzp6dukZAVQuqcKxq9u3yC72wSr/VzFR84LZdZQ
         s/gbrGvs+u4vxXiUgJ/XVLKmE9FvF4GGYwoF9EhIcWb3WDvdLtIRE19mk4K77Mlpjx
         +6L9xRsQNeEKfJG7xGQB9L+2sdubxxey9SJqEthkXc5LeNKeqjanJizRsWdk9VXi9e
         8ohrz5LfbQ2jqfcNyo8sA9TAHeS5OLjo7ML67wEtyxcOaprc8kiBeTbQu0ju5s0oJ8
         0tQObfU50dezX8hgsvo1sTlEpyaReD/qFEYmhxaYGTmyBg9rNjZEsuPD05jnyL9E1a
         FVdh7O83oHNDQ==
Subject: Re: drivers/clocksource/dw_apb_timer_of.c:66
 timer_get_base_and_rate() warn: 'timer_clk' not released on lines: 64.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <20210222062151.GL2087@kadam>
 <abe304b5-bd65-d8d1-509a-b1a58ffc9816@linaro.org>
From:   Dinh Nguyen <dinguyen@kernel.org>
Message-ID: <644a72b7-72de-8286-a977-b46aae36dc72@kernel.org>
Date:   Mon, 22 Mar 2021 07:21:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <abe304b5-bd65-d8d1-509a-b1a58ffc9816@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

2/21 4:58 AM, Daniel Lezcano wrote:
> 
> Dinh,
> 
> is it possible to have a look at this issue?
> 
> Thanks
> 

Sorry, but somehow I missed cc'ing you when I first sent the patch.

I've resent it just now.

Dinh

> On 22/02/2021 07:21, Dan Carpenter wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   55f62bc873477dae2c45bbbc30b86cf3e0982f3b
>> commit: 5d9814df0aec56a638bbf20795abb4cfaf3cd331 clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available
>> config: arm64-randconfig-m031-20210221 (attached as .config)
>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>>
>> New smatch warnings:
>> drivers/clocksource/dw_apb_timer_of.c:66 timer_get_base_and_rate() warn: 'timer_clk' not released on lines: 64.
>>
>> Old smatch warnings:
>> drivers/clocksource/dw_apb_timer_of.c:66 timer_get_base_and_rate() warn: '*base' not released on lines: 56,64.
>>
>> vim +/timer_clk +66 drivers/clocksource/dw_apb_timer_of.c
>>
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  17  static int __init timer_get_base_and_rate(struct device_node *np,
>> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  18  				    void __iomem **base, u32 *rate)
>> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  19  {
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  20  	struct clk *timer_clk;
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  21  	struct clk *pclk;
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  22  	struct reset_control *rstc;
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  23  	int ret;
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  24
>> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  25  	*base = of_iomap(np, 0);
>> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  26
>> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  27  	if (!*base)
>> 2a4849d2674b96 drivers/clocksource/dw_apb_timer_of.c Rob Herring    2018-08-27  28  		panic("Unable to map regs for %pOFn", np);
>> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  29
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  30  	/*
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  31  	 * Reset the timer if the reset control is available, wiping
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  32  	 * out the state the firmware may have left it
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  33  	 */
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  34  	rstc = of_reset_control_get(np, NULL);
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  35  	if (!IS_ERR(rstc)) {
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  36  		reset_control_assert(rstc);
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  37  		reset_control_deassert(rstc);
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  38  	}
>> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  39
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  40  	/*
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  41  	 * Not all implementations use a periphal clock, so don't panic
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  42  	 * if it's not present
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  43  	 */
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  44  	pclk = of_clk_get_by_name(np, "pclk");
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  45  	if (!IS_ERR(pclk))
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  46  		if (clk_prepare_enable(pclk))
>> 2a4849d2674b96 drivers/clocksource/dw_apb_timer_of.c Rob Herring    2018-08-27  47  			pr_warn("pclk for %pOFn is present, but could not be activated\n",
>> 2a4849d2674b96 drivers/clocksource/dw_apb_timer_of.c Rob Herring    2018-08-27  48  				np);
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  49
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  50  	if (!of_property_read_u32(np, "clock-freq", rate) &&
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  51  	    !of_property_read_u32(np, "clock-frequency", rate))
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  52  		return 0;
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  53
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  54  	timer_clk = of_clk_get_by_name(np, "timer");
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  55  	if (IS_ERR(timer_clk))
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  56  		return PTR_ERR(timer_clk);
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  57
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  58  	ret = clk_prepare_enable(timer_clk);
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  59  	if (ret)
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  60  		return ret;
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  61
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  62  	*rate = clk_get_rate(timer_clk);
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  63  	if (!(*rate))
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  64  		return -EINVAL;
>>
>> disable timer_clk if clk_get_rate() fails?
>>
>> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  65
>> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05 @66  	return 0;
>> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  67  }
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 
> 
