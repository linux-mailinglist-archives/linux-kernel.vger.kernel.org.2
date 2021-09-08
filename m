Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69F4403E89
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351972AbhIHRrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350240AbhIHRrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:05 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA035C061292
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:56 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id k23-20020a17090a591700b001976d2db364so2077919pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6oK4jNbYcTMU/+0WJjNoEZPUGOwkloI9wxPkGnC8fjQ=;
        b=HWpPkdxzM/riZwMXGoihezA9YyEA7iOlhkWjRyf7TPUI1cI8fvT7nVIa0ibcjnOpWW
         HefOjm1btTXd/FKCBV9h8zbBsm6EsBMGi9OCzIIdS1fN+zdYu+mWSTo23yAMPmAgt6Fs
         PH2BOFqpWWKsA8Zl779jAgYiBOjj7Ixq1FbzhgARlWxfX8uIMXxeKKz3jffw3Oer+bDk
         HqeGlGAAOH3JvpDZdoRJBgqVzoqNIASr5mVLr3eZ8BGaACTur0EI62O/jo+KlxeHJUdJ
         a2WLxTwQHIFsvWniO8Eay9E5gcOdSI8Z9wPwxjhrvTRq/Vsp4252fVtxhK2l2idM3+se
         OfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6oK4jNbYcTMU/+0WJjNoEZPUGOwkloI9wxPkGnC8fjQ=;
        b=WVObzLciPLnXELxixFcoOj0CIGAGiHwyZswgFEfPIwmnMXEnGbc/QpNt4TgUIVQ4In
         cgBUJuAI6OYn2U8zui3C6l+iDnYRUmjluqNa+RsQStzNGemHvYQlQtM37r9Eto5tBzBL
         l0wxGc1f3IFPqVOJqHkxgtw1SlJn4GfJRW2LuSVB52k2qYg7eT4PjKexo2nMV5adinLS
         5N5Uid+ui9BGBOli9+UCXy2dXPj28NL+z4btH3URdIyEOpROAMfTBBSppyOqbd7bsBxS
         cWlVEnQ0K4jtAm0/JbIMm93s6TNeEqglMLiEjHEOd4PfezZBYmwKhTxzwY+c3lpC8u7M
         gh6w==
X-Gm-Message-State: AOAM531bgGLrR00FoJb6+zZOBS+wgGYGVsrKXYuj+vFXIANose6jpoow
        4WZxRggKZ2OwVTqHX05gR0yjp04Yf+2dBA==
X-Google-Smtp-Source: ABdhPJwiFbDGdjLCARppFuAhuenxzRM2AP38Ty2sMqSVhbefKJDRjzCQI6IB6fU0nc+gd4UWBX1kww==
X-Received: by 2002:a17:903:189:b0:13a:186f:b8b7 with SMTP id z9-20020a170903018900b0013a186fb8b7mr4035031plg.57.1631123156209;
        Wed, 08 Sep 2021 10:45:56 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:55 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 13/21] riscv: Add support for kernel mode vector
Date:   Thu,  9 Sep 2021 01:45:25 +0800
Message-Id: <e3d94eee049fe9f3b6597e21748efbb1d4eb81de.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add <asm/vector.h> containing kernel_rvv_begin()/kernel_rvv_end() function
declarations and corresponding definitions in kernel_mode_vector.c

These are needed to wrap uses of vector in kernel mode.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/vector.h        |  14 ++
 arch/riscv/kernel/Makefile             |   6 +
 arch/riscv/kernel/kernel_mode_vector.c | 184 +++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 arch/riscv/include/asm/vector.h
 create mode 100644 arch/riscv/kernel/kernel_mode_vector.c

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
new file mode 100644
index 000000000000..5d7f14453f68
--- /dev/null
+++ b/arch/riscv/include/asm/vector.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2020 SiFive
+ */
+
+#ifndef __ASM_RISCV_VECTOR_H
+#define __ASM_RISCV_VECTOR_H
+
+#include <linux/types.h>
+
+void kernel_rvv_begin(void);
+void kernel_rvv_end(void);
+
+#endif /* ! __ASM_RISCV_VECTOR_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 344078080839..a2efd3646cd8 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -41,6 +41,12 @@ obj-$(CONFIG_MMU) += vdso.o vdso/
 obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
 obj-$(CONFIG_FPU)		+= fpu.o
 obj-$(CONFIG_VECTOR)		+= vector.o
+obj-$(CONFIG_VECTOR)		+= kernel_mode_vector.o
+riscv-march-cflags-$(CONFIG_ARCH_RV32I)		:= rv32ima
+riscv-march-cflags-$(CONFIG_ARCH_RV64I)		:= rv64ima
+riscv-march-cflags-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-cflags-y)c
+riscv-march-cflags-$(CONFIG_VECTOR)		:= $(riscv-march-cflags-y)v
+CFLAGS_kernel_mode_vector.o	+= -march=$(riscv-march-cflags-y)
 obj-$(CONFIG_SMP)		+= smpboot.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_SMP)		+= cpu_ops.o
diff --git a/arch/riscv/kernel/kernel_mode_vector.c b/arch/riscv/kernel/kernel_mode_vector.c
new file mode 100644
index 000000000000..108cfafe7496
--- /dev/null
+++ b/arch/riscv/kernel/kernel_mode_vector.c
@@ -0,0 +1,184 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ * Author: Catalin Marinas <catalin.marinas@arm.com>
+ * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ * Copyright (C) 2020 SiFive
+ */
+#include <linux/compiler.h>
+#include <linux/irqflags.h>
+#include <linux/percpu.h>
+#include <linux/preempt.h>
+#include <linux/types.h>
+
+#include <asm/vector.h>
+#include <asm/switch_to.h>
+
+DECLARE_PER_CPU(bool, vector_context_busy);
+DEFINE_PER_CPU(bool, vector_context_busy);
+
+/*
+ * may_use_vector - whether it is allowable at this time to issue vector
+ *                instructions or access the vector register file
+ *
+ * Callers must not assume that the result remains true beyond the next
+ * preempt_enable() or return from softirq context.
+ */
+static __must_check inline bool may_use_vector(void)
+{
+	/*
+	 * vector_context_busy is only set while preemption is disabled,
+	 * and is clear whenever preemption is enabled. Since
+	 * this_cpu_read() is atomic w.r.t. preemption, vector_context_busy
+	 * cannot change under our feet -- if it's set we cannot be
+	 * migrated, and if it's clear we cannot be migrated to a CPU
+	 * where it is set.
+	 */
+	return !in_irq() && !irqs_disabled() && !in_nmi() &&
+	       !this_cpu_read(vector_context_busy);
+}
+
+
+
+/*
+ * Claim ownership of the CPU vector context for use by the calling context.
+ *
+ * The caller may freely manipulate the vector context metadata until
+ * put_cpu_vector_context() is called.
+ */
+static void get_cpu_vector_context(void)
+{
+	bool busy;
+
+	preempt_disable();
+	busy = __this_cpu_xchg(vector_context_busy, true);
+
+	WARN_ON(busy);
+}
+
+/*
+ * Release the CPU vector context.
+ *
+ * Must be called from a context in which get_cpu_vector_context() was
+ * previously called, with no call to put_cpu_vector_context() in the
+ * meantime.
+ */
+static void put_cpu_vector_context(void)
+{
+	bool busy = __this_cpu_xchg(vector_context_busy, false);
+
+	WARN_ON(!busy);
+	preempt_enable();
+}
+
+static void rvv_enable(void)
+{
+	csr_set(CSR_STATUS, SR_VS);
+}
+
+static void rvv_disable(void)
+{
+	csr_clear(CSR_STATUS, SR_VS);
+}
+
+static void vector_flush_cpu_state(void)
+{
+	long tmp;
+
+	__asm__ __volatile__ (
+		"vsetvli %0, x0, e8, m1\n"
+		"vmv.v.i v0, 0\n"
+		"vmv.v.i v1, 0\n"
+		"vmv.v.i v2, 0\n"
+		"vmv.v.i v3, 0\n"
+		"vmv.v.i v4, 0\n"
+		"vmv.v.i v5, 0\n"
+		"vmv.v.i v6, 0\n"
+		"vmv.v.i v7, 0\n"
+		"vmv.v.i v8, 0\n"
+		"vmv.v.i v9, 0\n"
+		"vmv.v.i v10, 0\n"
+		"vmv.v.i v11, 0\n"
+		"vmv.v.i v12, 0\n"
+		"vmv.v.i v13, 0\n"
+		"vmv.v.i v14, 0\n"
+		"vmv.v.i v15, 0\n"
+		"vmv.v.i v16, 0\n"
+		"vmv.v.i v17, 0\n"
+		"vmv.v.i v18, 0\n"
+		"vmv.v.i v19, 0\n"
+		"vmv.v.i v20, 0\n"
+		"vmv.v.i v21, 0\n"
+		"vmv.v.i v22, 0\n"
+		"vmv.v.i v23, 0\n"
+		"vmv.v.i v24, 0\n"
+		"vmv.v.i v25, 0\n"
+		"vmv.v.i v26, 0\n"
+		"vmv.v.i v27, 0\n"
+		"vmv.v.i v28, 0\n"
+		"vmv.v.i v29, 0\n"
+		"vmv.v.i v30, 0\n"
+		"vmv.v.i v31, 0\n":"=r"(tmp)::);
+}
+
+/*
+ * kernel_rvv_begin(): obtain the CPU vector registers for use by the calling
+ * context
+ *
+ * Must not be called unless may_use_vector() returns true.
+ * Task context in the vector registers is saved back to memory as necessary.
+ *
+ * A matching call to kernel_rvv_end() must be made before returning from the
+ * calling context.
+ *
+ * The caller may freely use the vector registers until kernel_rvv_end() is
+ * called.
+ */
+void kernel_rvv_begin(void)
+{
+	if (WARN_ON(!has_vector))
+		return;
+
+	WARN_ON(!may_use_vector());
+
+	/* Acquire kernel mode vector */
+	get_cpu_vector_context();
+
+	/* Save vector state, if any */
+	vstate_save(current, task_pt_regs(current));
+
+	/* Enable vector */
+	rvv_enable();
+
+	/* Invalidate vector regs */
+	vector_flush_cpu_state();
+}
+EXPORT_SYMBOL(kernel_rvv_begin);
+
+/*
+ * kernel_rvv_end(): give the CPU vector registers back to the current task
+ *
+ * Must be called from a context in which kernel_rvv_begin() was previously
+ * called, with no call to kernel_rvv_end() in the meantime.
+ *
+ * The caller must not use the vector registers after this function is called,
+ * unless kernel_rvv_begin() is called again in the meantime.
+ */
+void kernel_rvv_end(void)
+{
+	if (WARN_ON(!has_vector))
+		return;
+
+	/* Invalidate vector regs */
+	vector_flush_cpu_state();
+
+	/* Restore vector state, if any */
+	vstate_restore(current, task_pt_regs(current));
+
+	/* disable vector */
+	rvv_disable();
+
+	/* release kernel mode vector */
+	put_cpu_vector_context();
+}
+EXPORT_SYMBOL(kernel_rvv_end);
-- 
2.31.1

