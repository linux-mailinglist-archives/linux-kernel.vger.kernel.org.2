Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375E340F08D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbhIQDzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244106AbhIQDys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:54:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56208C061766
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:27 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id v1so5256322plo.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTxY68Ufdm8UNqRMLWBsmc/KZ1S77UCqKKx7OF0ikR0=;
        b=LQ9nA+W3wSxOR7xZ474CGNgBcGrd1BIpSguaUrKsFyLhTaoslBzbnnnlCDs4Mt5udu
         hoecHN/AqwbODexKb4BBBgI5z6TeSrowqKADJ+IMHGNn4MW+Dmy3SQKo7P5BHUQRiiEB
         gdMuhZS8DTqgKUcKS4vGn0Qn3kwVVtYggZLbegSpqZy6BoE2O59+yskSJn3nYtKz/CvX
         /Nq0SKyUq9BpYWX0FDsU5DMoLPmfZYqBPpp4hEaQxikU57l++QpAavXkmLs+Q5f2w2bh
         1g2pOb7J5TE9cmZ2OhGLgOS8ym3LnnUXwBdkEYIgWpxM8D3BWSl7YyDnLUUQ4jcvDFII
         hnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTxY68Ufdm8UNqRMLWBsmc/KZ1S77UCqKKx7OF0ikR0=;
        b=Gvfr57QWWDwyGcyMkb4029/3EBQh+4darS/1RiIFp6hYQH1PYf2aQy7hxsbqkg9U21
         /CzSiOWEaEKiZYSVlWkmWGzRYpwwtiIVYfuTjBH8dX4dSQTnOki/8AlihxjsqGzR1Rh/
         6CQLEss8vljwgJ/hEMSm/6X3ymyRX/cZg8dHKumGt+XYGFAEEOXgpvGA5X/eJ/dEdbJB
         ZGROP3k/q2qSH0TUCTypw4yIE+RvGuNl6LMB2QhANhs4u9nGXf05cBsuVu7AitPUiNcH
         0hRdpQb9fVtte6i+yGPYS4PcEuXm3VHi6HQ40hHpb7NnN7cLLK6qddSHzVtileTbEVss
         yoaw==
X-Gm-Message-State: AOAM5301IZ7gCrrskqLFfI387/XptXbpe05d788GCERPudwYSewxzmyC
        +XCKobOloADiA6jUap/oMR0Phw==
X-Google-Smtp-Source: ABdhPJzyLYofu0O3pVXPfpDvq5aDxDGFtaZHYS+cZ3rJOmnnqAcKP4GWumAMa+/z8lSNcXSk65Vjbw==
X-Received: by 2002:a17:90a:bf82:: with SMTP id d2mr10003439pjs.201.1631850806876;
        Thu, 16 Sep 2021 20:53:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id g12sm8997704pja.28.2021.09.16.20.53.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 20:53:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RESEND v2 2/4] mm: hugetlb: replace hugetlb_free_vmemmap_enabled with a static_key
Date:   Fri, 17 Sep 2021 11:48:13 +0800
Message-Id: <20210917034815.80264-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210917034815.80264-1-songmuchun@bytedance.com>
References: <20210917034815.80264-1-songmuchun@bytedance.com>
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

