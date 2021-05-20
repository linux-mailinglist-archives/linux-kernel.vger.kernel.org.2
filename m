Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1177738B46A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhETQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234263AbhETQja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:39:30 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1206121E;
        Thu, 20 May 2021 16:38:07 +0000 (UTC)
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1ljlgS-002d7b-K1; Thu, 20 May 2021 17:38:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: [PATCH 09/39] powerpc: Add missing linux/{of.h,irqdomain.h} include directives
Date:   Thu, 20 May 2021 17:37:21 +0100
Message-Id: <20210520163751.27325-10-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520163751.27325-1-maz@kernel.org>
References: <20210520163751.27325-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, ley.foon.tan@intel.com, chris@zankel.net, jcmvbkbc@gmail.com, vgupta@synopsys.com, tsbogend@alpha.franken.de, robert.jarzmik@free.fr, linux@armlinux.org.uk, krzysztof.kozlowski@canonical.com, ysato@users.sourceforge.jp, dalias@libc.org, geert@linux-m68k.org, alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, daniel@ffwll.ch, robdclark@gmail.com, linus.walleij@linaro.org, lee.jones@linaro.org, lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com, bgolaszewski@baylibre.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 9a3c2a84a2ac..15e7b4900689 100644
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
index 84e5a2dc8be5..b898a596db42 100644
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
index e7219b6f5f9a..08910d44d2cb 100644
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
index 76800c84f2a3..30bacf6dd53d 100644
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
index 5fef8db3b463..edadb9e9c9c0 100644
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
index 35bbd15582af..b207a7f99be5 100644
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
index d39a9213a3e6..609bda2ad5dd 100644
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
index 78f2339ed5cb..e68f4fb1c1f4 100644
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
index a15ab33646b3..c6c79ef55e13 100644
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
index 48866e6c1efb..00705258ecf9 100644
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
index 13583bbc3e8e..5fa5fa215541 100644
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
index 21b9d1bf39ff..6765d9e264a3 100644
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
index 68fd2540b093..675d708863d5 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -7,6 +7,7 @@
 #include <linux/irq.h>
 #include <linux/smp.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 
-- 
2.30.2

