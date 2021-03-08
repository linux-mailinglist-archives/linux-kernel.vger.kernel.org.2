Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D453309BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 09:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhCHIvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:51:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhCHIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:51:40 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0833FC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 00:51:39 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id s7so8526049qkg.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 00:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvGRHqau0LSmQ9iEWw12UBeW9r6P6L8hPcU6HqXjj08=;
        b=sgPSOKRWLm6l3BAaik/aRFPj2DJYEKc6lxPGJFrTmAstEjFDx/3g/j8VkK5LfKNGNa
         QWELWKrlpeoayvgVC+oTm6DEr4IwL88vwSTwJFCIoK+dZTEQ9FGJtXNyasjOHmgAZ11Q
         1m7ao7NS7XJNCI5/rUwgQKN3/uYGHj8ROdRS2o3/EsggIuTTTUih3BJij67jlpbqjoq1
         q2FmEBLXYIdeV3QZqoRb3IMjcQYN2VoYRRUoSIxZBL9VxMPo31+cHOo0Wnljw42rdSY1
         L/m2qnYAQ9XINQV5WjAFeCtuBJ8S/+hJNi6t/UPiMQLPV4u25zm7SQ5dE7AAlpdA2ZM8
         nE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvGRHqau0LSmQ9iEWw12UBeW9r6P6L8hPcU6HqXjj08=;
        b=T6343rpIqnIUNINW3JL9z1Fd8Y2xYGGbsaw/PgA9cQ822doXw3gX77GGn4wgT39oI7
         cYHo4DFxxxALEkp0Y5Pnsnto4qevrrMIIxQoiThR3dT4RbACj5oGcOw4fi2nRfXBQz1T
         z125sCubfYogR5bbd95l09izVUkLLwuwB2nTxUbl+YuOnvrLsEyUPRh3iUdCDA0blkg8
         09juilI+IYlHGBRuYet6RcVrCzwyVsJNdTd1/8+HiWqwB0o4CjRLtalLf4DPxFof4bxF
         gTF+1WaAnLq2VXfDAXlcmsHJV+qgFfEj9DIE1rfc0OpHmGtaq9EKQJBJC48wEfwhgwwa
         OSXQ==
X-Gm-Message-State: AOAM531Xop7fT2nE/Y1FKbE1ccuNtPAmlHe2m2nJR6ETXTnG5wtoVM1g
        0+vmJn4yz0hrFLM2eIQNHobOD3cy7kFBLYySu/earg==
X-Google-Smtp-Source: ABdhPJxQTLx+S3PrTR0kVWdSXZMkHv0ZPMDpul/nG5VWP9YkR/HL8OiLJ25KRusXgouHw6zsFrUc+u4dH+CSx5Ip6xU=
X-Received: by 2002:a37:46cf:: with SMTP id t198mr19538732qka.265.1615193498862;
 Mon, 08 Mar 2021 00:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20210305223331.4173565-1-seanjc@google.com> <053d0a22-394d-90d0-8d3b-3cd37ca3f378@intel.com>
 <CACT4Y+YTjezgnY_KHzey1q_vDYD7jZCEHU6eOmKHnXYXbzUdcA@mail.gmail.com> <2a21980b-7b0a-0de2-d417-09c7c80100cd@linux.intel.com>
In-Reply-To: <2a21980b-7b0a-0de2-d417-09c7c80100cd@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 8 Mar 2021 09:51:25 +0100
Message-ID: <CACT4Y+aCP1my-ywPoLTBuSQB1gg-1Ja1M__Xo1W-_EN7PpaAow@mail.gmail.com>
Subject: Re: [PATCH] x86/perf: Fix guest_get_msrs static call if there is no PMU
To:     Like Xu <like.xu@linux.intel.com>
Cc:     "Xu, Like" <like.xu@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Mar 8, 2021 at 9:35 AM Like Xu <like.xu@linux.intel.com> wrote:
>
> On 2021/3/8 15:12, Dmitry Vyukov wrote:
> > On Mon, Mar 8, 2021 at 3:26 AM Xu, Like <like.xu@intel.com> wrote:
> >>
> >> On 2021/3/6 6:33, Sean Christopherson wrote:
> >>> Handle a NULL x86_pmu.guest_get_msrs at invocation instead of patching
> >>> in perf_guest_get_msrs_nop() during setup.  If there is no PMU, setup
> >>
> >> "If there is no PMU" ...
> >>
> >> How to set up this kind of environment,
> >> and what changes are needed in .config or boot parameters ?
> >
> > Hi Xu,
> >
> > This can be reproduced in qemu with "-cpu max,-pmu" flag using this reproducer:
> > https://groups.google.com/g/syzkaller-bugs/c/D8eHw3LIOd0/m/L2G0lVkVBAAJ
>
> Sorry, I couldn't reproduce any VMX abort with "-cpu max,-pmu".
> Doe this patch fix this "unexpected kernel reboot" issue ?
>
> If so, you may add "Tested-by" for more attention.

There is an uninit involved. For me it crashed reliably when kernel
compiled with clang 11, but with gcc it worked most of the time.
You may try to add something like:

--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6581,6 +6581,7 @@ static void atomic_switch_perf_msrs(struct vcpu_vmx *vmx)
        struct perf_guest_switch_msr *msrs;

+      nr_msrs = 12345678;
        msrs = perf_guest_get_msrs(&nr_msrs);
+       pr_err("atomic_switch_perf_msrs: msrs=%px nr_msrs=%d\n", msrs, nr_msrs);

Then you will see surprising things.


> >>> bails before updating the static calls, leaving x86_pmu.guest_get_msrs
> >>> NULL and thus a complete nop.
> >>
> >>> Ultimately, this causes VMX abort on
> >>> VM-Exit due to KVM putting random garbage from the stack into the MSR
> >>> load list.
> >>>
> >>> Fixes: abd562df94d1 ("x86/perf: Use static_call for x86_pmu.guest_get_msrs")
> >>> Cc: Like Xu <like.xu@linux.intel.com>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Jim Mattson <jmattson@google.com>
> >>> Cc: kvm@vger.kernel.org
> >>> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> >>> Signed-off-by: Sean Christopherson <seanjc@google.com>
> >>> ---
> >>>    arch/x86/events/core.c | 16 +++++-----------
> >>>    1 file changed, 5 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >>> index 6ddeed3cd2ac..ff874461f14c 100644
> >>> --- a/arch/x86/events/core.c
> >>> +++ b/arch/x86/events/core.c
> >>> @@ -671,7 +671,11 @@ void x86_pmu_disable_all(void)
> >>>
> >>>    struct perf_guest_switch_msr *perf_guest_get_msrs(int *nr)
> >>>    {
> >>> -     return static_call(x86_pmu_guest_get_msrs)(nr);
> >>> +     if (x86_pmu.guest_get_msrs)
> >>> +             return static_call(x86_pmu_guest_get_msrs)(nr);
> >>
> >> How about using "static_call_cond" per commit "452cddbff7" ?
> >>
> >>> +
> >>> +     *nr = 0;
> >>> +     return NULL;
> >>>    }
> >>>    EXPORT_SYMBOL_GPL(perf_guest_get_msrs);
> >>>
> >>> @@ -1944,13 +1948,6 @@ static void _x86_pmu_read(struct perf_event *event)
> >>>        x86_perf_event_update(event);
> >>>    }
> >>>
> >>> -static inline struct perf_guest_switch_msr *
> >>> -perf_guest_get_msrs_nop(int *nr)
> >>> -{
> >>> -     *nr = 0;
> >>> -     return NULL;
> >>> -}
> >>> -
> >>>    static int __init init_hw_perf_events(void)
> >>>    {
> >>>        struct x86_pmu_quirk *quirk;
> >>> @@ -2024,9 +2021,6 @@ static int __init init_hw_perf_events(void)
> >>>        if (!x86_pmu.read)
> >>>                x86_pmu.read = _x86_pmu_read;
> >>>
> >>> -     if (!x86_pmu.guest_get_msrs)
> >>> -             x86_pmu.guest_get_msrs = perf_guest_get_msrs_nop;
> >>> -
> >>>        x86_pmu_static_call_update();
> >>>
> >>>        /*
> >>
>
