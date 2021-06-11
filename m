Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7D3A484D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhFKSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhFKSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73D9C0613A2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so9070614wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qK6Sfmsnk18p+pY/3Jp3/D7QPEcskhtiQYsgnHttCgM=;
        b=X1YujvJlF2ra/UqUoBe6hsTu57J2faukqK9pfgBYw0mLP20ktjuasQlqEigFsY008Y
         G5fp58HiexZorYx5m92LUJbtZucMqIcAKZAbwxRbYfGanoz6LNe1X+eSwPKVWfWe0SBC
         zH43k8FFiDNQwwHFEVWu3SwSrt6g24ylVopOBZ3iIjMcgsQkTgrkhEVT30e04+H+I7+q
         GjiboVjbS8nzG8z7HvYDJkdNv6piw95JoHRN6XkrlhkFoUXRmSMNAq5YQWb2edmZkVRE
         h3/dBjZX6EmfUaC5L8Jww8eDt+qLFaldVLYGR9u7pdDuVQIg8Ucywm7ALnuUuuHGDj8k
         qGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qK6Sfmsnk18p+pY/3Jp3/D7QPEcskhtiQYsgnHttCgM=;
        b=Y+FKHMT7kK/dNrpA1jz1IdVcpuzac3xrN9BNi2rdJn1ne5WbwbqLUxyXvpIam1lgFP
         isrhVD6FZRK6pxIuQX8Hyx6047AJBoosmbuiyzjcLWatPBciO5A+WJqLPuJFreQ25Al2
         alsY93vfV9IZr1wEO/eCiiT/lOqAJgKiZ+Y9eQ0D+TK64P34BG2NWLN0ZnybcqoetGxZ
         JP/BL+/FPiuDX76kJL57m2TDmBW64YjEMaQ36u/QbeqgqprKcgMV4HmEi20netoHU3/O
         +1fl2CTBDSJpqfqS+B8WEvzbck7XMhbiDZWj2jeREGhUDqapdhOy5vsbm/xeTLl1ZKp2
         qfGg==
X-Gm-Message-State: AOAM533tufWiLJDX4aqx1vzEtqhggbijkUIEnglP+vfLehzBXmc0pGDa
        rtC0WimhmNt05sf7Xb4XedGRIrjiR/t2sOYW
X-Google-Smtp-Source: ABdhPJzsfAsnN+QfedaljjB0qs6vex1uRaAD/AHyC9rAXEh+63DZ+1joWiU5E5gzUyXH2WwnfjlBbA==
X-Received: by 2002:a7b:cf18:: with SMTP id l24mr20822405wmg.160.1623434601227;
        Fri, 11 Jun 2021 11:03:21 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:20 -0700 (PDT)
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
Subject: [PATCH v3 19/23] arm64/vdso: Migrate compat signals to generic vdso_base
Date:   Fri, 11 Jun 2021 19:02:38 +0100
Message-Id: <20210611180242.711399-20-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the landing vma area.
As a bonus, after unmapping sigpage, kernel won't try to land on its
previous position (due to UNMAPPED_VDSO_BASE check instead of
context.vdso ?= 0 check).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/Kconfig           |  1 +
 arch/arm64/include/asm/mmu.h |  3 ---
 arch/arm64/kernel/signal32.c | 17 ++++++++++++-----
 arch/arm64/kernel/vdso.c     | 11 +----------
 4 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 385ef8d8ad9b..073d6c8aa195 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -43,6 +43,7 @@ config ARM64
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TEARDOWN_DMA_OPS if IOMMU_SUPPORT
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VDSO_BASE
 	select ARCH_HAVE_ELF_PROT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 75beffe2ee8a..434acd49dbc3 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -18,9 +18,6 @@
 
 typedef struct {
 	atomic64_t	id;
-#ifdef CONFIG_COMPAT
-	void		*sigpage;
-#endif
 	refcount_t	pinned;
 	void		*vdso;
 	unsigned long	flags;
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 2f507f565c48..3d2ac8062e99 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -315,7 +315,7 @@ static void __user *compat_get_sigframe(struct ksignal *ksig,
 	return frame;
 }
 
-static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+static int compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 				compat_ulong_t __user *rc, void __user *frame,
 				int usig)
 {
@@ -342,13 +342,16 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+		unsigned long land = (unsigned long)current->mm->vdso_base;
 		unsigned int idx = thumb << 1;
 
 		if (ka->sa.sa_flags & SA_SIGINFO)
 			idx += 3;
 
-		retcode = (unsigned long)current->mm->context.sigpage +
-			  (idx << 2) + thumb;
+		if (land == UNMAPPED_VDSO_BASE)
+			return 1;
+
+		retcode = land + (idx << 2) + thumb;
 	}
 
 	regs->regs[0]	= usig;
@@ -356,6 +359,8 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 	regs->compat_lr	= retcode;
 	regs->pc	= handler;
 	regs->pstate	= spsr;
+
+	return 0;
 }
 
 static int compat_setup_sigframe(struct compat_sigframe __user *sf,
@@ -425,7 +430,8 @@ int compat_setup_rt_frame(int usig, struct ksignal *ksig,
 	err |= compat_setup_sigframe(&frame->sig, regs, set);
 
 	if (err == 0) {
-		compat_setup_return(regs, &ksig->ka, frame->sig.retcode, frame, usig);
+		err = compat_setup_return(regs, &ksig->ka,
+					  frame->sig.retcode, frame, usig);
 		regs->regs[1] = (compat_ulong_t)(unsigned long)&frame->info;
 		regs->regs[2] = (compat_ulong_t)(unsigned long)&frame->sig.uc;
 	}
@@ -448,7 +454,8 @@ int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 
 	err |= compat_setup_sigframe(frame, regs, set);
 	if (err == 0)
-		compat_setup_return(regs, &ksig->ka, frame->retcode, frame, usig);
+		err = compat_setup_return(regs, &ksig->ka,
+					  frame->retcode, frame, usig);
 
 	return err;
 }
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 680415e0098c..3e9dd41abee0 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -264,14 +264,6 @@ enum aarch32_map {
 static struct page *aarch32_vectors_page __ro_after_init;
 static struct page *aarch32_sig_page __ro_after_init;
 
-static int aarch32_sigpage_mremap(const struct vm_special_mapping *sm,
-				  struct vm_area_struct *new_vma)
-{
-	current->mm->context.sigpage = (void *)new_vma->vm_start;
-
-	return 0;
-}
-
 static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_VECTORS] = {
 		.name	= "[vectors]", /* ABI */
@@ -280,7 +272,6 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	[AA32_MAP_SIGPAGE] = {
 		.name	= "[sigpage]", /* ABI */
 		.pages	= &aarch32_sig_page,
-		.mremap	= aarch32_sigpage_mremap,
 	},
 	[AA32_MAP_VVAR] = {
 		.name = "[vvar]",
@@ -398,7 +389,7 @@ static int aarch32_sigreturn_setup(struct mm_struct *mm)
 	if (IS_ERR(ret))
 		goto out;
 
-	mm->context.sigpage = (void *)addr;
+	mm->vdso_base = (void __user *)addr;
 
 out:
 	return PTR_ERR_OR_ZERO(ret);
-- 
2.31.1

