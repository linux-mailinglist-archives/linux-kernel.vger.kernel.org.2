Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2F36638A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 04:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhDUCON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 22:14:13 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:62476 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbhDUCOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 22:14:09 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Apr 2021 22:14:09 EDT
Received: from localhost.localdomain (unknown [14.154.30.246])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id 31595802E9;
        Wed, 21 Apr 2021 10:05:16 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Ding Hui <dinghui@sangfor.com.cn>
Subject: [RFC PATCH] mm/page_alloc: fix counting of free pages after take off from buddy
Date:   Wed, 21 Apr 2021 10:04:26 +0800
Message-Id: <20210421020426.5914-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUhMHlZNH0NNTR8eS0tMH0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBQ6Izo4UT8TEgkINjFCKQ4i
        GSkwCUlVSlVKTUpDQkxLTEpNTENOVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKT1VKTk9VSEtVSU9NWVdZCAFZQUpMSU43Bg++
X-HM-Tid: 0a78f22ca8e4b037kuuu31595802e9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we found there is a lot MemFree left in /proc/meminfo after
do a lot of pages soft offline.

I think it's incorrect since NR_FREE_PAGES should not contain HWPoison pages.
After take_page_off_buddy, the page is no longer belong to buddy
allocator, and will not be used any more, but we maybe missed accounting
NR_FREE_PAGES in this situation.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..8d65b62784d8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8947,6 +8947,7 @@ bool take_page_off_buddy(struct page *page)
 			del_page_from_free_list(page_head, zone, page_order);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
+			__mod_zone_page_state(zone, NR_FREE_PAGES, -1);
 			ret = true;
 			break;
 		}
-- 
2.17.1

