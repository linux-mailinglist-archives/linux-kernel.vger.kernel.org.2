Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3AF403E88
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352628AbhIHRrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352518AbhIHRrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:47:03 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238E2C06179A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 10:45:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1855193pjh.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 10:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=h+N6OkYhHFG6aPexfiEFBTlQ664SH/Om3ht1fYTAMcg=;
        b=V/PY6AojKkWv653U3E0y+FQmnNzosT3tjExRJrOiIulLh5jmurN3fFWiER0RZlc78t
         OhUvkl2D7I7eHOodBNElsQkxGD4VqEODqFgSYqAI2+bAtsICXJdltqKvbYDdDjRiJDsR
         ioaJ2S+Koqe8dUXz9MkuOcRaOx+73rpQeeMM6bh79j0FHjnUTYM2Ghp7aqoYkj7ZUbHv
         Ve7Et+gHLt6GpYa0bj2Ual/N/9dKbGRWqOkSYOQXaq+EhYya0rdjT2cKXeD+vzJlgLr9
         4BuiH4BY2apTIub4pxvcXWOKu7bLBCs1d/bmxw6IFEnbjFXx1cY8gCe3awcVzAHSLA7n
         FFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+N6OkYhHFG6aPexfiEFBTlQ664SH/Om3ht1fYTAMcg=;
        b=ncZ6tE9Our0Z6uh4gF6FUXNHf4fslX8/ffWyTQWh2LQKQlI6GrO3aMMmPTPx1Y2D1f
         tRChoJcJ9d5ALNGr9A1ttNRqAWBGAih36zo6ZRfFWXMWHQjioSSPuhStJoUz77hSRgyX
         OfEm4WMyUhlqr+TXcBcV0mswloY82qU6FgUaOojXGMefrk/lIU198io2pGVYy1tgJTFI
         fP6TZgQUk/zR3LuSckBqFVJkwpkZGvMPi2nbslHqMfnkrdbxeiBSwwuknZAZ5Cgy17Z+
         JuSpQ40jVpiyFeZ6Km6niH3yqa+7kRnhuhRg3Uu5cT2iQ4VBdP4ZKTOfxyNumVL80fPV
         Kaeg==
X-Gm-Message-State: AOAM533pNSoByqF45PFmi1/sH+qbG6rJCEgzjLfOye5PzRT9SBdOZwLU
        Z3XnT00pe2Bycr8RZ1vy9cszYQCgixob4A==
X-Google-Smtp-Source: ABdhPJySbvWTwdd3N6nEf3w+/PxJ5kkkgALXiRqxMaP8xiduoZqHtaa4pbzctHastTRN11Wo2pjN7A==
X-Received: by 2002:a17:90a:cf08:: with SMTP id h8mr5538295pju.1.1631123154661;
        Wed, 08 Sep 2021 10:45:54 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id b5sm3108466pfr.26.2021.09.08.10.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 10:45:54 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, vincent.chen@sifive.com
Subject: [RFC PATCH v8 12/21] riscv: signal: Report signal frame size to userspace via auxv
Date:   Thu,  9 Sep 2021 01:45:24 +0800
Message-Id: <a46ba4d46419f3aff74019a177145a3732a07c99.1631121222.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1631121222.git.greentime.hu@sifive.com>
References: <cover.1631121222.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Chen <vincent.chen@sifive.com>

The vector register belongs to the signal context. They need to be stored
and restored as entering and leaving the signal handler. According to the
V-extension specification, the maximum length of the vector registers can
be 2^(XLEN-1). Hence, if userspace refers to the MINSIGSTKSZ to create a
sigframe, it may not be enough. To resolve this problem, this patch refers
to the commit 94b07c1f8c39c
("arm64: signal: Report signal frame size to userspace via auxv") to enable
userspace to know the minimum required sigframe size through the auxiliary
vector and use it to allocate enough memory for signal context.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/include/asm/elf.h         | 41 +++++++++++++++++-----------
 arch/riscv/include/asm/processor.h   |  2 ++
 arch/riscv/include/uapi/asm/auxvec.h |  1 +
 arch/riscv/kernel/signal.c           |  8 ++++++
 4 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index f4b490cd0e5d..1102052aa593 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -58,22 +58,31 @@ extern unsigned long elf_hwcap;
 #define ELF_PLATFORM	(NULL)
 
 #ifdef CONFIG_MMU
-#define ARCH_DLINFO						\
-do {								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		(elf_addr_t)current->mm->context.vdso);		\
-	NEW_AUX_ENT(AT_L1I_CACHESIZE,				\
-		get_cache_size(1, CACHE_TYPE_INST));		\
-	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY,			\
-		get_cache_geometry(1, CACHE_TYPE_INST));	\
-	NEW_AUX_ENT(AT_L1D_CACHESIZE,				\
-		get_cache_size(1, CACHE_TYPE_DATA));		\
-	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY,			\
-		get_cache_geometry(1, CACHE_TYPE_DATA));	\
-	NEW_AUX_ENT(AT_L2_CACHESIZE,				\
-		get_cache_size(2, CACHE_TYPE_UNIFIED));		\
-	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY,			\
-		get_cache_geometry(2, CACHE_TYPE_UNIFIED));	\
+#define ARCH_DLINFO						 \
+do {								 \
+	NEW_AUX_ENT(AT_SYSINFO_EHDR,				 \
+		(elf_addr_t)current->mm->context.vdso);		 \
+	NEW_AUX_ENT(AT_L1I_CACHESIZE,				 \
+		get_cache_size(1, CACHE_TYPE_INST));		 \
+	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY,			 \
+		get_cache_geometry(1, CACHE_TYPE_INST));	 \
+	NEW_AUX_ENT(AT_L1D_CACHESIZE,				 \
+		get_cache_size(1, CACHE_TYPE_DATA));		 \
+	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY,			 \
+		get_cache_geometry(1, CACHE_TYPE_DATA));	 \
+	NEW_AUX_ENT(AT_L2_CACHESIZE,				 \
+		get_cache_size(2, CACHE_TYPE_UNIFIED));		 \
+	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY,			 \
+		get_cache_geometry(2, CACHE_TYPE_UNIFIED));	 \
+	/*							 \
+	 * Should always be nonzero unless there's a kernel bug. \
+	 * If we haven't determined a sensible value to give to	 \
+	 * userspace, omit the entry:				 \
+	 */							 \
+	if (likely(signal_minsigstksz))				 \
+		NEW_AUX_ENT(AT_MINSIGSTKSZ, signal_minsigstksz); \
+	else							 \
+		NEW_AUX_ENT(AT_IGNORE, 0);			 \
 } while (0)
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 1b037c69d311..62c75645c606 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -7,6 +7,7 @@
 #define _ASM_RISCV_PROCESSOR_H
 
 #include <linux/const.h>
+#include <linux/cache.h>
 
 #include <vdso/processor.h>
 
@@ -74,6 +75,7 @@ int riscv_of_parent_hartid(struct device_node *node);
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 
+extern unsigned long signal_minsigstksz __ro_after_init;
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PROCESSOR_H */
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index 32c73ba1d531..6610d24e6662 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -33,5 +33,6 @@
 
 /* entries in ARCH_DLINFO */
 #define AT_VECTOR_SIZE_ARCH	7
+#define AT_MINSIGSTKSZ 51
 
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
index 6938cfa16b45..d30a3b588156 100644
--- a/arch/riscv/kernel/signal.c
+++ b/arch/riscv/kernel/signal.c
@@ -470,8 +470,16 @@ asmlinkage __visible void do_notify_resume(struct pt_regs *regs,
 		tracehook_notify_resume(regs);
 }
 
+unsigned long __ro_after_init signal_minsigstksz;
+
 void init_rt_signal_env(void);
 void __init init_rt_signal_env(void)
 {
 	rvv_sc_size = sizeof(struct __sc_riscv_v_state) + riscv_vsize;
+	/*
+	 * Determine the stack space required for guaranteed signal delivery.
+	 * The signal_minsigstksz will be populated into the AT_MINSIGSTKSZ entry
+	 * in the auxiliary array at process startup.
+	 */
+	signal_minsigstksz = cal_rt_frame_size();
 }
-- 
2.31.1

