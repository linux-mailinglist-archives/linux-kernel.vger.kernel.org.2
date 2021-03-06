Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4C32F81D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhCFDaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:30:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13445 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhCFDab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:30:31 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dsqp45dSkzjVb2;
        Sat,  6 Mar 2021 11:29:00 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Sat, 6 Mar 2021
 11:30:16 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <kirill.shutemov@linux.intel.com>
CC:     <riel@redhat.com>, <ebru.akagunduz@gmail.com>,
        <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 4/4] khugepaged: fix wrong result value for trace_mm_collapse_huge_page_isolate()
Date:   Fri, 5 Mar 2021 22:29:47 -0500
Message-ID: <20210306032947.35921-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210306032947.35921-1-linmiaohe@huawei.com>
References: <20210306032947.35921-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In writable and !referenced case, the result value should be
SCAN_LACK_REFERENCED_PAGE for trace_mm_collapse_huge_page_isolate()
instead of default 0 (SCAN_FAIL) here.

Fixes: 7d2eba0557c1 ("mm: add tracepoint for scanning pages")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 mm/khugepaged.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index e886a8618c33..adf677246d86 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -716,17 +716,17 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
 		if (pte_write(pteval))
 			writable = true;
 	}
-	if (likely(writable)) {
-		if (likely(referenced)) {
-			result = SCAN_SUCCEED;
-			trace_mm_collapse_huge_page_isolate(page, none_or_zero,
-							    referenced, writable, result);
-			return 1;
-		}
-	} else {
+
+	if (unlikely(!writable)) {
 		result = SCAN_PAGE_RO;
+	} else if (unlikely(!referenced)) {
+		result = SCAN_LACK_REFERENCED_PAGE;
+	} else {
+		result = SCAN_SUCCEED;
+		trace_mm_collapse_huge_page_isolate(page, none_or_zero,
+						    referenced, writable, result);
+		return 1;
 	}
-
 out:
 	release_pte_pages(pte, _pte, compound_pagelist);
 	trace_mm_collapse_huge_page_isolate(page, none_or_zero,
-- 
2.19.1

