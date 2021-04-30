Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0927370243
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbhD3UjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhD3Ui6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:38:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8269DC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:09 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m5so11725219wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEq0/bKuKyVdL1JH6Xf7qoLNGy26OvZqXWZScmfZsZ4=;
        b=I0VCihY9/Yzgm/gCe6zh6hq4ak+g7rW7WwWNXOZLJwv3HS3q0LwY+uzRRU+GDnGnwU
         Dfsr9wtVZZqei7Pm45e5k9igK9KbjtsJIspFn5T2ktkjRepnnfZdQQvZArGDh+5HKQXD
         kuly2T25iQN1F5yHFGu+RFM4tsnKPROSuc5VZin4RzNXdLdRHBSTDl3kDDoHwugOuAPi
         0+Y+wzZ5IEnYgFL+Ymzo8OXo+u8oHws3UDy33mRUJgyRLI+MaQkhlrqeeDJM5u1NjXNK
         UXlJLLFUnEW4jprVbwuej2R6LJd5nimX1Eui0/9A1XVCVB+6q/kmhmk6P8pB/etduWRJ
         WDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEq0/bKuKyVdL1JH6Xf7qoLNGy26OvZqXWZScmfZsZ4=;
        b=WiccS/xqaR1kNulSgk1PNB8qNmQHaP6i38MMrL7Q09diALpO1ZD1km3yUwmKb2e5vi
         0NDbzfNsR6nugF0Qfms+A998PskcPGg+9YRHE5qNzASKXNLxaB0FDG83W9FUMYv9Kfvx
         D+Vi2ZSa5/PbeeKlSMwcFKgAXCjpvLfhHmCLj1ufAPRuQKPd5blASyC1LaBIY0AaTg8X
         8c0vKMewl5DXRTymEb8uZQbfETqxDl6iJdhgbkxdL/+GZ37Xpy2dQQDsduumtOCQqQ6R
         u0ktS7tZy5w7cAOmdZ3JC1WfCZRSkkZpR5y+zjqaPFD4wR71o9OrmTAURtlPZ/oRudeM
         lDNA==
X-Gm-Message-State: AOAM533Ejfua+aPlh/LlltR98JnnrmcEnT0r5oFgYilpxTU9lGoTeAzz
        zHA6QL2H3J/oj8Z+pfcamZU=
X-Google-Smtp-Source: ABdhPJwpWgPw/hEcwnrnkgZN1FYmu83wrXI+9Z4H4NQtFJEKT9jTEWCNqWFNvppzg+i5y9ogbxbJHg==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr18616237wmi.86.1619815088327;
        Fri, 30 Apr 2021 13:38:08 -0700 (PDT)
Received: from amanieu-desktop.home ([2a00:23c6:f081:f801:93ef:94e:9f8:1f0])
        by smtp.gmail.com with ESMTPSA id r5sm4384239wmh.23.2021.04.30.13.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:38:08 -0700 (PDT)
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
Subject: [PATCH v4 2/8] hugetlbfs: Use arch_get_mmap_* macros
Date:   Fri, 30 Apr 2021 21:37:51 +0100
Message-Id: <20210430203757.47653-1-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210430202810.44092-1-amanieu@gmail.com>
References: <20210430202810.44092-1-amanieu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb_get_unmapped_area should obey the same arch-specific constraints
as mmap when selecting an address.

Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
Co-developed-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
Signed-off-by: Ryan Houdek <Houdek.Ryan@fex-emu.org>
---
 fs/hugetlbfs/inode.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 701c82c36138..526ccb524329 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -191,6 +191,18 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
  */
 
 #ifndef HAVE_ARCH_HUGETLB_UNMAPPED_AREA
+#ifndef arch_get_mmap_end
+#define arch_get_mmap_end(addr)			(TASK_SIZE)
+#endif
+
+#ifndef arch_get_mmap_base
+#define arch_get_mmap_base(addr)		(current->mm->mmap_base)
+#endif
+
+#ifndef arch_get_mmap_base_topdown
+#define arch_get_mmap_base_topdown(addr)	(current->mm->mmap_base)
+#endif
+
 static unsigned long
 hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
@@ -200,8 +212,8 @@ hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
 
 	info.flags = 0;
 	info.length = len;
-	info.low_limit = current->mm->mmap_base;
-	info.high_limit = TASK_SIZE;
+	info.low_limit = arch_get_mmap_base(addr);
+	info.high_limit = arch_get_mmap_end(addr);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
 	return vm_unmapped_area(&info);
@@ -217,7 +229,7 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
-	info.high_limit = current->mm->mmap_base;
+	info.high_limit = arch_get_mmap_base_topdown(addr);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
@@ -231,8 +243,8 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 	if (unlikely(offset_in_page(addr))) {
 		VM_BUG_ON(addr != -ENOMEM);
 		info.flags = 0;
-		info.low_limit = current->mm->mmap_base;
-		info.high_limit = TASK_SIZE;
+		info.low_limit = arch_get_mmap_base(addr);
+		info.high_limit = arch_get_mmap_end(addr);
 		addr = vm_unmapped_area(&info);
 	}
 
-- 
2.31.1

