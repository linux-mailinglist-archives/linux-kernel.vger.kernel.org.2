Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D06343D5A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 10:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVJ6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 05:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhCVJ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 05:58:13 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A2C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:58:12 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id y124-20020a1c32820000b029010c93864955so11025827wmy.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 02:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=scnHvmvziVRVYlkHauFT1chYgoSS8ODKgbmP5//Tlos=;
        b=EEvCV+ag1YsFC2ArFFtZAaMIzOI9d5JizKfwQ7LSCjXTcrRq52ztmtmZKvkHHAqQ/s
         Pn0zLVwaUfTkHbbOKhiY5Mia4eKEuojNtB2me6omSz7lB+u8rkj8zbT/ZBJaFaJk7hbI
         JXkcD3wD9okiCyB05BV9NgTjzKZchS6n7XR8QLMRcK0aEbXmPc0pns0CgT8fV4FmY+kG
         5pqWofiQ6jPAoSsdACn+WNanIBW5wXLymrUHdeKs9Ove2eifIYbN+AmuGqJ3xZW4o7T4
         ED/qBw7ioyLUvAq3oVa9WoiMjcHjonOoqMtC5oUX9A6GmPcOutILeoL8vp2gLEiVQMlh
         E8qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=scnHvmvziVRVYlkHauFT1chYgoSS8ODKgbmP5//Tlos=;
        b=QfqtM6Hwq7LLq/Fdc6UcvcmjSR6pe/hs2AIqY/I07LHJs8FQxaF0RAyNvYkGIo3V/S
         xhdYWDjxtDVwOEelFx2zpIFeV1arZOXQnh5OjoqbbI/ucmqaIyQl09hleyFQSz7j6kto
         OKI8hlzUFLY2Le17gGB59MxMWWBkLplDj7Lpx6i6BCkjKGQfnkGmbXDoYpeQVcinhqbK
         uPHzwmmxiShxc7fBOT+4s1DxF7oCgdB4COPKMeMj0b28Yy9g1E76eiM+OUZtPVUXVDxC
         9Wvhu52pa/3skh3rvypGFnMrAEAUpcFTzYdSjr2RovRq1fs9fRKnZ2JBzJepvcKwL0fl
         C+PA==
X-Gm-Message-State: AOAM530Z7ge7GySf3VSKfWcogMKeHjW6N2fm0xRoVckIYmFkxLpCphHX
        0wkmy7OqHWJVdvJ3bhREzmgBzKMtsCrKXw==
X-Google-Smtp-Source: ABdhPJyvpMHjQVTRR094DWDXYwe2fwqMQFGobMaTCgeMx+rlNloVJmK4aHcHQd8Vrjo6kVau9JYHRA==
X-Received: by 2002:a7b:c0c3:: with SMTP id s3mr15080780wmh.11.1616407091290;
        Mon, 22 Mar 2021 02:58:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:d8b:d5f9:2138:169c? ([2a01:e34:ed2f:f020:d8b:d5f9:2138:169c])
        by smtp.googlemail.com with ESMTPSA id l5sm15460481wmh.0.2021.03.22.02.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Mar 2021 02:58:10 -0700 (PDT)
Subject: Re: drivers/clocksource/dw_apb_timer_of.c:66
 timer_get_base_and_rate() warn: 'timer_clk' not released on lines: 64.
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <20210222062151.GL2087@kadam>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <abe304b5-bd65-d8d1-509a-b1a58ffc9816@linaro.org>
Date:   Mon, 22 Mar 2021 10:58:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210222062151.GL2087@kadam>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dinh,

is it possible to have a look at this issue?

Thanks

  -- Daniel


On 22/02/2021 07:21, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   55f62bc873477dae2c45bbbc30b86cf3e0982f3b
> commit: 5d9814df0aec56a638bbf20795abb4cfaf3cd331 clocksource/drivers/dw_apb_timer_of: Add error handling if no clock available
> config: arm64-randconfig-m031-20210221 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/clocksource/dw_apb_timer_of.c:66 timer_get_base_and_rate() warn: 'timer_clk' not released on lines: 64.
> 
> Old smatch warnings:
> drivers/clocksource/dw_apb_timer_of.c:66 timer_get_base_and_rate() warn: '*base' not released on lines: 56,64.
> 
> vim +/timer_clk +66 drivers/clocksource/dw_apb_timer_of.c
> 
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  17  static int __init timer_get_base_and_rate(struct device_node *np,
> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  18  				    void __iomem **base, u32 *rate)
> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  19  {
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  20  	struct clk *timer_clk;
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  21  	struct clk *pclk;
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  22  	struct reset_control *rstc;
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  23  	int ret;
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  24  
> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  25  	*base = of_iomap(np, 0);
> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  26  
> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  27  	if (!*base)
> 2a4849d2674b96 drivers/clocksource/dw_apb_timer_of.c Rob Herring    2018-08-27  28  		panic("Unable to map regs for %pOFn", np);
> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  29  
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  30  	/*
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  31  	 * Reset the timer if the reset control is available, wiping
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  32  	 * out the state the firmware may have left it
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  33  	 */
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  34  	rstc = of_reset_control_get(np, NULL);
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  35  	if (!IS_ERR(rstc)) {
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  36  		reset_control_assert(rstc);
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  37  		reset_control_deassert(rstc);
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  38  	}
> 1f174a1a2cdebc drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2018-09-17  39  
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  40  	/*
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  41  	 * Not all implementations use a periphal clock, so don't panic
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  42  	 * if it's not present
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  43  	 */
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  44  	pclk = of_clk_get_by_name(np, "pclk");
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  45  	if (!IS_ERR(pclk))
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  46  		if (clk_prepare_enable(pclk))
> 2a4849d2674b96 drivers/clocksource/dw_apb_timer_of.c Rob Herring    2018-08-27  47  			pr_warn("pclk for %pOFn is present, but could not be activated\n",
> 2a4849d2674b96 drivers/clocksource/dw_apb_timer_of.c Rob Herring    2018-08-27  48  				np);
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  49  
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  50  	if (!of_property_read_u32(np, "clock-freq", rate) &&
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  51  	    !of_property_read_u32(np, "clock-frequency", rate))
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  52  		return 0;
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  53  
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  54  	timer_clk = of_clk_get_by_name(np, "timer");
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  55  	if (IS_ERR(timer_clk))
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  56  		return PTR_ERR(timer_clk);
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  57  
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  58  	ret = clk_prepare_enable(timer_clk);
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  59  	if (ret)
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  60  		return ret;
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  61  
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  62  	*rate = clk_get_rate(timer_clk);
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  63  	if (!(*rate))
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05  64  		return -EINVAL;
> 
> disable timer_clk if clk_get_rate() fails?
> 
> a8b447f2bbbba7 drivers/clocksource/dw_apb_timer_of.c Heiko Stuebner 2013-06-04  65  
> 5d9814df0aec56 drivers/clocksource/dw_apb_timer_of.c Dinh Nguyen    2020-12-05 @66  	return 0;
> af75655c066621 arch/arm/mach-picoxcell/time.c        Jamie Iles     2011-07-25  67  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
