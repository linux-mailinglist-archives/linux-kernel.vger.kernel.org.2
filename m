Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB69F450456
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 13:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhKOMZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 07:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhKOMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 07:25:06 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF66C061570
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 04:22:10 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so12256732wmb.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 04:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Rq26T0B46/RTeMBISJl2qksdO4z+iIOIIbb/Qmov5oU=;
        b=V4SJjK26l05fT1YD+HEVOoGxM78R75jqxx7Ilefx03JWwUOkAjVYNJaacHuZXsOGK8
         5FRI2SfEQ3NmTw/qrsaAnGfodYV07gjb5sRVEM83sZZxJm4uqc2ymEnv397CQlYZt0SJ
         OPVOhaKRlJEjDtd2wJNkPaCdfEEy5vdpJL8uRZiokb83n11HlWyUs6Po1sknvagfYZ01
         DanExluF6NKETwhsj69iEc5z7h4JK9XUjUOYODebioNaPVCAdlHfzGoTkuT+4KdGLkTY
         G30yYiP3L5QG5l4K3QKpZ2fxFRFyqDo3goEQscm6RbkDJ1Jxb9JpjbdA3PLdqt/4ujRg
         jEfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Rq26T0B46/RTeMBISJl2qksdO4z+iIOIIbb/Qmov5oU=;
        b=wXFiB9DWmqoKrDCRr5206s8FRVDOsLfJMUW8gpd1f2CaSkQLGnjXyYYr/Lqcb2XME6
         VtpCOmTwdgfWGEiO4TwytHynTjurr91ZNIUDSpimsgDpfAAowhMDRyqEhxHq75MlQvNo
         WB/walkGJgqiVV2WcEqD99J7zaoJqUY0CxOyfyhmcOA5IYBSekhyRAoRqH3zb9Eqq5T7
         oHL+09VLICBDJnu8ha8iyfLAdWoHxt6DTj8miEdAa7nj4kzXcbSrgDHqHNkZ8fvODE37
         jELSNYRQRUzUNkWzzrZSrcwdWV63UeDMc9BhRjjjo6A2DMrMygiRalDe6c8tXDEumWUH
         k8aw==
X-Gm-Message-State: AOAM532Ke487xXuM5arQ5c0Xq8Zk3b4KABMbrN56ynbxHGe6npHz14PP
        e9I9F/J2uYcArC6KYJTGd01cg1yfBAC/Qg==
X-Google-Smtp-Source: ABdhPJzDOcM71NzZyHJoV30c2Q5fGKwc6AtaqN+iTBr8obPNQJMfmvFuxAM7TIsAwfJ7thKhhb6SeA==
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr42501894wmm.142.1636978928587;
        Mon, 15 Nov 2021 04:22:08 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b99:1d57:8555:27fb? ([2a01:e34:ed2f:f020:b99:1d57:8555:27fb])
        by smtp.googlemail.com with ESMTPSA id g13sm13273738wrd.57.2021.11.15.04.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Nov 2021 04:22:07 -0800 (PST)
Subject: Re: drivers/clocksource/timer-pistachio.c:74:22: warning: variable
 'overflow' set but not used
To:     Drew Fustini <drew@beagleboard.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <202111120738.oAGjK5L8-lkp@intel.com> <20211114212938.GA317441@x1>
 <552daf37-c5eb-6634-7456-3fa39c74ebcb@linaro.org>
 <20211115010253.GA325926@x1>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e2632d73-8bf2-52d9-e7a0-e7fec21290e6@linaro.org>
Date:   Mon, 15 Nov 2021 13:22:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211115010253.GA325926@x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2021 02:02, Drew Fustini wrote:
> On Sun, Nov 14, 2021 at 11:17:38PM +0100, Daniel Lezcano wrote:
>> On 14/11/2021 22:29, Drew Fustini wrote:
>>> On Fri, Nov 12, 2021 at 07:05:48AM +0800, kernel test robot wrote:
>>>> Hi Drew,
>>>>
>>>> FYI, the error/warning still remains.
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   debe436e77c72fcee804fb867f275e6d31aa999c
>>>> commit: a47d7ef4550d08fb428ea4c3f1a9c71674212208 clocksource/drivers/pistachio: Fix trivial typo
>>>> date:   7 months ago
>>>> config: mips-randconfig-r012-20210927 (attached as .config)
>>>> compiler: mips-linux-gcc (GCC) 11.2.0
>>>> reproduce (this is a W=1 build):
>>>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>         chmod +x ~/bin/make.cross
>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a47d7ef4550d08fb428ea4c3f1a9c71674212208
>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>         git fetch --no-tags linus master
>>>>         git checkout a47d7ef4550d08fb428ea4c3f1a9c71674212208
>>>>         # save the attached .config to linux build tree
>>>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>    drivers/clocksource/timer-pistachio.c: In function 'pistachio_clocksource_read_cycles':
>>>>>> drivers/clocksource/timer-pistachio.c:74:22: warning: variable 'overflow' set but not used [-Wunused-but-set-variable]
>>>>       74 |         u32 counter, overflow;
>>>>          |                      ^~~~~~~~
>>>>
>>>>
>>>> vim +/overflow +74 drivers/clocksource/timer-pistachio.c
>>>>
>>>>     69	
>>>>     70	static u64 notrace
>>>>     71	pistachio_clocksource_read_cycles(struct clocksource *cs)
>>>>     72	{
>>>>     73		struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
>>>>   > 74		u32 counter, overflow;
>>>>     75		unsigned long flags;
>>>>     76	
>>>>     77		/*
>>>>     78		 * The counter value is only refreshed after the overflow value is read.
>>>>     79		 * And they must be read in strict order, hence raw spin lock added.
>>>>     80		 */
>>>>     81	
>>>>     82		raw_spin_lock_irqsave(&pcs->lock, flags);
>>>>     83		overflow = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);
>>
>> overflow is set here but then never reused in the function. So a call to
>> gpt_readl without getting the return value is fine.
>>
>> The warning is different from 'variable is unused'
> 
> Thank you for pointing that out.  I was reading it incorrectly.
> 
> As for this function, it seems that warning is a false positive as
> the act of reading TIMER_CURRENT_OVERFLOW_VALUE causes the hardware
> to refresh TIMER_CURRENT_VALUE.

The warning is actually not a false positive. It just state the variable
is unused after setting it which is actually correct.

The indirect warning is about the behavior of the hardware where the
counter is refreshed only when the overflow is read.

May be adding the may_be_unused annotation to the overflow variable can
silent the warning?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
