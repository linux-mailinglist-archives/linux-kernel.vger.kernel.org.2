Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1EEA3E0DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 07:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhHEFce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 01:32:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:17962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234171AbhHEFcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 01:32:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="212217410"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="212217410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 22:32:18 -0700
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="522386543"
Received: from gao-cwp.sh.intel.com (HELO gao-cwp) ([10.239.159.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2021 22:32:14 -0700
Date:   Thu, 5 Aug 2021 13:39:40 +0800
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
Message-ID: <20210805053938.GA12593@gao-cwp>
References: <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
 <20210802062008.GA24720@gao-cwp>
 <20210802170257.GL4397@paulmck-ThinkPad-P17-Gen-1>
 <20210803085759.GA31621@gao-cwp>
 <20210803134816.GO4397@paulmck-ThinkPad-P17-Gen-1>
 <20210805021646.GA11629@gao-cwp>
 <20210805040349.GD4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805040349.GD4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>> This patch works well; no false-positive (marking TSC unstable) in a
>> 10hr stress test.
>
>Very good, thank you!  May I add your Tested-by?

sure.
Tested-by: Chao Gao <chao.gao@intel.com>

>
>I expect that I will need to modify the patch a bit more to check for
>a system where it is -never- able to get a good fine-grained read from
>the clock.

Agreed.

>And it might be that your test run ended up in that state.

Not that case judging from kernel logs. Coarse-grained check happened 6475
times in 43k seconds (by grep "coarse-grained skew check" in kernel logs).
So, still many checks were fine-grained.

>
>My current thought is that if more than (say) 100 consecutive attempts
>to read the clocksource get hit with excessive delays, it is time to at
>least do a WARN_ON(), and maybe also time to disable the clocksource
>due to skew.  The reason is that if reading the clocksource -always-
>sees excessive delays, perhaps the clock driver or hardware is to blame.
>
>Thoughts?

It makes sense to me.

Thanks
Chao
