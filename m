Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6B53A4843
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFKSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhFKSEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:04:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21FCEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:49 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id n7so840518wri.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=POB23j6eHMKYG01YnciLSXona0k20rJCyri3H+TNOj0=;
        b=dOVQy/kVwqT4KlA5abtC8FqncKhVZ5AfFF0HiWRUl0SawKd6tZfZlmvt+wQfQRYCXW
         AyfAACuVkJDn+DCxIclHxL7D8bFqFOzndT1yO887sOM8wTTv6mjI6QtLgItGVz/op2PW
         sMxNao3tsj2P3Rh07BLoFGdBkSIH+W0SZMP6Z7SS3QBs0tDa7tOuvKPApSSEJq/kQV3N
         7XUwYRk3lJtb95KHS5AZrHsT22QvKOOLoBh7DzMnsjfDFEpDP4XHfqFQQWCWLO8fTxfn
         r6gTTVBNIBIueqw+NX0v2IqRC4iMn8TFlLrjU+GPs2kkzS3ZXvJnZj50XaGVd4ibmciH
         iwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=POB23j6eHMKYG01YnciLSXona0k20rJCyri3H+TNOj0=;
        b=FApuIopSP+B4uxa/2HtwW9gMK3w2WAfxIR5Y27vMGY8toeBOZBNHbNkb4qg1tp//Ob
         RhqwELYV1dr0POXfRIgkcrBQvT0DlXsM9UsbbSFTTcKlu5jFLk9s2pojTmtJ5pjxa8BG
         yZz3xoDtG1ATsG7IQYMiE2BBPgRo2oYGuNkukBvO1/uv8ax9gkMN/gYNv3a8K/p8tivt
         uT2XheXvwbQ25Kf+GTWZ0AFUTvkaB+ykr6NF+Fo6fLrPMOalHswMo6DzaKrpFkaRK8or
         Q7W99JmpLhCNb07A70SUAVnx8EofdSORWukUbfJJemcwte4zZeMnV6EHEQ7HUpBUI1Vc
         kxLw==
X-Gm-Message-State: AOAM531fFuPw96hLwN+dJLpll/1tTeWE1EbgnW2ZDiaoab87dvvB/Ze4
        QDgKmRu6Gdmns0MvQfcIhiEzDLDPoLX2pJkT
X-Google-Smtp-Source: ABdhPJyEH0MGfiTNEJlmzeoOCJojcNIa6hYlchwmfKyECwamFJDX2Nf9R4tD8iUIz5XiSxiXmVXMTg==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr5507921wrn.156.1623434567338;
        Fri, 11 Jun 2021 11:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:02:46 -0700 (PDT)
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
Subject: [PATCH v3 01/23] x86/elf: Check in_x32_syscall() in compat_arch_setup_additional_pages()
Date:   Fri, 11 Jun 2021 19:02:20 +0100
Message-Id: <20210611180242.711399-2-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Partly revert commit 3316ec8ccd34 ("x86/elf: Use e_machine to check for
x32/ia32 in setup_additional_pages()") and commit 9a29a671902c ("elf:
Expose ELF header on arch_setup_additional_pages()".
Both patches did a good thing: removed usage of TIF_X32, but with
a price of additional macros ARCH_SETUP_ADDITIONAL_PAGES() and ifdeffs.

Instead, use in_x32_syscall() - the first thing load_elf_binary() does
after parsing and checking new ELF binary. It's done that early after
exec() that mmap() code already uses it straight away, which is needed
to know which mmap_base to use (see arch_pick_mmap_layout()).
Add comments to describe how it works.

Cc: x86@kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vma.c     |  4 ++--
 arch/x86/include/asm/compat.h |  6 ++++++
 arch/x86/include/asm/elf.h    |  6 ++----
 fs/binfmt_elf.c               | 10 +++++++---
 fs/compat_binfmt_elf.c        | 11 +++--------
 include/linux/elf.h           |  5 -----
 6 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..43d42ce82e86 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -396,10 +396,10 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 #ifdef CONFIG_COMPAT
 int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-				       int uses_interp, bool x32)
+				       int uses_interp)
 {
 #ifdef CONFIG_X86_X32_ABI
-	if (x32) {
+	if (in_x32_syscall()) {
 		if (!vdso64_enabled)
 			return 0;
 		return map_vdso_randomized(&vdso_image_x32);
diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index be09c7eac89f..58f76665042c 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -186,6 +186,12 @@ static inline bool in_x32_syscall(void)
 	return false;
 }
 
+/*
+ * Valid all the time on the context of a process that performs syscall.
+ * Just exec()ed process has __X32_SYSCALL_BIT or TS_COMPAT set very
+ * early in load_binary() on setting personality and flags.
+ * See also set_personality_ia32().
+ */
 static inline bool in_32bit_syscall(void)
 {
 	return in_ia32_syscall() || in_x32_syscall();
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 7d7500806af8..c0b5733005af 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -383,10 +383,8 @@ struct linux_binprm;
 extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 				       int uses_interp);
 extern int compat_arch_setup_additional_pages(struct linux_binprm *bprm,
-					      int uses_interp, bool x32);
-#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter)	\
-	compat_arch_setup_additional_pages(bprm, interpreter,		\
-					   (ex->e_machine == EM_X86_64))
+					      int uses_interp);
+#define compat_arch_setup_additional_pages compat_arch_setup_additional_pages
 
 extern bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs);
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 187b3f2b9202..2347d9067df6 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1002,8 +1002,12 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	if (retval)
 		goto out_free_dentry;
 
-	/* Do this immediately, since STACK_TOP as used in setup_arg_pages
-	   may depend on the personality.  */
+	/*
+	 * Do this immediately, since STACK_TOP as used in setup_arg_pages
+	 * may depend on the personality. At this moment sys_exec()
+	 * for loaded compatible application becomes non-native syscall
+	 * and in_compat_syscall() starts working.
+	 */
 	SET_PERSONALITY2(*elf_ex, &arch_state);
 	if (elf_read_implies_exec(*elf_ex, executable_stack))
 		current->personality |= READ_IMPLIES_EXEC;
@@ -1249,7 +1253,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	set_binfmt(&elf_format);
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
+	retval = arch_setup_additional_pages(bprm, !!interpreter);
 	if (retval < 0)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 95e72d271b95..049ba7c011b9 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -110,16 +110,11 @@
 #define START_THREAD		COMPAT_START_THREAD
 #endif
 
-#ifdef compat_arch_setup_additional_pages
-#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
-	compat_arch_setup_additional_pages(bprm, interpreter)
-#endif
-
-#ifdef	COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
+#ifdef	compat_arch_setup_additional_pages
 #undef	ARCH_HAS_SETUP_ADDITIONAL_PAGES
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-#undef	ARCH_SETUP_ADDITIONAL_PAGES
-#define	ARCH_SETUP_ADDITIONAL_PAGES COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
+#undef	arch_setup_additional_pages
+#define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
 
 #ifdef	compat_elf_read_implies_exec
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c9a46c4e183b..6dbcfe7a3fd7 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -27,11 +27,6 @@
 	start_thread(regs, elf_entry, start_stack)
 #endif
 
-#if defined(ARCH_HAS_SETUP_ADDITIONAL_PAGES) && !defined(ARCH_SETUP_ADDITIONAL_PAGES)
-#define ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
-	arch_setup_additional_pages(bprm, interpreter)
-#endif
-
 #define ELF32_GNU_PROPERTY_ALIGN	4
 #define ELF64_GNU_PROPERTY_ALIGN	8
 
-- 
2.31.1

