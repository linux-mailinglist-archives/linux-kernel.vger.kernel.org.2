Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9DE3E215A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 04:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhHFCC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 22:02:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:31195 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhHFCCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 22:02:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="214275346"
X-IronPort-AV: E=Sophos;i="5.84,299,1620716400"; 
   d="scan'208";a="214275346"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 19:02:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,299,1620716400"; 
   d="scan'208";a="513023514"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.133])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2021 19:02:34 -0700
Date:   Fri, 6 Aug 2021 10:10:00 +0800
From:   Chao Gao <chao.gao@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
Subject: Re: [clocksource]  8901ecc231:  stress-ng.lockbus.ops_per_sec -9.5%
 regression
Message-ID: <20210806020958.GA18104@gao-cwp>
References: <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
 <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803085759.GA31621@gao-cwp>
 <20210803134816.GO4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805021646.GA11629@gao-cwp>
 <20210805040349.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805053938.GA12593@gao-cwp>
 <20210805153727.GG4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805153727.GG4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 08:37:27AM -0700, Paul E. McKenney wrote:
>On Thu, Aug 05, 2021 at 01:39:40PM +0800, Chao Gao wrote:
>> [snip]
>> >> This patch works well; no false-positive (marking TSC unstable) in a
>> >> 10hr stress test.
>> >
>> >Very good, thank you!  May I add your Tested-by?
>> 
>> sure.
>> Tested-by: Chao Gao <chao.gao@intel.com>
>
>Very good, thank you!  I will apply this on the next rebase.
>
>> >I expect that I will need to modify the patch a bit more to check for
>> >a system where it is -never- able to get a good fine-grained read from
>> >the clock.
>> 
>> Agreed.
>> 
>> >And it might be that your test run ended up in that state.
>> 
>> Not that case judging from kernel logs. Coarse-grained check happened 6475
>> times in 43k seconds (by grep "coarse-grained skew check" in kernel logs).
>> So, still many checks were fine-grained.
>
>Whew!  ;-)
>
>So about once per 13 clocksource watchdog checks.
>
>To Andi's point, do you have enough information in your console log to
>work out the longest run of course-grained clocksource checks?

Yes. 5 consecutive course-grained clocksource checks. Note that
considering the reinitialization after course-grained check, in my
calculation, two course-grained checks are considered consecutive if
they happens in 1s(+/- 0.3s).

Thanks
Chao
