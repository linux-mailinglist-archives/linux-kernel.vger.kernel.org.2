Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2DDF3E1786
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241697AbhHEPGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:06:33 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:36989 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241251AbhHEPGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:06:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui3FG-J_1628175968;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui3FG-J_1628175968)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 23:06:09 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mm: migrate: Fix the incorrect function name in comments
Date:   Thu,  5 Aug 2021 23:05:58 +0800
Message-Id: <433d0be927c0cae047a4ca04feff0a1dccefe324.1628174413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

since commit a98a2f0c8ce1 ("mm/rmap: split migration into its own function"),
the migration ptes establishment has been split into a separate
try_to_migrate() function, thus update the related comments.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index eeba4c6..6f048a8 100644
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

