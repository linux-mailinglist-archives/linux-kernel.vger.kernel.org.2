Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B55532C014
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386448AbhCCSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:15:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1452460AbhCCPvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:51:16 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614786631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RN823tMCXXNqDXawfyuWxstSlaVtgyK0k/aEp2eRvyk=;
        b=0U9z21IpN1HCqcdiZ2uTUflwlGeCWs6jQ4h3F9BkHUVhGti652aa8aH/0mdifLipbYIeMy
        xRiwXyqWKNlR3d8eYSWIEa9hDxfInDuryeuYK/Uxs0j8Q6x5ipeN6CUQRTJaQjVtd0zZSr
        8TlPDsBKmRK6JSeeMtsgGwkmsrjSuKOZMd9KWhYnTB6eJjIQFa0XAabDGVmr+Gyn7X1Weh
        i2kkz8fuWKnXSp+FIFRS4hD4Jsw4Qjn/ZzywP7ESxgMTixV/RpyRlASjEgcM2+Kv4zXZdb
        t+p1lwVXRoW6M8zBH3tQaYlIo6feE4xTH6S6Dd7X4Tj1b8FrEBBw2T42zQcj2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614786631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RN823tMCXXNqDXawfyuWxstSlaVtgyK0k/aEp2eRvyk=;
        b=tRVVKXGXof+ij2V3KBbQFz2yWkwAS8YkvIOlAvXoavyQ/dfcQg2WEqeIIU2cO920EukgZu
        zyd8hSFBeTjiyTDg==
To:     Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
In-Reply-To: <20210302120634.GB76460@shbuild999.sh.intel.com>
References: <1614653665-20905-1-git-send-email-feng.tang@intel.com> <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net> <20210302120634.GB76460@shbuild999.sh.intel.com>
Date:   Wed, 03 Mar 2021 16:50:31 +0100
Message-ID: <875z286xtk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02 2021 at 20:06, Feng Tang wrote:
> On Tue, Mar 02, 2021 at 10:16:37AM +0100, Peter Zijlstra wrote:
>> On Tue, Mar 02, 2021 at 10:54:24AM +0800, Feng Tang wrote:
>> > clocksource watchdog runs every 500ms, which creates some OS noise.
>> > As the clocksource wreckage (especially for those that has per-cpu
>> > reading hook) usually happens shortly after CPU is brought up or
>> > after system resumes from sleep state, so add a time limit for
>> > clocksource watchdog to only run for a period of time, and make
>> > sure it run at least twice for each CPU.
>> > 
>> > Regarding performance data, there is no improvement data with the
>> > micro-benchmarks we have like hackbench/netperf/fio/will-it-scale
>> > etc. But it obviously reduces periodic timer interrupts, and may
>> > help in following cases:
>> > * When some CPUs are isolated to only run scientific or high
>> >   performance computing tasks on a NOHZ_FULL kernel, where there
>> >   is almost no interrupts, this could make it more quiet
>> > * On a cluster which runs a lot of systems in parallel with
>> >   barriers there are always enough systems which run the watchdog
>> >   and make everyone else wait
>> > 
>> > Signed-off-by: Feng Tang <feng.tang@intel.com>
>> 
>> Urgh.. so this hopes and prays that the TSC wrackage happens in the
>> first 10 minutes after boot.

which is wishful thinking....

> Yes, the 10 minutes part is only based on our past experience and we
> can make it longer. But if there was real case that the wrackage happened
> long after CPU is brought up like days, then this patch won't help
> much.

It really depends on the BIOS wreckage. On one of my machine it takes up
to a day depending on the workload.

Anything pre TSC_ADJUST wants the watchdog on. With TSC ADJUST available
we can probably avoid it.

There is a caveat though. If the machine never goes idle then TSC adjust
is not able to detect a potential wreckage. OTOH, most of the broken
BIOSes tweak TSC only by a few cycles and that is usually detectable
during boot. So we might be clever about it and schedule a check every
hour when during the first 10 minutes a modification of TSC adjust is
seen on any CPU.

Where is this TSC_DISABLE_WRITE bit again?

Thanks,

        tglx


