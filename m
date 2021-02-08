Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDB312CF8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbhBHJMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbhBHIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 03:54:17 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D98CC061225
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 00:53:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u11so7429648plg.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 00:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m2r1FERWV6CvJlF69ZnvfWhQq8y+N+1HmL5D3fr7REw=;
        b=mBcQo7C28Z/wKNxelavNo4kQzH38pqJyrK3MgBOwLmMt1/u8We3+zUu4Tp1UGo52bF
         TIT934gPZymDlU6DI6U8i8czBR5biwD4HgRPHf7BsSs32Lf7/aA+gl3S3Y5Q1DuFAdi8
         ExZm9nxwTo6s/7WmH+lsgGEwcB+WDm5VggdMiQ7X2SQaPvSfLbTwg4b3yQyFq30TQ9Xp
         P2FLDjRm8zhTfJS6VQnaUSYLy9yMxjqxBNmZzHdFlISNgwSrJ0201Qr09wQ1ubPu/vqZ
         cQeZW2PpiKc6hgUbnyLarmgVGqUFrxYJyatJAuVWk57RT3BuRjkbNqVz9XCTU+/SnSdq
         Wwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m2r1FERWV6CvJlF69ZnvfWhQq8y+N+1HmL5D3fr7REw=;
        b=oAMj2N63gJzKBTu744Xm44pXveC4NNIe57fviMVLe8DtmCXzM3YuwlYD06YOxJLUG0
         yHLs7qxgTZ83E18oOKALr7VLspoB1+HRsBQAFmpy4yG/FQX1WNhcRr5sKACQ5AYt7P9f
         CwqlJ6USB2T47+dj2y/9KAQX0nySJXbghF91K6btuTUnds/85HRI2MHsYuvu3pQF4Kmj
         JfadiPQDStO8ns2wTYsoCoFz91SH9U612GNx+XpGg0IjmDXmOagsBVvL8drcOqIN4ypB
         dUzsSQqzC5Gmeg4rfUMBFsPi6aktfPYG43asjKYQlU9pJet+TaHcTbkKCfJ+v+CapULI
         3KxQ==
X-Gm-Message-State: AOAM530Tg9memK3yTxYZKyGXlX52U3tW2z6Fg7wtw8167GwXiM5uKNmW
        hXj4w1r7RHxeDopgrEHkSBJ0Aw==
X-Google-Smtp-Source: ABdhPJwOtrHuyQXU5ZS8lGlTx0DLdMx6kmpQHx021XNgBGLZl50up3yVnxZ+F2qQLHOMZ9ycgOf4LA==
X-Received: by 2002:a17:90a:1b4f:: with SMTP id q73mr13180015pjq.187.1612774402732;
        Mon, 08 Feb 2021 00:53:22 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id g15sm17205179pfb.30.2021.02.08.00.53.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 00:53:22 -0800 (PST)
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
Subject: [PATCH v15 7/8] mm: hugetlb: gather discrete indexes of tail page
Date:   Mon,  8 Feb 2021 16:50:12 +0800
Message-Id: <20210208085013.89436-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210208085013.89436-1-songmuchun@bytedance.com>
References: <20210208085013.89436-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For HugeTLB page, there are more metadata to save in the struct page.
But the head struct page cannot meet our needs, so we have to abuse
other tail struct page to store the metadata. In order to avoid
conflicts caused by subsequent use of more tail struct pages, we can
gather these discrete indexes of tail struct page. In this case, it
will be easier to add a new tail page index later.

There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/hugetlb.h        | 20 ++++++++++++++++++--
 include/linux/hugetlb_cgroup.h | 19 +++++++++++--------
 mm/hugetlb_vmemmap.c           |  8 ++++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 775aea53669a..822ab2f5542a 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -28,6 +28,22 @@ typedef struct { unsigned long pd; } hugepd_t;
 #include <linux/shm.h>
 #include <asm/tlbflush.h>
 
+/*
+ * For HugeTLB page, there are more metadata to save in the struct page. But
+ * the head struct page cannot meet our needs, so we have to abuse other tail
+ * struct page to store the metadata. In order to avoid conflicts caused by
+ * subsequent use of more tail struct pages, we gather these discrete indexes
+ * of tail struct page here.
+ */
+enum {
+	SUBPAGE_INDEX_SUBPOOL = 1,	/* reuse page->private */
+#ifdef CONFIG_CGROUP_HUGETLB
+	SUBPAGE_INDEX_CGROUP,		/* reuse page->private */
+	SUBPAGE_INDEX_CGROUP_RSVD,	/* reuse page->private */
+#endif
+	NR_USED_SUBPAGE,
+};
+
 struct hugepage_subpool {
 	spinlock_t lock;
 	long count;
@@ -607,13 +623,13 @@ extern unsigned int default_hstate_idx;
  */
 static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 {
-	return (struct hugepage_subpool *)(hpage+1)->private;
+	return (void *)page_private(hpage + SUBPAGE_INDEX_SUBPOOL);
 }
 
 static inline void hugetlb_set_page_subpool(struct page *hpage,
 					struct hugepage_subpool *subpool)
 {
-	set_page_private(hpage+1, (unsigned long)subpool);
+	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
 }
 
 static inline struct hstate *hstate_file(struct file *f)
diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 2ad6e92f124a..c0cae6a704f2 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -21,15 +21,16 @@ struct hugetlb_cgroup;
 struct resv_map;
 struct file_region;
 
+#ifdef CONFIG_CGROUP_HUGETLB
 /*
  * Minimum page order trackable by hugetlb cgroup.
  * At least 4 pages are necessary for all the tracking information.
- * The second tail page (hpage[2]) is the fault usage cgroup.
- * The third tail page (hpage[3]) is the reservation usage cgroup.
+ * The second tail page (hpage[SUBPAGE_INDEX_CGROUP]) is the fault
+ * usage cgroup. The third tail page (hpage[SUBPAGE_INDEX_CGROUP_RSVD])
+ * is the reservation usage cgroup.
  */
-#define HUGETLB_CGROUP_MIN_ORDER	2
+#define HUGETLB_CGROUP_MIN_ORDER	order_base_2(NR_USED_SUBPAGE)
 
-#ifdef CONFIG_CGROUP_HUGETLB
 enum hugetlb_memory_event {
 	HUGETLB_MAX,
 	HUGETLB_NR_MEMORY_EVENTS,
@@ -66,9 +67,9 @@ __hugetlb_cgroup_from_page(struct page *page, bool rsvd)
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return NULL;
 	if (rsvd)
-		return (struct hugetlb_cgroup *)page[3].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP_RSVD);
 	else
-		return (struct hugetlb_cgroup *)page[2].private;
+		return (void *)page_private(page + SUBPAGE_INDEX_CGROUP);
 }
 
 static inline struct hugetlb_cgroup *hugetlb_cgroup_from_page(struct page *page)
@@ -90,9 +91,11 @@ static inline int __set_hugetlb_cgroup(struct page *page,
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
 		return -1;
 	if (rsvd)
-		page[3].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
+				 (unsigned long)h_cg);
 	else
-		page[2].private = (unsigned long)h_cg;
+		set_page_private(page + SUBPAGE_INDEX_CGROUP,
+				 (unsigned long)h_cg);
 	return 0;
 }
 
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ac29753fb297..a67301a9d19a 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -272,6 +272,14 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	unsigned int nr_pages = pages_per_huge_page(h);
 	unsigned int vmemmap_pages;
 
+	/*
+	 * There are only (RESERVE_VMEMMAP_SIZE / sizeof(struct page)) struct
+	 * page structs that can be used when CONFIG_HUGETLB_PAGE_FREE_VMEMMAP,
+	 * so add a BUILD_BUG_ON to catch invalid usage of the tail struct page.
+	 */
+	BUILD_BUG_ON(NR_USED_SUBPAGE >=
+		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
+
 	if (!hugetlb_free_vmemmap_enabled)
 		return;
 
-- 
2.11.0

