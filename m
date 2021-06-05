Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C49139C633
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFEGZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:25:10 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3434 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFEGZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:25:10 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FxqHm4QLFz6tlB
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 14:20:20 +0800 (CST)
Received: from dggpeml500020.china.huawei.com (7.185.36.88) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 5 Jun 2021 14:23:20 +0800
Received: from huawei.com (10.175.127.227) by dggpeml500020.china.huawei.com
 (7.185.36.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 5 Jun 2021
 14:23:20 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <yangjihong1@huawei.com>, <yukuai3@huawei.com>,
        <libaokun1@huawei.com>
Subject: [PATCH -next] devpts: fix doc warnings in inode.c
Date:   Sat, 5 Jun 2021 14:32:35 +0800
Message-ID: <20210605063235.682889-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
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

Fixes the following W=1 kernel build warning(s):

fs/devpts/inode.c:563: warning:
 Function parameter or member 'fsi' not described in 'devpts_pty_new'
fs/devpts/inode.c:563: warning:
 Excess function parameter 'ptmx_inode' description in 'devpts_pty_new'
fs/devpts/inode.c:563: warning:
 Excess function parameter 'device' description in 'devpts_pty_new'
fs/devpts/inode.c:606: warning:
 Function parameter or member 'dentry' not described in 'devpts_get_priv'
fs/devpts/inode.c:606: warning:
 Excess function parameter 'pts_inode' description in 'devpts_get_priv'
fs/devpts/inode.c:619: warning:
 Function parameter or member 'dentry' not described in 'devpts_pty_kill'
fs/devpts/inode.c:619: warning:
 Excess function parameter 'inode' description in 'devpts_pty_kill'

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/devpts/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d33c..d739f1b303f4 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -552,8 +552,7 @@ void devpts_kill_index(struct pts_fs_info *fsi, int idx)
 
 /**
  * devpts_pty_new -- create a new inode in /dev/pts/
- * @ptmx_inode: inode of the master
- * @device: major+minor of the node to be created
+ * @fsi: pointer to pts_fs_info
  * @index: used as a name of the node
  * @priv: what's given back by devpts_get_priv
  *
@@ -598,7 +597,7 @@ struct dentry *devpts_pty_new(struct pts_fs_info *fsi, int index, void *priv)
 
 /**
  * devpts_get_priv -- get private data for a slave
- * @pts_inode: inode of the slave
+ * @dentry: dentry of the slave
  *
  * Returns whatever was passed as priv in devpts_pty_new for a given inode.
  */
@@ -611,7 +610,7 @@ void *devpts_get_priv(struct dentry *dentry)
 
 /**
  * devpts_pty_kill -- remove inode form /dev/pts/
- * @inode: inode of the slave to be removed
+ * @dentry: dentry of the slave to be removed
  *
  * This is an inverse operation of devpts_pty_new.
  */
-- 
2.31.1

