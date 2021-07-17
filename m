Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 496AC3CC266
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhGQKNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 06:13:23 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:7384 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhGQKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 06:13:21 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4GRkKf6gTjz7vnW;
        Sat, 17 Jul 2021 18:06:46 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 17 Jul 2021 18:10:22 +0800
Received: from localhost.localdomain (10.175.112.125) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 17 Jul 2021 18:10:22 +0800
From:   Chen Wandun <chenwandun@huawei.com>
To:     <akpm@linux-foundation.org>, <0x7f454c46@gmail.com>,
        <wangkefeng.wang@huawei.com>, <weiyongjun1@huawei.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Chen Wandun <chenwandun@huawei.com>
Subject: [PATCH] mm/mremap: fix memory account on do_munmap() failure
Date:   Sat, 17 Jul 2021 18:19:42 +0800
Message-ID: <20210717101942.120607-1-chenwandun@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mremap will account the delta between new_len and old_len in
vma_to_resize, and then call move_vma when expanding an existing
memory mapping. In function move_vma, there are two scenarios when
calling do_munmap:
1. move_page_tables from old_addr to new_addr success
2. move_page_tables from old_addr to new_addr fail

In first scenario, it should account old_len if do_munmap fail,
because the delta has already been accounted.

In second scenario, new_addr/new_len will assign to old_addr/old_len
if move_page_table fail, so do_munmap is try to unmap new_addr actually,
if do_munmap fail, it should account the new_len, because error code
will be return from move_vma, and delta will be unaccounted.
What'more, because of new_len == old_len, so account old_len also is
OK.

In summary, account old_len will be correct if do_munmap fail.

Fixes: 51df7bcb6151 ("mm/mremap: account memory on do_munmap() failure")
Signed-off-by: Chen Wandun <chenwandun@huawei.com>
---
 mm/mremap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 5989d3990020..badfe17ade1f 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -686,7 +686,7 @@ static unsigned long move_vma(struct vm_area_struct *vma,
 	if (do_munmap(mm, old_addr, old_len, uf_unmap) < 0) {
 		/* OOM: unable to split vma, just get accounts right */
 		if (vm_flags & VM_ACCOUNT && !(flags & MREMAP_DONTUNMAP))
-			vm_acct_memory(new_len >> PAGE_SHIFT);
+			vm_acct_memory(old_len >> PAGE_SHIFT);
 		excess = 0;
 	}
 
-- 
2.25.1

