Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AEC39D227
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 01:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhFFXLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 19:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhFFXLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 19:11:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D949C061767;
        Sun,  6 Jun 2021 16:09:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a150ab0290162974722f2so9252430pja.2;
        Sun, 06 Jun 2021 16:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c8rDwOCs/qvqUrVaJWT4oCzeNMNghRW2CXnXA/uwULs=;
        b=NAMhti0iGnyYoOQxQe7n3zDhPjVtGhsVK1sUvt3/EWKV/UgkZ8XBFCSR0QW/k2O0bq
         LsTLxjamOWKy7Qc8Q2A7Xi2fndywKB7Kg0jLyzVHHFprLd1cmnwXe7YZgDbQ3+y00AjC
         ZUOltjmqcWgeR2G7PIQfPRsd9YYEt0WcbCKy7jlH6VpRMcvB71ishIcud3TUI8OQ9v11
         Yg3e06GWtsFMn8PFCKa2kcaznDrxODdM7UwHShZfsAnjKWnz2aM/dc8F8vfNJtPvy9LZ
         DphKKgI2Guce21GGK9zsr6wGoLvTGesw24YNPf3mLtABvyDd9BGegbN2kgkgXcXZSx1I
         CMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c8rDwOCs/qvqUrVaJWT4oCzeNMNghRW2CXnXA/uwULs=;
        b=i/SirGqOg6kFMZ0oVbtyXJl4022fOoo4kD10ASdr38nLtyxkWZTU1XMms/WRn73H88
         wk7Ij+oTMzwXMwnTAv31iBsEera07Iyw8XLhchiDiFJ9JWL9DAd3BEyd3HKJum4OhsGs
         g6x2u7kdbXuLTN50ROmKBos2Z4yATq+9aN8XKuV201WI4IzmeQqrSxx1heyrkWX8uq3Y
         9DAAHZFyhoP+PedeIuqn3QHT73DG57AyJnG9PEkx2V/39kMN3Gl+Ujlt43A0gGFZ1MGp
         JPW06jRHRVfB01e3IY0luYyZYpWe6DRPyVODFzlJJBkCVNj5jsQpLGsC3LsVLwiUzk6A
         t2XA==
X-Gm-Message-State: AOAM531SYhgK2wsuZZAuZOxXVAwz2/s2OTqJu+YcLOBchOy+lOMuA0fW
        ESk6VfOotQmRJlxuVQaMSa47UHJMEDp8Gg==
X-Google-Smtp-Source: ABdhPJzgZiGmcmCja5+87+P6qv3f+mJNF6Id2o/OPS+p3VoRsEGB/7ma0b9XDKcCmaqJWqF1hN3KZQ==
X-Received: by 2002:a17:90b:318:: with SMTP id ay24mr27930330pjb.150.1623020987977;
        Sun, 06 Jun 2021 16:09:47 -0700 (PDT)
Received: from WRT-WX9.. ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id f15sm6775672pgg.23.2021.06.06.16.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 16:09:47 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3 1/3] 9p: add support for root file systems
Date:   Mon,  7 Jun 2021 07:09:20 +0800
Message-Id: <20210606230922.77268-2-changbin.du@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210606230922.77268-1-changbin.du@gmail.com>
References: <20210606230922.77268-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a new kernel command-line option called 'v9fsroot='
which will tell the kernel to mount the root file system by
utilizing the 9p protocol.

This allows us to mount host folder as rootfs for guest linux in qemu.
Bellow is an example which mounts v9fs with tag 'r' as rootfs in qemu
guest via virtio transport.

  $ qemu-system-x86_64 -enable-kvm -cpu host -m 1024 \
      -virtfs local,path=$rootfs_dir,mount_tag=r,security_model=passthrough,id=r \
      -kernel /path/to/linux/arch/x86/boot/bzImage -nographic \
      -append "root=/dev/v9fs v9fsroot=r,trans=virtio rw console=ttyS0 3"

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v2:
  o use pr_err instead of printk.
  o ROOT_DEV is only set after checking.
  o cleanup DEFAULT_MNT_OPTS.
  o do not retry mount for fd and virtio transport.
---
 MAINTAINERS              |  5 ++++
 fs/9p/Kconfig            |  6 ++++
 fs/9p/Makefile           |  1 +
 fs/9p/v9fsroot.c         | 64 ++++++++++++++++++++++++++++++++++++++++
 include/linux/root_dev.h |  1 +
 init/do_mounts.c         | 55 ++++++++++++++++++++++++++++++++++
 6 files changed, 132 insertions(+)
 create mode 100644 fs/9p/v9fsroot.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b706dd20ff2b..35b2c8f614d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -239,6 +239,11 @@ F:	include/trace/events/9p.h
 F:	include/uapi/linux/virtio_9p.h
 F:	net/9p/
 
+9P FILE SYSTEM ROOTFS SUPPORT
+R:	Changbin Du <changbin.du@gmail.com>
+S:	Supported
+F:	fs/9p/v9fsroot.c
+
 A8293 MEDIA DRIVER
 M:	Antti Palosaari <crope@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index 09fd4a185fd2..71c5a49f9a27 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -42,3 +42,9 @@ config 9P_FS_SECURITY
 
 	  If you are not using a security module that requires using
 	  extended attributes for file security labels, say N.
+
+config 9P_FS_ROOT
+	bool "9p root file system"
+	depends on 9P_FS=y
+	help
+	  Enables root file system support over 9p protocol.
diff --git a/fs/9p/Makefile b/fs/9p/Makefile
index e7800a5c7395..bc2a4ef10049 100644
--- a/fs/9p/Makefile
+++ b/fs/9p/Makefile
@@ -15,3 +15,4 @@ obj-$(CONFIG_9P_FS) := 9p.o
 
 9p-$(CONFIG_9P_FSCACHE) += cache.o
 9p-$(CONFIG_9P_FS_POSIX_ACL) += acl.o
+9p-$(CONFIG_9P_FS_ROOT) += v9fsroot.o
diff --git a/fs/9p/v9fsroot.c b/fs/9p/v9fsroot.c
new file mode 100644
index 000000000000..6c9f7e335c1a
--- /dev/null
+++ b/fs/9p/v9fsroot.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * 9p root file system support
+ *
+ * Copyright (c) 2021 Changbin Du <changbin.du@gmail.com>
+ */
+#include <linux/init.h>
+#include <linux/fs.h>
+#include <linux/types.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
+#include <linux/root_dev.h>
+#include <linux/kernel.h>
+
+static char root_dev[2048] __initdata = "";
+static char root_opts[1024] __initdata = "";
+
+/* v9fsroot=<path>[,options] */
+static int __init v9fs_root_setup(char *line)
+{
+	char *s;
+	int len;
+
+	if (strlen(line) >= 1) {
+		/* make s point to ',' or '\0' at end of line */
+		s = strchrnul(line, ',');
+		/* len is strlen(unc) + '\0' */
+		len = s - line + 1;
+		if (len > sizeof(root_dev)) {
+			pr_err("Root-V9FS: path too long\n");
+			return 1;
+		}
+		strscpy(root_dev, line, len);
+
+		if (*s) {
+			int n = snprintf(root_opts,
+					 sizeof(root_opts), "%s",
+					 s + 1);
+			if (n >= sizeof(root_opts)) {
+				pr_err("Root-V9FS: mount options string too long\n");
+				root_opts[sizeof(root_opts)-1] = '\0';
+				return 1;
+			}
+		}
+	}
+
+	ROOT_DEV = Root_V9FS;
+	return 1;
+}
+
+__setup("v9fsroot=", v9fs_root_setup);
+
+int __init v9fs_root_data(char **dev, char **opts)
+{
+	if (!root_dev[0]) {
+		pr_err("Root-V9FS: no rootdev specified\n");
+		return -1;
+	}
+
+	*dev = root_dev;
+	*opts = root_opts;
+
+	return 0;
+}
diff --git a/include/linux/root_dev.h b/include/linux/root_dev.h
index 4e78651371ba..becd0ee2ff87 100644
--- a/include/linux/root_dev.h
+++ b/include/linux/root_dev.h
@@ -9,6 +9,7 @@
 enum {
 	Root_NFS = MKDEV(UNNAMED_MAJOR, 255),
 	Root_CIFS = MKDEV(UNNAMED_MAJOR, 254),
+	Root_V9FS = MKDEV(UNNAMED_MAJOR, 253),
 	Root_RAM0 = MKDEV(RAMDISK_MAJOR, 0),
 	Root_RAM1 = MKDEV(RAMDISK_MAJOR, 1),
 	Root_FD0 = MKDEV(FLOPPY_MAJOR, 0),
diff --git a/init/do_mounts.c b/init/do_mounts.c
index a78e44ee6adb..952e91f6efcb 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -287,6 +287,8 @@ dev_t name_to_dev_t(const char *name)
 		return Root_NFS;
 	if (strcmp(name, "/dev/cifs") == 0)
 		return Root_CIFS;
+	if (strcmp(name, "/dev/v9fs") == 0)
+		return Root_V9FS;
 	if (strcmp(name, "/dev/ram") == 0)
 		return Root_RAM0;
 #ifdef CONFIG_BLOCK
@@ -536,6 +538,52 @@ static int __init mount_cifs_root(void)
 }
 #endif
 
+#ifdef CONFIG_9P_FS_ROOT
+
+extern int v9fs_root_data(char **dev, char **opts);
+
+#define V9FSROOT_TIMEOUT_MIN	5
+#define V9FSROOT_TIMEOUT_MAX	30
+#define V9FSROOT_RETRY_MAX	5
+
+static bool v9fs_should_retry(char *mount_opts)
+{
+	if (strstr(mount_opts, "trans=virtio") || strstr(mount_opts, "trans=fd"))
+		return false;
+	return true;
+}
+
+static int __init mount_v9fs_root(void)
+{
+	char *root_dev, *root_data;
+	unsigned int timeout = V9FSROOT_TIMEOUT_MIN;
+	bool should_retry;
+	int try, err;
+
+	err = v9fs_root_data(&root_dev, &root_data);
+	if (err != 0)
+		return 0;
+
+	should_retry = v9fs_should_retry(root_data);
+	for (try = 1; ; try++) {
+		err = do_mount_root(root_dev, "9p",
+				    root_mountflags, root_data);
+		if (err == 0)
+			return 1;
+
+		if (!should_retry || try > V9FSROOT_RETRY_MAX)
+			break;
+
+		/* Wait, in case the server refused us immediately */
+		ssleep(timeout);
+		timeout <<= 1;
+		if (timeout > V9FSROOT_TIMEOUT_MAX)
+			timeout = V9FSROOT_TIMEOUT_MAX;
+	}
+	return 0;
+}
+#endif
+
 void __init mount_root(void)
 {
 #ifdef CONFIG_ROOT_NFS
@@ -552,6 +600,13 @@ void __init mount_root(void)
 		return;
 	}
 #endif
+#ifdef CONFIG_9P_FS_ROOT
+	if (ROOT_DEV == Root_V9FS) {
+		if (!mount_v9fs_root())
+			pr_err("VFS: Unable to mount root fs via 9p.\n");
+		return;
+	}
+#endif
 #ifdef CONFIG_BLOCK
 	{
 		int err = create_dev("/dev/root", ROOT_DEV);
-- 
2.30.2

