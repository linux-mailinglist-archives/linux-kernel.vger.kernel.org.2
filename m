Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E431368AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 04:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhDWCQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 22:16:39 -0400
Received: from mga11.intel.com ([192.55.52.93]:57676 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhDWCQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 22:16:38 -0400
IronPort-SDR: 9oFg7co7rUnv7fBoSuivU7pKNWEn2TaTKb3d914zp2oT/EP645GFnvX6ld07jISzOzZV4EyJuo
 pPjds5ki4KYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192817646"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="192817646"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 19:16:02 -0700
IronPort-SDR: 3nIHzZZCasK7WPQ5/mr1vBaEn1/Pj/ss9BNYkuieE5VnGJP5QUZcS6P27zONsY9ISWfh3MAtbo
 JDaoBTkN3yPw==
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="428205418"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.46]) ([10.238.4.46])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 19:15:58 -0700
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec
 -14.4% regression
To:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, lkp@intel.com
References: <20210420064934.GE31773@xsang-OptiPlex-9020>
 <20210420134331.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210420140552.GA3158164@paulmck-ThinkPad-P17-Gen-1>
 <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com>
 <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <d3a01227-cec5-2670-5525-36a418c5f4a0@linux.intel.com>
Date:   Fri, 23 Apr 2021 10:15:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2021 10:24 PM, Paul E. McKenney wrote:
> On Thu, Apr 22, 2021 at 03:41:26PM +0800, Feng Tang wrote:
>> Hi Paul,
>>
>> On Thu, Apr 22, 2021 at 02:58:27PM +0800, Xing Zhengjun wrote:
>>>
>>>
>>> On 4/21/2021 9:42 PM, Paul E. McKenney wrote:
>>>> On Wed, Apr 21, 2021 at 02:07:19PM +0800, Xing, Zhengjun wrote:
>>>>>
>>>>> On 4/20/2021 10:05 PM, Paul E. McKenney wrote:
>>>>>> On Tue, Apr 20, 2021 at 06:43:31AM -0700, Paul E. McKenney wrote:
>>>>>>> On Tue, Apr 20, 2021 at 02:49:34PM +0800, kernel test robot wrote:
>>>>>>>> Greeting,
>>>>>>>>
>>>>>>>> FYI, we noticed a -14.4% regression of stress-ng.opcode.ops_per_sec due to commit:
>>>>>>>>
>>>>>>>>
>>>>>>>> commit: 6c52b5f3cfefd6e429efc4413fd25e3c394e959f ("clocksource: Reduce WATCHDOG_THRESHOLD")
>>>>>>>> https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.13a
>>>>>>>>
>>>>>>>>
>>>>>>>> in testcase: stress-ng
>>>>>>>> on test machine: 96 threads Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz with 192G memory
>>>>>>>> with following parameters:
>>>>>>>>
>>>>>>>> 	nr_threads: 10%
>>>>>>>> 	disk: 1HDD
>>>>>>>> 	testtime: 60s
>>>>>>>> 	fs: ext4
>>>>>>>> 	class: os
>>>>>>>> 	test: opcode
>>>>>>>> 	cpufreq_governor: performance
>>>>>>>> 	ucode: 0x5003006
>>>>>>> Hmmm...  I will try a less-aggressive reduction.  Thank you for testing!
>>>>>> But wait...  This code is only running twice per second.  It is very
>>>>>> hard to believe that a clock-read retry twice per second is worth 2% of
>>>>>> performance, let alone 14.4%.
>>>>>>
>>>>>> Is something else perhaps going on here?
>>>>>>
>>>>>> For example, did this run enable any of the new diagnositic clocksource.*
>>>>>> kernel parameters?
>>>>>>
>>>>>> 								Thanx, Paul
>>>>> I attached the kernel log, the following logs are related with the
>>>>> clocksource.
>>>>> [    3.453206] clocksource: timekeeping watchdog on CPU1: Marking
>>>>> clocksource 'tsc-early' as unstable because the skew is too large:
>>>>> [    3.455197] clocksource:                       'hpet' wd_now: 288fcc0
>>>>> wd_last: 1a8b333 mask: ffffffff
>>>>> [    3.455199] clocksource:                       'tsc-early' cs_now:
>>>>> 1def309ebfdee cs_last: 1def2bd70d92c mask: ffffffffffffffff
>>>>> [    3.455201] clocksource:                       No current clocksource.
>>>>> [    3.457197] tsc: Marking TSC unstable due to clocksource watchdog
>>>>>
>>>>> 6c52b5f3cf reduced WATCHDOG_THRESHOLD, then in clocksource_watchdog, the
>>>>> warning logs are print, the TSC is marked as unstable.
>>>>> /* Check the deviation from the watchdog clocksource. */
>>>> Aha, so this system really does have an unstable TSC!  Which means that
>>>> the patch is operating as designed.
>>>>
>>>> Or are you saying that this is a false positive?
>>>>
>>>> 							Thanx, Paul
>>>
>>> It happened during boot and before TSC calibration
>>> (tsc_refine_calibration_work()), so on some machines "abs(cs_nsec - wd_nsec)
>>>> WATCHDOG_THRESHOLD", WATCHDOG_THRESHOLD is set too small at that time.
>>> After TSC calibrated, abs(cs_nsec - wd_nsec) should be very small,
>>> WATCHDOG_THRESHOLD for here is ok. So I suggest increasing the
>>> WATCHDOG_THRESHOLD before TSC calibration, for example, the clocks be skewed
>>> by more than 1% to be marked unstable.
> 
> This is common code, so we do need an architecture-independent way to
> handle this.
> 
>> As Zhengjun measuered, this is a Cascade Lake platform, and it has 2
>> times calibration of tsc, the first one of early quick calibration gives
>> 2100 MHz, while the later accurate calibration gives 2095 MHz, so there
>> is about 2.5/1000 deviation for the first number, which just exceeds the
>> 1/1000 threshold you set :)
> 
> Even my 2/1000 initial try would have caused this, then.  ;-)
> 
> But even 1/1000 deviation would cause any number of applications some
> severe heartburn, so I am not at all happy with the thought of globally
> increasing to (say) 3/1000.
> 
>> Following is the tsc freq info from kernel log
>>
>> [    0.000000] DMI: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
>> [    0.000000] tsc: Detected 2100.000 MHz processor
>> ...
>> [   13.859982] tsc: Refined TSC clocksource calibration: 2095.077 MHz
> 
> So what are our options?
> 
> 1.	Clear CLOCK_SOURCE_MUST_VERIFY from tsc-early.
> 
> 2.	#1, but add tsc-early into the watchdog list and set
> 	CLOCK_SOURCE_MUST_VERIFY once it is better calibrated.
> 
> 3.	Add a field to struct clocksource that, if non-zero, gives
> 	the maximum drift in nanoseconds per half second (AKA
> 	WATCHDOG_INTERVAL).  If zero, the WATCHDOG_MAX_SKEW value
> 	is used.  Set this to (say) 150,000ns for tsc-early.
> 
> 4.	As noted earlier, increase WATCHDOG_MAX_SKEW to 150 microseconds,
> 	which again is not a good approach given the real-world needs
> 	of real-world applications.
> 
> 5.	Your ideas here.
How about set two watchdog thresholds, one for before 
calibration(1/100), the other for after calibration(1/1000)? For 
example, u64 watchdog_thresholds[2].

> 
> All in all, I am glad that I made the patch that decreases
> WATCHDOG_MAX_SKEW be separate and at the end of the series.  ;-)
> 
> 							Thanx, Paul
> 

-- 
Zhengjun Xing
