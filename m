Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C33DF014
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhHCOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57218 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbhHCOR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:26 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fleanKftn1M/7aNvSSXYlPJGKZdzN9zFJsQrc6QUA1M=;
        b=ZIubvD+L7RDirRzayNjgOLmXswAwTkE+3MUtTYsJ/sxBAZhAz944FRjVfA4NOGa/tCKUW/
        3vMkmIKls1vr+CctMnTKQPz0KXqJrtx4IKpi42iEeM/jI1nHxoWDcytg6cwSMTSANmXILt
        jY35rQHezS6u691VmC5DC/pso0lgx6zejslSqnfLnTBEUlACbFm+pVfgdnH9Cc1JyOE541
        MFWw6xd3uRnwiK5b/W2J/dPBccT1aLKrD8iI2rrtfri+/3YnvEDQx+GVzleDNL3S9YfPoj
        iBWPCtes4CNZ+GR/d2FIMnZ0Z8zv0ujQEdaW9qWPqat//AA7sPoNyuwJgJbhKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fleanKftn1M/7aNvSSXYlPJGKZdzN9zFJsQrc6QUA1M=;
        b=n6MrhtT9zobRQ0y9gdhZbDlnJqyNHAxFYBKLoyYsakW2a0pHo8nQgJ/7MkB50o3UdXYPoz
        3vt6rQiH73xDL3BQ==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 31/38] rcu: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:14 +0200
Message-Id: <20210803141621.780504-32-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: rcu@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 51f24ecd94b26..f116ce58f4e68 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4050,7 +4050,7 @@ void rcu_barrier(void)
 	 */
 	init_completion(&rcu_state.barrier_completion);
 	atomic_set(&rcu_state.barrier_cpu_count, 2);
-	get_online_cpus();
+	cpus_read_lock();
=20
 	/*
 	 * Force each CPU with callbacks to register a new callback.
@@ -4081,7 +4081,7 @@ void rcu_barrier(void)
 					  rcu_state.barrier_sequence);
 		}
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	/*
 	 * Now that we have an rcu_barrier_callback() callback on each
--=20
2.32.0

