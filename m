Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BF230F3F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhBDNez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbhBDNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:34:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADBAC061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vztDQPMe981rlmhqqOurB7P1kTPr1JQmf5lExFoESKQ=; b=JWB6c60a/eNOWPZJcDGyeAh2dC
        AIjfGTAVeZgmYWjHlVZb7/gJqj1whZqVaNMhzkeuzzYCPfoQhj/CpB7ELuex09w7/5yCn1T0UKZsb
        Io6817QRJqp/jNaEvaV7slLXWfcGJRvOGFyDl2Ey2G2tyK4NmzmaksQ4AIdraD6DD3zaJEMr37t4P
        Ju4rZvzapBuT8VMI12Rt8FHGCpnh5Z4ZPG9UVafGfvuzIA5S9+xmcViw+q4Dv/qeu2+tSKWbO6zLV
        qFZQ3TMlwmig8+mWSzNeuiDxPt/y7kcc5Ur9HYfiuUtfJYDkDX0Q9z+BebUzlz0X0O8ABXLTFpVvN
        Lag9auPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l7elL-000vO1-D1; Thu, 04 Feb 2021 13:33:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BDB4E301CC4;
        Thu,  4 Feb 2021 14:33:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 84EC82C0034BF; Thu,  4 Feb 2021 14:33:32 +0100 (CET)
Date:   Thu, 4 Feb 2021 14:33:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matt Morehouse <mascasa@google.com>
Subject: Re: Process-wide watchpoints
Message-ID: <YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net>
References: <CACT4Y+ZsKXfAxrzJGQc5mJ+QiP5sAw7zKWtciS+07qZzSf33mw@mail.gmail.com>
 <CACT4Y+YeRtOTsMQ8xxZg-=nbv+yuJvYYhBErT46M8jtSHmiw6g@mail.gmail.com>
 <YBqXPmbpXf4hnlj3@hirez.programming.kicks-ass.net>
 <CACT4Y+a-9kqX0ZkNz-ygib+ERn41HVo_8Wx6oYMQmPjTC06j7g@mail.gmail.com>
 <YBqnAYVdNM4uyGny@hirez.programming.kicks-ass.net>
 <CACT4Y+btOt5QFKH9Q=81EnpDHoidJUHE2s0oZ8v65t-b__awuw@mail.gmail.com>
 <YBvAsku9OWM7KUno@hirez.programming.kicks-ass.net>
 <CACT4Y+ZLSyVMkPfh3PftEWKC1kC+o1XLxo_o6i4BiyRuPig27g@mail.gmail.com>
 <YBvj6eJR/DY2TsEB@hirez.programming.kicks-ass.net>
 <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+a17L2pUY1kkRB_v_y3P_sbMpSLb6rVfXmGM7LkbAvj5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 01:53:59PM +0100, Dmitry Vyukov wrote:
> On Thu, Feb 4, 2021 at 1:09 PM Peter Zijlstra <peterz@infradead.org> wrote:

> > What do we do then? The advantage of IOC_REFRESH is that it disables the
> > event until it gets explicitly re-armed, avoiding recursion issues etc.
> > Do you want those semantics? If so, we'd need to have IOC_REFRESH find
> > the actual event for the current task, which should be doable I suppose.
> 
> Frankly, I don't know. I didn't use it in my prototype, nor I fully
> understand what it's doing. Does it make sense for breakpoints?
> I see IOC_REFRESH has a check for !attr.inherit, so it will fail for
> my use case currently. I would say we just leave it as is for now.

Well, the way it works is that currently you set event_limit > 0. Then
each event will decrement, when we hit 0 we disable and raise a signal.

REFRESH will increment event_limit and re-enable.

This means you're guaranteed not to get another signal until you're
ready for it. It allows leaving the signal handler context to handle the
signal.

I suppose you're looking for something like this, which goes in top of
that thread_only thing.

--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -389,7 +389,8 @@ struct perf_event_attr {
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
 				thread_only    :  1, /* only inherit on threads */
-				__reserved_1   : 29;
+				sigtrap        :  1, /* foo */
+				__reserved_1   : 28;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6273,6 +6273,13 @@ static void perf_pending_event_disable(s
 
 	if (cpu == smp_processor_id()) {
 		WRITE_ONCE(event->pending_disable, -1);
+
+		if (event->attr.sigtrap) {
+			atomic_inc(&event->event_limit); /* rearm */
+			send_sig_info(SIGTRAP, SEND_SIG_PRIV, current);
+			return;
+		} 
+
 		perf_event_disable_local(event);
 		return;
 	}
@@ -8936,6 +8943,7 @@ static int __perf_event_overflow(struct
 				   int throttle, struct perf_sample_data *data,
 				   struct pt_regs *regs)
 {
+	perf_overflow_handler_t ovf;
 	int events = atomic_read(&event->event_limit);
 	int ret = 0;
 
@@ -8961,7 +8969,15 @@ static int __perf_event_overflow(struct
 		perf_event_disable_inatomic(event);
 	}
 
-	READ_ONCE(event->overflow_handler)(event, data, regs);
+	ovf = READ_ONCE(event->overflow_handler);
+#ifdef CONFIG_RETPOLINE
+	if (ovf == perf_event_output_forward) {
+		perf_event_output_forward(event, data, regs);
+	} else if (ovf == perf_event_output_backward) {
+		perf_event_output_backward(event, data, regs);
+	} else
+#endif
+		ovf(event, data, regs);
 
 	if (*perf_event_fasync(event) && event->pending_kill) {
 		event->pending_wakeup = 1;
@@ -11281,6 +11297,9 @@ perf_event_alloc(struct perf_event_attr
 
 	event->state		= PERF_EVENT_STATE_INACTIVE;
 
+	if (event->attr.sigtrap)
+		event->event_limit = ATOMIC_INIT(1);
+
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
@@ -11556,6 +11575,9 @@ static int perf_copy_attr(struct perf_ev
 	if (attr->thread_only && !attr->inherit)
 		return -EINVAL;
 
+	if (attr->sigtrap && attr->inherit && !attr->thread_only)
+		return -EINVAL;
+
 out:
 	return ret;
 


