Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBA13604B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhDOIo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbhDOIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:44:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28023C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:44:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so13992231pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 01:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rztN3Sqh1tkAjysn9ldI6OfX9hnQFcJ8oZ96HmDJuBw=;
        b=XyjszvEg4KtjzDgyFGgL4DKc3WTlGlBJkpde9eFMNV5K7VTWE7DHIT09M4BKSwVcyr
         8nKOzj/d5HHpc+YFKjmxwXy9t/m2Iot3CMvKHHOjtLYyeF+EK3WQS+cZYbcz70Ytuf7D
         qMJvJthb5h4SYRZO7708mCFiKU1K1ORY3fl8Ri605brIuIEgWUDuIE8+LMNuuq+47JiC
         XjV2TyhuMJfM+Spm8svYyY3NpdHsD9vRDVuzfPiy12HfHb5OWt4tB+oH2aMYsSEj+gSJ
         gfU5lqRnEHoWbZNj25cSjJOHE/B+y3bJnj57lhh+wxD6LwJesJv/BQ6yMzpwcXiGY798
         +6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rztN3Sqh1tkAjysn9ldI6OfX9hnQFcJ8oZ96HmDJuBw=;
        b=uGjpuQ/USRNLjH2W8H1ylNdCO/S2mjDusVNAgkR6Jfru3JD/LtfhYzGPhjg5eTA52p
         ZrTKo6zIFIGSIPr9RawzVnoNQObKo5ALI/Ox3xFW7Y8Jwi6CLxgZ27aRZ/9b/ixYbKT3
         vH+QTMc4QQOtdl5scNiO/rq6n6LIwuGgjZjE5akLNAfX9OhR+ikT9lA3FTAFublwVIML
         zNYEuEjwt3d4mNYsKhgshhLe2jU8MX2hChlXcGDEliLJMcBD/SV5flLBbqFHFgzeikAp
         I4kWxzFoeKwSrVeKbHRpnj+JR5Kjjv4wTSzQ/w6OD0dCDcIQ7Hcer0lO0D9gq1Y9qQ9r
         eKjQ==
X-Gm-Message-State: AOAM533HT0m4qErKgrSD/hWRi4wnohBOtSb7VYQYetr5JVV/0+RebbJt
        hTV5/W8qTpQu26ad0fr6++JT7w==
X-Google-Smtp-Source: ABdhPJzH5qvqlCVH3XG4+IacmBcXDkhhbnx9NW6Ap/O/MV03EbydxBbdj/RauHFJJ1E0EP9+xtzJdA==
X-Received: by 2002:a17:902:ce8b:b029:eb:5fd4:51c5 with SMTP id f11-20020a170902ce8bb02900eb5fd451c5mr2809871plg.31.1618476242689;
        Thu, 15 Apr 2021 01:44:02 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id e13sm1392365pgt.91.2021.04.15.01.43.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 01:44:02 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com, rientjes@google.com,
        willy@infradead.org, osalvador@suse.de, mhocko@suse.com,
        song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
Subject: [PATCH v20 9/9] mm: hugetlb: introduce nr_free_vmemmap_pages in the struct hstate
Date:   Thu, 15 Apr 2021 16:40:05 +0800
Message-Id: <20210415084005.25049-10-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210415084005.25049-1-songmuchun@bytedance.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the infrastructure is ready, so we introduce nr_free_vmemmap_pages
field in the hstate to indicate how many vmemmap pages associated with
a HugeTLB page that can be freed to buddy allocator. And initialize it
in the hugetlb_vmemmap_init(). This patch is actual enablement of the
feature.

There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Chen Huang <chenhuang5@huawei.com>
Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
---
 include/linux/hugetlb.h |  3 +++
 mm/hugetlb.c            |  1 +
 mm/hugetlb_vmemmap.c    | 33 +++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h    | 10 ++++++----
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 4015cedacf91..710d821fbca6 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -602,6 +602,9 @@ struct hstate {
 	unsigned int nr_huge_pages_node[MAX_NUMNODES];
 	unsigned int free_huge_pages_node[MAX_NUMNODES];
 	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
+#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
+	unsigned int nr_free_vmemmap_pages;
+#endif
 #ifdef CONFIG_CGROUP_HUGETLB
 	/* cgroup control files */
 	struct cftype cgroup_files_dfl[7];
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1c37f0098e00..8adf52f4c7e4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3361,6 +3361,7 @@ void __init hugetlb_add_hstate(unsigned int order)
 	h->next_nid_to_free = first_memory_node;
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
+	hugetlb_vmemmap_init(h);
 
 	parsed_hstate = h;
 }
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 3070e1465b1b..f9f9bb212319 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -262,3 +262,36 @@ void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 
 	SetHPageVmemmapOptimized(head);
 }
+
+void __init hugetlb_vmemmap_init(struct hstate *h)
+{
+	unsigned int nr_pages = pages_per_huge_page(h);
+	unsigned int vmemmap_pages;
+
+	/*
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
+	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 */
+	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
+	if (!hugetlb_free_vmemmap_enabled)
+		return;
+
+	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
+	/*
+	 * The head page and the first tail page are not to be freed to buddy
+	 * allocator, the other pages will map to the first tail page, so they
+	 * can be freed.
+	 *
+	 * Could RESERVE_VMEMMAP_NR be greater than @vmemmap_pages? It is true
+	 * on some architectures (e.g. aarch64). See Documentation/arm64/
+	 * hugetlbpage.rst for more details.
+	 */
+	if (likely(vmemmap_pages > RESERVE_VMEMMAP_NR))
+		h->nr_free_vmemmap_pages = vmemmap_pages - RESERVE_VMEMMAP_NR;
+
+	pr_info("can free %d vmemmap pages for %s\n", h->nr_free_vmemmap_pages,
+		h->name);
+}
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index a37771b0b82a..cb2bef8f9e73 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -13,17 +13,15 @@
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
+void hugetlb_vmemmap_init(struct hstate *h);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
  * to the buddy allocator.
- *
- * Todo: Returns zero for now, which means the feature is disabled. We will
- * enable it once all the infrastructure is there.
  */
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
-	return 0;
+	return h->nr_free_vmemmap_pages;
 }
 #else
 static inline int alloc_huge_page_vmemmap(struct hstate *h, struct page *head)
@@ -35,6 +33,10 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline void hugetlb_vmemmap_init(struct hstate *h)
+{
+}
+
 static inline unsigned int free_vmemmap_pages_per_hpage(struct hstate *h)
 {
 	return 0;
-- 
2.11.0

