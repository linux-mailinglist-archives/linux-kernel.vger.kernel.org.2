Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0136D926
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbhD1OB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 10:01:27 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:44896 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240171AbhD1OBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 10:01:04 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=xuyu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UX52TuL_1619618418;
Received: from localhost(mailfrom:xuyu@linux.alibaba.com fp:SMTPD_---0UX52TuL_1619618418)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 28 Apr 2021 22:00:18 +0800
From:   Xu Yu <xuyu@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org
Subject: [PATCH] mm, compaction: avoid isolating pinned tmpfs pages
Date:   Wed, 28 Apr 2021 22:00:14 +0800
Message-Id: <e2f0689e00cce7ac73716da14a971a4f1ab88359.1619618267.git.xuyu@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.2432.ga663e714
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes pinned tmpfs pages bail out early in the process of page
migration, like what pinned anonymous pages do.

Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
---
 mm/compaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index e04f4476e68e..78c3b992a1c9 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -964,11 +964,11 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		}
 
 		/*
-		 * Migration will fail if an anonymous page is pinned in memory,
-		 * so avoid taking lru_lock and isolating it unnecessarily in an
-		 * admittedly racy check.
+		 * Migration will fail if an anonymous or tmpfs page is pinned
+		 * in memory, so avoid taking lru_lock and isolating it
+		 * unnecessarily in an admittedly racy check.
 		 */
-		if (!page_mapping(page) &&
+		if (!page_is_file_lru(page) &&
 		    page_count(page) > page_mapcount(page))
 			goto isolate_fail;
 
-- 
2.20.1.2432.ga663e714

