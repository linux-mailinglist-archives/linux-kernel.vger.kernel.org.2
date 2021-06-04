Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA9239B192
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbhFDEn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:33354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhFDEnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:43:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 196EA613FF;
        Fri,  4 Jun 2021 04:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622781730;
        bh=B2WXhn6F+zQ9phQI0ES947LHVqJuRspJp/dzqFYg+BU=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=uDyqcAL5xUtzRLgLcFm3Xr7yDWBg7b8IosdPx7Pn4rUyB+5rSLJfqQ7gjXA1djuAE
         tiWvG6YihLr6AZYeAH6xLJCokg3qIZEblpElUF3ZVRnIcOIp7WHm3WSE/TOa+MRp5k
         Qu4xIaQ/KWS4ARjnuAMN3JM4QV6VL4JVAEAQSk5bJb+721gnqDDTz+kHCjnJKjxSxr
         awLJULx/euEmF6ylQdVjWd/Zkgun6K90tJqC9qfqffpCNo321bNfKYzit/o3rqh76e
         TAND3yj1eeu+uWIpihkeDG7XyFu2NHbB0yegEX5rt+b5nMUXUIlct39zHazIOX/FMZ
         utizkFUCH5L1w==
Date:   Thu, 3 Jun 2021 21:42:08 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: clean up /sys/fs/f2fs/<disk>/features
Message-ID: <YLmvIH/wVeKwSPCN@google.com>
References: <20210603220834.1949988-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603220834.1949988-1-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's create /sys/fs/f2fs/<disk>/feature_list/ to meet sysfs rule.

Note that there are three feature list entries:
1) /sys/fs/f2fs/features
  : shows runtime features supported by in-kernel f2fs along with Kconfig
    - ref. F2FS_FEATURE_RO_ATTR()

2) /sys/fs/f2fs/$s_id/features <deprecated>
  : shows on-disk features enabled by mkfs.f2fs, used for old kernels

3) /sys/fs/f2fs/$s_id/feature_list
  : shows on-disk features enabled by mkfs.f2fs per instance.
    this list covers old feature list provided by 2) and beyond
    - ref. F2FS_SB_FEATURE_RO_ATTR()

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  29 +++++-
 fs/f2fs/f2fs.h                          |   5 +
 fs/f2fs/sysfs.c                         | 118 ++++++++++++++++++++++++
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 5088281e312e..86d5e0e12a07 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -203,7 +203,34 @@ Description:	Shows total written kbytes issued to disk.
 What:		/sys/fs/f2fs/<disk>/features
 Date:		July 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
-Description:	Shows all enabled features in current device.
+Description:	<deprecated: should use /sys/fs/f2fs/<disk>/feature_list/
+		Shows all enabled features in current device.
+		Supported features:
+		encryption, blkzoned, extra_attr, projquota, inode_checksum,
+		flexible_inline_xattr, quota_ino, inode_crtime, lost_found,
+		verity, sb_checksum, casefold, readonly, compression,
+		encrypted_casefold, pin_file.
+
+What:		/sys/fs/f2fs/<disk>/feature_list/
+Date:		June 2021
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Expand /sys/fs/f2fs/<disk>/features to meet sysfs rule.
+		Supported on-disk features:
+		encryption, block_zoned (aka blkzoned), extra_attr,
+		project_quota (aka projquota), inode_checksum,
+		flexible_inline_xattr, quota_ino, inode_crtime, lost_found,
+		verity, sb_checksum, casefold, readonly, compression.
+		Note that, encrypted_casefold and pin_file were moved into
+		/sys/fs/f2fs/features/.
+
+What:		/sys/fs/f2fs/feature/
+Date:		July 2017
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Shows all enabled kernel features.
+		Supported features:
+		in addition to all in /sys/fs/f2fs/<disk>/feature_list/,
+		test_dummy_encryption_v2, encrypted_casefold, pin_file,
+		atomic_write
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8903c43091f8..c8c29effd844 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -172,6 +172,8 @@ struct f2fs_mount_info {
 
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
+#define F2FS_MATCH_FEATURE(sbi, mask)					\
+	((sbi->raw_super->feature & cpu_to_le32(mask)) == cpu_to_le32(mask))
 #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
 #define F2FS_SET_FEATURE(sbi, mask)					\
 	(sbi->raw_super->feature |= cpu_to_le32(mask))
@@ -1665,6 +1667,9 @@ struct f2fs_sb_info {
 	struct kobject s_stat_kobj;		/* /sys/fs/f2fs/<devname>/stat */
 	struct completion s_stat_kobj_unregister;
 
+	struct kobject s_feature_list_kobj;		/* /sys/fs/f2fs/<devname>/feature_list */
+	struct completion s_feature_list_kobj_unregister;
+
 	/* For shrinker support */
 	struct list_head s_list;
 	int s_ndevs;				/* number of devices */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2a76c959a7b4..f1d8b151cc36 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -569,6 +569,20 @@ static void f2fs_sb_release(struct kobject *kobj)
 	complete(&sbi->s_kobj_unregister);
 }
 
+/*
+ * Note that there are three feature list entries:
+ * 1) /sys/fs/f2fs/features
+ *   : shows runtime features supported by in-kernel f2fs along with Kconfig
+ *     - ref. F2FS_FEATURE_RO_ATTR()
+ *
+ * 2) /sys/fs/f2fs/$s_id/features <deprecated>
+ *   : shows on-disk features enabled by mkfs.f2fs, used for old kernels
+ *
+ * 3) /sys/fs/f2fs/$s_id/feature_list
+ *   : shows on-disk features enabled by mkfs.f2fs per instance.
+ *     this list covers old feature list provided by 2) and beyond
+ *     - ref. F2FS_SB_FEATURE_RO_ATTR()
+ */
 enum feat_id {
 	FEAT_CRYPTO = 0,
 	FEAT_BLKZONED,
@@ -587,6 +601,7 @@ enum feat_id {
 	FEAT_RO,
 	FEAT_TEST_DUMMY_ENCRYPTION_V2,
 	FEAT_ENCRYPTED_CASEFOLD,
+	FEAT_PIN_FILE,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
@@ -610,6 +625,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 	case FEAT_RO:
 	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
 	case FEAT_ENCRYPTED_CASEFOLD:
+	case FEAT_PIN_FILE:
 		return sprintf(buf, "supported\n");
 	}
 	return 0;
@@ -743,6 +759,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
 #endif
+F2FS_FEATURE_RO_ATTR(pin_file, FEAT_PIN_FILE);
 
 /* For ATGC */
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_ratio, candidate_ratio);
@@ -856,6 +873,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
+	ATTR_LIST(pin_file),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
@@ -867,6 +885,64 @@ static struct attribute *f2fs_stat_attrs[] = {
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
 
+static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	if (F2FS_MATCH_FEATURE(sbi, a->id))
+		return sprintf(buf, "supported\n");
+	return sprintf(buf, "unsupported\n");
+}
+
+#define F2FS_SB_FEATURE_RO_ATTR(_name, _feat)			\
+static struct f2fs_attr f2fs_attr_sb_##_name = {		\
+	.attr = {.name = __stringify(_name), .mode = 0444 },	\
+	.show	= f2fs_sb_feature_show,				\
+	.id	= F2FS_FEATURE_##_feat,				\
+}
+
+#define F2FS_SB_FEATURE_RO_ATTR2(_name, _feat1, _feat2)		\
+static struct f2fs_attr f2fs_attr_sb_##_name = {		\
+	.attr = {.name = __stringify(_name), .mode = 0444 },	\
+	.show	= f2fs_sb_feature_show,				\
+	.id	= F2FS_FEATURE_##_feat1 | F2FS_FEATURE_##_feat2,\
+}
+
+F2FS_SB_FEATURE_RO_ATTR(encryption, ENCRYPT);
+F2FS_SB_FEATURE_RO_ATTR(block_zoned, BLKZONED);
+F2FS_SB_FEATURE_RO_ATTR(extra_attr, EXTRA_ATTR);
+F2FS_SB_FEATURE_RO_ATTR(project_quota, PRJQUOTA);
+F2FS_SB_FEATURE_RO_ATTR(inode_checksum, INODE_CHKSUM);
+F2FS_SB_FEATURE_RO_ATTR(flexible_inline_xattr, FLEXIBLE_INLINE_XATTR);
+F2FS_SB_FEATURE_RO_ATTR(quota_ino, QUOTA_INO);
+F2FS_SB_FEATURE_RO_ATTR(inode_crtime, INODE_CRTIME);
+F2FS_SB_FEATURE_RO_ATTR(lost_found, LOST_FOUND);
+F2FS_SB_FEATURE_RO_ATTR(verity, VERITY);
+F2FS_SB_FEATURE_RO_ATTR(sb_checksum, SB_CHKSUM);
+F2FS_SB_FEATURE_RO_ATTR(casefold, CASEFOLD);
+F2FS_SB_FEATURE_RO_ATTR(compression, COMPRESSION);
+F2FS_SB_FEATURE_RO_ATTR(readonly, RO);
+F2FS_SB_FEATURE_RO_ATTR2(encrypted_casefold, ENCRYPT, CASEFOLD);
+
+static struct attribute *f2fs_sb_feat_attrs[] = {
+	ATTR_LIST(sb_encryption),
+	ATTR_LIST(sb_block_zoned),
+	ATTR_LIST(sb_extra_attr),
+	ATTR_LIST(sb_project_quota),
+	ATTR_LIST(sb_inode_checksum),
+	ATTR_LIST(sb_flexible_inline_xattr),
+	ATTR_LIST(sb_quota_ino),
+	ATTR_LIST(sb_inode_crtime),
+	ATTR_LIST(sb_lost_found),
+	ATTR_LIST(sb_verity),
+	ATTR_LIST(sb_sb_checksum),
+	ATTR_LIST(sb_casefold),
+	ATTR_LIST(sb_compression),
+	ATTR_LIST(sb_readonly),
+	ATTR_LIST(sb_encrypted_casefold),
+	NULL,
+};
+ATTRIBUTE_GROUPS(f2fs_sb_feat);
+
 static const struct sysfs_ops f2fs_attr_ops = {
 	.show	= f2fs_attr_show,
 	.store	= f2fs_attr_store,
@@ -933,6 +1009,34 @@ static struct kobj_type f2fs_stat_ktype = {
 	.release	= f2fs_stat_kobj_release,
 };
 
+static ssize_t f2fs_sb_feat_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+							s_feature_list_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->show ? a->show(a, sbi, buf) : 0;
+}
+
+static void f2fs_feature_list_kobj_release(struct kobject *kobj)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+							s_feature_list_kobj);
+	complete(&sbi->s_feature_list_kobj_unregister);
+}
+
+static const struct sysfs_ops f2fs_feature_list_attr_ops = {
+	.show	= f2fs_sb_feat_attr_show,
+};
+
+static struct kobj_type f2fs_feature_list_ktype = {
+	.default_groups = f2fs_sb_feat_groups,
+	.sysfs_ops	= &f2fs_feature_list_attr_ops,
+	.release	= f2fs_feature_list_kobj_release,
+};
+
+
 static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
 						void *offset)
 {
@@ -1149,6 +1253,14 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	if (err)
 		goto put_stat_kobj;
 
+	sbi->s_feature_list_kobj.kset = &f2fs_kset;
+	init_completion(&sbi->s_feature_list_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_feature_list_kobj,
+					&f2fs_feature_list_ktype,
+					&sbi->s_kobj, "feature_list");
+	if (err)
+		goto put_feature_list_kobj;
+
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
 
@@ -1163,6 +1275,9 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				victim_bits_seq_show, sb);
 	}
 	return 0;
+put_feature_list_kobj:
+	kobject_put(&sbi->s_feature_list_kobj);
+	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 put_stat_kobj:
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
@@ -1185,6 +1300,9 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 	kobject_del(&sbi->s_stat_kobj);
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
+	kobject_del(&sbi->s_feature_list_kobj);
+	kobject_put(&sbi->s_feature_list_kobj);
+	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 
 	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

