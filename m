Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57144FCB2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 02:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbhKOBWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 20:22:38 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:30939 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhKOBWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 20:22:17 -0500
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hsrnb6cp6zcbH3;
        Mon, 15 Nov 2021 09:14:27 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 15 Nov 2021 09:19:21 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Mon, 15 Nov
 2021 09:19:20 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <libaokun1@huawei.com>, <yukuai3@huawei.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: [PATCH -next 1/3] ubifs: fix slab-out-of-bounds in ubifs_change_lp
Date:   Mon, 15 Nov 2021 09:31:42 +0800
Message-ID: <20211115013144.2479319-2-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211115013144.2479319-1-libaokun1@huawei.com>
References: <20211115013144.2479319-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500020.china.huawei.com (7.185.36.88)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hulk Robot reported a KASAN report about slab-out-of-bounds:
 ==================================================================
 BUG: KASAN: slab-out-of-bounds in ubifs_change_lp+0x3a9/0x1390 [ubifs]
 Read of size 8 at addr ffff888101c961f8 by task fsstress/1068
 [...]
 Call Trace:
  check_memory_region+0x1c1/0x1e0
  ubifs_change_lp+0x3a9/0x1390 [ubifs]
  ubifs_change_one_lp+0x170/0x220 [ubifs]
  ubifs_garbage_collect+0x7f9/0xda0 [ubifs]
  ubifs_budget_space+0xfe4/0x1bd0 [ubifs]
  ubifs_write_begin+0x528/0x10c0 [ubifs]

 Allocated by task 1068:
  kmemdup+0x25/0x50
  ubifs_lpt_lookup_dirty+0x372/0xb00 [ubifs]
  ubifs_update_one_lp+0x46/0x260 [ubifs]
  ubifs_tnc_end_commit+0x98b/0x1720 [ubifs]
  do_commit+0x6cb/0x1950 [ubifs]
  ubifs_run_commit+0x15a/0x2b0 [ubifs]
  ubifs_budget_space+0x1061/0x1bd0 [ubifs]
  ubifs_write_begin+0x528/0x10c0 [ubifs]
 [...]
 ==================================================================

In ubifs_garbage_collect(), if ubifs_find_dirty_leb returns an error,
lp is an uninitialized variable. But lp.num might be used in the out
branch, which is a random value. If the value is -1 or another value
that can pass the check, soob may occur in the ubifs_change_lp() in
the following procedure.

To solve this problem, we initialize lp.lnum to -1, and then initialize
it correctly in ubifs_find_dirty_leb, which is not equal to -1, and
ubifs_return_leb is executed only when lp.lnum != -1.

if find a retained or indexing LEB and continue to next loop, but break
before find another LEB, the "taken" flag of this LEB will be cleaned
in ubi_return_lebi(). This bug has also been fixed in this patch.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ubifs/gc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index dc3e26e9ed7b..05e1eeae8457 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -692,6 +692,9 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 	for (i = 0; ; i++) {
 		int space_before, space_after;
 
+		/* Maybe continue after find and break before find */
+		lp.lnum = -1;
+
 		cond_resched();
 
 		/* Give the commit an opportunity to run */
@@ -843,7 +846,8 @@ int ubifs_garbage_collect(struct ubifs_info *c, int anyway)
 	ubifs_wbuf_sync_nolock(wbuf);
 	ubifs_ro_mode(c, ret);
 	mutex_unlock(&wbuf->io_mutex);
-	ubifs_return_leb(c, lp.lnum);
+	if (lp.lnum != -1)
+		ubifs_return_leb(c, lp.lnum);
 	return ret;
 }
 
-- 
2.31.1

