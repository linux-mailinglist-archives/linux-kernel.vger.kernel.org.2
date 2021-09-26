Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E57E4185DF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhIZDQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Sep 2021 23:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhIZDQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Sep 2021 23:16:36 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F65C061570
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:15:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id a7so9317491plm.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Sep 2021 20:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ilJDkaXh7LSsk+2CbzGdt7+obruL8uLSSSFT+3lohw=;
        b=nqbT0e8TItR5o3/wHL39X8UsBDXH5hOn3v5nBEgeVS2jYUxf+re1U5X70AIdPHelUE
         YjGQTjEoB0SLyDuFEvlWDA0AlZsFh0rrmULGTua7RVSnrctMGumYosfbaMJZ5A4FKDJa
         J6h3CvyOEUt+gYjVD1VZcdirCyTKHBNOdCrLBx2WBEXjjWTPNFj2Wn5FL1twweOY4J0t
         l+8s3pbqNLiR91hA6EYHLMSrG/LtZIyzV2VAV8ccaquyrTKzfT728yu9aMOumxCRdzWY
         Be88VpOBa05/aL1aAMBt9C4Jtn/VA6WtxqURPWqextJtlYSerTeMk0nWoT4+VYQslfnN
         eSYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ilJDkaXh7LSsk+2CbzGdt7+obruL8uLSSSFT+3lohw=;
        b=U6Km5JyGrUFjEQXyo+PUExJ3lMsOtXt94NV6z/VIVpsw6js4vgHz038/XnbdWo5DjO
         6KTO7DK8w3G/xpKwncCtcZR4EbUnea/l9UMCHcfi7+HQ1vElrM2HK4OdIoUHvZD9Ar2e
         XWA777Uj6RxAgJMFwkqi/FrqMkfJ6QF1tnCeLNcIrlzx2grIxpMbNr9IJMNQzee2M9mw
         XbhEugrK7hntx/QKOvndmmcz/JR68aQT3CZGHSFcApzT7Stv6wbf1OgqUz8yCcoIGGBy
         REmJAMPu14vbiqUoFv9UCf7pz23PLcAIBoyQKI17T7QNgqsfzfONjB2a7/Pmz+iPnoTc
         fF0A==
X-Gm-Message-State: AOAM532tfosxyCl3OJnKNu5MPFSXkaPeXNDbNNqZ231Swendb47p3nJp
        C9T74WJ7mMzgk+838HpMo/tKHg==
X-Google-Smtp-Source: ABdhPJy9/a/hcrXJCLT/1kui8x/aIagv3blDvi1/0Oi0qfoui0T6GrgWME8+PthvdIAaNfxdVJbuiA==
X-Received: by 2002:a17:90b:8cb:: with SMTP id ds11mr11500318pjb.66.1632626100693;
        Sat, 25 Sep 2021 20:15:00 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id v26sm13374862pfm.175.2021.09.25.20.14.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 20:15:00 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 2/5] mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
Date:   Sun, 26 Sep 2021 11:13:36 +0800
Message-Id: <20210926031339.40043-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210926031339.40043-1-songmuchun@bytedance.com>
References: <20210926031339.40043-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page_head_if_fake() is used throughout memory management and the
conditional check requires checking a global variable, although the
overhead of this check may be small, it increases when the memory
cache comes under pressure. Also, the global variable will not be
modified after system boot, so it is very appropriate to use static
key machanism.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/hugetlb.h    |  6 ------
 include/linux/page-flags.h | 18 +++++++++++++++---
 mm/hugetlb_vmemmap.c       | 12 ++++++------
 mm/memory_hotplug.c        |  2 +-
 4 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3cbf60464398..a90cc88195da 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1055,12 +1055,6 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 }
 #endif	/* CONFIG_HUGETLB_PAGE */
 
-#ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
-#else
-#define hugetlb_free_vmemmap_enabled	false
-#endif
-
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
 					struct mm_struct *mm, pte_t *pte)
 {
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b49808e748ce..26e540fd3393 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -185,7 +185,14 @@ enum pageflags {
 #ifndef __GENERATING_BOUNDS_H
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+			 hugetlb_free_vmemmap_enabled_key);
+
+static __always_inline bool hugetlb_free_vmemmap_enabled(void)
+{
+	return static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+				   &hugetlb_free_vmemmap_enabled_key);
+}
 
 /*
  * If the feature of freeing some vmemmap pages associated with each HugeTLB
@@ -205,7 +212,7 @@ extern bool hugetlb_free_vmemmap_enabled;
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-	if (!hugetlb_free_vmemmap_enabled)
+	if (!hugetlb_free_vmemmap_enabled())
 		return page;
 
 	/*
@@ -229,10 +236,15 @@ static __always_inline const struct page *page_fixed_fake_head(const struct page
 	return page;
 }
 #else
-static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
+static inline const struct page *page_fixed_fake_head(const struct page *page)
 {
 	return page;
 }
+
+static inline bool hugetlb_free_vmemmap_enabled(void)
+{
+	return false;
+}
 #endif
 
 static __always_inline int page_is_fake_head(struct page *page)
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index f4a8fca691ee..22ecb5e21686 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -188,9 +188,9 @@
 #define RESERVE_VMEMMAP_NR		1U
 #define RESERVE_VMEMMAP_SIZE		(RESERVE_VMEMMAP_NR << PAGE_SHIFT)
 
-bool hugetlb_free_vmemmap_enabled __read_mostly =
-	IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON);
-EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled);
+DEFINE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+			hugetlb_free_vmemmap_enabled_key);
+EXPORT_SYMBOL(hugetlb_free_vmemmap_enabled_key);
 
 static int __init early_hugetlb_free_vmemmap_param(char *buf)
 {
@@ -204,9 +204,9 @@ static int __init early_hugetlb_free_vmemmap_param(char *buf)
 		return -EINVAL;
 
 	if (!strcmp(buf, "on"))
-		hugetlb_free_vmemmap_enabled = true;
+		static_branch_enable(&hugetlb_free_vmemmap_enabled_key);
 	else if (!strcmp(buf, "off"))
-		hugetlb_free_vmemmap_enabled = false;
+		static_branch_disable(&hugetlb_free_vmemmap_enabled_key);
 	else
 		return -EINVAL;
 
@@ -284,7 +284,7 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_free_vmemmap_enabled)
+	if (!hugetlb_free_vmemmap_enabled())
 		return;
 
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 4ea91c3ff768..66eaa4e2e76f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1341,7 +1341,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       populate a single PMD.
 	 */
 	return memmap_on_memory &&
-	       !hugetlb_free_vmemmap_enabled &&
+	       !hugetlb_free_vmemmap_enabled() &&
 	       IS_ENABLED(CONFIG_MHP_MEMMAP_ON_MEMORY) &&
 	       size == memory_block_size_bytes() &&
 	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-- 
2.11.0

