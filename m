Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4821B3875D3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348147AbhERJ40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 05:56:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3017 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348124AbhERJ4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 05:56:22 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkrsC3qG4zlg9R;
        Tue, 18 May 2021 17:52:47 +0800 (CST)
Received: from dggemx753-chm.china.huawei.com (10.0.44.37) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 18 May 2021 17:55:02 +0800
Received: from szvp000207684.huawei.com (10.120.216.130) by
 dggemx753-chm.china.huawei.com (10.0.44.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 18 May 2021 17:55:02 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: compress: fix to disallow wildcard extension for hot/cold file
Date:   Tue, 18 May 2021 17:54:57 +0800
Message-ID: <20210518095458.99728-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggemx753-chm.china.huawei.com (10.0.44.37)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If all files are hot or cold, hot/cold separation is not needed anymore,
so let's disallow configure wildcard extension.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  |  1 +
 fs/f2fs/namei.c | 12 ++++++++----
 fs/f2fs/sysfs.c |  3 +++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b753cc88c77e..ecb13c3b458d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3322,6 +3322,7 @@ void f2fs_handle_failed_inode(struct inode *inode);
 /*
  * namei.c
  */
+bool f2fs_is_wildcard_char(const char *ext);
 int f2fs_update_extension_list(struct f2fs_sb_info *sbi, const char *name,
 							bool hot, bool set);
 struct dentry *f2fs_get_parent(struct dentry *child);
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index a9cd9cf97229..8d78b96a8b3b 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -153,15 +153,17 @@ static struct inode *f2fs_new_inode(struct inode *dir, umode_t mode)
 	return ERR_PTR(err);
 }
 
+bool f2fs_is_wildcard_char(const char *ext)
+{
+	return *ext == '*' && strlen(ext) == 1;
+}
+
 static inline int is_extension_exist(const unsigned char *s, const char *sub)
 {
 	size_t slen = strlen(s);
 	size_t sublen = strlen(sub);
 	int i;
 
-	if (sublen == 1 && *sub == '*')
-		return 1;
-
 	/*
 	 * filename format of multimedia file should be defined as:
 	 * "filename + '.' + extension + (optional: '.' + temp extension)".
@@ -306,9 +308,11 @@ static void set_compress_inode(struct f2fs_sb_info *sbi, struct inode *inode,
 	ext = F2FS_OPTION(sbi).extensions;
 
 	for (i = 0; i < ext_cnt; i++) {
+		if (f2fs_is_wildcard_char(ext[i]))
+			goto set_compress;
 		if (!is_extension_exist(name, ext[i]))
 			continue;
-
+set_compress:
 		set_compress_context(inode);
 		return;
 	}
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index dc71bc968c72..ff5acb4de1b6 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -343,6 +343,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
 		if (strlen(name) >= F2FS_EXTENSION_LEN)
 			return -EINVAL;
 
+		if (f2fs_is_wildcard_char(name))
+			return -EINVAL;
+
 		down_write(&sbi->sb_lock);
 
 		ret = f2fs_update_extension_list(sbi, name, hot, set);
-- 
2.29.2

