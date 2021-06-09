Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4853A140F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 14:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbhFIMSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbhFIMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 08:18:18 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6ADC06175F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jun 2021 05:16:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id e22so19264380pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 05:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fJItIIJHgO+A1N5IYOVKn5JeE414bhhp/oA3qles6Xw=;
        b=WlLFVMDvmulHtyEubYUDQU+7ljThYaUnjabUlZJLsA5GieKSU/8XkzkYlt1dydnyas
         1p/KUyW3jX5i6O0IT77DXTefphWxh+5xQpdCGdtjvT7ynnHIWz1oSFozd3HRbr8SbQ+3
         3BjVNa+WfTXUCGvFwWBkA3+maJBbRE9gDXvrif5OeXSnu3A50z29rTRnxoidxxXXJwme
         ZYuSyhXyIdfIlMn92Xy9IWg+kQ70GzDoNpqKeuKEIkgsbobaedlwRk14+AZPMMsQ0jGk
         ZxmT937nSKVj/gS900GTe8G3oa0ilU8/OuC+eBhETclxl/qSYQvCnGXu1xRssjde7JjB
         yEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fJItIIJHgO+A1N5IYOVKn5JeE414bhhp/oA3qles6Xw=;
        b=ffoEu9lt2aXmOCy8wtSISNwQfJdkTYTMMxWWd/UhLhIVWRAlrEZrdYfo7+r5Ad8xb+
         DN+FdCTmeFEMy65U4mV2GCZEL5PAcZayATTcG30/qtJ+ot4NnlcQIfl6rvWn13pcLQGc
         oz63NjOeq6RelphfbrVjq3rsNDd3YUbyu4vOnFUg7DdoWqElf+jHEMkcahMI7T1vp/1Z
         6e4RWTZ3FV7e0tqCK+yymLaY1XUwOe8MKHREMlx3DUvkI1zj+b5IJ8i+aP+THptkh20i
         gRw0N16LPT+kQQsiIK8+7UHwM7T1oEV8HkQYryrLvgDSNUOfEpKLeyRTV2zB5aRqAYpo
         RbJQ==
X-Gm-Message-State: AOAM530+8IMq3JeFV3143w4uTVWLRUmUXrREMf7qh7aB5cBlPAW8A1AP
        Kwny2VCufj46hrNGh4ezO1nVMg==
X-Google-Smtp-Source: ABdhPJzV04zNYLcNHfhY3m8qoB8RRWvVZ7sZMQTbXBOa04i5tBd1rQKv0iScYO3eQX+AF0GHGpm3Zg==
X-Received: by 2002:a63:5050:: with SMTP id q16mr3590109pgl.318.1623240970715;
        Wed, 09 Jun 2021 05:16:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id h16sm13689224pfk.119.2021.06.09.05.16.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 05:16:10 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/5] mm: hugetlb: introduce helpers to preallocate/free page tables
Date:   Wed,  9 Jun 2021 20:13:06 +0800
Message-Id: <20210609121310.62229-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210609121310.62229-1-songmuchun@bytedance.com>
References: <20210609121310.62229-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some architectures (e.g. x86_64 and arm64), vmemmap pages are usually
mapped with huge pmd. We will disable the huge pmd mapping of vmemmap
pages when the feature of "Free vmemmap pages of HugeTLB page" is enabled.
This can affect the non-HugeTLB pages. What we want is only mapping the
vmemmap pages associated with HugeTLB pages with base page. We can split
the huge pmd mapping of vmemmap pages when freeing vmemmap pages of
HugeTLB page. But we need to preallocate page tables. In this patch, we
introduce page tables allocationg/freeing helpers.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/hugetlb_vmemmap.h | 12 ++++++++++++
 2 files changed, 66 insertions(+)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f9f9bb212319..628e2752714f 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -170,6 +170,9 @@
  */
 #define pr_fmt(fmt)	"HugeTLB: " fmt
 
+#include <linux/list.h>
+#include <asm/pgalloc.h>
+
 #include "hugetlb_vmemmap.h"
 
 /*
@@ -209,6 +212,57 @@ static inline unsigned long free_vmemmap_pages_size_per_hpage(struct hstate *h)
 	return (unsigned long)free_vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
 }
 
+static inline unsigned int vmemmap_pages_per_hpage(struct hstate *h)
+{
+	return free_vmemmap_pages_per_hpage(h) + RESERVE_VMEMMAP_NR;
+}
+
+static inline unsigned long vmemmap_pages_size_per_hpage(struct hstate *h)
+{
+	return (unsigned long)vmemmap_pages_per_hpage(h) << PAGE_SHIFT;
+}
+
+static inline unsigned int pgtable_pages_to_prealloc_per_hpage(struct hstate *h)
+{
+	unsigned long vmemmap_size = vmemmap_pages_size_per_hpage(h);
+
+	/*
+	 * No need to pre-allocate page tables when there is no vmemmap pages
+	 * to be freed.
+	 */
+	if (!free_vmemmap_pages_per_hpage(h))
+		return 0;
+
+	return ALIGN(vmemmap_size, PMD_SIZE) >> PMD_SHIFT;
+}
+
+void vmemmap_pgtable_free(struct list_head *pgtables)
+{
+	struct page *pte_page, *t_page;
+
+	list_for_each_entry_safe(pte_page, t_page, pgtables, lru)
+		pte_free_kernel(&init_mm, page_to_virt(pte_page));
+}
+
+int vmemmap_pgtable_prealloc(struct hstate *h, struct list_head *pgtables)
+{
+	unsigned int nr = pgtable_pages_to_prealloc_per_hpage(h);
+
+	while (nr--) {
+		pte_t *pte_p;
+
+		pte_p = pte_alloc_one_kernel(&init_mm);
+		if (!pte_p)
+			goto out;
+		list_add(&virt_to_page(pte_p)->lru, pgtables);
+	}
+
+	return 0;
+out:
+	vmemmap_pgtable_free(pgtables);
+	return -ENOMEM;
+}
+
 /*
  * Previously discarded vmemmap pages will be allocated and remapping
  * after this function returns zero.
diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
index cb2bef8f9e73..306e15519da1 100644
--- a/mm/hugetlb_vmemmap.h
+++ b/mm/hugetlb_vmemmap.h
@@ -14,6 +14,8 @@
 int alloc_huge_page_vmemmap(struct hstate *h, struct page *head);
 void free_huge_page_vmemmap(struct hstate *h, struct page *head);
 void hugetlb_vmemmap_init(struct hstate *h);
+int vmemmap_pgtable_prealloc(struct hstate *h, struct list_head *pgtables);
+void vmemmap_pgtable_free(struct list_head *pgtables);
 
 /*
  * How many vmemmap pages associated with a HugeTLB page that can be freed
@@ -33,6 +35,16 @@ static inline void free_huge_page_vmemmap(struct hstate *h, struct page *head)
 {
 }
 
+static inline int vmemmap_pgtable_prealloc(struct hstate *h,
+					   struct list_head *pgtables)
+{
+	return 0;
+}
+
+static inline void vmemmap_pgtable_free(struct list_head *pgtables)
+{
+}
+
 static inline void hugetlb_vmemmap_init(struct hstate *h)
 {
 }
-- 
2.11.0

