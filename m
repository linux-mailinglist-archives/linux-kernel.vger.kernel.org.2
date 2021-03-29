Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC2A34C0B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 02:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhC2Axe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 20:53:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229656AbhC2Awy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 20:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616979173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=69GpLbOz0QHTnLpbyX9friDlBeuGYvpOcAw9PCViQI0=;
        b=PHRZEDgicgdxN/de0B0kQW59LQqGSshJQXOMJtlcSWbEX3sj6qdr1dEho5ok7Nat8d9m0r
        iBBd9gzS+0e++IPZdf2OxA+65hi8+hSKGD/I9Auhm0AR9n3P/FLeTstV174Veig0IDzKCc
        /TwxSbAnFPR35TzkHS0VDGFnF1S1xfE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-eHwymyidPGiCS6_xtxGuGw-1; Sun, 28 Mar 2021 20:52:51 -0400
X-MC-Unique: eHwymyidPGiCS6_xtxGuGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 033941005D54;
        Mon, 29 Mar 2021 00:52:50 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.14])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 988AE62464;
        Mon, 29 Mar 2021 00:52:45 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Marc Zyngier <maz@kernel.org>, Waiman Long <longman@redhat.com>
Subject: [PATCH v2] x86/apic/vector: Move pr_warn() out of vector_lock
Date:   Sun, 28 Mar 2021 20:52:36 -0400
Message-Id: <20210329005236.1218-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that the following circular locking dependency warning
could happen in some systems:

[  218.097878] ======================================================
[  218.097879] WARNING: possible circular locking dependency detected
[  218.097880] 4.18.0-228.el8.x86_64+debug #1 Not tainted
[  218.097881] ------------------------------------------------------
[  218.097882] systemd/1 is trying to acquire lock:
[  218.097883] ffffffff84c27920 (console_owner){-.-.}, at: console_unlock+0x3fb/0x9f0
[  218.097886]
[  218.097887] but task is already holding lock:
[  218.097888] ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
[  218.097891]
[  218.097892] which lock already depends on the new lock.
[  218.097893]
[  218.097893]
[  218.097894] the existing dependency chain (in reverse order) is:
[  218.097895]
[  218.097896] -> #3 (vector_lock){-.-.}:
[  218.097899]        _raw_spin_lock_irqsave+0x48/0x81
[  218.097900]        x86_vector_activate+0xca/0xab0
[  218.097901]        __irq_domain_activate_irq+0xdb/0x160
[  218.097901]        __irq_domain_activate_irq+0x7d/0x160
[  218.097902]        __irq_domain_activate_irq+0x7d/0x160
[  218.097903]        irq_domain_activate_irq+0x95/0x130
[  218.097904]        __setup_irq+0x861/0x1e60
[  218.097905]        request_threaded_irq+0x1e7/0x2c0
[  218.097906]        acpi_os_install_interrupt_handler+0x14c/0x180
[  218.097907]        acpi_ev_install_sci_handler+0xc4/0xef
[  218.097908]        acpi_ev_install_xrupt_handlers+0x85/0x15f
[  218.097909]        acpi_enable_subsystem+0x345/0x394
[  218.097910]        acpi_init+0x157/0x612
[  218.097910]        do_one_initcall+0xe9/0x57d
[  218.097911]        kernel_init_freeable+0x606/0x6d4
[  218.097912]        kernel_init+0xc/0x121
[  218.097913]        ret_from_fork+0x27/0x50
[  218.097914]
[  218.097914] -> #2 (&irq_desc_lock_class){-.-.}:
[  218.097917]        _raw_spin_lock_irqsave+0x48/0x81
[  218.097918]        __irq_get_desc_lock+0xcf/0x140
[  218.097919]        __dble_irq_nosync+0x6e/0x110
[  218.097920]        serial8250_do_startup+0x17a6/0x1ed0
[  218.097921]        uart_startup.part.7+0x16f/0x4b0
[  218.097922]        tty_port_open+0x112/0x190
[  218.097922]        uart_open+0xe0/0x150
[  218.097923]        tty_open+0x229/0x9a0
[  218.097924]        chrdev_open+0x1e0/0x4e0
[  218.097925]        do_dentry_open+0x3d9/0xea0
[  218.097926]        path_openat+0xb73/0x2690
[  218.097927]        do_filp_open+0x17c/0x250
[  218.097927]        do_sys_open+0x1d9/0x360
[  218.097928]        kernel_init_freeable+0x62e/0x6d4
[  218.097929]        kernel_init+0xc/0x121
[  218.097930]        ret_from_fork+0x27/0x50
[  218.097930]
[  218.097931] -> #1 (&port_lock_key){-.-.}:
[  218.097934]        _raw_spin_lock_irqsave+0x48/0x81
[  218.097935]        serial8250_console_write+0x629/0x770
[  218.097936]        console_unlock+0x611/0x9f0
[  218.097937]        register_console+0x54c/0xa70
[  218.097938]        univ8250_console_init+0x24/0x27
[  218.097938]        console_init+0x2ef/0x45a
[  218.097939]        start_kernel+0x4c4/0x7c5
[  218.097940]        secondary_startup_64+0xb7/0xc0
[
[  218.097941] -> #0 (console_owner){-.-.}:
[  218.097944]        __lock_acquire+0x2894/0x7300
[  218.097945]        lock_acquire+0x14f/0x3b0
[  218.097946]        console_unlock+0x45d/0x9f0
[  218.097947]        vprintk_emit+0x147/0x450
[  218.097947]        printk+0x9f/0xc5
[  218.097948]        x86_vector_activate+0x3f8/0xab0
[  218.097949]        __irq_domain_activate_irq+0xdb/0x160
[  218.097950]        __irq_domain_activate_irq+0x7d/0x160
[  218.097951]        __irq_domain_activate_irq+0x7d/0x160
[  218.097952]        irq_domain_activate_irq+0x95/0x130
[  218.097953]        __setup_irq+0x861/0x1e60
[  218.097954]        request_threaded_irq+0x1e7/0x2c0
[  218.097955]        univ8250_setup_irq+0x6ef/0x8b0
[  218.097955]        serial8250_do_startup+0x7d4/0x1ed0
[  218.097956]        uart_startup.part.7+0x16f/0x4b0
[  218.097957]        tty_port_open+0x112/0x190
[  218.097958]        uart_open+0xe0/0x150
[  218.097959]        tty_open+0x229/0x9a0
[  218.097960]        chrdev_open+0x1e0/0x4e0
[  218.097960]        do_dentry_open+0x3d9/0xea0
[  218.097961]        path_openat+0xb73/0x2690
[  218.097962]        do_filp_open+0x17c/0x250
[  218.097963]        do_sys_open+0x1d9/0x360
[  218.097964]        do_syscall_64+0xa5/0x4d0
[  218.097965]        entry_SYSCALL_64_after_hwframe+0x6a/0xdf
[  218.097965]
[  218.097966] other info that might help us debug this:
[  218.097967]
[  218.097967] Chain exists of:
[  218.097968]   console_oc_lock_class --> vector_lock
[  218.097972]
[  218.097973]  Possible unsafe locking scenario:
[  218.097973]
[  218.097974]        CPU0                    CPU1
[  218.097975]        ----                    ----
[  218.097975]   lock(vector_lock);
[  218.097977]                                lock(&irq_desc_lock_class);
[  218.097980]                                lock(vector_lock);
[  218.097981]   lock(console_owner);
[  218.097983]
[  218.097984]  *** DEADLOCK ***
[  218.097984]
[  218.097985] 6 locks held by systemd/1:
[  218.097986]  #0: ffff88822b5cc1e8 (&tty->legacy_mutex){+.+.}, at: tty_init_dev+0x79/0x440
[  218.097989]  #1: ffff88832ee00770 (&port->mutex){+.+.}, at: tty_port_open+0x85/0x190
[  218.097993]  #2: ffff88813be85a88 (&desc->request_mutex){+.+.}, at: __setup_irq+0x249/0x1e60
[  218.097996]  #3: ffff88813be858c0 (&irq_desc_lock_class){-.-.}, at: __setup_irq+0x2d9/0x1e60
[  218.098000]  #4: ffffffff84afca78 (vector_lock){-.-.}, at: x86_vector_activate+0xca/0xab0
[  218.098003]  #5: ffffffff84c27e20 (console_lock){+.+.}, at: vprintk_emit+0x13a/0x450
[  218.098007]
[  218.098007] stack backtrace:
[  218.098009] CPU: 1 PID: 1 Comm: systemdt tainted 4.18.0-228.el8.x86_64+debug #1
[  218.098010] Hardware name: HP ProLiant DL385p Gen8, BIOS A28 03/07/2016
[  218.098010] Call Trace:
[  218.098011]  dump_stack+0x9a/0xf0
[  218.098012]  check_noncircular+0x317/0x3c0
[  218.098013]  ? print_circular_bug+0x1e0/0x1e0
[  218.098014]  ? do_profile_hits.isra.4.cold.9+0x2d/0x2d
[  218.098015]  ? sched_clock+0x5/0x10
[  218.098015]  __lock_acquire+0x2894/0x7300
[  218.098016]  ? trace_hardirqs_on+0x10/0x10
[  218.098017]  ? lock_downgrade+0x6f0/0x6f0
[  218.098018]  lock_acquire+0x14f/0x3b0
[  218.098019]  ? console_unlock+0x3fb/0x9f0
[  218.098019]  console_unlock+0x45d/0x9f0
[  218.098020]  ? console_unlock+0x3fb/0x9f0
[  218.098021]  vprintk_emit+0x147/0x450
[  218.098022]  ? apic_update_irq_cfg+0x3f6/0x520
[  218.098023]  printk+0x9f/0xc5
[  218.098023]  ? kmsg_dump_rewind_nolock+0xd9/0xd9
[  218.098024]  x86_vector_activate+0x3f8/0xab0
[  218.098025]  ? find_held_lock+0x3a/0x1c0
[  218.098026]  __irq_domain_activate_irq+0xdb/0x160
[  218.098027]  __irq_domain_activate_irq+0x7d/0x160
[  218.098028]  __irq_domain_activate_irq+0x7d/0x160
[  218.098029]  irq_domain_activate_irq+0x95/0x130
[  218.098029]  ? __init_waitqueue_head+0x3a/0x90
[  218.098030]  __setup_irq+0x861/0x1e60
[  218.098031]  ? kmem_cache_alloc_trace+0x169/0x360
[  218.098032]  ? request_threaded_irq+0xf9/0x2c0
[  218.098033]  request_threaded_irq+0x1e7/0x2c0
[  218.098033]  univ8250_setup_irq+0x6ef/0x8b0
[  218.50_do_startup+0x7d4/0x1ed0
[  218.098035]  uart_startup.part.7+0x16f/0x4b0
[  218.098036]  tty_port_open+0x112/0x190
[  218.098037]  ? _raw_spin_unlock+0x1f/0x30
[  218.098037]  uart_open+0xe0/0x150
[  218.098038]  tty_open+0x229/0x9a0
[  218.098039]  ? lock_acquire+0x14f/0x3b0
[  218.098040]  ? tty_init_dev+0x440/0x440
[  218.098041]  ? selinux_file_open+0x2cf/0x400
[  218.098041]  chrdev_open+0x1e0/0x4e0
[  218.098042]  ? cdev_put.part.0+0x50/0x50
[  218.098043]  do_dentry_open+0x3d9/0xea0
[  218.098044]  ? cdev_put.part.0+0x50/0x50
[  218.098045]  ? devcgroup_check_permission+0x17c/0x2f0
[  218.098046]  ? __x64_sys_fchdir+0x180/0x180
[  218.098046]  ? security_inode_permission+0x79/0xc0
[  218.098047]  path_openat+0xb73/0x2690
[  218.098048]  ? save_stack+0x81/0xb0
[  218.098049]  ? path_lookupat+0x820/0x820
[  218.098049]  ? sched_clock+0x5/0x10
[  218.098050]  ? sched_clock_cpu+0x18/0x1e0
[  218.098051]  ? do_syscall_64+0xa5/0x4d0
[  218.098052]  ? entry_SYSCALL_64_after_hwframe+0x6a/0xdf
[  218.098053]  ? __lock_acquire+0x646/0x7300
[  218.098054]  ? sched_clock_cpu+0x18/0x1e0
[  218.098054]  ? find_held_lock+0x3a/0x1c0 filp_open+0x17c/0x250
[  218.098056]  ? may_open_dev+0xc0/0xc0
[  218.098057]  ? do_raw_spin_unlock+0x54/0x230
[  218.098058]  ? _raw_spin_unlock+0x1f/0x30
[  218.098058]  ? _raw_spin_unlock_irq+0x24/0x40
[  218.098059]  do_sys_open+0x1d9/0x360
[  218.098060]  ? filp_open+0x50/0x50
[  218.098061]  ? entry_SYSCALL_64_after_hwframe+0x7a/0xdf
[  218.098062]  ? do_syscall_64+0x22/0x4d0
[  218.098062]  do_syscall_64+0xa5/0x4d0
[  218.098063]  entry_SYSCALL_64_after_hwframe+0x6a/0xdf
[  218.098064] RIP: 0033:0x7ff4ee7620d6

This lockdep warning was causing by printing of the warning message:

[  218.095152] irq 3: Affinity broken due to vector space exhaustion.

To avoid this potential deadlock scenario, this patch moves all the
pr_warn() calls in the vector.c file out of the vector_lock critical
sections.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/apic/vector.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 3c9c7492252f..79f1ce3a9539 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -385,7 +385,7 @@ static void x86_vector_deactivate(struct irq_domain *dom, struct irq_data *irqd)
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
 }
 
-static int activate_reserved(struct irq_data *irqd)
+static int activate_reserved(struct irq_data *irqd, char *wbuf, size_t wsize)
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	int ret;
@@ -410,8 +410,9 @@ static int activate_reserved(struct irq_data *irqd)
 	 */
 	if (!cpumask_subset(irq_data_get_effective_affinity_mask(irqd),
 			    irq_data_get_affinity_mask(irqd))) {
-		pr_warn("irq %u: Affinity broken due to vector space exhaustion.\n",
-			irqd->irq);
+		snprintf(wbuf, wsize, KERN_WARNING
+			 "irq %u: Affinity broken due to vector space exhaustion.\n",
+			 irqd->irq);
 	}
 
 	return ret;
@@ -446,11 +447,13 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
 {
 	struct apic_chip_data *apicd = apic_chip_data(irqd);
 	unsigned long flags;
+	char warnbuf[256];
 	int ret = 0;
 
 	trace_vector_activate(irqd->irq, apicd->is_managed,
 			      apicd->can_reserve, reserve);
 
+	warnbuf[0] = '\0';
 	raw_spin_lock_irqsave(&vector_lock, flags);
 	if (!apicd->can_reserve && !apicd->is_managed)
 		assign_irq_vector_any_locked(irqd);
@@ -459,8 +462,10 @@ static int x86_vector_activate(struct irq_domain *dom, struct irq_data *irqd,
 	else if (apicd->is_managed)
 		ret = activate_managed(irqd);
 	else if (apicd->has_reserved)
-		ret = activate_reserved(irqd);
+		ret = activate_reserved(irqd, warnbuf, sizeof(warnbuf));
 	raw_spin_unlock_irqrestore(&vector_lock, flags);
+	if (warnbuf[0])
+		printk(warnbuf);
 	return ret;
 }
 
@@ -989,6 +994,7 @@ void irq_force_complete_move(struct irq_desc *desc)
 	struct apic_chip_data *apicd;
 	struct irq_data *irqd;
 	unsigned int vector;
+	bool warn_move_in_progress = false;
 
 	/*
 	 * The function is called for all descriptors regardless of which
@@ -1064,12 +1070,14 @@ void irq_force_complete_move(struct irq_desc *desc)
 		 * so we have the necessary information when a problem in that
 		 * area arises.
 		 */
-		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
-			irqd->irq, vector);
+		warn_move_in_progress = true;
 	}
 	free_moved_vector(apicd);
 unlock:
 	raw_spin_unlock(&vector_lock);
+	if (warn_move_in_progress)
+		pr_warn("IRQ fixup: irq %d move in progress, old vector %d\n",
+			irqd->irq, vector);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1079,25 +1087,24 @@ void irq_force_complete_move(struct irq_desc *desc)
  */
 int lapic_can_unplug_cpu(void)
 {
-	unsigned int rsvd, avl, tomove, cpu = smp_processor_id();
+	unsigned int rsvd = 0, avl, tomove, cpu = smp_processor_id();
 	int ret = 0;
 
 	raw_spin_lock(&vector_lock);
 	tomove = irq_matrix_allocated(vector_matrix);
 	avl = irq_matrix_available(vector_matrix, true);
+	if (avl < tomove)
+		ret = -ENOSPC;
+	else
+		rsvd = irq_matrix_reserved(vector_matrix);
+	raw_spin_unlock(&vector_lock);
 	if (avl < tomove) {
 		pr_warn("CPU %u has %u vectors, %u available. Cannot disable CPU\n",
 			cpu, tomove, avl);
-		ret = -ENOSPC;
-		goto out;
-	}
-	rsvd = irq_matrix_reserved(vector_matrix);
-	if (avl < rsvd) {
+	} else if (avl < rsvd) {
 		pr_warn("Reserved vectors %u > available %u. IRQ request may fail\n",
 			rsvd, avl);
 	}
-out:
-	raw_spin_unlock(&vector_lock);
 	return ret;
 }
 #endif /* HOTPLUG_CPU */
-- 
2.18.1

