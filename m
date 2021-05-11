Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07ED379BBF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 02:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhEKA5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 20:57:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36297 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEKA5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 20:57:07 -0400
Received: from tazenda.hos.anvin.org ([IPv6:2601:646:8602:8be0:7285:c2ff:fefb:fd4])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14B0tdw92504247
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 10 May 2021 17:55:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14B0tdw92504247
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1620694551;
        bh=W5h3PopoE+8MCUpVyxR2cKife06YcaZ4CXNONqZHdV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ai6LNybksVsT0hzJ1ck9EuuwIMtWQLolLAf0lvTA+TUWm9iwQmSOOAegL7nEfhm64
         ARyrBHqzD8GDdSH6tAl0n859Sfn5r6y/65P9ECRcqVL8fliurfU2SzGZD+Kh0kIuVC
         l7bgc2mdPmEoMB3puxFn0bjGQlzv670tfeYGbUQ04uWzwJjhxHYyzmzb82EZCgemO5
         UUpbpFdlC/jJAnfJR4dJsiWvov9VdN6E6vV+QPuHIgu1qpDKaOzTDLFtnx5jC8tZel
         uAUEF1kIder6+2BzNfAfBGFkRantA133pDQJiiplfsg8GbljhAnnzB8Snl2tenO+QF
         ZmBrr9JbCUlbw==
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Steve Wahl <steve.wahl@hpe.com>, Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>
Subject: [PATCH 4/6] x86/irq: merge common code in DEFINE_IDTENTRY_SYSVEC[_SIMPLE]
Date:   Mon, 10 May 2021 17:55:29 -0700
Message-Id: <20210511005531.1065536-5-hpa@zytor.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210511005531.1065536-1-hpa@zytor.com>
References: <20210511005531.1065536-1-hpa@zytor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Move the common code in DEFINE_IDTENTRY_SYSVEC[_SIMPLE] into a common
macro.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
---
 arch/x86/include/asm/idtentry.h | 35 ++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index c03a18cac78e..de3727db021a 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -219,6 +219,23 @@ static noinline void __##func(struct pt_regs *regs, u32 vector)
 #define DECLARE_IDTENTRY_SYSVEC(vector, func)				\
 	DECLARE_IDTENTRY(vector, func)
 
+/**
+ * IDTENTRY_INVOKE_SYSVEC - Common code for system vector IDT entry points
+ * @what:	What should be called
+ *
+ * Common code for DEFINE_IDTENTRY_SYSVEC and _SYSVEC_SIMPLE
+ */
+#define IDTENTRY_INVOKE_SYSVEC(what)					\
+do {									\
+	irqentry_state_t state = irqentry_enter(regs);			\
+									\
+	instrumentation_begin();					\
+	kvm_set_cpu_l1tf_flush_l1d();					\
+	what;								\
+	instrumentation_end();						\
+	irqentry_exit(regs, state);					\
+} while (0)								\
+
 /**
  * DEFINE_IDTENTRY_SYSVEC - Emit code for system vector IDT entry points
  * @func:	Function name of the entry point
@@ -233,13 +250,7 @@ static void __##func(struct pt_regs *regs);				\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	kvm_set_cpu_l1tf_flush_l1d();					\
-	run_sysvec_on_irqstack_cond(__##func, regs);			\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	IDTENTRY_INVOKE_SYSVEC(run_sysvec_on_irqstack_cond(__##func, regs)); \
 }									\
 									\
 static noinline void __##func(struct pt_regs *regs)
@@ -260,15 +271,7 @@ static __always_inline void __##func(struct pt_regs *regs);		\
 									\
 __visible noinstr void func(struct pt_regs *regs)			\
 {									\
-	irqentry_state_t state = irqentry_enter(regs);			\
-									\
-	instrumentation_begin();					\
-	__irq_enter_raw();						\
-	kvm_set_cpu_l1tf_flush_l1d();					\
-	__##func (regs);						\
-	__irq_exit_raw();						\
-	instrumentation_end();						\
-	irqentry_exit(regs, state);					\
+	IDTENTRY_INVOKE_SYSVEC(__irq_enter_raw(); __##func(regs); __irq_exit_raw()); \
 }									\
 									\
 static __always_inline void __##func(struct pt_regs *regs)
-- 
2.31.1

