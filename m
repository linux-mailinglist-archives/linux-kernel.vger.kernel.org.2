Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 996F6429D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhJLFv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:51:56 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:58989 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229688AbhJLFv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:51:56 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UrY4FKf_1634017792;
Received: from localhost.localdomain(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UrY4FKf_1634017792)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Oct 2021 13:49:53 +0800
From:   Xin Hao <xhao@linux.alibaba.com>
To:     sjpark@amazon.de
Cc:     xhao@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/dbgfs: add region_stat interface
Date:   Tue, 12 Oct 2021 13:49:48 +0800
Message-Id: <20211012054948.90381-1-xhao@linux.alibaba.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using damon-dbgfs has brought great convenience to user-mode
operation damon, but sometimes if i want to be able to view
the division of task regions, nr_access values etc,but i found
that it is impossible to view directly through the dbgfs interface,
so there i add a interface "region_stat", it displays like this.

 # cat region_stat
 last_aggregation=120.87s
 target_id=5148
 nr_regions=10
 400000-258c000(34352 KiB): 1
 258c000-4719000(34356 KiB): 0
 4719000-abbf000(103064 KiB): 0
 abbf000-c4d4000(25684 KiB): 11
 c4d4000-ff5c000(59936 KiB): 15
 ff5c000-152f9000(85620 KiB): 20
 152f9000-1599e000(6804 KiB): 10
 1599e000-19573000(61268 KiB): 0
 19573000-1f92c000(102116 KiB): 0
 1f92c000-22a4c000(50304 KiB): 0

Signed-off-by: Xin Hao <xhao@linux.alibaba.com>
---
 mm/damon/dbgfs.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index faee070977d8..269a336e92f0 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -266,6 +266,57 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 	return len;
 }
 
+static ssize_t dbgfs_region_stat_read(struct file *file,
+		char __user *buf, size_t count, loff_t *ppos)
+{
+	struct damon_ctx *ctx = file->private_data;
+	struct damon_target *t;
+	char *kbuf;
+	ssize_t len;
+	int id, rc, written = 0;
+
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	mutex_lock(&ctx->kdamond_lock);
+	damon_for_each_target(t, ctx) {
+		struct damon_region *r;
+
+		if (targetid_is_pid(ctx))
+			id = (int)pid_vnr((struct pid *)t->id);
+
+		rc = scnprintf(&kbuf[written], count - written,
+				"last_aggregation=%lld.%lds\ntarget_id=%d\nnr_regions=%u\n",
+				ctx->last_aggregation.tv_sec,
+				ctx->last_aggregation.tv_nsec / 1000000,
+				id, t->nr_regions);
+		if (!rc)
+			goto out;
+
+		written += rc;
+
+		damon_for_each_region(r, t) {
+			rc = scnprintf(&kbuf[written], count - written,
+				       "%lx-%lx(%lu KiB): %u\n",
+				       r->ar.start, r->ar.end,
+					   (r->ar.end - r->ar.start) >> 10,
+					   r->nr_accesses);
+			if (!rc)
+				goto out;
+
+			written += rc;
+		}
+
+		len += simple_read_from_buffer(buf, count, ppos, kbuf, written);
+	}
+
+out:
+	mutex_unlock(&ctx->kdamond_lock);
+	kfree(kbuf);
+	return len;
+}
+
 static int damon_dbgfs_open(struct inode *inode, struct file *file)
 {
 	file->private_data = inode->i_private;
@@ -290,12 +341,17 @@ static const struct file_operations kdamond_pid_fops = {
 	.read = dbgfs_kdamond_pid_read,
 };
 
+static const struct file_operations region_stat_fops = {
+	.open = damon_dbgfs_open,
+	.read = dbgfs_region_stat_read,
+};
+
 static void dbgfs_fill_ctx_dir(struct dentry *dir, struct damon_ctx *ctx)
 {
 	const char * const file_names[] = {"attrs", "target_ids",
-		"kdamond_pid"};
+		"kdamond_pid", "region_stat"};
 	const struct file_operations *fops[] = {&attrs_fops, &target_ids_fops,
-		&kdamond_pid_fops};
+		&kdamond_pid_fops, &region_stat_fops};
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(file_names); i++)
-- 
2.27.0

