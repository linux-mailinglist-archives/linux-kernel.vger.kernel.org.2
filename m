Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4926F39E8D9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFGVG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 17:06:28 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]:43522 "EHLO
        mail-qv1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhFGVG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 17:06:27 -0400
Received: by mail-qv1-f46.google.com with SMTP id e18so9641486qvm.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 14:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GGBwGm5k7PB2hnUFXG4AgmxjBeqKouZKlwO2MjG0pQI=;
        b=QaSDr6Dqf9UTx0mkv7jDK1pIQDcF3Lgpq2R6rZYy0Qc+1vWZSCgM+333YPozjm6lAH
         0IBg3tWQNOk/y9QxLKi3Kzp41L0RlnH4qT86HhEnOiFSYJ4cSrMfPHUNkAHo18P9fiRO
         WnVgpuSaqLCSYqfL088NMaUcrcAviza1ciqqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GGBwGm5k7PB2hnUFXG4AgmxjBeqKouZKlwO2MjG0pQI=;
        b=EF86AHGxYadhd/zYmufqZs7Z+CAv87EjLpvNZF0VHUTaY7DeC4mPVoihAxbV+Ia7yf
         kMz53yLUArp7gxqRifeqTCzbQGmKp69hmwOI+WNcA6cJqkqwVdeLJvYdc2NRMP8ZEX7c
         9zcqWvqe43s2dAMFtayHKOlGhWTsIp+oE/iqG4KXJnMCrT0Zwg3LXOSnso7Z0bTsPgd+
         1oclpdddlIW2s5z/ZuirviQj4pDThf28laiClK8e2oKLU5EXqaPb/73D8k5HU37U44iN
         PrIyhORFWpLslhCKVfLe7Hc1Hp7NdlvGvrecBUFTLit2sJM1Tt61mBl7X6Iq7wZZSHiJ
         8RYQ==
X-Gm-Message-State: AOAM533i1lazEPF//JLbTQpY02hNIfQh/epoeDIrbGNkrz2IhoMyFVhv
        wpcRwwAqJdVAc6lm8uzV4ofiUH7dQXKdYQ==
X-Google-Smtp-Source: ABdhPJwK7/O/kVHJFETXsyPYLihrnMe08OqOqlJpzFW95ZRHFY+Tn+hTVxoKfmlRWOypjZ7OBsULfQ==
X-Received: by 2002:a0c:cdc9:: with SMTP id a9mr20181077qvn.51.1623099815564;
        Mon, 07 Jun 2021 14:03:35 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id h14sm7915487qtp.46.2021.06.07.14.03.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 14:03:35 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id y2so26932145ybq.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 14:03:35 -0700 (PDT)
X-Received: by 2002:a25:b801:: with SMTP id v1mr28601197ybj.32.1623099450508;
 Mon, 07 Jun 2021 13:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210507205513.640780-1-dianders@chromium.org>
 <20210507135509.2.Ib54050e4091679cc31b04d52d7ef200f99faaae5@changeid> <47a95789-ca75-70a5-9d65-a2d3e9c651bc@arm.com>
In-Reply-To: <47a95789-ca75-70a5-9d65-a2d3e9c651bc@arm.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 7 Jun 2021 13:57:19 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1ChMU5dT4kBSTcsoePo7VUEQuoYtRUJuHBdVcgbS0XA@mail.gmail.com>
Message-ID: <CAD=FV=U1ChMU5dT4kBSTcsoePo7VUEQuoYtRUJuHBdVcgbS0XA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: perf: Improve compat perf_callchain_user() for
 clang leaf functions
To:     James Clark <james.clark@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Alexandre Truong <alexandre.truong@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>,
        Al Grant <Al.Grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 7, 2021 at 2:14 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 07/05/2021 23:55, Douglas Anderson wrote:
> > It turns out that even when you compile code with clang with
> > "-fno-omit-frame-pointer" that it won't generate a frame pointer for
> > leaf functions (those that don't call any sub-functions). Presumably
> > clang does this to reduce the overhead of frame pointers. In a leaf
> > function you don't really need frame pointers since the Link Register
> > (LR) is guaranteed to always point to the caller>
> [...]
> >
> >  arch/arm64/kernel/perf_callchain.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
> > index e5ce5f7965d1..b3cd9f371469 100644
> > --- a/arch/arm64/kernel/perf_callchain.c
> > +++ b/arch/arm64/kernel/perf_callchain.c
> > @@ -326,6 +326,20 @@ static void compat_perf_callchain_user(struct perf_callchain_entry_ctx *entry,
> >       while ((entry->nr < entry->max_stack) && fp && !(fp & 0x3)) {
> >               err = compat_perf_trace_1(&fp, &pc, leaf_lr);
> >
> > +             /*
> > +              * If this is the first trace and it didn't find the LR then
> > +              * let's throw it in the trace first. This isn't perfect but
> > +              * is the best we can do for handling clang leaf functions (or
> > +              * the case where we're right at the start of the function
> > +              * before the new frame has been pushed). In the worst case
> > +              * this can cause us to throw an extra entry that will be some
> > +              * location in the same function as the PC. That's not
> > +              * amazing but shouldn't really hurt. It seems better than
> > +              * throwing away the LR.
> > +              */
>
> Hi Douglas,
>
> I think the behaviour with GCC is also similar. We were working on this change
> (https://lore.kernel.org/lkml/20210304163255.10363-4-alexandre.truong@arm.com/)
> in userspace Perf which addresses the same issue.
>
> The basic concept of our version is to record only the link register
> (as in --user-regs=lr). Then use the existing dwarf based unwind
> to determine if the link register is valid for that frame, and then if
> it is and it doesn't already exist on the stack then insert it.
>
> You mention that your version isn't perfect, do you think that saving the
> LR and using something like libunwind in a post process could be better?

Using post processing atop a patch to always save the LR is definitely
the right solution IMO and (I think) you can fully overcome the "no
frame pointers in leaf functions" with the post processing.

-Doug
