Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAA83874BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbhERJJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347855AbhERJI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:08:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C48C061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f19-20020a05600c1553b02901794fafcfefso430247wmg.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 02:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DEq0/bKuKyVdL1JH6Xf7qoLNGy26OvZqXWZScmfZsZ4=;
        b=YXX3VRZhOsfkB4tqu4Q6tAruc141WxgNYT2vTPahITkoBVW62BQbI/sBbFkSqseuNC
         mhbNcHMeCuLCBI+BiUFrst6wUM5jKxPuY8C8rgZPqXRiDptgfsiJcKEK5lzgkfWq4ciG
         5o4kXqCM3YDFxvy4g6lHD4PG5hwsK9baR2Eo2C6jL7D/oSRm1/VSxks0nAEuNwAsAbPR
         YmiKvgRJK4ZFprotrlEM+uXJxVpewBXcVsCX0MvgzEIx0/Y+G7KEweH6FbNsMCCkwntb
         8+vvaCFdK1xbWXWC6Hlz71OwNNETAee3JejQ6tL9+YqsQB/JqPPb5lhQUI69AJ1YNLxD
         0P3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEq0/bKuKyVdL1JH6Xf7qoLNGy26OvZqXWZScmfZsZ4=;
        b=MlFvcOWmXsXX8jWO3efhz3io2kLkohOGqU2nsrEZ/nJmWl6oRBywu/4t9x66F3/wjy
         heMu4IFk8P96f8aKo0c6DrkTpfQ1Svq3hei0vmuCU/4Q08iUbmn4HhasLYVo3qNqkV+z
         y7sxIBzfC75sDw2x6zeh5UUNVOhit+008i+mRAfZ+8huoEQsj5k5GEc6Oqpidoxb62Cz
         xnq1B8agnH+DXr6nEsRXxV+Lz/nKb3c0I8oTxGHh6YUtqkY951PdAZcJ1911yFKTDx4i
         Eb8HL+u+ekgjEP5m1FNSFDa9+yVUQnWQ44YvdVaHxRc35epy6MIug+fMGAnVjrmNCW5T
         qr5Q==
X-Gm-Message-State: AOAM531JcrS2E+rrG0OWI2MMrw68Xn1WzicpuT5lQAPtfnxlAk7kOGJQ
        lKUduOOWH80h3X3ef7sX1v8=
X-Google-Smtp-Source: ABdhPJypDI4jFTUNpyCBGcVWEB+Qc4Mg9AKECPAD92Z3ZLvuiLmU/GmFHaNdYqqF00Froa1hujNP4w==
X-Received: by 2002:a1c:dd08:: with SMTP id u8mr3757709wmg.62.1621328828723;
        Tue, 18 May 2021 02:07:08 -0700 (PDT)
Received: from amanieu-laptop.home ([2a00:23c6:f081:f801:91cf:b949:c46c:f5a9])
        by smtp.gmail.com with ESMTPSA id z17sm7520306wrt.81.2021.05.18.02.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 02:07:08 -0700 (PDT)
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
Subject: [RESEND PATCH v4 2/8] hugetlbfs: Use arch_get_mmap_* macros
Date:   Tue, 18 May 2021 10:06:52 +0100
Message-Id: <20210518090658.9519-3-amanieu@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210518090658.9519-1-amanieu@gmail.com>
References: <20210518090658.9519-1-amanieu@gmail.com>
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

