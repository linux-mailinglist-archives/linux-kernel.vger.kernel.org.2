Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7B930931C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 10:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhA3JQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 04:16:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11220 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233694AbhA3JOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 04:14:54 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DST4h5jSvzlCSD;
        Sat, 30 Jan 2021 17:12:36 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Sat, 30 Jan 2021
 17:14:01 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm/mempolicy: use helper range_in_vma() in queue_pages_test_walk()
Date:   Sat, 30 Jan 2021 04:13:52 -0500
Message-ID: <20210130091352.20220-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper range_in_vma() is introduced via commit 017b1660df89 ("mm:
migration: fix migration of huge PMD shared pages"). But we forgot to
use it in queue_pages_test_walk().

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6961238c7ef5..ab51132547b8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -677,7 +677,7 @@ static int queue_pages_test_walk(unsigned long start, unsigned long end,
 	unsigned long flags = qp->flags;
 
 	/* range check first */
-	VM_BUG_ON_VMA((vma->vm_start > start) || (vma->vm_end < end), vma);
+	VM_BUG_ON_VMA(!range_in_vma(vma, start, end), vma);
 
 	if (!qp->first) {
 		qp->first = vma;
-- 
2.19.1

