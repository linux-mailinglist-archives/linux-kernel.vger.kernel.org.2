Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E223A1516
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 15:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhFINGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 09:06:17 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:52800
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231466AbhFINGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 09:06:15 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AH0XvDKiO1EA3vwtxH+8FCTPLpnBQXtsji2hC?=
 =?us-ascii?q?6mlwRA09TyX+rbHNoB17726WtN9/YhwdcLy7VJVoIkm9yXcW2+cs1N6ZNWGNhI?=
 =?us-ascii?q?LCFuBfBOXZrAEIYxeOk9J15ONdV+xVDd39CkU/pcv2+2CDeOod/A=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.83,260,1616454000"; 
   d="scan'208";a="383945347"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 15:04:19 +0200
Date:   Wed, 9 Jun 2021 15:04:19 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Vincent Guittot <vincent.guittot@linaro.org>
cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: find_new_ilb
In-Reply-To: <CAKfTPtAbPg=4os6F0QKMhDnP4gYE+5hWCkA365xG79acRTYWyg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2106091502490.11283@hadrien>
References: <alpine.DEB.2.22.394.2106082138350.16734@hadrien> <YMBpxBR3EMyAUa3j@hirez.programming.kicks-ass.net> <CAKfTPtAbPg=4os6F0QKMhDnP4gYE+5hWCkA365xG79acRTYWyg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jun 2021, Vincent Guittot wrote:

> On Wed, 9 Jun 2021 at 09:12, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jun 08, 2021 at 09:51:30PM +0200, Julia Lawall wrote:
> > > Starting from the following commit:
> > >
> > > commit 45da7a2b0af8fa29dff2e6ba8926322068350fce
> > > Author: Peter Zijlstra <peterz@infradead.org>
> > > Date:   Tue Aug 18 10:48:17 2020 +0200
> > >
> > >     sched/fair: Exclude the current CPU from find_new_ilb()
> > >
> > > up through Linux 5.12, I observed that often when most of the machine was
> > > idle, there could be many (thousands) of sched_wake_idle_without_ipi
> > > events, typically between cores 0 and 1.  I don't see this any more in
> > > Linux v5.13-rc1.  I looked through the patches to fair.c and core.c
> > > subsequent to v5.12, and I didn't see anything that explicitly addresses
> > > this issue.  Before I plunge into another set of rounds of bisecting, I
> > > wonder if anyone knows whether and how this problem was resolved?
> >
> > Hurmph.. that patch was preparation for a later change that never seems
> > to have happened. If it is causing trouble for you, I think you can
> > savely revert it.
> >
> > At the time I thought it was very strange that new_idle would select
> > itself as idle-balancer, doubly so, because the only way to get there
> > would be with NEED_RESCHED already set, so the IPI wouldn't in fact do
> > anything.
> >
> > Looking again, the difference is ofcourse that previously we'd select
> > self and NO-OP, but now we'll potentially select another CPU and
> > actually do something.
> >
> > This is arguably an improvement, because we did want to do something.
> >
> >  I can't quite remember what would've change here since, Vincent, can
> >  you remember?
>
> c6f886546cb8 ("sched/fair: Trigger the update of blocked load on newly
> idle cpu") could be the one which fixes it.
> We don't kick_ilb from newilde_balance() since this commit

This is indeed the commit that fixes the problem.  Increasing the blocked
load did seem to be what was not getting done.

thanks,
julia

>
> >
> > Anyway, is this actually causing you trouble, or are you just going on
> > the increased number of events?
>
