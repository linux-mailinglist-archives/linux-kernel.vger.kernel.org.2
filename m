Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6643A4853
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFKSFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 14:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhFKSF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 14:05:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C177C06124A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so9120776wmd.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 11:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3i998DGxR5JQUi1QNKogPGr4XjMtEWjoXVt+99m+GS0=;
        b=ZueUKXJJf0Fpw8kmzzO1H00RLU7Zel8GfRt+C0C9/M6arhxqGxGiJ/WsYmccqq0P0K
         E1x0Rg/jFmKw8NF09diwjZSJGIVt3ZShrP/fr0bsHNEGOmAg2V89ojF0tBh3vQANSn4E
         DMkB2kO/CRHulRSUEkHIXIw773Pc2ayMBeHdrH6e4NnF7HxZcq3xDa9L9nZlCKw9P2Dh
         cZ6fzQIsMLQqsV9ceKuOIFttcYx0L8hlDNyoqgLLE3CXNM+6Jjeys7WR5gmmB1XNEygB
         z4DzuGJnIN7Hs5EhvAsdNNZgz/WEkmP6MIQAym2O8AGCO6jKp5crTn/s9/0ESsQlWZjk
         9uVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3i998DGxR5JQUi1QNKogPGr4XjMtEWjoXVt+99m+GS0=;
        b=MZMg9EzC9MHzoNuL40GOhKNvrUjfXeTOVfKznfneadDV6PMWIykzlr7bP0Y/Nj2roT
         8GnOvzSFd1mCrv5XVRPBOOxxpsAqcW8DzoH8o64lTX77ZDJfZ/mxDCVLL61PXL8y6zJB
         8SRrp8MhvgCTJ7ehOx6Rm/n3zw6GODGoSXDmqn+gMjxg0Qp88ju0c3gxE3bGCOFeTQKs
         cxjieIsRx/ByCDnamhtm04CQPvzXQvsW2dGhcj1rAPmbtiKhcaHcB808+QyRU6wS06eY
         1BpcrCuELrxVp8SHbnpsjxjAHbvHoudk/AVb15D7qdU0r5SZCsc1kjStqQHWk5NdpOgt
         hqhg==
X-Gm-Message-State: AOAM530l+R7TVlvOPIUsy9ahySi9a6XfUWyh1U6m3VkbFMfcuMsx+ixy
        wvCXIjLGfktHHrPQQMDngdLWGa6/WlDvNp//
X-Google-Smtp-Source: ABdhPJzptyN+ihVekDcrG0+IoUXPwMDtiR10aH23x6UALNp8tbMTvJloRkPlD4JH52isjtc+86At0Q==
X-Received: by 2002:a1c:4606:: with SMTP id t6mr5119194wma.122.1623434589970;
        Fri, 11 Jun 2021 11:03:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:09 -0700 (PDT)
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
Subject: [PATCH v3 13/23] mm/mmap: Make vm_special_mapping::mremap return void
Date:   Fri, 11 Jun 2021 19:02:32 +0100
Message-Id: <20210611180242.711399-14-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously .mremap() callback had to return (int) to provide
a way to restrict resizing of a special mapping. Now it's
restricted by providing .may_split = special_mapping_split.

Removing (int) return simplifies further changes to
special_mapping_mremap() as it won't need save ret code from the
callback. Also, it removes needless `return 0` from callbacks.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/process.c | 3 +--
 arch/arm64/kernel/vdso.c  | 4 +---
 arch/mips/vdso/genvdso.c  | 3 +--
 arch/x86/entry/vdso/vma.c | 4 +---
 include/linux/mm_types.h  | 4 ++--
 mm/mmap.c                 | 2 +-
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 5897ccb88bca..b863c5525b5d 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -387,11 +387,10 @@ static unsigned long sigpage_addr(const struct mm_struct *mm,
 static struct page *signal_page;
 extern struct page *get_signal_page(void);
 
-static int sigpage_mremap(const struct vm_special_mapping *sm,
+static void sigpage_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	current->mm->context.sigpage = new_vma->vm_start;
-	return 0;
 }
 
 static const struct vm_special_mapping sigpage_mapping = {
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index c0512c2e8183..680415e0098c 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -78,12 +78,10 @@ static union {
 } vdso_data_store __page_aligned_data;
 struct vdso_data *vdso_data = vdso_data_store.data;
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
+static void vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	current->mm->context.vdso = (void *)new_vma->vm_start;
-
-	return 0;
 }
 
 static int __init __vdso_init(enum vdso_abi abi)
diff --git a/arch/mips/vdso/genvdso.c b/arch/mips/vdso/genvdso.c
index 09e30eb4be86..0303d30cde03 100644
--- a/arch/mips/vdso/genvdso.c
+++ b/arch/mips/vdso/genvdso.c
@@ -259,13 +259,12 @@ int main(int argc, char **argv)
 	fprintf(out_file, "#include <linux/linkage.h>\n");
 	fprintf(out_file, "#include <linux/mm.h>\n");
 	fprintf(out_file, "#include <asm/vdso.h>\n");
-	fprintf(out_file, "static int vdso_mremap(\n");
+	fprintf(out_file, "static void vdso_mremap(\n");
 	fprintf(out_file, "	const struct vm_special_mapping *sm,\n");
 	fprintf(out_file, "	struct vm_area_struct *new_vma)\n");
 	fprintf(out_file, "{\n");
 	fprintf(out_file, "	current->mm->context.vdso =\n");
 	fprintf(out_file, "	(void *)(new_vma->vm_start);\n");
-	fprintf(out_file, "	return 0;\n");
 	fprintf(out_file, "}\n");
 
 	/* Write out the stripped VDSO data. */
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index f1abe43aadb9..a286d44751be 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -86,15 +86,13 @@ static void vdso_fix_landing(const struct vdso_image *image,
 #endif
 }
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
+static void vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
 	const struct vdso_image *image = current->mm->context.vdso_image;
 
 	vdso_fix_landing(image, new_vma);
 	current->mm->context.vdso = (void __user *)new_vma->vm_start;
-
-	return 0;
 }
 
 #ifdef CONFIG_TIME_NS
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 5aacc1c10a45..e9c5f2051f08 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -770,8 +770,8 @@ struct vm_special_mapping {
 				struct vm_area_struct *vma,
 				struct vm_fault *vmf);
 
-	int (*mremap)(const struct vm_special_mapping *sm,
-		     struct vm_area_struct *new_vma);
+	void (*mremap)(const struct vm_special_mapping *sm,
+		       struct vm_area_struct *new_vma);
 };
 
 enum tlb_flush_reason {
diff --git a/mm/mmap.c b/mm/mmap.c
index 0584e540246e..4f0d62409b1c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3401,7 +3401,7 @@ static int special_mapping_mremap(struct vm_area_struct *new_vma)
 		return -EFAULT;
 
 	if (sm->mremap)
-		return sm->mremap(sm, new_vma);
+		sm->mremap(sm, new_vma);
 
 	return 0;
 }
-- 
2.31.1

