Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20D53062E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 19:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344084AbhA0SBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 13:01:39 -0500
Received: from mail.efficios.com ([167.114.26.124]:59868 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344044AbhA0SB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 13:01:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 26EB930E790;
        Wed, 27 Jan 2021 13:00:47 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tHr-aq-03Tsw; Wed, 27 Jan 2021 13:00:46 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 945C330E78F;
        Wed, 27 Jan 2021 13:00:46 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 945C330E78F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1611770446;
        bh=nGK5VmLMFEfSxv54YapusFJCRb8k+Rn/jrmNFcCgu5Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=dR2roPu96J1K/NTjUsJm2mnVyTurnl6A+N/W7uhzSK/9yTO21j649aP8f0JMj5soF
         KQedL2IAco2rwN2eFq/8NQqJ5iVIu5VuoVGHw5mkTrIENd+6x073O7Ra/gHVEBfpub
         nXzK9pN862bKJZJ6qZ/n6C5D3IofUTJT1f4mlUOva+B+MzV3U032vT0l4EveDcv/QO
         Y8Z/eYNaTPpfR079Oc1xytXKS9wOmtZ3IF7eFypyBIXsEyzS7Z24UR4ZX7KwDcUtZU
         8SaG7Ij1jmKjQK6QUj4O4tsWmgKDXlkHYtoejyCWAqp2apIDIgIwUGcjmkG/bFjLoH
         cckqjvUL7366w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oq3eXHlgrl_m; Wed, 27 Jan 2021 13:00:46 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 7ECE730E69F;
        Wed, 27 Jan 2021 13:00:46 -0500 (EST)
Date:   Wed, 27 Jan 2021 13:00:46 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>, paulmck <paulmck@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
Message-ID: <2075610164.123.1611770446483.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210127123951.14f8d321@gandalf.local.home>
References: <20210127123951.14f8d321@gandalf.local.home>
Subject: Re: [PATCH v4] tracepoint: Do not fail unregistering a probe due to
 memory failure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3996)
Thread-Topic: tracepoint: Do not fail unregistering a probe due to memory failure
Thread-Index: q9Y+RwhLjVw/LhVXfgFMff9ipx7MVg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jan 27, 2021, at 12:39 PM, rostedt rostedt@goodmis.org wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The list of tracepoint callbacks is managed by an array that is protected
> by RCU. To update this array, a new array is allocated, the updates are
> copied over to the new array, and then the list of functions for the
> tracepoint is switched over to the new array. After a completion of an RCU
> grace period, the old array is freed.
> 
> This process happens for both adding a callback as well as removing one.
> But on removing a callback, if the new array fails to be allocated, the
> callback is not removed, and may be used after it is freed by the clients
> of the tracepoint.
> 
> The handling of a failed allocation for removing an event can break use
> cases as the error report is not propagated up to the original callers. To
> make matters worse, there's some paths that can not handle error cases.
> 
> Instead of allocating a new array for removing a tracepoint, allocate twice
> the needed size when adding tracepoints to the array. On removing, use the
> second half of the allocated array. This removes the need to allocate memory
> for removing a tracepoint, as the allocation for removals will already have
> been done.

I don't see how this can work reliably. AFAIU, with RCU, approaches
requiring a pre-allocation of twice the size and swapping to the alternate
memory area on removal falls apart whenever you remove 2 or more elements
back-to-back without waiting for a grace period.

How is this handled by your scheme ?

Thanks,

Mathieu

> 
> Link: https://lkml.kernel.org/r/20201115055256.65625-1-mmullins@mmlx.us
> Link: https://lkml.kernel.org/r/20201116175107.02db396d@gandalf.local.home
> Link: https://lkml.kennel.org/r/20201118093405.7a6d2290@gandalf.local.home
> 
> Reported-by: Matt Mullins <mmullins@mmlx.us>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> 
> Changes since v3:
> 
>  Scrapped the entire idea of having a stub function replace the removed
>  tracepoint callback. Instead, simply allocate twice the needed array at
>  addition of the tracepoint, and on removal, use the second half of the
>  array. This removes the need to allocate anything on removal, which
>  removes the possible failure of that allocation.
> 
> kernel/tracepoint.c | 54 +++++++++++++++++++++++++++++++++++----------
> 1 file changed, 42 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 7261fa0f5e3c..23088f6276a4 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -129,7 +129,7 @@ static struct tracepoint_func *
> func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
> 	 int prio)
> {
> -	struct tracepoint_func *old, *new;
> +	struct tracepoint_func *old, *new, *tp_funcs;
> 	int nr_probes = 0;
> 	int pos = -1;
> 
> @@ -149,10 +149,28 @@ func_add(struct tracepoint_func **funcs, struct
> tracepoint_func *tp_func,
> 				return ERR_PTR(-EEXIST);
> 		}
> 	}
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
> +	if (tp_funcs == NULL)
> 		return ERR_PTR(-ENOMEM);
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
> 	if (old) {
> 		if (pos < 0) {
> 			pos = nr_probes;
> @@ -164,6 +182,14 @@ func_add(struct tracepoint_func **funcs, struct
> tracepoint_func *tp_func,
> 			memcpy(new + pos + 1, old + pos,
> 			       (nr_probes - pos) * sizeof(struct tracepoint_func));
> 		}
> +		/* Make old point back to the allocated array */
> +		old--;
> +		/*
> +		 * If this is the second half of the array,
> +		 * make it point back to the first half.
> +		 */
> +		if (old->func < old)
> +			old = old->func;
> 	} else
> 		pos = 0;
> 	new[pos] = *tp_func;
> @@ -202,14 +228,18 @@ static void *func_remove(struct tracepoint_func **funcs,
> 		/* N -> 0, (N > 1) */
> 		*funcs = NULL;
> 		debug_print_probes(*funcs);
> +		/* Set old back to what it was allocated to */
> +		old--;
> +		if (old->func < old)
> +			old = old->func;
> 		return old;
> 	} else {
> 		int j = 0;
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
> 		for (i = 0; old[i].func; i++)
> 			if (old[i].func != tp_func->func
> 					|| old[i].data != tp_func->data)
> @@ -218,7 +248,7 @@ static void *func_remove(struct tracepoint_func **funcs,
> 		*funcs = new;
> 	}
> 	debug_print_probes(*funcs);
> -	return old;
> +	return NULL;
> }
> 
> static void tracepoint_update_call(struct tracepoint *tp, struct tracepoint_func
> *tp_funcs, bool sync)
> @@ -309,8 +339,8 @@ static int tracepoint_remove_func(struct tracepoint *tp,
> 		rcu_assign_pointer(tp->funcs, tp_funcs);
> 	} else {
> 		rcu_assign_pointer(tp->funcs, tp_funcs);
> -		tracepoint_update_call(tp, tp_funcs,
> -				       tp_funcs[0].func != old[0].func);
> +		/* Need to sync, if going back to a single caller */
> +		tracepoint_update_call(tp, tp_funcs, tp_funcs[1].func == NULL);
> 	}
> 	release_probes(old);
> 	return 0;
> --
> 2.25.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
