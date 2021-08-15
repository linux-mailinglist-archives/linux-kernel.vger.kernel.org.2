Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3073EC7AB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhHOGXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:23:47 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51884 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231977AbhHOGXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:23:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uj0YhHM_1629008593;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uj0YhHM_1629008593)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 15 Aug 2021 14:23:14 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     apopple@nvidia.com, shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] mm: migrate: Fix the incorrect function name in comments
Date:   Sun, 15 Aug 2021 14:23:05 +0800
Message-Id: <70197e953cff2bd81555ac0a72d816fcf96a76ee.1629008158.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
References: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
References: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
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
index 9b162c0e..433c083 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1005,7 +1005,7 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	}
 
 	/*
-	 * By try_to_unmap(), page->mapcount goes down to 0 here. In this case,
+	 * By try_to_migrate(), page->mapcount goes down to 0 here. In this case,
 	 * we cannot notice that anon_vma is freed while we migrates a page.
 	 * This get_anon_vma() delays freeing anon_vma pointer until the end
 	 * of migration. File cache pages are no problem because of page_lock()
-- 
1.8.3.1

