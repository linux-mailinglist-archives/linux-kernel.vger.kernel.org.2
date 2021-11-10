Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97A444BD1F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 09:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhKJIo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 03:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhKJIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 03:44:27 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FC7C061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:41:40 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id f20-20020a17090a639400b001a772f524d1so1043374pjj.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 00:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2uW/yCeCX04tsKzmi9YATgmqhnOC3lon0JZ/8HxInXE=;
        b=PC+0ptR3CRoiOYcuGEmuCfx1B/fVgoY+9n0GDJwvB0oHxq/KL0GzNuaNhQWJfTxdbu
         8iQm+guscstXIodBn6FwCjrPmfhOfjR+syyiUsqg0Tn9NxACOneyl4y2Ul6SnMgLFnXk
         5PWxJOUo97aTooEHI1WGfcZOiR7Bju7rK6pVN9/peaGEJtze+F9+3tHZRiYygTWMcw1w
         krsleb0BfFAYoSOaXKwuXtRqNzkeyZ3gM8EsE3+sS6PB32wayzedhbRsCtS4JcEvHwuP
         WvJOiI/Hq68rpmjTlfItIauKn++7RGwbuKWwoYXOP9rO59iABWDh1PpN4VkN/AgXK+Jp
         5cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2uW/yCeCX04tsKzmi9YATgmqhnOC3lon0JZ/8HxInXE=;
        b=sKrkjDweRY//lXSEXc8fquDSy75vtf8eSVMBIx/KhX5JhnAo4HiAkY+d9X4Xir6d6T
         CVhW0Pxp1rrdG5aQmmsIHhYeKB6lcc5N5wequHxzAWIXxBevu0R5MIt6gL43Qx7msJ6U
         x9f45dqFU3NQaHnDmn/6BuTb71zat6ak38o962ANyVRqwE/KcukkwPeZZ70AdcykFJIK
         Kp5XKqIY1Q9nw7M/x0ubXD3lbGn6E8IIgjsBJN3NRglPylxzdLu5xhfkBQhGZTRk8bEJ
         dw0YSXfMZggaB5CcmDqjtVT1/Pw1FqmnCVglTZyGgYWdykUcKkG3P3+VP/zG7yheFVTC
         6AXA==
X-Gm-Message-State: AOAM531m33Jg71vdlWkpNzIUnTnObPHDPahGdPzSojW78akKhot9ercg
        KwQU35YWCsCfTXCOb+HC5X56mOpbOZ85cQ==
X-Google-Smtp-Source: ABdhPJxDUHb3N0EB7fBRSwo8sSEnmyV/FEoadE7ZqM0uRUd7DpuLRPGmQQH7K5eaSOY8PlhYWxmgaw==
X-Received: by 2002:a17:90a:e389:: with SMTP id b9mr14737638pjz.235.1636533699652;
        Wed, 10 Nov 2021 00:41:39 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id v38sm5485368pgl.38.2021.11.10.00.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Nov 2021 00:41:39 -0800 (PST)
From:   Qi Zheng <zhengqi.arch@bytedance.com>
To:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, songmuchun@bytedance.com,
        zhouchengming@bytedance.com, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 02/15] mm: introduce is_huge_pmd() helper
Date:   Wed, 10 Nov 2021 16:40:44 +0800
Message-Id: <20211110084057.27676-3-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
References: <20211110084057.27676-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we have some times the following judgments repeated in the
code:

	is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)

which is to determine whether the *pmd is a huge pmd, so introduce
is_huge_pmd() helper to deduplicate them.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/huge_mm.h | 10 +++++++---
 mm/huge_memory.c        |  3 +--
 mm/memory.c             |  5 ++---
 mm/mprotect.c           |  2 +-
 mm/mremap.c             |  3 +--
 5 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index f280f33ff223..b37a89180846 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -199,8 +199,7 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 #define split_huge_pmd(__vma, __pmd, __address)				\
 	do {								\
 		pmd_t *____pmd = (__pmd);				\
-		if (is_swap_pmd(*____pmd) || pmd_trans_huge(*____pmd)	\
-					|| pmd_devmap(*____pmd))	\
+		if (is_huge_pmd(*____pmd))				\
 			__split_huge_pmd(__vma, __pmd, __address,	\
 						false, NULL);		\
 	}  while (0)
@@ -232,11 +231,16 @@ static inline int is_swap_pmd(pmd_t pmd)
 	return !pmd_none(pmd) && !pmd_present(pmd);
 }
 
+static inline int is_huge_pmd(pmd_t pmd)
+{
+	return is_swap_pmd(pmd) || pmd_trans_huge(pmd) || pmd_devmap(pmd);
+}
+
 /* mmap_lock must be held on entry */
 static inline spinlock_t *pmd_trans_huge_lock(pmd_t *pmd,
 		struct vm_area_struct *vma)
 {
-	if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd))
+	if (is_huge_pmd(*pmd))
 		return __pmd_trans_huge_lock(pmd, vma);
 	else
 		return NULL;
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5483347291c..e76ee2e1e423 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1832,8 +1832,7 @@ spinlock_t *__pmd_trans_huge_lock(pmd_t *pmd, struct vm_area_struct *vma)
 {
 	spinlock_t *ptl;
 	ptl = pmd_lock(vma->vm_mm, pmd);
-	if (likely(is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) ||
-			pmd_devmap(*pmd)))
+	if (likely(is_huge_pmd(*pmd)))
 		return ptl;
 	spin_unlock(ptl);
 	return NULL;
diff --git a/mm/memory.c b/mm/memory.c
index 855486fff526..b00cd60fc368 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1146,8 +1146,7 @@ copy_pmd_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
 	src_pmd = pmd_offset(src_pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*src_pmd) || pmd_trans_huge(*src_pmd)
-			|| pmd_devmap(*src_pmd)) {
+		if (is_huge_pmd(*src_pmd)) {
 			int err;
 			VM_BUG_ON_VMA(next-addr != HPAGE_PMD_SIZE, src_vma);
 			err = copy_huge_pmd(dst_mm, src_mm, dst_pmd, src_pmd,
@@ -1441,7 +1440,7 @@ static inline unsigned long zap_pmd_range(struct mmu_gather *tlb,
 	pmd = pmd_offset(pud, addr);
 	do {
 		next = pmd_addr_end(addr, end);
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_huge_pmd(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE)
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			else if (zap_huge_pmd(tlb, vma, pmd, addr))
diff --git a/mm/mprotect.c b/mm/mprotect.c
index e552f5e0ccbd..2d5064a4631c 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -257,7 +257,7 @@ static inline unsigned long change_pmd_range(struct vm_area_struct *vma,
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
-		if (is_swap_pmd(*pmd) || pmd_trans_huge(*pmd) || pmd_devmap(*pmd)) {
+		if (is_huge_pmd(*pmd)) {
 			if (next - addr != HPAGE_PMD_SIZE) {
 				__split_huge_pmd(vma, pmd, addr, false, NULL);
 			} else {
diff --git a/mm/mremap.c b/mm/mremap.c
index 002eec83e91e..c6e9da09dd0a 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -532,8 +532,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		new_pmd = alloc_new_pmd(vma->vm_mm, vma, new_addr);
 		if (!new_pmd)
 			break;
-		if (is_swap_pmd(*old_pmd) || pmd_trans_huge(*old_pmd) ||
-		    pmd_devmap(*old_pmd)) {
+		if (is_huge_pmd(*old_pmd)) {
 			if (extent == HPAGE_PMD_SIZE &&
 			    move_pgt_entry(HPAGE_PMD, vma, old_addr, new_addr,
 					   old_pmd, new_pmd, need_rmap_locks))
-- 
2.11.0

