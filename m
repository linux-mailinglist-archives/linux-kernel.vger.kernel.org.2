Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF0311F1C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 18:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhBFRVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 12:21:42 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:65372
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229715AbhBFRVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 12:21:40 -0500
X-IronPort-AV: E=Sophos;i="5.81,158,1610406000"; 
   d="scan'208";a="372289270"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2021 18:20:56 +0100
Date:   Sat, 6 Feb 2021 18:20:56 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Vincent Guittot <vincent.guittot@linaro.org>
cc:     Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched/fair: check for idle core
In-Reply-To: <CAKfTPtDePZam9q7pR8-uSOif75d3EDmcZsawc2_Vx3RfDdLzOw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2102061818580.2908@hadrien>
References: <1603372550-14680-1-git-send-email-Julia.Lawall@inria.fr> <20201027091936.GS32041@suse.de> <alpine.DEB.2.22.394.2101242134530.2788@hadrien> <20210125091238.GE20777@suse.de> <alpine.DEB.2.22.394.2101251017480.5053@hadrien>
 <CAKfTPtDePZam9q7pR8-uSOif75d3EDmcZsawc2_Vx3RfDdLzOw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Jan 2021, Vincent Guittot wrote:

> On Mon, 25 Jan 2021 at 10:20, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> >
> >
> > On Mon, 25 Jan 2021, Mel Gorman wrote:
> >
> > > On Sun, Jan 24, 2021 at 09:38:14PM +0100, Julia Lawall wrote:
> > > >
> > > >
> > > > On Tue, 27 Oct 2020, Mel Gorman wrote:
> > > >
> > > > > On Thu, Oct 22, 2020 at 03:15:50PM +0200, Julia Lawall wrote:
> > > > > > Fixes: 11f10e5420f6 ("sched/fair: Use load instead of runnable load in wakeup path")
> > > > > > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > > > > > Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>
> > > > > >
> > > > >
> > > > > While not a universal win, it was mostly a win or neutral. In few cases
> > > > > where there was a problem, one benchmark I'm a bit suspicious of generally
> > > > > as occasionally it generates bad results for unknown and unpredictable
> > > > > reasons. In another, it was very machine specific and the differences
> > > > > were small in absolte time rather than relative time. Other tests on the
> > > > > same machine were fine so overall;
> > > > >
> > > > > Acked-by: Mel Gorman <mgorman@suse.de>
> > > >
> > > > Recently, we have been testing the phoronix multicore benchmarks.  On v5.9
> > > > with this patch, the preparation time of phoronix slows down, from ~23
> > > > seconds to ~28 seconds.  In v5.11-rc4, we see 29 seconds.  It's not yet
> > > > clear what causes the problem.  But perhaps the patch should be removed
> > > > from v5.11, until the problem is understood.
> > > >
> > > > commit d8fcb81f1acf651a0e50eacecca43d0524984f87
> > > >
> > >
> > > I'm not 100% convinved given that it was a mix of wins and losses. In
> > > the wakup path in general, universal wins almost never happen. It's not
> > > 100% clear from your mail what happens during the preparation patch. If
> > > it included time to download the benchmarks and install then it would be
> > > inherently variable due to network time (if download) or cache hotness
> > > (if installing/compiling). While preparation time can be interesting --
> > > for example, if preparation involves reading a lot of files from disk,
> > > it's not universally interesting when it's not the critical phase of a
> > > benchmark.
> >
> > The benchmark is completely downloaded prior to the runs.  There seems to
> > be some perturbation to the activation of containerd.  Normally it is
> > even:  *   *   *   *
>
> Does it impact the benchmark results too or only the preparation prior
> to running the benchmark ?
>
> >
> > and with the patch it becomes more like: *     **     **
> >
> > That is every other one is on time, and every other one is late.
> >
> > But I don't know why this happens.
> >
> > julia
> >
> > >
> > > I think it would be better to wait until the problem is fully understood
> > > to see if it's a timing artifact (e.g. a race between when prev_cpu is
> > > observed to be idle and when it is busy).
>
> I agree that a better understanding of what is happening is necessary
> before any changes

The tests were incorrect.  The faster ones without the patch were with
schedutil.  If we use powersave with the patch or without we get the same
setup time and comparable values for the metrics for the actual benchmarks
(some of which vary a lot, though).

So there is no evidence of any problem with the patch.

julia
