Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC07036B47A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 16:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhDZOGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 10:06:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:60594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233720AbhDZOF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 10:05:58 -0400
IronPort-SDR: RroM1/ceBrUJZxjLC9quLxg8aCgKfd1hn4uFtyYsvZ0O6Hg8P28UMc/9hZla2rn+auGoC11ida
 IF/o5+IvRY/w==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="175822019"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="175822019"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 07:05:17 -0700
IronPort-SDR: QOJ9Wvja0C8wdUuxGOawy1dtz4M6jw5IIyYFuzYGoN1fdzWSvv+hr0/yoJ3zq0dRkGIIOGELhV
 TXbJ5Pk0pf4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="465123921"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2021 07:05:13 -0700
Date:   Mon, 26 Apr 2021 22:05:12 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>
Subject: Re: [LKP] Re: [clocksource] 6c52b5f3cf: stress-ng.opcode.ops_per_sec
 -14.4% regression
Message-ID: <20210426140512.GA23119@shbuild999.sh.intel.com>
References: <04f4752e-6c5a-8439-fe75-6363d212c7b2@intel.com>
 <20210421134224.GR975577@paulmck-ThinkPad-P17-Gen-1>
 <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1>
 <20210423061115.GA62813@shbuild999.sh.intel.com>
 <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210424122920.GB85095@shbuild999.sh.intel.com>
 <87pmyhte2q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmyhte2q.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Mon, Apr 26, 2021 at 08:39:25PM +0800, Thomas Gleixner wrote:
> On Sat, Apr 24 2021 at 20:29, Feng Tang wrote:
> > On Fri, Apr 23, 2021 at 07:02:54AM -0700, Paul E. McKenney wrote:
> > And I'm eager to know if there is any real case of an unreliable tsc
> > on the 'large numbers' of x86 system which complies with our cpu feature
> > check. And if there is, my 2/2 definitely should be dropped.   
> 
> Nothing prevents BIOS tinkerers from trying to be 'smart'. My most
> recent encounter (3 month ago) was on a laptop where TSC drifted off on
> CPU0 very slowly, but was caught due to the TSC_ADJUST check in idle.

Thanks for sharing the info! So this laptop can still work with the
tsc_adjust check and restore, without triggering the 'unstable' alarm.

Why are those BIOSes playing the trick? Maybe some other OS has hard limit
for SMI's maxim handling time, so they try to hide the time?

> I'm still thinking about a solution to avoid that extra timer and the
> watchdog for these systems, but haven't found anything which I don't
> hate with a passion yet.

I see. So should I hold my two patches (tsc_adjust timer and tsc watchdog
check lifting) for a while?

Thanks,
Feng

> Thanks,
> 
>         tglx
