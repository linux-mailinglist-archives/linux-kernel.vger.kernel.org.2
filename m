Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E085372ACF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhEDNTr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 May 2021 09:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:49350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230413AbhEDNTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 09:19:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE57361008;
        Tue,  4 May 2021 13:18:49 +0000 (UTC)
Date:   Tue, 4 May 2021 09:18:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <Peter.Enderborg@sony.com>
Cc:     <ebiederm@xmission.com>, <mathieu.desnoyers@efficios.com>,
        <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
        <akpm@linux-foundation.org>, <peterz@infradead.org>,
        <ast@kernel.org>, <christian.brauner@ubuntu.com>,
        <dave@stgolabs.net>, <walken@google.com>, <jannh@google.com>,
        <christophe.leroy@c-s.fr>, <minchan@kernel.org>
Subject: Re: [PATCH 1/2] tracing: Add a trace for task_exit
Message-ID: <20210504091848.14d0627b@gandalf.local.home>
In-Reply-To: <51452139-801a-8b69-793a-946334bef434@sony.com>
References: <20210430142223.25500-1-peter.enderborg@sony.com>
        <20210430142223.25500-2-peter.enderborg@sony.com>
        <m14kfnzmsp.fsf@fess.ebiederm.org>
        <4bb24db4-f720-f5e7-9054-36bdeaee1d79@sony.com>
        <20210501091104.418765bd@oasis.local.home>
        <1214833117.22933.1620049830326.JavaMail.zimbra@efficios.com>
        <769a00d2-a76d-62d2-aa56-5a107dfdc53d@sony.com>
        <m1sg33lqyo.fsf@fess.ebiederm.org>
        <663fc7fa-e7fc-7d63-9de8-91b5f6fe4f06@sony.com>
        <m1a6pbk5d3.fsf@fess.ebiederm.org>
        <20210503165522.6f1f2fc3@gandalf.local.home>
        <51452139-801a-8b69-793a-946334bef434@sony.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 May 2021 08:00:43 +0000
<Peter.Enderborg@sony.com> wrote:

> On 5/3/21 10:55 PM, Steven Rostedt wrote:
> > On Mon, 03 May 2021 14:02:48 -0500
> > ebiederm@xmission.com (Eric W. Biederman) wrote:
> >  
> >>> However current traces is template based, and I assume it wont be
> >>> popular to add new fields to the template, and exit reasons is not
> >>> right for the other template use cases.  
> > trace events can always add fields, it's removing them that can cause
> > problems (but even then, it's not that bad). The new libtracefs and
> > libtraceevent make it trivial for tools to get the fields from trace events
> > when needed.
> >  
> >>> I still see a "new" task moving it to do_exit make trace name more
> >>> correct?  Or is trace_task_do_exit better?    
> > It is also trivial with the libraries to write a tool that can put together
> > everything you want. We even are working on python bindings to connect to
> > these libraries where you could write a python script to do this.  
> 
> The bpftrace package are 163 MB install size and that is on

No idea, I never used bpftrace or even BPF for that matter.

> a system that already have python. Linux is very much used
> on embedded system, having a shell is luxurious.
> 
> 
> Trivial?
> 
> Concept
> 
> A eBpf program hook in to a tracepoint A & B and collect data.
> 
> A happens before B and send the collected data when B happen.
> 
> 1 A is called:
> 
> 2 C is created, C is destroyed.
> 
> 3 B is called. How do I fetch C?

In use space. I'm talking about writing a simple C program that uses
libtracefs. We are also adding python bindings to do the same in python
(which is what I meant by "python script").


> 
> However I can make a ebpf that hooks in sched_process_free and
> sched_process_exit use  the uapi version of bpf_get_current_task to pick up

No idea. As I said, I never used ebpf.

> 
> oom_score_adj and exit_code.  However task definition is dependent on 71 ifdef's
> not including object that is pointers that also might have build dependency
> and some are there more than once.
> 
> I think kprobe will cause the same problem. It wont be that big deal if it
> was a for kernel debugging. But this is for userspace and should not
> have dependency on kernel internals.

But tracepoints *are* kernel internals and userspace should not have
dependency on them.

> 
> 
> > There is no need for a new tracepoint, especially if it makes it harder to
> > improve the implementation of what is being traced.  
> It does not introduce any complex functionality, and with a other
> mechanism i still believe you would need to reap the task somewhere.
> But I guess it will be needed to add a exist status flag that is new,
> but that is with or without a new tracepoint.
> 
> The python libs that uses this fetch the first item in the task_struct
> and assume that it is thread_info. What could possible go wrong?

No idea what you mean by python fetching task_struct items.

> 
> Is there a runtime linker in ebpf that resolves this by magic?

No idea. Never used ebpf.

Have you tried extending the other trace events?

Not sure this would be accepted though. But that's another discussion to be
had.

-- Steve

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 1eca2305ca42..83cc56174b75 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -307,16 +307,24 @@ DECLARE_EVENT_CLASS(sched_process_template,
 		__array(	char,	comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	pid			)
 		__field(	int,	prio			)
+		__field(	short,	oom_score_adj		)
+		__field(	int,	exit_signal		)
+		__field(	int,	exit_state		)
 	),
 
 	TP_fast_assign(
 		memcpy(__entry->comm, p->comm, TASK_COMM_LEN);
 		__entry->pid		= p->pid;
 		__entry->prio		= p->prio; /* XXX SCHED_DEADLINE */
+		__entry->oom_score_adj	= p->signal ? p->signal->oom_score_adj : 0;
+		__entry->exit_signal	= p->exit_signal;
+		__entry->exit_state	= p->exit_state;
 	),
 
-	TP_printk("comm=%s pid=%d prio=%d",
-		  __entry->comm, __entry->pid, __entry->prio)
+	TP_printk("comm=%s pid=%d prio=%d oom=%d signal=%d state=0x%x",
+		  __entry->comm, __entry->pid, __entry->prio,
+		  __entry->oom_score_adj, __entry->exit_signal,
+		  __entry->exit_state)
 );
 
 /*
