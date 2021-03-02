Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4032A34A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378819AbhCBIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:55:14 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13036 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377952AbhCBIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:45:53 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DqVyF3N21zMh6R;
        Tue,  2 Mar 2021 16:43:01 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 16:45:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix compile warning
Date:   Tue, 2 Mar 2021 16:44:58 +0800
Message-ID: <20210302084458.15077-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

node.c: In function ‘f2fs_restore_node_summary’:
./include/linux/minmax.h:18:28: warning: comparison of distinct pointer types lacks a cast
  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                            ^
./include/linux/minmax.h:32:4: note: in expansion of macro ‘__typecheck’
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^
./include/linux/minmax.h:42:24: note: in expansion of macro ‘__safe_cmp’
  __builtin_choose_expr(__safe_cmp(x, y), \
                        ^
./include/linux/minmax.h:51:19: note: in expansion of macro ‘__careful_cmp’
 #define min(x, y) __careful_cmp(x, y, <)
                   ^
node.c:2750:13: note: in expansion of macro ‘min’
   nrpages = min(last_offset - i, BIO_MAX_PAGES);

Use min_t() rather than min() to do type cast before comparing.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a8a0fb890e8d..77f9ffaf9b8e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -2747,7 +2747,8 @@ int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
 	sum_entry = &sum->entries[0];
 
 	for (i = 0; i < last_offset; i += nrpages, addr += nrpages) {
-		nrpages = min(last_offset - i, BIO_MAX_PAGES);
+		nrpages = min_t(unsigned long, last_offset - i,
+						BIO_MAX_PAGES);
 
 		/* readahead node pages */
 		f2fs_ra_meta_pages(sbi, addr, nrpages, META_POR, true);
-- 
2.29.2

