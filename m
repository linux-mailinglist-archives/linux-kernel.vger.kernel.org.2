Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0558D32C139
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837049AbhCCSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577891AbhCCSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 13:01:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C8DC061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 09:53:03 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id f81so27484887yba.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 09:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=eQ1N4syBqhEslbSb0mdNs2OlZNLITnu4bJ8FJAo60h4=;
        b=OLQjJT0J9gD2SzMgodm1GHn6v88aUuM7RgUuzmOJG3tKUlRF4p/HNeovouVQxPrtDQ
         W3cfRVvYPVJf0PUgUTTg9KacNDQGjtV0t41hSbwQbAvjBMnZuTFT0x9eS3UEQXMttKn5
         ltADl2+jM89/kQclQtWNkvS4ijrLyucXx0nZ0G4250rFdxWhgpLFaNyjqkIjosUfi07f
         sxRA7jMw0Py89UrFDAZ05uf6A7fvoblcOv74/leSiKt2Rn7WthMRqXMWZxSbJNoxNPsb
         Yyw+KEashPMBUEdqc6pmvhLyZ6GOk4foNIMP/6DrXY9D1XhFPoR0Yi1Y+cwIFFGlZmbv
         8CCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=eQ1N4syBqhEslbSb0mdNs2OlZNLITnu4bJ8FJAo60h4=;
        b=ftN6T9+3V49KrrYy70HXWxnheaqheQ+z0DtPw9Pp04N2mtFs4FgfLAyFZt28zYcqdF
         d2fvMn142n3QpSbWN7J06uCH1pWjOpl5NZQBbEl8PVI3ALvyVXv4DdBiPLbrG3YQcOou
         dbNeiMrjo6DAPTJzH5zopXaQHEgXs+clhbO83CasKy5O3ecY4g4V75RX6u6amKma0zFy
         cS/yTRqBKyjDzh0AjKjRMy3d4Z9Oa+6fdNTlw8S8D9h0FNoXt8KxOshY7qPMmH+r3aux
         C2bMYE17RHtWlOyFkR0w2Zk7uUspfgkVk3wjr9L3Xlr/sUhgoPgZrQAOn/97HKkS05TL
         LrLA==
X-Gm-Message-State: AOAM5313rNkAwQlerRNJ3nXMSfpf8WMf+TuS5+ilOdD1HMGnlsd4A+a5
        1dbHNY9Qod6bMn1uUoru2/o2B3GiBpbD
X-Google-Smtp-Source: ABdhPJwnyqDHV+MfT760BeCIxgKo4yidtHHzI6Ce9X1wfCm1ty1jRfE6ZB+qqj7wRE676p0RC6J7UICzudl5
Sender: "bgeffon via sendgmr" <bgeffon@bg.sfo.corp.google.com>
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:60ab:b78:20ae:fc05])
 (user=bgeffon job=sendgmr) by 2002:a25:e795:: with SMTP id
 e143mr523308ybh.509.1614793981739; Wed, 03 Mar 2021 09:53:01 -0800 (PST)
Date:   Wed,  3 Mar 2021 09:52:35 -0800
Message-Id: <20210303175235.3308220-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.rc0.254.gbdcc3b1a9d-goog
Subject: [PATCH] mm: Allow shmem mappings with MREMAP_DONTUNMAP
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
        "Kirill A . Shutemov" <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently MREMAP_DONTUNMAP only accepts private anonymous mappings. This change
will widen the support to include shmem mappings. The primary use case
is to support MREMAP_DONTUNMAP on mappings which may have been created from
a memfd.

Lokesh Gidra who works on the Android JVM, provided an explanation of how such
a feature will improve Android JVM garbage collection:
"Android is developing a new garbage collector (GC), based on userfaultfd. The
garbage collector will use userfaultfd (uffd) on the java heap during compaction.
On accessing any uncompacted page, the application threads will find it missing,
at which point the thread will create the compacted page and then use UFFDIO_COPY
ioctl to get it mapped and then resume execution. Before starting this compaction,
in a stop-the-world pause the heap will be mremap(MREMAP_DONTUNMAP) so that the
java heap is ready to receive UFFD_EVENT_PAGEFAULT events after resuming execution.

To speedup mremap operations, pagetable movement was optimized by moving PUD entries
instead of PTE entries [1]. It was necessary as mremap of even modest sized memory
ranges also took several milliseconds, and stopping the application for that long
isn't acceptable in response-time sensitive cases. With UFFDIO_CONTINUE feature [2],
it will be even more efficient to implement this GC, particularly the 'non-moveable'
portions of the heap. It will also help in reducing the need to copy (UFFDIO_COPY)
the pages. However, for this to work, the java heap has to be on a 'shared' vma.
Currently MREMAP_DONTUNMAP only supports private anonymous mappings, this patch will
enable using UFFDIO_CONTINUE for the new userfaultfd-based heap compaction."

[1] https://lore.kernel.org/linux-mm/20201215030730.NC3CU98e4%25akpm@linux-foundation.org/
[2] https://lore.kernel.org/linux-mm/20210302000133.272579-1-axelrasmussen@google.com/
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index ec8f840399ed..6934d199da54 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -653,8 +653,7 @@ static struct vm_area_struct *vma_to_resize(unsigned long addr,
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (flags & MREMAP_DONTUNMAP && (!vma_is_anonymous(vma) ||
-			vma->vm_flags & VM_SHARED))
+	if (flags & MREMAP_DONTUNMAP && !(vma_is_anonymous(vma) || vma_is_shmem(vma)))
 		return ERR_PTR(-EINVAL);
 
 	if (is_vm_hugetlb_page(vma))
-- 
2.31.0.rc0.254.gbdcc3b1a9d-goog

