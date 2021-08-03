Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E053DF010
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236910AbhHCOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbhHCORX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E94C06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 07:17:12 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtDx+7fvh1tsVni+y0ocsaxBDBzMjJCqLf2XeH5bqbw=;
        b=1R9g1wY+HprWMJWieeb++cLANiJmE6EzrwFQHRXwH30otyAp7Hr3P7yRavbRKWxDNkHlp7
        p9DOHr6v58PZmeTsziRhwcr87lQBelawwOBlHFFjxaL5RQL3pPdu6IPQMKAhHUbUf+dShw
        JZ4hfUQtcSIFXMb0OJJ6p4nR/CeZ7ZkYIK0azS0JbaT4AwXmZMEFlt8s+UXg7hYOALSnGl
        nSQNO0j25PagDmyOzWZwGkuylaotHhxfxoLtZWYm3irU9AWZYJrebb1y3JsVp41thgtd8Y
        NcatpSyJZgom310LtjaRLiOg6q+GcJn864pdQ0/jaGSVC+OFzAj9Ek5EiMV8xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000231;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vtDx+7fvh1tsVni+y0ocsaxBDBzMjJCqLf2XeH5bqbw=;
        b=V/g9b9xFFMeUOAOUsfstWQnimnZBlvmYRhAK9Yw7g8t+y09k8ih/yBb6Aex5lV44bdL45A
        YLPzaUKJynUpyIBQ==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH 20/38] mm: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:16:03 +0200
Message-Id: <20210803141621.780504-21-bigeasy@linutronix.de>
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 mm/swap_slots.c |  4 ++--
 mm/vmstat.c     | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index a66f3e0ec9733..16f706c55d925 100644
--- a/mm/swap_slots.c
+++ b/mm/swap_slots.c
@@ -70,9 +70,9 @@ void disable_swap_slots_cache_lock(void)
 	swap_slot_cache_enabled =3D false;
 	if (swap_slot_cache_initialized) {
 		/* serialize with cpu hotplug operations */
-		get_online_cpus();
+		cpus_read_lock();
 		__drain_swap_slots_cache(SLOTS_CACHE|SLOTS_CACHE_RET);
-		put_online_cpus();
+		cpus_read_unlock();
 	}
 }
=20
diff --git a/mm/vmstat.c b/mm/vmstat.c
index b0534e068166c..a7ed56ac4c0b4 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -129,9 +129,9 @@ static void sum_vm_events(unsigned long *ret)
 */
 void all_vm_events(unsigned long *ret)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	sum_vm_events(ret);
-	put_online_cpus();
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(all_vm_events);
=20
@@ -1948,7 +1948,7 @@ static void vmstat_shepherd(struct work_struct *w)
 {
 	int cpu;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	/* Check processors whose vmstat worker threads have been disabled */
 	for_each_online_cpu(cpu) {
 		struct delayed_work *dw =3D &per_cpu(vmstat_work, cpu);
@@ -1958,7 +1958,7 @@ static void vmstat_shepherd(struct work_struct *w)
=20
 		cond_resched();
 	}
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	schedule_delayed_work(&shepherd,
 		round_jiffies_relative(sysctl_stat_interval));
@@ -2037,9 +2037,9 @@ void __init init_mm_internals(void)
 	if (ret < 0)
 		pr_err("vmstat: failed to register 'online' hotplug state\n");
=20
-	get_online_cpus();
+	cpus_read_lock();
 	init_cpu_node_state();
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	start_shepherd_timer();
 #endif
--=20
2.32.0

