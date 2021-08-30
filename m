Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6B13FB403
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhH3Kpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236390AbhH3Kpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:45:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC99C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 03:44:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630320285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0ZeDNeAAJkeGwUYujdz9gk9/y/5eisyuX/ZXOq6/QgM=;
        b=sKAHfF417tbMzbtgpGZiYTQvDonbRA1xnbik6j2popyANvFFLbW7srYthmxjxjRJBcfXiA
        8yPSfgD/coyhjOrwudxluGFq0LL3MzOuOh7eCnubNmzJpJHS1povHOf2lOqtR6aDo2/tIe
        q9znAQi1r7bKthB57lwKYziXiiMmxlh00U4/rhYNhxy4iRHGmdI0TxUX+gPs8IHjk6sJ52
        Bke/cLbLx4Nme0UevL74sjIWbJqkqosV5p7572FQtU2kKx5lFrWVLUFsSePAwrVMLiynOz
        tWh7fE0qA3jy7e0WTkSnRc8J0h/4rG8gMBPq6cZmA/UlK4uWaaxmEEGJp13xVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630320285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=0ZeDNeAAJkeGwUYujdz9gk9/y/5eisyuX/ZXOq6/QgM=;
        b=03P4z5k28PldpXxGDhEQ2aFWNpOWtvzbKcMHsXyVRI46b1SUoph5CrV0ebz3/EVYpGSJ+C
        xrr1wJoTITjz81BQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for v5.15-rc1
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
Message-ID: <163031993498.58256.7558950960844391018.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 30 Aug 2021 12:44:45 +0200 (CEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2021-08=
-30

up to:  7625eccd1852: mm: Replace deprecated CPU-hotplug functions.


SMP core updates:

  - Replace get/put_online_cpus() in various places. The final removal will
    happen shortly before v5.15-rc1 when the rest of the patches have been
    merged.

  - Add debug code to help the analysis of CPU hotplug failures=20

  - A set of kernel doc updates

Thanks,

	tglx

------------------>
Baokun Li (1):
      cpu/hotplug: Fix kernel doc warnings for __cpuhp_setup_state_cpuslocked=
()

Dongli Zhang (1):
      cpu/hotplug: Add debug printks for hotplug callback failures

John Garry (1):
      cpu/hotplug: Fix comment typo

Randy Dunlap (2):
      cpu/hotplug: Eliminate all kernel-doc warnings
      smp: Fix all kernel-doc warnings

Sebastian Andrzej Siewior (4):
      smpboot: Replace deprecated CPU-hotplug functions.
      Documentation: Replace deprecated CPU-hotplug functions.
      md/raid5: Replace deprecated CPU-hotplug functions.
      mm: Replace deprecated CPU-hotplug functions.

YueHaibing (1):
      cpu/hotplug: Use DEVICE_ATTR_*() macro


 Documentation/core-api/cpu_hotplug.rst |  2 +-
 Documentation/trace/ftrace.rst         |  2 +-
 drivers/md/raid5.c                     |  4 +-
 include/linux/cpuhotplug.h             |  2 +-
 kernel/cpu.c                           | 84 +++++++++++++++++++++-----------=
--
 kernel/smp.c                           | 14 ++++--
 kernel/smpboot.c                       |  8 ++--
 mm/swap_slots.c                        |  4 +-
 mm/vmstat.c                            | 12 ++---
 9 files changed, 80 insertions(+), 52 deletions(-)

diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/=
cpu_hotplug.rst
index a2c96bec5ee8..1122cd3044c0 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -220,7 +220,7 @@ goes online (offline) and during initial setup (shutdown)=
 of the driver. However
 each registration and removal function is also available with a ``_nocalls``
 suffix which does not invoke the provided callbacks if the invocation of the
 callbacks is not desired. During the manual setup (or teardown) the functions
-``get_online_cpus()`` and ``put_online_cpus()`` should be used to inhibit CPU
+``cpus_read_lock()`` and ``cpus_read_unlock()`` should be used to inhibit CPU
 hotplug operations.
=20
=20
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index cfc81e98e0b8..4e5b26f03d5b 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2762,7 +2762,7 @@ listed in:
   put_prev_task_idle
   kmem_cache_create
   pick_next_task_rt
-  get_online_cpus
+  cpus_read_lock
   pick_next_task_fair
   mutex_lock
   [...]
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index b8436e4930ed..02ed53b20654 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -2437,7 +2437,7 @@ static int resize_chunks(struct r5conf *conf, int new_d=
isks, int new_sectors)
 	    conf->scribble_sectors >=3D new_sectors)
 		return 0;
 	mddev_suspend(conf->mddev);
-	get_online_cpus();
+	cpus_read_lock();
=20
 	for_each_present_cpu(cpu) {
 		struct raid5_percpu *percpu;
@@ -2449,7 +2449,7 @@ static int resize_chunks(struct r5conf *conf, int new_d=
isks, int new_sectors)
 			break;
 	}
=20
-	put_online_cpus();
+	cpus_read_unlock();
 	mddev_resume(conf->mddev);
 	if (!err) {
 		conf->scribble_disks =3D new_disks;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index f39b34b13871..6ac543d33b66 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -399,7 +399,7 @@ static inline int cpuhp_state_remove_instance(enum cpuhp_=
state state,
=20
 /**
  * cpuhp_state_remove_instance_nocalls - Remove hotplug instance from state
- *					 without invoking the reatdown callback
+ *					 without invoking the teardown callback
  * @state:	The state from which the instance is removed
  * @node:	The node for this individual state.
  *
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 804b847912dc..192e43a87407 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -41,14 +41,19 @@
 #include "smpboot.h"
=20
 /**
- * cpuhp_cpu_state - Per cpu hotplug state storage
+ * struct cpuhp_cpu_state - Per cpu hotplug state storage
  * @state:	The current cpu state
  * @target:	The target state
+ * @fail:	Current CPU hotplug callback state
  * @thread:	Pointer to the hotplug thread
  * @should_run:	Thread should execute
  * @rollback:	Perform a rollback
  * @single:	Single callback invocation
  * @bringup:	Single callback bringup or teardown selector
+ * @cpu:	CPU number
+ * @node:	Remote CPU node; for multi-instance, do a
+ *		single entry callback for install/remove
+ * @last:	For multi-instance rollback, remember how far we got
  * @cb_state:	The state for a single callback (install/uninstall)
  * @result:	Result of the operation
  * @done_up:	Signal completion to the issuer of the task for cpu-up
@@ -106,11 +111,12 @@ static inline void cpuhp_lock_release(bool bringup) { }
 #endif
=20
 /**
- * cpuhp_step - Hotplug state machine step
+ * struct cpuhp_step - Hotplug state machine step
  * @name:	Name of the step
  * @startup:	Startup function of the step
  * @teardown:	Teardown function of the step
  * @cant_stop:	Bringup/teardown can't be stopped at this step
+ * @multi_instance:	State has multiple instances which get added afterwards
  */
 struct cpuhp_step {
 	const char		*name;
@@ -124,7 +130,9 @@ struct cpuhp_step {
 		int		(*multi)(unsigned int cpu,
 					 struct hlist_node *node);
 	} teardown;
+	/* private: */
 	struct hlist_head	list;
+	/* public: */
 	bool			cant_stop;
 	bool			multi_instance;
 };
@@ -143,7 +151,7 @@ static bool cpuhp_step_empty(bool bringup, struct cpuhp_s=
tep *step)
 }
=20
 /**
- * cpuhp_invoke_callback _ Invoke the callbacks for a given state
+ * cpuhp_invoke_callback - Invoke the callbacks for a given state
  * @cpu:	The cpu for which the callback should be invoked
  * @state:	The state to do callbacks for
  * @bringup:	True if the bringup callback should be invoked
@@ -151,6 +159,8 @@ static bool cpuhp_step_empty(bool bringup, struct cpuhp_s=
tep *step)
  * @lastp:	For multi-instance rollback, remember how far we got
  *
  * Called from cpu hotplug and from the state register machinery.
+ *
+ * Return: %0 on success or a negative errno code
  */
 static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 				 bool bringup, struct hlist_node *node,
@@ -682,6 +692,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct c=
puhp_cpu_state *st,
=20
 	ret =3D cpuhp_invoke_callback_range(true, cpu, st, target);
 	if (ret) {
+		pr_debug("CPU UP failed (%d) CPU %u state %s (%d)\n",
+			 ret, cpu, cpuhp_get_step(st->state)->name,
+			 st->state);
+
 		cpuhp_reset_state(st, prev_state);
 		if (can_rollback_cpu(st))
 			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
@@ -1081,6 +1095,9 @@ static int cpuhp_down_callbacks(unsigned int cpu, struc=
t cpuhp_cpu_state *st,
=20
 	ret =3D cpuhp_invoke_callback_range(false, cpu, st, target);
 	if (ret) {
+		pr_debug("CPU DOWN failed (%d) CPU %u state %s (%d)\n",
+			 ret, cpu, cpuhp_get_step(st->state)->name,
+			 st->state);
=20
 		cpuhp_reset_state(st, prev_state);
=20
@@ -1183,6 +1200,8 @@ static int cpu_down(unsigned int cpu, enum cpuhp_state =
target)
  * This function is meant to be used by device core cpu subsystem only.
  *
  * Other subsystems should use remove_cpu() instead.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int cpu_device_down(struct device *dev)
 {
@@ -1395,6 +1414,8 @@ static int cpu_up(unsigned int cpu, enum cpuhp_state ta=
rget)
  * This function is meant to be used by device core cpu subsystem only.
  *
  * Other subsystems should use add_cpu() instead.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int cpu_device_up(struct device *dev)
 {
@@ -1420,6 +1441,8 @@ EXPORT_SYMBOL_GPL(add_cpu);
  * On some architectures like arm64, we can hibernate on any CPU, but on
  * wake up the CPU we hibernated on might be offline as a side effect of
  * using maxcpus=3D for example.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int bringup_hibernate_cpu(unsigned int sleep_cpu)
 {
@@ -1976,6 +1999,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
 /**
  * __cpuhp_setup_state_cpuslocked - Setup the callbacks for an hotplug machi=
ne state
  * @state:		The state to setup
+ * @name:		Name of the step
  * @invoke:		If true, the startup function is invoked for cpus where
  *			cpu state >=3D @state
  * @startup:		startup callback function
@@ -1984,9 +2008,9 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_instance);
  *			added afterwards.
  *
  * The caller needs to hold cpus read locked while calling this function.
- * Returns:
+ * Return:
  *   On success:
- *      Positive state number if @state is CPUHP_AP_ONLINE_DYN
+ *      Positive state number if @state is CPUHP_AP_ONLINE_DYN;
  *      0 for all other states
  *   On failure: proper (negative) error code
  */
@@ -2232,18 +2256,17 @@ int cpuhp_smt_enable(void)
 #endif
=20
 #if defined(CONFIG_SYSFS) && defined(CONFIG_HOTPLUG_CPU)
-static ssize_t show_cpuhp_state(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, dev->id);
=20
 	return sprintf(buf, "%d\n", st->state);
 }
-static DEVICE_ATTR(state, 0444, show_cpuhp_state, NULL);
+static DEVICE_ATTR_RO(state);
=20
-static ssize_t write_cpuhp_target(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t target_store(struct device *dev, struct device_attribute *att=
r,
+			    const char *buf, size_t count)
 {
 	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, dev->id);
 	struct cpuhp_step *sp;
@@ -2281,19 +2304,17 @@ static ssize_t write_cpuhp_target(struct device *dev,
 	return ret ? ret : count;
 }
=20
-static ssize_t show_cpuhp_target(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t target_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, dev->id);
=20
 	return sprintf(buf, "%d\n", st->target);
 }
-static DEVICE_ATTR(target, 0644, show_cpuhp_target, write_cpuhp_target);
-
+static DEVICE_ATTR_RW(target);
=20
-static ssize_t write_cpuhp_fail(struct device *dev,
-				struct device_attribute *attr,
-				const char *buf, size_t count)
+static ssize_t fail_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
 {
 	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, dev->id);
 	struct cpuhp_step *sp;
@@ -2342,15 +2363,15 @@ static ssize_t write_cpuhp_fail(struct device *dev,
 	return count;
 }
=20
-static ssize_t show_cpuhp_fail(struct device *dev,
-			       struct device_attribute *attr, char *buf)
+static ssize_t fail_show(struct device *dev,
+			 struct device_attribute *attr, char *buf)
 {
 	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, dev->id);
=20
 	return sprintf(buf, "%d\n", st->fail);
 }
=20
-static DEVICE_ATTR(fail, 0644, show_cpuhp_fail, write_cpuhp_fail);
+static DEVICE_ATTR_RW(fail);
=20
 static struct attribute *cpuhp_cpu_attrs[] =3D {
 	&dev_attr_state.attr,
@@ -2365,7 +2386,7 @@ static const struct attribute_group cpuhp_cpu_attr_grou=
p =3D {
 	NULL
 };
=20
-static ssize_t show_cpuhp_states(struct device *dev,
+static ssize_t states_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
 	ssize_t cur, res =3D 0;
@@ -2384,7 +2405,7 @@ static ssize_t show_cpuhp_states(struct device *dev,
 	mutex_unlock(&cpuhp_state_mutex);
 	return res;
 }
-static DEVICE_ATTR(states, 0444, show_cpuhp_states, NULL);
+static DEVICE_ATTR_RO(states);
=20
 static struct attribute *cpuhp_cpu_root_attrs[] =3D {
 	&dev_attr_states.attr,
@@ -2457,28 +2478,27 @@ static const char *smt_states[] =3D {
 	[CPU_SMT_NOT_IMPLEMENTED]	=3D "notimplemented",
 };
=20
-static ssize_t
-show_smt_control(struct device *dev, struct device_attribute *attr, char *bu=
f)
+static ssize_t control_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
 {
 	const char *state =3D smt_states[cpu_smt_control];
=20
 	return snprintf(buf, PAGE_SIZE - 2, "%s\n", state);
 }
=20
-static ssize_t
-store_smt_control(struct device *dev, struct device_attribute *attr,
-		  const char *buf, size_t count)
+static ssize_t control_store(struct device *dev, struct device_attribute *at=
tr,
+			     const char *buf, size_t count)
 {
 	return __store_smt_control(dev, attr, buf, count);
 }
-static DEVICE_ATTR(control, 0644, show_smt_control, store_smt_control);
+static DEVICE_ATTR_RW(control);
=20
-static ssize_t
-show_smt_active(struct device *dev, struct device_attribute *attr, char *buf)
+static ssize_t active_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	return snprintf(buf, PAGE_SIZE - 2, "%d\n", sched_smt_active());
 }
-static DEVICE_ATTR(active, 0444, show_smt_active, NULL);
+static DEVICE_ATTR_RO(active);
=20
 static struct attribute *cpuhp_smt_attrs[] =3D {
 	&dev_attr_control.attr,
diff --git a/kernel/smp.c b/kernel/smp.c
index 52bf159ec400..f43ede0ab183 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -764,7 +764,7 @@ int smp_call_function_single(int cpu, smp_call_func_t fun=
c, void *info,
 EXPORT_SYMBOL(smp_call_function_single);
=20
 /**
- * smp_call_function_single_async(): Run an asynchronous function on a
+ * smp_call_function_single_async() - Run an asynchronous function on a
  * 			         specific CPU.
  * @cpu: The CPU to run on.
  * @csd: Pre-allocated and setup data structure
@@ -783,6 +783,8 @@ EXPORT_SYMBOL(smp_call_function_single);
  *
  * NOTE: Be careful, there is unfortunately no current debugging facility to
  * validate the correctness of this serialization.
+ *
+ * Return: %0 on success or negative errno value on error
  */
 int smp_call_function_single_async(int cpu, struct __call_single_data *csd)
 {
@@ -974,7 +976,7 @@ static void smp_call_function_many_cond(const struct cpum=
ask *mask,
  * @mask: The set of cpus to run on (only runs on online subset).
  * @func: The function to run. This must be fast and non-blocking.
  * @info: An arbitrary pointer to pass to the function.
- * @flags: Bitmask that controls the operation. If %SCF_WAIT is set, wait
+ * @wait: Bitmask that controls the operation. If %SCF_WAIT is set, wait
  *        (atomically) until function has completed on other CPUs. If
  *        %SCF_RUN_LOCAL is set, the function will also be run locally
  *        if the local CPU is set in the @cpumask.
@@ -1180,7 +1182,13 @@ void wake_up_all_idle_cpus(void)
 EXPORT_SYMBOL_GPL(wake_up_all_idle_cpus);
=20
 /**
- * smp_call_on_cpu - Call a function on a specific cpu
+ * struct smp_call_on_cpu_struct - Call a function on a specific CPU
+ * @work: &work_struct
+ * @done: &completion to signal
+ * @func: function to call
+ * @data: function's data argument
+ * @ret: return value from @func
+ * @cpu: target CPU (%-1 for any CPU)
  *
  * Used to call a function on a specific cpu and wait for it to return.
  * Optionally make sure the call is done on a specified physical cpu via vcpu
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index cf6acab78538..f6bc0bc8a2aa 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -291,7 +291,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_thr=
ead *plug_thread)
 	unsigned int cpu;
 	int ret =3D 0;
=20
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smpboot_threads_lock);
 	for_each_online_cpu(cpu) {
 		ret =3D __smpboot_create_thread(plug_thread, cpu);
@@ -304,7 +304,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_thr=
ead *plug_thread)
 	list_add(&plug_thread->list, &hotplug_threads);
 out:
 	mutex_unlock(&smpboot_threads_lock);
-	put_online_cpus();
+	cpus_read_unlock();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
@@ -317,12 +317,12 @@ EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
  */
 void smpboot_unregister_percpu_thread(struct smp_hotplug_thread *plug_thread)
 {
-	get_online_cpus();
+	cpus_read_lock();
 	mutex_lock(&smpboot_threads_lock);
 	list_del(&plug_thread->list);
 	smpboot_destroy_threads(plug_thread);
 	mutex_unlock(&smpboot_threads_lock);
-	put_online_cpus();
+	cpus_read_unlock();
 }
 EXPORT_SYMBOL_GPL(smpboot_unregister_percpu_thread);
=20
diff --git a/mm/swap_slots.c b/mm/swap_slots.c
index a66f3e0ec973..16f706c55d92 100644
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
index b0534e068166..a7ed56ac4c0b 100644
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

