Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08813BC878
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhGFJ14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 05:27:56 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:49200 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhGFJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 05:27:55 -0400
DKIM-Signature: a=rsa-sha256;
        b=fsB1TXyBUOJ/Qaqv5mSIpYKgYP1FhlOkIsPrAn/yCH53IKhgeTAvjgVjHCgbNIgAPmA/BmNbf92Jn7LQXmoummyEH4utQxFDwcK9dw21mlmh+jNLuJZgxzcQC+0y0EMjQ+vK0HIEFjy6TwWZnhOTGxd4NMRsN8iCHm0tX5czu5E=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=bOc4pvtcNfvNmA+UO/ZMqZD/nzwNN8K7zpJtMiW/zWY=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 7E28D38018B;
        Tue,  6 Jul 2021 17:25:15 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Cc:     mgorman@techsingularity.net, Qiang.Zhang@windriver.com,
        Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] mm: add GFP_ATOMIC flag after local_lock_irqsave
Date:   Tue,  6 Jul 2021 17:24:31 +0800
Message-Id: <1625563471-3873-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQxlPSFZOQx9NSx9KHUMaH05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzY6LBw4Aj9PLh8rE0oBDhIw
        PxoKCRFVSlVKTUlOTk1ITkpNS05KVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFJSkxINwY+
X-HM-Tid: 0a7a7b22cb46d994kuws7e28d38018b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prep_new_page() will allocate memory in some scenarios. 

Call Trace:
__dump_stack lib/dump_stack.c:79 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96
___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153
prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179
__alloc_pages+0x12f/0x500 mm/page_alloc.c:5375
alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2272
stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303
save_stack+0x15e/0x1e0 mm/page_owner.c:120
__set_page_owner+0x50/0x290 mm/page_owner.c:181
prep_new_page mm/page_alloc.c:2445 [inline]
__alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313

So we add GFP_ATOMIC and remove GFP_KERNEL flag.

Reported-and-tested-by: syzbot+b07d8440edb5f8988eea@syzkaller.appspotmail.com
Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc..3016ba5
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5309,7 +5309,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 		}
 		nr_account++;
 
-		prep_new_page(page, 0, gfp, 0);
+		prep_new_page(page, 0, gfp | GFP_ATOMIC & ~GFP_KERNEL, 0);
 		if (page_list)
 			list_add(&page->lru, page_list);
 		else
-- 
2.7.4

