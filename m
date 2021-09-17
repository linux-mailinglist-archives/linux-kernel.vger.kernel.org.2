Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A80540F08E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244180AbhIQDzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244137AbhIQDy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:54:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3238C061756
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:34 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id i19so6020995pjv.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sSF06QuAY7kUNXCT+H8hO7WNAzsL+XHoJo4uKapYUQ=;
        b=d7oXrFiwLxVl+QDJ45TJCHO5rPPOJ2J06Arj3E0JjwACw0Dzonyj496/iRL70tZEDA
         EuMPSdakZAHG4X7Asun5/fVzg3bkWJSWwtxDmn5Kum7iE/HjaWn6uT0uMDF+zvs7kFQV
         Fo+486EroYVFtkeRBIfqdRyaEP/UhMoLjrUflG66vgHfx6hkt2W/XjH3faoPkuqAefDn
         Ie3bhXqjZ1moLpvRO2MpiVy2lqQ99Eazh0N3zb33Fn6VtvSPYqDDCSC8QqfCeDgMNIAN
         dK4HcE3O08fpgg1M1uUJ7UISwDj0Bz7ej7N02lZZy3jq2FRa/zKINPHrX9YAQQXNiwQn
         dqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sSF06QuAY7kUNXCT+H8hO7WNAzsL+XHoJo4uKapYUQ=;
        b=LMPi7voQr/KqetGkcGkI0+dl6ItINijp6U3MSsBc9qVxeg8PKrnC7QE6lr3406Zkmi
         dWSH3WK50xXqJFpTNDLp824UXgzESrFLhiyDE0JNOd6cnYAx7h48I8biaEQ1kIQgPHFy
         xbndIAEwTUszQutgvrya5Cc7BEbo/EmauUldBDCtZaM7qELcWNb29bBU2WHVHJm4qSZi
         Y6KMbq2myQ7bLED96/FQPfw59fZonsP8B7cDZMbnNRDESMT95zXh5HBOJop8smKWDFko
         eCVL/KuHOxYlNbObUV7WFjmNJ6h6qRmUJ2EL5AqRE8IYzJ5C9UEzthzXsR8a9L57gMy9
         u/Sg==
X-Gm-Message-State: AOAM533Eulj7sE2dg+pcQGI9HZbMoGdbEp8Qtz2i3ywgtc+LP1zCBkoL
        PTFiy6uvbI3c1XUie71ZZ1qHZQ==
X-Google-Smtp-Source: ABdhPJysLWSTpZBBnsGr+SwefgGTH706NuJHGHNEwUSjRTb/TLYCvvsWcEu/i1vl1i9/i/l/6KUu5g==
X-Received: by 2002:a17:902:6b0b:b0:13a:18bf:1ece with SMTP id o11-20020a1709026b0b00b0013a18bf1ecemr7744262plk.49.1631850814182;
        Thu, 16 Sep 2021 20:53:34 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id g12sm8997704pja.28.2021.09.16.20.53.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 20:53:33 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RESEND v2 3/4] mm: sparsemem: use page table lock to protect kernel pmd operations
Date:   Fri, 17 Sep 2021 11:48:14 +0800
Message-Id: <20210917034815.80264-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210917034815.80264-1-songmuchun@bytedance.com>
References: <20210917034815.80264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The init_mm.page_table_lock is used to protect kernel page tables, we
can use it to serialize splitting vmemmap PMD mappings instead of mmap
write lock, which can increase the concurrency of vmemmap_remap_free().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/ptdump.c         | 16 ++++++++++++----
 mm/sparse-vmemmap.c | 49 ++++++++++++++++++++++++++++++++++---------------
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index da751448d0e4..eea3d28d173c 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -40,8 +40,10 @@ static int ptdump_pgd_entry(pgd_t *pgd, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 0, pgd_val(val));
 
-	if (pgd_leaf(val))
+	if (pgd_leaf(val)) {
 		st->note_page(st, addr, 0, pgd_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
@@ -61,8 +63,10 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 1, p4d_val(val));
 
-	if (p4d_leaf(val))
+	if (p4d_leaf(val)) {
 		st->note_page(st, addr, 1, p4d_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
@@ -82,8 +86,10 @@ static int ptdump_pud_entry(pud_t *pud, unsigned long addr,
 	if (st->effective_prot)
 		st->effective_prot(st, 2, pud_val(val));
 
-	if (pud_leaf(val))
+	if (pud_leaf(val)) {
 		st->note_page(st, addr, 2, pud_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
@@ -101,8 +107,10 @@ static int ptdump_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	if (st->effective_prot)
 		st->effective_prot(st, 3, pmd_val(val));
-	if (pmd_leaf(val))
+	if (pmd_leaf(val)) {
 		st->note_page(st, addr, 3, pmd_val(val));
+		walk->action = ACTION_CONTINUE;
+	}
 
 	return 0;
 }
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 62e3d20648ce..e636943ccfc4 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -64,8 +64,8 @@ struct vmemmap_remap_walk {
  */
 #define NR_RESET_STRUCT_PAGE		3
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
-				  struct vmemmap_remap_walk *walk)
+static int __split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
+				    struct vmemmap_remap_walk *walk)
 {
 	pmd_t __pmd;
 	int i;
@@ -87,15 +87,37 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
 		set_pte_at(&init_mm, addr, pte, entry);
 	}
 
-	/* Make pte visible before pmd. See comment in __pte_alloc(). */
-	smp_wmb();
-	pmd_populate_kernel(&init_mm, pmd, pgtable);
+	spin_lock(&init_mm.page_table_lock);
+	if (likely(pmd_leaf(*pmd))) {
+		/* Make pte visible before pmd. See comment in __pte_alloc(). */
+		smp_wmb();
+		pmd_populate_kernel(&init_mm, pmd, pgtable);
+		flush_tlb_kernel_range(start, start + PMD_SIZE);
+		spin_unlock(&init_mm.page_table_lock);
 
-	flush_tlb_kernel_range(start, start + PMD_SIZE);
+		return 0;
+	}
+	spin_unlock(&init_mm.page_table_lock);
+	pte_free_kernel(&init_mm, pgtable);
 
 	return 0;
 }
 
+static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start,
+				  struct vmemmap_remap_walk *walk)
+{
+	int ret;
+
+	spin_lock(&init_mm.page_table_lock);
+	ret = pmd_leaf(*pmd);
+	spin_unlock(&init_mm.page_table_lock);
+
+	if (ret)
+		ret = __split_vmemmap_huge_pmd(pmd, start, walk);
+
+	return ret;
+}
+
 static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
 			      unsigned long end,
 			      struct vmemmap_remap_walk *walk)
@@ -132,13 +154,12 @@ static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
 
 	pmd = pmd_offset(pud, addr);
 	do {
-		if (pmd_leaf(*pmd)) {
-			int ret;
+		int ret;
+
+		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
+		if (ret)
+			return ret;
 
-			ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK, walk);
-			if (ret)
-				return ret;
-		}
 		next = pmd_addr_end(addr, end);
 		vmemmap_pte_range(pmd, addr, next, walk);
 	} while (pmd++, addr = next, addr != end);
@@ -321,10 +342,8 @@ int vmemmap_remap_free(unsigned long start, unsigned long end,
 	 */
 	BUG_ON(start - reuse != PAGE_SIZE);
 
-	mmap_write_lock(&init_mm);
+	mmap_read_lock(&init_mm);
 	ret = vmemmap_remap_range(reuse, end, &walk);
-	mmap_write_downgrade(&init_mm);
-
 	if (ret && walk.nr_walked) {
 		end = reuse + walk.nr_walked * PAGE_SIZE;
 		/*
-- 
2.11.0

