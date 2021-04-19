Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D23364A33
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 21:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbhDSTBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 15:01:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230295AbhDSTBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 15:01:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25C9E61369
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618858831;
        bh=mjG/94F4oRSL6XX4zs59mpfmrhxsYQ1jFKNKP838jfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MZnGpoqnsq400z/bBtlw1PGZnKqx4WTr+v3bNMVYucoXGgRZDe5ocAG2A5xIVgcbZ
         oi8eoAJh5Ub1Vvl4qgfpACxZPL0KDAxsM0+ELoX6FQIwYTS5UCz/Lw1GN3E01hcad/
         e3lE6PW+6Feu0og8cB7R8bPX5Jpj4F+ZvxFE+htW8v1i6o841hGsnEaMOUYYl/6lLA
         BCBnJVAJcsi4N3wDOkSPXccTWqV/sfZIo4QqSwpZrlRq/KP/hp7rVXULBkWNH8LEV3
         ZKS9lUvYGSgfbSTIYlAS14WXM331iXV3npEM3rUFMUOF5bhHuRWvD/40dUh3eaGTju
         61ami1uOUSZkQ==
Received: by mail-ej1-f44.google.com with SMTP id w3so54605507ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 12:00:31 -0700 (PDT)
X-Gm-Message-State: AOAM533ST4OrxY/tA1CKUrT6cqaG06sjQKuvzsbQj0uo768A5lldybrT
        NuNF77OYWpd1uTGbarNDzVeo3qpReATDNvQWVg==
X-Google-Smtp-Source: ABdhPJw0+olVhafs3muGSwDi5hHwzQfymSb1Dpo1k1zo8Cm1ew3aCvMtuUYzi/9x6eTboHBkAhF6WbLNce0G+Tsueyo=
X-Received: by 2002:a17:906:18e1:: with SMTP id e1mr7077742ejf.341.1618858829585;
 Mon, 19 Apr 2021 12:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210311000837.3630499-1-robh@kernel.org> <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck> <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
 <20210331160059.GD7815@willie-the-truck> <CAL_Jsq+ga_-5=UBTAn4eGhpL6j2aWFVh9CdxR4XSG7WpYfxNsA@mail.gmail.com>
 <20210407124437.GA15622@willie-the-truck> <20210408110800.GA32792@C02TD0UTHF1T.local>
 <CAL_Jsq+H_asWWrHiCk-PBS8xDEGpBL1__dRyrPXdBYgRBBw2vA@mail.gmail.com> <20210419161429.GA30998@willie-the-truck>
In-Reply-To: <20210419161429.GA30998@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 19 Apr 2021 14:00:17 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKV_m8tzKpBq=3w-LUksWLmU-1mO1GgQS1nB9sDJanEpQ@mail.gmail.com>
Message-ID: <CAL_JsqKV_m8tzKpBq=3w-LUksWLmU-1mO1GgQS1nB9sDJanEpQ@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
To:     Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2021 at 11:14 AM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Apr 08, 2021 at 01:38:17PM -0500, Rob Herring wrote:
> > On Thu, Apr 8, 2021 at 6:08 AM Mark Rutland <mark.rutland@arm.com> wrote:
> > > On Wed, Apr 07, 2021 at 01:44:37PM +0100, Will Deacon wrote:
> > > > On Thu, Apr 01, 2021 at 02:45:21PM -0500, Rob Herring wrote:
> > > > > On Wed, Mar 31, 2021 at 11:01 AM Will Deacon <will@kernel.org> wrote:
> > > > I guess I'm just worried about exposing the counters to userspace after
> > > > the PMU driver (or perf core?) thinks that they're no longer exposed in
> > > > case we leak other events.
> > >
> > > IMO that's not practically different from the single-PMU case (i.e.
> > > multi-PMU isn't material, either we have a concern with leaking or we
> > > don't); more on that below.
>
> Well, maybe. It looks the single-PMU case is exposed to the same issue,
> but I think a solution needs to take into account the multi-PMU situation.
>
> > > While it looks odd to place this on the mm, I don't think it's the end
> > > of the world.
> > >
> > > > However, I'm not sure how this is supposed to work normally: what
> > > > happens if e.g. a privileged user has a per-cpu counter for a kernel
> > > > event while a task has a counter with direct access -- can that task
> > > > read the kernel event out of the PMU registers from userspace?
> > >
> > > Yes -- userspace could go read any counters even though it isn't
> > > supposed to, and could potentially infer information from those. It
> > > won't have access to the config registers or kernel data structures, so
> > > it isn't guaranteed to know what the even is or when it is
> > > context-switched/reprogrammed/etc.
> > >
> > > If we believe that's a problem, then it's difficult to do anything
> > > robust other than denying userspace access entirely, since disabling
> > > userspace access while in use would surprise applications, and denying
> > > privileged events would need some global state that we consult at event
> > > creation time (in addition to being an inversion of privilege).
> > >
> > > IIRC there was some fuss about this a while back on x86; I'll go dig and
> > > see what I can find, unless Peter has a memory...
> >
> > Maybe this one[1].
> >
> > Rob
> >
> > [1] https://lore.kernel.org/lkml/20200730123815.18518-1-kan.liang@linux.intel.com/
>
> Going through the archives and talking to Peter, it looks like this is still
> an active area of concern:
>
>   - There are patches to clear "dirty" counters on context-switch. They were
>     queued for 5.13 but broke -tip on Friday:
>
>     https://lore.kernel.org/lkml/YHm%2FM4za2LpRYePw@hirez.programming.kicks-ass.net/

Yes, nice timing. I've reworked the arm64 support to do the same
things (minus the breakage). And it looks like we can simplify things
a bit by moving all the context switch handling into .sched_task() and
out of switch_mm. Unless there's some case where that wouldn't work
that I'm not aware of (entirely likely).

>   - Per-cpu events cannot be protected in software:
>
>     https://lore.kernel.org/lkml/CALCETrVVPzUd_hQ8xoomHn_wWRQJUvROeCt2do4_D4ROZoAVMg@mail.gmail.com/
>
>     so without hardware support, we need a way to disable user access for
>     people that care about this leakage
>
> x86 has an "rdpmc" file exposed for the PMU device in sysfs which allows
> access to be disabled. I don't think these patches add such a thing, and
> that's where the fun with multi-PMU machines would come into play.

The fun is because sysfs will end up with multiple 'rdpmc' files or
something else?

Rob
