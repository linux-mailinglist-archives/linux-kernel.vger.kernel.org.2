Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C097C3F396F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 09:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbhHUH4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 03:56:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:33217 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232195AbhHUH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 03:56:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UkdYqNg_1629532532;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UkdYqNg_1629532532)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 21 Aug 2021 15:55:32 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     shy828301@gmail.com, willy@infradead.org,
        baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mm: migrate: Simplify the file-backed pages validation when migrating its mapping
Date:   Sat, 21 Aug 2021 15:54:56 +0800
Message-Id: <df4c129fd8e86a95dbc55f4663d77441cc0d3bd1.1629447552.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
References: <cover.1629447552.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to validate the file-backed page's refcount before
trying to freeze the page's expected refcount, instead we can rely on
the folio_ref_freeze() to validate if the page has the expected refcount
before migrating its mapping.

Moreover we are always under the page lock when migrating the page
mapping, which means nowhere else can remove it from the page cache,
so we can remove the xas_load() validation under the i_pages lock.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/migrate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index c6eb2a8..4c93d98 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -404,12 +404,6 @@ int folio_migrate_mapping(struct address_space *mapping,
 	newzone = folio_zone(newfolio);
 
 	xas_lock_irq(&xas);
-	if (folio_ref_count(folio) != expected_count ||
-	    xas_load(&xas) != folio) {
-		xas_unlock_irq(&xas);
-		return -EAGAIN;
-	}
-
 	if (!folio_ref_freeze(folio, expected_count)) {
 		xas_unlock_irq(&xas);
 		return -EAGAIN;
-- 
1.8.3.1

