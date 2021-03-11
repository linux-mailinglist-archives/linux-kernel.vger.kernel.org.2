Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F57336F48
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 10:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhCKJwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 04:52:25 -0500
Received: from lucky1.263xmail.com ([211.157.147.130]:38372 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbhCKJwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 04:52:03 -0500
Received: from localhost (unknown [192.168.167.172])
        by lucky1.263xmail.com (Postfix) with ESMTP id 81B99D10BC;
        Thu, 11 Mar 2021 17:51:48 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [124.126.19.250])
        by smtp.263.net (postfix) whith ESMTP id P11225T140489871304448S1615456220209782_;
        Thu, 11 Mar 2021 17:51:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9892b09b0797cf7069056cb2265cbecb>
X-RL-SENDER: songqiang@uniontech.com
X-SENDER: songqiang@uniontech.com
X-LOGIN-NAME: songqiang@uniontech.com
X-FST-TO: akpm@linux-foundation.org
X-SENDER-IP: 124.126.19.250
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   songqiang <songqiang@uniontech.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songqiang <songqiang@uniontech.com>
Subject: [PATCH] mm/highmem.c: fix coding style issue
Date:   Thu, 11 Mar 2021 17:50:15 +0800
Message-Id: <20210311095015.14277-1-songqiang@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete/add some blank lines and some blank spaces

Signed-off-by: songqiang <songqiang@uniontech.com>
---
 mm/highmem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/highmem.c b/mm/highmem.c
index 1352a27951e3..902154b76030 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -110,7 +110,7 @@ EXPORT_SYMBOL(_totalhigh_pages);
 
 EXPORT_PER_CPU_SYMBOL(__kmap_atomic_idx);
 
-unsigned int nr_free_highpages (void)
+unsigned int nr_free_highpages(void)
 {
 	struct zone *zone;
 	unsigned int pages = 0;
@@ -126,7 +126,7 @@ unsigned int nr_free_highpages (void)
 static int pkmap_count[LAST_PKMAP];
 static  __cacheline_aligned_in_smp DEFINE_SPINLOCK(kmap_lock);
 
-pte_t * pkmap_page_table;
+pte_t *pkmap_page_table;
 
 /*
  * Most architectures have no use for kmap_high_get(), so let's abstract
@@ -153,6 +153,7 @@ struct page *kmap_to_page(void *vaddr)
 
 	if (addr >= PKMAP_ADDR(0) && addr < PKMAP_ADDR(LAST_PKMAP)) {
 		int i = PKMAP_NR(addr);
+
 		return pte_page(pkmap_page_table[i]);
 	}
 
@@ -287,9 +288,8 @@ void *kmap_high(struct page *page)
 	pkmap_count[PKMAP_NR(vaddr)]++;
 	BUG_ON(pkmap_count[PKMAP_NR(vaddr)] < 2);
 	unlock_kmap();
-	return (void*) vaddr;
+	return (void *) vaddr;
 }
-
 EXPORT_SYMBOL(kmap_high);
 
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
@@ -314,7 +314,7 @@ void *kmap_high_get(struct page *page)
 		pkmap_count[PKMAP_NR(vaddr)]++;
 	}
 	unlock_kmap_any(flags);
-	return (void*) vaddr;
+	return (void *) vaddr;
 }
 #endif
 
@@ -367,7 +367,6 @@ void kunmap_high(struct page *page)
 	if (need_wakeup)
 		wake_up(pkmap_map_wait);
 }
-
 EXPORT_SYMBOL(kunmap_high);
 #endif	/* CONFIG_HIGHMEM */
 
@@ -431,7 +430,6 @@ void *page_address(const struct page *page)
 	spin_unlock_irqrestore(&pas->lock, flags);
 	return ret;
 }
-
 EXPORT_SYMBOL(page_address);
 
 /**
-- 
2.20.1



