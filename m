Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089BB4602FF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 03:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234867AbhK1Cdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 21:33:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbhK1Cbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 21:31:33 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A719C061574
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 18:28:18 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so12530856pjc.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Nov 2021 18:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si4rOrqX/eJVRfxqg7o9yRvduz/4ozbOvrqHySRirg4=;
        b=Y7/MwRRcyiq8YM4oKNZLlqefpvr6hkSSXw0KUK6+BfW5fDZmzNFPoArL9kSvzWFVKW
         +/7ZhnVNVgNnzM46DA4yH+wxq8k70nNUxAj/rpLDnOLaR2ZoF60Z3jHrUa6hSS2yp14p
         0FL6NCZSYWUv/wsOmIbCL6LMyOnN/P97/1ECDO11rPaLbb14rmP1FrNlYxdQKGyxP+iT
         O5X7Uyosl0N91ZMLOBYydkthRI3B8nKwnEIdGWEXN9fgx4mlsFadJtOHSkvtyl3wPecv
         G0gHq5Nspzady0KnKMt1Ohc6+LX4Pd9RUY5434w81byRdzj16IrZQsRAcTvp7oq4PYL9
         hKzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Si4rOrqX/eJVRfxqg7o9yRvduz/4ozbOvrqHySRirg4=;
        b=ltrXLGv0cvKtY3xNanjVILfDIHnRJz3CNKdbJqqnUy2Nu350znWnfFwYYHDlQZ/vBX
         fZ6dpkui+RBg2c4202DGAylBsJWWwLrB7SPP3PVQUQM1IClR27qxaHJJIWU30EyJnve4
         S+V8jgvluE9AwB9tSPSskWFeNsQx6fJ+b8ghtogHl22DesWOnztizknqdAbjmBTwJotc
         0gdDy1PM/kBdWASRmlacxatZxKchZw0Xe30AE1eSS+C258ib2wUqOm0bUkbveQCCf9Al
         GsXvlPx9+VpIWWMFMid96xWAk82wHDbFnz+8FFmaYirG4IkTEXBJTs/n8vSDGvyt6PAM
         8Y1g==
X-Gm-Message-State: AOAM530Oje4UBHZvzjHzAph/0wL4dd+fV0IKQR8xXacV82SIa8Gxo9An
        xFfXrrTVFRiZ7Hq20CxYPc60xSklGz4=
X-Google-Smtp-Source: ABdhPJya9ElONcpp1kxxXq77pLwRouEs3bzF91Fv95oBDdLGolRxuLDNATmb0HQRj7End3QNMmuZPQ==
X-Received: by 2002:a17:90b:4c02:: with SMTP id na2mr27730611pjb.94.1638066497196;
        Sat, 27 Nov 2021 18:28:17 -0800 (PST)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id u13sm8742747pgp.27.2021.11.27.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 18:28:16 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Christian Brauner <christian@brauner.io>,
        Petr Mladek <pmladek@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chris Down <chris@chrisdown.name>,
        openrisc@lists.librecores.org
Subject: [PATCH] openrisc: remove wrappers for clone and fork
Date:   Sun, 28 Nov 2021 11:28:01 +0900
Message-Id: <20211128022803.3828408-1-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment here explains that the extra saved registers are clobbered
by _switch.  However, looking at switch they are definitely saved, so I
am not sure why these wrappers are needed.  This was noticed when
auditing the clone3 syscall path which works fine and does not have the
extra wrapper code.

The patch removes the wrapper code as a cleanup.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/syscalls.h |  7 ------
 arch/openrisc/kernel/entry.S         | 36 ++--------------------------
 2 files changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/openrisc/include/asm/syscalls.h b/arch/openrisc/include/asm/syscalls.h
index 3a7eeae6f56a..c8c8a5072ad9 100644
--- a/arch/openrisc/include/asm/syscalls.h
+++ b/arch/openrisc/include/asm/syscalls.h
@@ -20,11 +20,4 @@ asmlinkage long sys_or1k_atomic(unsigned long type, unsigned long *v1,
 
 #include <asm-generic/syscalls.h>
 
-asmlinkage long __sys_clone(unsigned long clone_flags, unsigned long newsp,
-			void __user *parent_tid, void __user *child_tid, int tls);
-asmlinkage long __sys_fork(void);
-
-#define sys_clone __sys_clone
-#define sys_fork __sys_fork
-
 #endif /* __ASM_OPENRISC_SYSCALLS_H */
diff --git a/arch/openrisc/kernel/entry.S b/arch/openrisc/kernel/entry.S
index 59c6d3aa7081..062967e09fbb 100644
--- a/arch/openrisc/kernel/entry.S
+++ b/arch/openrisc/kernel/entry.S
@@ -1139,43 +1139,11 @@ ENTRY(_switch)
 
 /* ==================================================================== */
 
-/* These all use the delay slot for setting the argument register, so the
+/*
+ * This uses the delay slot for setting the argument register, so the
  * jump is always happening after the l.addi instruction.
- *
- * These are all just wrappers that don't touch the link-register r9, so the
- * return from the "real" syscall function will return back to the syscall
- * code that did the l.jal that brought us here.
- */
-
-/* fork requires that we save all the callee-saved registers because they
- * are all effectively clobbered by the call to _switch.  Here we store
- * all the registers that aren't touched by the syscall fast path and thus
- * weren't saved there.
  */
 
-_fork_save_extra_regs_and_call:
-	l.sw    PT_GPR14(r1),r14
-	l.sw    PT_GPR16(r1),r16
-	l.sw    PT_GPR18(r1),r18
-	l.sw    PT_GPR20(r1),r20
-	l.sw    PT_GPR22(r1),r22
-	l.sw    PT_GPR24(r1),r24
-	l.sw    PT_GPR26(r1),r26
-	l.jr	r29
-	 l.sw    PT_GPR28(r1),r28
-
-ENTRY(__sys_clone)
-	l.movhi	r29,hi(sys_clone)
-	l.ori	r29,r29,lo(sys_clone)
-	l.j	_fork_save_extra_regs_and_call
-	 l.nop
-
-ENTRY(__sys_fork)
-	l.movhi	r29,hi(sys_fork)
-	l.ori	r29,r29,lo(sys_fork)
-	l.j	_fork_save_extra_regs_and_call
-	 l.nop
-
 ENTRY(sys_rt_sigreturn)
 	l.jal	_sys_rt_sigreturn
 	 l.addi	r3,r1,0
-- 
2.31.1

