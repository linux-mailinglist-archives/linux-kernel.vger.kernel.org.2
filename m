Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25330FDEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbhBDURD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 15:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:35488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239686AbhBDUQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 15:16:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFC464E35;
        Thu,  4 Feb 2021 20:09:24 +0000 (UTC)
Date:   Thu, 4 Feb 2021 15:09:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracepoints: Do not punish non static call users
Message-ID: <20210204150923.0140fe55@gandalf.local.home>
In-Reply-To: <238902062.7677.1612468371566.JavaMail.zimbra@efficios.com>
References: <20210204141742.46739ed2@gandalf.local.home>
        <238902062.7677.1612468371566.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 14:52:51 -0500 (EST)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Feb 4, 2021, at 2:17 PM, rostedt rostedt@goodmis.org wrote:
> 
> > With static calls, a tracepoint can call the callback directly if there is
> > only one callback registered to that tracepoint. When there is more than
> > one, the static call will call the tracepoint's "iterator" function, which
> > needs to reload the tracepoint's "funcs" array again, as it could have
> > changed since the first time it was loaded.
> > 
> > But an arch without static calls is punished by having to load the
> > tracepoint's "funcs" array twice. Once in the DO_TRACE macro, and once
> > again in the iterator macro.  
> 
> In addition to loading it, it needs to test it against NULL twice.

True, but it needs to be tested again because it was loaded again. So I
consider the test as a result of the reload, and only indirectly of the
double call. Thus, I left it out of the change log.

> 
> > 
> > For archs without static calls, there's no reason to load the array macro
> > in the first place, since the iterator function will do it anyway.
> > 
> > Change the __DO_TRACE_CALL() macro to do the double call only for  
> 
> Do you mean "double call" or "double load and NULL check" ?

I was thinking of it as double call, as calling once to the iterator, and
once again to the functions that are loaded. But sure, because of the
double load too (and the NULL check is only because of the load ;-)

> 
> > architectures with static calls, and just call the iterator function
> > directly for architectures without static calls.
> > 
> > [ Tested only on architectures with static calls, will test on those
> >  without later ]
> > 
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index dc1d4c612cc3..966bfa6a861c 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -152,9 +152,18 @@ static inline struct tracepoint
> > *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > #ifdef TRACEPOINTS_ENABLED
> > 
> > #ifdef CONFIG_HAVE_STATIC_CALL
> > -#define __DO_TRACE_CALL(name)	static_call(tp_func_##name)
> > +#define __DO_TRACE_CALL(name, args)					\
> > +	do {								\
> > +		struct tracepoint_func *it_func_ptr;			\
> > +		it_func_ptr =						\
> > +			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
> > +		if (it_func_ptr) {					\
> > +			__data = (it_func_ptr)->data;			\
> > +			static_call(tp_func_##name)(args);		\
> > +		}							\
> > +	} while (0)
> > #else
> > -#define __DO_TRACE_CALL(name)	__traceiter_##name
> > +#define __DO_TRACE_CALL(name, args)	__traceiter_##name(args)  
> 
> Also, we may want to comment or annotate the "void *data" argument of
> __traceiter_##_name() to state that it is unused.

Good point. (Which would have possibly been found in my more extensive
testing).

Thanks,

-- Steve

> 
> Thanks,
> 
> Mathieu
> 
> > #endif /* CONFIG_HAVE_STATIC_CALL */
> > 
> > /*
> > @@ -168,7 +177,6 @@ static inline struct tracepoint
> > *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  */
> > #define __DO_TRACE(name, proto, args, cond, rcuidle)			\
> > 	do {								\
> > -		struct tracepoint_func *it_func_ptr;			\
> > 		int __maybe_unused __idx = 0;				\
> > 		void *__data;						\
> > 									\
> > @@ -190,12 +198,7 @@ static inline struct tracepoint
> > *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > 			rcu_irq_enter_irqson();				\
> > 		}							\
> > 									\
> > -		it_func_ptr =						\
> > -			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
> > -		if (it_func_ptr) {					\
> > -			__data = (it_func_ptr)->data;			\
> > -			__DO_TRACE_CALL(name)(args);			\
> > -		}							\
> > +		__DO_TRACE_CALL(name, TP_ARGS(args));			\
> > 									\
> > 		if (rcuidle) {						\
> >  			rcu_irq_exit_irqson();				\  
> 

