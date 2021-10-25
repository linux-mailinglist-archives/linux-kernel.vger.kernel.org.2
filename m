Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F212438DCC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhJYDbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:31:13 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29932 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbhJYDau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:30:50 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hd0fZ0jLZzbnKl;
        Mon, 25 Oct 2021 11:23:50 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.15; Mon, 25 Oct 2021 11:28:27 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.15; Mon, 25
 Oct 2021 11:28:26 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <miquel.raynal@bootlin.com>, <vigneshr@ti.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <Artem.Bityutskiy@nokia.com>, <ext-adrian.hunter@nokia.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: [PATCH 08/11] ubifs: setflags: Don't make a budget for 'ui->data_len'
Date:   Mon, 25 Oct 2021 11:41:13 +0800
Message-ID: <20211025034116.3544321-9-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211025034116.3544321-1-chengzhihao1@huawei.com>
References: <20211025034116.3544321-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema761-chm.china.huawei.com (10.1.198.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'setflags()' affects regular files and directories, only xattr inode,
symlink inode and special inode(pipe/char_dev/block_dev) have none-
zero 'ui->data_len' field.

Remove superfluous space budget for 'dirtied_ino_d', besides add an
assert to verify that 'setflags()' only operates ubifs inode with
zero data_len.

Fixes: 1e51764a3c2ac05a ("UBIFS: add new flash file system")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index c6a863487780..ed95e97a3740 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -107,9 +107,9 @@ static int setflags(struct inode *inode, int flags)
 	int err, release;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
-	struct ubifs_budget_req req = { .dirtied_ino = 1,
-					.dirtied_ino_d = ui->data_len };
+	struct ubifs_budget_req req = { .dirtied_ino = 1 };
 
+	ubifs_assert(c, !ui->data_len);
 	err = ubifs_budget_space(c, &req);
 	if (err)
 		return err;
-- 
2.31.1

