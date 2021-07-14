Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64DA93C816F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 11:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhGNJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbhGNJYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 05:24:14 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798E0C061760
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:22 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u3so1194088plf.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 02:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0sSF06QuAY7kUNXCT+H8hO7WNAzsL+XHoJo4uKapYUQ=;
        b=hWbxjhh0bB5B6m4rcT6U6l1KYThmR4c2fqxERQD3zKLqXkWJMG/SysrhsRf+SH6gzN
         JEvfZCrpYNToVVx1FkVeze7w0t73ZfLF5XBrOqO7WP6KJN+q2Tx8Es0D/dBSjxvxJra9
         W3IWsb4howhaF1lP3TRBoD8r+btX3cApquQw7dBUSWmYpU+t2e+xBLLJPwv5crFsoxqn
         QwJKXSegIhAsNoxYnw+UkwIfkHX7fs+RO0mU8Pfyir0agDJugBedGS3RoIyyGn9qYyT5
         hggFWsM8Dbszg55bzNtvl5DFHAcfG1OGjoELlI2kE8QKY+CKDEJS5v2xnv37+xjmmq4L
         HT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0sSF06QuAY7kUNXCT+H8hO7WNAzsL+XHoJo4uKapYUQ=;
        b=gTQNYP5xK3HKcmy9/EW1ySoCH01bdVIEaIIW+uTDpEV2UwiFRNNPfaBqcFpLk941Bp
         oC0jqVYB5Y/Id2xbOEN3RS/o9+Q10O+v2rdkmoL6XVDurhBsg6GWGO1hBjK+m2pIC3dz
         USOdmlBDmHxyqODhRRm/zH1jJT0LC+YvDamHgIx5NGvKLn3yquyorgh9eBcWx/sHf9fQ
         08IUz7HXkd+7xTG97nlCMTQa96G51e1YZ0reMMYklZQvaBOYs1Wyog9viiWdrE+Srh2/
         FdukvAX9+jIyPJpahU+SHR0odHSKLtjThxrHXL0xe7EARtPGdFMGtQAihVWQgnW98n0z
         YnqQ==
X-Gm-Message-State: AOAM531GDT1CeQPa98PErhkgXUloHyDUaVHrTu0NZMuLxJH9vsdIADWK
        1jwzh6Pcb/Qa3rAQrIYW+RTAVw==
X-Google-Smtp-Source: ABdhPJxDHd9SN5fagjQhrWthsjzWABX4QS3GgblMv9qSYLWRITZkU4ZRFkOcw5Ylui6X2JqBjrTSLA==
X-Received: by 2002:a17:903:2309:b029:12a:965b:333 with SMTP id d9-20020a1709032309b029012a965b0333mr6943494plh.31.1626254481985;
        Wed, 14 Jul 2021 02:21:21 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k19sm1742540pji.32.2021.07.14.02.21.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jul 2021 02:21:21 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, zhengqi.arch@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 5/5] mm: sparsemem: use page table lock to protect kernel pmd operations
Date:   Wed, 14 Jul 2021 17:18:00 +0800
Message-Id: <20210714091800.42645-6-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210714091800.42645-1-songmuchun@bytedance.com>
References: <20210714091800.42645-1-songmuchun@bytedance.com>
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

