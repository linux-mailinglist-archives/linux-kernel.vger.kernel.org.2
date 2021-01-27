Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF68305D04
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhA0NYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:24:10 -0500
Received: from outbound-smtp30.blacknight.com ([81.17.249.61]:57599 "EHLO
        outbound-smtp30.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236705AbhA0NWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:22:16 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp30.blacknight.com (Postfix) with ESMTPS id 98C99BAE1D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 13:21:22 +0000 (GMT)
Received: (qmail 18257 invoked from network); 27 Jan 2021 13:21:22 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 Jan 2021 13:21:22 -0000
Date:   Wed, 27 Jan 2021 13:21:21 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Merge select_idle_core/cpu()
Message-ID: <20210127132121.GD3592@techsingularity.net>
References: <20210125085909.4600-1-mgorman@techsingularity.net>
 <20210125085909.4600-5-mgorman@techsingularity.net>
 <CAKfTPtBhq25D8iZ67n+kkf9Mdyf+OradvVC5pG0MeZEMKZmU2g@mail.gmail.com>
 <20210127120245.GC3592@techsingularity.net>
 <CAKfTPtB=vh0FzszeOS5ND4Voq3ck2AQgruF-4zC-K1hSSsbT_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtB=vh0FzszeOS5ND4Voq3ck2AQgruF-4zC-K1hSSsbT_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:07:50PM +0100, Vincent Guittot wrote:
> > @@ -6162,18 +6162,16 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> >
> >         for_each_cpu_wrap(cpu, cpus, target) {
> >                 if (smt) {
> > -                       i = select_idle_core(p, cpu, cpus, &idle_cpu);
> > -                       if ((unsigned int)i < nr_cpumask_bits)
> > -                               return i;
> > +                       idle_cpu = select_idle_core(p, cpu, cpus, &idle_cpu);
> 
> but how do you differentiate idle core (return value) and an idle cpu
> in the core set in &idle_cpu
> 
> You will return as soon as a cpu is idle and before testing all cores
> 

Bah, I'm sorry, I was context switching between multiple tasks and failed
to engage brain. I'll apply your hunk and resend. I don't think this
merits retesting as the saving of avoiding the intermeriate is marginal.

-- 
Mel Gorman
SUSE Labs
