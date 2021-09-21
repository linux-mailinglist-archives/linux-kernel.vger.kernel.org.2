Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EAC4131E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 12:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhIUKqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 06:46:51 -0400
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:43698 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231189AbhIUKqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 06:46:49 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 93D6F1800A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:45:20 +0100 (IST)
Received: (qmail 6161 invoked from network); 21 Sep 2021 10:45:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 21 Sep 2021 10:45:20 -0000
Date:   Tue, 21 Sep 2021 11:45:18 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Scale wakeup granularity relative to
 nr_running
Message-ID: <20210921104518.GN3959@techsingularity.net>
References: <20210920142614.4891-1-mgorman@techsingularity.net>
 <20210920142614.4891-3-mgorman@techsingularity.net>
 <CAKfTPtAhb=mryigtxgwETg4FuJ0s5X8XFjyTaCbnxjpgZXmyng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAhb=mryigtxgwETg4FuJ0s5X8XFjyTaCbnxjpgZXmyng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:03:56AM +0200, Vincent Guittot wrote:
> On Mon, 20 Sept 2021 at 16:26, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > Commit 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs") moved
> > the kernel.sched_wakeup_granularity_ns sysctl under debugfs.  One of the
> > reasons why this sysctl may be used may be for "optimising for throughput",
> > particularly when overloaded. The tool TuneD sometimes alters this for two
> > profiles e.g. "mssql" and "throughput-performance". At least version 2.9
> > does but it changed in master where it also will poke at debugfs instead.
> >
> > During task migration or wakeup, a decision is made on whether
> > to preempt the current task or not. To limit over-scheduled,
> > sysctl_sched_wakeup_granularity delays the preemption to allow at least 1ms
> > of runtime before preempting. However, when a domain is heavily overloaded
> > (e.g. hackbench), the degree of over-scheduling is still severe. This is
> 
> sysctl_sched_wakeup_granularity =  1 msec * (1 + ilog(ncpus))
> AFAIK, a 2-socket CascadeLake has 56 cpus which means that
> sysctl_sched_wakeup_granularity is 6ms for your platform
> 

On my machine it becomes 7ms but lets assume there were 56 cpus to avoid
confusion.

> > problematic as a lot of time can be wasted rescheduling tasks that could
> > instead be used by userspace tasks.
> >
> > This patch scales the wakeup granularity based on the number of running
> > tasks on the CPU up to a max of 8ms by default.  The intent is to
> 
> This becomes 8*6=48ms on your platform which is far more than the 15ms
> below. Also 48ms is quite a long time to wait for a newly woken task
> especially when this task is a bottleneck.
> 

With the patch on top I proposed to Mike to take FAIR_SLEEPERS into
account, it becomes ((sysctl_sched_latency / gran) >> 1) by default which
becomes 18ms for heavy overloading or potentially 12ms if there is enough
load to stack 2 tasks. The patch generates a warning as I didn't even
build test it, but hey, it was for illustrative purposes.

Is that any better conceptually or should we ignore the problem? My
motivation here really is to reduce the motivation of others to "tune"
debugfs values or be tempted to revert the move to debugfs.

-- 
Mel Gorman
SUSE Labs
