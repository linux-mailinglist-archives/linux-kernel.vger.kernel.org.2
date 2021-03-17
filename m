Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6B333FA8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 22:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhCQVl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 17:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhCQVlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 17:41:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C2DC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:41:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j4so46002754ybt.23
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 14:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6JKBBoz8CQGNb7LdFHQu8eZZo9mpl/jAnB6fSdRHbgM=;
        b=TVFJl/Bz+n9V0z7OP99iR4mlt7aH5gkCLB0f5sibPPJF64t0iU47HjkYgm9BRwwIS7
         oW7WYz8lWfu/urEkfdhsFqyqXbAo6PCTzLxinfBAuJ6ciBbFgyPLFY0fQ5jvv8KbLng6
         4QomHgwzG4CRgQenSNg85//32OdBi2aoO09fwIT2HLgtkhxzp/WWBKjz+mbfwfWVGwZB
         7/i8O7zLqSKH04aDXTcyUq7HinalLh0vqCliDXbE5PDUaMMu+NOCh+csdLEWB6wqYnJW
         uj2i9n54E4/Hvqkk8pcuMNLXxsO6luRxA/+QL0bOysGkvb9zdSMIWXXBqzv7nbM5F3wW
         fSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6JKBBoz8CQGNb7LdFHQu8eZZo9mpl/jAnB6fSdRHbgM=;
        b=Gyz/a+hywNAsSWAXWYm54f7KidRQZVjzOvLfJULa70t//OUCpfYLGSFpaAjDZkPXZO
         vX5Q6QXq3ZyEDV9r82+3jUZ/TaYwYjuObOiLfA+rWSz2YWveMaPzCMecy5t+xhDyKtLq
         Js430h23+qI6j/gt8BuPafjbc/IMMkamkHoyk9+yHscYflKEg7MsMfbVWJ2uyAdbstVf
         BzAPBsb5G33EJaHydbZM+xsAF4epP16tBMzA5Z97yUplDfRCHyJvTDRTCDYVOcVukpDP
         RrhIxu/kLiqizOWS/G1rIfqxqMcp5Hy16IS+522KM/+bz8ZUeAUwMIF4w4YO2KabgBNz
         G0Hw==
X-Gm-Message-State: AOAM532nEHmfzaxhQpe6Q4Kz7emYUwskg49N7T3oEAPWfRiy/rw3E2Hl
        aiixxPQFo0I8lYupRjGjr1ivAoQ2kztD
X-Google-Smtp-Source: ABdhPJyWVCh6V0a73bmY964YJglCxN05PngE4FP3YYnZ6KhzjGe1g6OQoBJkIVakX9cR7RD8uwys7JxEyw8C
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:8c6a:2e6f:ed81:d930])
 (user=bgeffon job=sendgmr) by 2002:a25:a561:: with SMTP id
 h88mr7030922ybi.235.1616017310240; Wed, 17 Mar 2021 14:41:50 -0700 (PDT)
Date:   Wed, 17 Mar 2021 14:41:46 -0700
In-Reply-To: <20210303175235.3308220-1-bgeffon@google.com>
Message-Id: <20210317214147.682687-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v3 1/2] mm: Allow non-VM_DONTEXPAND and VM_PFNMAP mappings
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

This change will result in mremap(MREMAP_DONTUNMAP) returning -EINVAL
if VM_DONTEXPAND or VM_PFNMAP mappings are specified.

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
 mm/mremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ec8f840399ed..db5b8b28c2dd 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -653,8 +653,8 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
-			vma->vm_flags & VM_SHARED))
+	if ((flags & MREMAP_DONTUNMAP) &&
+			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return ERR_PTR(-EINVAL);
 
 	if (is_vm_hugetlb_page(vma))
-- 
2.31.0.rc2.261.g7f71774620-goog

