Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20843F13F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbhHSHCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 03:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232735AbhHSHCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 03:02:05 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABFCC061756
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:01:29 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e7so4975698pgk.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 00:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTxY68Ufdm8UNqRMLWBsmc/KZ1S77UCqKKx7OF0ikR0=;
        b=udSVxlwMVtCgOdal9skEcrtOOlkbpjElZ0fwLOo8FwTTHT/Jnxl5qRS//fZ+inFeq4
         N6U7m4ES00lY1g5Z3nWRJfQISLuH9mIWJkadx3e5lZRPgwjcsKr+nZbLba83Gqh5MrUe
         LVIOKysRnfasE0FG2JvPu1aoqc/k41nHT5qNQ7/bwHmx92z2o/Ewg+mIzMcD10ng3GMa
         pldchSUP694vbNs590DJbMGSx4cVT7R4kbvTonTKSkCeZ23CLFCa4RjfpGw2o142Cdvt
         4o86NswXubR6AROFGWZ4FzR0zWuXqtYb+mTvoWHt8RuRgrfQ5JZjhYC/+VbK0V3Vtc32
         xn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTxY68Ufdm8UNqRMLWBsmc/KZ1S77UCqKKx7OF0ikR0=;
        b=DxVo2yhAoGBKhIrAzJbKh6Qb0P/f1x6lNPDrGFsroakcH97X/M6E7rCK1zBSKKbQ+a
         RgNLqxSJgpFQOh8TlRbgYyiHkKKHbyCi7GIJur/yuDdyqRWVjXyTp65HdrNE1eDyblFj
         B+5d4c6bmHssS6M30hwUa3iV8WtmYF+53R7gqa9SsDaynvJQh54djChgaL7Vce0IBVoz
         zRDfmSmFVCPRKrtS5ND9B3Fw2MzvKlOJtylfczXOcq45uMqczSZROiGCxXOGDGBmjbsc
         ZdCMP+dUSgnyPoMqgH3aAIp7LTsrAn++GPBMQxTS2+wpW+OTtPhjcChXT3mqUu35COr9
         cB/A==
X-Gm-Message-State: AOAM530Eb7E0YArK3gxETqvrZMxjO+9O3VUYQ6Kw4ADzyuHGnC7mS7Jj
        yrHdBCa8U6e1qgSLJkLOdO/JZw==
X-Google-Smtp-Source: ABdhPJz6BNvUtnn0IBiNO/ph123G8mcdkJEcNpmKIzPsWUA724ZXomsEWhuBZTvbLwPKu0WhJiQCVA==
X-Received: by 2002:aa7:86d5:0:b0:3e1:abc7:890b with SMTP id h21-20020aa786d5000000b003e1abc7890bmr13279465pfo.4.1629356489253;
        Thu, 19 Aug 2021 00:01:29 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id t30sm2490395pgl.47.2021.08.19.00.01.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Aug 2021 00:01:28 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
Date:   Thu, 19 Aug 2021 14:58:29 +0800
Message-Id: <20210819065831.43186-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210819065831.43186-1-songmuchun@bytedance.com>
References: <20210819065831.43186-1-songmuchun@bytedance.com>
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
 include/linux/hugetlb.h    |  6 +++++-
 include/linux/page-flags.h |  6 ++++--
 mm/hugetlb_vmemmap.c       | 10 +++++-----
 3 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a3870ea..ee3ddf3d12cf 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1057,7 +1057,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+			 hugetlb_free_vmemmap_enabled_key);
+#define hugetlb_free_vmemmap_enabled					 \
+	static_key_enabled(&hugetlb_free_vmemmap_enabled_key)
+
 #else
 #define hugetlb_free_vmemmap_enabled	false
 #endif
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 7b1a918ebd43..d68d2cf30d76 100644
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
@@ -204,7 +205,8 @@ extern bool hugetlb_free_vmemmap_enabled;
  */
 static __always_inline const struct page *page_head_if_fake(const struct page *page)
 {
-	if (!hugetlb_free_vmemmap_enabled)
+	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+				 &hugetlb_free_vmemmap_enabled_key))
 		return page;
 
 	/*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 527bcaa44a48..5b80129c684c 100644
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
 
-- 
2.11.0

