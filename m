Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2868241AF35
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240757AbhI1Mo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240762AbhI1Mo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:44:28 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF593C061604
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:48 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s11so21019491pgr.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1mV+Uo2hEu6Z/m8ownrJ3eDHR3JXra4o9LXLi90WMCs=;
        b=pAboec8Z9r/H+WP0iIlbENqCqMmH4ubvCfHX40yht+vZi5YqbabayFsTQMNiIOT1xC
         3G1ImHKYEcxXoX4dpIef05Iq1B2PGk91xxZqXPoJE/HwwkYeRFr9SFVv4V7RvP4coBDO
         +oNYvcwP98w2eJRrPxqKnr4P9PDD3vNtnrRpBsb+GoPqPdJYx1vh8by55mgpXmP1/kD4
         i0JT7xz97Mq/aFv2eTuz6XNWzHxFZ7uV1chIKOrcmFSGb09Q+XLvM3/lj6rnsvQWCUFC
         uTvQQD5VE+e7ht3Y3w4w2ohDWUGMo8Dl6dJ6X9C6kDClGn+qFYyp034FiGEArwXtPXBb
         xrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1mV+Uo2hEu6Z/m8ownrJ3eDHR3JXra4o9LXLi90WMCs=;
        b=ieWGNh8y16LIqJEfclijcHty1wfbQBomRMrbAl/TwVFZ1UodrAvdsz0jpw/VCEwbOo
         MaOvTY7wdyWOciF9FS7yIh6R3e658NugcMLSxUP1vgNRXFXEKtRyTRaZDTgkHUNbyvhu
         MQVz94LADs5DhKyG/bAbkh9BH6e/8Q582GX0aDakt4yJmcgt4j92wubXOjBh58GXTfQu
         Zt73ohWGL8wxI0ffb/d9gbgE2UfGe4+nZ/8w5esJexNpVKqWBmUzgTTSR+zVC64PRdnh
         Sh1nuCUgaO3+nHttfG6HCeh+Gg1tLp/jGI0tPTflhd6kTU53ELKifVwHb0dNZ/7AkUv6
         4aKg==
X-Gm-Message-State: AOAM532wsrHdGOKTf1UkVolly4iJM3kO57r3SkNvIQ7Hgg0MplU6hICN
        DSD8UR0jrD8IqkWZlsuyVhr9hw==
X-Google-Smtp-Source: ABdhPJz5Rh7kl/Qmsw94wje1ybpjrWIrJOZK6nmPmOSK0wO9kOPxrZ/uQPaOu8GHINr/LGkKYgsdZg==
X-Received: by 2002:a62:ce06:0:b0:44b:b8f7:4b83 with SMTP id y6-20020a62ce06000000b0044bb8f74b83mr1067252pfg.10.1632832968519;
        Tue, 28 Sep 2021 05:42:48 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s17sm10055287pge.50.2021.09.28.05.42.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:42:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 2/5] mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
Date:   Tue, 28 Sep 2021 20:41:49 +0800
Message-Id: <20210928124152.33634-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210928124152.33634-1-songmuchun@bytedance.com>
References: <20210928124152.33634-1-songmuchun@bytedance.com>
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

