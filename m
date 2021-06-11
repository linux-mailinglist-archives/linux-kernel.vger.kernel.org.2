Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD943A4855
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFKSFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhFKSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:19 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so9070524wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68Nvhp7T29LVIFC+LrlwpeAGAA5qKhpu52We1KzYa/I=;
        b=KDNEszGRhf34GPx7jEUzm9rwurINQNk2yfN/ZpHk8b8+/SJvv34raLJRc9k9J/NCg2
         gMenA6knxcN8JYDT1yOpvrPPqK5TwNy692fcQ+mujxmCYXTJhFC2JzfZB4SyDhAfYgGu
         Mj7uDMPVCkSd99Whzdqxs+1Ost+4UI+m4zcW5lbYDjHTEgAXZq0LQG1BLXvYdrCuTaxZ
         Z5/dezWQ997cCMyDq/dm9N0fJtdpKUSXgF5D9ZHNoVfeKZYqFEtE7U8NFTMsh230f4yX
         dNUTFjxpAlZM3R7Le7pEXtm5VOWri63Ut5If2/tvFk0c/dnau+95rJo10Mw9W0re3bUQ
         L6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68Nvhp7T29LVIFC+LrlwpeAGAA5qKhpu52We1KzYa/I=;
        b=fzwOdPKmp6z3rCPosgZFX2KEjh3ojT1Ys9DKjXRt6UFQCGbJdx8glsnOc/DBckVme5
         tN9T5tMEMAexium9L9Dtm4CYdUA6GfP3DYsbazojBN0uNu0IRxnNUXskqDFtiCwQCOuu
         nQvfTfMKRhseEeR1iWSLX6Z+FD2lB1PuSj+qvgWx2mIB4efgtLPo0f1oK/fcfLMlP1ID
         gZji79Cbb9VYOMWBj61KUfzOHVJigcLgoIXQrDpbGMYXhlbHpOfh5MCZhXOf/SshMCUT
         Sn0pq2y8ctOrMfsOVt+ZUBpdjq8+P7Jb83RSqK6vkZyZURCxF7ah8en7SRAoBhwDrvFT
         fZ8g==
X-Gm-Message-State: AOAM533qJjOe0Ih80UrP9iYHaaIJWIlwqFYLmCjobsreaE4gkI4QkVBy
        MMsTDZBiZqvanLsuABwtV+XXz9VTeJG4h6EA
X-Google-Smtp-Source: ABdhPJwm1b02aF3j6Te90rrR57RcECIP2EFVKXBY3mLkQr3hI48NbpXivDhvKBUCgwD2jTFaY+DC5A==
X-Received: by 2002:a1c:a54b:: with SMTP id o72mr5068112wme.124.1623434597679;
        Fri, 11 Jun 2021 11:03:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:17 -0700 (PDT)
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
Subject: [PATCH v3 17/23] x86/vdso: Migrate to generic vdso_base
Date:   Fri, 11 Jun 2021 19:02:36 +0100
Message-Id: <20210611180242.711399-18-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the landing vma area.
As a bonus, after unmapping vdso, kernel won't try to land on its
previous position (due to UNMAPPED_VDSO_BASE check instead of
context.vdso != 0 check).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/Kconfig              |  1 +
 arch/x86/entry/common.c       |  2 +-
 arch/x86/entry/vdso/extable.c |  4 ++--
 arch/x86/entry/vdso/vma.c     | 13 ++++++-------
 arch/x86/ia32/ia32_signal.c   |  4 ++--
 arch/x86/include/asm/mmu.h    |  1 -
 arch/x86/include/asm/vdso.h   |  2 +-
 arch/x86/kernel/signal.c      |  4 ++--
 8 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d30b952f4453..b1b6dab92fb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
+	select ARCH_HAS_VDSO_BASE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 385a1c4bf4c0..f5861f6e00a2 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -162,7 +162,7 @@ __visible noinstr long do_fast_syscall_32(struct pt_regs *regs)
 	 * Called using the internal vDSO SYSENTER/SYSCALL32 calling
 	 * convention.  Adjust regs so it looks like we entered using int80.
 	 */
-	landing_pad = (unsigned long)current->mm->context.vdso +
+	landing_pad = (unsigned long)current->mm->vdso_base +
 					vdso_image_32.sym_int80_landing_pad;
 
 	/*
diff --git a/arch/x86/entry/vdso/extable.c b/arch/x86/entry/vdso/extable.c
index afcf5b65beef..e5bfb35dafdb 100644
--- a/arch/x86/entry/vdso/extable.c
+++ b/arch/x86/entry/vdso/extable.c
@@ -25,10 +25,10 @@ bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 	if (trapnr == X86_TRAP_DB || trapnr == X86_TRAP_BP)
 		return false;
 
-	if (!current->mm->context.vdso)
+	if (current->mm->vdso_base == (void __user *)UNMAPPED_VDSO_BASE)
 		return false;
 
-	base =  (unsigned long)current->mm->context.vdso + image->extable_base;
+	base = (unsigned long)current->mm->vdso_base + image->extable_base;
 	nr_entries = image->extable_len / (sizeof(*extable));
 	extable = image->extable;
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index a286d44751be..f17e617c3b3e 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -77,7 +77,7 @@ static void vdso_fix_landing(const struct vdso_image *image,
 		struct pt_regs *regs = current_pt_regs();
 		unsigned long vdso_land = image->sym_int80_landing_pad;
 		unsigned long old_land_addr = vdso_land +
-			(unsigned long)current->mm->context.vdso;
+			(unsigned long)current->mm->vdso_base;
 
 		/* Fixing userspace landing - look at do_fast_syscall_32 */
 		if (regs->ip == old_land_addr)
@@ -92,7 +92,6 @@ static void vdso_mremap(const struct vm_special_mapping *sm,
 	const struct vdso_image *image = current->mm->context.vdso_image;
 
 	vdso_fix_landing(image, new_vma);
-	current->mm->context.vdso = (void __user *)new_vma->vm_start;
 }
 
 #ifdef CONFIG_TIME_NS
@@ -287,7 +286,7 @@ static int map_vdso(const struct vdso_image *image, unsigned long addr,
 		ret = PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
 	} else {
-		current->mm->context.vdso = (void __user *)text_start;
+		current->mm->vdso_base = (void __user *)text_start;
 		current->mm->context.vdso_image = image;
 		*sysinfo_ehdr = text_start;
 	}
@@ -362,8 +361,8 @@ int map_vdso_once(const struct vdso_image *image, unsigned long addr)
 	 * Check if we have already mapped vdso blob - fail to prevent
 	 * abusing from userspace install_special_mapping, which may
 	 * not do accounting and rlimit right.
-	 * We could search vma near context.vdso, but it's a slowpath,
-	 * so let's explicitly check all VMAs to be completely sure.
+	 * It's a slowpath, let's explicitly check all VMAs to be
+	 * completely sure.
 	 */
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
@@ -415,9 +414,9 @@ bool arch_syscall_is_vdso_sigreturn(struct pt_regs *regs)
 {
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
 	const struct vdso_image *image = current->mm->context.vdso_image;
-	unsigned long vdso = (unsigned long) current->mm->context.vdso;
+	unsigned long vdso = (unsigned long) current->mm->vdso_base;
 
-	if (in_ia32_syscall() && image == &vdso_image_32) {
+	if (in_ia32_syscall() && current_has_vdso(&vdso_image_32)) {
 		if (regs->ip == vdso + image->sym_vdso32_sigreturn_landing_pad ||
 		    regs->ip == vdso + image->sym_vdso32_rt_sigreturn_landing_pad)
 			return true;
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 2af40ae53a0e..a98f4c7cdc38 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -256,7 +256,7 @@ int ia32_setup_frame(int sig, struct ksignal *ksig,
 	} else {
 		/* Return stub is in 32bit vsyscall page */
 		if (current_has_vdso(&vdso_image_32))
-			restorer = current->mm->context.vdso +
+			restorer = current->mm->vdso_base +
 				vdso_image_32.sym___kernel_sigreturn;
 		else
 			restorer = &frame->retcode;
@@ -337,7 +337,7 @@ int ia32_setup_rt_frame(int sig, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso(&vdso_image_32))
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->vdso_base +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
 		restorer = &frame->retcode;
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 5d7494631ea9..7bd10e6b8386 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -43,7 +43,6 @@ typedef struct {
 #endif
 
 	struct mutex lock;
-	void __user *vdso;			/* vdso base address */
 	const struct vdso_image *vdso_image;	/* vdso image in use */
 
 	atomic_t perf_rdpmc_allowed;	/* nonzero if rdpmc is allowed */
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 1ea7cb3f9b14..e4dcc189c30d 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -46,7 +46,7 @@ extern const struct vdso_image vdso_image_32;
 #endif
 
 #define current_has_vdso(image)						\
-	(current->mm->context.vdso != 0 &&				\
+	(current->mm->vdso_base != (void __user *)UNMAPPED_VDSO_BASE &&	\
 	current->mm->context.vdso_image == image)
 
 extern void __init init_vdso_image(const struct vdso_image *image);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 77496ccb812d..c853d212e6cb 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -320,7 +320,7 @@ __setup_frame(int sig, struct ksignal *ksig, sigset_t *set,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso(&vdso_image_32))
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->vdso_base +
 			vdso_image_32.sym___kernel_sigreturn;
 	else
 		restorer = &frame->retcode;
@@ -382,7 +382,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
 		restorer = ksig->ka.sa.sa_restorer;
 	else if (current_has_vdso(&vdso_image_32))
-		restorer = current->mm->context.vdso +
+		restorer = current->mm->vdso_base +
 			vdso_image_32.sym___kernel_rt_sigreturn;
 	else
 		restorer = &frame->retcode;
-- 
2.31.1

