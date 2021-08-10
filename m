Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1B53E0D59
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 06:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbhHEEfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 00:35:39 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:43604 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhHEEf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 00:35:29 -0400
Received: by mail-pj1-f44.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so6815158pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 21:35:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yauXPQZrqZdfzfp8gZkQrVcOpkyuxqTexmaOAf6MkPs=;
        b=cvtLgiKo4t+I8HdJ9EMsZpgtQMBttjb+eWXq0nMWU4ZUAYSkdcY7W72EIsx/64sx8r
         8OX+JFH0d5J9K5Zzs7bdTQqa62qU8WWt+HrN4/4Ush7vUALRing3x1iSH4/MmIhA8TwX
         pb5/C/vqnC3Zp0EgikaaKM8hA7QwrngE5R8i/yl7rQMPY5xVgD+aVeV3wjRTR1BGPfkl
         a6dE5U/wppfnwnWtJbY31euq1Lov3815kp0bd8j3zgmHivZhi1/W5OJS19452bsZaLNv
         nYr0zqChkl9JDxGNvVNMX5WgX4+pbBbOqbC8Q0nusCE9JlGkQMpngbDH6FcwpA8kgfJs
         UrrA==
X-Gm-Message-State: AOAM530Dvtplrg7/aMxiFCiIZvcrijNrYPtWsU6f2zOr84PfQftVEl3M
        YseKww3byXWhzO1B1bDQ7xQ=
X-Google-Smtp-Source: ABdhPJwOV7F/fuUfS76B5k8ShsxpQv5KQNyHT2Xscw5pzsnbQYl+LotDUEwUTxGehB7VgDmOyc0rXA==
X-Received: by 2002:a17:902:7598:b029:12b:e9ca:dfd5 with SMTP id j24-20020a1709027598b029012be9cadfd5mr2625911pll.12.1628138115587;
        Wed, 04 Aug 2021 21:35:15 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e365:91b7:6284:3848])
        by smtp.gmail.com with ESMTPSA id b15sm5642153pgj.60.2021.08.04.21.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 21:35:15 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joel Becker <jlbec@evilplan.org>, linux-kernel@vger.kernel.org,
        Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Yanko Kaneti <yaneti@declera.com>
Subject: [PATCH v4 3/3] configfs: Add unit tests
Date:   Wed,  4 Aug 2021 21:35:03 -0700
Message-Id: <20210805043503.20252-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805043503.20252-1-bvanassche@acm.org>
References: <20210805043503.20252-1-bvanassche@acm.org>
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
 fs/configfs/configfs-test.c | 429 ++++++++++++++++++++++++++++++++++++
 3 files changed, 439 insertions(+)
 create mode 100644 fs/configfs/configfs-test.c

diff --git a/fs/configfs/Kconfig b/fs/configfs/Kconfig
index 272b64456999..bbd7867407df 100644
--- a/fs/configfs/Kconfig
+++ b/fs/configfs/Kconfig
@@ -10,3 +10,11 @@ config CONFIGFS_FS
 
 	  Both sysfs and configfs can and should exist together on the
 	  same system. One is not a replacement for the other.
+
+config CONFIGFS_KUNIT_TEST
+	bool "Configfs Kunit test" if !KUNIT_ALL_TESTS
+	depends on CONFIGFS_FS && KUNIT=y
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
index 000000000000..46632d054fc8
--- /dev/null
+++ b/fs/configfs/configfs-test.c
@@ -0,0 +1,429 @@
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
+	const int left = (left_arg);					\
+									\
+	KUNIT_EXPECT_TRUE_MSG(test, left >= 0 && (left & mask) == right, \
+		"(" #left_arg "(%d) & " #mask ") != " #right, left);	\
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
+	/* Write at a non-zero offset. */
+	pos = off2;
+	res = kernel_write(f, text2, len2, &pos);
+	KUNIT_EXPECT_EQ(test, res, len2);
+	KUNIT_EXPECT_EQ(test, pos, off2 + len2);
+	/* Verify the effect of the above kernel_write() call. */
+	pos = 0;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, len2);
+	KUNIT_EXPECT_EQ(test, pos, len2);
+	if (res >= 0) {
+		text3[res] = '\0';
+		KUNIT_EXPECT_STREQ(test, text3, text2);
+	}
+	/* Write at offset zero. */
+	pos = off1;
+	res = kernel_write(f, text1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	KUNIT_EXPECT_EQ(test, pos, len1);
+	/* Verify the effect of the above kernel_write() call. */
+	pos = 0;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	KUNIT_EXPECT_EQ(test, pos, len1);
+	if (res >= 0) {
+		text3[res] = '\0';
+		KUNIT_EXPECT_STREQ(test, text3, text1);
+	}
+	/* Write at a non-zero offset. */
+	pos = off2;
+	res = kernel_write(f, text2, len2, &pos);
+	KUNIT_EXPECT_EQ(test, res, len2);
+	KUNIT_EXPECT_EQ(test, pos, off2 + len2);
+	/* Verify that the above kernel_write() call truncated the attribute. */
+	pos = 0;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, len2);
+	KUNIT_EXPECT_EQ(test, pos, len2);
+	if (res >= 0) {
+		text3[res] = '\0';
+		KUNIT_EXPECT_STREQ(test, text3, text2);
+	}
+	/* Read from offset 1. */
+	pos = 1;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, len2 - 1);
+	KUNIT_EXPECT_EQ(test, pos, len2);
+	if (res >= 0) {
+		text3[res] = '\0';
+		KUNIT_EXPECT_STREQ(test, text3, text2 + 1);
+	}
+	/* Write at offset -1. */
+	pos = -1;
+	res = kernel_write(f, text1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	/* Write at the largest possible positive offset. */
+	pos = LLONG_MAX - len1;
+	res = kernel_write(f, text1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	/* Read from offset -1. */
+	pos = -1;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	/* Read from the largest possible positive offset. */
+	pos = LLONG_MAX - sizeof(text3);
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, 0);
+	/* Verify the effect of the latest kernel_write() call. */
+	pos = 0;
+	res = kernel_read(f, text3, sizeof(text3), &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	KUNIT_EXPECT_EQ(test, pos, len1);
+	if (res >= 0) {
+		text3[res] = '\0';
+		KUNIT_EXPECT_STREQ(test, text3, text1);
+	}
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
+	/* Write at offset zero. */
+	pos = off1;
+	res = kernel_write(f, data1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, len1);
+	KUNIT_EXPECT_EQ(test, pos, off1 + len1);
+	/* Write at a non-zero offset. */
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
+	/* Verify the effect of the two kernel_write() calls. */
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
+	/* Read from offset 1. */
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
+	/* Write at offset -1. */
+	pos = -1;
+	res = kernel_write(f, data1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	/* Write at the largest possible positive offset. */
+	pos = LLONG_MAX - len1;
+	res = kernel_write(f, data1, len1, &pos);
+	KUNIT_EXPECT_EQ(test, res, -EFBIG);
+	filp_close(f, NULL);
+
+	/* Wait until the .write() function has been called. */
+	down(&bin_attr_written);
+
+	KUNIT_EXPECT_EQ(test, bin_attr.nbytes, 0);
+
+	f = filp_open("/sys/kernel/config/unit-test/bin_attr", O_RDONLY, 0);
+	KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(f), 0);
+	if (IS_ERR(f))
+		return;
+	/* Read from offset -1. */
+	pos = -1;
+	res = kernel_read(f, data3, sizeof(data3), &pos);
+	KUNIT_EXPECT_EQ(test, res, -EINVAL);
+	/* Read from the largest possible positive offset. */
+	pos = LLONG_MAX - sizeof(data3);
+	res = kernel_read(f, data3, sizeof(data3), &pos);
+	KUNIT_EXPECT_EQ(test, res, 0);
+	KUNIT_EXPECT_EQ(test, pos, LLONG_MAX - sizeof(data3));
+	/* Read from offset zero. */
+	pos = 0;
+	res = kernel_read(f, data3, sizeof(data3), &pos);
+	KUNIT_EXPECT_EQ(test, res, 0);
+	KUNIT_EXPECT_EQ(test, pos, 0);
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
+
+MODULE_LICENSE("GPL v2");
