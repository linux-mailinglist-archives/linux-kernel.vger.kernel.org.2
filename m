Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4296B395AC9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhEaMon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 08:44:43 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2419 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbhEaMoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 08:44:38 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FtvxH2S5vz65QG;
        Mon, 31 May 2021 20:39:15 +0800 (CST)
Received: from dggema761-chm.china.huawei.com (10.1.198.203) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 31 May 2021 20:42:53 +0800
Received: from huawei.com (10.175.127.227) by dggema761-chm.china.huawei.com
 (10.1.198.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 31
 May 2021 20:42:52 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <richard@nod.at>, <yangds.fnst@cn.fujitsu.com>,
        <s.hauer@pengutronix.de>
CC:     <yi.zhang@huawei.com>, <houtao1@huawei.com>, <yukuai3@huawei.com>,
        <chengzhihao1@huawei.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ubifs: Remove ui_mutex in ubifs_xattr_get and change_xattr
Date:   Mon, 31 May 2021 20:52:10 +0800
Message-ID: <20210531125210.1173922-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210531125210.1173922-1-chengzhihao1@huawei.com>
References: <20210531125210.1173922-1-chengzhihao1@huawei.com>
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

Since ubifs_xattr_get and ubifs_xattr_set cannot being executed
parallelly after importing @host_ui->xattr_sem, now we can remove
ui_mutex imported by commit ab92a20bce3b4c2 ("ubifs: make
ubifs_[get|set]xattr atomic").

@xattr_size, @xattr_names and @xattr_cnt can't be out of protection
by @host_ui->mutex yet, they are sill accesed in other places, such as
pack_inode() called by ubifs_write_inode() triggered by page-writeback.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/ubifs/xattr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 1fce27e9b769..e4f193eae4b2 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -208,13 +208,11 @@ static int change_xattr(struct ubifs_info *c, struct inode *host,
 		err = -ENOMEM;
 		goto out_free;
 	}
-	mutex_lock(&ui->ui_mutex);
 	kfree(ui->data);
 	ui->data = buf;
 	inode->i_size = ui->ui_size = size;
 	old_size = ui->data_len;
 	ui->data_len = size;
-	mutex_unlock(&ui->ui_mutex);
 
 	mutex_lock(&host_ui->ui_mutex);
 	host->i_ctime = current_time(host);
@@ -362,7 +360,6 @@ ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 	ubifs_assert(c, inode->i_size == ui->data_len);
 	ubifs_assert(c, ubifs_inode(host)->xattr_size > ui->data_len);
 
-	mutex_lock(&ui->ui_mutex);
 	if (buf) {
 		/* If @buf is %NULL we are supposed to return the length */
 		if (ui->data_len > size) {
@@ -375,7 +372,6 @@ ssize_t ubifs_xattr_get(struct inode *host, const char *name, void *buf,
 	err = ui->data_len;
 
 out_iput:
-	mutex_unlock(&ui->ui_mutex);
 	iput(inode);
 out_cleanup:
 	up_read(&ubifs_inode(host)->xattr_sem);
-- 
2.25.4

