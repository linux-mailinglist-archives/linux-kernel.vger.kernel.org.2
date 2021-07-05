Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4863BBDEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 15:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhGEOAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 10:00:07 -0400
Received: from mail-m17639.qiye.163.com ([59.111.176.39]:52122 "EHLO
        mail-m17639.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhGEOAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 10:00:06 -0400
DKIM-Signature: a=rsa-sha256;
        b=HNR+dXzxrdrcR8OUrPosGj3LIRGG4dc6wbrY97tqVS/Lh/hhRI0sE1ExBEuCN5k5XN3EZmrw1GYb7ouQ+HGeENpTg1yKqsXAAJnRr9FZdZhmrR9OnxNbMfhJBtauGg+kIcuGbO1RG6n1qwRrBhGJRUgKldr4HMaGh5P9ol/Au10=;
        s=default; c=relaxed/relaxed; d=vivo.com; v=1;
        bh=Hj7ANVvmsqIMnUcnu2LhSgHEe4XeE1gdx8oBVcDVPhk=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m17639.qiye.163.com (Hmail) with ESMTPA id 440A6380063;
        Mon,  5 Jul 2021 21:57:28 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mm: add GFP_ATOMIC flag after local_lock_irqsave
Date:   Mon,  5 Jul 2021 21:57:12 +0800
Message-Id: <1625493432-9945-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQhlLGVZMGh5NGkpOHUwZHkhVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWUFZT0tIVUpKS0
        hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MTI6Chw6ET9LIhk1SCMpCB0O
        FBUKCxNVSlVKTUlOT0JIT09DTUJKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFKSE9KNwY+
X-HM-Tid: 0a7a76f5a6d4d994kuws440a6380063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use GFP_ATOMIC when local_lock_irqsave in __alloc_pages_bulk

Reported-by: syzbot+e45919db2eab5e837646@syzkaller.appspotmail.com
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
+		prep_new_page(page, 0, gfp | GFP_ATOMIC, 0);
 		if (page_list)
 			list_add(&page->lru, page_list);
 		else
-- 
2.7.4

