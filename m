Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C03324C5C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbhBYJBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbhBYJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:01:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DA4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:00:20 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so4136999wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 01:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P+rEmEXJeIEMkgM7yp/Rzria8ljpilKMeBye3y/9kaU=;
        b=VfuNiNTgc49NflI9eoGah9pBYU2L1UTSfTEVaqWAAAeHZPMzSUw6Zhmx+tWw+uH/Ee
         +XIm7hnv+pA6ugZjNgb++y79n/EUdKL2CL0NQjUpe9g5/1hGrLz0fomtcGe1Q4SNPGRh
         fL5wbi1or6UPHJjhETzLuYV/ihL3fDIeCSnVC+Hd/Xihq2bHPRXIjuDoZenpRHYJiSIB
         QB+zCEp4l8KewoBxoQswN6U/hLmD2hvvg9rLfxqkdwc+cHQnDin4r0g8S0IvLddj40Nv
         2bBxzsngR0lsdTyPigwuNSY7LSqdzPRxZx6X1G0uv3vqVaZuZmfalHlV4thIvFKLpZXA
         fC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P+rEmEXJeIEMkgM7yp/Rzria8ljpilKMeBye3y/9kaU=;
        b=tL4ediNoKPI6fzspcGsW0TA+OD6BTMqGgXLLk/jlib52p1eXjV7Ln49gaU+t9lQKwu
         17lgb9VlW7euissjpzvU8IgEDZKixJswxg69LuMos0fhLGkWg6X8wPhcgmffuN2NdKW3
         XnpFwwXLfmC4FDjH7WGJJsM/bugSnKX5buA4/23HhBRnXGfLaRmgoZWFne35e5+K37iF
         s/N0Jwq2KmJTkB09amLqcD8o7u2PiiPwjK8Gr8PAEjj5FrxgQHlZj6H85/859Uk4y9Rw
         9mNOFgsf9X5ZKHGEYFq/sSkiNoIOLrR9hNF6USHlhOJOlgvN0QfHJGO0zSClhCyf0yXf
         +OnQ==
X-Gm-Message-State: AOAM53280McprAfRs+MvmX+lML6pnZl6iyNXa9E025XPpGce1CC6WuxK
        jLc5cVk5ylJBdF/7r3UtWDX270o56mH4dQU6pOUmMxUyGS0=
X-Google-Smtp-Source: ABdhPJzNUrqDP+jLJiG5v8dfg71aM478kKEj5xBrHxryHtgP9gyaogjiQLO5FsTcBaZVjjZuDCrIJOgIwXUZ66p8fFM=
X-Received: by 2002:a1c:5f89:: with SMTP id t131mr2069609wmb.173.1614243619445;
 Thu, 25 Feb 2021 01:00:19 -0800 (PST)
MIME-Version: 1.0
References: <20210210083327.22726-1-namhyung@kernel.org>
In-Reply-To: <20210210083327.22726-1-namhyung@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 25 Feb 2021 01:00:08 -0800
Message-ID: <CABPqkBQCmTX5N40nj_+kf6qza1mqtbRg_QA_d3c0HeypgHAk+A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] perf core: Factor out __perf_sw_event_sched
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Any comments on this patch series?

It is quite useful to be able to count the number of cgroup switches
simply using perf stat/record.
Not all context switches (cs) are necessarily cgroup switches.
Thanks.

On Wed, Feb 10, 2021 at 12:33 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> In some cases, we need to check more than whether the software event
> is enabled.  So split the condition check and the actual event
> handling.  This is a preparation for the next change.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  include/linux/perf_event.h | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index fab42cfbd350..2a1be6026a2f 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1174,30 +1174,24 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
>   * which is guaranteed by us not actually scheduling inside other swevents
>   * because those disable preemption.
>   */
> -static __always_inline void
> -perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
> +static __always_inline void __perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
>  {
> -       if (static_key_false(&perf_swevent_enabled[event_id])) {
> -               struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
> +       struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
>
> -               perf_fetch_caller_regs(regs);
> -               ___perf_sw_event(event_id, nr, regs, addr);
> -       }
> +       perf_fetch_caller_regs(regs);
> +       ___perf_sw_event(event_id, nr, regs, addr);
>  }
>
>  extern struct static_key_false perf_sched_events;
>
> -static __always_inline bool
> -perf_sw_migrate_enabled(void)
> +static __always_inline bool __perf_sw_enabled(int swevt)
>  {
> -       if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
> -               return true;
> -       return false;
> +       return static_key_false(&perf_swevent_enabled[swevt]);
>  }
>
>  static inline void perf_event_task_migrate(struct task_struct *task)
>  {
> -       if (perf_sw_migrate_enabled())
> +       if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS))
>                 task->sched_migrated = 1;
>  }
>
> @@ -1207,11 +1201,9 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
>         if (static_branch_unlikely(&perf_sched_events))
>                 __perf_event_task_sched_in(prev, task);
>
> -       if (perf_sw_migrate_enabled() && task->sched_migrated) {
> -               struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);
> -
> -               perf_fetch_caller_regs(regs);
> -               ___perf_sw_event(PERF_COUNT_SW_CPU_MIGRATIONS, 1, regs, 0);
> +       if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
> +           task->sched_migrated) {
> +               __perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
>                 task->sched_migrated = 0;
>         }
>  }
> @@ -1219,7 +1211,8 @@ static inline void perf_event_task_sched_in(struct task_struct *prev,
>  static inline void perf_event_task_sched_out(struct task_struct *prev,
>                                              struct task_struct *next)
>  {
> -       perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
> +       if (__perf_sw_enabled(PERF_COUNT_SW_CONTEXT_SWITCHES))
> +               __perf_sw_event_sched(PERF_COUNT_SW_CONTEXT_SWITCHES, 1, 0);
>
>         if (static_branch_unlikely(&perf_sched_events))
>                 __perf_event_task_sched_out(prev, next);
> @@ -1475,8 +1468,6 @@ static inline int perf_event_refresh(struct perf_event *event, int refresh)
>  static inline void
>  perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)    { }
>  static inline void
> -perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)                    { }
> -static inline void
>  perf_bp_event(struct perf_event *event, void *data)                    { }
>
>  static inline int perf_register_guest_info_callbacks
> --
> 2.30.0.478.g8a0d178c01-goog
>
