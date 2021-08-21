Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E91D3F3971
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhHUH4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:56:20 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:42090 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233015AbhHUH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:56:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UkdiL.9_1629532533;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UkdiL.9_1629532533)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Aug 2021 15:55:33 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mm: migrate: Fix the incorrect function name in comments
Date:   Sat, 21 Aug 2021 15:54:58 +0800
Message-Id: <5b824bad6183259c916ae6cf42f81d14c6118b06.1629447552.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since commit a98a2f0c8ce1 ("mm/rmap: split migration into its own function"),
the migration ptes establishment has been split into a separate
try_to_migrate() function, thus update the related comments.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Yang Shi <shy828301@gmail.com>
Reviewed-by: Alistair Popple <apopple@nvidia.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 9520d2f..a9800fa 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1001,7 +1001,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	}
 
 	/*
-	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
+	 * By try_to_migrate(), page->mapcount goes down to 0 here. In this case,
 	 * we cannot notice that anon_vma is freed while we migrates a page.
 	 * This get_anon_vma() delays freeing anon_vma pointer until the end
 	 * of migration. File cache pages are no problem because of page_lock()
-- 
1.8.3.1

