Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF234890F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 07:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCYGYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 02:24:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13691 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbhCYGYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:24:05 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5ZkJ6njnznWBW;
        Thu, 25 Mar 2021 14:21:28 +0800 (CST)
Received: from ubuntu.huawei.com (10.67.174.117) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 14:23:51 +0800
From:   Ruiqi Gong <gongruiqi1@huawei.com>
To:     <jaegeuk@kernel.org>, <chao@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <gongruiqi1@huawei.com>
Subject: [PATCH -next] f2fs: fix a typo in inode.c
Date:   Thu, 25 Mar 2021 02:38:11 -0400
Message-ID: <20210325063811.6486-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.117]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do a trivial typo fix.
s/runing/running

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ruiqi Gong <gongruiqi1@huawei.com>
---
 fs/f2fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 349d9cb933ee..5d2253d53f17 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -698,7 +698,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 
 	/*
 	 * We need to balance fs here to prevent from producing dirty node pages
-	 * during the urgent cleaning time when runing out of free sections.
+	 * during the urgent cleaning time when running out of free sections.
 	 */
 	f2fs_update_inode_page(inode);
 	if (wbc && wbc->nr_to_write)
-- 
2.17.1

