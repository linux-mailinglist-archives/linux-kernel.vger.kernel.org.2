Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5ADF4043E7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 05:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349769AbhIIDVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 23:21:49 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9017 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbhIIDVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 23:21:44 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4kl02pv4zW0wc;
        Thu,  9 Sep 2021 11:19:40 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeml765-chm.china.huawei.com
 (10.1.199.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Thu, 9 Sep
 2021 11:20:32 +0800
From:   Liu Yuntao <liuyuntao10@huawei.com>
To:     <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <kirill.shutemov@linux.intel.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <liusirui@huawei.com>,
        <liuyuntao10@huawei.com>, <windspectator@gmail.com>,
        <wuxu.wu@huawei.com>
Subject: [PATCH v2] fix judgment error in shmem_is_huge()
Date:   Thu, 9 Sep 2021 11:20:07 +0800
Message-ID: <20210909032007.18353-1-liuyuntao10@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeml765-chm.china.huawei.com (10.1.199.175)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the case of SHMEM_HUGE_WITHIN_SIZE, the page index is not rounded
up correctly. When the page index points to the first page in a huge
page, round_up() cannot bring it to the end of the huge page, but
to the end of the previous one.

an example:
HPAGE_PMD_NR on my machine is 512(2 MB huge page size).
After allcoating a 3000 KB buffer, I access it at location 2050 KB.
In shmem_is_huge(), the corresponding index happens to be 512.
After rounded up by HPAGE_PMD_NR, it will still be 512 which is
smaller than i_size, and shmem_is_huge() will return true.
As a result, my buffer takes an additional huge page, and that
shouldn't happen when shmem_enabled is set to within_size.

Fixes: f3f0e1d2150b2b ("khugepaged: add support of collapse for tmpfs/shmem pages")
Signed-off-by: Liu Yuntao <liuyuntao10@huawei.com>
---
V1->V2:
add simplification of the condition after round_up()
---
 mm/shmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 88742953532c..b5860f4a2738 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -490,9 +490,9 @@ bool shmem_is_huge(struct vm_area_struct *vma,
 	case SHMEM_HUGE_ALWAYS:
 		return true;
 	case SHMEM_HUGE_WITHIN_SIZE:
-		index = round_up(index, HPAGE_PMD_NR);
+		index = round_up(index + 1, HPAGE_PMD_NR);
 		i_size = round_up(i_size_read(inode), PAGE_SIZE);
-		if (i_size >= HPAGE_PMD_SIZE && (i_size >> PAGE_SHIFT) >= index)
+		if (i_size >> PAGE_SHIFT >= index)
 			return true;
 		fallthrough;
 	case SHMEM_HUGE_ADVISE:
-- 
2.23.0

