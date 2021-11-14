Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2044FC29
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 23:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbhKNWUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 17:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKNWUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 17:20:39 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB96C061746
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 14:17:42 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o29so12296399wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 14:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hUtaNx2jsav5+ui23Ix4jotRDlK6SQqIv6KGl6rVHp4=;
        b=pY9CCmzhSIj2B5V12V7KEDy9JA4Iqmm70immVME9+NIAFNbMNn8f4cfVhDK072omHt
         3u480N5t9JySUkxpWEk6xWQv3NQeR8D1wpF2kkN/dDHZ3ULAONck84NVfdp2EUS8dhrE
         Fhu8VHepiNPaAqpPumibbmPfenJu8SxVdiVQakzplvj0aIQf7LC5J2dth6bbq74B9SKu
         ir5EG4ARkhMfXfeFDgfpnmo4pG3D7ZNjJofyLIkt/mjCfQYvDfdgRXFth66ej7NKtP0t
         EQ8UrtFX4pXV4UJHaqIbDbCj84sf5GlvVcuCJOB8TEB1gLAK6SoVmIl2Zi+HugSJZ70l
         Ipmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hUtaNx2jsav5+ui23Ix4jotRDlK6SQqIv6KGl6rVHp4=;
        b=FaOlf8WfBVgAMYAO0inl6T5YRLGXgFKYEcCTFmqJT4xESWU5qssJqfWXmDR1k8nZnw
         w3y5+oI23oR6/hFu8bygzcqEIbtfgYZxoDC4cUG0mrW15zySideXP27n/MAmcJUZvFNc
         fL5u34RMRj1y7TnwFVvwTcZEk3yZM0N6lpareH0/apwLFFf+bshV1hs+ENf7CiUC1wCz
         migwoQkK5zQk3F8UcuygL8ksx7d1FcIGgY5w+f+hNaSqVXPjMNgHq36G2avadQOpjsJo
         MWUOCaw2AGYoQUh7UKyBXTGYhUeYomGJIRhMN6l5dtefyHxzEe9Fq4lhht5OMzvp/rD4
         KlFg==
X-Gm-Message-State: AOAM533mThbcmLiKrL/yTBLUwT7NpCFmtT+fNm0IgDYuay7wCdfE7Hu6
        ZK/+O1Q7cQ4cG1QS39gUW1YqSd+j+QnlQQ==
X-Google-Smtp-Source: ABdhPJxVsznUF7TSxpy+UOR7ljUA2XftfVVi3/yE37qt668o1P58p1o0HxQQ8i4yoLcjLoOc4fhCqA==
X-Received: by 2002:a05:600c:4fca:: with SMTP id o10mr36729523wmq.175.1636928260564;
        Sun, 14 Nov 2021 14:17:40 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b99:1d57:8555:27fb? ([2a01:e34:ed2f:f020:b99:1d57:8555:27fb])
        by smtp.googlemail.com with ESMTPSA id f19sm22894517wmq.34.2021.11.14.14.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 14:17:39 -0800 (PST)
Subject: Re: drivers/clocksource/timer-pistachio.c:74:22: warning: variable
 'overflow' set but not used
To:     Drew Fustini <drew@beagleboard.org>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <202111120738.oAGjK5L8-lkp@intel.com> <20211114212938.GA317441@x1>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <552daf37-c5eb-6634-7456-3fa39c74ebcb@linaro.org>
Date:   Sun, 14 Nov 2021 23:17:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211114212938.GA317441@x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2021 22:29, Drew Fustini wrote:
> On Fri, Nov 12, 2021 at 07:05:48AM +0800, kernel test robot wrote:
>> Hi Drew,
>>
>> FYI, the error/warning still remains.
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   debe436e77c72fcee804fb867f275e6d31aa999c
>> commit: a47d7ef4550d08fb428ea4c3f1a9c71674212208 clocksource/drivers/pistachio: Fix trivial typo
>> date:   7 months ago
>> config: mips-randconfig-r012-20210927 (attached as .config)
>> compiler: mips-linux-gcc (GCC) 11.2.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a47d7ef4550d08fb428ea4c3f1a9c71674212208
>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>         git fetch --no-tags linus master
>>         git checkout a47d7ef4550d08fb428ea4c3f1a9c71674212208
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=mips 
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>    drivers/clocksource/timer-pistachio.c: In function 'pistachio_clocksource_read_cycles':
>>>> drivers/clocksource/timer-pistachio.c:74:22: warning: variable 'overflow' set but not used [-Wunused-but-set-variable]
>>       74 |         u32 counter, overflow;
>>          |                      ^~~~~~~~
>>
>>
>> vim +/overflow +74 drivers/clocksource/timer-pistachio.c
>>
>>     69	
>>     70	static u64 notrace
>>     71	pistachio_clocksource_read_cycles(struct clocksource *cs)
>>     72	{
>>     73		struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
>>   > 74		u32 counter, overflow;
>>     75		unsigned long flags;
>>     76	
>>     77		/*
>>     78		 * The counter value is only refreshed after the overflow value is read.
>>     79		 * And they must be read in strict order, hence raw spin lock added.
>>     80		 */
>>     81	
>>     82		raw_spin_lock_irqsave(&pcs->lock, flags);
>>     83		overflow = gpt_readl(pcs->base, TIMER_CURRENT_OVERFLOW_VALUE, 0);

overflow is set here but then never reused in the function. So a call to
gpt_readl without getting the return value is fine.

The warning is different from 'variable is unused'

> I fail to see how variable 'overflow' set but not used as the return
> value of gpt_readl() is unconditionally assigned to 'overflow'.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
