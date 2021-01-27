Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A2A3060E0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbhA0QTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 11:19:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236142AbhA0QQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 11:16:36 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A755B20789;
        Wed, 27 Jan 2021 16:15:48 +0000 (UTC)
Date:   Wed, 27 Jan 2021 11:15:47 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Viktor Rosendahl <Viktor.Rosendahl@bmw.de>
Subject: Re: [PATCH] sched/tracing: Reset critical timings on scheduling
Message-ID: <20210127111547.5c33f1c5@gandalf.local.home>
In-Reply-To: <YBFQbF/BqmjXFAd0@hirez.programming.kicks-ass.net>
References: <20210126135718.5bf8d273@gandalf.local.home>
        <YBFQbF/BqmjXFAd0@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 12:37:16 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> And that's just really daft.. why are you adding two unconditional
> function calls to __schedule() that are a complete waste of time
> 99.999999% of the time?
> 
> If anything, this should be fixed in schedule_idle().

Note, those two unconditional calls are only called when you have the
preempt or irqs off latency tracers enabled (which causes overhead on every
preempt_enable/disable and irqs enabled/disabled as well, and why we tell
people not to compile them in if you care about performance).

When irqs and preempt latency tracers are not enabled, we have this:

# define stop_critical_timings() do { } while (0)
# define start_critical_timings() do { } while (0)

static inline void reset_critical_timings(void) {
	stop_critical_timings();
	start_critical_timings();
}

which is basically a nop.

If you still care about the overhead to schedule when these tracers are
enabled (which is not much considered the overhead they cause elsewhere), we
can make it more specific to cpu idle.

I was worried that this could happen more than just in cpu idle, and added
it to the scheduler directly to make sure I got any other case.

-- Steve
