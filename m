Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B733F8E5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 20:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhCQTOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 15:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhCQTNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 15:13:39 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBFFC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:13:38 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j19so39530ybg.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PMNTWEhfV6poxu3dvNBZ0UMNzT+uf6rEFOoHyvBSs4w=;
        b=NBYx9GkOp4RmsEoqQW1OUbK6Af2HZ+LSsowzg92soxTJILyt1ru0deBVCL4L1rv72R
         wNa5pP6KVc+qd2CwbKXOZPKQEI5zMGrWD+mA1YusfzJytS77RqUnsDx9WMaXglXnSDsx
         xcd2uhqLhA6g2U3Be8s572z9gjYEj4t6QyB64QOJBwwaAxcaOlwmWCgcmFXeyWI7RdPI
         Q+No5H0JfUdzubH73uOJNzHeifUE3NpHJ30yDQGj5uju9XNlysiYgOqPdje5/Cm3hLdd
         rEpgaya2cvWiZjPyi8MhqBCZ/UYMItUgSfbsDoIIhwe8WCOjDXAiGWa76x4x5bG8dZCo
         vLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PMNTWEhfV6poxu3dvNBZ0UMNzT+uf6rEFOoHyvBSs4w=;
        b=k3qca8Hw9+YCDB3It7I7XGPU2WJW/6cDRgtDYRmTHuWzlIcSyN9X2pYxcWbb3yQE9y
         Av5jcuxGGCEZPSgRqUR7gRvbd+nffz/rjII4x8RXM1xAuS0Az0VcB1Q/QzRarfq8MF7M
         vtpgCoEFQsmQ6fvWoAFHwIOYjn9qLup2IEHZPRNDC9dPPgCbtwzqYD/tUetbwgX4Wy1q
         rtfEykBUIL6APdEeWtGr7/ZUGGCdyeKfNzp9QL1bVmpHRbqkjvUdoOuv7H18tL5nyioa
         Ofs0CsZ1f8bq/T6FXXy9H/LvooTalm8rsOBwJF9afjUyHGHQs+a0Sj1E3ymK2rJl7jON
         2Wiw==
X-Gm-Message-State: AOAM532zJE5Dd6pXkqBW+xqEPl6gsYiHCA79dgJyoi5zcyZUyY4AfcUJ
        c3HQk1iAhMOM4XbX2zDZkzn8w+yBFadR
X-Google-Smtp-Source: ABdhPJxEU/NDufnze3h7G0LVZg2aYOx4qJg+j9BSn1s+iC2EzMHJDDyEnwUZx76eo1cN/PimKfC47lJ2IHEe
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:8c6a:2e6f:ed81:d930])
 (user=bgeffon job=sendgmr) by 2002:a25:d155:: with SMTP id
 i82mr6299882ybg.404.1616008417952; Wed, 17 Mar 2021 12:13:37 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:13:33 -0700
In-Reply-To: <20210303175235.3308220-1-bgeffon@google.com>
Message-Id: <20210317191334.564944-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v2 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP mappings
 with MREMAP_DONTUNMAP
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

Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This
change will widen the support to include any mappings which are not
VM_DONTEXPAND or VM_PFNMAP. The primary use case is to support
MREMAP_DONTUNMAP on mappings which may have been created from a memfd.

This change which takes advantage of the existing check in vma_to_resize
for non-VM_DONTEXPAND and non-VM_PFNMAP mappings will cause
MREMAP_DONTUNMAP to return -EFAULT if such mappings are remapped. This
behavior is consistent with existing behavior when using mremap with
such mappings.

Lokesh Gidra who works on the Android JVM, provided an explanation of how
such a feature will improve Android JVM garbage collection:
"Android is developing a new garbage collector (GC), based on userfaultfd.
The garbage collector will use userfaultfd (uffd) on the java heap during
compaction. On accessing any uncompacted page, the application threads will
find it missing, at which point the thread will create the compacted page
and then use UFFDIO_COPY ioctl to get it mapped and then resume execution.
Before starting this compaction, in a stop-the-world pause the heap will be
mremap(MREMAP_DONTUNMAP) so that the java heap is ready to receive
UFFD_EVENT_PAGEFAULT events after resuming execution.

To speedup mremap operations, pagetable movement was optimized by moving
PUD entries instead of PTE entries [1]. It was necessary as mremap of even
modest sized memory ranges also took several milliseconds, and stopping the
application for that long isn't acceptable in response-time sensitive
cases.

With UFFDIO_CONTINUE feature [2], it will be even more efficient to
implement this GC, particularly the 'non-moveable' portions of the heap.
It will also help in reducing the need to copy (UFFDIO_COPY) the pages.
However, for this to work, the java heap has to be on a 'shared' vma.
Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this
patch will enable using UFFDIO_CONTINUE for the new userfaultfd-based heap
compaction."

[1] https://lore.kernel.org/linux-mm/20201215030730.NC3CU98e4%25akpm@linux-foundation.org/
[2] https://lore.kernel.org/linux-mm/20210302000133.272579-1-axelrasmussen@google.com/

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 mm/mremap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ec8f840399ed..2c57dc4bc8b6 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -653,10 +653,6 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
-			vma->vm_flags & VM_SHARED))
-		return ERR_PTR(-EINVAL);
-
 	if (is_vm_hugetlb_page(vma))
 		return ERR_PTR(-EINVAL);
 
-- 
2.31.0.rc2.261.g7f71774620-goog

