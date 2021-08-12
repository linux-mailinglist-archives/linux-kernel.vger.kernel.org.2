Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6D3EA440
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhHLMEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:04:25 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:8403 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbhHLMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:04:19 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GllcB4W95z86nT;
        Thu, 12 Aug 2021 19:59:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 12
 Aug 2021 20:03:52 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/4] shmem: include header file to declare swap_info
Date:   Thu, 12 Aug 2021 20:03:50 +0800
Message-ID: <20210812120350.49801-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210812120350.49801-1-linmiaohe@huawei.com>
References: <20210812120350.49801-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's bad to extern swap_info[] in .c. Include corresponding header
file instead.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index ccef5fad0049..b9cebf074367 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -38,6 +38,7 @@
 #include <linux/hugetlb.h>
 #include <linux/frontswap.h>
 #include <linux/fs_parser.h>
+#include <linux/swapfile.h>
 
 static struct vfsmount *shm_mnt;
 
@@ -1152,8 +1153,6 @@ static void shmem_evict_inode(struct inode *inode)
 	clear_inode(inode);
 }
 
-extern struct swap_info_struct *swap_info[];
-
 static int shmem_find_swap_entries(struct address_space *mapping,
 				   pgoff_t start, unsigned int nr_entries,
 				   struct page **entries, pgoff_t *indices,
-- 
2.23.0

