Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8EC734678D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbhCWS0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbhCWSZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:25:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A536EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j19so3473551ybg.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dY7WA+UEN40ndqtDO7RREDL5/0nyCAvFJ0UPO+eomVs=;
        b=r7X+QE2kE7/WKXlDrA2RA+qriBrJ7O7/Zbw4BWQohT1QckYfsCiullXxdtvOjPSjx2
         /QsVEx5udz4PpuhSdakuaUkaQM6DluYT1W36ElHFZKXD3pITIt7fZknCC9jo69V93JIj
         ObiRX3d2bjEJKgnarX73B6RfhLchUBboImOsICYHDyE1/orAix04zLT5he4TnE+au1Cw
         kObbIgB76AqOPTjBMa9vLEjK/sK4le2D0vppwlAAb4w0p/eBwZCqGBOStZLx92mdNaBH
         b9e4pDgWEH+m1BMGDkgKxIycG/f4Zt77bsgAn5oh+fPeQUMjYYYgMAIIx5fiZBPqzgiq
         4UIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dY7WA+UEN40ndqtDO7RREDL5/0nyCAvFJ0UPO+eomVs=;
        b=mfbjglRtU0Lk7bZxohXUJPLoXvHWSGdAA9+rfNk0GXQgGRUH5q4OLpWb5R2R9P5DeJ
         3L5eVUaWafIvz/tL2jvBugLSGT7ghiNdeFd+jv0BAhcnrDJcFRcez2sRmzanTMleDRlY
         bPkLsZEob4Hbk1jdD8Jnto4/iSmeYRNhziLhtgkfywJrEnnZfxJEqJFT7lKj3UFZXqTA
         cAbsrYo/nkrX7lmDnvu6YllqX1+XERQJOYr0jiLOkNMVfxboFVcRyP8usccS2i0bXRMO
         V1/RkWOUJSQvMRXrDuwpznA3rrc6+YhuUci/ps4qwYXOCBq/0pyrL5TyoBuTDVsqFB5x
         n6RQ==
X-Gm-Message-State: AOAM530cR9efFqNF/8NHPJCZcBbTAQv9wCsF7WD9HBFCtnK5UA+3+qde
        JPv45UQ7IZ8mqMEqM4BnknaNeez/2KUg
X-Google-Smtp-Source: ABdhPJy8jbCMWhdnWSi7dX5ifnQwWGCqzH8htG0mfRL0hzsDMRzqT9Ury8PnrGWjrz/VHIAXw+TaGgoArHJZ
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:b047:e98d:2134:b4dd])
 (user=bgeffon job=sendgmr) by 2002:a25:ae9f:: with SMTP id
 b31mr7241564ybj.160.1616523933889; Tue, 23 Mar 2021 11:25:33 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:25:18 -0700
In-Reply-To: <20210323182520.2712101-1-bgeffon@google.com>
Message-Id: <20210323182520.2712101-2-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323182520.2712101-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v5 2/3] Revert "mremap: don't allow MREMAP_DONTUNMAP on
 special_mappings and aio"
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit cd544fd1dc9293c6702fab6effa63dac1cc67e99.

As discussed in [1] this commit was a no-op because the mapping type was
checked in vma_to_resize before move_vma is ever called. This meant that
vm_ops->mremap() would never be called on such mappings. Furthermore,
we've since expanded support of MREMAP_DONTUNMAP to non-anonymous
mappings, and these special mappings are still protected by the existing
check of !VM_DONTEXPAND and !VM_PFNMAP which will result in a -EINVAL.

1. https://lkml.org/lkml/2020/12/28/2340

Signed-off-by: Brian Geffon <bgeffon@google.com>
Acked-by: Hugh Dickins <hughd@google.com>
---
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 2 +-
 fs/aio.c                                  | 5 +----
 include/linux/mm.h                        | 2 +-
 mm/mmap.c                                 | 6 +-----
 mm/mremap.c                               | 2 +-
 5 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index e916646adc69..0daf2f1cf7a8 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1458,7 +1458,7 @@ static int pseudo_lock_dev_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int pseudo_lock_dev_mremap(struct vm_area_struct *area, unsigned long flags)
+static int pseudo_lock_dev_mremap(struct vm_area_struct *area)
 {
 	/* Not supported */
 	return -EINVAL;
diff --git a/fs/aio.c b/fs/aio.c
index 1f32da13d39e..76ce0cc3ee4e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -323,16 +323,13 @@ static void aio_free_ring(struct kioctx *ctx)
 	}
 }
 
-static int aio_ring_mremap(struct vm_area_struct *vma, unsigned long flags)
+static int aio_ring_mremap(struct vm_area_struct *vma)
 {
 	struct file *file = vma->vm_file;
 	struct mm_struct *mm = vma->vm_mm;
 	struct kioctx_table *table;
 	int i, res = -EINVAL;
 
-	if (flags & MREMAP_DONTUNMAP)
-		return -EINVAL;
-
 	spin_lock(&mm->ioctx_lock);
 	rcu_read_lock();
 	table = rcu_dereference(mm->ioctx_table);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 64a71bf20536..ecdc6e8dc5af 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -570,7 +570,7 @@ struct vm_operations_struct {
 	void (*close)(struct vm_area_struct * area);
 	/* Called any time before splitting to check if it's allowed */
 	int (*may_split)(struct vm_area_struct *area, unsigned long addr);
-	int (*mremap)(struct vm_area_struct *area, unsigned long flags);
+	int (*mremap)(struct vm_area_struct *area);
 	/*
 	 * Called by mprotect() to make driver-specific permission
 	 * checks before mprotect() is finalised.   The VMA must not
diff --git a/mm/mmap.c b/mm/mmap.c
index 3f287599a7a3..9d7651e4e1fe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3403,14 +3403,10 @@ static const char *special_mapping_name(struct vm_area_struct *vma)
 	return ((struct vm_special_mapping *)vma->vm_private_data)->name;
 }
 
-static int special_mapping_mremap(struct vm_area_struct *new_vma,
-				  unsigned long flags)
+static int special_mapping_mremap(struct vm_area_struct *new_vma)
 {
 	struct vm_special_mapping *sm = new_vma->vm_private_data;
 
-	if (flags & MREMAP_DONTUNMAP)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(current->mm != new_vma->vm_mm))
 		return -EFAULT;
 
diff --git a/mm/mremap.c b/mm/mremap.c
index db5b8b28c2dd..d22629ff8f3c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -545,7 +545,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (moved_len < old_len) {
 		err = -ENOMEM;
 	} else if (vma->vm_ops && vma->vm_ops->mremap) {
-		err = vma->vm_ops->mremap(new_vma, flags);
+		err = vma->vm_ops->mremap(new_vma);
 	}
 
 	if (unlikely(err)) {
-- 
2.31.0.291.g576ba9dcdaf-goog

