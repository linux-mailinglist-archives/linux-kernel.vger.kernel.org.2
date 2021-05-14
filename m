Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9338029C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 05:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhENDwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 23:52:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231829AbhENDwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 23:52:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69A27613F5
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 03:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620964249;
        bh=XyiazPjppFaROOYSjccZd2zCHW55SWs+63nFcLzTYp4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oA9NG2O62su+wNTFIYr+sR5bASS5BoZta5d2X7Skm5bBZfjuiuWrNELQFtJGN1baJ
         akkndb6FA53jirDOGaW7PkeNX16uLfoPMbEE/Ks9U3JQb8xpistQ9K2BUvRXUW89oi
         vY0dbBqg1/HlxNV5VL4+suLqllr1tK1UuP8xS7bUTBy9iUgtBTo19JH+N7ruCJ+JD6
         8xxtmtmYCG6pNqQ7hmId0LOjqwgitPTbN6M1mid4D2SJiWXyzYR5HCZwrqJGT45JSv
         QgiThNI9ZceRRwTtuo8CE6RlkouPwHhwCy1WkJ8PJXDxh5/5Y42bM/Uez/hgyPpCgh
         CoutSXDNI5i9w==
Received: by mail-ej1-f43.google.com with SMTP id c22so14643121ejd.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 20:50:49 -0700 (PDT)
X-Gm-Message-State: AOAM53373oKcyPrt5kqzLmQKQe3Kx1WaL7Uj1itNEyTWhUrBd1dvXjX7
        jP4gBDR0bLPzC9M6Jr0veFPPngvv16jm8cuaiA==
X-Google-Smtp-Source: ABdhPJxu6F4NvbqgAVlIxVxbp7aDwhbj2M84OKyb7M9p5McCYOFzYdlBduEcymzxRLFLfgw9pnmCk87x/GMQcf+7GDY=
X-Received: by 2002:a17:906:ce42:: with SMTP id se2mr17244253ejb.359.1620964248059;
 Thu, 13 May 2021 20:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <1620915782-50154-1-git-send-email-kan.liang@linux.intel.com>
 <1620915782-50154-2-git-send-email-kan.liang@linux.intel.com>
 <YJ0/bjek1ihh/2Ea@hirez.programming.kicks-ass.net> <de8b7f48-9242-c28f-ebaa-5c5137e6c102@linux.intel.com>
In-Reply-To: <de8b7f48-9242-c28f-ebaa-5c5137e6c102@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 13 May 2021 22:50:36 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ8WtTykBPiN6tm=oDPeypChnsSQr-2BpDjXGfmuKXnrg@mail.gmail.com>
Message-ID: <CAL_JsqJ8WtTykBPiN6tm=oDPeypChnsSQr-2BpDjXGfmuKXnrg@mail.gmail.com>
Subject: Re: [PATCH V7 2/2] perf/x86: Reset the dirty counter to prevent the
 leak for an RDPMC task
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Stephane Eranian <eranian@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 5:14 PM Liang, Kan <kan.liang@linux.intel.com> wrote:
>
>
>
> On 5/13/2021 11:02 AM, Peter Zijlstra wrote:
> > On Thu, May 13, 2021 at 07:23:02AM -0700, kan.liang@linux.intel.com wrote:
> >
> >> +    if (x86_pmu.sched_task && event->hw.target) {
> >> +            atomic_inc(&event->pmu->sched_cb_usage);
> >> +            local_irq_save(flags);
> >> +            x86_pmu_clear_dirty_counters();
> >> +            local_irq_restore(flags);
> >> +    }
> >
> > So what happens if our mmap() happens after we've already created two
> > (or more) threads in the process, all of who already have a counter (or
> > more) on?
> >
> > Shouldn't this be something like?
>
> That's not enough.
>
> I implemented a test case as below:
> - The main thread A creates a new thread B.
> - Bind the thread A to CPU 0. Then the thread A opens a event, mmap,
> enable the event, and sleep.
> - Bind the thread B to CPU 1. Wait until the event in the thread A is
> enabled. Then RDPMC can read the counters on CPU 1.
>
> In the x86_pmu_event_mapped(), we do on_each_cpu_mask(mm_cpumask(mm),
> cr4_update_pce, NULL, 1);
> The RDPMC from thread B on CPU 1 is not forbidden.

You want RDPMC disabled since the counters are not cleared? If you had
a cpu bound event for CPU1, then you'd want RDPMC enabled, right?

> Since the counter is not created in thread B, the sched_task() never
> gets a chance to be invoked. The dirty counter is not cleared.
>
> To fix it, I think we have to move the cr4_update_pce() to the context
> switch, and update it only when the RDPMC task is scheduled. But it
> probably brings some overhead.

I'm trying to do a similar approach (if I understand what you mean)
using sched_task() without a switch_mm hook or IPIs. The current
branch is here[1]. I have things working for task bound events, but I
don't think cpu bound events are handled for similar reasons as above.
I'm not too sure that enabling user access for cpu bound events is
really all that useful? Maybe for Arm we should just keep user access
for cpu bound events disabled.

Note for now I'm not doing lazy clearing of counters for simplicity.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
user-perf-event-v8
