Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4A39B222
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhFDFu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:50:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229787AbhFDFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:50:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A65126141B;
        Fri,  4 Jun 2021 05:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622785753;
        bh=QDo8LW4yLc2t73ix9puD5x09HJZydjyIddOSVdzoh8s=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=O72rKNnNZ/VyBtzX5w6yHMGe3SPzLrZJhfnGkFVAEO6CK2PFHesGn+8tDwqtJ75i+
         df/kFTONe99UVzsZ3eEDuOHXWAF1VRbtGaQpsFVDkXCxMI+ApMwBYeDBRyurmRm2H0
         zF8H0zIMD1GrkKX/4Z+kMaZsmdZzVJz832iHYdmn8Jsx71FC44u/kWNl0PodZ0Uciq
         fpuoOkdoMxL+T1YO1I5g+hFoIwYg3lOxZtWKQipRBlNiiaakO5N3VazQk3IEueaLsf
         tLC+g9ryinrRND5H/TyXOCJLW2YeHFZZdVWJ7dhVxnvX4VCXv6wLn23nEDlM7yD7+u
         XgjLnCw5HWRMA==
Date:   Thu, 3 Jun 2021 22:49:12 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: clean up /sys/fs/f2fs/<disk>/features
Message-ID: <YLm+2HUe0qKExg6b@google.com>
References: <20210603220834.1949988-1-jaegeuk@kernel.org>
 <YLmvIH/wVeKwSPCN@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLmvIH/wVeKwSPCN@google.com>
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
 Documentation/ABI/testing/sysfs-fs-f2fs |  28 +++-
 fs/f2fs/f2fs.h                          |   5 +
 fs/f2fs/sysfs.c                         | 200 ++++++++++++++++--------
 3 files changed, 169 insertions(+), 64 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 5088281e312e..ca697cc1e765 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -203,7 +203,33 @@ Description:	Shows total written kbytes issued to disk.
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
+		verity, sb_checksum, casefold, readonly, compression,
+		encrypted_casefold.
+		Note that, pin_file is moved into /sys/fs/f2fs/features/.
+
+What:		/sys/fs/f2fs/feature/
+Date:		July 2017
+Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
+Description:	Shows all enabled kernel features.
+		Supported features:
+		in addition to all in /sys/fs/f2fs/<disk>/feature_list/,
+		test_dummy_encryption_v2, atomic_write, pin_file
 
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
index a1d3ba75c753..1e9e1ea8d4f3 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -569,50 +569,53 @@ static void f2fs_sb_release(struct kobject *kobj)
 	complete(&sbi->s_kobj_unregister);
 }
 
-enum feat_id {
-	FEAT_CRYPTO = 0,
-	FEAT_BLKZONED,
-	FEAT_ATOMIC_WRITE,
-	FEAT_EXTRA_ATTR,
-	FEAT_PROJECT_QUOTA,
-	FEAT_INODE_CHECKSUM,
-	FEAT_FLEXIBLE_INLINE_XATTR,
-	FEAT_QUOTA_INO,
-	FEAT_INODE_CRTIME,
-	FEAT_LOST_FOUND,
-	FEAT_VERITY,
-	FEAT_SB_CHECKSUM,
-	FEAT_CASEFOLD,
-	FEAT_COMPRESSION,
-	FEAT_RO,
-	FEAT_TEST_DUMMY_ENCRYPTION_V2,
-	FEAT_ENCRYPTED_CASEFOLD,
-};
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
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
-	switch (a->id) {
-	case FEAT_CRYPTO:
-	case FEAT_BLKZONED:
-	case FEAT_ATOMIC_WRITE:
-	case FEAT_EXTRA_ATTR:
-	case FEAT_PROJECT_QUOTA:
-	case FEAT_INODE_CHECKSUM:
-	case FEAT_FLEXIBLE_INLINE_XATTR:
-	case FEAT_QUOTA_INO:
-	case FEAT_INODE_CRTIME:
-	case FEAT_LOST_FOUND:
-	case FEAT_VERITY:
-	case FEAT_SB_CHECKSUM:
-	case FEAT_CASEFOLD:
-	case FEAT_COMPRESSION:
-	case FEAT_RO:
-	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
-	case FEAT_ENCRYPTED_CASEFOLD:
+	return sprintf(buf, "supported\n");
+}
+
+#define F2FS_FEATURE_RO_ATTR(_name)				\
+static struct f2fs_attr f2fs_attr_##_name = {			\
+	.attr = {.name = __stringify(_name), .mode = 0444 },	\
+	.show	= f2fs_feature_show,				\
+}
+
+static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
+		struct f2fs_sb_info *sbi, char *buf)
+{
+	if (F2FS_MATCH_FEATURE(sbi, a->id))
 		return sprintf(buf, "supported\n");
-	}
-	return 0;
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
 }
 
 #define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
@@ -632,13 +635,6 @@ static struct f2fs_attr f2fs_attr_##_name = {			\
 #define F2FS_GENERAL_RO_ATTR(name) \
 static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
 
-#define F2FS_FEATURE_RO_ATTR(_name, _id)			\
-static struct f2fs_attr f2fs_attr_##_name = {			\
-	.attr = {.name = __stringify(_name), .mode = 0444 },	\
-	.show	= f2fs_feature_show,				\
-	.id	= _id,						\
-}
-
 #define F2FS_STAT_ATTR(_struct_type, _struct_name, _name, _elname)	\
 static struct f2fs_attr f2fs_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = 0444 },	\
@@ -712,33 +708,33 @@ F2FS_GENERAL_RO_ATTR(avg_vblocks);
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
-F2FS_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
-F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2, FEAT_TEST_DUMMY_ENCRYPTION_V2);
+F2FS_FEATURE_RO_ATTR(encryption);
+F2FS_FEATURE_RO_ATTR(test_dummy_encryption_v2);
 #ifdef CONFIG_UNICODE
-F2FS_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
+F2FS_FEATURE_RO_ATTR(encrypted_casefold);
 #endif /* CONFIG_UNICODE */
 #endif /* CONFIG_FS_ENCRYPTION */
 #ifdef CONFIG_BLK_DEV_ZONED
-F2FS_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
+F2FS_FEATURE_RO_ATTR(block_zoned);
 #endif
-F2FS_FEATURE_RO_ATTR(atomic_write, FEAT_ATOMIC_WRITE);
-F2FS_FEATURE_RO_ATTR(extra_attr, FEAT_EXTRA_ATTR);
-F2FS_FEATURE_RO_ATTR(project_quota, FEAT_PROJECT_QUOTA);
-F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
-F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
-F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
-F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
-F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
+F2FS_FEATURE_RO_ATTR(atomic_write);
+F2FS_FEATURE_RO_ATTR(extra_attr);
+F2FS_FEATURE_RO_ATTR(project_quota);
+F2FS_FEATURE_RO_ATTR(inode_checksum);
+F2FS_FEATURE_RO_ATTR(flexible_inline_xattr);
+F2FS_FEATURE_RO_ATTR(quota_ino);
+F2FS_FEATURE_RO_ATTR(inode_crtime);
+F2FS_FEATURE_RO_ATTR(lost_found);
 #ifdef CONFIG_FS_VERITY
-F2FS_FEATURE_RO_ATTR(verity, FEAT_VERITY);
+F2FS_FEATURE_RO_ATTR(verity);
 #endif
-F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
+F2FS_FEATURE_RO_ATTR(sb_checksum);
 #ifdef CONFIG_UNICODE
-F2FS_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
+F2FS_FEATURE_RO_ATTR(casefold);
 #endif
-F2FS_FEATURE_RO_ATTR(readonly, FEAT_RO);
+F2FS_FEATURE_RO_ATTR(readonly);
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-F2FS_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
+F2FS_FEATURE_RO_ATTR(compression);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
@@ -869,6 +865,42 @@ static struct attribute *f2fs_stat_attrs[] = {
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
 
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
@@ -935,6 +967,34 @@ static struct kobj_type f2fs_stat_ktype = {
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
@@ -1151,6 +1211,14 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
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
 
@@ -1165,6 +1233,9 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 				victim_bits_seq_show, sb);
 	}
 	return 0;
+put_feature_list_kobj:
+	kobject_put(&sbi->s_feature_list_kobj);
+	wait_for_completion(&sbi->s_feature_list_kobj_unregister);
 put_stat_kobj:
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
@@ -1187,6 +1258,9 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
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

