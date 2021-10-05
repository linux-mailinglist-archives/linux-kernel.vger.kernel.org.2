Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F9F422256
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 11:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhJEJdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 05:33:31 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:44025 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232658AbhJEJda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 05:33:30 -0400
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id F3ABEFADA0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 10:31:38 +0100 (IST)
Received: (qmail 27782 invoked from network); 5 Oct 2021 09:31:38 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Oct 2021 09:31:38 -0000
Date:   Tue, 5 Oct 2021 10:31:37 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Barry Song <21cnbao@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: wakeup_affine_weight() is b0rked - was Re: [PATCH 2/2]
 sched/fair: Scale wakeup granularity relative to nr_running
Message-ID: <20211005093137.GQ3959@techsingularity.net>
References: <20210920142614.4891-3-mgorman@techsingularity.net>
 <22e7133d674b82853a5ee64d3f5fc6b35a8e18d6.camel@gmx.de>
 <20210921103621.GM3959@techsingularity.net>
 <ea2f9038f00d3b4c0008235079e1868145b47621.camel@gmx.de>
 <02c977d239c312de5e15c77803118dcf1e11f216.camel@gmx.de>
 <CAGsJ_4xcRFcDMpuC7vrpHe=aRbDpAnRd1F64aqh2EEcNgmZxCg@mail.gmail.com>
 <f1b421f956fa044b4efa7f5fef015725b27223cf.camel@gmx.de>
 <4f571c5c759b9d356d1bb4114fb169181194a780.camel@gmx.de>
 <20211005074719.GP3959@techsingularity.net>
 <ba1195a9843add64b38fce9ceb186c0c21ef5783.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba1195a9843add64b38fce9ceb186c0c21ef5783.camel@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 10:42:07AM +0200, Mike Galbraith wrote:
> On Tue, 2021-10-05 at 08:47 +0100, Mel Gorman wrote:
> > On Mon, Oct 04, 2021 at 11:06:30AM +0200, Mike Galbraith wrote:
> > >
> > > The mallet below convinced wake_wide() that X waking event threads is
> > > something it most definitely should care about.  It's not perfect, can
> > > get caught with its pants down, because behavior changes a LOT, but I
> > > at least have to work at it a bit to stack tasks to the ceiling.
> > >
> > > With make -j8 running along with firefox with two tabs, one containing
> > > youtube's suggestions of stuff you probably don't want to watch, the
> > > other a running clip, if I have the idle tab in focus, and don't drive
> > > mouse around, flips decay enough for wake_wide() to lose interest, but
> > > just wiggle the mouse, and it starts waking wide. Focus on the running
> > > clip, and it continuously wakes wide.  
> > >
> > > Hacky, but way better behavior.. at this particular testcase.. in this
> > > particular box.. at least once :)
> > >
> >
> > Only three machines managed to complete tests overnight. For most
> > workloads test, it was neutral or slight improvements. For
> > multi-kernbench__netperf-tcp-rr-multipair (kernel compile +
> > netperf-tcp-rr combined), there was little to no change.
> >
> > For the heavy overloaded cases (hackbench again), it was variable. Worst
> > improvement was a gain of 1-3%. Best improvement (single socket skylake
> > with 8 logical CPUs SMT enabled) was 1%-18% depending on the group
> > count.
> 
> I wrote up a changelog to remind future me why I bent it up, but I'm
> not going to submit it. I'll leave the twiddling to folks who can be
> more responsive to possible (spelled probable;) regression reports than
> I can be.
> 

Thanks Mike.

If you write a formal patch with a Signed-off-by, I'll use it as a baseline
for the wakegran work or submit it directly. That way, I'll get any LKP
reports, user regression reports on lkml, any regression reports via
openSUSE etc and deal with them.

Based on the results I have so far, I would not be twiddling it further
but that might change when a full range of machines have completed all
of their tests. Ideally, I would do some tracing to confirm that maximum
runqueue depth is really reduced by the path.

-- 
Mel Gorman
SUSE Labs
