Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE30414624
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhIVK2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbhIVK2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:28:44 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2CBC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so2180292pgc.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9Y75SXjQ4OjFnf6AL18GnX+kpqvEJUigzCibLGNWc0=;
        b=GoaNh0eyBtI0BAqbHw0AIPyMRmRMogyXs6ENtuhJGZRh7QLB6qZhAYmlhRt3JpTkmg
         w+FjzBOWFidlgTJxxCS1rlaNtWkqw9hU8SIgyItfljjyCa6vLtSpriQ/VDeRt7FHf2Ju
         P4yVKFidSEWAYw2n4yMjkX8Ry9IX/tvlbBZ2l+/C61KUcldmySBCsVL2S65jZFVPNOKo
         q5z4V9kz6d12molI4J1Q7OB3ZpjEXV0Sr1JZL5LXOVOikW/niitVMPYeW5l0l6P1KRfl
         zVG34ggd/XbKZoP34T11Le4LU7XbyNHtnHWUEksOrEJ996dvlTq6gFCEDK8WbtuQbh6+
         qqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9Y75SXjQ4OjFnf6AL18GnX+kpqvEJUigzCibLGNWc0=;
        b=My9FNmsVzJuwK57FAIkSU+dx5E9v6v8xmok+BkIpwlbr3FX5Icf8mBDHdfMzmjTn2G
         t1PGcVrnrMnIBmXbiYkJGYz7ZhJdJYDiN2smnSipvmoeB2yw3RnKivd0wPYT20ZI9/zd
         YG2QHAQs31IYsTxoWJ00+z1ubt5S2eapRAagSYiVgqFfXfOuGO/SzP5zN/5mzmNOm6CC
         1yGYCm83WUjjf1H1E7r3dIDcCG2Go4d1/bQaOdj96qkxMeK51n61lAjJYNah9SSLAf+A
         wE0I4dRxSD9PAytOcQB5NZlA518EKiWM/gAbJSnq0kk6uGWmreuZz1UB2rzXChrlJ5HP
         YFDg==
X-Gm-Message-State: AOAM530S/jXL6MDNUtHEOwvPsu2rAVfrb5roNuoualbCi8OaayRAAsNK
        B9lncpjTw/Jbv5xOBCJa/2eejg==
X-Google-Smtp-Source: ABdhPJwj+m8/3Sco/DMCLFXrMXDs8yZjN0k1vj0JTznwjQRew1gI7Jr5pVDALF/DRfwJHuGQAjB39w==
X-Received: by 2002:a63:1f24:: with SMTP id f36mr32764347pgf.6.1632306434072;
        Wed, 22 Sep 2021 03:27:14 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s89sm1821929pjj.43.2021.09.22.03.27.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 03:27:13 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
Date:   Wed, 22 Sep 2021 18:24:09 +0800
Message-Id: <20210922102411.34494-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210922102411.34494-1-songmuchun@bytedance.com>
References: <20210922102411.34494-1-songmuchun@bytedance.com>
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
 include/linux/hugetlb.h    | 10 ++++++++--
 include/linux/page-flags.h |  6 ++++--
 mm/hugetlb_vmemmap.c       | 12 ++++++------
 mm/memory_hotplug.c        |  2 +-
 4 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1faebe1cd0ed..4cc647a5dbf8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1066,9 +1066,15 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
+static inline bool hugetlb_free_vmemmap_enabled(void)
+{
+	return static_key_enabled(&hugetlb_free_vmemmap_enabled_key);
+}
 #else
-#define hugetlb_free_vmemmap_enabled	false
+static inline bool hugetlb_free_vmemmap_enabled(void)
+{
+	return false;
+}
 #endif
 
 static inline spinlock_t *huge_pte_lock(struct hstate *h,
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index b47a7f51d2c3..54e119e44496 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -185,7 +185,8 @@ enum pageflags {
 #ifndef __GENERATING_BOUNDS_H
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+			 hugetlb_free_vmemmap_enabled_key);
 
 /*
  * If the feature of freeing some vmemmap pages associated with each HugeTLB
@@ -205,7 +206,8 @@ extern bool hugetlb_free_vmemmap_enabled;
  */
 static __always_inline const struct page *page_fixed_fake_head(const struct page *page)
 {
-	if (!hugetlb_free_vmemmap_enabled)
+	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+				 &hugetlb_free_vmemmap_enabled_key))
 		return page;
 	/*
 	 * Only addresses aligned with PAGE_SIZE of struct page may be fake head
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 527bcaa44a48..47517e878ed5 100644
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
index 0488eed3327c..89c1fde02162 100644
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

