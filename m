Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90120392E4A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 14:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhE0MwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 08:52:23 -0400
Received: from smtp1.axis.com ([195.60.68.17]:34882 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235761AbhE0MwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 08:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1622119849;
  x=1653655849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HE843OUk3i4titNovIMg/MrZrNh4mHoyES6G/9pokvw=;
  b=fJh2MVjKYEFFQylK9BWHI6VSzT8N58RHSJLFuNGPwob/EjnbAsyP0jZm
   zLY76HqcRJbTamsG6Dnsq1LLWGU2iqJYyd1GSYvAoSyDERaisNPM7pigP
   M+MjQMmvhDNYScKaB3nFpC9zSCAYdrWb707y4Kp8Xn4eLyAWDe8JMgQ38
   SSkJxbKKvUbo3PJb4YggmHrIO4UnO2DFzh5MXyMiGRfPaGMi347cYURm3
   /+05lQ6KCxCxe81K29L1CN3mj0FCCXzd0kBJv3Aa9UwyRqcZmeXetSOUl
   Oe2jQqtTsDJ/K998y2F43siq6BO9plc/M0dKsmGjHdQVDkkkQ6Xig+3vm
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <akpm@linux-foundation.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] squashfs: add option to panic on errors
Date:   Thu, 27 May 2021 14:50:19 +0200
Message-ID: <20210527125019.14511-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an errors=panic mount option to make squashfs trigger a panic when
errors are encountered, similar to several other filesystems.  This
allows a kernel dump to be saved using which the corruption can be
analysed and debugged.

Inspired by a pre-fs_context patch by Anton Eliasson.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 fs/squashfs/block.c          |  5 ++-
 fs/squashfs/squashfs_fs_sb.h |  1 +
 fs/squashfs/super.c          | 86 ++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index b9e87ebb1060..855f0e87066d 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -226,8 +226,11 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	bio_free_pages(bio);
 	bio_put(bio);
 out:
-	if (res < 0)
+	if (res < 0) {
 		ERROR("Failed to read block 0x%llx: %d\n", index, res);
+		if (msblk->panic_on_errors)
+			panic("squashfs read failed");
+	}
 
 	return res;
 }
diff --git a/fs/squashfs/squashfs_fs_sb.h b/fs/squashfs/squashfs_fs_sb.h
index 166e98806265..1e90c2575f9b 100644
--- a/fs/squashfs/squashfs_fs_sb.h
+++ b/fs/squashfs/squashfs_fs_sb.h
@@ -65,5 +65,6 @@ struct squashfs_sb_info {
 	unsigned int				fragments;
 	int					xattr_ids;
 	unsigned int				ids;
+	bool					panic_on_errors;
 };
 #endif
diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 88cc94be1076..60d6951915f4 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -18,9 +18,11 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_parser.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
+#include <linux/seq_file.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
 #include <linux/module.h>
@@ -37,6 +39,51 @@
 static struct file_system_type squashfs_fs_type;
 static const struct super_operations squashfs_super_ops;
 
+enum Opt_errors {
+	Opt_errors_continue,
+	Opt_errors_panic,
+};
+
+enum squashfs_param {
+	Opt_errors,
+};
+
+struct squashfs_mount_opts {
+	enum Opt_errors errors;
+};
+
+static const struct constant_table squashfs_param_errors[] = {
+	{"continue",   Opt_errors_continue },
+	{"panic",      Opt_errors_panic },
+	{}
+};
+
+static const struct fs_parameter_spec squashfs_fs_parameters[] = {
+	fsparam_enum("errors", Opt_errors, squashfs_param_errors),
+	{}
+};
+
+static int squashfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct squashfs_mount_opts *opts = fc->fs_private;
+	struct fs_parse_result result;
+	int opt;
+
+	opt = fs_parse(fc, squashfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_errors:
+		opts->errors = result.uint_32;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static const struct squashfs_decompressor *supported_squashfs_filesystem(
 	struct fs_context *fc,
 	short major, short minor, short id)
@@ -67,6 +114,7 @@ static const struct squashfs_decompressor *supported_squashfs_filesystem(
 
 static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
+	struct squashfs_mount_opts *opts = fc->fs_private;
 	struct squashfs_sb_info *msblk;
 	struct squashfs_super_block *sblk = NULL;
 	struct inode *root;
@@ -85,6 +133,8 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	msblk = sb->s_fs_info;
 
+	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
+
 	msblk->devblksize = sb_min_blocksize(sb, SQUASHFS_DEVBLK_SIZE);
 	msblk->devblksize_log2 = ffz(~msblk->devblksize);
 
@@ -350,18 +400,52 @@ static int squashfs_get_tree(struct fs_context *fc)
 
 static int squashfs_reconfigure(struct fs_context *fc)
 {
+	struct super_block *sb = fc->root->d_sb;
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+	struct squashfs_mount_opts *opts = fc->fs_private;
+
 	sync_filesystem(fc->root->d_sb);
 	fc->sb_flags |= SB_RDONLY;
+
+	msblk->panic_on_errors = (opts->errors == Opt_errors_panic);
+
 	return 0;
 }
 
+static void squashfs_free_fs_context(struct fs_context *fc)
+{
+	kfree(fc->fs_private);
+}
+
 static const struct fs_context_operations squashfs_context_ops = {
 	.get_tree	= squashfs_get_tree,
+	.free		= squashfs_free_fs_context,
+	.parse_param	= squashfs_parse_param,
 	.reconfigure	= squashfs_reconfigure,
 };
 
+static int squashfs_show_options(struct seq_file *s, struct dentry *root)
+{
+	struct super_block *sb = root->d_sb;
+	struct squashfs_sb_info *msblk = sb->s_fs_info;
+
+	if (msblk->panic_on_errors)
+		seq_puts(s, ",errors=panic");
+	else
+		seq_puts(s, ",errors=continue");
+
+	return 0;
+}
+
 static int squashfs_init_fs_context(struct fs_context *fc)
 {
+	struct squashfs_mount_opts *opts;
+
+	opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+	if (!opts)
+		return -ENOMEM;
+
+	fc->fs_private = opts;
 	fc->ops = &squashfs_context_ops;
 	return 0;
 }
@@ -481,6 +565,7 @@ static struct file_system_type squashfs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "squashfs",
 	.init_fs_context = squashfs_init_fs_context,
+	.parameters = squashfs_fs_parameters,
 	.kill_sb = kill_block_super,
 	.fs_flags = FS_REQUIRES_DEV
 };
@@ -491,6 +576,7 @@ static const struct super_operations squashfs_super_ops = {
 	.free_inode = squashfs_free_inode,
 	.statfs = squashfs_statfs,
 	.put_super = squashfs_put_super,
+	.show_options = squashfs_show_options,
 };
 
 module_init(init_squashfs_fs);
-- 
2.28.0

