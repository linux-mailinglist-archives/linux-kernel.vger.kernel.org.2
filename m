Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E33EA43F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 14:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237271AbhHLMEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 08:04:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8013 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237236AbhHLMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 08:04:18 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GllhR52DHzYlWH;
        Thu, 12 Aug 2021 20:03:35 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 12
 Aug 2021 20:03:51 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <hughd@google.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/4] shmem: remove unneeded function forward declaration
Date:   Thu, 12 Aug 2021 20:03:49 +0800
Message-ID: <20210812120350.49801-4-linmiaohe@huawei.com>
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

The forward declaration for shmem_should_replace_page() and
shmem_replace_page() is unnecessary. Remove them.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/shmem.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 41d2900153d9..ccef5fad0049 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -135,9 +135,6 @@ static unsigned long shmem_default_max_inodes(void)
 }
 #endif
 
-static bool shmem_should_replace_page(struct page *page, gfp_t gfp);
-static int shmem_replace_page(struct page **pagep, gfp_t gfp,
-				struct shmem_inode_info *info, pgoff_t index);
 static int shmem_swapin_page(struct inode *inode, pgoff_t index,
 			     struct page **pagep, enum sgp_type sgp,
 			     gfp_t gfp, struct vm_area_struct *vma,
-- 
2.23.0

