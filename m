Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D894D3A4854
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhFKSFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhFKSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:33 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76806C0617AF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c9so6954812wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vAYTm9g45y/0YoEPHLWHk693b44k5gXdnp3b7Fu6a04=;
        b=SsGwv/WT1hXQ2dTKSetGHC+Ujltp9eWMKp2LBdeWGMopkAp7u9BGGrVDhYYWvQbQ+O
         UmZbNwlsmXxj3YNrPFQEJW6t9nmKxZRgu4JsVcS9eIO0nmzQuijLN80Fnsg9oJrSXuvg
         pSh1kPyV7DmMbw8GITlJa+Mo+07wMrpLmemJS6yvmuO8/Ymy1uIUwvuGOV/G5ijAUVNQ
         UNOlM0h+NqqzlRvQ/aS8CvfwiQgbjD3Lwv3wCam3jdpLsfg+YV6o6nCajBSXiTPM9b2+
         +mvCV0FGE/O1eKUoHPYs2V2m+dtiRef8miGua5RPa3O4Ioe+nOietJ3BlZ2p4R1tiwci
         XRNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vAYTm9g45y/0YoEPHLWHk693b44k5gXdnp3b7Fu6a04=;
        b=mu7rSwN9/S02Uhf/k6qa/tCi/OcpR1zwYk2rVOBOpJ3buz58p+HJBDUCQr1HducqpQ
         u1JiSAFVhVKq08+thvmVred1y6PrhemdfEMclZXUGyb15ES4LVf6tmue9Q2GFn5l4LkM
         0l6LaTsTCH2+Su4GinzhrZ+JNwyqSnuqzaU4bkFUDTluQ00mXFFgSwFv6kg686COsF8b
         T6bGJd0qOLeehErmv/fJtFLtiHzpyhQuo40OaM2FD3jad1/uJmN9tZTl26Kli3BGkdYb
         znAaplna3oC722g4TfTqfpWSqPopFQEzniTyazH1BnnJ9NZ7O+F0KER8T0Zilv1EiCe0
         uDrQ==
X-Gm-Message-State: AOAM531cx3m5iRKn/FymHxMFgNcVK2EYDoLpL4qIVebU0Znva/C4U9j7
        PuWscmDp0CNar/X46JB8Rd+w0rN63a6gud5Z
X-Google-Smtp-Source: ABdhPJz5wu8NlXVBMr1yjdBL/5z1c/3WnDv1VVhVrAMBRZ8f/b1R0A6zv/s/l5bsp8I2nZIh8U6jDA==
X-Received: by 2002:a5d:5243:: with SMTP id k3mr5420505wrc.19.1623434599178;
        Fri, 11 Jun 2021 11:03:19 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:18 -0700 (PDT)
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
Subject: [PATCH v3 18/23] arm/vdso: Migrate to generic vdso_base
Date:   Fri, 11 Jun 2021 19:02:37 +0100
Message-Id: <20210611180242.711399-19-dima@arista.com>
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
 arch/arm/Kconfig          | 1 +
 arch/arm/kernel/process.c | 9 +--------
 arch/arm/kernel/signal.c  | 6 +++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2df5ad505b8b..edf1cbb908a9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,6 +23,7 @@ config ARM
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VDSO_BASE
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if CPU_V7 || CPU_V7M || CPU_V6K
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index b863c5525b5d..3a5975d1ace6 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -387,16 +387,9 @@ static unsigned long sigpage_addr(const struct mm_struct *mm,
 static struct page *signal_page;
 extern struct page *get_signal_page(void);
 
-static void sigpage_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	current->mm->context.sigpage = new_vma->vm_start;
-}
-
 static const struct vm_special_mapping sigpage_mapping = {
 	.name = "[sigpage]",
 	.pages = &signal_page,
-	.mremap = sigpage_mremap,
 };
 
 int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
@@ -434,7 +427,7 @@ int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 		goto up_fail;
 	}
 
-	mm->context.sigpage = addr;
+	mm->vdso_base = (void __user *)addr;
 
 	/* Unlike the sigpage, failure to install the vdso is unlikely
 	 * to be fatal to the process, so no error check needed
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index a3a38d0a4c85..6c0507e84e24 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -451,13 +451,17 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 #ifdef CONFIG_MMU
 		if (cpsr & MODE32_BIT) {
 			struct mm_struct *mm = current->mm;
+			unsigned long land = (unsigned long)mm->vdso_base;
+
+			if (land == UNMAPPED_VDSO_BASE)
+				return 1;
 
 			/*
 			 * 32-bit code can use the signal return page
 			 * except when the MPU has protected the vectors
 			 * page from PL0
 			 */
-			retcode = mm->context.sigpage + signal_return_offset +
+			retcode = land + signal_return_offset +
 				  (idx << 2) + thumb;
 		} else
 #endif
-- 
2.31.1

