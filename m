Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB39C34E84B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbhC3NDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:03:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15043 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhC3NDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:03:22 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8qLg16nczPmtb;
        Tue, 30 Mar 2021 21:00:43 +0800 (CST)
Received: from huawei.com (10.175.103.91) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 21:03:15 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>
CC:     <asmadeus@codewreck.org>
Subject: [PATCH -next] fs: 9p: fix wrong pointer passed to IS_ERR() and PTR_ERR()
Date:   Tue, 30 Mar 2021 21:06:32 +0800
Message-ID: <20210330130632.1054357-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IS_ERR() and PTR_ERR() use wrong pointer, it should be
writeback_fid, fix it.

Fixes: 5bfe97d7382b ("9p: Fix writeback fid incorrectly being attached to dentry")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 fs/9p/vfs_file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
index 649f04f112dc..59c32c9b799f 100644
--- a/fs/9p/vfs_file.c
+++ b/fs/9p/vfs_file.c
@@ -86,8 +86,8 @@ int v9fs_file_open(struct inode *inode, struct file *file)
 		 * to work.
 		 */
 		writeback_fid = v9fs_writeback_fid(file_dentry(file));
-		if (IS_ERR(fid)) {
-			err = PTR_ERR(fid);
+		if (IS_ERR(writeback_fid)) {
+			err = PTR_ERR(writeback_fid);
 			mutex_unlock(&v9inode->v_mutex);
 			goto out_error;
 		}
-- 
2.25.1

