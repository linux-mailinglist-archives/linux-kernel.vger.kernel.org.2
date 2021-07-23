Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789C83D4227
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbhGWUni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:43:38 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:46640 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhGWUng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:43:36 -0400
Received: by mail-pl1-f172.google.com with SMTP id t21so4419789plr.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 14:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYF27hK0HPhBVQajIi7MXo40M6AFf/2KuJLdIFLJOOM=;
        b=A18JM1xtf6UxRtS9yya5Hpt/UpKsfieYM74BCUN6VD5dnMNbY64HwVAARnOnKFDDku
         PhVzC2LHbX9fzdlsrlWSuVC5KJOdEZNkGBa22VD3tiLY8033gFcouLo/Men1st037bw4
         3Wx23xY3bp+xnpbH8l9Ev7lo0MCbo7ZaWseHZpqrWYCLc5YpgMwn5Hh9HpBBsbXyr8oC
         zqsOAE8Ybul5WoUsSJwgP2iLibwoARGjML58x/1F75PEFkPgAjM4lLHRCNqMMKVhlESO
         nVKePrUpwbWSi2k/GvQZLjDbPeCMmWIFrlG0zmJ8IO+LbXBvk8BcK9oYtvtsUWpTWgxz
         ExvQ==
X-Gm-Message-State: AOAM532i4X0dsh50+hvVNxLCm4NcGO8rflz1K9yV1SfPMT9mwWFZrL2y
        sN39WIk3p9+M0D/t+ezkX0s=
X-Google-Smtp-Source: ABdhPJx1CrTbvMJslogP3oTnj9ccQDb6SluZ48g5IKzep7ct6+PH1R0X4OG2SX2vL4VpzRVv09hEhw==
X-Received: by 2002:a17:90a:a008:: with SMTP id q8mr6190007pjp.217.1627075448553;
        Fri, 23 Jul 2021 14:24:08 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:db72:85bb:463f:5c41])
        by smtp.gmail.com with ESMTPSA id w16sm39854011pgi.41.2021.07.23.14.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:24:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Yanko Kaneti <yaneti@declera.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 4/4] configfs: Add unit tests
Date:   Fri, 23 Jul 2021 14:23:53 -0700
Message-Id: <20210723212353.896343-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
In-Reply-To: <20210723212353.896343-1-bvanassche@acm.org>
References: <20210723212353.896343-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Testing configfs read and write behavior is non-trivial and tedious.
Hence these configfs kunit tests that make it easier to test configfs
text and binary attribute support. This is how I run these tests:

set -e
if [ -e .config ]; then
    make ARCH=um mrproper
fi
if [ ! -e .kunit/.kunitconfig ]; then
    cat <<EOF >.kunit/.kunitconfig
CONFIG_CONFIGFS_FS=y
CONFIG_CONFIGFS_KUNIT_TEST=y
CONFIG_KUNIT=y
CONFIG_PROVE_LOCKING=y
CONFIG_SYSFS=y
CONFIG_UBSAN=y
EOF
    cp .kunit/.kunitconfig .kunit/.config
fi
./tools/testing/kunit/kunit.py run

Cc: Bodo Stroesser <bostroesser@gmail.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Yanko Kaneti <yaneti@declera.com>
Cc: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/configfs/Kconfig         |   8 +
 fs/configfs/Makefile        |   2 +
 fs/configfs/configfs-test.c | 375 ++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)
 create mode 100644 fs/configfs/configfs-test.c

diff --git a/fs/configfs/Kconfig b/fs/configfs/Kconfig
index 272b64456999..9f8f3d8ca67d 100644
--- a/fs/configfs/Kconfig
+++ b/fs/configfs/Kconfig
@@ -10,3 +10,11 @@ config CONFIGFS_FS
 
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
+
+config CONFIGFS_KUNIT_TEST
+	tristate "Configfs Kunit test" if !KUNIT_ALL_TESTS
+	depends on CONFIGFS_FS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Run the configfs unit tests at boot time. For more information, see
+	  also the Kunit documentation in Documentation/dev-tools/kunit/.
diff --git a/fs/configfs/Makefile b/fs/configfs/Makefile
index 0200498ede27..388003fa9f37 100644
--- a/fs/configfs/Makefile
+++ b/fs/configfs/Makefile
@@ -6,3 +6,5 @@
 obj-$(CONFIG_CONFIGFS_FS)	+= configfs.o
 
 configfs-objs	:= inode.o file.o dir.o symlink.o mount.o item.o
+
+obj-$(CONFIG_CONFIGFS_KUNIT_TEST) += configfs-test.o
diff --git a/fs/configfs/configfs-test.c b/fs/configfs/configfs-test.c
new file mode 100644
index 000000000000..ad907cd092f8
--- /dev/null
+++ b/fs/configfs/configfs-test.c
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <kunit/test.h>
+#include <linux/configfs.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/uio.h>
+
+/*
+ * Maximum number of bytes supported by the configfs attributes in this unit
+ * test.
+ */
+enum { ATTR_MAX_SIZE = 256 };
+
+static struct test_item {
+	uint32_t nbytes;
+	char data[ATTR_MAX_SIZE];
+} bin_attr, text_attr;
+
+static ssize_t attr_read(struct test_item *ti, void *buf, size_t len)
+{
+	size_t nbytes = min_t(size_t, len, ti->nbytes);
+
+	memcpy(buf, ti->data, nbytes);
+	return nbytes;
+}
+
+static ssize_t attr_write(struct test_item *ti, const void *buf, size_t len)
+{
+	if (len > ATTR_MAX_SIZE)
+		return -EINVAL;
+	ti->nbytes = len;
+	memcpy(ti->data, buf, len);
+	return len;
+}
+
+static DEFINE_SEMAPHORE(bin_attr_written);
+
+static ssize_t bin_attr_read(struct config_item *item, void *buf, size_t len)
+{
+	WARN_ON_ONCE(!bin_attr.nbytes);
+	return buf ? attr_read(&bin_attr, buf, len) : bin_attr.nbytes;
+}
+
+static ssize_t bin_attr_write(struct config_item *item, const void *buf,
+			      size_t len)
+{
+	up(&bin_attr_written);
+	return attr_write(&bin_attr, buf, len);
+}
+
+CONFIGFS_BIN_ATTR(, bin_attr, NULL, ATTR_MAX_SIZE);
+
+static struct configfs_bin_attribute *bin_attrs[] = {
+	&attr_bin_attr,
+	NULL,
+};
+
+static ssize_t text_attr_show(struct config_item *item, char *buf)
+{
+	return attr_read(&text_attr, buf, strlen(buf));
+}
+
+static ssize_t text_attr_store(struct config_item *item, const char *buf,
+			       size_t size)
+{
+	return attr_write(&text_attr, buf, size);
+}
+
+CONFIGFS_ATTR(, text_attr);
+
+static struct configfs_attribute *text_attrs[] = {
+	&attr_text_attr,
+	NULL,
+};
+
+static const struct config_item_type test_configfs_type = {
+	.ct_owner	= THIS_MODULE,
+	.ct_bin_attrs	= bin_attrs,
+	.ct_attrs	= text_attrs,
+};
+
+/*
+ * Return the file mode if @path exists or an error code if opening @path via
+ * filp_open() in read-only mode failed.
+ */
+int get_file_mode(const char *path)
+{
+	struct file *file;
+	int res;
+
+	file = filp_open(path, O_RDONLY, 0400);
+	if (IS_ERR(file)) {
+		res = PTR_ERR(file);
+		goto out;
+	}
+	res = file_inode(file)->i_mode;
+	filp_close(file, NULL);
+
+out:
+	return res;
+}
+
+static int mkdir(const char *name, umode_t mode)
+{
+	struct dentry *dentry;
+	struct path path;
+	int err;
+
+	err = get_file_mode(name);
+	if (err >= 0 && S_ISDIR(err))
+		return 0;
+
+	dentry = kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTORY);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	err = vfs_mkdir(&init_user_ns, d_inode(path.dentry), dentry, mode);
+	done_path_create(&path, dentry);
+
+	return err;
+}
+
+static int mount_configfs(void)
+{
+	int res;
+
+	res = get_file_mode("/sys/kernel/config/unit-test");
+	if (res >= 0)
+		return 0;
+	res = mkdir("/sys", 0755);
+	if (res < 0)
+		return res;
+	res = mkdir("/sys/kernel", 0755);
+	if (res < 0)
+		return res;
+	res = mkdir("/sys/kernel/config", 0755);
+	if (res < 0)
+		return res;
+	pr_info("mounting configfs ...\n");
+	res = do_mount("", "/sys/kernel/config", "configfs", 0, NULL);
+	if (res < 0)
+		pr_err("mounting configfs failed: %d\n", res);
+	else
+		pr_info("mounted configfs.\n");
+	return res;
+}
+
+static void unmount_configfs(void)
+{
+	/* How to unmount a filesystem from kernel code? */
+}
+
+#define KUNIT_EXPECT_MODE(test, left_arg, mask, right)			\
+({									\
+	const int left = (left_arg);				\
+									\
+	KUNIT_EXPECT_TRUE_MSG(test, left >= 0 && (left & mask) == right,\
+		"(" #left_arg "(%d) & " #mask ") != " #right, left); \
+})
+
+static void configfs_mounted(struct kunit *test)
+{
+	KUNIT_EXPECT_MODE(test, get_file_mode("/"), 0500, 0500);
+	KUNIT_EXPECT_MODE(test, get_file_mode("/sys"), 0500, 0500);
+	KUNIT_EXPECT_MODE(test, get_file_mode("/sys/kernel"), 0500, 0500);
+	KUNIT_EXPECT_MODE(test, get_file_mode("/sys/kernel/config"), 0500, 0500);
+	KUNIT_EXPECT_MODE(test, get_file_mode("/sys/kernel/config/unit-test"),
+			  0500, 0500);
+	KUNIT_EXPECT_MODE(test, get_file_mode
+			  ("/sys/kernel/config/unit-test/text_attr"),
+			  0700, 0600);
+}
+
+static void configfs_text_attr(struct kunit *test)
+{
+	struct file *f = filp_open("/sys/kernel/config/unit-test/text_attr",
+				   O_RDWR, 0);
+	static const char text1[] =
+		"The quick brown fox jumps over the lazy dog";
+	const int off1 = 0;
+	const int len1 = strlen(text1);
+	static const char text2[] = "huge";
+	const int off2 = strlen(text1) - strlen(text2) - 4;
+	const int len2 = strlen(text2);
+	char text3[sizeof(text1)];
+	int res;
+	loff_t pos;
+
+	KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(f), 0);
+	if (IS_ERR(f))
+		return;
+	pos = off1;
+	res = kernel_write(f, text1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	KUNIT_EXPECT_EQ(test, pos, off1 + len1);
+	pos = off2;
+	res = kernel_write(f, text2, len2, &pos);
+	KUNIT_EXPECT_EQ(test, res, len2);
+	KUNIT_EXPECT_EQ(test, pos, off2 + len2);
+	pos = 4095;
+	res = kernel_write(f, text1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, 0);
+	KUNIT_EXPECT_EQ(test, pos, 4095);
+	pos = 0;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, off2 + len2);
+	KUNIT_EXPECT_EQ(test, pos, off2 + len2);
+	if (res >= 0) {
+		text3[res] = '\0';
+		KUNIT_EXPECT_STREQ(test, text3,
+				   "The quick brown fox jumps over the huge");
+	}
+	pos = 1;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, off2 + len2 - 1);
+	KUNIT_EXPECT_EQ(test, pos, off2 + len2);
+	if (res >= 0) {
+		text3[res] = '\0';
+		KUNIT_EXPECT_STREQ(test, text3,
+				   "he quick brown fox jumps over the huge");
+	}
+	pos = -1;
+	res = kernel_write(f, text1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	pos = LLONG_MAX - len1;
+	res = kernel_write(f, text1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, 0);
+	pos = -1;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	pos = LLONG_MAX - sizeof(text3);
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, 0);
+	filp_close(f, NULL);
+}
+
+#define KUNIT_EXPECT_MEMEQ(test, left, right, len)			\
+	KUNIT_EXPECT_TRUE_MSG(test, memcmp(left, right, len) == 0,	\
+			      #left " != " #right ": %.*s <> %.*s",	\
+			      (int)len, left, (int)len, right)
+
+static void configfs_bin_attr(struct kunit *test)
+{
+	struct file *f = filp_open("/sys/kernel/config/unit-test/bin_attr",
+				   O_RDWR, 0);
+	static const u8 data1[] =
+		"\xff\x00The quick brown fox jumps over the lazy dog";
+	const int off1 = 0;
+	const int len1 = sizeof(data1) - 1;
+	static const u8 data2[] = "huge";
+	const int off2 = len1 - strlen(data2) - 4;
+	const int len2 = strlen(data2);
+	u8 data3[sizeof(data1)];
+	int res;
+	loff_t pos;
+
+	bin_attr.nbytes = len1;
+
+	KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(f), 0);
+	if (IS_ERR(f))
+		return;
+	pos = off1;
+	res = kernel_write(f, data1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	KUNIT_EXPECT_EQ(test, pos, off1 + len1);
+	pos = off2;
+	res = kernel_write(f, data2, len2, &pos);
+	KUNIT_EXPECT_EQ(test, res, len2);
+	KUNIT_EXPECT_EQ(test, pos, off2 + len2);
+	filp_close(f, NULL);
+
+	/*
+	 * buffer->bin_attr->write() is called from inside
+	 * configfs_release_bin_file() and the latter function is
+	 * called asynchronously. Hence the down() calls below to wait
+	 * until the write method has been called.
+	 */
+	down(&bin_attr_written);
+	down(&bin_attr_written);
+
+	f = filp_open("/sys/kernel/config/unit-test/bin_attr", O_RDONLY, 0);
+	KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(f), 0);
+	if (IS_ERR(f))
+		return;
+	pos = 0;
+	res = kernel_read(f, data3, sizeof(data3), &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	KUNIT_EXPECT_EQ(test, pos, len1);
+	if (res >= 0) {
+		data3[res] = '\0';
+		KUNIT_EXPECT_MEMEQ(test, data3,
+			"\xff\x00The quick brown fox jumps over the huge dog",
+			len1);
+	}
+	pos = 1;
+	res = kernel_read(f, data3, sizeof(data3), &pos);
+	KUNIT_EXPECT_EQ(test, res, len1 - 1);
+	KUNIT_EXPECT_EQ(test, pos, len1);
+	if (res >= 0) {
+		data3[res] = '\0';
+		KUNIT_EXPECT_MEMEQ(test, data3,
+			"\x00The quick brown fox jumps over the huge dog",
+			len1 - 1);
+	}
+	filp_close(f, NULL);
+
+	f = filp_open("/sys/kernel/config/unit-test/bin_attr", O_RDWR, 0);
+	KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(f), 0);
+	if (IS_ERR(f))
+		return;
+	pos = -1;
+	res = kernel_write(f, data1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	pos = LLONG_MAX - len1;
+	res = kernel_write(f, data1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, -EFBIG);
+	filp_close(f, NULL);
+
+	f = filp_open("/sys/kernel/config/unit-test/bin_attr", O_RDONLY, 0);
+	KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(f), 0);
+	if (IS_ERR(f))
+		return;
+	pos = -1;
+	res = kernel_read(f, data3, sizeof(data3), &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	pos = LLONG_MAX - sizeof(data3);
+	res = kernel_read(f, data3, sizeof(data3), &pos);
+	KUNIT_EXPECT_EQ(test, res, 0);
+	filp_close(f, NULL);
+}
+
+static struct kunit_case configfs_test_cases[] = {
+	KUNIT_CASE(configfs_mounted),
+	KUNIT_CASE(configfs_text_attr),
+	KUNIT_CASE(configfs_bin_attr),
+	{},
+};
+
+static struct configfs_subsystem test_subsys = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf = "unit-test",
+			.ci_type    = &test_configfs_type,
+		}
+	},
+};
+
+static int configfs_suite_init(void)
+{
+	int res;
+
+	config_group_init(&test_subsys.su_group);
+	mutex_init(&test_subsys.su_mutex);
+	res = configfs_register_subsystem(&test_subsys);
+	if (res < 0) {
+		pr_err("Registration of configfs subsystem failed: %d\n", res);
+		return res;
+	}
+	return mount_configfs();
+}
+
+static void configfs_suite_exit(void)
+{
+	configfs_unregister_subsystem(&test_subsys);
+	unmount_configfs();
+}
+
+static struct kunit_suite configfs_test_module = {
+	.name		= "configfs unit tests",
+	.init_suite	= configfs_suite_init,
+	.exit_suite	= configfs_suite_exit,
+	.test_cases	= configfs_test_cases,
+};
+kunit_test_suites(&configfs_test_module);
