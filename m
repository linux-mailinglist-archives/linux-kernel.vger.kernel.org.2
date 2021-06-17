Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D1F3AAF35
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 10:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhFQJBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 05:01:19 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4832 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhFQJBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 05:01:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G5G7f3qFfzXfMq;
        Thu, 17 Jun 2021 16:54:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:59:09 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 16:59:08 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     David Woodhouse <dwmw2@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] jffs2: remove unnecessary oom message
Date:   Thu, 17 Jun 2021 16:59:05 +0800
Message-ID: <20210617085905.1385-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes scripts/checkpatch.pl warning:
WARNING: Possible unnecessary 'out of memory' message

Remove it can help us save a bit of memory.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 fs/jffs2/compr.c | 16 +++++-----------
 fs/jffs2/dir.c   |  1 -
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/jffs2/compr.c b/fs/jffs2/compr.c
index 4849a4c9a0e2..700a2de39b08 100644
--- a/fs/jffs2/compr.c
+++ b/fs/jffs2/compr.c
@@ -80,10 +80,8 @@ static int jffs2_selected_compress(u8 compr, unsigned char *data_in,
 	char *output_buf;
 
 	output_buf = kmalloc(*cdatalen, GFP_KERNEL);
-	if (!output_buf) {
-		pr_warn("No memory for compressor allocation. Compression failed.\n");
+	if (!output_buf)
 		return ret;
-	}
 	orig_slen = *datalen;
 	orig_dlen = *cdatalen;
 	spin_lock(&jffs2_compressor_list_lock);
@@ -189,15 +187,11 @@ uint16_t jffs2_compress(struct jffs2_sb_info *c, struct jffs2_inode_info *f,
 				spin_unlock(&jffs2_compressor_list_lock);
 				tmp_buf = kmalloc(orig_slen, GFP_KERNEL);
 				spin_lock(&jffs2_compressor_list_lock);
-				if (!tmp_buf) {
-					pr_warn("No memory for compressor allocation. (%d bytes)\n",
-						orig_slen);
+				if (!tmp_buf)
 					continue;
-				}
-				else {
-					this->compr_buf = tmp_buf;
-					this->compr_buf_size = orig_slen;
-				}
+
+				this->compr_buf = tmp_buf;
+				this->compr_buf_size = orig_slen;
 			}
 			this->usecount++;
 			spin_unlock(&jffs2_compressor_list_lock);
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index c0aabbcbfd58..a2f643dd1923 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -353,7 +353,6 @@ static int jffs2_symlink (struct user_namespace *mnt_userns, struct inode *dir_i
 	/* We use f->target field to store the target path. */
 	f->target = kmemdup(target, targetlen + 1, GFP_KERNEL);
 	if (!f->target) {
-		pr_warn("Can't allocate %d bytes of memory\n", targetlen + 1);
 		mutex_unlock(&f->sem);
 		jffs2_complete_reservation(c);
 		ret = -ENOMEM;
-- 
2.25.1


