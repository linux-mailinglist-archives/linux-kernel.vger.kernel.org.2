Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD51E36C712
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 15:33:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbhD0Ndv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 09:33:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17047 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238022AbhD0NdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 09:33:22 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FV2fv6KWWzPtFX;
        Tue, 27 Apr 2021 21:29:27 +0800 (CST)
Received: from huawei.com (10.175.104.170) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Tue, 27 Apr 2021
 21:32:24 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <ziy@nvidia.com>, <william.kucharski@oracle.com>,
        <willy@infradead.org>, <yang.shi@linux.alibaba.com>,
        <aneesh.kumar@linux.ibm.com>, <rcampbell@nvidia.com>,
        <songliubraving@fb.com>, <kirill.shutemov@linux.intel.com>,
        <riel@surriel.com>, <hannes@cmpxchg.org>, <minchan@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 3/5] mm/huge_memory.c: add missing read-only THP checking in transparent_hugepage_enabled()
Date:   Tue, 27 Apr 2021 21:32:12 +0800
Message-ID: <20210427133214.2270207-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210427133214.2270207-1-linmiaohe@huawei.com>
References: <20210427133214.2270207-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.170]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 99cb0dbd47a1 ("mm,thp: add read-only THP support for
(non-shmem) FS"), read-only THP file mapping is supported. But it
forgot to add checking for it in transparent_hugepage_enabled().

Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 76ca1eb2a223..aa22a0ae9894 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -74,6 +74,9 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
 		return __transparent_hugepage_enabled(vma);
 	if (vma_is_shmem(vma))
 		return shmem_huge_enabled(vma);
+	if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) && vma->vm_file &&
+	    (vma->vm_flags & VM_DENYWRITE))
+		return true;
 
 	return false;
 }
-- 
2.23.0

