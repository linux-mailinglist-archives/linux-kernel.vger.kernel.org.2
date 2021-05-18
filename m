Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4D387A75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbhERNzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:55:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4736 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245500AbhERNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:55:18 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fky7V67MgzqVCQ;
        Tue, 18 May 2021 21:50:30 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 21:53:59 +0800
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 18
 May 2021 21:53:58 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/5] mm/swap: simplify the code of find_get_incore_page()
Date:   Tue, 18 May 2021 21:53:52 +0800
Message-ID: <20210518135352.3705306-6-linmiaohe@huawei.com>
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

pagecache_get_page() can do find_subpage() for us if we do not specify
FGP_HEAD. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index a55b7b74b0e6..bc92e4893fec 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -394,13 +394,11 @@ struct page *find_get_incore_page(struct address_space *mapping, pgoff_t index)
 {
 	swp_entry_t swp;
 	struct swap_info_struct *si;
-	struct page *page = pagecache_get_page(mapping, index,
-						FGP_ENTRY | FGP_HEAD, 0);
+	struct page *page = pagecache_get_page(mapping, index, FGP_ENTRY, 0);
 
-	if (!page)
+	if (!page || !xa_is_value(page))
 		return page;
-	if (!xa_is_value(page))
-		return find_subpage(page, index);
+
 	if (!shmem_mapping(mapping))
 		return NULL;
 
-- 
2.23.0

