Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B58391195
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 09:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbhEZHyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 03:54:52 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:44884 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbhEZHyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 03:54:45 -0400
Received: from localhost.localdomain (unknown [14.154.30.253])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id D9F0980288;
        Wed, 26 May 2021 15:53:11 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        osalvador@suse.de, david@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH v3] mm/page_alloc: fix counting of free pages after take off from buddy
Date:   Wed, 26 May 2021 15:52:47 +0800
Message-Id: <20210526075247.11130-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQksZQlZMGExLHU4eT0hKSEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OFE6UTo*FT8UThkSFStJGCwr
        GTUwCwNVSlVKTUlJS0pOTkJJT0hPVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKT1VKTk9VSEtVSU5IWVdZCAFZQUhLT0k3Bg++
X-HM-Tid: 0a79a7a9c6aab037kuuud9f0980288
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we found that there is a lot MemFree left in /proc/meminfo
after do a lot of pages soft offline, it's not quite correct.

Before Oscar rework soft offline for free pages [1], if we soft
offline free pages, these pages are left in buddy with HWPoison
flag, and NR_FREE_PAGES is not updated immediately. So the difference
between NR_FREE_PAGES and real number of available free pages is
also even big at the beginning.

However, with the workload running, when we catch HWPoison page in
any alloc functions subsequently, we will remove it from buddy,
meanwhile update the NR_FREE_PAGES and try again, so the NR_FREE_PAGES
will get more and more closer to the real number of available free pages.
(regardless of unpoison_memory())

Now, for offline free pages, after a successful call take_page_off_buddy(),
the page is no longer belong to buddy allocator, and will not be
used any more, but we missed accounting NR_FREE_PAGES in this situation,
and there is no chance to be updated later.

Do update in take_page_off_buddy() like rmqueue() does, but avoid
double counting if some one already set_migratetype_isolate() on the
page.

[1]: commit 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")

Suggested-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
v3:
- as Naoya Horiguchi suggested, do update only when
  is_migrate_isolate(migratetype)) is false
- updated patch description

v2:
- https://lore.kernel.org/linux-mm/20210508035533.23222-1-dinghui@sangfor.com.cn/
- use __mod_zone_freepage_state instead of __mod_zone_page_state 

 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index aaa1655cf682..d1f5de1c1283 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9158,6 +9158,8 @@ bool take_page_off_buddy(struct page *page)
 			del_page_from_free_list(page_head, zone, page_order);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
+			if (!is_migrate_isolate(migratetype))
+				__mod_zone_freepage_state(zone, -1, migratetype);
 			ret = true;
 			break;
 		}
-- 
2.17.1

