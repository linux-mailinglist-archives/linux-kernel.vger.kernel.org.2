Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86E0442EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 14:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKBNPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 09:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhKBNPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 09:15:48 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A65DC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 06:13:14 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s5so7948525pfg.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N6BBgYB9y9o/KEMrM5XpJsnZe4hC3BDSIOBT2qELU7c=;
        b=bWjsonUYl7kQ0UGD+SKGCAYm/02GkHQmXCEMfMrlh6Bi6hbH5WlKtQ3Y3ixXDkSQow
         Y6MuVIsteJRLVricj5lDvkFn5r77wAkyIXaiBW9si+4YIfHNsC6iIYVRMyuYren+iy4z
         2hV4F6Px/KWOmpONM3vp9LVohzBYUUlJJSVbXJBwjHJ5HCMODkwxaRsg9c/6wPfvLaNb
         Q8rqSThiE5Nu0z+5lL/1ETZZKcohhbzFbJ996+OMQAEjwzPRp2orrE6gwvbisAqB6sWP
         wXl2ekivy+3AGhKJjuxSVx9Oze9RhGSIOSzrdu2tyWLVmrVLfYSjge9w9PwIyhVFTSev
         l5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N6BBgYB9y9o/KEMrM5XpJsnZe4hC3BDSIOBT2qELU7c=;
        b=4cxs1eUzOUzWlpgD10QECn1/DpSBtlqamt98zvushBIzS5mAdw5JqmUs+IliH15pDb
         0USWISXkkI5PCKzIMgCz2Wh+wyX4vfRLIn2OFPy5H9vwUfjTRUBziaIyxRmF73CeWOrT
         3BI3rhv7NwQlPZ3Mie7mKp+Keuhrx3n8V9anRBKeZ/8zlm83cE2Tn17cdrxNJMrKrjve
         WdZZ1wt48HXtQMNienZvwQTJ/jV5NfpLSZBLyB4bhGGZE8WEf6yjaiFq7XaUos21LB+w
         2Sv2TZqcmt1BZY9TVuBUUmhWoFlFCaEVC+32GUJkd1bAtCNYexMxCpuPEi9JpZKEDllh
         kU1Q==
X-Gm-Message-State: AOAM532DXoZcQ1jspR5M/I8BsmrfDauxDtBDj4ObLupBNiMABjq+k1gg
        8wZLFkmm7lMtx7OlEM20oKQ=
X-Google-Smtp-Source: ABdhPJxk3C46k2gLlz/QKD87GqVb3EVkn/YeXW8qP1kCxzlDbiGCvzh9EIu1RNokv6ZV6c5GX4oADQ==
X-Received: by 2002:aa7:8892:0:b0:481:1868:17d9 with SMTP id z18-20020aa78892000000b00481186817d9mr10175338pfe.40.1635858793601;
        Tue, 02 Nov 2021 06:13:13 -0700 (PDT)
Received: from bj04871pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k13sm20924750pfc.197.2021.11.02.06.13.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Nov 2021 06:13:12 -0700 (PDT)
From:   Janet Liu <jianhua.ljh@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        orson.zhai@unisoc.com
Subject: [PATCH v2 2/2] arm64: kprobes: add support for KPROBES_ON_FTRACE
Date:   Tue,  2 Nov 2021 21:11:46 +0800
Message-Id: <1635858706-27320-2-git-send-email-jianhua.ljh@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1635858706-27320-1-git-send-email-jianhua.ljh@gmail.com>
References: <1635858706-27320-1-git-send-email-jianhua.ljh@gmail.com>
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
 arch/arm64/kernel/probes/ftrace.c  | 73 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/probes/kprobes.c | 27 +++++++++++
 4 files changed, 102 insertions(+)
 create mode 100644 arch/arm64/kernel/probes/ftrace.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 339130712093..f59005608976 100644
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
index c77c92ac95fd..d9b204f4795a 100644
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
index 000000000000..46ea92eb552f
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
index 6dbcc89f6662..3d371d3e4dfa 100644
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
2.25.1

