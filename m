Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9B13D6CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 05:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbhG0C6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 22:58:25 -0400
Received: from mail-m118208.qiye.163.com ([115.236.118.208]:21134 "EHLO
        mail-m118208.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235023AbhG0C6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 22:58:24 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Jul 2021 22:58:23 EDT
DKIM-Signature: a=rsa-sha256;
        b=ABBMxIWpIg9L/+HOKYm9N1K3nPL1ofAhoRb4Dm66I2pA+wli25VBZg/N0i6mDzrm9zPMT73QTa8Zq3dbUZO59+M9fg+NiqGeg4rKGcRl35JF41+7dWgONWXkly4teBrxqr6qWEvTVzKjC86vKOlDKoE+UDUONjzKgovIecZpwaw=;
        c=relaxed/relaxed; s=default; d=vivo.com; v=1;
        bh=fgFn2CfqfI5yLqGF+VB3uiM6py0rkY8NZLedV5hh+AU=;
        h=date:mime-version:subject:message-id:from;
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.232])
        by mail-m118208.qiye.163.com (Hmail) with ESMTPA id 722B7E0121;
        Tue, 27 Jul 2021 11:33:30 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mm: folio: use copy_highpage() instead of folio_migrate_copy() when copy once
Date:   Tue, 27 Jul 2021 11:32:54 +0800
Message-Id: <1627356775-28742-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZCBgUCR5ZQVlLVUtZV1
        kWDxoPAgseWUFZKDYvK1lXWShZQUhPN1dZLVlBSVdZDwkaFQgSH1lBWRpPSUpWSx8dTR5NHkNNTE
        9PVRMBExYaEhckFA4PWVdZFhoPEhUdFFlBWU9LSFVKSktISkxVS1kG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NU06SBw6Ez9NDEwtFEk9LU0c
        NDYaCzxVSlVKTUlMSE5NQ0pKS0lDVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISVlXWQgBWUFITkxMNwY+
X-HM-Tid: 0a7ae6064d672c17kusn722b7e0121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

folio_migrate_copy() will call cond_resched(), even if it only needs to be
copied once, restore the previous implementation before there is a better
solution: use copy_highpage() when copy once.

Call Trace:
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
___might_sleep.cold+0x1f3/0x239 kernel/sched/core.c:9182
folio_copy+0x10c/0x1a0 mm/util.c:761
folio_migrate_copy+0x19/0x30 mm/migrate.c:619
__buffer_migrate_page+0x820/0xa80 mm/migrate.c:757
move_to_new_page+0x339/0xf00 mm/migrate.c:904
__unmap_and_move mm/migrate.c:1069 [inline]
unmap_and_move mm/migrate.c:1210 [inline]
migrate_pages+0x2867/0x3890 mm/migrate.c:1487
compact_zone+0x1abb/0x3860 mm/compaction.c:2393
kcompactd_do_work+0x2c9/0x730 mm/compaction.c:2808
kcompactd+0x262/0xd10 mm/compaction.c:2903
kthread+0x3e5/0x4d0 kernel/kthread.c:319
 
Reported-by: syzbot+bb4c69145b4a52b40b27@syzkaller.appspotmail.com
Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 mm/folio-compat.c |  6 ------
 mm/migrate.c      | 15 +++++++++++----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 5b6ae1d..13ec6aa
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -64,12 +64,6 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	folio_migrate_flags(page_folio(newpage), page_folio(page));
 }
 EXPORT_SYMBOL(migrate_page_states);
-
-void migrate_page_copy(struct page *newpage, struct page *page)
-{
-	folio_migrate_copy(page_folio(newpage), page_folio(page));
-}
-EXPORT_SYMBOL(migrate_page_copy);
 #endif
 
 bool set_page_writeback(struct page *page)
diff --git a/mm/migrate.c b/mm/migrate.c
index 7d06515..8fb796b
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -614,12 +614,19 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
 }
 EXPORT_SYMBOL(folio_migrate_flags);
 
-void folio_migrate_copy(struct folio *newfolio, struct folio *folio)
+void migrate_page_copy(struct page *newpage, struct page *page)
 {
-	folio_copy(newfolio, folio);
+	struct folio *newfolio = page_folio(newpage);
+	struct folio *folio = page_folio(page);
+
+	if (PageHuge(page) || PageTransHuge(page))
+		folio_copy(newfolio, folio);
+	else
+		copy_highpage(newpage, page);
+
 	folio_migrate_flags(newfolio, folio);
 }
-EXPORT_SYMBOL(folio_migrate_copy);
+EXPORT_SYMBOL(migrate_page_copy);
 
 /************************************************************
  *                    Migration functions
@@ -647,7 +654,7 @@ int migrate_page(struct address_space *mapping,
 		return rc;
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
-		folio_migrate_copy(newfolio, folio);
+		migrate_page_copy(newpage, page);
 	else
 		folio_migrate_flags(newfolio, folio);
 	return MIGRATEPAGE_SUCCESS;
-- 
2.7.4

