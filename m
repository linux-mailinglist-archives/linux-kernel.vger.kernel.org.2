Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619ED3FB399
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbhH3KIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 06:08:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:40096 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236068AbhH3KIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 06:08:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yun.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UmapD6V_1630318076;
Received: from testdeMacBook-Pro.local(mailfrom:yun.wang@linux.alibaba.com fp:SMTPD_---0UmapD6V_1630318076)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 Aug 2021 18:07:57 +0800
To:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:HWPOISON MEMORY FAILURE HANDLING" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
From:   =?UTF-8?B?546L6LSH?= <yun.wang@linux.alibaba.com>
Subject: [PATCH] mm: fix panic caused by __page_handle_poison()
Message-ID: <58b6b733-b021-7eb8-4226-1b98d50c8c82@linux.alibaba.com>
Date:   Mon, 30 Aug 2021 18:07:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By commit 510d25c92ec4 ("mm/hwpoison: disable pcp for
page_handle_poison()"), __page_handle_poison() was
introduced, and if we mark:

RET_A = dissolve_free_huge_page();
RET_B = take_page_off_buddy();

then __page_handle_poison was supposed to return TRUE When
RET_A == 0 && RET_B == TRUE

But since it failed to take care the case when RET_A is
-EBUSY or -ENOMEM, and just return the ret as a bool which
actually become TRUE, it break the original logical.

The following result is a huge page in freelist but was
referenced as poisoned, and lead into the final panic:

  kernel BUG at mm/internal.h:95!
  invalid opcode: 0000 [#1] SMP PTI
  skip...
  RIP: 0010:set_page_refcounted mm/internal.h:95 [inline]
  RIP: 0010:remove_hugetlb_page+0x23c/0x240 mm/hugetlb.c:1371
  skip...
  Call Trace:
   remove_pool_huge_page+0xe4/0x110 mm/hugetlb.c:1892
   return_unused_surplus_pages+0x8d/0x150 mm/hugetlb.c:2272
   hugetlb_acct_memory.part.91+0x524/0x690 mm/hugetlb.c:4017

This patch replace 'bool' with 'int' to handle RET_A correctly.

Reported-by: Abaci <abaci@linux.alibaba.com>
Signed-off-by: Michael Wang <yun.wang@linux.alibaba.com>
---
 mm/memory-failure.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 470400c..0fff717 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -68,7 +68,7 @@

 static bool __page_handle_poison(struct page *page)
 {
-	bool ret;
+	int ret;

 	zone_pcp_disable(page_zone(page));
 	ret = dissolve_free_huge_page(page);
@@ -76,7 +76,7 @@ static bool __page_handle_poison(struct page *page)
 		ret = take_page_off_buddy(page);
 	zone_pcp_enable(page_zone(page));

-	return ret;
+	return ret > 0;
 }

 static bool page_handle_poison(struct page *page, bool hugepage_or_freepage, bool release)
-- 
1.8.3.1

