Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706F43A484F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbhFKSFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbhFKSFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA05C0613A3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:25 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so9178223wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NX8m1YUTA5OD8o59LIehw6knsVcTtkdCGgu8De/cJys=;
        b=UTT78y3vim01I8+bSVWTJH0l0ENXv3e6J3wdGywkRKbpnmgV2Td3BVUyIQiAYoDKte
         ENRqvcNxZuAsC8SKnDhTwbtoLomn6UJ2z/Vt9XQKfLNQF167YAldz9y4ym5qCKFGU9o2
         diS6TGEUFezJ7sXLiHCkc/m9bq92AaFGA4QYaSI+/zJ48h/e/fLjleBexQ1We7mlcEKg
         Z8ZTPJbYt9tVkyH00ayznNFq+EqSo2YeXXEmttC10FmZHs3svgtcTiDIEUcScIiFE7Zo
         T/QUTwTRwV+75+xGHj63um5icXKy+i8igHvumqCi0aNPizhcLyh4VF8Q6DcuKY1BhmCp
         yhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NX8m1YUTA5OD8o59LIehw6knsVcTtkdCGgu8De/cJys=;
        b=ZbjGblrXwpfxQiYx9+7XWzf5XtYPZBlFO9UuUO+7b/QAObNAHHFBrPCuh7tXaYw6Po
         dgkPmacgZHaqGIGFH05dLsemxA0SlqZBDlyBFpSwLNwWY3/4pV5vhQ+lREAvwjE11wyc
         +EOup5d2m2kpYpO/TYPyLNIOvZR0lmSLRxN+WqVNAgFwbIwp94vrrHrYZGgqQH+Jrtyx
         8su44/8zPdE8CVTya5GK6OTXj/Aj3HWyx9b0msmEFjdUaRnaXi5yBJR0/wmgKVweFAPa
         X57w1YkA1eGDC28gCjTQo3bYgXpo4W7JdLn7t3UWHM1hToXsVzlh1lMyBpBx6L+W1RfF
         Yd5Q==
X-Gm-Message-State: AOAM532C/gICHVvgyndik+U3mpEa4TaxEz//V2rTugBac/tGdPOlh2WQ
        6gKWsI8ckzvKRwRWgC1x9uqWBk3aIBHESMbx
X-Google-Smtp-Source: ABdhPJzdMs5R2cAVSYOVRHLk8DrU6cDDx50A/hJWz6rAFXrl2PGBcTlOrhMzfrZlG6f82N60RTxbsA==
X-Received: by 2002:a7b:c396:: with SMTP id s22mr5027928wmj.131.1623434603848;
        Fri, 11 Jun 2021 11:03:23 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:23 -0700 (PDT)
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
Subject: [PATCH v3 20/23] arm64/vdso: Migrate native signals to generic vdso_base
Date:   Fri, 11 Jun 2021 19:02:39 +0100
Message-Id: <20210611180242.711399-21-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the land vma area.
As a bonus, after unmapping vdso, kernel won't try to land on its
previous position (due to UNMAPPED_VDSO_BASE check instead of
context.vdso ?= 0 check).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/include/asm/mmu.h |  1 -
 arch/arm64/kernel/signal.c   | 10 +++++++---
 arch/arm64/kernel/vdso.c     | 15 ++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 434acd49dbc3..4432a2809e0d 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -19,7 +19,6 @@
 typedef struct {
 	atomic64_t	id;
 	refcount_t	pinned;
-	void		*vdso;
 	unsigned long	flags;
 } mm_context_t;
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 6237486ff6bb..5f6a8c0abc4c 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -723,9 +723,10 @@ static int get_sigframe(struct rt_sigframe_user_layout *user,
 	return 0;
 }
 
-static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
+static int setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			 struct rt_sigframe_user_layout *user, int usig)
 {
+	unsigned long land = (unsigned long)current->mm->vdso_base;
 	__sigrestore_t sigtramp;
 
 	regs->regs[0] = usig;
@@ -754,10 +755,13 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
+	else if (land != UNMAPPED_VDSO_BASE)
+		sigtramp = VDSO_SYMBOL(land, sigtramp);
 	else
-		sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
+		return 1;
 
 	regs->regs[30] = (unsigned long)sigtramp;
+	return 0;
 }
 
 static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
@@ -780,7 +784,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
 	err |= setup_sigframe(&user, regs, set);
 	if (err == 0) {
-		setup_return(regs, &ksig->ka, &user, usig);
+		err = setup_return(regs, &ksig->ka, &user, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
 			err |= copy_siginfo_to_user(&frame->info, &ksig->info);
 			regs->regs[1] = (unsigned long)&frame->info;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 3e9dd41abee0..4af29f89be37 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -78,12 +78,6 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
-static void vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	current->mm->context.vdso = (void *)new_vma->vm_start;
-}
-
 static int __init __vdso_init(enum vdso_abi abi)
 {
 	int i;
@@ -244,7 +238,12 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	if (IS_ERR(ret))
 		return PTR_ERR(ret);
 
-	mm->context.vdso = (void *)vdso_base;
+	/*
+	 * 32-bit ABI is to land on sigpage (see aarch32_sigreturn_setup()),
+	 * 64-bit on vDSO.
+	 */
+	if (abi == VDSO_ABI_AA64)
+		mm->vdso_base = (void __user *)vdso_base;
 	*sysinfo_ehdr = vdso_base;
 
 	return 0;
@@ -279,7 +278,6 @@ static struct vm_special_mapping aarch32_vdso_maps[] = {
 	},
 	[AA32_MAP_VDSO] = {
 		.name = "[vdso]",
-		.mremap = vdso_mremap,
 	},
 };
 
@@ -426,7 +424,6 @@ static struct vm_special_mapping aarch64_vdso_maps[] __ro_after_init = {
 	},
 	[AA64_MAP_VDSO] = {
 		.name	= "[vdso]",
-		.mremap = vdso_mremap,
 	},
 };
 
-- 
2.31.1

