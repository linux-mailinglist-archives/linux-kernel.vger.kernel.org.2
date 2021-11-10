Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CA044BF3A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 11:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhKJK6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 05:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhKJK6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 05:58:47 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F40CC061764
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:56:00 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id p17so1933377pgj.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 02:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oACp49gXaGAjKIiwkR+ZeBWqiQkGBkUqqKqI3adW4JI=;
        b=mYFTL8nAGfoCHW+ltxTYZYlXDGFJnMrF2VCPBAxylGRD2oFy5grbsGypUkK/thKoL5
         +HDEBjxveBsreY4/QAXWNNN3NCUjVtlIu+dXA+sEVew8eBN/NOAYKTD8bjGwoAg4DT8P
         nA266BKFpGTAEUchN6jo4bbemK6xw1SgSz2wcj6mmPJTV26W1ZLUbJaHy4pY4MRTLkeP
         PkEhNjCiFFyj9cs63AMuh07LHAzL6EP1KxHwQ1DFzPXqQpKGj9BFHTcFbR/9G4aFjL09
         ssmWBBRktXlg+M4KvdgY2ZD6i03sO0ej9Ly0sv9VqbPWsh2Hu1JFwr7baM2VV55tG4qT
         SffQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oACp49gXaGAjKIiwkR+ZeBWqiQkGBkUqqKqI3adW4JI=;
        b=ZI1ETw+qviUotfYNOrPKbgiwVjWYqYTu8C8lQ/h0Gd7Z8d0+mOuliSG2Tq2KwR4Gm6
         nPjPWqh2PxR2uqXw07sODR2c0JJSf1l3R1m19VHlyyv2hW21Yy3v46ljrlr7NGF1XXPb
         FBOj/3Yq+n5CpRkZMa4Y1IMqQFpC67mDMYUYI9/MWS0mOgEHPskGJk6zsq3vThwYlwfT
         HNx2eCyJoRtVz5hpQlJojAhP6E4Qg1YBfHDg6Yz/EBClZZXb4RKQVKSQ3sZ7LrB2C9yd
         kDzq555fyalfpjYcMm/1RaUeIGAdvoJAbOS4MJOeCNy07kUzZ1btN4Lb/il0QJ/v3vuy
         YKtw==
X-Gm-Message-State: AOAM530ydHHzZe2j3DTWq61AQmaNU/2zlucMNcaJ05BlNhQUHyjU369/
        oMtAZaLsDMcL/as1I1wJWed4KA==
X-Google-Smtp-Source: ABdhPJxsiLB9lgCGapZu/Cp89rN/P3dimmlX2wiU05T9FeDDXf/uTbUmrVDMvDWMjGH9ivQ2d5gBsg==
X-Received: by 2002:a63:8048:: with SMTP id j69mr11183988pgd.111.1636541759762;
        Wed, 10 Nov 2021 02:55:59 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5865829pgl.38.2021.11.10.02.55.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 02:55:59 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 14/15] Documentation: add document for pte_ref
Date:   Wed, 10 Nov 2021 18:54:27 +0800
Message-Id: <20211110105428.32458-15-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
References: <20211110105428.32458-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds document for pte_ref under `Documentation/vm/`.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 Documentation/vm/pte_ref.rst | 212 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100644 Documentation/vm/pte_ref.rst

diff --git a/Documentation/vm/pte_ref.rst b/Documentation/vm/pte_ref.rst
new file mode 100644
index 000000000000..c5323a263464
--- /dev/null
+++ b/Documentation/vm/pte_ref.rst
@@ -0,0 +1,212 @@
+.. _pte_ref:
+
+============================================================================
+pte_ref: Tracking about how many references to each user PTE page table page
+============================================================================
+
+.. contents:: :local:
+
+1. Preface
+==========
+
+Now in order to pursue high performance, applications mostly use some
+high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
+These memory allocators use ``madvise(MADV_DONTNEED or MADV_FREE)`` to release
+physical memory for the following reasons::
+
+ First of all, we should hold as few write locks of mmap_lock as possible,since
+ the mmap_lock semaphore has long been a contention point in the memory
+ management subsystem. The mmap()/munmap() hold the write lock, and the
+ madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using madvise()
+ instead of munmap() to released physical memory can reduce the competition of
+ the mmap_lock.
+
+ Secondly, after using madvise() to release physical memory, there is no need to
+ build vma and allocate page tables again when accessing the same virtual
+ address again, which can also save some time.
+
+The following is the largest user PTE page table memory that can be allocated by
+a single user process in a 32-bit and a 64-bit system.
+
++---------------------------+--------+---------+
+|                           | 32-bit | 64-bit  |
++===========================+========+=========+
+| user PTE page table pages | 3 MiB  | 512 GiB |
++---------------------------+--------+---------+
+| user PMD page table pages | 3 KiB  | 1 GiB   |
++---------------------------+--------+---------+
+
+(for 32-bit, take 3G user address space, 4K page size as an example; for 64-bit,
+take 48-bit address width, 4K page size as an example.)
+
+After using ``madvise()``, everything looks good, but as can be seen from the
+above table, a single process can create a large number of PTE page tables on a
+64-bit system, since both of the ``MADV_DONTNEED`` and ``MADV_FREE`` will not
+release page table memory. And before the process exits or calls ``munmap()``,
+the kernel cannot reclaim these pages even if these PTE page tables do not map
+anything.
+
+Therefore, we decided to introduce reference count to manage the PTE page table
+life cycle, so that some free PTE page table memory in the system can be
+dynamically released.
+
+2. The reference count of user PTE page table pages
+===================================================
+
+We introduce two members for the ``struct page`` of the user PTE page table
+page::
+
+ union {
+	pgtable_t pmd_huge_pte; /* protected by page->ptl */
+	pmd_t *pmd;             /* PTE page only */
+ };
+ union {
+	struct mm_struct *pt_mm; /* x86 pgds only */
+	atomic_t pt_frag_refcount; /* powerpc */
+	atomic_t pte_refcount;  /* PTE page only */
+ };
+
+The ``pmd`` member record the pmd entry that maps the user PTE page table page,
+the ``pte_refcount`` member keep track of how many references to the user PTE
+page table page.
+
+The following people will hold a reference on the user PTE page table page::
+
+ The !pte_none() entry, such as regular page table entry that map physical
+ pages, or swap entry, or migrate entry, etc.
+
+ Visitor to the PTE page table entries, such as page table walker.
+
+Any ``!pte_none()`` entry and visitor can be regarded as the user of its PTE
+page table page. When the ``pte_refcount`` is reduced to 0, it means that no one
+is using the PTE page table page, then this free PTE page table page can be
+released back to the system at this time.
+
+3. Competitive relationship
+===========================
+
+Now, the user page table will only be released by calling ``free_pgtables()``
+when the process exits or ``unmap_region()`` is called (e.g. ``munmap()`` path).
+So other threads only need to ensure mutual exclusion with these paths to ensure
+that the page table is not released. For example::
+
+	thread A			thread B
+	page table walker		munmap
+	=================		======
+
+	mmap_read_lock()
+	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
+		pte_offset_map_lock()
+		*walk page table*
+		pte_unmap_unlock()
+	}
+	mmap_read_unlock()
+
+					mmap_write_lock_killable()
+					detach_vmas_to_be_unmapped()
+					unmap_region()
+					--> free_pgtables()
+
+But after we introduce the reference count for the user PTE page table page,
+these existing balances will be broken. The page can be released at any time
+when its ``pte_refcount`` is reduced to 0. Therefore, the following case may
+happen::
+
+	thread A		thread B			thread C
+	page table walker	madvise(MADV_DONTNEED)		page fault
+	=================	======================		==========
+
+	mmap_read_lock()
+	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
+
+				mmap_read_lock()
+				unmap_page_range()
+				--> zap_pte_range()
+				    *the pte_refcount is reduced to 0*
+				    --> *free PTE page table page*
+
+		/* broken!! */					mmap_read_lock()
+		pte_offset_map_lock()
+
+As we can see, all of the thread A, B and C hold the read lock of mmap_lock, so
+they can execute concurrently. When thread B releases the PTE page table page,
+the value in the corresponding pmd entry will become unstable, which may be
+none or huge pmd, or map a new PTE page table page again. This will cause system
+chaos and even panic.
+
+So as described in the section "The reference count of user PTE page table
+pages", we need to try to take a reference to the PTE page table page before
+walking page table, then the system will become orderly again::
+
+	thread A		thread B
+	page table walker	madvise(MADV_DONTNEED)
+	=================	======================
+
+	mmap_read_lock()
+	if (!pte_none() && pte_present() && !pmd_trans_unstable()) {
+		pte_try_get()
+		--> pte_get_unless_zero
+		*if successfully, then:*
+
+				mmap_read_lock()
+				unmap_page_range()
+				--> zap_pte_range()
+				    *the pte_refcount is reduced to 1*
+
+		pte_offset_map_lock()
+		*walk page table*
+		pte_unmap_unlock()
+		pte_put()
+		--> *the pte_refcount is reduced to 0*
+		    --> *free PTE page table page*
+
+There is also a lock-less scenario(such as fast GUP). Fortunately, we don't need
+to do any additional operations to ensure that the system is in order. Take fast
+GUP as an example::
+
+	thread A		thread B
+	fast GUP		madvise(MADV_DONTNEED)
+	========		======================
+
+	get_user_pages_fast_only()
+	--> local_irq_save();
+				*free PTE page table page*
+				--> unhook page
+				    /* The CPU where thread A is located closed
+				     * the local interrupt and cannot respond to
+				     * IPI, so it will block here */
+				    TLB invalidate page
+	    gup_pgd_range();
+	    local_irq_restore();
+	    			    *free page*
+
+4. Helpers
+==========
+
++---------------------+-------------------------------------------------+
+| pte_ref_init        | Initialize the pte_refcount and pmd             |
++---------------------+-------------------------------------------------+
+| pte_to_pmd          | Get the corresponding pmd                       |
++---------------------+-------------------------------------------------+
+| pte_update_pmd      | Update the corresponding pmd                    |
++---------------------+-------------------------------------------------+
+| pte_get             | Increment a pte_refcount                        |
++---------------------+-------------------------------------------------+
+| pte_get_many        | Add a value to a pte_refcount                   |
++---------------------+-------------------------------------------------+
+| pte_get_unless_zero | Increment a pte_refcount unless it is 0         |
++---------------------+-------------------------------------------------+
+| pte_try_get         | Try to increment a pte_refcount                 |
++---------------------+-------------------------------------------------+
+| pte_tryget_map      | Try to increment a pte_refcount before          |
+|                     | pte_offset_map()                                |
++---------------------+-------------------------------------------------+
+| pte_tryget_map_lock | Try to increment a pte_refcount before          |
+|                     | pte_offset_map_lock()                           |
++---------------------+-------------------------------------------------+
+| pte_put             | Decrement a pte_refcount                        |
++---------------------+-------------------------------------------------+
+| pte_put_many        | Sub a value to a pte_refcount                   |
++---------------------+-------------------------------------------------+
+| pte_put_vmf         | Decrement a pte_refcount in the page fault path |
++---------------------+-------------------------------------------------+
-- 
2.11.0

