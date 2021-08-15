Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F03EC7AA
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhHOGXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:23:45 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50583 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229633AbhHOGXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:23:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Uj0RWdi_1629008593;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Uj0RWdi_1629008593)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 15 Aug 2021 14:23:13 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     apopple@nvidia.com, shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] mm: migrate: Move the page count validation to the proper place
Date:   Sun, 15 Aug 2021 14:23:03 +0800
Message-Id: <644a666e1e177c57a39a4c37c6e2ca64052b9d7e.1629008158.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
References: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
References: <cover.1629008158.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've got the expected count for anonymous page or file page by
expected_page_refs() at the beginning of migrate_page_move_mapping(),
thus we should move the page count validation a little forward to
reduce duplicated code.

Moreover the i_pages lock is not used to guarantee the page refcount
safety in migrate_page_move_mapping(), so we can move the getting page
count out of the i_pages lock. Since now the migration page has
established a migration pte under the page lock now, with the page
refcount freezing validation, to ensure that the page references
meet the migration requirement.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c6eb2a8..8e9282f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -386,11 +386,10 @@ int folio_migrate_mapping(struct address_space *mapping,
 	int expected_count = expected_page_refs(mapping, &folio->page) + extra_count;
 	long nr = folio_nr_pages(folio);
 
-	if (!mapping) {
-		/* Anonymous page without mapping */
-		if (folio_ref_count(folio) != expected_count)
-			return -EAGAIN;
+	if (folio_ref_count(folio) != expected_count)
+		return -EAGAIN;
 
+	if (!mapping) {
 		/* No turning back from here */
 		newfolio->index = folio->index;
 		newfolio->mapping = folio->mapping;
@@ -404,8 +403,7 @@ int folio_migrate_mapping(struct address_space *mapping,
 	newzone = folio_zone(newfolio);
 
 	xas_lock_irq(&xas);
-	if (folio_ref_count(folio) != expected_count ||
-	    xas_load(&xas) != folio) {
+	if (xas_load(&xas) != folio) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
 	}
-- 
1.8.3.1

