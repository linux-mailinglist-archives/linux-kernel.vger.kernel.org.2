Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FC30DA0C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhBCMox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:44:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229909AbhBCMnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356101;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAV2DtGdnze6/DUXreZRwzqN5h4wCJbjqK470XAgNOg=;
        b=fpo1hBkX3XVf/Yxf+qA/oTydamI0zN3/Vmm3yp/C6EP3MBg62UKFIBhhgqTd5gbwIgHBGw
        QVHZQo+uQA0KAK+S6ki8zVYJYHrbF/yOZPZiWtOLGvIJCzbsR6ltdu1FIMM3a4Y9VUjHQq
        xrUvzmFvZy9QbJinjH/xe62nvP9GXxE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-Rlz-TbQMNxiMWe3jZMm5eg-1; Wed, 03 Feb 2021 07:41:39 -0500
X-MC-Unique: Rlz-TbQMNxiMWe3jZMm5eg-1
Received: by mail-ej1-f69.google.com with SMTP id yh28so2809026ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bAV2DtGdnze6/DUXreZRwzqN5h4wCJbjqK470XAgNOg=;
        b=FE77vIsb2i8C2NfH0WlCCNVAxjGzQdXOaofk+I0yJTETOdaIOJ23XUhbxQwTywwqsM
         8k8EgUp2/ObKqyaonr9q9XLG5L2lZo5Vt7T5v5I5NEoeB8LrSNG0sWx+f81shHGJpOkT
         p4uiXuFs0jPWhiCQuTI/3Bq1ioxRFyFWIivhxcrdYyTVLr+/5F6tZaCUXnaIs6ERZdY3
         vZfLWV0khbChiDdnGzyQipyDat9SqtrnPK7M+PpJFvdQHfcCoeV2vOgIkl+5OxoH5oNJ
         9sNLWl1sWLxNPi7cKUj+429AzAlG7Jvjh7qugaPaueoIxb41iRD3p0wm6Wolfk5X5r/G
         1m/Q==
X-Gm-Message-State: AOAM532QmwSW0Y69IIRgq3zCk1MvW0ftKUmRzxToKkhVcFHpYD/qRU2C
        90Yr4yTEYWk4BWoWy3Fmo0XeaOdZp0qFEndVhSQ1uKUQ84kKA1uPT0Qs8fq3hkWndJAY/8zwgXE
        NsqNUc6kzoz24UxjWpr/mTs1+
X-Received: by 2002:a17:907:1701:: with SMTP id le1mr3098025ejc.68.1612356098494;
        Wed, 03 Feb 2021 04:41:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzNi4/C8vpY7XNwhaBRa6kzdFiPSnJyZhGUYsQD4yAaPEiqbu2AtRMST7tFQvLDvi0bQi9Swg==
X-Received: by 2002:a17:907:1701:: with SMTP id le1mr3098008ejc.68.1612356098232;
        Wed, 03 Feb 2021 04:41:38 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:37 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH 04/18] btrfs: convert to miscattr
Date:   Wed,  3 Feb 2021 13:40:58 +0100
Message-Id: <20210203124112.1182614-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210203124112.1182614-1-mszeredi@redhat.com>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the miscattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.h |   2 +
 fs/btrfs/inode.c |   4 +
 fs/btrfs/ioctl.c | 248 +++++++++--------------------------------------
 3 files changed, 50 insertions(+), 204 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 4debdbdde2ab..c8e48ed4ea70 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3177,6 +3177,8 @@ void btrfs_update_inode_bytes(struct btrfs_inode *inode,
 /* ioctl.c */
 long btrfs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int btrfs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int btrfs_miscattr_set(struct dentry *dentry, struct miscattr *ma);
 int btrfs_ioctl_get_supported_features(void __user *arg);
 void btrfs_sync_inode_flags_to_i_flags(struct inode *inode);
 int __pure btrfs_is_empty_uuid(u8 *uuid);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index a8e0a6b038d3..048044f4c44b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -10348,6 +10348,8 @@ static const struct inode_operations btrfs_dir_inode_operations = {
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
 	.tmpfile        = btrfs_tmpfile,
+	.miscattr_get	= btrfs_miscattr_get,
+	.miscattr_set	= btrfs_miscattr_set,
 };
 
 static const struct file_operations btrfs_dir_file_operations = {
@@ -10401,6 +10403,8 @@ static const struct inode_operations btrfs_file_inode_operations = {
 	.get_acl	= btrfs_get_acl,
 	.set_acl	= btrfs_set_acl,
 	.update_time	= btrfs_update_time,
+	.miscattr_get	= btrfs_miscattr_get,
+	.miscattr_set	= btrfs_miscattr_set,
 };
 static const struct inode_operations btrfs_special_inode_operations = {
 	.getattr	= btrfs_getattr,
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index dde49a791f3e..d40cd719a013 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -26,6 +26,7 @@
 #include <linux/btrfs.h>
 #include <linux/uaccess.h>
 #include <linux/iversion.h>
+#include <linux/miscattr.h>
 #include "ctree.h"
 #include "disk-io.h"
 #include "export.h"
@@ -153,16 +154,6 @@ void btrfs_sync_inode_flags_to_i_flags(struct inode *inode)
 		      new_fl);
 }
 
-static int btrfs_ioctl_getflags(struct file *file, void __user *arg)
-{
-	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
-	unsigned int flags = btrfs_inode_flags_to_fsflags(binode->flags);
-
-	if (copy_to_user(arg, &flags, sizeof(flags)))
-		return -EFAULT;
-	return 0;
-}
-
 /*
  * Check if @flags are a supported and valid set of FS_*_FL flags and that
  * the old and new flags are not conflicting
@@ -201,9 +192,33 @@ static int check_fsflags_compatible(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
+bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
+			enum btrfs_exclusive_operation type)
 {
-	struct inode *inode = file_inode(file);
+	return !cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE, type);
+}
+
+void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
+{
+	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
+	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
+}
+
+/*
+ * Set flags/xflags from the internal inode flags. The remaining items of
+ * fsxattr are zeroed.
+ */
+int btrfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct btrfs_inode *binode = BTRFS_I(d_inode(dentry));
+
+	miscattr_fill_flags(ma, btrfs_inode_flags_to_fsflags(binode->flags));
+	return 0;
+}
+
+int btrfs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_inode *binode = BTRFS_I(inode);
 	struct btrfs_root *root = binode->root;
@@ -213,34 +228,21 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	const char *comp = NULL;
 	u32 binode_flags;
 
-	if (!inode_owner_or_capable(inode))
-		return -EPERM;
-
 	if (btrfs_root_readonly(root))
 		return -EROFS;
 
-	if (copy_from_user(&fsflags, arg, sizeof(fsflags)))
-		return -EFAULT;
-
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
+	if (miscattr_has_xattr(ma))
+		return -EOPNOTSUPP;
 
-	inode_lock(inode);
-	fsflags = btrfs_mask_fsflags_for_type(inode, fsflags);
+	fsflags = btrfs_mask_fsflags_for_type(inode, ma->flags);
 	old_fsflags = btrfs_inode_flags_to_fsflags(binode->flags);
-
-	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
-	if (ret)
-		goto out_unlock;
-
 	ret = check_fsflags(old_fsflags, fsflags);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	ret = check_fsflags_compatible(fs_info, fsflags);
 	if (ret)
-		goto out_unlock;
+		return ret;
 
 	binode_flags = binode->flags;
 	if (fsflags & FS_SYNC_FL)
@@ -263,6 +265,13 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 		binode_flags |= BTRFS_INODE_NOATIME;
 	else
 		binode_flags &= ~BTRFS_INODE_NOATIME;
+
+	/* if coming from FS_IOC_FSSETXATTR then skip unconverted flags */
+	if (!ma->flags_valid) {
+		trans = btrfs_start_transaction(root, 1);
+		goto update_flags;
+	}
+
 	if (fsflags & FS_DIRSYNC_FL)
 		binode_flags |= BTRFS_INODE_DIRSYNC;
 	else
@@ -303,10 +312,8 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 		binode_flags |= BTRFS_INODE_NOCOMPRESS;
 	} else if (fsflags & FS_COMPR_FL) {
 
-		if (IS_SWAPFILE(inode)) {
-			ret = -ETXTBSY;
-			goto out_unlock;
-		}
+		if (IS_SWAPFILE(inode))
+			return -ETXTBSY;
 
 		binode_flags |= BTRFS_INODE_COMPRESS;
 		binode_flags &= ~BTRFS_INODE_NOCOMPRESS;
@@ -323,10 +330,8 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 	 * 2 for properties
 	 */
 	trans = btrfs_start_transaction(root, 3);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		goto out_unlock;
-	}
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
 
 	if (comp) {
 		ret = btrfs_set_prop(trans, inode, "btrfs.compression", comp,
@@ -344,6 +349,7 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 		}
 	}
 
+update_flags:
 	binode->flags = binode_flags;
 	btrfs_sync_inode_flags_to_i_flags(inode);
 	inode_inc_iversion(inode);
@@ -352,158 +358,6 @@ static int btrfs_ioctl_setflags(struct file *file, void __user *arg)
 
  out_end_trans:
 	btrfs_end_transaction(trans);
- out_unlock:
-	inode_unlock(inode);
-	mnt_drop_write_file(file);
-	return ret;
-}
-
-/*
- * Translate btrfs internal inode flags to xflags as expected by the
- * FS_IOC_FSGETXATT ioctl. Filter only the supported ones, unknown flags are
- * silently dropped.
- */
-static unsigned int btrfs_inode_flags_to_xflags(unsigned int flags)
-{
-	unsigned int xflags = 0;
-
-	if (flags & BTRFS_INODE_APPEND)
-		xflags |= FS_XFLAG_APPEND;
-	if (flags & BTRFS_INODE_IMMUTABLE)
-		xflags |= FS_XFLAG_IMMUTABLE;
-	if (flags & BTRFS_INODE_NOATIME)
-		xflags |= FS_XFLAG_NOATIME;
-	if (flags & BTRFS_INODE_NODUMP)
-		xflags |= FS_XFLAG_NODUMP;
-	if (flags & BTRFS_INODE_SYNC)
-		xflags |= FS_XFLAG_SYNC;
-
-	return xflags;
-}
-
-/* Check if @flags are a supported and valid set of FS_XFLAGS_* flags */
-static int check_xflags(unsigned int flags)
-{
-	if (flags & ~(FS_XFLAG_APPEND | FS_XFLAG_IMMUTABLE | FS_XFLAG_NOATIME |
-		      FS_XFLAG_NODUMP | FS_XFLAG_SYNC))
-		return -EOPNOTSUPP;
-	return 0;
-}
-
-bool btrfs_exclop_start(struct btrfs_fs_info *fs_info,
-			enum btrfs_exclusive_operation type)
-{
-	return !cmpxchg(&fs_info->exclusive_operation, BTRFS_EXCLOP_NONE, type);
-}
-
-void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
-{
-	WRITE_ONCE(fs_info->exclusive_operation, BTRFS_EXCLOP_NONE);
-	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
-}
-
-/*
- * Set the xflags from the internal inode flags. The remaining items of fsxattr
- * are zeroed.
- */
-static int btrfs_ioctl_fsgetxattr(struct file *file, void __user *arg)
-{
-	struct btrfs_inode *binode = BTRFS_I(file_inode(file));
-	struct fsxattr fa;
-
-	simple_fill_fsxattr(&fa, btrfs_inode_flags_to_xflags(binode->flags));
-	if (copy_to_user(arg, &fa, sizeof(fa)))
-		return -EFAULT;
-
-	return 0;
-}
-
-static int btrfs_ioctl_fssetxattr(struct file *file, void __user *arg)
-{
-	struct inode *inode = file_inode(file);
-	struct btrfs_inode *binode = BTRFS_I(inode);
-	struct btrfs_root *root = binode->root;
-	struct btrfs_trans_handle *trans;
-	struct fsxattr fa, old_fa;
-	unsigned old_flags;
-	unsigned old_i_flags;
-	int ret = 0;
-
-	if (!inode_owner_or_capable(inode))
-		return -EPERM;
-
-	if (btrfs_root_readonly(root))
-		return -EROFS;
-
-	if (copy_from_user(&fa, arg, sizeof(fa)))
-		return -EFAULT;
-
-	ret = check_xflags(fa.fsx_xflags);
-	if (ret)
-		return ret;
-
-	if (fa.fsx_extsize != 0 || fa.fsx_projid != 0 || fa.fsx_cowextsize != 0)
-		return -EOPNOTSUPP;
-
-	ret = mnt_want_write_file(file);
-	if (ret)
-		return ret;
-
-	inode_lock(inode);
-
-	old_flags = binode->flags;
-	old_i_flags = inode->i_flags;
-
-	simple_fill_fsxattr(&old_fa,
-			    btrfs_inode_flags_to_xflags(binode->flags));
-	ret = vfs_ioc_fssetxattr_check(inode, &old_fa, &fa);
-	if (ret)
-		goto out_unlock;
-
-	if (fa.fsx_xflags & FS_XFLAG_SYNC)
-		binode->flags |= BTRFS_INODE_SYNC;
-	else
-		binode->flags &= ~BTRFS_INODE_SYNC;
-	if (fa.fsx_xflags & FS_XFLAG_IMMUTABLE)
-		binode->flags |= BTRFS_INODE_IMMUTABLE;
-	else
-		binode->flags &= ~BTRFS_INODE_IMMUTABLE;
-	if (fa.fsx_xflags & FS_XFLAG_APPEND)
-		binode->flags |= BTRFS_INODE_APPEND;
-	else
-		binode->flags &= ~BTRFS_INODE_APPEND;
-	if (fa.fsx_xflags & FS_XFLAG_NODUMP)
-		binode->flags |= BTRFS_INODE_NODUMP;
-	else
-		binode->flags &= ~BTRFS_INODE_NODUMP;
-	if (fa.fsx_xflags & FS_XFLAG_NOATIME)
-		binode->flags |= BTRFS_INODE_NOATIME;
-	else
-		binode->flags &= ~BTRFS_INODE_NOATIME;
-
-	/* 1 item for the inode */
-	trans = btrfs_start_transaction(root, 1);
-	if (IS_ERR(trans)) {
-		ret = PTR_ERR(trans);
-		goto out_unlock;
-	}
-
-	btrfs_sync_inode_flags_to_i_flags(inode);
-	inode_inc_iversion(inode);
-	inode->i_ctime = current_time(inode);
-	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
-
-	btrfs_end_transaction(trans);
-
-out_unlock:
-	if (ret) {
-		binode->flags = old_flags;
-		inode->i_flags = old_i_flags;
-	}
-
-	inode_unlock(inode);
-	mnt_drop_write_file(file);
-
 	return ret;
 }
 
@@ -4886,10 +4740,6 @@ long btrfs_ioctl(struct file *file, unsigned int
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		return btrfs_ioctl_getflags(file, argp);
-	case FS_IOC_SETFLAGS:
-		return btrfs_ioctl_setflags(file, argp);
 	case FS_IOC_GETVERSION:
 		return btrfs_ioctl_getversion(file, argp);
 	case FS_IOC_GETFSLABEL:
@@ -5015,10 +4865,6 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_get_features(fs_info, argp);
 	case BTRFS_IOC_SET_FEATURES:
 		return btrfs_ioctl_set_features(file, argp);
-	case FS_IOC_FSGETXATTR:
-		return btrfs_ioctl_fsgetxattr(file, argp);
-	case FS_IOC_FSSETXATTR:
-		return btrfs_ioctl_fssetxattr(file, argp);
 	case BTRFS_IOC_GET_SUBVOL_INFO:
 		return btrfs_ioctl_get_subvol_info(file, argp);
 	case BTRFS_IOC_GET_SUBVOL_ROOTREF:
@@ -5038,12 +4884,6 @@ long btrfs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	 * handling is necessary.
 	 */
 	switch (cmd) {
-	case FS_IOC32_GETFLAGS:
-		cmd = FS_IOC_GETFLAGS;
-		break;
-	case FS_IOC32_SETFLAGS:
-		cmd = FS_IOC_SETFLAGS;
-		break;
 	case FS_IOC32_GETVERSION:
 		cmd = FS_IOC_GETVERSION;
 		break;
-- 
2.26.2

