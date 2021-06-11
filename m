Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4623A485C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhFKSG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:06:27 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:44712 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbhFKSGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:06:04 -0400
Received: by mail-wr1-f44.google.com with SMTP id f2so6951379wri.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gNZwlNcg/qEzBSyTL6Wv2jCWb0gGSXBR1sJQHmlHgk=;
        b=gOSxto0fEAE0CNxgaVVyGo7TML0k8dxdI1VN7aQnbZiX7VOAgM/RV095J+LMEi5Djy
         c2vgoeYoqoVlki92qUzpTv28DHbf1bvdLACytRrao+z5ES0YTkZ23VErjee+EI1MWQSL
         fEGSi7pfhjlzVt5lyHBtJ9ZXIYFrwKuU9w03h1lEwSMcGnsZUTve2rT9DUAA/nQVj+Rj
         cEzg1PU0i+rgtJZTv/acFBsibyum+ur0NZHkjQsXuzhcG3fCydGSHkyum6+5ZKEpTJIL
         tMsGxmZ3mTVQCxPVw1tMKYK/S2CsfAhcR/HfKwhqZjL3pGQ0Iaqnl1tVj2j+0M4QFZLF
         SGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gNZwlNcg/qEzBSyTL6Wv2jCWb0gGSXBR1sJQHmlHgk=;
        b=JCbT+G3v9qv19trt1vVeifp3l1f/jT6KrKrq5bRNyTK5ZdHiPfiuWCYa4tsiLh9bJ8
         bMI3G8gQhPBXleWlbqe/L7wXuwMHDKPBSLK7a+gQ4x4cHkUiCSOiDdXjUVUFIVYJMqTk
         82aQG+/h+dK3V6g6ol4f5ez+kPa6JWm5YRfUv1u6lSOeGb2EWDi6PfO55E/Ou0nLo65u
         dVTgSEc2xMi8Paj3mDcxwKiaC5B9gJ9c9kfAXrelY5Ni1alJy7mmyqzNPKW2bUVVw1nc
         /6jDa2pC+AYXHOH0gg7XpyFAytZVpGRoBsiUSAbL+QQg25Nw20NveHfvGrqolppGiiX7
         J5rg==
X-Gm-Message-State: AOAM5312z9UHB2ANGX+NcFHW9RAVlDFYW9SE2nL8WljCNDbKwkjNCtfY
        TJ9TJ21bwdyXTHn/fpZRzCakYZXKIDOQTrA+
X-Google-Smtp-Source: ABdhPJyoVe09k6xUsonmoOGGagpmXhBKXLNAHAsz9B/OkEJcxn68yrKVmi8uPCtyYfs7nNKoUfCArg==
X-Received: by 2002:adf:ec02:: with SMTP id x2mr5509320wrn.156.1623434584983;
        Fri, 11 Jun 2021 11:03:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:04 -0700 (PDT)
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
Subject: [PATCH v3 10/23] arm/vdso: Remove vdso pointer from mm->context
Date:   Fri, 11 Jun 2021 19:02:29 +0100
Message-Id: <20210611180242.711399-11-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used any more: now sysinfo_ehdr is passed back from
arch_setup_additional_pages() to set AT_SYSINFO_EHDR tag.
.vdso_mremap() was only to track proper position of context.vdso
throughout any mremap() syscalls, remove it too.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/include/asm/mmu.h |  3 ---
 arch/arm/kernel/vdso.c     | 10 ----------
 2 files changed, 13 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 1592a4264488..2397b0a19f59 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -12,9 +12,6 @@ typedef struct {
 #endif
 	unsigned int	vmalloc_seq;
 	unsigned long	sigpage;
-#ifdef CONFIG_VDSO
-	unsigned long	vdso;
-#endif
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long	exec_fdpic_loadmap;
 	unsigned long	interp_fdpic_loadmap;
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index de516f8ba85a..4b39c7d8f525 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -47,17 +47,8 @@ static const struct vm_special_mapping vdso_data_mapping = {
 	.pages = &vdso_data_page,
 };
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	current->mm->context.vdso = new_vma->vm_start;
-
-	return 0;
-}
-
 static struct vm_special_mapping vdso_text_mapping __ro_after_init = {
 	.name = "[vdso]",
-	.mremap = vdso_mremap,
 };
 
 struct elfinfo {
@@ -256,7 +247,6 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
 	if (IS_ERR(vma))
 		return;
 
-	mm->context.vdso = addr;
 	*sysinfo_ehdr = addr;
 }
 
-- 
2.31.1

