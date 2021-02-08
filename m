Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A9312CFB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhBHJNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhBHIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:54:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FD5C06121D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 00:52:58 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nm1so7876285pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FwfBb8leoH0hnrr2rh6Voq7+o/vVssC0KT4rigZes7k=;
        b=DSUVxLGj/l71Jy/1zoz60gcLWxd6itR639k/qbn3b6a71jdjfZxGMrgOL/9udCgeUH
         vGlzNS5jTBTROQ5CXmGKSSprFVfXYrWfrfmKCMjSW6Vl0tU7/l9WMj2A5eS8Q40qnap1
         B+TQayDgvXNEBJj93I8j7LwFoVqoyobW8TGqix/QJ7pGr34eZOp6a3vlR6hThe4qFAVy
         UlPmQt4oO2FsYB/JiSpLpCJFRIhqprozQrzhjnJ4P8uv0XoAk8BfiT8RTHetK/ia5XnH
         6M3l1MIW6NNTnsrMeKjv2Bp390wXyLLWAJTknWY7NJurZO7XDiWL/XLPMjY+hJ6lr/mc
         UStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FwfBb8leoH0hnrr2rh6Voq7+o/vVssC0KT4rigZes7k=;
        b=mX2PND9W4VnoEzaApSInjW1TBSbzAqim99AV/DvaqBfMEjE3WcVJAfBiKqGrjlut2d
         RH0l6zzg5xmk8OK4D1aRHifc8Zj3GjOUEFSkKKIx74RRQmC1NabOzj6lwW1NpbzG0f0I
         a70fp2+pwFaqy0IdjhSv+9zuMn7QoURHAaMwWy6LJbDS1aX6DnrhGvTNShXkuR2ponB5
         67xGPp8xARS8yCZouC2JNN5dPLRgxHIkc6VjEaB7jvSutNKI11ogwVdINmxSlH5T451U
         5DIMkdUU9TDDfHJUOJOn/O1vB3XFJl1rvYpnzCzmL+Q853qymsCoSSCOdjnWkYiGKJdO
         XG8A==
X-Gm-Message-State: AOAM5334zzH9bUswcu8PV9895sWksYhbEN2jQ5HfbQWCqUDpxs2+sUUL
        BPyHq8FOEXdviO6RrLGHWjHXEA==
X-Google-Smtp-Source: ABdhPJwdTic33Da4be3cn4KUGqT0YdaxInbVcA7iEoq8DGq+2eoEAsT/aLnsABWXVyqTEmcO3cur7A==
X-Received: by 2002:a17:902:e84e:b029:e2:dbb6:73f8 with SMTP id t14-20020a170902e84eb02900e2dbb673f8mr3876421plg.52.1612774378291;
        Mon, 08 Feb 2021 00:52:58 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id g15sm17205179pfb.30.2021.02.08.00.52.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 00:52:57 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: [PATCH v15 5/8] mm: hugetlb: add a kernel parameter hugetlb_free_vmemmap
Date:   Mon,  8 Feb 2021 16:50:10 +0800
Message-Id: <20210208085013.89436-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210208085013.89436-1-songmuchun@bytedance.com>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kernel parameter hugetlb_free_vmemmap to enable the feature of
freeing unused vmemmap pages associated with each hugetlb page on boot.

We disables PMD mapping of vmemmap pages for x86-64 arch when this
feature is enabled. Because vmemmap_remap_free() depends on vmemmap
being base page mapped.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 14 ++++++++++++++
 Documentation/admin-guide/mm/hugetlbpage.rst    |  3 +++
 arch/x86/mm/init_64.c                           |  8 ++++++--
 include/linux/hugetlb.h                         | 19 +++++++++++++++++++
 mm/hugetlb_vmemmap.c                            | 22 ++++++++++++++++++++++
 5 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5adf1e57e932..7db2591f3ad3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1577,6 +1577,20 @@
 			Documentation/admin-guide/mm/hugetlbpage.rst.
 			Format: size[KMG]
 
+	hugetlb_free_vmemmap=
+			[KNL] When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set,
+			this controls freeing unused vmemmap pages associated
+			with each HugeTLB page. When this option is enabled,
+			we disable PMD/huge page mapping of vmemmap pages which
+			increase page table pages. So if a user/sysadmin only
+			uses a small number of HugeTLB pages (as a percentage
+			of system memory), they could end up using more memory
+			with hugetlb_free_vmemmap on as opposed to off.
+			Format: { on | off (default) }
+
+			on:  enable the feature
+			off: disable the feature
+
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
 			Format: 0 | 1
diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
index f7b1c7462991..3a23c2377acc 100644
--- a/Documentation/admin-guide/mm/hugetlbpage.rst
+++ b/Documentation/admin-guide/mm/hugetlbpage.rst
@@ -145,6 +145,9 @@ default_hugepagesz
 
 	will all result in 256 2M huge pages being allocated.  Valid default
 	huge page size is architecture dependent.
+hugetlb_free_vmemmap
+	When CONFIG_HUGETLB_PAGE_FREE_VMEMMAP is set, this enables freeing
+	unused vmemmap pages associated with each HugeTLB page.
 
 When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
 indicates the current number of pre-allocated huge pages of the default size.
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0435bee2e172..39f88c5faadc 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -34,6 +34,7 @@
 #include <linux/gfp.h>
 #include <linux/kcore.h>
 #include <linux/bootmem_info.h>
+#include <linux/hugetlb.h>
 
 #include <asm/processor.h>
 #include <asm/bios_ebda.h>
@@ -1557,7 +1558,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
+	if ((is_hugetlb_free_vmemmap_enabled()  && !altmap) ||
+	    end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1585,6 +1587,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 	pmd_t *pmd;
 	unsigned int nr_pmd_pages;
 	struct page *page;
+	bool base_mapping = !boot_cpu_has(X86_FEATURE_PSE) ||
+			    is_hugetlb_free_vmemmap_enabled();
 
 	for (; addr < end; addr = next) {
 		pte_t *pte = NULL;
@@ -1610,7 +1614,7 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (!boot_cpu_has(X86_FEATURE_PSE)) {
+		if (base_mapping) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
 			if (pmd_none(*pmd))
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 37fd248ce271..ad249e56ac49 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -854,6 +854,20 @@ static inline void huge_ptep_modify_prot_commit(struct vm_area_struct *vma,
 
 void set_page_huge_active(struct page *page);
 
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+extern bool hugetlb_free_vmemmap_enabled;
+
+static inline bool is_hugetlb_free_vmemmap_enabled(void)
+{
+	return hugetlb_free_vmemmap_enabled;
+}
+#else
+static inline bool is_hugetlb_free_vmemmap_enabled(void)
+{
+	return false;
+}
+#endif
+
 #else	/* CONFIG_HUGETLB_PAGE */
 struct hstate {};
 
@@ -1007,6 +1021,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 					pte_t *ptep, pte_t pte, unsigned long sz)
 {
 }
+
+static inline bool is_hugetlb_free_vmemmap_enabled(void)
+{
+	return false;
+}
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 3d85e3ab7caa..2fa6fff9f5dd 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -183,6 +183,28 @@
 #define RESERVE_VMEMMAP_NR		2U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
+bool hugetlb_free_vmemmap_enabled;
+
+static int __init early_hugetlb_free_vmemmap_param(char *buf)
+{
+	/* We cannot optimize if a "struct page" crosses page boundaries. */
+	if ((!is_power_of_2(sizeof(struct page)))) {
+		pr_warn("cannot free vmemmap pages because \"struct page\" crosses page boundaries\n");
+		return 0;
+	}
+
+	if (!buf)
+		return -EINVAL;
+
+	if (!strcmp(buf, "on"))
+		hugetlb_free_vmemmap_enabled = true;
+	else if (strcmp(buf, "off"))
+		return -EINVAL;
+
+	return 0;
+}
+early_param("hugetlb_free_vmemmap", early_hugetlb_free_vmemmap_param);
+
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
  * to the buddy allocator.
-- 
2.11.0

