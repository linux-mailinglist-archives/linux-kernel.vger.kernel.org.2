Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53E43A0DB6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 09:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbhFIH15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 03:27:57 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:12371 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234029AbhFIH1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 03:27:55 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ak4Cj560mSeVZ5jLgBDZTrwqjBKckLtp133Aq?=
 =?us-ascii?q?2lEZdPUzSKClfqGV88jzuiWVtN98YgBFpTniAse9qA3nhP1ICOAqVN/INmTbUQ?=
 =?us-ascii?q?2TXeZfBODZsljd8kPFh4xgPN9bEpRDNA=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.83,260,1616454000"; 
   d="scan'208";a="512502862"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 09:26:00 +0200
Date:   Wed, 9 Jun 2021 09:26:00 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: find_new_ilb
In-Reply-To: <YMBpxBR3EMyAUa3j@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.22.394.2106090921200.5695@hadrien>
References: <alpine.DEB.2.22.394.2106082138350.16734@hadrien> <YMBpxBR3EMyAUa3j@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 9 Jun 2021, Peter Zijlstra wrote:

> On Tue, Jun 08, 2021 at 09:51:30PM +0200, Julia Lawall wrote:
> > Starting from the following commit:
> >
> > commit 45da7a2b0af8fa29dff2e6ba8926322068350fce
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Tue Aug 18 10:48:17 2020 +0200
> >
> >     sched/fair: Exclude the current CPU from find_new_ilb()
> >
> > up through Linux 5.12, I observed that often when most of the machine was
> > idle, there could be many (thousands) of sched_wake_idle_without_ipi
> > events, typically between cores 0 and 1.  I don't see this any more in
> > Linux v5.13-rc1.  I looked through the patches to fair.c and core.c
> > subsequent to v5.12, and I didn't see anything that explicitly addresses
> > this issue.  Before I plunge into another set of rounds of bisecting, I
> > wonder if anyone knows whether and how this problem was resolved?
>
> Hurmph.. that patch was preparation for a later change that never seems
> to have happened. If it is causing trouble for you, I think you can
> savely revert it.
>
> At the time I thought it was very strange that new_idle would select
> itself as idle-balancer, doubly so, because the only way to get there
> would be with NEED_RESCHED already set, so the IPI wouldn't in fact do
> anything.
>
> Looking again, the difference is ofcourse that previously we'd select
> self and NO-OP, but now we'll potentially select another CPU and
> actually do something.
>
> This is arguably an improvement, because we did want to do something.
>
>  I can't quite remember what would've change here since, Vincent, can
>  you remember?
>
> Anyway, is this actually causing you trouble, or are you just going on
> the increased number of events?

Thanks for the feedback.  The scenarios I saw wouldn't have caused trouble
for anyone, because the machine was highly idle (maybe a couple of cores
in use).  And the problem seems to be gone as well in v5.13.

julia
