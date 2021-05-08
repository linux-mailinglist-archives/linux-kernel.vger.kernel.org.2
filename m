Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDCE376F23
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 05:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEHDek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 23:34:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:18373 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhEHDei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 23:34:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FcXsr4sLTzlbyJ;
        Sat,  8 May 2021 11:31:28 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Sat, 8 May 2021 11:33:26 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ubifs: journal: Fix error return code in ubifs_jnl_write_inode()
Date:   Sat, 8 May 2021 11:33:13 +0800
Message-ID: <20210508033313.2227-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return a negative error code from the error handling case instead
of 0, as done elsewhere in this function.

Fixes: 9ca2d7326444 ("ubifs: Limit number of xattrs per inode")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/ubifs/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 2857e64d673d..230717384a38 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -882,6 +882,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 		struct ubifs_dent_node *xent, *pxent = NULL;
 
 		if (ui->xattr_cnt > ubifs_xattr_max_cnt(c)) {
+			err = -EPERM;
 			ubifs_err(c, "Cannot delete inode, it has too much xattrs!");
 			goto out_release;
 		}
-- 
2.25.1


