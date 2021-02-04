Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94FF30FA29
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhBDRtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:49:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238742AbhBDRs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:48:27 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BBB64F41;
        Thu,  4 Feb 2021 17:47:46 +0000 (UTC)
Date:   Thu, 4 Feb 2021 12:47:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] tracepoint: cleanup: do not fail unregistration
Message-ID: <20210204124744.60ec54aa@gandalf.local.home>
In-Reply-To: <20210203175741.20665-1-mathieu.desnoyers@efficios.com>
References: <20210203160550.710877069@goodmis.org>
        <20210203175741.20665-1-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  3 Feb 2021 12:57:41 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> This patch is only compile-tested.
> 

Yes it is. (crashed on boot)


> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> ---
>  include/linux/tracepoint.h |  2 +-
>  kernel/tracepoint.c        | 80 +++++++++++++-------------------------
>  2 files changed, 28 insertions(+), 54 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 0f21617f1a66..fae8d6d9588c 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -308,7 +308,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
>  		it_func_ptr =						\
>  			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
>  		do {							\
> -			it_func = (it_func_ptr)->func;			\
> +			it_func = READ_ONCE((it_func_ptr)->func);	\
>  			__data = (it_func_ptr)->data;			\
>  			((void(*)(void *, proto))(it_func))(__data, args); \
>  		} while ((++it_func_ptr)->func);			\
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index 3e261482296c..b1bec710f68a 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -136,9 +136,10 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	 int prio)
>  {
>  	struct tracepoint_func *old, *new;
> -	int nr_probes = 0;
> -	int stub_funcs = 0;
> -	int pos = -1;
> +	int iter_probes = 0;	/* Iterate over old probe array. */
> +	int nr_old_probes = 0;	/* Count non-stub functions in old. */
> +	int nr_new_probes = 0;	/* Count functions in new. */
> +	int pos = -1;		/* Insert position in new. */
>  
>  	if (WARN_ON(!tp_func->func))
>  		return ERR_PTR(-EINVAL);
> @@ -147,54 +148,34 @@ func_add(struct tracepoint_func **funcs, struct tracepoint_func *tp_func,
>  	old = *funcs;
>  	if (old) {
>  		/* (N -> N+1), (N != 0, 1) probes */
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
>  				return ERR_PTR(-EEXIST);
> -			if (old[nr_probes].func == tp_stub_func)
> -				stub_funcs++;
> +			/* Insert before probes of lower priority */
> +			if (pos < 0 && old[iter_probes].prio < prio)
> +				pos = nr_old_probes;
> +			nr_old_probes++;
>  		}
>  	}
> -	/* + 2 : one for new probe, one for NULL func - stub functions */
> -	new = allocate_probes(nr_probes + 2 - stub_funcs);
> +	/* + 2 : one for new probe, one for NULL func */
> +	new = allocate_probes(nr_old_probes + 2);
>  	if (new == NULL)
>  		return ERR_PTR(-ENOMEM);
>  	if (old) {
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

The above "trick" is to handle the case that we inserted a probe with the:

			if (pos < 0 && old[nr_probes].prio < prio)
				pos = probes++;

Which in the below code, you missed.

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
> +		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
> +			if (old[iter_probes].func == tp_stub_func)
> +				continue;		/* Skip stub functions. */
> +			if (nr_new_probes != pos)
> +				new[nr_new_probes] = old[iter_probes];

The problem is above, because we just skipped adding old[iter_probes].

> +			nr_new_probes++;

I'm not sure this is any less confusing than my code. Because, I now have
to try and wrap my head around how to increment three different variables
instead of just two.

I agree that we can just make it one code, but I think I'll keep the
original logic, with slight modifications influenced by your code.

Instead of doing that "trick" that decrements nr_probes, I should increment
it if we are adding to the end (pos < 0):

		if (pos < 0)
			pos = nr_probes++;
		/* nr_probes points to the end of the array */
	} else { /* !old */
		pos = 0;
		nr_probes = 1; /* points to end of array */
	}

	new[pos] = *tp_func;
	new[nr_probes].func = NULL;


>  		}
>  	} else
>  		pos = 0;
>  	new[pos] = *tp_func;
> -	new[nr_probes + 1].func = NULL;
> +	new[nr_new_probes + 1].func = NULL;
>  	*funcs = new;
>  	debug_print_probes(*funcs);
>  	return old;
> @@ -238,9 +219,9 @@ static void *func_remove(struct tracepoint_func **funcs,
>  		new = allocate_probes(nr_probes - nr_del + 1);
>  		if (new) {
>  			for (i = 0; old[i].func; i++)
> -				if ((old[i].func != tp_func->func
> -				     || old[i].data != tp_func->data)
> -				    && old[i].func != tp_stub_func)
> +				if ((old[i].func != tp_func->func ||
> +				     old[i].data != tp_func->data) &&
> +				    old[i].func != tp_stub_func)
>  					new[j++] = old[i];
>  			new[nr_probes - nr_del].func = NULL;
>  			*funcs = new;
> @@ -251,15 +232,8 @@ static void *func_remove(struct tracepoint_func **funcs,
>  			 */
>  			for (i = 0; old[i].func; i++)
>  				if (old[i].func == tp_func->func &&
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

I'll add this change too.

>  			*funcs = old;
>  		}
>  	}

Here's an updated patch:

(tested against tools/testing/selftests/ftrace/ftracetest)

Index: linux-trace.git/include/linux/tracepoint.h
===================================================================
--- linux-trace.git.orig/include/linux/tracepoint.h
+++ linux-trace.git/include/linux/tracepoint.h
@@ -309,7 +309,7 @@ static inline struct tracepoint *tracepo
 			rcu_dereference_raw((&__tracepoint_##_name)->funcs); \
 		if (it_func_ptr) {					\
 			do {						\
-				it_func = (it_func_ptr)->func;		\
+				it_func = READ_ONCE((it_func_ptr)->func); \
 				__data = (it_func_ptr)->data;		\
 				((void(*)(void *, proto))(it_func))(__data, args); \
 			} while ((++it_func_ptr)->func);		\
Index: linux-trace.git/kernel/tracepoint.c
===================================================================
--- linux-trace.git.orig/kernel/tracepoint.c
+++ linux-trace.git/kernel/tracepoint.c
@@ -136,9 +136,9 @@ func_add(struct tracepoint_func **funcs,
 	 int prio)
 {
 	struct tracepoint_func *old, *new;
-	int nr_probes = 0;
-	int stub_funcs = 0;
-	int pos = -1;
+	int iter_probes;	/* Iterate over old probe array. */
+	int nr_probes = 0;	/* Counter for probes */
+	int pos = -1;		/* New position */
 
 	if (WARN_ON(!tp_func->func))
 		return ERR_PTR(-EINVAL);
@@ -147,54 +147,39 @@ func_add(struct tracepoint_func **funcs,
 	old = *funcs;
 	if (old) {
 		/* (N -> N+1), (N != 0, 1) probes */
-		for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
-			/* Insert before probes of lower priority */
-			if (pos < 0 && old[nr_probes].prio < prio)
-				pos = nr_probes;
-			if (old[nr_probes].func == tp_func->func &&
-			    old[nr_probes].data == tp_func->data)
+		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
+			if (old[iter_probes].func == tp_stub_func)
+				continue;	/* Skip stub functions. */
+			if (old[iter_probes].func == tp_func->func &&
+			    old[iter_probes].data == tp_func->data)
 				return ERR_PTR(-EEXIST);
-			if (old[nr_probes].func == tp_stub_func)
-				stub_funcs++;
+			nr_probes++;
 		}
 	}
-	/* + 2 : one for new probe, one for NULL func - stub functions */
-	new = allocate_probes(nr_probes + 2 - stub_funcs);
+	/* + 2 : one for new probe, one for NULL func */
+	new = allocate_probes(nr_probes + 2);
 	if (new == NULL)
 		return ERR_PTR(-ENOMEM);
 	if (old) {
-		if (stub_funcs) {
-			/* Need to copy one at a time to remove stubs */
-			int probes = 0;
-
-			pos = -1;
-			for (nr_probes = 0; old[nr_probes].func; nr_probes++) {
-				if (old[nr_probes].func == tp_stub_func)
-					continue;
-				if (pos < 0 && old[nr_probes].prio < prio)
-					pos = probes++;
-				new[probes++] = old[nr_probes];
-			}
-			nr_probes = probes;
-			if (pos < 0)
-				pos = probes;
-			else
-				nr_probes--; /* Account for insertion */
-
-		} else if (pos < 0) {
-			pos = nr_probes;
-			memcpy(new, old, nr_probes * sizeof(struct tracepoint_func));
-		} else {
-			/* Copy higher priority probes ahead of the new probe */
-			memcpy(new, old, pos * sizeof(struct tracepoint_func));
-			/* Copy the rest after it. */
-			memcpy(new + pos + 1, old + pos,
-			       (nr_probes - pos) * sizeof(struct tracepoint_func));
+		pos = -1;
+		nr_probes = 0;
+		for (iter_probes = 0; old[iter_probes].func; iter_probes++) {
+			if (old[iter_probes].func == tp_stub_func)
+				continue;
+			/* Insert before probes of lower priority */
+			if (pos < 0 && old[iter_probes].prio < prio)
+				pos = nr_probes++;
+			new[nr_probes++] = old[iter_probes];
 		}
-	} else
+		if (pos < 0)
+			pos = nr_probes++;
+		/* nr_probes now points to the end of the new array */
+	} else {
 		pos = 0;
+		nr_probes = 1; /* must point at end of array */
+	}
 	new[pos] = *tp_func;
-	new[nr_probes + 1].func = NULL;
+	new[nr_probes].func = NULL;
 	*funcs = new;
 	debug_print_probes(*funcs);
 	return old;
@@ -237,11 +222,12 @@ static void *func_remove(struct tracepoi
 		/* + 1 for NULL */
 		new = allocate_probes(nr_probes - nr_del + 1);
 		if (new) {
-			for (i = 0; old[i].func; i++)
-				if ((old[i].func != tp_func->func
-				     || old[i].data != tp_func->data)
-				    && old[i].func != tp_stub_func)
+			for (i = 0; old[i].func; i++) {
+				if ((old[i].func != tp_func->func ||
+				     old[i].data != tp_func->data) &&
+				    old[i].func != tp_stub_func)
 					new[j++] = old[i];
+			}
 			new[nr_probes - nr_del].func = NULL;
 			*funcs = new;
 		} else {
@@ -249,17 +235,11 @@ static void *func_remove(struct tracepoi
 			 * Failed to allocate, replace the old function
 			 * with calls to tp_stub_func.
 			 */
-			for (i = 0; old[i].func; i++)
+			for (i = 0; old[i].func; i++) {
 				if (old[i].func == tp_func->func &&
-				    old[i].data == tp_func->data) {
-					old[i].func = tp_stub_func;
-					/* Set the prio to the next event. */
-					if (old[i + 1].func)
-						old[i].prio =
-							old[i + 1].prio;
-					else
-						old[i].prio = -1;
-				}
+				    old[i].data == tp_func->data)
+					WRITE_ONCE(old[i].func, tp_stub_func);
+			}
 			*funcs = old;
 		}
 	}


