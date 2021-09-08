Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87A4037DC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 12:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348894AbhIHKaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 06:30:08 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:9015 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245727AbhIHKaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 06:30:05 -0400
Received: from dggeml765-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4H4JHm3rVyzVrqv;
        Wed,  8 Sep 2021 18:28:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeml765-chm.china.huawei.com
 (10.1.199.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Wed, 8 Sep
 2021 18:28:55 +0800
From:   Liu Yuntao <liuyuntao10@huawei.com>
To:     <hughd@google.com>, <akpm@linux-foundation.org>,
        <kirill.shutemov@linux.intel.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <wuxu.wu@huawei.com>, <liusirui@huawei.com>,
        <windspectator@gmail.com>
Subject: [PATCH] fix judgment error in shmem_is_huge()
Date:   Wed, 8 Sep 2021 18:26:48 +0800
Message-ID: <20210908102648.2326917-2-liuyuntao10@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210908102648.2326917-1-liuyuntao10@huawei.com>
References: <20210908102648.2326917-1-liuyuntao10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 88742953532c..5747572859d1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -490,7 +490,7 @@ bool shmem_is_huge(struct vm_area_struct *vma,
 	case SHMEM_HUGE_ALWAYS:
 		return true;
 	case SHMEM_HUGE_WITHIN_SIZE:
-		index = round_up(index, HPAGE_PMD_NR);
+		index = round_up(index + 1, HPAGE_PMD_NR);
 		i_size = round_up(i_size_read(inode), PAGE_SIZE);
 		if (i_size >= HPAGE_PMD_SIZE && (i_size >> PAGE_SHIFT) >= index)
 			return true;
-- 
2.23.0

