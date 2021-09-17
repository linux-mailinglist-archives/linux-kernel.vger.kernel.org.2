Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61CF140F95F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245321AbhIQNhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:37:22 -0400
Received: from outbound-smtp19.blacknight.com ([46.22.139.246]:40185 "EHLO
        outbound-smtp19.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344439AbhIQNgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:36:38 -0400
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp19.blacknight.com (Postfix) with ESMTPS id 8A8991C4C74
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 14:35:14 +0100 (IST)
Received: (qmail 25531 invoked from network); 17 Sep 2021 13:35:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Sep 2021 13:35:14 -0000
Date:   Fri, 17 Sep 2021 14:35:12 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Aubrey Li <aubrey.li@linux.intel.com>
Cc:     Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, song.bao.hua@hisilicon.com,
        valentin.schneider@arm.com, vincent.guittot@linaro.org,
        yangyicong@huawei.com
Subject: Re: [PATCH 8/9] sched/fair: select idle cpu from idle cpumask for
 task wakeup
Message-ID: <20210917133512.GH3959@techsingularity.net>
References: <125eb98a-241b-078f-1844-b0521425ed1e@linux.intel.com>
 <20210917041539.7862-1-21cnbao@gmail.com>
 <865702ea-b1c1-e39d-94ea-d55bf03b86db@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <865702ea-b1c1-e39d-94ea-d55bf03b86db@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 05:11:11PM +0800, Aubrey Li wrote:
> On 9/17/21 12:15 PM, Barry Song wrote:
> >> @@ -4965,6 +4965,7 @@ void scheduler_tick(void)
> >>
> >>  #ifdef CONFIG_SMP
> >> 	rq->idle_balance = idle_cpu(cpu);
> >> +	update_idle_cpumask(cpu, rq->idle_balance);
> >>  	trigger_load_balance(rq);
> >>  #endif
> >> }
> > 
> > might be stupid, a question bothering yicong and me is that why don't we
> > choose to update_idle_cpumask() while idle task exits and switches to a
> > normal task?
> 
> I implemented that way and we discussed before(RFC v1 ?), updating a cpumask
> at every enter/exit idle is more expensive than we expected, though it's
> per LLC domain, Vincent saw a significant regression IIRC. You can also
> take a look at nohz.idle_cpus_mask as a reference.
> 

It's possible to track it differently and I prototyped it some time
back. The results were mixed at the time. It helped some workloads
and was marginal on others. It appeared to help hackbench but I found
that hackbench is much more vulnerable to the wakeup_granularity and
overscheduling. For hackbench, it makes more sense to target that directly
before revisiting the alt-idlecore to see what it really helps. I'm waiting
on test results on various ways wakeup_gran can be scaled depending on
rq activity.

For alternative idle core tracking, the current 5.15-rc1 rebase
prototype looks like this

https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/commit/?h=sched-altidlecore-v2r8&id=b2af1a88245f6cbeb28343e89f3183a77b29d52d

Test results still pending and as usual the queue is busy. I swear, my
primary bottleneck for doing anything is benchmark and validation :(

-- 
Mel Gorman
SUSE Labs
