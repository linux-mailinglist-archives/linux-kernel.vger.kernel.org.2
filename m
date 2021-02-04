Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A651C30FD86
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 21:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239937AbhBDT7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:59:20 -0500
Received: from mail.efficios.com ([167.114.26.124]:60366 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239548AbhBDTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:53:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 0358E2EDD03;
        Thu,  4 Feb 2021 14:52:52 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 14JidllVMyop; Thu,  4 Feb 2021 14:52:51 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id ADFB32ED775;
        Thu,  4 Feb 2021 14:52:51 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com ADFB32ED775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1612468371;
        bh=tm9ZclZIKau30JnEcmiab479rhRd4jrHM7N4vCj01v8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lA1x7pruhENmh00y3HGGhf5Zv1YFzNFR2MN0SkTegCZ3+000AaDlCznWrdZIj2CEf
         MEbG4KBmWfJzAdEGOdYzgVOuW3dW17/CYZJuXcQKEhu7zZMTJ4SpF5LEbenF817xMv
         Aq1JxJwMS/BEgMPnSMMSTh+myebOMArdOLdxEKMKk5N0qMxDykk9Mc9AA7mok4kEML
         OjkPRom6Be00nLYordOxCtVwX+ISvOaQG5/oZw+qeKUlVO2khnlQZdmO0FcZasGD+f
         8j6p7mkkjYqN1aT1cGbTcqgrHNKGwZPzurM/L9nsqlOuzAU7sZ93MTVoc1ngPVKd64
         PgMMBiHhcxTXw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KyW9av_yAjS7; Thu,  4 Feb 2021 14:52:51 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A16FA2EDB46;
        Thu,  4 Feb 2021 14:52:51 -0500 (EST)
Date:   Thu, 4 Feb 2021 14:52:51 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <238902062.7677.1612468371566.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210204141742.46739ed2@gandalf.local.home>
References: <20210204141742.46739ed2@gandalf.local.home>
Subject: Re: [PATCH] tracepoints: Do not punish non static call users
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3996)
Thread-Topic: tracepoints: Do not punish non static call users
Thread-Index: TnT7X8zpVckFrwA4VcXZbf0c13kIRA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 4, 2021, at 2:17 PM, rostedt rostedt@goodmis.org wrote:

> With static calls, a tracepoint can call the callback directly if there is
> only one callback registered to that tracepoint. When there is more than
> one, the static call will call the tracepoint's "iterator" function, which
> needs to reload the tracepoint's "funcs" array again, as it could have
> changed since the first time it was loaded.
> 
> But an arch without static calls is punished by having to load the
> tracepoint's "funcs" array twice. Once in the DO_TRACE macro, and once
> again in the iterator macro.

In addition to loading it, it needs to test it against NULL twice.

> 
> For archs without static calls, there's no reason to load the array macro
> in the first place, since the iterator function will do it anyway.
> 
> Change the __DO_TRACE_CALL() macro to do the double call only for

Do you mean "double call" or "double load and NULL check" ?

> architectures with static calls, and just call the iterator function
> directly for architectures without static calls.
> 
> [ Tested only on architectures with static calls, will test on those
>  without later ]
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index dc1d4c612cc3..966bfa6a861c 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -152,9 +152,18 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> #ifdef TRACEPOINTS_ENABLED
> 
> #ifdef CONFIG_HAVE_STATIC_CALL
> -#define __DO_TRACE_CALL(name)	static_call(tp_func_##name)
> +#define __DO_TRACE_CALL(name, args)					\
> +	do {								\
> +		struct tracepoint_func *it_func_ptr;			\
> +		it_func_ptr =						\
> +			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
> +		if (it_func_ptr) {					\
> +			__data = (it_func_ptr)->data;			\
> +			static_call(tp_func_##name)(args);		\
> +		}							\
> +	} while (0)
> #else
> -#define __DO_TRACE_CALL(name)	__traceiter_##name
> +#define __DO_TRACE_CALL(name, args)	__traceiter_##name(args)

Also, we may want to comment or annotate the "void *data" argument of
__traceiter_##_name() to state that it is unused.

Thanks,

Mathieu

> #endif /* CONFIG_HAVE_STATIC_CALL */
> 
> /*
> @@ -168,7 +177,6 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  */
> #define __DO_TRACE(name, proto, args, cond, rcuidle)			\
> 	do {								\
> -		struct tracepoint_func *it_func_ptr;			\
> 		int __maybe_unused __idx = 0;				\
> 		void *__data;						\
> 									\
> @@ -190,12 +198,7 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 			rcu_irq_enter_irqson();				\
> 		}							\
> 									\
> -		it_func_ptr =						\
> -			rcu_dereference_raw((&__tracepoint_##name)->funcs); \
> -		if (it_func_ptr) {					\
> -			__data = (it_func_ptr)->data;			\
> -			__DO_TRACE_CALL(name)(args);			\
> -		}							\
> +		__DO_TRACE_CALL(name, TP_ARGS(args));			\
> 									\
> 		if (rcuidle) {						\
>  			rcu_irq_exit_irqson();				\

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
