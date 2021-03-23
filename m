Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16A73455CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCWC4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhCWC41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:56:27 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:56:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id dc12so8883969qvb.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=2R4gLaPYkZFGv5NUAo6hrY8/w0TXRLxYQUAIP/ILvK8=;
        b=NkkXOe1XZ0/viCj985EOBLvinQi610DcZkMd8wcsafVI+5zp16yJzr6jV/yfTjhWOb
         5ZfLiO+RpUkuuS+ph5OszJvdCPP9HN5oItKTkhFLEhG8a0ihc19Mr3a1wjLQPCUhjpdc
         LaykFB8+EFo5fQr5VUqAHr23+EzTw36vA8lyQfcJYcxij/GRgyvNK2Ge/p2abPhgIzbV
         ZiXO8nT51CzZNVswDiDdR6NEXBPQ9G3vwdZoXo7TNAO9QEBaNYvw9+4KRcBKQ/fxn20E
         BHtlC4dFa/xyy8WQ1UTkUNSySEc9K0p7osFVIXMt+opp85lGgLsYEu+gGZ3pYIIERD7A
         Qwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=2R4gLaPYkZFGv5NUAo6hrY8/w0TXRLxYQUAIP/ILvK8=;
        b=cx0qpv+PIhjsZ5PCgoF9e0eyFgOvbVsCZ811ktizy5LNI88W6XH2EnMsZRoUJrNSe0
         v86WH22w7KL1Iyk94wzS6xvBqJSaY6/hM9JPe39cc+uNm2dDV4HV1HEQYAzqVTi+pErr
         hP4kYXZrtxbvb+KXr/dbPdyWLLw3QzrvnaVZxzrrJtIPkem43XQ9/Yak0ntXuk/NebEi
         TLvEIEuc2gJ+BB+gq7dGaZzfDMh0lQGMjDkY6vTupn9hQOmYHvgYW/tEOIL/op9JVpBG
         CzPWd0bAqoOUSTFY24jOu93U13jz0l5gEaDyp9aJvthxmCx/APYG3/kZuZodfWFUpXEW
         MKEg==
X-Gm-Message-State: AOAM533gYzYXrawW/aogjG4e6U4jruTi/pVdbOOK5Cj1Kgr7MRKQCPBT
        61QVcbMPQkPqlj502J80qdj0TSaRBOBgC1sL
X-Google-Smtp-Source: ABdhPJy6ynGpCWcrMnNxF+3lI9Ld93DtZq1p0d37XfdftJCi7mhbkeDDtHetLgUbYDrgRPW7ZzSMbg==
X-Received: by 2002:a05:6214:184e:: with SMTP id d14mr3171699qvy.30.1616468186324;
        Mon, 22 Mar 2021 19:56:26 -0700 (PDT)
Received: from ArchLinux ([37.19.198.117])
        by smtp.gmail.com with ESMTPSA id l27sm4212715qki.133.2021.03.22.19.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 19:56:25 -0700 (PDT)
Date:   Tue, 23 Mar 2021 08:26:14 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Fix various typos in comments
Message-ID: <YFlYzkY7h+OD0WCb@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20210322230258.GA1983587@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YeYIkammuQkKNDF9"
Content-Disposition: inline
In-Reply-To: <20210322230258.GA1983587@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YeYIkammuQkKNDF9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 00:02 Tue 23 Mar 2021, Ingo Molnar wrote:
>
>Hi Paul,
>
>Was working on automation to make it a bit more straightforward to fix
>typos within comments (which we tend to reintroduce during
>development), and here are the ones it found in the RCU code.
>
>Thanks,
>
>	Ingo
>
>=========>
>From: Ingo Molnar <mingo@kernel.org>
>Date: Mon, 22 Mar 2021 23:57:26 +0100
>Subject: [PATCH] rcu: Fix various typos in comments
>
>Fix ~12 single-word typos in RCU code comments.
>
>Signed-off-by: Ingo Molnar <mingo@kernel.org>
>Cc: Paul E. McKenney <paulmck@kernel.org>
>Cc: linux-kernel@vger.kernel.org
>---
> kernel/rcu/srcutree.c                                           | 4 ++--
> kernel/rcu/sync.c                                               | 2 +-
> kernel/rcu/tasks.h                                              | 8 ++++----
> kernel/rcu/tree.c                                               | 4 ++--
> kernel/rcu/tree.h                                               | 2 +-
> kernel/rcu/tree_plugin.h                                        | 2 +-
> tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h | 2 +-
> 7 files changed, 12 insertions(+), 12 deletions(-)
>
>diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
>index e26547b34ad3..036ff5499ad5 100644
>--- a/kernel/rcu/srcutree.c
>+++ b/kernel/rcu/srcutree.c
>@@ -777,9 +777,9 @@ static bool srcu_might_be_idle(struct srcu_struct *ssp)
> 	spin_unlock_irqrestore_rcu_node(sdp, flags);
>
> 	/*
>-	 * No local callbacks, so probabalistically probe global state.
>+	 * No local callbacks, so probabilistically probe global state.
> 	 * Exact information would require acquiring locks, which would
>-	 * kill scalability, hence the probabalistic nature of the probe.
>+	 * kill scalability, hence the probabilistic nature of the probe.
> 	 */
>
> 	/* First, see if enough time has passed since the last GP. */
>diff --git a/kernel/rcu/sync.c b/kernel/rcu/sync.c
>index d4558ab7a07d..3eeb871cf0de 100644
>--- a/kernel/rcu/sync.c
>+++ b/kernel/rcu/sync.c
>@@ -94,7 +94,7 @@ static void rcu_sync_func(struct rcu_head *rhp)
> 		rcu_sync_call(rsp);
> 	} else {
> 		/*
>-		 * We're at least a GP after the last rcu_sync_exit(); eveybody
>+		 * We're at least a GP after the last rcu_sync_exit(); everybody
> 		 * will now have observed the write side critical section.
> 		 * Let 'em rip!.
> 		 */
>diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>index af7c19439f4e..ac3c362e08a3 100644
>--- a/kernel/rcu/tasks.h
>+++ b/kernel/rcu/tasks.h
>@@ -23,7 +23,7 @@ typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
>  * Definition for a Tasks-RCU-like mechanism.
>  * @cbs_head: Head of callback list.
>  * @cbs_tail: Tail pointer for callback list.
>- * @cbs_wq: Wait queue allowning new callback to get kthread's attention.
>+ * @cbs_wq: Wait queue allowing new callback to get kthread's attention.
>  * @cbs_lock: Lock protecting callback list.
>  * @kthread_ptr: This flavor's grace-period/callback-invocation kthread.
>  * @gp_func: This flavor's grace-period-wait function.
>@@ -504,7 +504,7 @@ DEFINE_RCU_TASKS(rcu_tasks, rcu_tasks_wait_gp, call_rcu_tasks, "RCU Tasks");
>  * or transition to usermode execution.  As such, there are no read-side
>  * primitives analogous to rcu_read_lock() and rcu_read_unlock() because
>  * this primitive is intended to determine that all tasks have passed
>- * through a safe state, not so much for data-strcuture synchronization.
>+ * through a safe state, not so much for data-structure synchronization.
>  *
>  * See the description of call_rcu() for more detailed information on
>  * memory ordering guarantees.
>@@ -637,7 +637,7 @@ DEFINE_RCU_TASKS(rcu_tasks_rude, rcu_tasks_rude_wait_gp, call_rcu_tasks_rude,
>  * there are no read-side primitives analogous to rcu_read_lock() and
>  * rcu_read_unlock() because this primitive is intended to determine
>  * that all tasks have passed through a safe state, not so much for
>- * data-strcuture synchronization.
>+ * data-structure synchronization.
>  *

The "hyphen" in the middle of the word "data structure" is required or keeping by
convention or has some significance?
>  * See the description of call_rcu() for more detailed information on
>  * memory ordering guarantees.
>@@ -1127,7 +1127,7 @@ static void exit_tasks_rcu_finish_trace(struct task_struct *t)
>  * there are no read-side primitives analogous to rcu_read_lock() and
>  * rcu_read_unlock() because this primitive is intended to determine
>  * that all tasks have passed through a safe state, not so much for
>- * data-strcuture synchronization.
>+ * data-structure synchronization.
>  *
Same like above.
>  * See the description of call_rcu() for more detailed information on
>  * memory ordering guarantees.
>diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
>index da6f5213fb74..ab5bd5b391e6 100644
>--- a/kernel/rcu/tree.c
>+++ b/kernel/rcu/tree.c
>@@ -2490,7 +2490,7 @@ int rcutree_dead_cpu(unsigned int cpu)
>
> /*
>  * Invoke any RCU callbacks that have made it to the end of their grace
>- * period.  Thottle as specified by rdp->blimit.
>+ * period.  Throttle as specified by rdp->blimit.
>  */
> static void rcu_do_batch(struct rcu_data *rdp)
> {
>@@ -4013,7 +4013,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier);
> /*
>  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
>  * first CPU in a given leaf rcu_node structure coming online.  The caller
>- * must hold the corresponding leaf rcu_node ->lock with interrrupts
>+ * must hold the corresponding leaf rcu_node ->lock with interrupts
>  * disabled.
>  */
> static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
>diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
>index 71821d59d95c..abff7abd59ee 100644
>--- a/kernel/rcu/tree.h
>+++ b/kernel/rcu/tree.h
>@@ -153,7 +153,7 @@ struct rcu_data {
> 	unsigned long	gp_seq;		/* Track rsp->gp_seq counter. */
> 	unsigned long	gp_seq_needed;	/* Track furthest future GP request. */
> 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
>-	bool		core_needs_qs;	/* Core waits for quiesc state. */
>+	bool		core_needs_qs;	/* Core waits for quiescent state. */
> 	bool		beenonline;	/* CPU online at least once. */
> 	bool		gpwrap;		/* Possible ->gp_seq wrap. */
> 	bool		exp_deferred_qs; /* This CPU awaiting a deferred QS? */
>diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
>index 2d603771c7dc..2a28f05cf467 100644
>--- a/kernel/rcu/tree_plugin.h
>+++ b/kernel/rcu/tree_plugin.h
>@@ -2772,7 +2772,7 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
> 	wastimer = timer_pending(&rdp->nocb_bypass_timer);
> 	wassleep = swait_active(&rdp->nocb_gp_wq);
> 	if (!rdp->nocb_gp_sleep && !waslocked && !wastimer && !wassleep)
>-		return;  /* Nothing untowards. */
>+		return;  /* Nothing untoward. */
>
> 	pr_info("   nocb GP activity on CB-only CPU!!! %c%c%c%c %c\n",
> 		"lL"[waslocked],
>diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
>index cf6938d679d7..1e24827f96f1 100644
>--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
>+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/locks.h
>@@ -174,7 +174,7 @@ static inline bool spin_trylock(spinlock_t *lock)
> }
>
> struct completion {
>-	/* Hopefuly this won't overflow. */
>+	/* Hopefully this won't overflow. */
> 	unsigned int count;
> };
>

--YeYIkammuQkKNDF9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmBZWMsACgkQsjqdtxFL
KRXNhwf/dmb9PmJgzqTPoa30OXy5d00Ini/6fNBzAGvw+oNecXe/9N8WL2r+u6LF
zLkGfkx3Q4aZUPet9gkLmL9K9jaclkeWSlZR8mTIQuqtP+pYv5W03s6DpXlabtUD
VlOqCQYGL1qskIGt2Uiuhl1I53k61ifZEwabwbNMR1BNlUP9T4j/1O9TYgGekU3w
0CWfnDpcGCDaNFjbORKGKre1RuL6owdYfBIAZAz8U/uXPsnDlSHMdaU7ZVgayR1u
KskpXYetmvdTI2yRW6n360MeDTHSUyTU4ZlTS28mQlPmjVyafsxz5nPz7uK7/yey
YcEnTX0ibOcHkIdASkp9p6a+sQ5IXg==
=GM7o
-----END PGP SIGNATURE-----

--YeYIkammuQkKNDF9--
