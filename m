Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF5139578E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 10:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhEaIzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 04:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhEaIzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 04:55:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4469C061574
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:54:02 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id t15so2583533eju.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 May 2021 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3Sgy9lxSE/4rJC7tRGP/6YuIFQCgMKdTyw9mrcVWZg=;
        b=fVUmkh6qSAPFNWHN9AX7ozHUcGgip/SzRcHJQBb2bTY9rqgCOJOmmFGLdIdG6r0KYX
         LVAFS3jnCyjU7sZttDAO3hdRRylr2G/mbcM49VydpOPQ2ptxHESXNnJUx1VVe4zKGUrM
         bGGDTr0G2qR2vDIRC6KLCwYWbhA1SZ4ntmc/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3Sgy9lxSE/4rJC7tRGP/6YuIFQCgMKdTyw9mrcVWZg=;
        b=q4oLBEdGy0qWMdBeBznhzQIuDA8k95HzZyHafLKwsBCzX5hS671xXpvrEDPpR9Zb8i
         yB8tgrfou3aVFeRwyMqXbEKTlVntdFVAnJrR491S+4+tplh6wvtdygjgMnskl4ypJd5w
         ln7W02EXti1ZF/KSfJ/HbbftmwggoYo8JD+GQ6abhco0oMJKXo9j/vWZVRiNVYtASwEA
         wpbFKMBM/8Ie064oogJuC0NlEa2WWVv0PwB9Kqg+G9mup684je86vUrJgjTeQ3+TEfol
         AbDSo5YXi5lbh4hsGzfkpURkzI1BThq5Iw3AjUIueeVn0ZPmNyHr+ubo0pJu/qzhiGON
         V75Q==
X-Gm-Message-State: AOAM531x5G0PMASrWjT5FA0yYNBziugkZlrS2gIR8vxh4Mtz7OLh932x
        dRQD3gX3QSlYF5DVCtMPA5nmLi0XjUvV20tY3Gc=
X-Google-Smtp-Source: ABdhPJzkVghUA2l7j4wGR9CmhK24v5IJsEEEwSjLdIcvpqYMumWzIrfDITP3PgVWDLeaIKbAubzduA==
X-Received: by 2002:a17:906:b748:: with SMTP id fx8mr12586650ejb.477.1622451241210;
        Mon, 31 May 2021 01:54:01 -0700 (PDT)
Received: from lootbox.konsulko.bg (lan.nucleusys.com. [92.247.61.126])
        by smtp.gmail.com with ESMTPSA id c19sm1663683edw.10.2021.05.31.01.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 01:54:00 -0700 (PDT)
From:   Vitaly Wool <vitaly.wool@konsulko.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Nicolas Pitre <nico@fluxnic.net>, Alex Ghiti <alex@ghiti.fr>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Subject: [PATCH] riscv: xip: support runtime trap patching
Date:   Mon, 31 May 2021 11:53:42 +0300
Message-Id: <20210531085342.17494-1-vitaly.wool@konsulko.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISCV_ERRATA_ALTERNATIVE patches text at runtime which is currently
not possible when the kernel is executed from the flash in XIP mode.
Since runtime patching concerns only traps at the moment, let's just
have all the traps reside in RAM anyway if RISCV_ERRATA_ALTERNATIVE
is set. Thus, these functions will be patch-able even when the .text
section is in flash.

Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
---
 arch/riscv/kernel/traps.c           | 13 +++++++++----
 arch/riscv/kernel/vmlinux-xip.lds.S | 15 ++++++++++++++-
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 0721b9798595..7bc88d8aab97 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -86,8 +86,13 @@ static void do_trap_error(struct pt_regs *regs, int signo, int code,
 	}
 }
 
+#if defined (CONFIG_XIP_KERNEL) && defined (CONFIG_RISCV_ERRATA_ALTERNATIVE)
+#define __trap_section		__section(".xip.traps")
+#else
+#define __trap_section
+#endif
 #define DO_ERROR_INFO(name, signo, code, str)				\
-asmlinkage __visible void name(struct pt_regs *regs)			\
+asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
 {									\
 	do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
 }
@@ -111,7 +116,7 @@ DO_ERROR_INFO(do_trap_store_misaligned,
 int handle_misaligned_load(struct pt_regs *regs);
 int handle_misaligned_store(struct pt_regs *regs);
 
-asmlinkage void do_trap_load_misaligned(struct pt_regs *regs)
+asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs *regs)
 {
 	if (!handle_misaligned_load(regs))
 		return;
@@ -119,7 +124,7 @@ asmlinkage void do_trap_load_misaligned(struct pt_regs *regs)
 		      "Oops - load address misaligned");
 }
 
-asmlinkage void do_trap_store_misaligned(struct pt_regs *regs)
+asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs *regs)
 {
 	if (!handle_misaligned_store(regs))
 		return;
@@ -146,7 +151,7 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
 	return GET_INSN_LENGTH(insn);
 }
 
-asmlinkage __visible void do_trap_break(struct pt_regs *regs)
+asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 {
 #ifdef CONFIG_KPROBES
 	if (kprobe_single_step_handler(regs))
diff --git a/arch/riscv/kernel/vmlinux-xip.lds.S b/arch/riscv/kernel/vmlinux-xip.lds.S
index 4b29b9917f99..a3ff09c4c3f9 100644
--- a/arch/riscv/kernel/vmlinux-xip.lds.S
+++ b/arch/riscv/kernel/vmlinux-xip.lds.S
@@ -99,9 +99,22 @@ SECTIONS
 	}
 	PERCPU_SECTION(L1_CACHE_BYTES)
 
-	. = ALIGN(PAGE_SIZE);
+	. = ALIGN(8);
+	.alternative : {
+		__alt_start = .;
+		*(.alternative)
+		__alt_end = .;
+	}
 	__init_end = .;
 
+	. = ALIGN(16);
+	.xip.traps : {
+		__xip_traps_start = .;
+		*(.xip.traps)
+		__xip_traps_end = .;
+	}
+
+	. = ALIGN(PAGE_SIZE);
 	.sdata : {
 		__global_pointer$ = . + 0x800;
 		*(.sdata*)
-- 
2.29.2

