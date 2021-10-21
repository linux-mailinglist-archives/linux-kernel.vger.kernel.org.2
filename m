Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B431243685A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbhJUQyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJUQyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:54:00 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E550CC061764
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:51:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id g5so854572plg.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utoy+jQZzvRnzA1QWeuCmlU/QiIEQT6LKCT7U63qum8=;
        b=x8/aeoXyTGmp//1afH0+pe+lHvlkIprY9l6+jEEMrD9x/aw8fI1lNPBwex0dW1q0hF
         6GWTNfl5PefzN5QSEjiNqb/NkgWKFVXxiAY24Z2ttZN+NSPZ8ecr48c9Ep2zOFA85kDF
         PRsXpmhyhbo4GsT2Xgf9iifyDaB7045MsUQlaKHDqb5ggq8eKo9iEjG1N+5wbU11GJgn
         9DJz9SrYhm2cuzF7hXks8UUV1T26+6Ps4Qj8FNpsQdbnZzINWDMEhHcYWxNlggdJ2FqC
         qnICeOn9KcXcf9NyUo9mGy93lBg6SKTWkmiLpn0uW95FYEWmEeFVT0ytkGNohN0BKFAy
         NNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=utoy+jQZzvRnzA1QWeuCmlU/QiIEQT6LKCT7U63qum8=;
        b=F8b6ADn+JC13LnGRl7HSJeqp76HNAweFginZCUyLHgp0nPVGiggy3pJyk2RGibMIvK
         eATSewyAeB35n7pQJCstZxQA0mzdxkc16hZugZWRgJrsU9qcdmhYknVM0C0vnammar8L
         sHAWacyx81AJ0mNkh251Wcb7Aj4tRiwiTwrOu4aifkb4M4UcK51qumsf/RFu+5iXIeZE
         PnKe7fA0FUV0nxrrWd+rcsQWm1q7090nV+rSs8vYo57ahb95adDE/soewNGTAVXw3WnO
         EQ8QB1tqY2+ghAcQlhQ823NwMqFaIGKOnx60TGaRLJxZa6DFUCyc06ivAdMO+34srA9w
         yrNg==
X-Gm-Message-State: AOAM532GB8aWlQwqWvqq9mfTLI7eFc978VhSw5R08RQbnv/X0iqq4blk
        INyu3Vm8nQw+18GNFBdU9qUZNA==
X-Google-Smtp-Source: ABdhPJzPn1WnhmqY3wp2dc+1Jtbo+21IiUrqDsvcEMwzsRnJLaf4nWK/njw4aSEB0eHoBWNnGsJMGw==
X-Received: by 2002:a17:90a:2943:: with SMTP id x3mr7820076pjf.71.1634835104442;
        Thu, 21 Oct 2021 09:51:44 -0700 (PDT)
Received: from vineetg-ThinkPad-X1-Carbon-Gen-9.ba.rivosinc.com (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id y4sm7553890pfa.90.2021.10.21.09.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:51:44 -0700 (PDT)
From:   Vineet Gupta <vineetg@rivosinc.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Atish Patra <atish.patra@wdc.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Chen Huang <chenhuang5@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH] riscv: remove code for !CONFIG_FRAME_POINTER
Date:   Thu, 21 Oct 2021 09:51:42 -0700
Message-Id: <20211021165142.444236-1-vineetg@rivosinc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

while frame pointer generates horrible code it is a necessary evil on
RISC-V as the only way to unwind stack.

In fact Kconfig unconditonally selects ARCH_WANT_FRAME_POINTERS, so
any code for handling !FRAME_POINTER is essentially dead weight.

And while here remove redundant setting of -fno-omit-frame-pointer as
this is enabled by generic code for CONFIG_FRAME_POINTER

Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
---
 arch/riscv/Makefile            |  3 ---
 arch/riscv/kernel/stacktrace.c | 37 ++--------------------------------
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index a0b8259c7098..a4329035c341 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -65,9 +65,6 @@ endif
 ifeq ($(CONFIG_CMODEL_MEDANY),y)
 	KBUILD_CFLAGS += -mcmodel=medany
 endif
-ifeq ($(CONFIG_PERF_EVENTS),y)
-        KBUILD_CFLAGS += -fno-omit-frame-pointer
-endif
 
 KBUILD_CFLAGS_MODULE += $(call cc-option,-mno-relax)
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 315db3d0229b..63f471278401 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,13 +16,13 @@
 
 register unsigned long sp_in_global __asm__("sp");
 
-#ifdef CONFIG_FRAME_POINTER
-
 void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 			     bool (*fn)(void *, unsigned long), void *arg)
 {
 	unsigned long fp, sp, pc;
 
+        BUILD_BUG_ON(!IS_ENABLED(CONFIG_FRAME_POINTER));
+
 	if (regs) {
 		fp = frame_pointer(regs);
 		sp = user_stack_pointer(regs);
@@ -65,39 +65,6 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-#else /* !CONFIG_FRAME_POINTER */
-
-void notrace walk_stackframe(struct task_struct *task,
-	struct pt_regs *regs, bool (*fn)(void *, unsigned long), void *arg)
-{
-	unsigned long sp, pc;
-	unsigned long *ksp;
-
-	if (regs) {
-		sp = user_stack_pointer(regs);
-		pc = instruction_pointer(regs);
-	} else if (task == NULL || task == current) {
-		sp = sp_in_global;
-		pc = (unsigned long)walk_stackframe;
-	} else {
-		/* task blocked in __switch_to */
-		sp = task->thread.sp;
-		pc = task->thread.ra;
-	}
-
-	if (unlikely(sp & 0x7))
-		return;
-
-	ksp = (unsigned long *)sp;
-	while (!kstack_end(ksp)) {
-		if (__kernel_text_address(pc) && unlikely(!fn(arg, pc)))
-			break;
-		pc = (*ksp++) - 0x4;
-	}
-}
-
-#endif /* CONFIG_FRAME_POINTER */
-
 static bool print_trace_address(void *arg, unsigned long pc)
 {
 	const char *loglvl = arg;
-- 
2.30.2

