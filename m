Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67234678C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhCWS0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbhCWSZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:25:32 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74229C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:32 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id s18so2686309pfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZLSbe0msUPGoJbO5z3RPkVHQZpnKpWfj8nNzVB1WJoM=;
        b=XGOV7o4gmjGI5erW92akFqPLGTXl3Og7bgkQxChThRnwJKoMamywmF0UDEpRXuBfqF
         ooMp2qwGHBybBKQO9DF/lsTfAAq97lCH3Dy8JYuSaJi0F4T8flh49k7ISuqYb9njVOSy
         dcu3j9MJLxRRwbC1vIprWy8ymy82ife+Q6PLDpg0mXRKPn1mkJPeCbKiT7w3RIttVw0m
         62Jh+6iT330dfgGTkDU4NjnDVfDA6PQ2QgFFsex6P7T6+ReU/UuaJHDWLT9mT5BiE1Bf
         pIT4kdQktf6sZ3FAl3V7lL6dLpHmFynMlB/d5yqJta62AabG8lp7nV3w5g2miG9DMM/n
         LW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZLSbe0msUPGoJbO5z3RPkVHQZpnKpWfj8nNzVB1WJoM=;
        b=LXz9RTNNuxt1JBx1NC9II96R4CH8HQXxbGasfCViXWyt7Domte2J0wYc5Ah81QLIYM
         BSDweuxXgIQIbc/ktwhBUgc72QSwp6g/PLxusNWOQSERZ+MurPGpaBvGhGw72tegSekn
         LBZnqUzWQCj06R5hNkhTZpLBMDxWXwsrR8vyc6JOGTZpbk8+1nbWNyY6LmZbFVLh/QCl
         BDPa/RlUTO3rKQR1mddImHAsE8Rm5IU80PBNzLJWs525Cgp2ARv87ANiabsHEQDQ76uA
         WkaFRozI2ToCINwR948aY0Tw8l5MrNGF0iIpDEXF8BoFd37l1XT3oJAA+wcwAdRaaicJ
         X/CQ==
X-Gm-Message-State: AOAM531LREZu963GYxCG2k5d61JQEYuWg35LV4yeITJjZUrveX5hUn1w
        eXhgpB4QW3f4zS1VhTCsfj8N32oG2pqB
X-Google-Smtp-Source: ABdhPJyjdDd3Dru52GbT0K29c5H12+F+r8WSy64N5iba6zTVrxc7m+fJNI6FZVL4+GCI04lFEiiP/Hy5bERc
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:b047:e98d:2134:b4dd])
 (user=bgeffon job=sendgmr) by 2002:aa7:80d1:0:b029:21d:d2ce:ad6 with SMTP id
 a17-20020aa780d10000b029021dd2ce0ad6mr1620778pfn.37.1616523931968; Tue, 23
 Mar 2021 11:25:31 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:25:17 -0700
In-Reply-To: <20210303175235.3308220-1-bgeffon@google.com>
Message-Id: <20210323182520.2712101-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v5 1/3] mm: Extend MREMAP_DONTUNMAP to non-anonymous mappings
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
2.31.0.291.g576ba9dcdaf-goog

