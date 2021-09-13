Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459C840856A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 09:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbhIMHfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 03:35:45 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:15405 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237568AbhIMHfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 03:35:43 -0400
Received: from dggeml761-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4H7J6P3tNyzQrl5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 15:30:21 +0800 (CST)
Received: from huawei.com (10.175.127.234) by dggeml761-chm.china.huawei.com
 (10.1.199.171) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.8; Mon, 13
 Sep 2021 15:34:25 +0800
From:   Wenyu Liu <liuwenyu7@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <yeyunfeng@huawei.com>, <hewenliang4@huawei.com>,
        <wuxu.wu@huawei.com>
Subject: [PATCH] tools api fs: fix the concurrency problem for  xxx__mountpoint()
Date:   Mon, 13 Sep 2021 03:35:53 -0400
Message-ID: <20210913073553.3384908-1-liuwenyu7@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.234]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeml761-chm.china.huawei.com (10.1.199.171)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xxx_mountpoint() first acquires the mountpoint
path,it also fills the path into fs__entries[idx]->path
and set fs__entries[idx]->found to be true.

After that,every time xxx_mountpoint() is executed,the
path is gotten directly from fs__entries[idx]->path.

There will be a concurrency problem:
The fs__entries[idx]->found has been set by a thread,
but the fs__entries[idx]->path has not been completely
filled.
However, another thread thinks that the mountpoint path
has been found and read it from fs__entries[idx]->path.

We found this bug when we repeatedly executed the
"perf top" command:
When the "perf top" command is executed, multiple
threads are created and concurrently execute the func
hugetlbfs_mountpoint().

Using memory barrier alone does not solve this problem,
because if the current thread thinks the path is not
found,it will still trys to find the path and fills it
into fs__entries[idx]->path,it also will causes other
threads that are getting fs__entries[idx]->path to read
a wrong path.

This patch add a mutex_lock when fs__get_mountpoint(fs)
is filling the fs->path,and uses memory barrier to ensure
the path is completely filled before the fs->found is set.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Wenyu Liu <liuwenyu7@huawei.com>
---
 tools/lib/api/Makefile |  1 +
 tools/lib/api/fs/fs.c  | 51 +++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index a13e9c7f1fc5..b75ba280dde9 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -19,6 +19,7 @@ LIBFILE = $(OUTPUT)libapi.a
 
 CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -fPIC
+CFLAGS += -lpthread
 
 ifeq ($(DEBUG),0)
 ifeq ($(CC_NO_CLANG), 0)
diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 82f53d81a7a7..65d19de3911c 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -12,6 +12,9 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/mount.h>
+#include <pthread.h>
+#include <asm/barrier.h>
+#include <linux/compiler.h>
 
 #include "fs.h"
 #include "debug-internal.h"
@@ -92,6 +95,7 @@ struct fs {
 	bool			 found;
 	bool			 checked;
 	long			 magic;
+	pthread_mutex_t		 lock;
 };
 
 enum {
@@ -113,43 +117,69 @@ static struct fs fs__entries[] = {
 		.mounts	= sysfs__fs_known_mountpoints,
 		.magic	= SYSFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__PROCFS] = {
 		.name	= "proc",
 		.mounts	= procfs__known_mountpoints,
 		.magic	= PROC_SUPER_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__DEBUGFS] = {
 		.name	= "debugfs",
 		.mounts	= debugfs__known_mountpoints,
 		.magic	= DEBUGFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__TRACEFS] = {
 		.name	= "tracefs",
 		.mounts	= tracefs__known_mountpoints,
 		.magic	= TRACEFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__HUGETLBFS] = {
 		.name	= "hugetlbfs",
 		.mounts = hugetlbfs__known_mountpoints,
 		.magic	= HUGETLBFS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 	[FS__BPF_FS] = {
 		.name	= "bpf",
 		.mounts = bpf_fs__known_mountpoints,
 		.magic	= BPF_FS_MAGIC,
 		.checked = false,
+		.lock = PTHREAD_MUTEX_INITIALIZER,
 	},
 };
 
+static void fs_fill_path(struct fs *fs, const char *path, size_t len)
+{
+	if (len >= sizeof(fs->path))
+		len = sizeof(fs->path) - 1;
+
+	pthread_mutex_lock(&fs->lock);
+	if (fs->found) {
+		pthread_mutex_unlock(&fs->lock);
+		return;
+	}
+	strncpy(fs->path, path, len);
+	fs->path[len] = '\0';
+	/* Make sure the path is filled before fs->found is set */
+	smp_wmb();
+	fs->found = true;
+	pthread_mutex_unlock(&fs->lock);
+}
+
+
 static bool fs__read_mounts(struct fs *fs)
 {
 	bool found = false;
 	char type[100];
+	char path[PATH_MAX];
 	FILE *fp;
 
 	fp = fopen("/proc/mounts", "r");
@@ -158,15 +188,17 @@ static bool fs__read_mounts(struct fs *fs)
 
 	while (!found &&
 	       fscanf(fp, "%*s %" STR(PATH_MAX) "s %99s %*s %*d %*d\n",
-		      fs->path, type) == 2) {
+		      path, type) == 2) {
 
-		if (strcmp(type, fs->name) == 0)
+		if (strcmp(type, fs->name) == 0) {
+			fs_fill_path(fs, path, sizeof(path) - 1);
 			found = true;
+		}
 	}
 
 	fclose(fp);
 	fs->checked = true;
-	return fs->found = found;
+	return found;
 }
 
 static int fs__valid_mount(const char *fs, long magic)
@@ -188,8 +220,7 @@ static bool fs__check_mounts(struct fs *fs)
 	ptr = fs->mounts;
 	while (*ptr) {
 		if (fs__valid_mount(*ptr, fs->magic) == 0) {
-			fs->found = true;
-			strcpy(fs->path, *ptr);
+			fs_fill_path(fs, *ptr, strlen(*ptr));
 			return true;
 		}
 		ptr++;
@@ -227,10 +258,7 @@ static bool fs__env_override(struct fs *fs)
 	if (!override_path)
 		return false;
 
-	fs->found = true;
-	fs->checked = true;
-	strncpy(fs->path, override_path, sizeof(fs->path) - 1);
-	fs->path[sizeof(fs->path) - 1] = '\0';
+	fs_fill_path(fs, override_path, sizeof(fs->path) - 1);
 	return true;
 }
 
@@ -252,8 +280,11 @@ static const char *fs__mountpoint(int idx)
 {
 	struct fs *fs = &fs__entries[idx];
 
-	if (fs->found)
+	if (READ_ONCE(fs->found)) {
+		/* Make sure the path is filled completely */
+		smp_rmb();
 		return (const char *)fs->path;
+	}
 
 	/* the mount point was already checked for the mount point
 	 * but and did not exist, so return NULL to avoid scanning again.
-- 
2.27.0

