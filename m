Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3076387532
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347945AbhERJeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:34:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58860 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbhERJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:34:30 -0400
Message-Id: <20210518093117.968251441@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621330391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Nj6vVjQqhP20P/gc7ktwvGxf5OKwxxGe/sIC+rIcp3c=;
        b=0Ww2cxu0KQvgdejUDgHRbCQMZQYzGAtqLgK6A28Z72YRAbk4EKwcBv/R/52PCF9D90iXXT
        nFgMzZsAqnHNJc244WQJ+9AZc2CUdEuwwvR5QUIH3M2nF50sQcJJVWW8HACf1f6yC9b2Ug
        XE6D0euzEv+fp697UWUPxrg9HUWnDPHQwBYjnkmzl07xQagOem79yzA74arMylSfwl9ogM
        aK2k8W3Xqo/zNIhzJMBzYOITPSExUL81XoL9Qo24sACoBLbunNNWDyg7zF5t0W8sEdCJEE
        fxy2qmwE+imZ4lg6y1IsL885oyDA6fhLnChDEiJCDOVS01KvNuseOzjdWphHzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621330391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=Nj6vVjQqhP20P/gc7ktwvGxf5OKwxxGe/sIC+rIcp3c=;
        b=+qUMQh1JPwTjvi/Cti9zbqXNRf1StZxGS8wUmeYzDtKJRV+6Fv9ew9u9mNWL55PT77/YaH
        +VAow57A0OtDeRDw==
Date:   Tue, 18 May 2021 11:17:26 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: [patch 1/8] genirq: Export affinity setter for modules
References: <20210518091725.046774792@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf modules abuse irq_set_affinity_hint() to set the affinity of system
PMU interrupts just because irq_set_affinity() was not exported.

The fact that irq_set_affinity_hint() actually sets the affinity is a
non-documented side effect and the name is clearly saying it's a hint.

To clean this up, export the real affinity setter.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |   35 ++---------------------------------
 kernel/irq/manage.c       |   33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 34 deletions(-)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -322,39 +322,8 @@ struct irq_affinity_desc {
 
 extern cpumask_var_t irq_default_affinity;
 
-/* Internal implementation. Use the helpers below */
-extern int __irq_set_affinity(unsigned int irq, const struct cpumask *cpumask,
-			      bool force);
-
-/**
- * irq_set_affinity - Set the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
- *
- * Fails if cpumask does not contain an online CPU
- */
-static inline int
-irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
-{
-	return __irq_set_affinity(irq, cpumask, false);
-}
-
-/**
- * irq_force_affinity - Force the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
- *
- * Same as irq_set_affinity, but without checking the mask against
- * online cpus.
- *
- * Solely for low level cpu hotplug code, where we need to make per
- * cpu interrupts affine before the cpu becomes online.
- */
-static inline int
-irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
-{
-	return __irq_set_affinity(irq, cpumask, true);
-}
+extern int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask);
+extern int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask);
 
 extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -441,7 +441,8 @@ int irq_update_affinity_desc(unsigned in
 	return ret;
 }
 
-int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
+static int __irq_set_affinity(unsigned int irq, const struct cpumask *mask,
+			      bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned long flags;
@@ -456,6 +457,36 @@ int __irq_set_affinity(unsigned int irq,
 	return ret;
 }
 
+/**
+ * irq_set_affinity - Set the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Fails if cpumask does not contain an online CPU
+ */
+int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, false);
+}
+EXPORT_SYMBOL_GPL(irq_set_affinity);
+
+/**
+ * irq_force_affinity - Force the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Same as irq_set_affinity, but without checking the mask against
+ * online cpus.
+ *
+ * Solely for low level cpu hotplug code, where we need to make per
+ * cpu interrupts affine before the cpu becomes online.
+ */
+int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, true);
+}
+EXPORT_SYMBOL_GPL(irq_force_affinity);
+
 int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 {
 	unsigned long flags;

