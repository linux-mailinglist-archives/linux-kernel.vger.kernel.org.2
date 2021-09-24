Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6019C418782
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 10:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhIZIoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 04:44:21 -0400
Received: from unicom145.biz-email.net ([210.51.26.145]:62792 "EHLO
        unicom145.biz-email.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbhIZIoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 04:44:20 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Sun, 26 Sep 2021 04:44:19 EDT
Received: from ([60.208.111.195])
        by unicom145.biz-email.net ((LNX1044)) with ASMTP (SSL) id UJL00034;
        Sun, 26 Sep 2021 16:36:34 +0800
Received: from localhost.localdomain (10.200.104.119) by
 jtjnmail201608.home.langchao.com (10.100.2.8) with Microsoft SMTP Server id
 15.1.2308.14; Sun, 26 Sep 2021 16:27:09 +0800
From:   Kai Song <songkai01@inspur.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Kai Song <songkai01@inspur.com>
Subject: [PATCH] mm/vmscan.c:Fix -Wunused-but-set-variable warning
Date:   Sat, 25 Sep 2021 02:12:18 +0800
Message-ID: <20210924181218.21165-1-songkai01@inspur.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.200.104.119]
tUid:   2021926163634ab3e599a17e05123bb24ebaaed18d147
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We fix the following warning when building kernel with W=1:
mm/vmscan.c:1362:6: warning: variable 'err' set but not used [-Wunused-but-set-variable]

Signed-off-by: Kai Song <songkai01@inspur.com>
---
 mm/vmscan.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index f8b43f131673..7cf702bc1959 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1359,7 +1359,6 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 {
 	int target_nid = next_demotion_node(pgdat->node_id);
 	unsigned int nr_succeeded;
-	int err;
 
 	if (list_empty(demote_pages))
 		return 0;
@@ -1368,7 +1367,7 @@ static unsigned int demote_page_list(struct list_head *demote_pages,
 		return 0;
 
 	/* Demotion ignores all cpuset and mempolicy settings */
-	err = migrate_pages(demote_pages, alloc_demote_page, NULL,
+	migrate_pages(demote_pages, alloc_demote_page, NULL,
 			    target_nid, MIGRATE_ASYNC, MR_DEMOTION,
 			    &nr_succeeded);
 
-- 
2.27.0

