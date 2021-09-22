Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C897414248
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 09:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhIVHIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 03:08:21 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:57710 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233051AbhIVHIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 03:08:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R631e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UpCSO0C_1632294405;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UpCSO0C_1632294405)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 15:06:47 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, cfijalkovich@google.com,
        willy@infradead.org, song@kernel.org, william.kucharski@oracle.com,
        hughd@google.com
Subject: [PATCH v2 1/2] mm, thp: check page mapping when truncating page cache
Date:   Wed, 22 Sep 2021 15:06:44 +0800
Message-Id: <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Transparent huge page has supported read-only non-shmem files. The file-
backed THP is collapsed by khugepaged and truncated when written (for
shared libraries).

However, there is race in two possible places.

1) multiple writers truncate the same page cache concurrently;
2) collapse_file rolls back when writer truncates the page cache;

In both cases, subpage(s) of file THP can be revealed by find_get_entry
in truncate_inode_pages_range, which will trigger PageTail BUG_ON in
truncate_inode_page, as follows.

[40326.247034] page:000000009e420ff2 refcount:1 mapcount:0 mapping:0000000000000000 index:0x7ff pfn:0x50c3ff
[40326.247041] head:0000000075ff816d order:9 compound_mapcount:0 compound_pincount:0
[40326.247046] flags: 0x37fffe0000010815(locked|uptodate|lru|arch_1|head)
[40326.247051] raw: 37fffe0000000000 fffffe0013108001 dead000000000122 dead000000000400
[40326.247053] raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
[40326.247055] head: 37fffe0000010815 fffffe001066bd48 ffff000404183c20 0000000000000000
[40326.247057] head: 0000000000000600 0000000000000000 00000001ffffffff ffff000c0345a000
[40326.247058] page dumped because: VM_BUG_ON_PAGE(PageTail(page))
[40326.247077] ------------[ cut here ]------------
[40326.247080] kernel BUG at mm/truncate.c:213!
[40326.280581] Internal error: Oops - BUG: 0 [#1] SMP
[40326.281077] Modules linked in: xfs(E) libcrc32c(E) rfkill(E) ...
[40326.285130] CPU: 14 PID: 11394 Comm: check_madvise_d Kdump: ...
[40326.286202] Hardware name: ECS, BIOS 0.0.0 02/06/2015
[40326.286968] pstate: 60400005 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[40326.287584] pc : truncate_inode_page+0x64/0x70
[40326.288040] lr : truncate_inode_page+0x64/0x70
[40326.288498] sp : ffff80001b60b900
[40326.288837] x29: ffff80001b60b900 x28: 00000000000007ff
[40326.289377] x27: ffff80001b60b9a0 x26: 0000000000000000
[40326.289943] x25: 000000000000000f x24: ffff80001b60b9a0
[40326.290485] x23: ffff80001b60ba18 x22: ffff0001e0999ea8
[40326.291027] x21: ffff0000c21db300 x20: ffffffffffffffff
[40326.291566] x19: fffffe001310ffc0 x18: 0000000000000020
[40326.292106] x17: 0000000000000000 x16: 0000000000000000
[40326.292655] x15: ffff0000c21db960 x14: 3030306666666620
[40326.293197] x13: 6666666666666666 x12: 3130303030303030
[40326.293746] x11: ffff8000117b69b8 x10: 00000000ffff8000
[40326.294313] x9 : ffff80001012690c x8 : 0000000000000000
[40326.294851] x7 : ffff8000114f69b8 x6 : 0000000000017ffd
[40326.295392] x5 : ffff0007fffbcbc8 x4 : ffff80001b60b5c0
[40326.295942] x3 : 0000000000000001 x2 : 0000000000000000
[40326.296497] x1 : 0000000000000000 x0 : 0000000000000000
[40326.297047] Call trace:
[40326.297304]  truncate_inode_page+0x64/0x70
[40326.297724]  truncate_inode_pages_range+0x550/0x7e4
[40326.298251]  truncate_pagecache+0x58/0x80
[40326.298662]  do_dentry_open+0x1e4/0x3c0
[40326.299052]  vfs_open+0x38/0x44
[40326.299377]  do_open+0x1f0/0x310
[40326.299709]  path_openat+0x114/0x1dc
[40326.300077]  do_filp_open+0x84/0x134
[40326.300444]  do_sys_openat2+0xbc/0x164
[40326.300825]  __arm64_sys_openat+0x74/0xc0
[40326.301236]  el0_svc_common.constprop.0+0x88/0x220
[40326.301723]  do_el0_svc+0x30/0xa0
[40326.302089]  el0_svc+0x20/0x30
[40326.302404]  el0_sync_handler+0x1a4/0x1b0
[40326.302814]  el0_sync+0x180/0x1c0
[40326.303157] Code: aa0103e0 900061e1 910ec021 9400d300 (d4210000)
[40326.303775] ---[ end trace f70cdb42cb7c2d42 ]---
[40326.304244] Kernel panic - not syncing: Oops - BUG: Fatal exception

This checks the page mapping and retries when subpage of file THP is
found, in truncate_inode_pages_range.

Fixes: eb6ecbed0aa2 ("mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs")
Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>
Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 mm/filemap.c  |  7 ++++++-
 mm/truncate.c | 17 ++++++++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293..a3af2ec 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2093,7 +2093,6 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 		if (!xa_is_value(page)) {
 			if (page->index < start)
 				goto put;
-			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
 			if (page->index + thp_nr_pages(page) - 1 > end)
 				goto put;
 			if (!trylock_page(page))
@@ -2102,6 +2101,12 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t start,
 				goto unlock;
 			VM_BUG_ON_PAGE(!thp_contains(page, xas.xa_index),
 					page);
+			/*
+			 * We can find and get head page of file THP with
+			 * non-head index. The head page should have already
+			 * be truncated with page->mapping reset to NULL.
+			 */
+			VM_BUG_ON_PAGE(page->index != xas.xa_index, page);
 		}
 		indices[pvec->nr] = xas.xa_index;
 		if (!pagevec_add(pvec, page))
diff --git a/mm/truncate.c b/mm/truncate.c
index 714eaf1..3f47190 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -319,7 +319,8 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	index = start;
 	while (index < end && find_lock_entries(mapping, index, end - 1,
 			&pvec, indices)) {
-		index = indices[pagevec_count(&pvec) - 1] + 1;
+		index = indices[pagevec_count(&pvec) - 1] +
+			thp_nr_pages(pvec.pages[pagevec_count(&pvec) - 1]);
 		truncate_exceptional_pvec_entries(mapping, &pvec, indices);
 		for (i = 0; i < pagevec_count(&pvec); i++)
 			truncate_cleanup_page(pvec.pages[i]);
@@ -392,6 +393,20 @@ void truncate_inode_pages_range(struct address_space *mapping,
 				continue;
 
 			lock_page(page);
+			/*
+			 * Already truncated? We can find and get subpage
+			 * of file THP, of which the head page is truncated.
+			 *
+			 * In addition, another race will be avoided, where
+			 * collapse_file rolls back when writer truncates the
+			 * page cache.
+			 */
+			if (page_mapping(page) != mapping) {
+				unlock_page(page);
+				/* Restart to make sure all gone */
+				index = start - 1;
+				break;
+			}
 			WARN_ON(page_to_index(page) != index);
 			wait_on_page_writeback(page);
 			truncate_inode_page(mapping, page);
-- 
1.8.3.1

