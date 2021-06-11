Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87C2E3A4848
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhFKSFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbhFKSFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43C8C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so9069796wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qAtXrYtTKAjubB/CfqzcW0qPkrE4h/QWzwA7h1ieoNI=;
        b=QsBgteIVTIPrq8EFD1E3aenC56/7SCZmvD15enK/pa+Z14PezVMdjjvzhJwDRAkPJn
         pdJbdofNL2Rt7vC07kqeSj2r5PBlP41sFyBLExVU728UuSCvcXCesf+zmFDGC8ZuzmJI
         Bt1ln7u9PGBNhJQ2lkEFWLVdn57DybF+NlrVQQvm34mRA83AJZRuL2OjNAqASQ/bYQql
         pN6s+9FLgMpcUWB9E9cCVgkTzCFpqL5kyetI95oG0iXJZgau4iJTqNtF5RHot2RFnAO3
         1yr4Z4p8VpU2LfVwFvem7Quh/H4Rn2+Em1XlBue5HB3/+pIjP0OzY9jyQGXyGdsbzATb
         wydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAtXrYtTKAjubB/CfqzcW0qPkrE4h/QWzwA7h1ieoNI=;
        b=SaZOqWkF+4AHVQCMpW9Jo2rZZ5OyE4N3GpJtYMsLv+vKNDtJEvRf3JwycKQEFlZJSs
         0Bpb/zlo+EMcWN3b3tEVvydsSKYNMnJgwbyITHeNHCmfB+WPFXNm/o+KCXP0roBpA48R
         XVvn2/yQegwWI5iYfqiXq7qj4LO37c6IGJ33OKPa30jbnlN4m7QtK7/D8CHgi9U+Hgzd
         RU9SGrhe4Kkbvs7Ubh/jJtyR2B5Fw5ooujE1WxEiyN9k7Uo3dUDvSy/sKO8ZMJcy1m7E
         6j6CLYBtUZ1opkAwBnkXZfd+togVpwzH76nFdqC7oVK7m/wwbAGqrJE8b9f0792A5meZ
         k3hA==
X-Gm-Message-State: AOAM5329rkgFx3M+sw8FwS3Z7XPTztP4Cb7wEW8QgVEJXXlk31jIajQc
        OX4WD/6gywS6JXbfexDVyFRunM1gwTNGmZ0q
X-Google-Smtp-Source: ABdhPJxDiMG7k0pGxtQd+aP0tIwbK6JgIm5Mu592Q36+FPcz2MVr+SuvCabpHvYUD8fu8i4NsvWc4g==
X-Received: by 2002:a1c:4606:: with SMTP id t6mr5118270wma.122.1623434576179;
        Fri, 11 Jun 2021 11:02:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:55 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v3 05/23] x86: Remove compat_arch_setup_additional_pages()
Date:   Fri, 11 Jun 2021 19:02:24 +0100
Message-Id: <20210611180242.711399-6-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same as for x32 task, detect ia32 task by in_ia32_syscall().
A process that has just done sys_exec() for compatible ELF
is doing compatible syscall after personality is set in
load_elf_binary(), see the comment near in_32bit_syscall().

Removing compat_arch_setup_additional_pages() provides single point of
entry - arch_setup_additional_pages(), makes ifdeffery easier to read,
aligns the code with powerpc and sparc (mips also has single vdso setup
function, but instead of taking bitness from mm.context, takes vdso
image pointer there).
Together with arm64 code align to use in_compat_task(), it makes
possible to remove compat_arch_setup_additional_pages() macro
re-definition from compat elf code (another redefined macro less).

Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c  | 48 +++++++++++++++-----------------------
 arch/x86/include/asm/elf.h |  5 ----
 2 files changed, 19 insertions(+), 34 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 43d42ce82e86..99415ffb9501 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -375,50 +375,40 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	return map_vdso(image, addr);
 }
 
-#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static int load_vdso32(void)
-{
-	if (vdso32_enabled != 1)  /* Other values all mean "disabled" */
-		return 0;
-
-	return map_vdso(&vdso_image_32, 0);
-}
-#endif
-
 #ifdef CONFIG_X86_64
-int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+static int load_vdso_64(void)
 {
 	if (!vdso64_enabled)
 		return 0;
 
-	return map_vdso_randomized(&vdso_image_64);
-}
-
-#ifdef CONFIG_COMPAT
-int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp)
-{
 #ifdef CONFIG_X86_X32_ABI
-	if (in_x32_syscall()) {
-		if (!vdso64_enabled)
-			return 0;
+	if (in_x32_syscall())
 		return map_vdso_randomized(&vdso_image_x32);
-	}
 #endif
-#ifdef CONFIG_IA32_EMULATION
-	return load_vdso32();
+
+	return map_vdso_randomized(&vdso_image_64);
+}
 #else
-	return 0;
-#endif
+static int load_vdso_64(void)
+{
+	WARN_ON_ONCE(1);
+	return -ENODATA;
 }
 #endif
-#else
+
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 {
-	return load_vdso32();
-}
+#if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
+	if (in_ia32_syscall()) {
+		if (vdso32_enabled != 1)  /* Other values all mean "disabled" */
+			return 0;
+		return map_vdso(&vdso_image_32, 0);
+	}
 #endif
 
+	return load_vdso_64();
+}
+
 bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 {
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 9ee5b3b3ba93..93ff2c7ca4df 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -377,11 +377,6 @@ else if (IS_ENABLED(CONFIG_IA32_EMULATION))				\
 	((unsigned long)current->mm->context.vdso +			\
 	 vdso_image_32.sym___kernel_vsyscall)
 
-struct linux_binprm;
-extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp);
-#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
-
 extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 
 /* Do not change the values. See get_align_mask() */
-- 
2.31.1

