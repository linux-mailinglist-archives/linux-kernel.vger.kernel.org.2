Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D403144FF92
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbhKOIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:00:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28565 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230418AbhKOH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:59:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962987;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQTAYR2U0B9NQT5q5Dh9pQHL0/MM7Qz5TQPJEv+v98g=;
        b=fVQDpNllnVkoHborceNRRJenMuUzKbgvBCOs6/U4tHY1Q+TvgtSNWFAwY9bZuNleRzD7xF
        XZRksP++zhsXvbxv+fAGvenzoXgoOHGvTgjj5ttYCfyC9CqW//IHr0tKlTGvuqaPI9S0Mx
        6e3bWeCD8xITUyGP8xcPHp18oXhvqXM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-hNMXCEovP02jqIykmRYpLQ-1; Mon, 15 Nov 2021 02:56:25 -0500
X-MC-Unique: hNMXCEovP02jqIykmRYpLQ-1
Received: by mail-pj1-f69.google.com with SMTP id o4-20020a17090a3d4400b001a66f10df6cso4880344pjf.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQTAYR2U0B9NQT5q5Dh9pQHL0/MM7Qz5TQPJEv+v98g=;
        b=VsxkS/1+KjRQbru9RazNMclgGJfxO9xS1y6PmTOXSmKh2MhCgCIxi7LRTj6T5Wfy2U
         A8XvBUTugZYMKyzRwM2b+Q3pVtF5sO+IqJzr0ZnFZLTOSbBDfRA2lZ8J3yO6vXLZrsMs
         IZbDNwAl3ojnmyryAmlLy5QKIP4ILIwvW8FkBr6EVV/z9Gw+lsFt9Dswwi1GuGtcXNS6
         zJGseyZBBNhYTr7VW9LeBfqwy/dyv8AxkZhISecPKBz34v2vips3sRqjbvyr23reH1h8
         S6XT3H82i4GvRvGLrOB1BmqHhQ2tTeQJc2FXgdCdBxhMD9qFGaXxwdphZIsJnADJyEZs
         2WoA==
X-Gm-Message-State: AOAM531yIC/s1rUImfHFU0+T7947erAODDHMGrC4ml0Z0gaupA74uCtR
        RDBAeidVSOIGu2WCLYNAMcxy0Gsw17FyBWxWv1Fhhg2GAbx/WNBuokxMwutw3SatbKzLHgMgCp3
        RVxB54PA/4fmjptHJp1VhMjcY
X-Received: by 2002:a17:90a:ca81:: with SMTP id y1mr61191340pjt.231.1636962984418;
        Sun, 14 Nov 2021 23:56:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQVZcj01aFlbyqYO4BSw1DS5ur5lPKwB1eRxjFMR30tJL7G2a+EjobAshXx0ZYvcchxwbzZQ==
X-Received: by 2002:a17:90a:ca81:: with SMTP id y1mr61191302pjt.231.1636962984128;
        Sun, 14 Nov 2021 23:56:24 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.56.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:56:23 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v6 06/23] mm/shmem: Handle uffd-wp special pte in page fault handler
Date:   Mon, 15 Nov 2021 15:55:05 +0800
Message-Id: <20211115075522.73795-7-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

File-backed memories are prone to unmap/swap so the ptes are always unstable,
because they can be easily faulted back later using the page cache.  This could
lead to uffd-wp getting lost when unmapping or swapping out such memory.  One
example is shmem.  PTE markers are needed to store those information.

This patch prepares it by handling uffd-wp pte markers first it is applied
elsewhere, so that the page fault handler can recognize uffd-wp pte markers.

The handling of uffd-wp pte markers is similar to missing fault, it's just that
we'll handle this "missing fault" when we see the pte markers, meanwhile we
need to make sure the marker information is kept during processing the fault.

This is a slow path of uffd-wp handling, because zapping of wr-protected shmem
ptes should be rare.  So far it should only trigger in two conditions:

  (1) When trying to punch holes in shmem_fallocate(), there is an optimization
      to zap the pgtables before evicting the page.

  (2) When swapping out shmem pages.

Because of this, the page fault handling is simplifed too by not sending the
wr-protect message in the 1st page fault, instead the page will be installed
read-only, so the uffd-wp message will be generated in the next fault, which
will trigger the do_wp_page() path of general uffd-wp handling.

Disable fault-around for all uffd-wp registered ranges for extra safety just
like uffd-minor fault, and clean the code up.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/userfaultfd_k.h | 17 +++++++++
 mm/memory.c                   | 71 ++++++++++++++++++++++++++++++-----
 2 files changed, 79 insertions(+), 9 deletions(-)

diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 7d7ffec53ddb..05cec02140cb 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -96,6 +96,18 @@ static inline bool uffd_disable_huge_pmd_share(struct vm_area_struct *vma)
 	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
 }
 
+/*
+ * Don't do fault around for either WP or MINOR registered uffd range.  For
+ * MINOR registered range, fault around will be a total disaster and ptes can
+ * be installed without notifications; for WP it should mostly be fine as long
+ * as the fault around checks for pte_none() before the installation, however
+ * to be super safe we just forbid it.
+ */
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return vma->vm_flags & (VM_UFFD_WP | VM_UFFD_MINOR);
+}
+
 static inline bool userfaultfd_missing(struct vm_area_struct *vma)
 {
 	return vma->vm_flags & VM_UFFD_MISSING;
@@ -236,6 +248,11 @@ static inline void userfaultfd_unmap_complete(struct mm_struct *mm,
 {
 }
 
+static inline bool uffd_disable_fault_around(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 #endif /* CONFIG_USERFAULTFD */
 
 static inline bool is_pte_marker_uffd_wp(pte_t pte)
diff --git a/mm/memory.c b/mm/memory.c
index d5966d9e24c3..e8557d43a87d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3452,6 +3452,43 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	return 0;
 }
 
+static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
+{
+	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
+				       vmf->address, &vmf->ptl);
+	/*
+	 * Be careful so that we will only recover a special uffd-wp pte into a
+	 * none pte.  Otherwise it means the pte could have changed, so retry.
+	 */
+	if (is_pte_marker(*vmf->pte))
+		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
+	pte_unmap_unlock(vmf->pte, vmf->ptl);
+	return 0;
+}
+
+/*
+ * This is actually a page-missing access, but with uffd-wp special pte
+ * installed.  It means this pte was wr-protected before being unmapped.
+ */
+static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
+{
+	/* Careful!  vmf->pte unmapped after return */
+	if (!pte_unmap_same(vmf))
+		return 0;
+
+	/*
+	 * Just in case there're leftover special ptes even after the region
+	 * got unregistered - we can simply clear them.  We can also do that
+	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
+	 * ranges, but it should be more efficient to be done lazily here.
+	 */
+	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
+		return pte_marker_clear(vmf);
+
+	/* do_fault() can handle pte markers too like none pte */
+	return do_fault(vmf);
+}
+
 static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 {
 	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
@@ -3465,8 +3502,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
 	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
 		return VM_FAULT_SIGBUS;
 
-	/* TODO: handle pte markers */
-	return 0;
+	if (marker & PTE_MARKER_UFFD_WP)
+		return pte_marker_handle_uffd_wp(vmf);
+
+	/* This is an unknown pte marker */
+	return VM_FAULT_SIGBUS;
 }
 
 /*
@@ -3968,6 +4008,7 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
 void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool uffd_wp = is_pte_marker_uffd_wp(vmf->orig_pte);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
 	bool prefault = vmf->address != addr;
 	pte_t entry;
@@ -3982,6 +4023,8 @@ void do_set_pte(struct vm_fault *vmf, struct page *page, unsigned long addr)
 
 	if (write)
 		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
+	if (unlikely(uffd_wp))
+		entry = pte_mkuffd_wp(pte_wrprotect(entry));
 	/* copy-on-write page */
 	if (write && !(vma->vm_flags & VM_SHARED)) {
 		inc_mm_counter_fast(vma->vm_mm, MM_ANONPAGES);
@@ -4155,9 +4198,21 @@ static vm_fault_t do_fault_around(struct vm_fault *vmf)
 	return vmf->vma->vm_ops->map_pages(vmf, start_pgoff, end_pgoff);
 }
 
+/* Return true if we should do read fault-around, false otherwise */
+static inline bool should_fault_around(struct vm_fault *vmf)
+{
+	/* No ->map_pages?  No way to fault around... */
+	if (!vmf->vma->vm_ops->map_pages)
+		return false;
+
+	if (uffd_disable_fault_around(vmf->vma))
+		return false;
+
+	return fault_around_bytes >> PAGE_SHIFT > 1;
+}
+
 static vm_fault_t do_read_fault(struct vm_fault *vmf)
 {
-	struct vm_area_struct *vma = vmf->vma;
 	vm_fault_t ret = 0;
 
 	/*
@@ -4165,12 +4220,10 @@ static vm_fault_t do_read_fault(struct vm_fault *vmf)
 	 * if page by the offset is not ready to be mapped (cold cache or
 	 * something).
 	 */
-	if (vma->vm_ops->map_pages && fault_around_bytes >> PAGE_SHIFT > 1) {
-		if (likely(!userfaultfd_minor(vmf->vma))) {
-			ret = do_fault_around(vmf);
-			if (ret)
-				return ret;
-		}
+	if (should_fault_around(vmf)) {
+		ret = do_fault_around(vmf);
+		if (ret)
+			return ret;
 	}
 
 	ret = __do_fault(vmf);
-- 
2.32.0

