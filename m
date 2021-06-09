Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8271F3A1110
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 12:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236482AbhFIK2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 06:28:23 -0400
Received: from out28-50.mail.aliyun.com ([115.124.28.50]:35360 "EHLO
        out28-50.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbhFIK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 06:28:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3055118|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0374721-0.0102982-0.95223;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=liu.xiang@zlingsmart.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.KPunzqk_1623232454;
Received: from localhost(mailfrom:liu.xiang@zlingsmart.com fp:SMTPD_---.KPunzqk_1623232454)
          by smtp.aliyun-inc.com(10.194.97.171);
          Wed, 09 Jun 2021 17:54:14 +0800
From:   Liu Xiang <liu.xiang@zlingsmart.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Liu Xiang <liu.xiang@zlingsmart.com>
Subject: [PATCH] mm: compaction: remove duplicate !list_empty(&sublist) check
Date:   Wed,  9 Jun 2021 17:54:09 +0800
Message-Id: <20210609095409.19920-1-liu.xiang@zlingsmart.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The list_splice_tail(&sublist, freelist) also do
!list_empty(&sublist) check, so remove the duplicate call.

Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
---
 mm/compaction.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/compaction.c b/mm/compaction.c
index 84fde270a..5b1dc832f 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1297,8 +1297,7 @@ move_freelist_head(struct list_head *freelist, struct page *freepage)
 
 	if (!list_is_last(freelist, &freepage->lru)) {
 		list_cut_before(&sublist, freelist, &freepage->lru);
-		if (!list_empty(&sublist))
-			list_splice_tail(&sublist, freelist);
+		list_splice_tail(&sublist, freelist);
 	}
 }
 
@@ -1315,8 +1314,7 @@ move_freelist_tail(struct list_head *freelist, struct page *freepage)
 
 	if (!list_is_first(freelist, &freepage->lru)) {
 		list_cut_position(&sublist, freelist, &freepage->lru);
-		if (!list_empty(&sublist))
-			list_splice_tail(&sublist, freelist);
+		list_splice_tail(&sublist, freelist);
 	}
 }
 
-- 
2.17.1

