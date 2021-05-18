Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71047387A76
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 15:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242810AbhERNz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 09:55:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4735 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245342AbhERNzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 09:55:18 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fky7V3b1kzqVCP;
        Tue, 18 May 2021 21:50:30 +0800 (CST)
Received: from dggeme703-chm.china.huawei.com (10.1.199.99) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
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
Subject: [PATCH 4/5] mm/swap: remove unused global variable nr_swapper_spaces
Date:   Tue, 18 May 2021 21:53:51 +0800
Message-ID: <20210518135352.3705306-5-linmiaohe@huawei.com>
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

Since commit b6038942480e ("mm: memcg: add swapcache stat for memcg v2"),
the last user of nr_swapper_spaces is gone. So we remove this unused one.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swap_state.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index bab386c7b655..a55b7b74b0e6 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -37,7 +37,6 @@ static const struct address_space_operations swap_aops = {
 };
 
 struct address_space *swapper_spaces[MAX_SWAPFILES] __read_mostly;
-static unsigned int nr_swapper_spaces[MAX_SWAPFILES] __read_mostly;
 static bool enable_vma_readahead __read_mostly = true;
 
 #define SWAP_RA_WIN_SHIFT	(PAGE_SHIFT / 2)
@@ -686,7 +685,6 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 		/* swap cache doesn't use writeback related tags */
 		mapping_set_no_writeback_tags(space);
 	}
-	nr_swapper_spaces[type] = nr;
 	swapper_spaces[type] = spaces;
 
 	return 0;
@@ -695,7 +693,6 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
 void exit_swap_address_space(unsigned int type)
 {
 	kvfree(swapper_spaces[type]);
-	nr_swapper_spaces[type] = 0;
 	swapper_spaces[type] = NULL;
 }
 
-- 
2.23.0

