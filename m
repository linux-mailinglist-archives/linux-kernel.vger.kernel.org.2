Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E244416299
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbhIWQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:03:38 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46907 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233772AbhIWQDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:03:34 -0400
Received: by mail-lf1-f44.google.com with SMTP id z24so29056385lfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=//4vm2Zk0xHX2cAPLBijbFAl7mQX/1oOOmYkGnVPPUY=;
        b=ao0h/H0TAVX/fw7DmlUj7gUu+4uKl8/z/CJSRzLfFc8/Z8e/NxyeD/RQnjQyyHl7p0
         IDk6W+1JIx1WA62E16fsVSRQ4ORW6nglgyHgSe/9DNkzRIO0MLx2H8j5BR4QUBtI73ye
         Le2zKJHZdVclXfFsHjfPtMVLBwyRWVm4cri9MTif1zuV4tfVCFGphwuGHxL+u6RDG4NG
         LeBbjms7HpDrz/kEltRtNxQVwmLucBO1q4jQTk5Mr1i7FfGmJfp70h7bhyh3m3ecUIsv
         2WujMp1XMzHM7xTY3Ji2Q9Oh29br1cYCSn3zvH6ae7//kIb18XaI6oyT/tt7ZBJMe6Mk
         Hvew==
X-Gm-Message-State: AOAM532/XVNEVoAtclQW858GcXXSDLQIX869X1xdrcgQWKKo+evSj1Qj
        2IvqKSkXIXgFN/O/v25cvj8yEmwiBJVWHsfW2mo=
X-Google-Smtp-Source: ABdhPJwyXFii+C3MLVuOkfsZfcjHpJR3wO4JkQCyd1RBao+Xmzm06UEA0/o8wHfPqoeYbvGB6Ch6XsLHCQBK3RXDQAU=
X-Received: by 2002:a05:6512:128f:: with SMTP id u15mr5061602lfs.528.1632412921227;
 Thu, 23 Sep 2021 09:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210916001748.1525291-1-namhyung@kernel.org> <20210916135418.GA383600@leoy-ThinkPad-X240s>
 <CAM9d7chQjzEm7=UpjtTBbsob7kT+=9v16P30hWxnna7mbHu=2g@mail.gmail.com> <20210923142305.GA603008@leoy-ThinkPad-X240s>
In-Reply-To: <20210923142305.GA603008@leoy-ThinkPad-X240s>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 23 Sep 2021 09:01:49 -0700
Message-ID: <CAM9d7cixyD6ZmXnBnoB8Zg-JN-tWYXUdqURHGn+2ZMD5x9evew@mail.gmail.com>
Subject: Re: [RFC] perf arm-spe: Track task context switch for cpu-mode events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

On Thu, Sep 23, 2021 at 7:23 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Namhyung,
>
> On Thu, Sep 16, 2021 at 02:01:21PM -0700, Namhyung Kim wrote:
>
> [...]
>
> > > Before we had discussion for enabling PID/TID for SPE samples; in the patch
> > > set [1], patches 07, 08 set sample's pid/tid based on the Arm SPE context
> > > packets.  To enable hardware tracing context ID, you also needs to enable
> > > kernel config CONFIG_PID_IN_CONTEXTIDR.
> >
> > Thanks for sharing this.
> >
> > Yeah I also look at the context info but having a dependency on a kconfig
> > looks limiting its functionality.  Also the kconfig says it has some overhead
> > in the critical path (even if perf is not running, right?) - but not sure how
> > much it can add.
>
> Yes, after enabled config PID_IN_CONTEXTIDR, the kernel will always
> write PID into the system register CONTEXTIDR during process context
> switching.  Please see the flow:
>
>   __switch_to() (arch/arm64/kernel/process.c)
>     `-> contextidr_thread_switch(next)

Thanks for the info.  I assume it's a light-weight operation.


> > > We also considered to use PERF_RECORD_SWITCH_CPU_WIDE event for setting
> > > pid/tid, the Intel PT implementation uses two things to set sample's
> > > pid/tid: one is PERF_RECORD_SWITCH_CPU_WIDE event and another is to detect
> > > the branch instruction is the symbol "__switch_to".  Since the trace
> > > event PERF_RECORD_SWITCH_CPU_WIDE is coarse, so it only uses the new
> > > pid/tid after the branch instruction for "__switch_to".  Arm SPE is
> > > 'statistical', thus it cannot promise the trace data must contain the
> > > branch instruction for "__switch_to", please see details [2].
> >
> > I can see the need in the Intel PT as it needs to trace all (branch)
> > instructions, but is it really needed for ARM SPE too?
> > Maybe I am missing something, but it seems enough to have a
> > coarse-grained context switch for sampling events..
>
> The issue is that the coarse-grained context switch if introduces any
> inaccuracy in the reported result.  If we can run some workloads and
> prove the coarse-grained context switch doesn't cause significant bias,
> it will be great and can give us the confidence for this approach.
>
> Even enabling PERF_RECORD_SWITCH_CPU_WIDE event, I think it's good to
> give priority for hardware PID tracing in Arm SPE trace data, if detects
> the hardware PID tracing is enabled, then we can rollback to use
> context packets from hardware trace data to set sample's PID.
>
> How about you think for this?

I think it's good as long as it has a fallback when the context info
is not available.

Thanks,
Namhyung
