Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05ACD3F3972
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbhHUH44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:56:56 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:35482 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233068AbhHUH4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:56:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UkdiL.F_1629532533;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UkdiL.F_1629532533)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Aug 2021 15:55:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] mm: migrate: Change to use bool type for 'page_was_mapped'
Date:   Sat, 21 Aug 2021 15:54:59 +0800
Message-Id: <ce1279df18d2c163998c403e0b5ec6d3f6f90f7a.1629447552.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use bool type for 'page_was_mapped' variable making it
more readable.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
---
 mm/migrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a9800fa..04a76fc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -953,7 +953,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 				int force, enum migrate_mode mode)
 {
 	int rc = -EAGAIN;
-	int page_was_mapped = 0;
+	bool page_was_mapped = false;
 	struct anon_vma *anon_vma = NULL;
 	bool is_lru = !__PageMovable(page);
 
@@ -1056,7 +1056,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 		VM_BUG_ON_PAGE(PageAnon(page) && !PageKsm(page) && !anon_vma,
 				page);
 		try_to_migrate(page, 0);
-		page_was_mapped = 1;
+		page_was_mapped = true;
 	}
 
 	if (!page_mapped(page))
-- 
1.8.3.1

