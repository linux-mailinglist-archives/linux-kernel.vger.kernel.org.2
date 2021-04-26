Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B4036B584
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbhDZPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:13:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:23119 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233573AbhDZPNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:13:36 -0400
IronPort-SDR: ZdF0ptpXiQj9imCouTaggO655kEtQAHGJsVdFCY0k8/irL2vvkROzoNIaLlfO2fl6a6uA47/l4
 rfKs9jUFyZLg==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="194232622"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="194232622"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 08:12:53 -0700
IronPort-SDR: RzSdqbWmxZuStb6bncQizLVdCJ7D6PKRwokbl8COVJ56sUhWUR9Oc8T8zGWfZ0dz7gT+nihC71
 14W0ewhyXyiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="402952253"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.147.94])
  by orsmga002.jf.intel.com with ESMTP; 26 Apr 2021 08:12:50 -0700
Date:   Mon, 26 Apr 2021 23:12:49 +0800
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
Message-ID: <20210426151249.GA89018@shbuild999.sh.intel.com>
References: <ed77d2a5-aeb0-b7f5-ce91-4cac12cfdd61@linux.intel.com>
 <20210422074126.GA85095@shbuild999.sh.intel.com>
 <20210422142454.GD975577@paulmck-ThinkPad-P17-Gen-1>
 <20210422165743.GA162649@paulmck-ThinkPad-P17-Gen-1>
 <20210423061115.GA62813@shbuild999.sh.intel.com>
 <20210423140254.GM975577@paulmck-ThinkPad-P17-Gen-1>
 <20210424122920.GB85095@shbuild999.sh.intel.com>
 <87pmyhte2q.ffs@nanos.tec.linutronix.de>
 <20210426140512.GA23119@shbuild999.sh.intel.com>
 <87fszdt8sk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fszdt8sk.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 04:33:31PM +0200, Thomas Gleixner wrote:
> On Mon, Apr 26 2021 at 22:05, Feng Tang wrote:
> > On Mon, Apr 26, 2021 at 08:39:25PM +0800, Thomas Gleixner wrote:
> >> On Sat, Apr 24 2021 at 20:29, Feng Tang wrote:
> >> > On Fri, Apr 23, 2021 at 07:02:54AM -0700, Paul E. McKenney wrote:
> >> > And I'm eager to know if there is any real case of an unreliable tsc
> >> > on the 'large numbers' of x86 system which complies with our cpu feature
> >> > check. And if there is, my 2/2 definitely should be dropped.   
> >> 
> >> Nothing prevents BIOS tinkerers from trying to be 'smart'. My most
> >> recent encounter (3 month ago) was on a laptop where TSC drifted off on
> >> CPU0 very slowly, but was caught due to the TSC_ADJUST check in idle.
> >
> > Thanks for sharing the info! So this laptop can still work with the
> > tsc_adjust check and restore, without triggering the 'unstable' alarm.
> >
> > Why are those BIOSes playing the trick? Maybe some other OS has hard limit
> > for SMI's maxim handling time, so they try to hide the time?
> 
> Years ago someone admitted that it was the attempt to hide the
> (substantial) time wasted in SMIs from being detectable via tracing, but
> obviously that backfired because TSC got out of sync.
> 
> Since then this has mostly vanished but for some reasons it's coming
> back every now and then. Rarely, but it happens still.
 
I see now.

> >> I'm still thinking about a solution to avoid that extra timer and the
> >> watchdog for these systems, but haven't found anything which I don't
> >> hate with a passion yet.
> >
> > I see. So should I hold my two patches (tsc_adjust timer and tsc watchdog
> > check lifting) for a while?
> 
> I have them on my list anyway, but yes we want to avoid the timer
> because that's what the HPC / NOHZ full people are going to complain
> about anyway.

Got it. Thanks for the clarification!

- Feng

> Thanks,
> 
>         tglx
