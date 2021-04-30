Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E371B370246
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbhD3UjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236018AbhD3UjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:39:03 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8265EC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v12so141332wrq.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/r5fensnn55MXUHGBjpVLt7X4x9tXaFMDjcQRg5EpA=;
        b=pexmQbQ2FMIQxijpDpJd6fg0rB4mjAoVdriFE0Hgh8XZsvWHuA/3dwZP5rkvNy3zGY
         mASCu3x/Cq7WpSBR+NosE6dIr4GhsgazyE9d8iU4YgLdMTtZXUHX/6/ZAH/HOM2/sXIP
         wFoYUEdK8FQJ/ZqJ0jvifLwM35CsuVBl97xHhqHPyBp1FxXbVhxxsGeEqtnnTp3J/bA/
         tHeGH4XhRBmcuiNF3kLeJfzL8uV0UekgmktmOOHKtRMkYHIDyICngB0Iry49YI3/CLrE
         mRCuxblAdzF614H65jLBQAAeKhen8EENODgW0y/F1k72nBXMAG7NZ68uLdU0wyLnVftQ
         6pUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/r5fensnn55MXUHGBjpVLt7X4x9tXaFMDjcQRg5EpA=;
        b=gPKtwc9b2pQpgSkytMilvjgSphQBVzdNf/dVlPYVwi1dosf1EYG3ciWcTsRTVw8HsS
         gfQ+gUpneZ2fKDz+7wH5U3nAH35GoyNjUusBBt39J1z1FXb4a7xfcgTGLc4myNNG4Lzx
         aeWjW+kf/oMbf8rkHP8stwOq3NHEbOv3n28Kqa4plfNP1vEv4TcOBGOvqz8CypNLvTwL
         uBfbjPNJ1BqP+ZrcfOB3HQVFxRrf6BkpDhZnZZYxx2xePBEnT85QmHCKyjm380ovkPT9
         U720XFwdJLa7jAnhb1QUudnvNLLwZAh856L0UpCdDo0fBjNlIxcJHGp6Nm6GRKh9iOhB
         sioA==
X-Gm-Message-State: AOAM533dq/x2qwK16SFjuVsptl7G4oNRdkdnn4UP54nrhlbIWhx300Tw
        u18tsHxLXx8SFc25rpe+oBQ=
X-Google-Smtp-Source: ABdhPJw6Is/XQCrdPf2RWrx2UDyKsq3WAbsN9+WvxGVTgubk8Utvsd5KsPP9jEdHm4ZExet7PCLdRQ==
X-Received: by 2002:a05:6000:362:: with SMTP id f2mr9506423wrf.141.1619815093267;
        Fri, 30 Apr 2021 13:38:13 -0700 (PDT)
Received: from amanieu-desktop.home ([2a00:23c6:f081:f801:93ef:94e:9f8:1f0])
        by smtp.gmail.com with ESMTPSA id r5sm4384239wmh.23.2021.04.30.13.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:38:13 -0700 (PDT)
From:   Amanieu d'Antras <amanieu@gmail.com>
Cc:     Amanieu d'Antras <amanieu@gmail.com>,
        Ryan Houdek <Houdek.Ryan@fex-emu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/8] arm64: mm: Use HAVE_ARCH_COMPAT_MMAP_BASES
Date:   Fri, 30 Apr 2021 21:37:54 +0100
Message-Id: <20210430203757.47653-4-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430202810.44092-1-amanieu@gmail.com>
References: <20210430202810.44092-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches arm64 to use separate mmap_base for 32-bit and
64-bit mmaps. This is needed to ensure that compat syscalls
invoked by 64-bit tasks perform VM allocations in the low 4G of the
address space.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 arch/arm64/Kconfig                 |  1 +
 arch/arm64/include/asm/elf.h       |  8 +++++---
 arch/arm64/include/asm/processor.h | 33 ++++++++++++++++++------------
 arch/arm64/mm/mmap.c               | 33 ++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index dfdc3e0af5e1..d57b7bcbd758 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -133,6 +133,7 @@ config ARM64
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_BITREVERSE
+	select HAVE_ARCH_COMPAT_MMAP_BASES if COMPAT
 	select HAVE_ARCH_COMPILER_H
 	select HAVE_ARCH_HUGE_VMAP
 	select HAVE_ARCH_JUMP_LABEL
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 8d1c8dcb87fd..e21964898d06 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -187,12 +187,14 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 
 /* 1GB of VA */
+#define STACK_RND_MASK_64		(0x3ffff >> (PAGE_SHIFT - 12))
 #ifdef CONFIG_COMPAT
+#define STACK_RND_MASK_32		(0x7ff >> (PAGE_SHIFT - 12))
 #define STACK_RND_MASK			(test_thread_flag(TIF_32BIT) ? \
-						0x7ff >> (PAGE_SHIFT - 12) : \
-						0x3ffff >> (PAGE_SHIFT - 12))
+						STACK_RND_MASK_32 : \
+						STACK_RND_MASK_64)
 #else
-#define STACK_RND_MASK			(0x3ffff >> (PAGE_SHIFT - 12))
+#define STACK_RND_MASK			STACK_RND_MASK_64
 #endif
 
 #ifdef __AARCH64EB__
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index f47528aae321..f8309f8d0ece 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -70,29 +70,36 @@
 
 #ifdef CONFIG_ARM64_FORCE_52BIT
 #define STACK_TOP_MAX		TASK_SIZE_64
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 4))
+#define TASK_UNMAPPED_BASE_64	(PAGE_ALIGN(TASK_SIZE_64 / 4))
 #else
 #define STACK_TOP_MAX		DEFAULT_MAP_WINDOW_64
-#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(DEFAULT_MAP_WINDOW / 4))
+#define TASK_UNMAPPED_BASE_64	(PAGE_ALIGN(DEFAULT_MAP_WINDOW_64 / 4))
 #endif /* CONFIG_ARM64_FORCE_52BIT */
 
+#ifdef CONFIG_COMPAT
+#define TASK_UNMAPPED_BASE_32	(PAGE_ALIGN(TASK_SIZE_32 / 4))
+#define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_32BIT) ? \
+				TASK_UNMAPPED_BASE_32 : TASK_UNMAPPED_BASE_64)
+#else
+#define TASK_UNMAPPED_BASE	TASK_UNMAPPED_BASE_64
+#endif /* CONFIG_COMPAT */
+
+#define STACK_TOP_64		STACK_TOP_MAX
 #ifdef CONFIG_COMPAT
 #define AARCH32_VECTORS_BASE	0xffff0000
+#define STACK_TOP_32		AARCH32_VECTORS_BASE
 #define STACK_TOP		(test_thread_flag(TIF_32BIT) ? \
-				AARCH32_VECTORS_BASE : STACK_TOP_MAX)
+				STACK_TOP_32 : STACK_TOP_64)
 #else
-#define STACK_TOP		STACK_TOP_MAX
+#define STACK_TOP		STACK_TOP_64
 #endif /* CONFIG_COMPAT */
 
-#ifndef CONFIG_ARM64_FORCE_52BIT
-#define arch_get_mmap_end(addr) ((addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE :\
-				DEFAULT_MAP_WINDOW)
-
-#define arch_get_mmap_base_topdown(addr) \
-	((addr > DEFAULT_MAP_WINDOW) ? \
-	current->mm->mmap_base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
-	current->mm->mmap_base)
-#endif /* CONFIG_ARM64_FORCE_52BIT */
+#define arch_get_mmap_end arch_get_mmap_end
+#define arch_get_mmap_base arch_get_mmap_base
+#define arch_get_mmap_base_topdown arch_get_mmap_base_topdown
+unsigned long arch_get_mmap_end(unsigned long addr);
+unsigned long arch_get_mmap_base(unsigned long addr);
+unsigned long arch_get_mmap_base_topdown(unsigned long addr);
 
 extern phys_addr_t arm64_dma_phys_limit;
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index a38f54cd638c..956cab3ade11 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -38,3 +38,36 @@ int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return !(((pfn << PAGE_SHIFT) + size) & ~PHYS_MASK);
 }
+
+unsigned long arch_get_mmap_end(unsigned long addr)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return TASK_SIZE_32;
+#endif /* CONFIG_COMPAT */
+#ifndef CONFIG_ARM64_FORCE_52BIT
+	if (addr > DEFAULT_MAP_WINDOW_64)
+		return TASK_SIZE_64;
+#endif /* CONFIG_ARM64_FORCE_52BIT */
+	return DEFAULT_MAP_WINDOW_64;
+}
+unsigned long arch_get_mmap_base(unsigned long addr)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return current->mm->mmap_compat_base;
+#endif /* CONFIG_COMPAT */
+	return current->mm->mmap_base;
+}
+unsigned long arch_get_mmap_base_topdown(unsigned long addr)
+{
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall())
+		return current->mm->mmap_compat_base;
+#endif /* CONFIG_COMPAT */
+#ifndef CONFIG_ARM64_FORCE_52BIT
+	if (addr > DEFAULT_MAP_WINDOW_64)
+		return current->mm->mmap_base + TASK_SIZE - DEFAULT_MAP_WINDOW_64;
+#endif /* CONFIG_ARM64_FORCE_52BIT */
+	return current->mm->mmap_base;
+}
-- 
2.31.1

