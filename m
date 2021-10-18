Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92D1431600
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhJRK1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhJRK1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:27:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6249C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:36 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so14126126pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhMXohaipBke6xOtWf2whLCJBoi6CVAwEzN4wXOFZSY=;
        b=hnUO9pplQhl5S3GsNvI6yx4RjlSwCCnaMcQvqhLf2TBKOUUDkg47/v6/xUW+vvgv0x
         84rkV2kA7bARAel5+WQbpyBZDisbABA88id207Wq7htpPwWyQO1/d2oGWdKr5yn2KyAa
         Aiu1uQ1A18cw+wOtyl8SPJw+pYQpTEy60dbkLS3FvzF5KPLKKBe31CNb+8r7lQ1BE5hN
         4+16f9sfEcscRWhfNbyg/bFRiIo2jgB2DtTGl5IN1unyxS+LCB8t/6h4vOPAb/Jso+Oj
         Xml9ecpione7lx2zqqQ7l8Hiq1awF8tVJqD1oGFqcOH1Kb+sRwG8yf0XWgLPsXZqIdya
         JMGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhMXohaipBke6xOtWf2whLCJBoi6CVAwEzN4wXOFZSY=;
        b=nf73xQfPTnuYUhMKJrz3wGjTJALBuJxRlStk24DsKYELDAQbo0xtxma6f7XiPwTazt
         evLJN+RnmzQdg35700aZ9KkR0YWafVvYBH2jjut5IBIPsucIlpHtLwmExKmRH3CddOS7
         pLhn7htAtVkn2ZdYzJdzhOyfAyGYzvXsGCufIoBhetmAjRocEZB2qz2c/3Co4NGv8d6O
         z6QDthdCVC4spsWMNFezICnjmS/SA5I2U+dhbel3NrQGJeUY7RfZC9F9kx7RpE2YcN1A
         WkVrxsI2o/XflQu9z43B4reakZMHUsUfEGKf0MNhftMjP9s1tapI0uv2UBK8Dm0Dyqli
         Oskg==
X-Gm-Message-State: AOAM533RSxog5E5SEztYp9IpUApWbHEgUmfJfY2vIxcCST9w+yayiR6t
        kNZOMtBJjMXGkoai3ObBYji7+w==
X-Google-Smtp-Source: ABdhPJzmhXBehF57sDToISHgBpJeXGOTenrQtWrZvDbe/BybmHbhc2G3sAd4iD96pWqgNZheVhDwMQ==
X-Received: by 2002:a17:903:234a:b0:13e:f01a:24f with SMTP id c10-20020a170903234a00b0013ef01a024fmr26554320plh.43.1634552736229;
        Mon, 18 Oct 2021 03:25:36 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id nn14sm12762232pjb.27.2021.10.18.03.25.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:25:36 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 2/5] mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
Date:   Mon, 18 Oct 2021 18:20:40 +0800
Message-Id: <20211018102043.78685-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211018102043.78685-1-songmuchun@bytedance.com>
References: <20211018102043.78685-1-songmuchun@bytedance.com>
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
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
---
 include/linux/hugetlb.h    |  6 ------
 include/linux/page-flags.h | 16 ++++++++++++++--
 mm/hugetlb_vmemmap.c       | 12 ++++++------
 mm/memory_hotplug.c        |  2 +-
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 44c2ab0dfa59..27a2adff0db7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1077,12 +1077,6 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
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
index 7cd386538d0c..26e540fd3393 100644
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
@@ -233,6 +240,11 @@ static inline const struct page *page_fixed_fake_head(const struct page *page)
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
index 3de7933e5302..587a8fc61fc8 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1326,7 +1326,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
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

