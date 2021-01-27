Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1EC3062C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbhA0Rzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 12:55:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:48704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344296AbhA0RzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 12:55:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B082764DA8;
        Wed, 27 Jan 2021 17:54:35 +0000 (UTC)
Date:   Wed, 27 Jan 2021 12:54:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matt Mullins <mmullins@mmlx.us>, paulmck <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Vyukov <dvyukov@google.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v4] tracepoint: Do not fail unregistering a probe due to
 memory failure
Message-ID: <20210127125434.3ccad5ff@gandalf.local.home>
In-Reply-To: <20210127123951.14f8d321@gandalf.local.home>
References: <20210127123951.14f8d321@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jan 2021 12:39:51 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>  kernel/tracepoint.c | 54 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 7261fa0f5e3c..23088f6276a4 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -129,7 +129,7 @@ static struct tracepoint_func *
>  func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	 int prio)
>  {
> -	struct tracepoint_func *old, *new;
> +	struct tracepoint_func *old, *new, *tp_funcs;
>  	int nr_probes = 0;
>  	int pos = -1;
>  
> @@ -149,10 +149,28 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  				return ERR_PTR(-EEXIST);
>  		}
>  	}
> -	/* + 2 : one for new probe, one for NULL func */
> -	new = allocate_probes(nr_probes + 2);
> -	if (new == NULL)
> +	/*
> +	 * The size of the tp_funcs will be the current size, plus
> +	 * one for the new probe, one for the NULL func, and one for
> +	 * the pointer to the "removal" array.
> +	 * And then double the size to create the "removal" array.
> +	 */
> +	tp_funcs = allocate_probes((nr_probes + 3) * 2);

Note, I realize that this double allocation is unnecessary if we add a
single probe. But to make this different for 2 or more probes, would make
the logic more complex, so I just kept the logic the same for the single
probe even though it's not needed.


> +	if (tp_funcs == NULL)
>  		return ERR_PTR(-ENOMEM);
> +	/*
> +	 * When removing a probe and there are more probes left,
> +	 * we cannot rely on allocation to succeed to create the new
> +	 * RCU array. Thus, the array is doubled here, and on removal of
> +	 * a probe with other probes still in the array, the second half
> +	 * of the array is used.
> +	 *
> +	 * The first element of the array has its "func" field point to
> +	 * the start of the other half of the array.
> +	 */
> +	tp_funcs->func = tp_funcs + nr_probes + 3;
> +	tp_funcs[nr_probes + 3].func = tp_funcs;
> +	new = tp_funcs + 1;
>  	if (old) {
>  		if (pos < 0) {
>  			pos = nr_probes;
> @@ -164,6 +182,14 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  			memcpy(new + pos + 1, old + pos,
>  			       (nr_probes - pos) * sizeof(struct tracepoint_func));
>  		}
> +		/* Make old point back to the allocated array */
> +		old--;
> +		/*
> +		 * If this is the second half of the array,
> +		 * make it point back to the first half.
> +		 */
> +		if (old->func < old)
> +			old = old->func;
>  	} else
>  		pos = 0;
>  	new[pos] = *tp_func;
> @@ -202,14 +228,18 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		/* N -> 0, (N > 1) */
>  		*funcs = NULL;
>  		debug_print_probes(*funcs);
> +		/* Set old back to what it was allocated to */
> +		old--;
> +		if (old->func < old)
> +			old = old->func;
>  		return old;
>  	} else {
>  		int j = 0;
> -		/* N -> M, (N > 1, M > 0) */
> -		/* + 1 for NULL */
> -		new = allocate_probes(nr_probes - nr_del + 1);
> -		if (new == NULL)
> -			return ERR_PTR(-ENOMEM);
> +
> +		/* Use the other half of the array for the new probes */
> +		new = old - 1;
> +		new = new->func;
> +		new++;
>  		for (i = 0; old[i].func; i++)
>  			if (old[i].func != tp_func->func
>  					|| old[i].data != tp_func->data)
> @@ -218,7 +248,7 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		*funcs = new;
>  	}
>  	debug_print_probes(*funcs);
> -	return old;
> +	return NULL;
>  }
>  
>  static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func *tp_funcs, bool sync)
> @@ -309,8 +339,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
>  		rcu_assign_pointer(tp->funcs, tp_funcs);
>  	} else {
>  		rcu_assign_pointer(tp->funcs, tp_funcs);
> -		tracepoint_update_call(tp, tp_funcs,
> -				       tp_funcs[0].func != old[0].func);
> +		/* Need to sync, if going back to a single caller */
> +		tracepoint_update_call(tp, tp_funcs, tp_funcs[1].func == NULL);

I may make this change a separate patch. As it changes the logic slightly
unrelated to the change being fixed, and was only needed for this patch, to
remove the reference to "old".

-- Steve


>  	}
>  	release_probes(old);
>  	return 0;

