Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18278352A7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 14:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbhDBMMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 08:12:12 -0400
Received: from m12-11.163.com ([220.181.12.11]:59259 "EHLO m12-11.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBMMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 08:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mGoUT
        l8kqayttdL1VREEMYNyzZHUEANXE7LVNQNMDNs=; b=FUXi5zgI050NW5QECdgpz
        ptVIARKy0PxB24NpCRx5juqPreFr9Btm9Oz5MsAyIKezd4XsYohXD68CkaZElrL4
        1x/VA0pz/3/SA/G2nfZPoVo3B7wb+JSFcCRZdRpE21Jia4wT3Pk98R01m8hPR6/j
        kPgFCwNhxrP78jVk7Ddj6Q=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp7 (Coremail) with SMTP id C8CowADHsorzCWdgsOdAVQ--.12928S2;
        Fri, 02 Apr 2021 20:11:34 +0800 (CST)
From:   zuoqilin1@163.com
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] fs/debugfs: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Fri,  2 Apr 2021 20:11:41 +0800
Message-Id: <20210402121141.82-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowADHsorzCWdgsOdAVQ--.12928S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury5ZF18uw48AFW8JF4UXFb_yoW8WFyDpa
        n5Ca45Kr4xArWDCryFkF1UZ34S9r93XF4kuF92v3ySyw1v9rn5tF4YyFWjyryjgry8Ww10
        qw15KryUXF1rCr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbsqXUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipRVniVUMdJmefwACsJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 fs/debugfs/file.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 686e0ad..d670ca3 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1045,7 +1045,7 @@ void debugfs_print_regs32(struct seq_file *s, const struct debugfs_reg32 *regs,
 }
 EXPORT_SYMBOL_GPL(debugfs_print_regs32);
 
-static int debugfs_show_regset32(struct seq_file *s, void *data)
+static int regset32_show(struct seq_file *s, void *data)
 {
 	struct debugfs_regset32 *regset = s->private;
 
@@ -1060,17 +1060,7 @@ static int debugfs_show_regset32(struct seq_file *s, void *data)
 	return 0;
 }
 
-static int debugfs_open_regset32(struct inode *inode, struct file *file)
-{
-	return single_open(file, debugfs_show_regset32, inode->i_private);
-}
-
-static const struct file_operations fops_regset32 = {
-	.open =		debugfs_open_regset32,
-	.read =		seq_read,
-	.llseek =	seq_lseek,
-	.release =	single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(regset32);
 
 /**
  * debugfs_create_regset32 - create a debugfs file that returns register values
@@ -1091,7 +1081,7 @@ void debugfs_create_regset32(const char *name, umode_t mode,
 			     struct dentry *parent,
 			     struct debugfs_regset32 *regset)
 {
-	debugfs_create_file(name, mode, parent, regset, &fops_regset32);
+	debugfs_create_file(name, mode, parent, regset, &regset32_fops);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_regset32);
 
-- 
1.9.1

