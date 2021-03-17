Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836F633FA8D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbhCQVmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhCQVlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:41:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D4BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:41:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 127so46093524ybc.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PE76OhS7gOhisfnYJ34BsUCZhRzyUT9agI71FqfBCUQ=;
        b=Kddr/UUoa+woTOsBjRGakKyox6pozzIhXdt3RnHLuXmSDuUfQSgFuVdknVN533ca87
         sDtghIkKoA3a5oDDpEQSnXDFML8r8/+kvqi7gfwqRsrDClpBBJaLPWUm3uzcAF5Ygsqg
         Wr0Q7glWMar1BLgExphmB0ty7JZ86ny9Hda9QaX4hyVhE/cbC9uTQq1M3XrpkZ1LBqHq
         gNgSYUg5xCJeoqXYhXuA3VYeCL5BsAFIsC3+6FcwvK1198CDnMfx6cPxFqIIim992vtB
         jy2dr4q+kXSxZzGb5+Xd0lDum8mPtghFG0nO/7ACV0tl+fsb7QzU6wJAlI/aBdij1p0J
         2Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PE76OhS7gOhisfnYJ34BsUCZhRzyUT9agI71FqfBCUQ=;
        b=P1YKx6OC83l2hiOTi7cs+Q6TSa58ZkV6BGdUdF2mmZgG6AE8ckqsEi+tU0jZMm/UEi
         LLfBoVs2bKBk53P8Iq4cv7I/jOXzYZ0mOax0uNDQ6oHoqevIy3uShBgFSnbyFug7l+xD
         7KZkelltJKyccAzs9O4XxOLUQb7rxVINXPuzeHon8DJTLr+WPDSi1YhMOFKvqridIfQd
         KVFC7+gCgbcFg1H5/5IIti8U2MvSVtKGrEaPzM2hpEsukqn6B0pwe/V9B3iAIqe2uG3Z
         C/jjGlDAACsXTZDXXZ6jxSVfJaMKCE/2ptPAs3qRKRdzSY63G7fFWHukpSARNcNzYJd7
         ZsKw==
X-Gm-Message-State: AOAM530sK76pst3HYPV5ITu+gzn+ue6o75d18STS6nQp1AoQzGP5KdP3
        CMtdZ9SxKVatYpuqzbwlPXdPLk4KyHI7
X-Google-Smtp-Source: ABdhPJyBuc4RzSE6YsLPIioC7HoYjlEa6rLlvNPBwi6c0E0CrnwV5mtzkXtzfpc5FobREa6yi1FZ9SZ6h/54
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:8c6a:2e6f:ed81:d930])
 (user=bgeffon job=sendgmr) by 2002:a25:ca13:: with SMTP id
 a19mr6217553ybg.446.1616017312057; Wed, 17 Mar 2021 14:41:52 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:41:47 -0700
In-Reply-To: <20210317214147.682687-1-bgeffon@google.com>
Message-Id: <20210317214147.682687-2-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210317214147.682687-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v3 2/2] Revert "mremap: don't allow MREMAP_DONTUNMAP on
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
        Dmitry Safonov <dima@arista.com>
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
check of !VM_DONTEXPAND and !VM_PFNMAP which will result in a -EFAULT.

1. https://lkml.org/lkml/2020/12/28/2340

Signed-off-by: Brian Geffon <bgeffon@google.com>
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
index 77e64e3eac80..8c3729eb3e38 100644
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
2.31.0.rc2.261.g7f71774620-goog

