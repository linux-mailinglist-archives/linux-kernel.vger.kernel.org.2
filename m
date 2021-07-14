Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A341D3C816D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238769AbhGNJYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238743AbhGNJYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:24:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D8FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:16 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x16so1460617pfa.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkdbfyChYU3bqFZgwG+U5i+8HOhTg3puUmTJxwvU+7E=;
        b=U6HfgZ+T/eT56e1XbZEvevYHqqXpNVMhY4FWPTeZZeapWt4nKyvve9g7cSTGlRaEgx
         Pz/ACDbeddOp2tDYW6pgVgxNjM3yy76a14fwbXT+0hznC6V0PQAicWAhywPZzR3ZvB+t
         M2RyXS+z6J8shiA0tuFWYJv+L0F+EjgqHmshUyXV8DH5Gi8HxShdiciPI6HbL7DHkSb+
         KxtUS6NJP6NWxkhn+G0mViqf0S6oeZ2DnaaLhSUxg90Z+r/23t6OIUyxKThlnr3ZMlaS
         Pdd/itKuHLZlLFy4Uc6Z1SK4qnvVculUrR0+MLUJf6lic7Vv2JPnEcAC5a0wlhQgRSjS
         fbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CkdbfyChYU3bqFZgwG+U5i+8HOhTg3puUmTJxwvU+7E=;
        b=GVxigxY42xDTdKGVFiugLl+drVYtonfEOGmIkFj9ora3l/y3kYuasHL2t0O5/PlTcS
         820pWkNMiCIaspRFt0GyjIkdMiBZ45m9NN8oTml+Sf//HJvYUIgTlNeuiQ3TuPAC5Ruc
         E5z2BNu28syNBW+xiWqfvD44tnYSeWJ87BzZs72i8ZwzM+QdUwioGdwTWMNLdSoMszNr
         tZT7BYbCCuYNYQQj+CCDOtkFaCCktsPBQdZlLkMy7Kqyg7FpTxg5smdpOaGSk60y0g2+
         ZVsglYZeohtEGNGPuSE/TYvPNfjdDTt1JmjqZmQLJ9iQENB0IF8nGH/1w8y5ZhH/TU8d
         Njeg==
X-Gm-Message-State: AOAM530h3yDo9LU1msxivKLbIh72zL4MQzg2eRY0YMK6Sme12Qzpsu6J
        e09gsPetnWek8UhtyVYY+t3mKA==
X-Google-Smtp-Source: ABdhPJzoLfhTDsf9vvjpt27Db4UVjn18L2E3wvZk35t27v/G6ikZT65cAao/86OzOUyqtO55T+nmdA==
X-Received: by 2002:a65:690a:: with SMTP id s10mr6674972pgq.99.1626254475855;
        Wed, 14 Jul 2021 02:21:15 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k19sm1742540pji.32.2021.07.14.02.21.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:21:15 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 4/5] mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
Date:   Wed, 14 Jul 2021 17:17:59 +0800
Message-Id: <20210714091800.42645-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210714091800.42645-1-songmuchun@bytedance.com>
References: <20210714091800.42645-1-songmuchun@bytedance.com>
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
 mm/hugetlb_vmemmap.c       | 13 +++++++------
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f7ca1a3870ea..876a1af73bec 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -1057,7 +1057,11 @@ static inline void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr
 #endif	/* CONFIG_HUGETLB_PAGE */
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+			 hugetlb_free_vmemmap_enabled_key);
+#define hugetlb_free_vmemmap_enabled					 \
+	static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON, \
+			    &hugetlb_free_vmemmap_enabled_key)
 #else
 #define hugetlb_free_vmemmap_enabled	false
 #endif
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index d29c16f7b176..f05f806b98b4 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -183,7 +183,8 @@ enum pageflags {
 #ifndef __GENERATING_BOUNDS_H
 
 #ifdef CONFIG_HUGETLB_PAGE_FREE_VMEMMAP
-extern bool hugetlb_free_vmemmap_enabled;
+DECLARE_STATIC_KEY_MAYBE(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+			 hugetlb_free_vmemmap_enabled_key);
 
 /*
  * If the feature of freeing some vmemmap pages associated with each HugeTLB
@@ -222,7 +223,8 @@ extern bool hugetlb_free_vmemmap_enabled;
  */
 static __always_inline struct page *page_head_if_fake(const struct page *page)
 {
-	if (!hugetlb_free_vmemmap_enabled)
+	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+				 &hugetlb_free_vmemmap_enabled_key))
 		return NULL;
 
 	/*
diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 527bcaa44a48..a382e12f6ff0 100644
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
 
@@ -284,7 +284,8 @@ void __init hugetlb_vmemmap_init(struct hstate *h)
 	BUILD_BUG_ON(__NR_USED_SUBPAGE >=
 		     RESERVE_VMEMMAP_SIZE / sizeof(struct page));
 
-	if (!hugetlb_free_vmemmap_enabled)
+	if (!static_branch_maybe(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON,
+				 &hugetlb_free_vmemmap_enabled_key))
 		return;
 
 	vmemmap_pages = (nr_pages * sizeof(struct page)) >> PAGE_SHIFT;
-- 
2.11.0

