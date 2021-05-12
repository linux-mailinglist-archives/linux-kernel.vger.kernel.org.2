Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43C37B45D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 05:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELDCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 23:02:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2446 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhELDCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 23:02:16 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Ffzxv3scCzCrRb;
        Wed, 12 May 2021 10:58:27 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 11:01:01 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 1/3] mm/page_alloc: Use dump_page() directly
Date:   Wed, 12 May 2021 11:10:55 +0800
Message-ID: <20210512031057.13580-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simplfy use dump_page().

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a2fe714aed93..f23702e7c564 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -658,8 +658,7 @@ static void bad_page(struct page *page, const char *reason)
 
 	pr_alert("BUG: Bad page state in process %s  pfn:%05lx\n",
 		current->comm, page_to_pfn(page));
-	__dump_page(page, reason);
-	dump_page_owner(page);
+	dump_page(page, reason);
 
 	print_modules();
 	dump_stack();
-- 
2.26.2

