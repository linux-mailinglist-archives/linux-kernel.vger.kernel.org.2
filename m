Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99A13E1788
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbhHEPHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:07:01 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:42128 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233228AbhHEPHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:00 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui3.1cn_1628175969;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui3.1cn_1628175969)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 23:06:09 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mm: migrate: Change to use bool type for 'page_was_mapped'
Date:   Thu,  5 Aug 2021 23:05:59 +0800
Message-Id: <11d1f8fc954a83945930a5b11f47e00c063bdc1b.1628174413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use bool type for 'page_was_mapped' variable making it
more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 6f048a8..0ab364f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -957,7 +957,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 				int force, enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
-	int page_was_mapped = 0;
+	bool page_was_mapped = false;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(page);
 
@@ -1060,7 +1060,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
 				page);
 		try_to_migrate(page, 0);
-		page_was_mapped = 1;
+		page_was_mapped = true;
 	}
 
 	if (!page_mapped(page))
-- 
1.8.3.1

