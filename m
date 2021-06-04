Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A8539AFD5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbhFDBeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:34:07 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4295 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhFDBeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:34:05 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fx4rP46XSz1BH0G;
        Fri,  4 Jun 2021 09:27:33 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:32:17 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <richard@nod.at>, Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] ubifs: Fix spelling mistakes
Date:   Fri, 4 Jun 2021 09:45:56 +0800
Message-ID: <20210604014556.2086341-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme760-chm.china.huawei.com (10.3.19.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some spelling mistakes in comments:
withoug  ==> without
numer  ==> number
aswell  ==> as well
referes  ==> refers
childs  ==> children
unnecesarry  ==> unnecessary

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/ubifs/journal.c    | 2 +-
 fs/ubifs/master.c     | 2 +-
 fs/ubifs/replay.c     | 2 +-
 fs/ubifs/super.c      | 2 +-
 fs/ubifs/tnc_commit.c | 2 +-
 fs/ubifs/ubifs.h      | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 2857e64d673d..298d87891a8e 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -1431,7 +1431,7 @@ int ubifs_jnl_rename(struct ubifs_info *c, const struct inode *old_dir,
 /**
  * truncate_data_node - re-compress/encrypt a truncated data node.
  * @c: UBIFS file-system description object
- * @inode: inode which referes to the data node
+ * @inode: inode which refers to the data node
  * @block: data block number
  * @dn: data node to re-compress
  * @new_len: new length
diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
index 0df9a3dd0aaa..7adc37c10b6a 100644
--- a/fs/ubifs/master.c
+++ b/fs/ubifs/master.c
@@ -37,7 +37,7 @@ int ubifs_compare_master_node(struct ubifs_info *c, void *m1, void *m2)
 		return ret;
 
 	/*
-	 * Do not compare the embedded HMAC aswell which also must be different
+	 * Do not compare the embedded HMAC as well which also must be different
 	 * due to the different common node header.
 	 */
 	behind = hmac_offs + UBIFS_MAX_HMAC_LEN;
diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 382a54c82930..5260d3e531bb 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -296,7 +296,7 @@ static int apply_replay_entry(struct ubifs_info *c, struct replay_entry *r)
  * @b: second replay entry
  *
  * This is a comparios function for 'list_sort()' which compares 2 replay
- * entries @a and @b by comparing their sequence numer.  Returns %1 if @a has
+ * entries @a and @b by comparing their sequence number.  Returns %1 if @a has
  * greater sequence number and %-1 otherwise.
  */
 static int replay_entries_cmp(void *priv, const struct list_head *a,
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 7b572e1414ba..2868586c2dfc 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -2060,7 +2060,7 @@ const struct super_operations ubifs_super_operations = {
  * @mode: UBI volume open mode
  *
  * The primary method of mounting UBIFS is by specifying the UBI volume
- * character device node path. However, UBIFS may also be mounted withoug any
+ * character device node path. However, UBIFS may also be mounted without any
  * character device node using one of the following methods:
  *
  * o ubiX_Y    - mount UBI device number X, volume Y;
diff --git a/fs/ubifs/tnc_commit.c b/fs/ubifs/tnc_commit.c
index 234be1c4dc87..58c92c96ecef 100644
--- a/fs/ubifs/tnc_commit.c
+++ b/fs/ubifs/tnc_commit.c
@@ -930,7 +930,7 @@ static int write_index(struct ubifs_info *c)
 		 * flag cleared before %COW_ZNODE. Specifically, it matters in
 		 * the 'dirty_cow_znode()' function. This is the reason for the
 		 * first barrier. Also, we want the bit changes to be seen to
-		 * other threads ASAP, to avoid unnecesarry copying, which is
+		 * other threads ASAP, to avoid unnecessary copying, which is
 		 * the reason for the second barrier.
 		 */
 		clear_bit(DIRTY_ZNODE, &znode->flags);
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index b65c599a386a..edd0982dc66c 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -912,7 +912,7 @@ struct ubifs_budget_req {
  * @rb: rb-tree node of rb-tree of orphans sorted by inode number
  * @list: list head of list of orphans in order added
  * @new_list: list head of list of orphans added since the last commit
- * @child_list: list of xattr childs if this orphan hosts xattrs, list head
+ * @child_list: list of xattr children if this orphan hosts xattrs, list head
  * if this orphan is a xattr, not used otherwise.
  * @cnext: next orphan to commit
  * @dnext: next orphan to delete
-- 
2.25.1

