Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0F9364805
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 18:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbhDSQPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 12:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232354AbhDSQPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:15:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD7A961246;
        Mon, 19 Apr 2021 16:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618848875;
        bh=R0qX6zD3L/dyw/+Tco9R7q/X8chtUMBh6V7YBfFk1YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVA8t4a8+NhaysC7U3saV/2YYntmCJHB/9EI5YybvNWL8L74H3+8c953dFlPf0vx9
         03IO175VuvVTG18bG4dnqLziIagpLllJl6wjWGXEMfLWtgKAlnxaNZUTgYItSNTm8L
         8javIOMGkTo/b94z1IWii1GSxKo9ZNUi07ZHCdaGO7XcfWNKu6JRKGDl2up7P1YQY0
         ma8nAqLcJgAdFqkaS7ZLU95N22JVWq0CHBLNbcqKPrLbPa7n+nfh0/8cCnx8vTR68Q
         /g7Sws7RYLW3xYqlwAOtt54vuo4vqTM6Vb7whEyqPoCRzkG0gCupzF7bFxsscjXXff
         jb5etUY+VMcFQ==
Date:   Mon, 19 Apr 2021 17:14:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
Message-ID: <20210419161429.GA30998@willie-the-truck>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck>
 <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
 <20210331160059.GD7815@willie-the-truck>
 <CAL_Jsq+ga_-5=UBTAn4eGhpL6j2aWFVh9CdxR4XSG7WpYfxNsA@mail.gmail.com>
 <20210407124437.GA15622@willie-the-truck>
 <20210408110800.GA32792@C02TD0UTHF1T.local>
 <CAL_Jsq+H_asWWrHiCk-PBS8xDEGpBL1__dRyrPXdBYgRBBw2vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+H_asWWrHiCk-PBS8xDEGpBL1__dRyrPXdBYgRBBw2vA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 01:38:17PM -0500, Rob Herring wrote:
> On Thu, Apr 8, 2021 at 6:08 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Apr 07, 2021 at 01:44:37PM +0100, Will Deacon wrote:
> > > On Thu, Apr 01, 2021 at 02:45:21PM -0500, Rob Herring wrote:
> > > > On Wed, Mar 31, 2021 at 11:01 AM Will Deacon <will@kernel.org> wrote:
> > > I guess I'm just worried about exposing the counters to userspace after
> > > the PMU driver (or perf core?) thinks that they're no longer exposed in
> > > case we leak other events.
> >
> > IMO that's not practically different from the single-PMU case (i.e.
> > multi-PMU isn't material, either we have a concern with leaking or we
> > don't); more on that below.

Well, maybe. It looks the single-PMU case is exposed to the same issue,
but I think a solution needs to take into account the multi-PMU situation.

> > While it looks odd to place this on the mm, I don't think it's the end
> > of the world.
> >
> > > However, I'm not sure how this is supposed to work normally: what
> > > happens if e.g. a privileged user has a per-cpu counter for a kernel
> > > event while a task has a counter with direct access -- can that task
> > > read the kernel event out of the PMU registers from userspace?
> >
> > Yes -- userspace could go read any counters even though it isn't
> > supposed to, and could potentially infer information from those. It
> > won't have access to the config registers or kernel data structures, so
> > it isn't guaranteed to know what the even is or when it is
> > context-switched/reprogrammed/etc.
> >
> > If we believe that's a problem, then it's difficult to do anything
> > robust other than denying userspace access entirely, since disabling
> > userspace access while in use would surprise applications, and denying
> > privileged events would need some global state that we consult at event
> > creation time (in addition to being an inversion of privilege).
> >
> > IIRC there was some fuss about this a while back on x86; I'll go dig and
> > see what I can find, unless Peter has a memory...
> 
> Maybe this one[1].
> 
> Rob
> 
> [1] https://lore.kernel.org/lkml/20200730123815.18518-1-kan.liang@linux.intel.com/

Going through the archives and talking to Peter, it looks like this is still
an active area of concern:

  - There are patches to clear "dirty" counters on context-switch. They were
    queued for 5.13 but broke -tip on Friday:

    https://lore.kernel.org/lkml/YHm%2FM4za2LpRYePw@hirez.programming.kicks-ass.net/

  - Per-cpu events cannot be protected in software:

    https://lore.kernel.org/lkml/CALCETrVVPzUd_hQ8xoomHn_wWRQJUvROeCt2do4_D4ROZoAVMg@mail.gmail.com/

    so without hardware support, we need a way to disable user access for
    people that care about this leakage

x86 has an "rdpmc" file exposed for the PMU device in sysfs which allows
access to be disabled. I don't think these patches add such a thing, and
that's where the fun with multi-PMU machines would come into play.

Will
