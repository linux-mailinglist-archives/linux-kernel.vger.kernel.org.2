Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F2E3A4DFE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jun 2021 11:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbhFLJse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Jun 2021 05:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhFLJsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jun 2021 05:48:33 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC21C0617AF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:46:18 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c12so6483272pfl.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jun 2021 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KC0On2yvIRGYR5Tx6Aoa1thZ3mR+Ze9SCIXSxV9QNMo=;
        b=BWT9fI1X89JDvUQS4XFMLpK1ki292I3lniywkAZFQ387QiFhmPa1rsKIzcyACeeuYn
         LDCgxz9yhxYBTAg5P+XeDLuJ2xn3Sv17zYC6gcORNRyX0sqGpgcw7tdU33VQqWIcHBJL
         IWnJLmA9+HiXJd2L6rMQ3QOocJMh2hqMrpcAie+09tUMz9yDxa08HfcBN3jyP3R7OQw2
         /g9yIZ+pG2Pdc5vDYqdWQtioRIYGTZ/NHiWjEnJYMGnQeJiARvYB7xBynkuNY7agse0y
         qmHbGwXgfo7KMImfKVa+7bB2HUF3M4kBxW5W9rl8oevftB/PSX2jKgRpf1fMzy1GxZkk
         tLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KC0On2yvIRGYR5Tx6Aoa1thZ3mR+Ze9SCIXSxV9QNMo=;
        b=jn+YmBVgeBPr2IVixtqPPiO3AykrsaPSTEOBmuwnTKt47DT4adOiFLGAa/QyaDySqe
         eqVS/mtasgNsnZdPY8Z79sENiacfWxe3EMCqBShB7eOG1A7xybC3BwC7PrIGK+XAxNWK
         SUR2JH1j6vdJ6G0kqBf7qXJz9QbwMmqIW2mTvXJYn6kGgGkdvEazfJPBfO5JY6LuswCY
         9g/atVYehVELQj6GkHc2XPVRRRvgjxpKhIhSnm3Pga+hRw2Hb50io5kqBPJkjB8vmSYZ
         Z2qSbK8p5mxUWLuD9sLk/jhAH3spwdJgMbzvkUjYH4D00fHU6D9N0c9pBIvyisDj/40t
         6PwA==
X-Gm-Message-State: AOAM532lLFdQCtkFHIttOw0b4kjEiSWs/AnzZNFvxr1ONPkoUzErVvsl
        cre/oPwl7OFO0YrruoxRwKwYwg==
X-Google-Smtp-Source: ABdhPJzlV+X34s+XadDAq8IRfThE+1QP5f7WXqSFWivVZkY7TsjDfOf4yVK+yTR8eXMcg7x/42wckA==
X-Received: by 2002:a62:7d4e:0:b029:2e9:ac1c:2769 with SMTP id y75-20020a627d4e0000b02902e9ac1c2769mr12173274pfc.57.1623491178468;
        Sat, 12 Jun 2021 02:46:18 -0700 (PDT)
Received: from localhost.tiktokd.org ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id t39sm6929557pfg.147.2021.06.12.02.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jun 2021 02:46:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/3] mm: sparsemem: use huge PMD mapping for vmemmap pages
Date:   Sat, 12 Jun 2021 17:45:54 +0800
Message-Id: <20210612094555.71344-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210612094555.71344-1-songmuchun@bytedance.com>
References: <20210612094555.71344-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The preparation of splitting huge PMD mapping of vmemmap pages is ready,
so switch the mapping from PTE to PMD.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 -------
 arch/x86/mm/init_64.c                           |  8 ++------
 include/linux/hugetlb.h                         | 25 ++++++-------------------
 mm/memory_hotplug.c                             |  2 +-
 4 files changed, 9 insertions(+), 33 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index db1ef6739613..a01aadafee38 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1599,13 +1599,6 @@
 			enabled.
 			Allows heavy hugetlb users to free up some more
 			memory (6 * PAGE_SIZE for each 2MB hugetlb page).
-			This feauture is not free though. Large page
-			tables are not used to back vmemmap pages which
-			can lead to a performance degradation for some
-			workloads. Also there will be memory allocation
-			required when hugetlb pages are freed from the
-			pool which can lead to corner cases under heavy
-			memory pressure.
 			Format: { on | off (default) }
 
 			on:  enable the feature
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 9d9d18d0c2a1..65ea58527176 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,7 +34,6 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
-#include <linux/hugetlb.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1610,8 +1609,7 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 	VM_BUG_ON(!IS_ALIGNED(start, PAGE_SIZE));
 	VM_BUG_ON(!IS_ALIGNED(end, PAGE_SIZE));
 
-	if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
-	    end - start < PAGES_PER_SECTION * sizeof(struct page))
+	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1639,8 +1637,6 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 	pmd_t *pmd;
 	unsigned int nr_pmd_pages;
 	struct page *page;
-	bool base_mapping = !boot_cpu_has(X86_FEATURE_PSE) ||
-			    is_hugetlb_free_vmemmap_enabled();
 
 	for (; addr < end; addr = next) {
 		pte_t *pte = NULL;
@@ -1666,7 +1662,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (base_mapping) {
+		if (!boot_cpu_has(X86_FEATURE_PSE)) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
 			if (pmd_none(*pmd))
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 03ca83db0a3e..d43565dd5fb9 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -904,20 +904,6 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 }
 #endif
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
-
-static inline bool is_hugetlb_free_vmemmap_enabled(void)
-{
-	return hugetlb_free_vmemmap_enabled;
-}
-#else
-static inline bool is_hugetlb_free_vmemmap_enabled(void)
-{
-	return false;
-}
-#endif
-
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1077,13 +1063,14 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
-
-static inline bool is_hugetlb_free_vmemmap_enabled(void)
-{
-	return false;
-}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+extern bool hugetlb_free_vmemmap_enabled;
+#else
+#define hugetlb_free_vmemmap_enabled	false
+#endif
+
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
 					struct mm_struct *mm, pte_t *pte)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d96a3c7551c8..9d8a551c08d5 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1056,7 +1056,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       populate a single PMD.
 	 */
 	return memmap_on_memory &&
-	       !is_hugetlb_free_vmemmap_enabled() &&
+	       !hugetlb_free_vmemmap_enabled &&
 	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-- 
2.11.0

