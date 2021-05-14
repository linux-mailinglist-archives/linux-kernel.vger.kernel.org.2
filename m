Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E73C380384
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 08:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhENGFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 02:05:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230121AbhENGFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 02:05:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25E9D61442;
        Fri, 14 May 2021 06:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620972276;
        bh=7thu+ANECwgoapk9y0rfkNoObCgHdSaeFn1wY2GgHFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OBJbVCryd33z13cNpyWRwNInMMyoRKj2bV2jrZzMXTAvLt/nnwAR6Z31v+sXp+M6L
         7ChtYZgbFbVn11XEWeUR75Tem8WuDh615FHBcSCX6Uvq66xVM+3wTG6YHQJnhtP3lV
         4rEjhKeOIy/cVYA4beD6+n6bcxz9Grrk9FUGA3xoc0mtBMBXjhBjA/YOxRqtCcmkaa
         ftk5eY7tusNcY28Jz9h5TCoBVxAYuJpHpPVqMvV2YUU/8mORKDzYwh8fXQjYThT08D
         /AyU94aO9ItUwtYZBBnR/9Ya/iO00ATJUl6tT+wxb/vI2fiyO+et5tAI6OC/FT8/37
         o3MLW5UfNVXlg==
Date:   Fri, 14 May 2021 15:04:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Subject: Re: [PATCH tip/core/rcu 3/4] rcu-tasks: Make ksoftirqd provide RCU
 Tasks quiescent states
Message-Id: <20210514150431.d89b0ad0a5ce1ac3971a66e5@kernel.org>
In-Reply-To: <20210513191539.GF975577@paulmck-ThinkPad-P17-Gen-1>
References: <20210512182747.3445812-4-paulmck@kernel.org>
        <20210513155417.93ab2299139ba35025ec8ef7@kernel.org>
        <20210513142110.GY975577@paulmck-ThinkPad-P17-Gen-1>
        <20210514024912.a38f755add13a0f1dc73395a@kernel.org>
        <20210513191539.GF975577@paulmck-ThinkPad-P17-Gen-1>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, 13 May 2021 12:15:39 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Fri, May 14, 2021 at 02:49:12AM +0900, Masami Hiramatsu wrote:
> > On Thu, 13 May 2021 07:21:10 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> > > On Thu, May 13, 2021 at 03:54:17PM +0900, Masami Hiramatsu wrote:
> > > > Hi Paul,
> > > > 
> > > > On Wed, 12 May 2021 11:27:46 -0700
> > > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > > 
> > > > > Heavy networking load can cause a CPU to execute continuously and
> > > > > indefinitely within ksoftirqd, in which case there will be no voluntary
> > > > > task switches and thus no RCU-tasks quiescent states.  This commit
> > > > > therefore causes the exiting rcu_softirq_qs() to provide an RCU-tasks
> > > > > quiescent state.
> > > > > 
> > > > > This of course means that __do_softirq() and its callers cannot be
> > > > > invoked from within a tracing trampoline.
> > > > 
> > > > I would like to confirm that you mean "tracing trampoline" here is
> > > > the code on the trampoline buffer, not the handler code which is
> > > > invoked from the trampoline buffer but it is protected by preempt_disable(),
> > > > am I understand correctly?
> > > 
> > > Maybe?  ;-)
> > > 
> > > If the handler code is invoked from the trampoline buffer, but
> > > returns somewhere else, then it is OK for the handler code to invoke
> > > __do_softirq() or its callers.
> > > 
> > > In addition, if the handler code is invoked from the trampoline buffer is
> > > guaranteed never to be running in the context of the ksoftirqd kthread,
> > > then it is also OK for the handler code to invoke __do_softirq() or
> > > its callers.
> > > 
> > > Otherwise, if the handler code might return back into the trampoline
> > > buffer and if that code might be running in the context of the ksoftirqd
> > > kthread, invoking __do_softirq() or one of its callers could result in
> > > the trampoline buffer no longer being there when it was returned to.
> > 
> > Hmm, the optprobe may be involved in this case. It always return to
> > the trampoline and handler does not disable irqs (only disable preempt).
> > BTW, what will call the __do_softirq()? Is hardirq safe?
> 
> As long as your code does not explicitly call __do_softirq() or one of
> its callers, you should be OK.
> 
> Let's suppose that your code takes a hardirq from ksoftirqd context.
> In that case, the return-from-irq path will notice the ksoftirqd
> context and refrain from calling __do_softirqd().  Life is good.
> (See the invoke_softirq() function for more detail.)
> 
> On the other hand, if your code takes a hardirq from some non-ksoftirqd
> context, and if this hardirq decides to handle softirqs on exit
> from the hardirq, the "__this_cpu_read(ksoftirqd) == current" within
> __do_softirq() will fail, so that rcu_softirq_qs() will not be called.
> Life is still good.

Ah, OK. This is good.

> 
> Either way, as long as your handler does not explicitly invoke
> __do_softirq(), life is good.

There should be no such code, I hope. 

> 
> The bad case is when you instrument a function that is invoked in the
> context of a ksoftirqd kthread, and the corresponding handler (or
> some function that the handler explicitly calls) directly invokes
> __do_softirq() or one of its caller.
> 
> Is that more helpful?

OK, I got it. So it would be better to be commented later.
But anyway I can't imagine that there is any reason to call
__do_softirq() inside kprobe handler :)

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
