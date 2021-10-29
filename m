Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050C343FC54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJ2Mbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 08:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhJ2Mbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 08:31:36 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF31C061714
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:29:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id np13so7103515pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 05:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gEraMLFzSplNAUy4i7pXqNhRNlM3ihBS+/+Sge7ndc4=;
        b=ah2O7AkmSl6iAasakF8esWUKnZ41GCbgjz/a9jgwiIVjwxhoAxXNpHL1c9tLKKAey3
         qm40lI5IRbvB3pOaDhQN39nlMiSyyaLDQ8/dhMUgIm4zKQ1PnAWDgkgkQ/lKCvkX9LHa
         AJPyuQ9BdB8QByfLg2RZV1EWYWfysSV6UVzp8S41JzJ1t3pchG0tnzwgp4zabFNt53PY
         vRVRHg7RiHmhTF9M69REUj3xuWzJGDbK0IWvpZIdbdkitrfvaUuvGZ1bsaBEJ94+rOIS
         BDXwPVFeebIPnD3g81jH1GK2FBQGeraYybDUPW9vADVxQ6i8A3/sw3pzmZiYQ8eULi70
         V1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gEraMLFzSplNAUy4i7pXqNhRNlM3ihBS+/+Sge7ndc4=;
        b=JouOV6+yUKmRWMVnd2xlPn0+PRuXEfCHE3Au7m5qqDLp1fbY5qaeWtZ0bQ0d8aTIs4
         2/O7L2/U/WzS7ELO+H+DYF5r7E0hD/v7zwtjYX1U7HTDebJtfpyu4KIFptwVY+HuBkyV
         LmGbsb5e0obk6xKOKsPPPxI1tsOtzkk1ldL00ssf4piDCbj5sAU8noijfsbQkY3DeE5J
         tPhcuhy7Ft8Nb7xZesBvTqhZjsGYpyMKbMfbthQ2fdQARgwtJI8eusLzpkKh4ide21Pw
         bubTqIlNniI16WD734VVKnfNRGcsvCAyeuIacQqASDPdNoEkVF3AVdPpt5gHKnedVNQy
         69JA==
X-Gm-Message-State: AOAM531BIgYcoNlT0KqYfDOg8AVwE1/0KuQjpgD0IR8+BiJgS0KiuUh2
        j2zJ1Lwn0SoNOVX1h1GcpDk=
X-Google-Smtp-Source: ABdhPJzqG/4wKfBpqiS70pcdj0yWDnLPNau7LJZaalU5J9VP7co0YAeHM3wyFx74G1AbFFbsb1lQDw==
X-Received: by 2002:a17:90a:fe87:: with SMTP id co7mr1372091pjb.21.1635510547268;
        Fri, 29 Oct 2021 05:29:07 -0700 (PDT)
Received: from bj04871pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g8sm7033143pfv.123.2021.10.29.05.29.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Oct 2021 05:29:06 -0700 (PDT)
From:   Janet Liu <jianhua.ljh@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        orson.zhai@unisoc.com
Subject: [PATCH v1 2/2] arm64: kprobes: add support for KPROBES_ON_FTRACE
Date:   Fri, 29 Oct 2021 20:27:45 +0800
Message-Id: <1635510465-20469-2-git-send-email-jianhua.ljh@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1635510465-20469-1-git-send-email-jianhua.ljh@gmail.com>
References: <1635510465-20469-1-git-send-email-jianhua.ljh@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janet Liu <janet.liu@unisoc.com>

This patch allow kprobes on ftrace call sites. This optimization
avoids use of a trap with regular kprobes.

This depends on HAVE_DYNAMIC_FTRACE_WITH_REGS which depends on
"patchable-function-entry" options which is only implemented with newer
toolchains.

Signed-off-by: Janet Liu <janet.liu@unisoc.com>
---
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/kernel/probes/Makefile  |  1 +
 arch/arm64/kernel/probes/ftrace.c  | 73 ++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/probes/kprobes.c | 27 ++++++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/kernel/probes/ftrace.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ab07251..c3fd0dd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -200,6 +200,7 @@ config ARM64
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
 	select HAVE_OPTPROBES
+	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
index c77c92a..d9b204f 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -3,5 +3,6 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
 				   kprobes_trampoline.o		\
 				   simulate-insn.o
 obj-$(CONFIG_OPTPROBES) 	+= opt.o opt_head.o
+obj-$(CONFIG_KPROBES_ON_FTRACE) += ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
 				   simulate-insn.o
diff --git a/arch/arm64/kernel/probes/ftrace.c b/arch/arm64/kernel/probes/ftrace.c
new file mode 100644
index 0000000..46ea92e
--- /dev/null
+++ b/arch/arm64/kernel/probes/ftrace.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Dynamic Ftrace based Kprobes Optimization
+//
+// Copyright (C) 2021, Unisoc Inc.
+// Author: Janet Liu <janet.liu@unisoc.com>
+#include <linux/kprobes.h>
+#include <linux/ptrace.h>
+#include <linux/hardirq.h>
+#include <linux/preempt.h>
+#include <linux/ftrace.h>
+
+
+/* Ftrace callback handler for kprobes*/
+void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+	int bit;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	preempt_disable_notrace();
+	p = get_kprobe((kprobe_opcode_t *)ip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		goto end;
+
+	kcb = get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_ip = instruction_pointer(regs);
+
+		instruction_pointer_set(regs, ip);
+
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 *Emulate singlestep (and also recover regs->pc)
+			 *as if there is a nop
+			 */
+			instruction_pointer_set(regs,
+					(unsigned long)p->addr + MCOUNT_INSN_SIZE);
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			instruction_pointer_set(regs, orig_ip);
+		}
+
+		/*
+		 * If pre_handler returns !0,it changes regs->pc. We have to
+		 * skip emulating post_handler.
+		 */
+		__this_cpu_write(current_kprobe, NULL);
+	}
+end:
+	preempt_enable_notrace();
+	ftrace_test_recursion_unlock(bit);
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn = NULL;
+	p->ainsn.api.restore = 0;
+	return 0;
+}
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 6dbcc89..3d371d3 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -417,6 +417,33 @@ int __kprobes arch_trampoline_kprobe(struct kprobe *p)
 	return 0;
 }
 
+kprobe_opcode_t __kprobes *kprobe_lookup_name(const char *name, unsigned int offset)
+{
+	kprobe_opcode_t *addr;
+
+	addr = (kprobe_opcode_t *)kallsyms_lookup_name(name);
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	if (addr && !offset) {
+		unsigned long faddr;
+
+		faddr = ftrace_location_range((unsigned long)addr,
+					      (unsigned long)addr + 8);
+		if (faddr)
+			addr = (kprobe_opcode_t *)faddr;
+	}
+#endif
+	return addr;
+}
+
+bool __kprobes arch_kprobe_on_func_entry(unsigned long offset)
+{
+#ifdef CONFIG_KPROBES_ON_FTRACE
+	return offset <= 8;
+#else
+	return !offset;
+#endif
+}
+
 int __init arch_init_kprobes(void)
 {
 	register_kernel_break_hook(&kprobes_break_hook);
-- 
1.9.1

