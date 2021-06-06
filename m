Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52BA39CF25
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFFMqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:46:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35058 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbhFFMpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:45:44 -0400
Date:   Sun, 06 Jun 2021 12:43:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622983434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UwGm3pwjn6R/zubnWN0+KqKageg4uF2+l43B0f8PACI=;
        b=Bd6ko882hV9wH8eDe1TbANR4c2UCsFenVJgNFWyx55rhinC5ZvAEEP4X0nYaQ6R5M4+g5N
        jf3yT6K98xwZCI/O4KDBs4OYEnfxGGS05dEFEPWNZg9o9fjU2zeasOAJAs0d2j/OXya1Rp
        4Jn5yMD2kYWWCDQiWp8/VvWEGIw0fxIDAScNpCYDLPtdyNS2/V8ZdE2Zz+Axm7hs2EKMNL
        1HJqcXwGHut7GeEqkhC9uwBGQ5wcQZLCik6nF735N6LnfRDA+TN3e+gxXuFzYDKR4vxXD5
        XJ4GDMSdbSHxpQwN1oRIXrQrgTS19R84c7GiaEGY6F2k8PBA13IKB5ShNILeYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622983434;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=UwGm3pwjn6R/zubnWN0+KqKageg4uF2+l43B0f8PACI=;
        b=jKYy/7H126yUTATZnWXfD/hpTMNQ2oFo5mAxQJ9+0Ux9Dfp6SUXvCP6gEq/SqfqXHMCMi8
        h4lGf788SZ6b+TBA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] powerpc: Add missing
 linux/{of.h,irqdomain.h} include directives
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <162298343268.29796.15352904748325771971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     da22dfd6e3b294ad0a22686473382dd8ec913608
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/da22dfd6e3b294ad0a22686473382dd8ec913608
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 13 Sep 2018 17:09:06 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 02 Jun 2021 14:34:48 +01:00

powerpc: Add missing linux/{of.h,irqdomain.h} include directives

A bunch of PPC files are missing the inclusion of linux/of.h and
linux/irqdomain.h, relying on transitive inclusion from another
file.

As we are about to break this dependency, make sure these dependencies
are explicit.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/powerpc/kernel/mce.c                        | 1 +
 arch/powerpc/kvm/book3s_hv_uvmem.c               | 1 +
 arch/powerpc/kvm/book3s_xive.c                   | 1 +
 arch/powerpc/kvm/book3s_xive_native.c            | 1 +
 arch/powerpc/mm/book3s64/radix_pgtable.c         | 1 +
 arch/powerpc/platforms/cell/pmu.c                | 1 +
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 1 +
 arch/powerpc/platforms/ps3/interrupt.c           | 1 +
 arch/powerpc/platforms/pseries/ibmebus.c         | 1 +
 arch/powerpc/sysdev/ehv_pic.c                    | 1 +
 arch/powerpc/sysdev/fsl_mpic_err.c               | 1 +
 arch/powerpc/sysdev/xics/icp-hv.c                | 1 +
 arch/powerpc/sysdev/xics/icp-opal.c              | 1 +
 13 files changed, 13 insertions(+)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index 9a3c2a8..15e7b49 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -18,6 +18,7 @@
 #include <linux/extable.h>
 #include <linux/ftrace.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 
 #include <asm/interrupt.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 84e5a2d..b898a59 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -90,6 +90,7 @@
 #include <linux/migrate.h>
 #include <linux/kvm_host.h>
 #include <linux/ksm.h>
+#include <linux/of.h>
 #include <asm/ultravisor.h>
 #include <asm/mman.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index e7219b6..08910d4 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -14,6 +14,7 @@
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
 #include <linux/uaccess.h>
+#include <linux/irqdomain.h>
 #include <asm/kvm_book3s.h>
 #include <asm/kvm_ppc.h>
 #include <asm/hvcall.h>
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index 76800c8..30bacf6 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -12,6 +12,7 @@
 #include <linux/spinlock.h>
 #include <linux/delay.h>
 #include <linux/file.h>
+#include <linux/irqdomain.h>
 #include <asm/uaccess.h>
 #include <asm/kvm_book3s.h>
 #include <asm/kvm_ppc.h>
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 5fef8db..edadb9e 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/sched/mm.h>
 #include <linux/memblock.h>
+#include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
diff --git a/arch/powerpc/platforms/cell/pmu.c b/arch/powerpc/platforms/cell/pmu.c
index 35bbd15..b207a7f 100644
--- a/arch/powerpc/platforms/cell/pmu.c
+++ b/arch/powerpc/platforms/cell/pmu.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/types.h>
 #include <linux/export.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index d39a921..609bda2 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -12,6 +12,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 78f2339..e68f4fb 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 
 #include <asm/machdep.h>
 #include <asm/udbg.h>
diff --git a/arch/powerpc/platforms/pseries/ibmebus.c b/arch/powerpc/platforms/pseries/ibmebus.c
index a15ab33..c6c79ef 100644
--- a/arch/powerpc/platforms/pseries/ibmebus.c
+++ b/arch/powerpc/platforms/pseries/ibmebus.c
@@ -42,6 +42,7 @@
 #include <linux/kobject.h>
 #include <linux/dma-map-ops.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index 48866e6..0070525 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/irq.h>
+#include <linux/irqdomain.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
diff --git a/arch/powerpc/sysdev/fsl_mpic_err.c b/arch/powerpc/sysdev/fsl_mpic_err.c
index 13583bb..5fa5fa2 100644
--- a/arch/powerpc/sysdev/fsl_mpic_err.c
+++ b/arch/powerpc/sysdev/fsl_mpic_err.c
@@ -8,6 +8,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 
 #include <asm/io.h>
 #include <asm/irq.h>
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index 21b9d1b..6765d9e 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 
diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index 68fd254..675d708 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 
