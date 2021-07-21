Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18BE3D0F12
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhGUMJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 08:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbhGUMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 08:09:17 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA9FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 05:49:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso3352335wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 05:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fLe6r5M9YCsN+u9j0MHPR2O1k5FlFfghu7zbUgzRek=;
        b=M5i5gEYYLvatVUqGemPlfqrKkQvWg/u7TigfdeKlfJ51trQJB/YjovQd0wBcnPPlKo
         zy5e7xhnBqEOo58YPvm9dtPjSL8PRp/ybJcUh39yMm2TJl5789hJTnkOsJET8YHq0XFY
         mOb4JqQLiM4OrEaoj1+daqmrsZViJJEExSpyvrdo/iMSuipoXNoE6FfrMYPCCGpjKLUk
         x8xMhZOhjy9Mq1sWg8+jqhaX1E4luE3Qqapc+mkVPzI42TTVBGSm93cfM4mQbsALdK/t
         Zgyfjq+KkoGYBx3CLMaBwCuHKb0e82+8EnoFB1j96XzsuoO55Yg37qYrPQCYIA6Qiynm
         ri0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9fLe6r5M9YCsN+u9j0MHPR2O1k5FlFfghu7zbUgzRek=;
        b=Sg+JUY7XoaCDeQYBX/ci/vC5kuH5+Dwy6wsyFhE363HgxjsoMHEuTB6xYhub7p4XyX
         OwUO6yfNuYYfVSknZmb43ieE6RI64hiNn0c1zMhJIkg6uLZCFxr2zrq0j9FqUDemR+Ns
         jIBkt0P/TGYBPcXAquSgz7LY7uWQp6QYX4wzW8Cb5QO7fi643Xrk0WSp0so4wTiTNAk9
         g1GD+VZKoJwdSf9RYyuF+8tOT2YzI6M2aZLnzBn2MJNzrY8HwICSt2tJlAFIELu4H4mL
         zs4k3Kqna2q2NdpjJgyA3u3aUGayLoM3eHaE+abOlAtD0fGAF3aRPrwjptJyb+Z3W5Dt
         nm0g==
X-Gm-Message-State: AOAM53248WyifiUKpJ5T8GgxpTbOYmscNJ1toZ1lwIP0X1Cb7gu24xc/
        8+E/FaiXv0QH/lJ40LCXc7pBVrhHgjBtlA==
X-Google-Smtp-Source: ABdhPJwTOHOy75FOleI/71nywuUkIrbymlJorqU7Xd2glO+xTVz6X9SxxQ4rx9TZS53VSyr2/yk+yA==
X-Received: by 2002:a1c:1bc3:: with SMTP id b186mr3966568wmb.27.1626871792281;
        Wed, 21 Jul 2021 05:49:52 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id w9sm22667429wmc.19.2021.07.21.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 05:49:51 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH] mm/mremap: Don't account pages in vma_to_resize()
Date:   Wed, 21 Jul 2021 13:49:49 +0100
Message-Id: <20210721124949.517217-1-dima@arista.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All this vm_unacct_memory(charged) dance seems to complicate the life
without a good reason. Furthermore, it seems not always done right on
error-pathes in mremap_to().
And worse than that: this `charged' difference is sometimes
double-accounted for growing MREMAP_DONTUNMAP mremap()s in move_vma():
: if (security_vm_enough_memory_mm(mm, new_len >> PAGE_SHIFT))

Let's not do this.
Account memory in mremap() fast-path for growing VMAs or in move_vma()
for actually moving things.

Originally noticed by Chen Wandun:
https://lkml.kernel.org/r/20210717101942.120607-1-chenwandun@huawei.com

Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chen Wandun <chenwandun@huawei.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Ralph Campbell <rcampbell@nvidia.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Wei Yongjun <weiyongjun1@huawei.com>
Cc: Will Deacon <will@kernel.org>
Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 mm/mremap.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5989d3990020..ae48955aee74 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -708,8 +708,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 }
 
 static struct vm_area_struct *vma_to_resize(unsigned long addr,
-	unsigned long old_len, unsigned long new_len, unsigned long flags,
-	unsigned long *p)
+	unsigned long old_len, unsigned long new_len, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
@@ -768,13 +767,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 				(new_len - old_len) >> PAGE_SHIFT))
 		return ERR_PTR(-ENOMEM);
 
-	if (vma->vm_flags & VM_ACCOUNT) {
-		unsigned long charged = (new_len - old_len) >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return ERR_PTR(-ENOMEM);
-		*p = charged;
-	}
-
 	return vma;
 }
 
@@ -787,7 +779,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
-	unsigned long charged = 0;
 	unsigned long map_flags = 0;
 
 	if (offset_in_page(new_addr))
@@ -830,7 +821,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 		old_len = new_len;
 	}
 
-	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
+	vma = vma_to_resize(addr, old_len, new_len, flags);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
@@ -853,7 +844,7 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 				((addr - vma->vm_start) >> PAGE_SHIFT),
 				map_flags);
 	if (IS_ERR_VALUE(ret))
-		goto out1;
+		goto out;
 
 	/* We got a new mapping */
 	if (!(flags & MREMAP_FIXED))
@@ -862,12 +853,6 @@ static unsigned long mremap_to(unsigned long addr, unsigned long old_len,
 	ret = move_vma(vma, addr, old_len, new_len, new_addr, locked, flags, uf,
 		       uf_unmap);
 
-	if (!(offset_in_page(ret)))
-		goto out;
-
-out1:
-	vm_unacct_memory(charged);
-
 out:
 	return ret;
 }
@@ -899,7 +884,6 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long ret = -EINVAL;
-	unsigned long charged = 0;
 	bool locked = false;
 	bool downgraded = false;
 	struct vm_userfaultfd_ctx uf = NULL_VM_UFFD_CTX;
@@ -981,7 +965,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 	/*
 	 * Ok, we need to grow..
 	 */
-	vma = vma_to_resize(addr, old_len, new_len, flags, &charged);
+	vma = vma_to_resize(addr, old_len, new_len, flags);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
@@ -994,8 +978,16 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 		if (vma_expandable(vma, new_len - old_len)) {
 			int pages = (new_len - old_len) >> PAGE_SHIFT;
 
+			if (vma->vm_flags & VM_ACCOUNT) {
+				if (security_vm_enough_memory_mm(mm, pages)) {
+					ret = -ENOMEM;
+					goto out;
+				}
+			}
+
 			if (vma_adjust(vma, vma->vm_start, addr + new_len,
 				       vma->vm_pgoff, NULL)) {
+				vm_unacct_memory(pages);
 				ret = -ENOMEM;
 				goto out;
 			}
@@ -1034,10 +1026,8 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
 			       &locked, flags, &uf, &uf_unmap);
 	}
 out:
-	if (offset_in_page(ret)) {
-		vm_unacct_memory(charged);
+	if (offset_in_page(ret))
 		locked = false;
-	}
 	if (downgraded)
 		mmap_read_unlock(current->mm);
 	else
-- 
2.32.0

