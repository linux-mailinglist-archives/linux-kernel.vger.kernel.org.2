Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F3E3B747D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 16:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhF2OlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 10:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbhF2OlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:41:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BFBC061760
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 07:38:50 -0700 (PDT)
Date:   Tue, 29 Jun 2021 14:35:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624977528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wsxO1yvz4yDWnvrMfXEXRksmGWq0jqOOF4iDwXtFVOI=;
        b=lszRpmPUVwxssEIbJLsX5AmEEF23l0X7E8xJGh6Oo/1BMzXhG0tzqeiTV6jEgfIHG9T9Ng
        4RGoNuIZjXboLruElPQxWfYKzq9Lf7b3gTKz+dlQmBII4OMfCZ1+zC8KXFrIfGSagAYpJ1
        SPCU81COFKDtIfpCB8UEpyNbwYr/lb/qg5iFJ+8zCuKvw2ZB5CHxz6Q4N9xdS4HPv+Gr5H
        tz+2adJCEHyajOl2SUJo0hp7vZvab4hZ+49RCAM6Y4sLK3tI8nMo2m9RSt+beORNj9VKYT
        wjEf1ekKzz+4oNRvtr7rl0fuxOM7t5P9nqsUpxXiYbiowgeqJ4cZL17Z7GuN5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624977528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=wsxO1yvz4yDWnvrMfXEXRksmGWq0jqOOF4iDwXtFVOI=;
        b=ahKmTNpL8nnNtj6G0UO9N7Wwwj+ncJxhr+YyCF8IM3o+Ir1XhjJ/sYWOoLx7WgysHM1D9A
        2d5W04rBHcuIl7Bg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/urgent for v5.14-rc1
References: <162497731214.6531.6083197571290189651.tglx@nanos>
Message-ID: <162497731455.6531.14556986039751007461.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2021-06-29

up to:  b22afcdf04c9: cpu/hotplug: Cure the cpusets trainwreck

A fix for the CPU hotplug and cpusets interaction:

cpusets delegate the hotplug work to a workqueue to prevent a lock order
inversion vs. the CPU hotplug lock. The work is not flushed before the
hotplug operation returns which creates user visible inconsistent state.
Prevent this by flushing the work after dropping CPU hotplug lock and
before releasing the outer mutex which serializes the CPU hotplug related
sysfs interface operations.


Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      cpu/hotplug: Cure the cpusets trainwreck


 kernel/cpu.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index e538518556f4..d2e1692d7bdf 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -32,6 +32,7 @@
 #include <linux/relay.h>
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
+#include <linux/cpuset.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -873,6 +874,52 @@ void __init cpuhp_threads_init(void)
 	kthread_unpark(this_cpu_read(cpuhp_state.thread));
 }
 
+/*
+ *
+ * Serialize hotplug trainwrecks outside of the cpu_hotplug_lock
+ * protected region.
+ *
+ * The operation is still serialized against concurrent CPU hotplug via
+ * cpu_add_remove_lock, i.e. CPU map protection.  But it is _not_
+ * serialized against other hotplug related activity like adding or
+ * removing of state callbacks and state instances, which invoke either the
+ * startup or the teardown callback of the affected state.
+ *
+ * This is required for subsystems which are unfixable vs. CPU hotplug and
+ * evade lock inversion problems by scheduling work which has to be
+ * completed _before_ cpu_up()/_cpu_down() returns.
+ *
+ * Don't even think about adding anything to this for any new code or even
+ * drivers. It's only purpose is to keep existing lock order trainwrecks
+ * working.
+ *
+ * For cpu_down() there might be valid reasons to finish cleanups which are
+ * not required to be done under cpu_hotplug_lock, but that's a different
+ * story and would be not invoked via this.
+ */
+static void cpu_up_down_serialize_trainwrecks(bool tasks_frozen)
+{
+	/*
+	 * cpusets delegate hotplug operations to a worker to "solve" the
+	 * lock order problems. Wait for the worker, but only if tasks are
+	 * _not_ frozen (suspend, hibernate) as that would wait forever.
+	 *
+	 * The wait is required because otherwise the hotplug operation
+	 * returns with inconsistent state, which could even be observed in
+	 * user space when a new CPU is brought up. The CPU plug uevent
+	 * would be delivered and user space reacting on it would fail to
+	 * move tasks to the newly plugged CPU up to the point where the
+	 * work has finished because up to that point the newly plugged CPU
+	 * is not assignable in cpusets/cgroups. On unplug that's not
+	 * necessarily a visible issue, but it is still inconsistent state,
+	 * which is the real problem which needs to be "fixed". This can't
+	 * prevent the transient state between scheduling the work and
+	 * returning from waiting for it.
+	 */
+	if (!tasks_frozen)
+		cpuset_wait_for_hotplug();
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
 #ifndef arch_clear_mm_cpumask_cpu
 #define arch_clear_mm_cpumask_cpu(cpu, mm) cpumask_clear_cpu(cpu, mm_cpumask(mm))
@@ -1108,6 +1155,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 */
 	lockup_detector_cleanup();
 	arch_smt_update();
+	cpu_up_down_serialize_trainwrecks(tasks_frozen);
 	return ret;
 }
 
@@ -1302,6 +1350,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 out:
 	cpus_write_unlock();
 	arch_smt_update();
+	cpu_up_down_serialize_trainwrecks(tasks_frozen);
 	return ret;
 }
 

