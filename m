Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148A43E1784
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241432AbhHEPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:06:26 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46858 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232752AbhHEPGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:06:23 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Ui3E80D_1628175967;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ui3E80D_1628175967)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 05 Aug 2021 23:06:08 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mm: migrate: Move the page count validation to the proper place
Date:   Thu,  5 Aug 2021 23:05:56 +0800
Message-Id: <1f7e1d083864fbb17a20a9c8349d2e8b427e20a3.1628174413.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
References: <cover.1628174413.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've got the expected count for anonymous page or file page by
expected_page_refs() at the beginning of migrate_page_move_mapping(),
thus we should move the page count validation a little forward to
reduce duplicated code.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 239b238..5559571 100644
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

