Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721933DF01F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237048AbhHCOTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbhHCORk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5F6C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:17:17 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYZF7eb99CEzN9tmPwvy1lHpkdRlxZR89E9ad6rLtjE=;
        b=l/ivUo5WIe3XABjkGsx0btO7VuTLWMzFnUkYfJpmlB/D/h6KCGP1iZOmpALrrrpdz6dCP2
        9B8ZrNU9Kk5hB33Xj9rbWif+T4O+V6XXfZ3v9DaNiGhuGjKbJI06siEMw/ex55ITe7M27y
        uAjJfTA1gK7leEyt/7hRAOeLL0XhDjWJb7MqUorRw9MroLqSaG2fpSuzzoV/eXhq6T83y/
        cupeuxKA5RC7EMQ2HXbLdghVyOvFVqcGLgNTaQr1/hc0uojayqoWPEvzA4hqpvksbtdvlU
        tLlO0J3GRF39f7LO6bTti7Ls3aCja7Fj8royRBSLHDiq2bHo18EANHcHDDkKaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYZF7eb99CEzN9tmPwvy1lHpkdRlxZR89E9ad6rLtjE=;
        b=KSxLiwnOuqAYFwf39Ya48SiXNbhPc0+Rbw4/Gk7pvqcr3TOPW23p0vYmldNx42MsiK2p4r
        1laCM2RbuR5xe1Cw==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 37/38] workqueue: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:20 +0200
Message-Id: <20210803141621.780504-38-bigeasy@linutronix.de>
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

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index f148eacda55a9..f967aa4050d08 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3293,7 +3293,7 @@ int schedule_on_each_cpu(work_func_t func)
 	if (!works)
 		return -ENOMEM;
=20
-	get_online_cpus();
+	cpus_read_lock();
=20
 	for_each_online_cpu(cpu) {
 		struct work_struct *work =3D per_cpu_ptr(works, cpu);
@@ -3305,7 +3305,7 @@ int schedule_on_each_cpu(work_func_t func)
 	for_each_online_cpu(cpu)
 		flush_work(per_cpu_ptr(works, cpu));
=20
-	put_online_cpus();
+	cpus_read_unlock();
 	free_percpu(works);
 	return 0;
 }
@@ -4016,14 +4016,14 @@ static void apply_wqattrs_commit(struct apply_wqatt=
rs_ctx *ctx)
 static void apply_wqattrs_lock(void)
 {
 	/* CPUs should stay stable across pwq creations and installations */
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&wq_pool_mutex);
 }
=20
 static void apply_wqattrs_unlock(void)
 {
 	mutex_unlock(&wq_pool_mutex);
-	put_online_cpus();
+	cpus_read_unlock();
 }
=20
 static int apply_workqueue_attrs_locked(struct workqueue_struct *wq,
@@ -4068,7 +4068,7 @@ static int apply_workqueue_attrs_locked(struct workqu=
eue_struct *wq,
  *
  * Performs GFP_KERNEL allocations.
  *
- * Assumes caller has CPU hotplug read exclusion, i.e. get_online_cpus().
+ * Assumes caller has CPU hotplug read exclusion, i.e. cpus_read_lock().
  *
  * Return: 0 on success and -errno on failure.
  */
@@ -4196,7 +4196,7 @@ static int alloc_and_link_pwqs(struct workqueue_struc=
t *wq)
 		return 0;
 	}
=20
-	get_online_cpus();
+	cpus_read_lock();
 	if (wq->flags & __WQ_ORDERED) {
 		ret =3D apply_workqueue_attrs(wq, ordered_wq_attrs[highpri]);
 		/* there should only be single pwq for ordering guarantee */
@@ -4206,7 +4206,7 @@ static int alloc_and_link_pwqs(struct workqueue_struc=
t *wq)
 	} else {
 		ret =3D apply_workqueue_attrs(wq, unbound_std_wq_attrs[highpri]);
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return ret;
 }
@@ -5168,10 +5168,10 @@ long work_on_cpu_safe(int cpu, long (*fn)(void *), =
void *arg)
 {
 	long ret =3D -ENODEV;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	if (cpu_online(cpu))
 		ret =3D work_on_cpu(cpu, fn, arg);
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(work_on_cpu_safe);
@@ -5443,7 +5443,7 @@ static ssize_t wq_pool_ids_show(struct device *dev,
 	const char *delim =3D "";
 	int node, written =3D 0;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	rcu_read_lock();
 	for_each_node(node) {
 		written +=3D scnprintf(buf + written, PAGE_SIZE - written,
@@ -5453,7 +5453,7 @@ static ssize_t wq_pool_ids_show(struct device *dev,
 	}
 	written +=3D scnprintf(buf + written, PAGE_SIZE - written, "\n");
 	rcu_read_unlock();
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	return written;
 }
--=20
2.32.0

