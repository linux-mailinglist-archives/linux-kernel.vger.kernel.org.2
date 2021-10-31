Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE2C440D4E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 07:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhJaGFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 02:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbhJaGFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 02:05:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD23DC061570
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 23:03:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id l10-20020a17090a4d4a00b001a678eed8abso369258pjh.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Oct 2021 23:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3JMpCir9O4C/+thkZw6Zp6gl8Z+qWlXpOixuNSACOM=;
        b=Xq6L/JDAA3Boh5ndh2fn/fmAsa7ZlJF0yUbCiqEnnKo1tB159gyltguxW82Z1Q2Cxd
         LrW7WutTsy3FhhIgXNByQ8K+HAt/geNDb931DgYPFYTCf4WEEgKZTIzS7At5kgRqEOeN
         9evU8JbhRhriCeDFS6EG78MKTbfyNM7sPG/dknVoEtKBoxnvlaMleM33hcr/552S25lm
         wJO8V02JBMCAGYe/HwbzjTxwFrGghj+VkHBLZ92EJrlrLAsQzlQkyzRFIvRB3PNRWVrW
         ytjOk5ihXml8K9w0LXs01aYhAD7ZdGGlNVLLvdJ6sTSABxcR5uReflr2hDFGjiHJA/L9
         wuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N3JMpCir9O4C/+thkZw6Zp6gl8Z+qWlXpOixuNSACOM=;
        b=HpQukLrLUJFyh1F2cPdm/ZE2n19eAiq0o2dscgozOaCQ0stLS1bcubGO2fWRhSUJTg
         bhtjfg1lC7BnaD+lFZNK1SSWDcxMfJ0Q+jJ8Q217Vm+E3JHMJHHEhMgjpOxLRBwRAPKa
         ZIHGiKDHiuutVhZLHg3yl5xBE8MppMgK/1LRQSy1/3R4RZRXWXz5t38CeUMMC7Al9Y8V
         SoCRapfbFSDdBkc+AAEyW17NT0DLTN7gi+edKcrvBUJqV2XGxdw5TdWsBUf1BjDyg62/
         Iq8nbsLYgnz1tEGSyJ7OxbHlLTSC2CLU8jCB0rYNLPvVD4yXZHu4D2iUv5kbac6R/8MZ
         V0gA==
X-Gm-Message-State: AOAM531eNIRg+pYGW2v1iBbyLqIOorNJMYtMPS0o1G8kk6b5GjCKXF5l
        YRGX88cKulhBORVGMUDM+U1EOGCelmZ902K3
X-Google-Smtp-Source: ABdhPJzBGkGvZNbuit6l1si3F3U8jdJE0C5HhOx5F7h40YZSEZTLXwi9HOnCuhiV2OvWKC22ppUueg==
X-Received: by 2002:a17:902:bb96:b0:13f:b181:58ef with SMTP id m22-20020a170902bb9600b0013fb18158efmr18566958pls.2.1635660196272;
        Sat, 30 Oct 2021 23:03:16 -0700 (PDT)
Received: from ubuntu.localdomain ([103.121.208.77])
        by smtp.gmail.com with ESMTPSA id r14sm9553813pgf.49.2021.10.30.23.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Oct 2021 23:03:16 -0700 (PDT)
From:   Quanfa Fu <fuqf0919@gmail.com>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Quanfa Fu <fuqf0919@gmail.com>
Subject: [PATCH] writeback: Fix some comment errors
Date:   Sun, 31 Oct 2021 14:03:02 +0800
Message-Id: <20211031060302.146914-1-fuqf0919@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Quanfa Fu <fuqf0919@gmail.com>
---
 mm/khugepaged.c     | 2 +-
 mm/memory-failure.c | 4 ++--
 mm/slab_common.c    | 2 +-
 mm/swap.c           | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8a8b3aa92937..f482a7861141 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1306,7 +1306,7 @@ static int khugepaged_scan_pmd(struct mm_struct *mm,
 		/*
 		 * Record which node the original page is from and save this
 		 * information to khugepaged_node_load[].
-		 * Khupaged will allocate hugepage from the node has the max
+		 * Khugepaged will allocate hugepage from the node has the max
 		 * hit record.
 		 */
 		node = page_to_nid(page);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index bdbbb32211a5..21fa983e52e4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1227,7 +1227,7 @@ static int get_any_page(struct page *p, unsigned long flags)
  *
  * get_hwpoison_page() takes a page refcount of an error page to handle memory
  * error on it, after checking that the error page is in a well-defined state
- * (defined as a page-type we can successfully handle the memor error on it,
+ * (defined as a page-type we can successfully handle the memory error on it,
  * such as LRU page and hugetlb page).
  *
  * Memory error handling could be triggered at any time on any type of page,
@@ -1653,7 +1653,7 @@ int memory_failure(unsigned long pfn, int flags)
 
 	/*
 	 * We need/can do nothing about count=0 pages.
-	 * 1) it's a free page, and therefore in safe hand:
+	 * 1) it's a freed page, and therefore in safe hand:
 	 *    prep_new_page() will be the gate keeper.
 	 * 2) it's part of a non-compound high order page.
 	 *    Implies some kernel user: cannot stop them from
diff --git a/mm/slab_common.c b/mm/slab_common.c
index ec2bb0beed75..e845a8286f2c 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -832,7 +832,7 @@ void __init setup_kmalloc_cache_index_table(void)
 
 	if (KMALLOC_MIN_SIZE >= 64) {
 		/*
-		 * The 96 byte size cache is not used if the alignment
+		 * The 96 byte sized cache is not used if the alignment
 		 * is 64 byte.
 		 */
 		for (i = 64 + 8; i <= 96; i += 8)
diff --git a/mm/swap.c b/mm/swap.c
index af3cad4e5378..0ab1aa4a79b6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -866,7 +866,7 @@ void lru_cache_disable(void)
 	 * all online CPUs so any calls of lru_cache_disabled wrapped by
 	 * local_lock or preemption disabled would be ordered by that.
 	 * The atomic operation doesn't need to have stronger ordering
-	 * requirements because that is enforeced by the scheduling
+	 * requirements because that is enforced by the scheduling
 	 * guarantees.
 	 */
 	__lru_add_drain_all(true);
-- 
2.25.1

