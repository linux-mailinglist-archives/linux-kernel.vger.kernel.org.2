Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE66E387A74
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343913AbhERNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:55:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3587 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbhERNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:55:18 -0400
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fky8K0P3kzsRDD;
        Tue, 18 May 2021 21:51:13 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 21:53:58 +0800
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 18
 May 2021 21:53:57 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 1/5] mm/swapfile: move get_swap_page_of_type() under CONFIG_HIBERNATION
Date:   Tue, 18 May 2021 21:53:48 +0800
Message-ID: <20210518135352.3705306-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210518135352.3705306-1-linmiaohe@huawei.com>
References: <20210518135352.3705306-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should move get_swap_page_of_type() under CONFIG_HIBERNATION since the
only caller of this function is now suspend routine.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2aad85751991..4e7628b82e63 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1137,30 +1137,6 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	return n_ret;
 }
 
-/* The only caller of this function is now suspend routine */
-swp_entry_t get_swap_page_of_type(int type)
-{
-	struct swap_info_struct *si = swap_type_to_swap_info(type);
-	pgoff_t offset;
-
-	if (!si)
-		goto fail;
-
-	spin_lock(&si->lock);
-	if (si->flags & SWP_WRITEOK) {
-		/* This is called for allocating swap entry, not cache */
-		offset = scan_swap_map(si, 1);
-		if (offset) {
-			atomic_long_dec(&nr_swap_pages);
-			spin_unlock(&si->lock);
-			return swp_entry(type, offset);
-		}
-	}
-	spin_unlock(&si->lock);
-fail:
-	return (swp_entry_t) {0};
-}
-
 static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
 {
 	struct swap_info_struct *p;
@@ -1812,6 +1788,30 @@ int free_swap_and_cache(swp_entry_t entry)
 }
 
 #ifdef CONFIG_HIBERNATION
+
+swp_entry_t get_swap_page_of_type(int type)
+{
+	struct swap_info_struct *si = swap_type_to_swap_info(type);
+	pgoff_t offset;
+
+	if (!si)
+		goto fail;
+
+	spin_lock(&si->lock);
+	if (si->flags & SWP_WRITEOK) {
+		/* This is called for allocating swap entry, not cache */
+		offset = scan_swap_map(si, 1);
+		if (offset) {
+			atomic_long_dec(&nr_swap_pages);
+			spin_unlock(&si->lock);
+			return swp_entry(type, offset);
+		}
+	}
+	spin_unlock(&si->lock);
+fail:
+	return (swp_entry_t) {0};
+}
+
 /*
  * Find the swap type that corresponds to given device (if any).
  *
-- 
2.23.0

