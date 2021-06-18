Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90BB3AC0A0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhFRBw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:52:27 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:7365 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhFRBwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:52:25 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G5hbS4lVHz6y4Z;
        Fri, 18 Jun 2021 09:46:12 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:50:13 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 09:50:13 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Jan Kara <jack@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] quota: remove unnecessary oom message
Date:   Fri, 18 Jun 2021 09:47:20 +0800
Message-ID: <20210618014720.1977-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210618014720.1977-1-thunder.leizhen@huawei.com>
References: <20210618014720.1977-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory. After that, the static
function getdqbuf() becomes unnecessary, get rid of it and instead call
kmalloc() directly.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/quota/quota_tree.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/fs/quota/quota_tree.c b/fs/quota/quota_tree.c
index c5562c871c8b..d3e995e1046f 100644
--- a/fs/quota/quota_tree.c
+++ b/fs/quota/quota_tree.c
@@ -47,15 +47,6 @@ static int qtree_dqstr_in_blk(struct qtree_mem_dqinfo *info)
 	       / info->dqi_entry_size;
 }
 
-static char *getdqbuf(size_t size)
-{
-	char *buf = kmalloc(size, GFP_NOFS);
-	if (!buf)
-		printk(KERN_WARNING
-		       "VFS: Not enough memory for quota buffers.\n");
-	return buf;
-}
-
 static ssize_t read_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
 {
 	struct super_block *sb = info->dqi_sb;
@@ -83,7 +74,7 @@ static ssize_t write_blk(struct qtree_mem_dqinfo *info, uint blk, char *buf)
 /* Remove empty block from list and return it */
 static int get_free_dqblk(struct qtree_mem_dqinfo *info)
 {
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
 	int ret, blk;
 
@@ -132,7 +123,7 @@ static int put_free_dqblk(struct qtree_mem_dqinfo *info, char *buf, uint blk)
 static int remove_free_dqentry(struct qtree_mem_dqinfo *info, char *buf,
 			       uint blk)
 {
-	char *tmpbuf = getdqbuf(info->dqi_usable_bs);
+	char *tmpbuf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
 	uint nextblk = le32_to_cpu(dh->dqdh_next_free);
 	uint prevblk = le32_to_cpu(dh->dqdh_prev_free);
@@ -179,7 +170,7 @@ static int remove_free_dqentry(struct qtree_mem_dqinfo *info, char *buf,
 static int insert_free_dqentry(struct qtree_mem_dqinfo *info, char *buf,
 			       uint blk)
 {
-	char *tmpbuf = getdqbuf(info->dqi_usable_bs);
+	char *tmpbuf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	struct qt_disk_dqdbheader *dh = (struct qt_disk_dqdbheader *)buf;
 	int err;
 
@@ -227,7 +218,7 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 {
 	uint blk, i;
 	struct qt_disk_dqdbheader *dh;
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	char *ddquot;
 
 	*err = 0;
@@ -298,7 +289,7 @@ static uint find_free_dqentry(struct qtree_mem_dqinfo *info,
 static int do_insert_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			  uint *treeblk, int depth)
 {
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0, newson = 0, newact = 0;
 	__le32 *ref;
 	uint newblk;
@@ -375,7 +366,7 @@ int qtree_write_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
 	int type = dquot->dq_id.type;
 	struct super_block *sb = dquot->dq_sb;
 	ssize_t ret;
-	char *ddquot = getdqbuf(info->dqi_entry_size);
+	char *ddquot = kmalloc(info->dqi_entry_size, GFP_NOFS);
 
 	if (!ddquot)
 		return -ENOMEM;
@@ -414,7 +405,7 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 			uint blk)
 {
 	struct qt_disk_dqdbheader *dh;
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0;
 
 	if (!buf)
@@ -474,7 +465,7 @@ static int free_dqentry(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 static int remove_tree(struct qtree_mem_dqinfo *info, struct dquot *dquot,
 		       uint *blk, int depth)
 {
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	int ret = 0;
 	uint newblk;
 	__le32 *ref = (__le32 *)buf;
@@ -533,7 +524,7 @@ EXPORT_SYMBOL(qtree_delete_dquot);
 static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 				 struct dquot *dquot, uint blk)
 {
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	loff_t ret = 0;
 	int i;
 	char *ddquot;
@@ -571,7 +562,7 @@ static loff_t find_block_dqentry(struct qtree_mem_dqinfo *info,
 static loff_t find_tree_dqentry(struct qtree_mem_dqinfo *info,
 				struct dquot *dquot, uint blk, int depth)
 {
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	loff_t ret = 0;
 	__le32 *ref = (__le32 *)buf;
 
@@ -635,7 +626,7 @@ int qtree_read_dquot(struct qtree_mem_dqinfo *info, struct dquot *dquot)
 		}
 		dquot->dq_off = offset;
 	}
-	ddquot = getdqbuf(info->dqi_entry_size);
+	ddquot = kmalloc(info->dqi_entry_size, GFP_NOFS);
 	if (!ddquot)
 		return -ENOMEM;
 	ret = sb->s_op->quota_read(sb, type, ddquot, info->dqi_entry_size,
@@ -679,7 +670,7 @@ EXPORT_SYMBOL(qtree_release_dquot);
 static int find_next_id(struct qtree_mem_dqinfo *info, qid_t *id,
 			unsigned int blk, int depth)
 {
-	char *buf = getdqbuf(info->dqi_usable_bs);
+	char *buf = kmalloc(info->dqi_usable_bs, GFP_NOFS);
 	__le32 *ref = (__le32 *)buf;
 	ssize_t ret;
 	unsigned int epb = info->dqi_usable_bs >> 2;
-- 
2.25.1


