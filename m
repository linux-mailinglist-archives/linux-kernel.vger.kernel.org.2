Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE6394684
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhE1Rec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 13:34:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhE1Rea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 13:34:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6579A613B5;
        Fri, 28 May 2021 17:32:55 +0000 (UTC)
Date:   Fri, 28 May 2021 13:32:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, corbet@lwn.net, mtosatti@redhat.com
Subject: Re: [RFC] trace: Add option for polling ring buffers
Message-ID: <20210528133253.27c749ab@gandalf.local.home>
In-Reply-To: <20210519175755.670876-1-nsaenzju@redhat.com>
References: <20210519175755.670876-1-nsaenzju@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 19:57:55 +0200
Nicolas Saenz Julienne <nsaenzju@redhat.com> wrote:

> To minimize trace's effect on isolated CPUs. That is, CPUs were only a
> handful or a single, process are allowed to run. Introduce a new trace
> option: 'poll-rb'.
> 
> This option changes the heuristic used to wait for data on trace
> buffers. The default one, based on wait queues, will trigger an IPI[1]
> on the CPU responsible for new data, which will take care of waking up
> the trace gathering process (generally trace-cmd). Whereas with
> 'poll-rb' we will poll (as in busy-wait) the ring buffers from the trace
> gathering process, releasing the CPUs writing trace data from doing any
> wakeup work.
> 
> This wakeup work, although negligible in the vast majority of workloads,
> may cause unwarranted latencies on systems running trace on isolated
> CPUs. This is made worse on PREEMPT_RT kernels, as they defer the IPI
> handling into a kernel thread, forcing unwarranted context switches on
> otherwise extremely busy CPUs.
> 
> To illustrate this, tracing with PREEMPT_RT=y on an isolated CPU with a
> single process pinned to it (NO_HZ_FULL=y, and plenty more isolation
> options enabled). I see:
>   - 50-100us latency spikes with the default trace-cmd options
>   - 14-10us latency spikes with 'poll-rb'
>   - 11-8us latency spikes with no tracing at all
> 
> The obvious drawback of 'poll-rb' is putting more pressure on the
> housekeeping CPUs. Wasting cycles. Hence the notice in the documentation
> discouraging its use in general.
> 
> [1] The IPI, in this case, an irq_work, is needed since trace might run
> in NMI context. Which is not suitable for wake-ups.

Can't this simply be done in user-space?

Set the reading of the trace buffers to O_NONBLOCK and it wont wait for
buffering to happen, and should prevent it from causing the IPI wake ups.

If you need this for trace-cmd, we can add a --poll option that would do
this.

-- Steve
