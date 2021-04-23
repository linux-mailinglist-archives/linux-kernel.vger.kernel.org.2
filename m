Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48666369095
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242131AbhDWKuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:50:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhDWKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:50:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619175012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XflyyTO/magLjGUnfAYTmDLBeZOJLJv+1Pu/8xfWz3w=;
        b=GAJX0SddqFN6+EFawAFonw5VzS3Lhb0erFfim3k1aOyKcvrhlHi/eqIeAIb9thcwkZ4ufL
        zH+8ggjhzMFgD021+sls5+QRpbIjxfZ0rG6SJkJEd8m88XQ7AVytdVKzFk2N9qJsEknq8t
        yUyPwICWBZt3msSkNSLbRvXI6zIs+3JySQGqAfe7WS6xmWKcKx0duYstGITKbg20SaWoXK
        VSwuQmNcONea4u5jk75w7Je4CnJu7GzSTNz/y1J2sVQxsHH9oVgrxI+HAxiI2WN7rHg40x
        VbjHO65rWV0fpPSth/M0r/iytZLYmkADRyPHPPOoLjkK05ne7sjTpjZ7VqSHxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619175012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XflyyTO/magLjGUnfAYTmDLBeZOJLJv+1Pu/8xfWz3w=;
        b=Ln5OoGgyq6VIgqXQwmUEhv5Tj70tIDQyAxo5v+HOK6zbcfXZbFjj0sqxtPI/87eVHOYZr9
        FwGQz0zoQXBnF2Cw==
To:     John Garry <john.garry@huawei.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: Question on threaded handlers for managed interrupts
In-Reply-To: <b8c4be8c-1d67-c16c-570e-d3c883c77ea2@huawei.com>
References: <b8c4be8c-1d67-c16c-570e-d3c883c77ea2@huawei.com>
Date:   Fri, 23 Apr 2021 12:50:12 +0200
Message-ID: <874kfxw9zv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John,

On Thu, Apr 22 2021 at 17:10, John Garry wrote:
> I am finding that I can pretty easily trigger a system hang for certain 
> scenarios with my storage controller.
>
> So I'm getting something like this when running moderately heavy data 
> throughput:
>
> Starting 6 processes
> [70.656622] sched: RT throttling activatedB/s][r=356k,w=0 IOPS][eta
> 01h:14m:43s]
> [  207.632161] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:ta
> 01h:12m:26s]
> [  207.638261] rcu:  0-...!: (1 GPs behind)
> idle=312/1/0x4000000000000000 softirq=508/512 fqs=0
> [  207.646777] rcu:  1-...!: (1 GPs behind) idle=694/0/0x0
>
> It ends pretty badly - see [0].

Obviously.

> The multi-queue storage controller (see [1] for memory refresh, but
> note that I can also trigger on PCI device host controller as well) is
> using managed interrupts and threaded handlers. Since the threaded
> handler uses SCHED_FIFO, aren't we always vulnerable to this situation
> with the managed interrupt and threaded handler combo? Would the
> advice be to just use irq polling here?

This is a really good question. Most interrupt handlers are not running
exceedingly long or come in with high frequency, but of course this
problem exists.

The network people have solved it with NAPI which disables the interrupt
in the device and polls it from softirq context (which might be then
delegated to ksoftirqd) until it's drained.

I'm not familiar with the block/multiqueue layer to be able to tell
whether such a concept exists there as well.

OTOH, the way how you splitted the handling into hard/thread context
provides already the base for this.

The missing piece is infrastructure at the irq/scheduler core level to
handle this transparently.

I have some horrible ideas how to solve that, but I'm sure the scheduler
wizards can come up with a reasonable and generic solution.

Thanks,

        tglx




