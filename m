Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2814D376F4E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 05:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbhEHD5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 23:57:38 -0400
Received: from mail-m121142.qiye.163.com ([115.236.121.142]:12588 "EHLO
        mail-m121142.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhEHD5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 23:57:37 -0400
Received: from localhost.localdomain (unknown [14.154.28.254])
        by mail-m121142.qiye.163.com (Hmail) with ESMTPA id B20FD80762;
        Sat,  8 May 2021 11:56:31 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     david@redhat.com, naoya.horiguchi@nec.com, osalvador@suse.de
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH v2] mm/page_alloc: fix counting of free pages after take off from buddy
Date:   Sat,  8 May 2021 11:55:33 +0800
Message-Id: <20210508035533.23222-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <8cd355d2-1adc-4189-7b65-cfea13129db5@sangfor.com.cn>
References: <8cd355d2-1adc-4189-7b65-cfea13129db5@sangfor.com.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUseSlYYTElMGR0fGkhDH01VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        9ISFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTo6Tjo4CT8KPzkPNCoZNw8u
        H1YKCTlVSlVKTUlLT09NSkJJSEtOVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlKT1VKTk9VSUNVSU5PWVdZCAFZQUlKT0I3Bg++
X-HM-Tid: 0a794a1ea173b037kuuub20fd80762
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently we found there is a lot MemFree left in /proc/meminfo after
do a lot of pages soft offline.

I think it's incorrect since NR_FREE_PAGES should not contain HWPoison pages.
For offline free pages, after a successful call take_page_off_buddy(), the
page is no longer belong to buddy allocator, and will not be used any more,
but we missed accounting NR_FREE_PAGES in this situation.

Do update like rmqueue() does.

Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
V2:
use __mod_zone_freepage_state instead of __mod_zone_page_state

 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfc72873961d..e124a615303b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8947,6 +8947,7 @@ bool take_page_off_buddy(struct page *page)
 			del_page_from_free_list(page_head, zone, page_order);
 			break_down_buddy_pages(zone, page_head, page, 0,
 						page_order, migratetype);
+			__mod_zone_freepage_state(zone, -1, migratetype);
 			ret = true;
 			break;
 		}
-- 
2.17.1

