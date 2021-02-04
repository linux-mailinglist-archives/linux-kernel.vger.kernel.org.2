Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC0E30FC66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbhBDTQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:16:18 -0500
Received: from mail.efficios.com ([167.114.26.124]:48878 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239713AbhBDTOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 14:14:43 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C7F1D2ED64F;
        Thu,  4 Feb 2021 14:13:59 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2WwpemO315JU; Thu,  4 Feb 2021 14:13:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5BCBF2ED723;
        Thu,  4 Feb 2021 14:13:59 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5BCBF2ED723
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1612466039;
        bh=Usiw8w0r2BTgV8wxVPGfF4EBMHncmE9ji+XjdY768ok=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=C/4WEg1v3IlhkIbUwrLCWSHzHEHT1YIHiUoUDBOgNLIddgXXfxWSbStTsYs6q0rdf
         8JV64Y+HMcLSXUwO4llWbi/wtrPuTqtthj0yc0tLcGIVXHhM8UrVcY2gO99yOIRrY5
         /9yLRpKNTuiv2IsZh9V/nvA6e3GA5xNpHzEhFAegnEwRFWzn4w5xcmz9opVgkKO2Ay
         oXmN4KbgZSe0LO8p/YBR6AaHd7o1pX7dCOt4tUGYeLeCx0wbmF0nulRm25EijvkUOc
         dHFKdBr80BGFUwaoUyp2JJE19P/r6Z/R2NUtzFnjtVUvhlIrOkrBaFFrLABzpgUVn4
         Be7TWTgChcguw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id AcB47s9FLJuR; Thu,  4 Feb 2021 14:13:59 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 4D8422ED919;
        Thu,  4 Feb 2021 14:13:59 -0500 (EST)
Date:   Thu, 4 Feb 2021 14:13:59 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <677733063.7658.1612466039188.JavaMail.zimbra@efficios.com>
In-Reply-To: <20210204132710.00fdce4f@gandalf.local.home>
References: <20210204132710.00fdce4f@gandalf.local.home>
Subject: Re: [PATCH] tracepoints: Code clean up
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3996 (ZimbraWebClient - FF84 (Linux)/8.8.15_GA_3996)
Thread-Topic: tracepoints: Code clean up
Thread-Index: 5hJ3s+efzSE39e/plazqz71cgtom6g==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 4, 2021, at 1:27 PM, rostedt rostedt@goodmis.org wrote:

> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> Restructure the code a bit to make it simpler, fix some formatting problems
> and add READ_ONCE/WRITE_ONCE to make sure there's no compiler tear downs on

compiler tear downs -> compiler load/store tearing.

> changes to variables that can be accessed across CPUs.
> 
> Started with Mathieu Desnoyers's patch:
> 
>  Link:
>  https://lore.kernel.org/lkml/20210203175741.20665-1-mathieu.desnoyers@efficios.com/
> 
> And will keep his signature, but I will take the responsibility of this
> being correct, and keep the authorship.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> include/linux/tracepoint.h |  2 +-
> kernel/tracepoint.c        | 92 +++++++++++++++-----------------------
> 2 files changed, 37 insertions(+), 57 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 966ed8980327..dc1d4c612cc3 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -309,7 +309,7 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
> 		if (it_func_ptr) {					\
> 			do {						\
> -				it_func = (it_func_ptr)->func;		\
> +				it_func = READ_ONCE((it_func_ptr)->func); \
> 				__data = (it_func_ptr)->data;		\
> 				((void(*)(void *, proto))(it_func))(__data, args); \
> 			} while ((++it_func_ptr)->func);		\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index e8f20ae29c18..4b9de79bb927 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -136,9 +136,9 @@ func_add(struct tracepoint_func **funcs, struct
> tracepoint_func *tp_func,
> 	 int prio)
> {
> 	struct tracepoint_func *old, *new;
> -	int nr_probes = 0;
> -	int stub_funcs = 0;
> -	int pos = -1;
> +	int iter_probes;	/* Iterate over old probe array. */
> +	int nr_probes = 0;	/* Counter for probes */
> +	int pos = -1;		/* New position */

New position -> Insertion position into new array

> 
> 	if (WARN_ON(!tp_func->func))
> 		return ERR_PTR(-EINVAL);
> @@ -147,54 +147,39 @@ func_add(struct tracepoint_func **funcs, struct
> tracepoint_func *tp_func,
> 	old = *funcs;
> 	if (old) {
> 		/* (N -> N+1), (N != 0, 1) probes */
> -		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
> -			/* Insert before probes of lower priority */
> -			if (pos < 0 && old[nr_probes].prio < prio)
> -				pos = nr_probes;
> -			if (old[nr_probes].func == tp_func->func &&
> -			    old[nr_probes].data == tp_func->data)
> +		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> +			if (old[iter_probes].func == tp_stub_func)
> +				continue;	/* Skip stub functions. */
> +			if (old[iter_probes].func == tp_func->func &&
> +			    old[iter_probes].data == tp_func->data)
> 				return ERR_PTR(-EEXIST);
> -			if (old[nr_probes].func == tp_stub_func)
> -				stub_funcs++;
> +			nr_probes++;
> 		}
> 	}
> -	/* + 2 : one for new probe, one for NULL func - stub functions */
> -	new = allocate_probes(nr_probes + 2 - stub_funcs);
> +	/* + 2 : one for new probe, one for NULL func */
> +	new = allocate_probes(nr_probes + 2);
> 	if (new == NULL)
> 		return ERR_PTR(-ENOMEM);
> 	if (old) {
> -		if (stub_funcs) {
> -			/* Need to copy one at a time to remove stubs */
> -			int probes = 0;
> -
> -			pos = -1;
> -			for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
> -				if (old[nr_probes].func == tp_stub_func)
> -					continue;
> -				if (pos < 0 && old[nr_probes].prio < prio)
> -					pos = probes++;
> -				new[probes++] = old[nr_probes];
> -			}
> -			nr_probes = probes;
> -			if (pos < 0)
> -				pos = probes;
> -			else
> -				nr_probes--; /* Account for insertion */
> -
> -		} else if (pos < 0) {
> -			pos = nr_probes;
> -			memcpy(new, old, nr_probes * sizeof(struct tracepoint_func));
> -		} else {
> -			/* Copy higher priority probes ahead of the new probe */
> -			memcpy(new, old, pos * sizeof(struct tracepoint_func));
> -			/* Copy the rest after it. */
> -			memcpy(new + pos + 1, old + pos,
> -			       (nr_probes - pos) * sizeof(struct tracepoint_func));
> +		pos = -1;

pos is already initialized to -1 at function beginning.

> +		nr_probes = 0;
> +		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> +			if (old[iter_probes].func == tp_stub_func)
> +				continue;
> +			/* Insert before probes of lower priority */
> +			if (pos < 0 && old[iter_probes].prio < prio)
> +				pos = nr_probes++;
> +			new[nr_probes++] = old[iter_probes];
> 		}
> -	} else
> +		if (pos < 0)
> +			pos = nr_probes++;
> +		/* nr_probes now points to the end of the new array */
> +	} else {
> 		pos = 0;
> +		nr_probes = 1; /* must point at end of array */

Yep, much nicer.

> +	}
> 	new[pos] = *tp_func;
> -	new[nr_probes + 1].func = NULL;
> +	new[nr_probes].func = NULL;
> 	*funcs = new;
> 	debug_print_probes(*funcs);
> 	return old;
> @@ -237,11 +222,12 @@ static void *func_remove(struct tracepoint_func **funcs,
> 		/* + 1 for NULL */
> 		new = allocate_probes(nr_probes - nr_del + 1);
> 		if (new) {
> -			for (i = 0; old[i].func; i++)
> -				if ((old[i].func != tp_func->func
> -				     || old[i].data != tp_func->data)
> -				    && old[i].func != tp_stub_func)
> +			for (i = 0; old[i].func; i++) {
> +				if ((old[i].func != tp_func->func ||
> +				     old[i].data != tp_func->data) &&
> +				    old[i].func != tp_stub_func)
> 					new[j++] = old[i];
> +			}
> 			new[nr_probes - nr_del].func = NULL;
> 			*funcs = new;
> 		} else {
> @@ -249,17 +235,11 @@ static void *func_remove(struct tracepoint_func **funcs,
> 			 * Failed to allocate, replace the old function
> 			 * with calls to tp_stub_func.
> 			 */
> -			for (i = 0; old[i].func; i++)
> +			for (i = 0; old[i].func; i++) {
> 				if (old[i].func == tp_func->func &&
> -				    old[i].data == tp_func->data) {
> -					old[i].func = tp_stub_func;
> -					/* Set the prio to the next event. */
> -					if (old[i + 1].func)
> -						old[i].prio =
> -							old[i + 1].prio;
> -					else
> -						old[i].prio = -1;
> -				}
> +				    old[i].data == tp_func->data)
> +					WRITE_ONCE(old[i].func, tp_stub_func);
> +			}

The rest looks good, thanks!

You can keep my signed-off-by, and if needed may add my reviewed-by tag
as well. ;-)

Mathieu


> 			*funcs = old;
> 		}
> 	}
> --
> 2.25.4

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
