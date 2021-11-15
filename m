Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14F0F44FF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 08:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhKOH7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 02:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230056AbhKOH6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 02:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636962955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XNTxE1iM+okUx3tL+hKy8xQDAnTI8ZhKWAdYtMcr0FQ=;
        b=edGwuEOGQzGDeoPSwiSGYBEbIQ2qqlPLmLX4Ramx8ywiNOf+BEChBIq2KsiPJIvecId4qe
        dSgWobAAEvldWvY3BjAmm/Q/hH9wNX4fOhxd3rRv16rpDOs5usgTMcXfxjF+gPvFedKdNK
        R3D2XTYasRTdpsZgjon9izsdIgwEx5U=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-9ySDSCMoPneVaKjkS_N-nw-1; Mon, 15 Nov 2021 02:55:54 -0500
X-MC-Unique: 9ySDSCMoPneVaKjkS_N-nw-1
Received: by mail-pg1-f198.google.com with SMTP id s8-20020a63af48000000b002e6c10ac245so1396008pgo.21
        for <linux-kernel@vger.kernel.org>; Sun, 14 Nov 2021 23:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XNTxE1iM+okUx3tL+hKy8xQDAnTI8ZhKWAdYtMcr0FQ=;
        b=G3yr6m7DTiyn2vSJWdyYr+p1z7Ir5UVwUsF2TQnxl/dNAwsN5nlGpRFXKb2WxwS3MM
         1+X2GN1WIR/uqd+oSHh6ycK2ONSwd+cQhy5EQVceZqRd72iIZRCXzy3cqTv6K3T+yFhN
         6cbVDqn5ub8QtI9mOs2Zg8ab0hD3gM4YMRPkPDgngxX/FnH5jjCDiDMmr/cBMLZAjB+L
         Yn0aK1Uiqxql5UPd9C5h5KtGtPRb26xHB1PVWsMdePSejIJ57lFjlpbv8IImMTlJpqjc
         J5TquTJtzgu07oa9cfttWZHItS4uJNPk4umU3TlJkFYubNFo5aeUQ2CBjAismQVZOJGg
         6F0g==
X-Gm-Message-State: AOAM533JUgwlLcyqoC4O75zg4rhRZFlqK5jquR5W/83aOCkVdcDNnm3G
        yV+vXWrfN/95FZFBaNczprqyiII7e9hluN+KVX6Erjq4/NhUoE1i+2VvbvhRPn8PLQBwJoaX1D8
        C1w7TdTeEDv4vUO7LOclbdnLF
X-Received: by 2002:a17:902:d703:b0:140:125b:40a5 with SMTP id w3-20020a170902d70300b00140125b40a5mr33288596ply.65.1636962953205;
        Sun, 14 Nov 2021 23:55:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzr2k4IPsVPsWDOJS1pWtswgYrOd6P3YKvfA/vFCF6qlLE/nRrQuC+VisMGWkBR++WhCEY/sw==
X-Received: by 2002:a17:902:d703:b0:140:125b:40a5 with SMTP id w3-20020a170902d70300b00140125b40a5mr33288572ply.65.1636962952914;
        Sun, 14 Nov 2021 23:55:52 -0800 (PST)
Received: from localhost.localdomain ([191.101.132.223])
        by smtp.gmail.com with ESMTPSA id e10sm15792796pfv.140.2021.11.14.23.55.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:55:52 -0800 (PST)
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
Subject: [PATCH v6 02/23] mm: Teach core mm about pte markers
Date:   Mon, 15 Nov 2021 15:55:01 +0800
Message-Id: <20211115075522.73795-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch still does not use pte marker in any way, however it teaches the
core mm about the pte marker idea.

For example, handle_pte_marker() is introduced that will parse and handle all
the pte marker faults.

Many of the places are more about commenting it up - so that we know there's
the possibility of pte marker showing up, and why we don't need special code
for the cases.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 fs/userfaultfd.c | 10 ++++++----
 mm/filemap.c     |  5 +++++
 mm/hmm.c         |  2 +-
 mm/memcontrol.c  |  8 ++++++--
 mm/memory.c      | 23 +++++++++++++++++++++++
 mm/mincore.c     |  3 ++-
 mm/mprotect.c    |  3 +++
 7 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 22bf14ab2d16..fa24c72a849e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -245,9 +245,10 @@ static inline bool userfaultfd_huge_must_wait(struct userfaultfd_ctx *ctx,
 
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.
+	 * changes under us.  PTE markers should be handled the same as none
+	 * ptes here.
 	 */
-	if (huge_pte_none(pte))
+	if (huge_pte_none_mostly(pte))
 		ret = true;
 	if (!huge_pte_write(pte) && (reason & VM_UFFD_WP))
 		ret = true;
@@ -326,9 +327,10 @@ static inline bool userfaultfd_must_wait(struct userfaultfd_ctx *ctx,
 	pte = pte_offset_map(pmd, address);
 	/*
 	 * Lockless access: we're in a wait_event so it's ok if it
-	 * changes under us.
+	 * changes under us.  PTE markers should be handled the same as none
+	 * ptes here.
 	 */
-	if (pte_none(*pte))
+	if (pte_none_mostly(*pte))
 		ret = true;
 	if (!pte_write(*pte) && (reason & VM_UFFD_WP))
 		ret = true;
diff --git a/mm/filemap.c b/mm/filemap.c
index daa0e23a6ee6..9a7228b95b30 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3327,6 +3327,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;
 
+		/*
+		 * NOTE: If there're PTE markers, we'll leave them to be
+		 * handled in the specific fault path, and it'll prohibit the
+		 * fault-around logic.
+		 */
 		if (!pte_none(*vmf->pte))
 			goto unlock;
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 842e26599238..a0f72a540dc3 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -239,7 +239,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	pte_t pte = *ptep;
 	uint64_t pfn_req_flags = *hmm_pfn;
 
-	if (pte_none(pte)) {
+	if (pte_none_mostly(pte)) {
 		required_fault =
 			hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, 0);
 		if (required_fault)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 781605e92015..eaddbc77aa5a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5692,10 +5692,14 @@ static enum mc_target_type get_mctgt_type(struct vm_area_struct *vma,
 
 	if (pte_present(ptent))
 		page = mc_handle_present_pte(vma, addr, ptent);
+	else if (pte_none_mostly(ptent))
+		/*
+		 * PTE markers should be treated as a none pte here, separated
+		 * from other swap handling below.
+		 */
+		page = mc_handle_file_pte(vma, addr, ptent);
 	else if (is_swap_pte(ptent))
 		page = mc_handle_swap_pte(vma, ptent, &ent);
-	else if (pte_none(ptent))
-		page = mc_handle_file_pte(vma, addr, ptent);
 
 	if (!page && !ent.val)
 		return ret;
diff --git a/mm/memory.c b/mm/memory.c
index e5d59a6b6479..04662b010005 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -98,6 +98,8 @@ struct page *mem_map;
 EXPORT_SYMBOL(mem_map);
 #endif
 
+static vm_fault_t do_fault(struct vm_fault *vmf);
+
 /*
  * A number of key systems in x86 including ioremap() rely on the assumption
  * that high_memory defines the upper bound on direct map memory, then end
@@ -1380,6 +1382,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
 			if (unlikely(zap_skip_check_mapping(details, page)))
 				continue;
 			rss[mm_counter(page)]--;
+		} else if (is_pte_marker_entry(entry)) {
+			/* By default, simply drop all pte markers when zap */
 		} else if (!non_swap_entry(entry)) {
 			rss[MM_SWAPENTS]--;
 			if (unlikely(!free_swap_and_cache(entry)))
@@ -3448,6 +3452,23 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
 	return 0;
 }
 
+static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
+{
+	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
+	unsigned long marker = pte_marker_get(entry);
+
+	/*
+	 * PTE markers should always be with file-backed memories, and the
+	 * marker should never be empty.  If anything weird happened, the best
+	 * thing to do is to kill the process along with its mm.
+	 */
+	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
+		return VM_FAULT_SIGBUS;
+
+	/* TODO: handle pte markers */
+	return 0;
+}
+
 /*
  * We enter with non-exclusive mmap_lock (to exclude vma changes,
  * but allow concurrent faults), and pte mapped but not yet locked.
@@ -3484,6 +3505,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			ret = vmf->page->pgmap->ops->migrate_to_ram(vmf);
 		} else if (is_hwpoison_entry(entry)) {
 			ret = VM_FAULT_HWPOISON;
+		} else if (is_pte_marker_entry(entry)) {
+			ret = handle_pte_marker(vmf);
 		} else {
 			print_bad_pte(vma, vmf->address, vmf->orig_pte, NULL);
 			ret = VM_FAULT_SIGBUS;
diff --git a/mm/mincore.c b/mm/mincore.c
index 9122676b54d6..736869f4b409 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -121,7 +121,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 	for (; addr != end; ptep++, addr += PAGE_SIZE) {
 		pte_t pte = *ptep;
 
-		if (pte_none(pte))
+		/* We need to do cache lookup too for pte markers */
+		if (pte_none_mostly(pte))
 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
 						 vma, vec);
 		else if (pte_present(pte))
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e552f5e0ccbd..890bc1f9ca24 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -173,6 +173,9 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 					newpte = pte_swp_mksoft_dirty(newpte);
 				if (pte_swp_uffd_wp(oldpte))
 					newpte = pte_swp_mkuffd_wp(newpte);
+			} else if (is_pte_marker_entry(entry)) {
+				/* Skip it, the same as none pte */
+				continue;
 			} else {
 				newpte = oldpte;
 			}
-- 
2.32.0

