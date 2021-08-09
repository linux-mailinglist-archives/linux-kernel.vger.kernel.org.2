Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208553E4F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 00:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhHIWiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 18:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbhHIWis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 18:38:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3CDC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8VZhWOfErkUu2qSXFID/EPmKwtmw6GqPUsvlHgzHMpY=; b=q81nWA0m53NVz8N/+YJCno5MY4
        8GtERJLLdrrIbbTHvH41waQoUUvc3FUuVlIjvoAjX2Kdar+/5Ax4RlkuQeH2BjQhYdzpE9coYJzl/
        AKaur4osL0hID0RESCIcPkMZXaaZPUkVieAb0Lqu6S/cvVRE4iFDcc2IYbng9F97uWg84Loem9/6k
        HQFQbDICDiERZUR2EZrFGYHsdMh77Op3nMhQBbz7vTgf+1gafgciozj2NYcxzo6SNghC5eFPh0sw1
        9ieA8mV1nI78Hpc61+GDO0FIiyW1ecPamZ/lyu2ZSgZSMUS570q9aksQFdn6IMt9rZq/wsECRnAf/
        dQpD5b6Q==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDDuc-0025Qa-I3; Mon, 09 Aug 2021 22:38:26 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH] kernel/cpu.c: eliminate all kernel-doc warnings
Date:   Mon,  9 Aug 2021 15:38:25 -0700
Message-Id: <20210809223825.24512-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/cpu.c:57: warning: cannot understand function prototype: 'struct cpuhp_cpu_state '
kernel/cpu.c:115: warning: cannot understand function prototype: 'struct cpuhp_step '
kernel/cpu.c:146: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * cpuhp_invoke_callback _ Invoke the callbacks for a given state
kernel/cpu.c:1998: warning: Function parameter or member 'name' not described in '__cpuhp_setup_state_cpuslocked'
kernel/cpu.c:75: warning: Function parameter or member 'fail' not described in 'cpuhp_cpu_state'
kernel/cpu.c:75: warning: Function parameter or member 'cpu' not described in 'cpuhp_cpu_state'
kernel/cpu.c:75: warning: Function parameter or member 'node' not described in 'cpuhp_cpu_state'
kernel/cpu.c:75: warning: Function parameter or member 'last' not described in 'cpuhp_cpu_state'
kernel/cpu.c:130: warning: Function parameter or member 'list' not described in 'cpuhp_step'
kernel/cpu.c:130: warning: Function parameter or member 'multi_instance' not described in 'cpuhp_step'
kernel/cpu.c:158: warning: No description found for return value of 'cpuhp_invoke_callback'
kernel/cpu.c:1188: warning: No description found for return value of 'cpu_device_down'
kernel/cpu.c:1400: warning: No description found for return value of 'cpu_device_up'
kernel/cpu.c:1425: warning: No description found for return value of 'bringup_hibernate_cpu'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Vincent Donnefort <vincent.donnefort@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 kernel/cpu.c |   27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

--- linux-next-20210809.orig/kernel/cpu.c
+++ linux-next-20210809/kernel/cpu.c
@@ -41,14 +41,19 @@
 #include "smpboot.h"
 
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
@@ -106,11 +111,12 @@ static inline void cpuhp_lock_release(bo
 #endif
 
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
@@ -143,7 +151,7 @@ static bool cpuhp_step_empty(bool bringu
 }
 
 /**
- * cpuhp_invoke_callback _ Invoke the callbacks for a given state
+ * cpuhp_invoke_callback - Invoke the callbacks for a given state
  * @cpu:	The cpu for which the callback should be invoked
  * @state:	The state to do callbacks for
  * @bringup:	True if the bringup callback should be invoked
@@ -151,6 +159,8 @@ static bool cpuhp_step_empty(bool bringu
  * @lastp:	For multi-instance rollback, remember how far we got
  *
  * Called from cpu hotplug and from the state register machinery.
+ *
+ * Return: %0 on success or a negative errno code
  */
 static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 				 bool bringup, struct hlist_node *node,
@@ -1183,6 +1193,8 @@ static int cpu_down(unsigned int cpu, en
  * This function is meant to be used by device core cpu subsystem only.
  *
  * Other subsystems should use remove_cpu() instead.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int cpu_device_down(struct device *dev)
 {
@@ -1395,6 +1407,8 @@ out:
  * This function is meant to be used by device core cpu subsystem only.
  *
  * Other subsystems should use add_cpu() instead.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int cpu_device_up(struct device *dev)
 {
@@ -1420,6 +1434,8 @@ EXPORT_SYMBOL_GPL(add_cpu);
  * On some architectures like arm64, we can hibernate on any CPU, but on
  * wake up the CPU we hibernated on might be offline as a side effect of
  * using maxcpus= for example.
+ *
+ * Return: %0 on success or a negative errno code
  */
 int bringup_hibernate_cpu(unsigned int sleep_cpu)
 {
@@ -1976,6 +1992,7 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_inst
 /**
  * __cpuhp_setup_state_cpuslocked - Setup the callbacks for an hotplug machine state
  * @state:		The state to setup
+ * @name:		Name of the step
  * @invoke:		If true, the startup function is invoked for cpus where
  *			cpu state >= @state
  * @startup:		startup callback function
@@ -1984,9 +2001,9 @@ EXPORT_SYMBOL_GPL(__cpuhp_state_add_inst
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
