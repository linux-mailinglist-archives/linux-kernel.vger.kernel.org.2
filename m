Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E21BF38B02F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 15:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238134AbhETNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 09:42:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3606 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbhETNm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 09:42:28 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fm9lf3STHzQpXR;
        Thu, 20 May 2021 21:37:34 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 21:41:05 +0800
Received: from huawei.com (10.175.104.170) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 20
 May 2021 21:41:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 2/4] mm/swap: remove unused local variable nr_shadows
Date:   Thu, 20 May 2021 21:40:20 +0800
Message-ID: <20210520134022.1370406-3-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210520134022.1370406-1-linmiaohe@huawei.com>
References: <20210520134022.1370406-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 55c653b71e8c ("mm: stop accounting shadow entries"),
nr_shadows is not used anymore.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index df5405384520..1a2ba4056f37 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -114,8 +114,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 	SetPageSwapCache(page);
 
 	do {
-		unsigned long nr_shadows = 0;
-
 		xas_lock_irq(&xas);
 		xas_create_range(&xas);
 		if (xas_error(&xas))
@@ -124,7 +122,6 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry,
 			VM_BUG_ON_PAGE(xas.xa_index != idx + i, page);
 			old = xas_load(&xas);
 			if (xa_is_value(old)) {
-				nr_shadows++;
 				if (shadowp)
 					*shadowp = old;
 			}
@@ -260,7 +257,6 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 	void *old;
 
 	for (;;) {
-		unsigned long nr_shadows = 0;
 		swp_entry_t entry = swp_entry(type, curr);
 		struct address_space *address_space = swap_address_space(entry);
 		XA_STATE(xas, &address_space->i_pages, curr);
@@ -270,7 +266,6 @@ void clear_shadow_from_swap_cache(int type, unsigned long begin,
 			if (!xa_is_value(old))
 				continue;
 			xas_store(&xas, NULL);
-			nr_shadows++;
 		}
 		xa_unlock_irq(&address_space->i_pages);
 
-- 
2.23.0

