Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD93308AA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 08:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235148AbhCHHNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 02:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhCHHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 02:12:52 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB4C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Mar 2021 23:12:52 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b130so8339781qkc.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Mar 2021 23:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C08demyre3kojiX31o1Q1+SA4+m7jyiCUMEVIWTEp4U=;
        b=DorOoQF49lpcIwRZT0Wkw9DqN61pd61/qogSYNxeck5JgfiZKByVfVhsF9gtaH7HXc
         IBPHpmUiLp4VmZphTo2So47jLLq/F8tXH2zYE13lkmYyDi+I1oZQ5LrwJQW2iRT7x4Xw
         cBei59e3u/PJjtGUGfjWbe0YMp9C7bCuB7gAiNt53gxpXMpTq8urUnkxq/hFr3Gs8I3M
         FpCwfIhj9qiMKGc7Xe4a1+6zjOcyjxf6e1z6aOCJpDPAp25UQP5cBhPGsEnqgBBFoXYe
         nWX1SLpJvUMO9s0Q04W5HZdlAm/IXcLFAg/+IcxrJW+rq9wCc0z2EIJPJnjfsSRKdiy3
         CjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C08demyre3kojiX31o1Q1+SA4+m7jyiCUMEVIWTEp4U=;
        b=LC/2/r/o375+3uSsgaEIxKD5p+cs6SqXKOWbFIZ8AnJH/FhYPxk9/8ia3A5TNiEFom
         Yqy0NmKY4AKUcIDJdcwjZ3aJ/ArErZKsvaUruOm4CTEmUOanFCWjLf7mFllCRkP2haY6
         a5WO3zo++MigDUXYNAZzgdzxYTgtV7E8CMgLlZRdDohLN5LCUZq0t2XbltKlfCy7RwiN
         LKpV4xSqN5+vnuROypvjDka238CHdo1c8Yy1tXHF4uqggOedEelLrBucZadS+632I/+Z
         k//f9n5iLG1gXyCuxkwMMpWqqOSY5LsHiXvFRYsJHp7BDFt5ADl5pvJHFzFY+OwA13KF
         AX/A==
X-Gm-Message-State: AOAM530XqdcHk6+L7NmATBt6XOofCZ5g3IPO03E8JtL4vezp0nTZ/zAn
        eEZtQF2oLuIO+Z2vLqmHFGPGTBuoC6XZKw+s1sfvAQ==
X-Google-Smtp-Source: ABdhPJxLghQPyXekh0Nsu/jRTdYDrxaFPxIbTI80ael3XOQY0QngAXAcBGnPr6nYcuFVYLkaHH4SuWOkXm8Q+DnP384=
X-Received: by 2002:a37:4743:: with SMTP id u64mr19589049qka.350.1615187571276;
 Sun, 07 Mar 2021 23:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20210305223331.4173565-1-seanjc@google.com> <053d0a22-394d-90d0-8d3b-3cd37ca3f378@intel.com>
In-Reply-To: <053d0a22-394d-90d0-8d3b-3cd37ca3f378@intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Mar 2021 08:12:36 +0100
Message-ID: <CACT4Y+YTjezgnY_KHzey1q_vDYD7jZCEHU6eOmKHnXYXbzUdcA@mail.gmail.com>
Subject: Re: [PATCH] x86/perf: Fix guest_get_msrs static call if there is no PMU
To:     "Xu, Like" <like.xu@intel.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Like Xu <like.xu@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        KVM list <kvm@vger.kernel.org>,
        "Thomas Gleixner
        (x86/pti/timer/core/smp/irq/perf/efi/locking/ras/objtool)
        (x86@kernel.org)" <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 3:26 AM Xu, Like <like.xu@intel.com> wrote:
>
> On 2021/3/6 6:33, Sean Christopherson wrote:
> > Handle a NULL x86_pmu.guest_get_msrs at invocation instead of patching
> > in perf_guest_get_msrs_nop() during setup.  If there is no PMU, setup
>
> "If there is no PMU" ...
>
> How to set up this kind of environment,
> and what changes are needed in .config or boot parameters ?

Hi Xu,

This can be reproduced in qemu with "-cpu max,-pmu" flag using this reproducer:
https://groups.google.com/g/syzkaller-bugs/c/D8eHw3LIOd0/m/L2G0lVkVBAAJ

> > bails before updating the static calls, leaving x86_pmu.guest_get_msrs
> > NULL and thus a complete nop.
>
> > Ultimately, this causes VMX abort on
> > VM-Exit due to KVM putting random garbage from the stack into the MSR
> > load list.
> >
> > Fixes: abd562df94d1 ("x86/perf: Use static_call for x86_pmu.guest_get_msrs")
> > Cc: Like Xu <like.xu@linux.intel.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Jim Mattson <jmattson@google.com>
> > Cc: kvm@vger.kernel.org
> > Reported-by: Dmitry Vyukov <dvyukov@google.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/events/core.c | 16 +++++-----------
> >   1 file changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index 6ddeed3cd2ac..ff874461f14c 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -671,7 +671,11 @@ void x86_pmu_disable_all(void)
> >
> >   struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
> >   {
> > -     return static_call(x86_pmu_guest_get_msrs)(nr);
> > +     if (x86_pmu.guest_get_msrs)
> > +             return static_call(x86_pmu_guest_get_msrs)(nr);
>
> How about using "static_call_cond" per commit "452cddbff7" ?
>
> > +
> > +     *nr = 0;
> > +     return NULL;
> >   }
> >   EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
> >
> > @@ -1944,13 +1948,6 @@ static void _x86_pmu_read(struct perf_event *event)
> >       x86_perf_event_update(event);
> >   }
> >
> > -static inline struct perf_guest_switch_msr *
> > -perf_guest_get_msrs_nop(int *nr)
> > -{
> > -     *nr = 0;
> > -     return NULL;
> > -}
> > -
> >   static int __init init_hw_perf_events(void)
> >   {
> >       struct x86_pmu_quirk *quirk;
> > @@ -2024,9 +2021,6 @@ static int __init init_hw_perf_events(void)
> >       if (!x86_pmu.read)
> >               x86_pmu.read = _x86_pmu_read;
> >
> > -     if (!x86_pmu.guest_get_msrs)
> > -             x86_pmu.guest_get_msrs = perf_guest_get_msrs_nop;
> > -
> >       x86_pmu_static_call_update();
> >
> >       /*
>
