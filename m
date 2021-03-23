Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D323434650E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:27:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhCWQ05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbhCWQ0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:26:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:19 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c1so2358038qke.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n6MgZRmjRkHGAKz5NOP9vxE91Mkgm+fsdWg3ns4pBws=;
        b=sh5yoDsFJETNBe8FClnjRA7HtDwQu/2+xa0OK9DvIZJzuEAskE0IqX6jSN1JnJUJHU
         iSIF71CO8jHw0/iO5gp76xvblL1xa0wgYP8d7R01aAzKjO4Tk+Hzzh2kXRpQh52/PecS
         La77iujaazzkcIEBfG8MBZtk8fWdnvypTrEyardClPL3a5BfrSMgRGci5h7BQwVgdBGG
         D+8bFfBX9y8XTvdi0LwgLkPrBBRzPZ/7KaWCdm5+KQgTwiLb6RAb9NyicLjxPXkDpnBD
         96LIyZVyy2xAIcaAEZoKMvTUIvSG6QCO1BoFI7a8bTE50vWvmrj1PxdLF5d93WYAEWW3
         K7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n6MgZRmjRkHGAKz5NOP9vxE91Mkgm+fsdWg3ns4pBws=;
        b=mZx+uk9iGRfXJiNUdAXd2L6y5dK3qRznMUq9ZrOjJKkhRG5TuvVWmJnXT+MDO2y0hu
         YFfdu8oRavbfpIjFgocM5EWKhA6vaQ62NQs9bZq/RmtQMvz/wzf/UdLxvfQZNyoxYWua
         o8pJZsXzU6pLavUMNtOgzH9bu0ky/nIcEKnPF4CsTAPCKAX2zQEoSUumCchLntfPtmZ3
         eYeY2S/5TlhGTDgIrR0fCSG9DHL4GeiF7UsRI0Skaa7n8Psli187eUnqTlIoqrIMgZEf
         4E7U2Sc6XiJSDWJYXJzy47uu7W7vgwyCf0Zz4oOaBRKQQK2qnsl+d56eQsyh0BEO1sVm
         lqsQ==
X-Gm-Message-State: AOAM5338zgG9VkUEUdjwTF1Zao1597pemRNwLA6orsAZlv3ObFbGrfXg
        EHjuTbLLbGeTmOevXPzGZmUVR+MTLaXS
X-Google-Smtp-Source: ABdhPJwg4rwIUdJnLCHIUMEMPabekLBtDNnkmH0fROuNNU4sOIPxMnlJGgrodI9f9mphy2R854xeGWRJxekc
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:b5cc:cacb:2875:ae6e])
 (user=bgeffon job=sendgmr) by 2002:ad4:57a5:: with SMTP id
 g5mr5599168qvx.60.1616516778194; Tue, 23 Mar 2021 09:26:18 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:26:08 -0700
In-Reply-To: <20210303175235.3308220-1-bgeffon@google.com>
Message-Id: <20210323162611.2398613-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v4 1/3] mm: Extend MREMAP_DONTUNMAP to non-anonymous mappings
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

Currently MREMAP_DONTUNMAP only accepts private anonymous mappings.
This restriction was placed initially for simplicity and not because
there exists a technical reason to do so.

This change will widen the support to include any mappings which are not
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
Acked-by: Hugh Dickins <hughd@google.com>
Tested-by: Lokesh Gidra <lokeshgidra@google.com>
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

