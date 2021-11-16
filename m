Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699274535EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 16:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238336AbhKPPkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 10:40:22 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31874 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbhKPPkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 10:40:20 -0500
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Htqn72LC7zcbLW;
        Tue, 16 Nov 2021 23:32:27 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 23:37:21 +0800
Received: from use12-sp2.huawei.com (10.67.189.20) by
 dggpemm500007.china.huawei.com (7.185.36.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 16 Nov 2021 23:37:21 +0800
From:   Jubin Zhong <zhongjubin@huawei.com>
To:     <dwmw2@infradead.org>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangfangpeng1@huawei.com>, <zhongjubin@huawei.com>,
        <kechengsong@huawei.com>, <chenzefeng2@huawei.com>
Subject: [PATCH] jffs2: Fix truncate never update m/ctime
Date:   Tue, 16 Nov 2021 23:37:16 +0800
Message-ID: <1637077036-67090-1-git-send-email-zhongjubin@huawei.com>
X-Mailer: git-send-email 1.8.5.6
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.189.20]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhongjubin <zhongjubin@huawei.com>

Syscall truncate() never updates m/ctime in jffs2 even if the file
size is changed. This is incorrect according to man file:

  truncate (2):
  If  the  size  changed, then the st_ctime and st_mtime fields
  (respectively, time of last status change and time of last
  modification; see stat(2)) for the file are updated, and the
  set-user-ID and set-group-ID mode bits may be cleared.

This is because truncate() will not set ATTR_CTIME and ATTR_MTIME even
when file size is changed. Fix this special case just like what other
filesystems do.

Test Steps:
  1. cd /path/to/mnt/point
  2. dd if=/dev/zero of=test bs=1M count=1
  3. stat test
  4. /bin/my_truncate -s 1024 test
  5. stat test
  6. compare m/ctime of step 5 with step 3

Program source:
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <unistd.h>
  #include <sys/types.h>
  int main(int argc, char **argv)
  {
  	int ret;
	char file_name[128] = {0};

	if (argc < 4 || argv == NULL || argv[1] == NULL ||
argv[2] == NULL || argv[3] == NULL) {
		return -1;
	}

	if (strcmp(argv[1], "-s")) {
		return -1;
	}

	if (realpath(argv[3], file_name) == NULL) {
		printf("truncate: input file name %s err.\n", argv[3]);
			return -1;
		}

		off_t size = (off_t)strtol(argv[2], 0, 0);
		ret = truncate(file_name, size);
		if (ret) {
			printf("truncate return err %d\n", ret);
		}
		return ret;
	}

Signed-off-by: zhongjubin <zhongjubin@huawei.com>

----
v1:
  https://lore.kernel.org/all/1636974018-31285-1-git-send-email-zhongjubin@huawei.com/
  I considered fixing this problem in vfs_truncate(), but it is
  suggested to implement the proper semantics in jffs's ->setattr.
---
 fs/jffs2/fs.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/jffs2/fs.c b/fs/jffs2/fs.c
index 2ac410477c4f..181f053d072b 100644
--- a/fs/jffs2/fs.c
+++ b/fs/jffs2/fs.c
@@ -114,8 +114,18 @@ int jffs2_do_setattr (struct inode *inode, struct iattr *iattr)
 
 	ri->isize = cpu_to_je32((ivalid & ATTR_SIZE)?iattr->ia_size:inode->i_size);
 	ri->atime = cpu_to_je32(I_SEC((ivalid & ATTR_ATIME)?iattr->ia_atime:inode->i_atime));
-	ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
-	ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode->i_ctime));
+	/*
+	 * Special case for truncate() where we should update the times despite not having
+	 * ATTR_CTIME and ATTR_MTIME set.
+	 */
+	if ((ivalid & ATTR_SIZE) && (iattr->ia_size != inode->i_size) &&
+			!(ivalid & (ATTR_CTIME | ATTR_MTIME))) {
+		ri->mtime = cpu_to_je32(I_SEC(iattr->ia_mtime));
+		ri->ctime = cpu_to_je32(I_SEC(iattr->ia_ctime));
+	} else {
+		ri->mtime = cpu_to_je32(I_SEC((ivalid & ATTR_MTIME)?iattr->ia_mtime:inode->i_mtime));
+		ri->ctime = cpu_to_je32(I_SEC((ivalid & ATTR_CTIME)?iattr->ia_ctime:inode->i_ctime));
+	}
 
 	ri->offset = cpu_to_je32(0);
 	ri->csize = ri->dsize = cpu_to_je32(mdatalen);
-- 
2.12.3

