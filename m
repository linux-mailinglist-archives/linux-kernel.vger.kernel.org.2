Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA539AD76
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 00:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhFCWK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 18:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229924AbhFCWKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:10:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6F60C613F9;
        Thu,  3 Jun 2021 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622758120;
        bh=W3YnTuFowyxh6PaM08Dc2jipblg6Axyh4ECrxVAo774=;
        h=From:To:Cc:Subject:Date:From;
        b=IkKxfoamWQiVM58iFQ9rb3aUyEWu1Egze7QJ1f74hqU72eoEEaA13MVM475KCtEC5
         5qqBeOaeY38tmuHMkd94m6aZ8ENypcRB0iCsFhqGW+LZqKg51I1bQ/FQ1fOdfZp5a2
         WdiXTw1QcapOWw0JRApeipETRROnO6Kn9pUDsFME5ojBwlVNsWYoWOA/sjqugkFHXz
         SdU7zSK9EFQFXyvZJWN7fpdEjl1rsQ1Nf9dMNNZAF5VlLASshMJp2vz+TZQO9yPnzN
         V89bcKkcXIKzyJGSn8AZ/5MhTz0f1W/l5YKerfTY/vkiccGZdsJXmuwp9TsJbEJI5E
         0LMoRAMdtChnw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: clean up /sys/fs/f2fs/<disk>/features
Date:   Thu,  3 Jun 2021 15:08:34 -0700
Message-Id: <20210603220834.1949988-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's create /sys/fs/f2fs/<disk>/feature_list/ to meet sysfs rule.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 Documentation/ABI/testing/sysfs-fs-f2fs |  18 ++-
 fs/f2fs/f2fs.h                          |   3 +
 fs/f2fs/sysfs.c                         | 152 +++++++++++++++++++++++-
 3 files changed, 168 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index 5088281e312e..43b2cde80b70 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -203,7 +203,23 @@ Description:	Shows total written kbytes issued to disk.
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
+		Supported features:
+		encryption, block_zoned, extra_attr, projquota, inode_checksum,
+		flexible_inline_xattr, quota_ino, inode_crtime, lost_found,
+		verity, sb_checksum, casefold, readonly, compression,
+		encrypted_casefold, pin_file.
 
 What:		/sys/fs/f2fs/<disk>/inject_rate
 Date:		May 2016
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 8903c43091f8..17ade71547f1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1665,6 +1665,9 @@ struct f2fs_sb_info {
 	struct kobject s_stat_kobj;		/* /sys/fs/f2fs/<devname>/stat */
 	struct completion s_stat_kobj_unregister;
 
+	struct kobject s_disk_feat_kobj;		/* /sys/fs/f2fs/<devname>/feature_list */
+	struct completion s_disk_feat_kobj_unregister;
+
 	/* For shrinker support */
 	struct list_head s_list;
 	int s_ndevs;				/* number of devices */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 2a76c959a7b4..5d591f0b79b7 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -587,32 +587,85 @@ enum feat_id {
 	FEAT_RO,
 	FEAT_TEST_DUMMY_ENCRYPTION_V2,
 	FEAT_ENCRYPTED_CASEFOLD,
+	FEAT_PIN_FILE,
 };
 
 static ssize_t f2fs_feature_show(struct f2fs_attr *a,
 		struct f2fs_sb_info *sbi, char *buf)
 {
+	unsigned long feat_supp = 0;
+
 	switch (a->id) {
 	case FEAT_CRYPTO:
+		feat_supp |= f2fs_sb_has_encrypt(sbi) ?
+					(1 << FEAT_CRYPTO) : 0;
+		fallthrough;
 	case FEAT_BLKZONED:
-	case FEAT_ATOMIC_WRITE:
+		feat_supp |= f2fs_sb_has_blkzoned(sbi) ?
+					(1 << FEAT_BLKZONED) : 0;
+		fallthrough;
 	case FEAT_EXTRA_ATTR:
+		feat_supp |= f2fs_sb_has_extra_attr(sbi) ?
+					(1 << FEAT_EXTRA_ATTR) : 0;
+		fallthrough;
 	case FEAT_PROJECT_QUOTA:
+		feat_supp |= f2fs_sb_has_project_quota(sbi) ?
+					(1 << FEAT_PROJECT_QUOTA) : 0;
+		fallthrough;
 	case FEAT_INODE_CHECKSUM:
+		feat_supp |= f2fs_sb_has_inode_chksum(sbi) ?
+					(1 << FEAT_INODE_CHECKSUM) : 0;
+		fallthrough;
 	case FEAT_FLEXIBLE_INLINE_XATTR:
+		feat_supp |= f2fs_sb_has_flexible_inline_xattr(sbi) ?
+					(1 << FEAT_FLEXIBLE_INLINE_XATTR) : 0;
+		fallthrough;
 	case FEAT_QUOTA_INO:
+		feat_supp |= f2fs_sb_has_quota_ino(sbi) ?
+					(1 << FEAT_QUOTA_INO) : 0;
+		fallthrough;
 	case FEAT_INODE_CRTIME:
+		feat_supp |= f2fs_sb_has_inode_crtime(sbi) ?
+					(1 << FEAT_INODE_CRTIME) : 0;
+		fallthrough;
 	case FEAT_LOST_FOUND:
+		feat_supp |= f2fs_sb_has_lost_found(sbi) ?
+					(1 << FEAT_LOST_FOUND) : 0;
+		fallthrough;
 	case FEAT_VERITY:
+		feat_supp |= f2fs_sb_has_verity(sbi) ?
+					(1 << FEAT_VERITY) : 0;
+		fallthrough;
 	case FEAT_SB_CHECKSUM:
+		feat_supp |= f2fs_sb_has_sb_chksum(sbi) ?
+					(1 << FEAT_SB_CHECKSUM) : 0;
+		fallthrough;
 	case FEAT_CASEFOLD:
+		feat_supp |= f2fs_sb_has_casefold(sbi) ?
+					(1 << FEAT_CASEFOLD) : 0;
+		fallthrough;
 	case FEAT_COMPRESSION:
+		feat_supp |= f2fs_sb_has_compression(sbi) ?
+					(1 << FEAT_COMPRESSION) : 0;
+		fallthrough;
 	case FEAT_RO:
-	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
+		feat_supp |= f2fs_sb_has_readonly(sbi) ?
+					(1 << FEAT_RO) : 0;
+		fallthrough;
 	case FEAT_ENCRYPTED_CASEFOLD:
-		return sprintf(buf, "supported\n");
+		feat_supp |= (f2fs_sb_has_casefold(sbi) &&
+				f2fs_sb_has_encrypt(sbi)) ?
+					(1 << FEAT_ENCRYPTED_CASEFOLD) : 0;
+		fallthrough;
+	case FEAT_PIN_FILE:
+		feat_supp |= (1 << FEAT_PIN_FILE);
+		fallthrough;
+	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
+	case FEAT_ATOMIC_WRITE:
+		if (!a->offset || feat_supp & (1 << a->id))
+			return sprintf(buf, "supported\n");
 	}
-	return 0;
+	return sprintf(buf, "not supported\n");
 }
 
 #define F2FS_ATTR_OFFSET(_struct_type, _name, _mode, _show, _store, _offset) \
@@ -636,6 +689,7 @@ static struct f2fs_attr f2fs_attr_##name = __ATTR(name, 0444, name##_show, NULL)
 static struct f2fs_attr f2fs_attr_##_name = {			\
 	.attr = {.name = __stringify(_name), .mode = 0444 },	\
 	.show	= f2fs_feature_show,				\
+	.offset	= 0,						\
 	.id	= _id,						\
 }
 
@@ -743,6 +797,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_written_block, compr_written_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_saved_block, compr_saved_block);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, compr_new_inode, compr_new_inode);
 #endif
+F2FS_FEATURE_RO_ATTR(pin_file, FEAT_PIN_FILE);
 
 /* For ATGC */
 F2FS_RW_ATTR(ATGC_INFO, atgc_management, atgc_candidate_ratio, candidate_ratio);
@@ -856,6 +911,7 @@ static struct attribute *f2fs_feat_attrs[] = {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	ATTR_LIST(compression),
 #endif
+	ATTR_LIST(pin_file),
 	NULL,
 };
 ATTRIBUTE_GROUPS(f2fs_feat);
@@ -867,6 +923,52 @@ static struct attribute *f2fs_stat_attrs[] = {
 };
 ATTRIBUTE_GROUPS(f2fs_stat);
 
+#define F2FS_DISK_FEATURE_RO_ATTR(_name, _id)			\
+static struct f2fs_attr f2fs_attr_disk_##_name = {		\
+	.attr = {.name = __stringify(_name), .mode = 0444 },	\
+	.show	= f2fs_feature_show,				\
+	.offset	= 1,						\
+	.id	= _id,						\
+}
+
+F2FS_DISK_FEATURE_RO_ATTR(encryption, FEAT_CRYPTO);
+F2FS_DISK_FEATURE_RO_ATTR(block_zoned, FEAT_BLKZONED);
+F2FS_DISK_FEATURE_RO_ATTR(extra_attr, FEAT_EXTRA_ATTR);
+F2FS_DISK_FEATURE_RO_ATTR(project_quota, FEAT_PROJECT_QUOTA);
+F2FS_DISK_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
+F2FS_DISK_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
+F2FS_DISK_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
+F2FS_DISK_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
+F2FS_DISK_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
+F2FS_DISK_FEATURE_RO_ATTR(verity, FEAT_VERITY);
+F2FS_DISK_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
+F2FS_DISK_FEATURE_RO_ATTR(casefold, FEAT_CASEFOLD);
+F2FS_DISK_FEATURE_RO_ATTR(compression, FEAT_COMPRESSION);
+F2FS_DISK_FEATURE_RO_ATTR(readonly, FEAT_RO);
+F2FS_DISK_FEATURE_RO_ATTR(encrypted_casefold, FEAT_ENCRYPTED_CASEFOLD);
+F2FS_DISK_FEATURE_RO_ATTR(pin_file, FEAT_PIN_FILE);
+
+static struct attribute *f2fs_disk_feat_attrs[] = {
+	ATTR_LIST(disk_encryption),
+	ATTR_LIST(disk_block_zoned),
+	ATTR_LIST(disk_extra_attr),
+	ATTR_LIST(disk_project_quota),
+	ATTR_LIST(disk_inode_checksum),
+	ATTR_LIST(disk_flexible_inline_xattr),
+	ATTR_LIST(disk_quota_ino),
+	ATTR_LIST(disk_inode_crtime),
+	ATTR_LIST(disk_lost_found),
+	ATTR_LIST(disk_verity),
+	ATTR_LIST(disk_sb_checksum),
+	ATTR_LIST(disk_casefold),
+	ATTR_LIST(disk_compression),
+	ATTR_LIST(disk_readonly),
+	ATTR_LIST(disk_encrypted_casefold),
+	ATTR_LIST(disk_pin_file),
+	NULL,
+};
+ATTRIBUTE_GROUPS(f2fs_disk_feat);
+
 static const struct sysfs_ops f2fs_attr_ops = {
 	.show	= f2fs_attr_show,
 	.store	= f2fs_attr_store,
@@ -933,6 +1035,34 @@ static struct kobj_type f2fs_stat_ktype = {
 	.release	= f2fs_stat_kobj_release,
 };
 
+static ssize_t f2fs_disk_feat_attr_show(struct kobject *kobj,
+				struct attribute *attr, char *buf)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+							s_disk_feat_kobj);
+	struct f2fs_attr *a = container_of(attr, struct f2fs_attr, attr);
+
+	return a->show ? a->show(a, sbi, buf) : 0;
+}
+
+static void f2fs_disk_feat_kobj_release(struct kobject *kobj)
+{
+	struct f2fs_sb_info *sbi = container_of(kobj, struct f2fs_sb_info,
+							s_disk_feat_kobj);
+	complete(&sbi->s_disk_feat_kobj_unregister);
+}
+
+static const struct sysfs_ops f2fs_disk_feat_attr_ops = {
+	.show	= f2fs_disk_feat_attr_show,
+};
+
+static struct kobj_type f2fs_disk_feat_ktype = {
+	.default_groups = f2fs_disk_feat_groups,
+	.sysfs_ops	= &f2fs_disk_feat_attr_ops,
+	.release	= f2fs_disk_feat_kobj_release,
+};
+
+
 static int __maybe_unused segment_info_seq_show(struct seq_file *seq,
 						void *offset)
 {
@@ -1149,6 +1279,15 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 	if (err)
 		goto put_stat_kobj;
 
+	sbi->s_disk_feat_kobj.kset = &f2fs_kset;
+	init_completion(&sbi->s_disk_feat_kobj_unregister);
+	err = kobject_init_and_add(&sbi->s_disk_feat_kobj,
+						&f2fs_disk_feat_ktype,
+						&sbi->s_kobj, "feature_list");
+	if (err)
+		goto put_stat_kobj;
+
+
 	if (f2fs_proc_root)
 		sbi->s_proc = proc_mkdir(sb->s_id, f2fs_proc_root);
 
@@ -1166,6 +1305,8 @@ int f2fs_register_sysfs(struct f2fs_sb_info *sbi)
 put_stat_kobj:
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
+	kobject_put(&sbi->s_disk_feat_kobj);
+	wait_for_completion(&sbi->s_disk_feat_kobj_unregister);
 put_sb_kobj:
 	kobject_put(&sbi->s_kobj);
 	wait_for_completion(&sbi->s_kobj_unregister);
@@ -1185,6 +1326,9 @@ void f2fs_unregister_sysfs(struct f2fs_sb_info *sbi)
 	kobject_del(&sbi->s_stat_kobj);
 	kobject_put(&sbi->s_stat_kobj);
 	wait_for_completion(&sbi->s_stat_kobj_unregister);
+	kobject_del(&sbi->s_disk_feat_kobj);
+	kobject_put(&sbi->s_disk_feat_kobj);
+	wait_for_completion(&sbi->s_disk_feat_kobj_unregister);
 
 	kobject_del(&sbi->s_kobj);
 	kobject_put(&sbi->s_kobj);
-- 
2.32.0.rc1.229.g3e70b5a671-goog

