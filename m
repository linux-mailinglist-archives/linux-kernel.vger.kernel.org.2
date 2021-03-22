Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF27344824
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhCVOwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:52:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231243AbhCVOtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424581;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l6EzCQAw/mBMnPIz8KDSZFIEDfo7AHQRBn5q68A5xxs=;
        b=RCU7fkWGz6CYDEhGxCX2VZhOyjwB24xjuc1liZ6iUBLCk61/n+yPjpWtSulfkQuqt4xs1L
        xK7pXptT18RHrVten4wbiRB19oIcQ1VznnNF8O5BSuhMlxp0L444vB+LKNEGQoi7G+JuiC
        u+0G+is2xwKzk1FcwxXx0DX0cJaeIR8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-JBqpf2aWO6SYQHWljQtLPA-1; Mon, 22 Mar 2021 10:49:39 -0400
X-MC-Unique: JBqpf2aWO6SYQHWljQtLPA-1
Received: by mail-ed1-f69.google.com with SMTP id r19so27098925edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l6EzCQAw/mBMnPIz8KDSZFIEDfo7AHQRBn5q68A5xxs=;
        b=WV+4yYxsy3smlcF82B3UzT+AAp7k2mUNITMr5Vh52wKEoaIAaO7hFXPwpPQDgE5ZNM
         xiAX+134s9715GZIC5IDQV8JerDxSw8vySSTQqRbzMs7pJDvp37jZ6+i3uOZSg6Vjm9I
         rheG/KJaoEzPWZyutM3eK9nMPHohtJud8LTidZ8SCrMu4BQ2m+bTCNMLJLWn7G+cnxDS
         OuvHOMaP+D2VJzFLzhvGoaKSio8imvbJqSO83zyllUt8NqbAJK/Hlu89aKp5SfERzPiD
         2pylRcF5e19HARMpOlqDcjztnJIddcM4mw7oL3sfjr3jQ4bLMAcaJFpiVPcTf9PiL3Xr
         Kduw==
X-Gm-Message-State: AOAM533KFNjqc4r+3K0UeFscXtmTKAoI/4U5HWnZ81ePTVjTqnyhUknA
        LOEVfwcYEHZ+LhdNGezpUwbGfImqjurBU21kFp38uwYl1QExYSttzSO0BMksP3EAukjsX9de9dF
        GKKuk9OFXio8VTEm2PiOuA+7b
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr129362ejc.384.1616424577795;
        Mon, 22 Mar 2021 07:49:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmoL1xtRBZBvW72vdcqh8NIrWFegxo5+WgvxENXGto+uk06haidHAPFlhoeOzC0kwv6nsTWA==
X-Received: by 2002:a17:907:6289:: with SMTP id nd9mr129339ejc.384.1616424577612;
        Mon, 22 Mar 2021 07:49:37 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:37 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 16/18] reiserfs: convert to miscattr
Date:   Mon, 22 Mar 2021 15:49:14 +0100
Message-Id: <20210322144916.137245-17-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the miscattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Jan Kara <jack@suse.cz>
---
 fs/reiserfs/file.c     |   2 +
 fs/reiserfs/ioctl.c    | 121 +++++++++++++++++++----------------------
 fs/reiserfs/namei.c    |   2 +
 fs/reiserfs/reiserfs.h |   7 ++-
 fs/reiserfs/super.c    |   2 +-
 5 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/fs/reiserfs/file.c b/fs/reiserfs/file.c
index 1db0254bc38b..bf8f125b41ca 100644
--- a/fs/reiserfs/file.c
+++ b/fs/reiserfs/file.c
@@ -258,4 +258,6 @@ const struct inode_operations reiserfs_file_inode_operations = {
 	.permission = reiserfs_permission,
 	.get_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
+	.miscattr_get = reiserfs_miscattr_get,
+	.miscattr_set = reiserfs_miscattr_set,
 };
diff --git a/fs/reiserfs/ioctl.c b/fs/reiserfs/ioctl.c
index 4f1cbd930179..913c4dc016e5 100644
--- a/fs/reiserfs/ioctl.c
+++ b/fs/reiserfs/ioctl.c
@@ -10,6 +10,59 @@
 #include <linux/uaccess.h>
 #include <linux/pagemap.h>
 #include <linux/compat.h>
+#include <linux/miscattr.h>
+
+int reiserfs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+
+	if (!reiserfs_attrs(inode->i_sb))
+		return -ENOTTY;
+
+	miscattr_fill_flags(ma, REISERFS_I(inode)->i_attrs);
+
+	return 0;
+}
+
+int reiserfs_miscattr_set(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, struct miscattr *ma)
+{
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags = ma->flags;
+	int err;
+
+	reiserfs_write_lock(inode->i_sb);
+
+	err = -ENOTTY;
+	if (!reiserfs_attrs(inode->i_sb))
+		goto unlock;
+
+	err = -EOPNOTSUPP;
+	if (miscattr_has_xattr(ma))
+		goto unlock;
+
+	/*
+	 * Is it quota file? Do not allow user to mess with it
+	 */
+	err = -EPERM;
+	if (IS_NOQUOTA(inode))
+		goto unlock;
+
+	if ((flags & REISERFS_NOTAIL_FL) && S_ISREG(inode->i_mode)) {
+		err = reiserfs_unpack(inode);
+		if (err)
+			goto unlock;
+	}
+	sd_attrs_to_i_attrs(flags, inode);
+	REISERFS_I(inode)->i_attrs = flags;
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
+	err = 0;
+unlock:
+	reiserfs_write_unlock(inode->i_sb);
+
+	return err;
+}
 
 /*
  * reiserfs_ioctl - handler for ioctl for inode
@@ -23,7 +76,6 @@
 long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	unsigned int flags;
 	int err = 0;
 
 	reiserfs_write_lock(inode->i_sb);
@@ -32,7 +84,7 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	case REISERFS_IOC_UNPACK:
 		if (S_ISREG(inode->i_mode)) {
 			if (arg)
-				err = reiserfs_unpack(inode, filp);
+				err = reiserfs_unpack(inode);
 		} else
 			err = -ENOTTY;
 		break;
@@ -40,63 +92,6 @@ long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		 * following two cases are taken from fs/ext2/ioctl.c by Remy
 		 * Card (card@masi.ibp.fr)
 		 */
-	case REISERFS_IOC_GETFLAGS:
-		if (!reiserfs_attrs(inode->i_sb)) {
-			err = -ENOTTY;
-			break;
-		}
-
-		flags = REISERFS_I(inode)->i_attrs;
-		err = put_user(flags, (int __user *)arg);
-		break;
-	case REISERFS_IOC_SETFLAGS:{
-			if (!reiserfs_attrs(inode->i_sb)) {
-				err = -ENOTTY;
-				break;
-			}
-
-			err = mnt_want_write_file(filp);
-			if (err)
-				break;
-
-			if (!inode_owner_or_capable(&init_user_ns, inode)) {
-				err = -EPERM;
-				goto setflags_out;
-			}
-			if (get_user(flags, (int __user *)arg)) {
-				err = -EFAULT;
-				goto setflags_out;
-			}
-			/*
-			 * Is it quota file? Do not allow user to mess with it
-			 */
-			if (IS_NOQUOTA(inode)) {
-				err = -EPERM;
-				goto setflags_out;
-			}
-			err = vfs_ioc_setflags_prepare(inode,
-						     REISERFS_I(inode)->i_attrs,
-						     flags);
-			if (err)
-				goto setflags_out;
-			if ((flags & REISERFS_NOTAIL_FL) &&
-			    S_ISREG(inode->i_mode)) {
-				int result;
-
-				result = reiserfs_unpack(inode, filp);
-				if (result) {
-					err = result;
-					goto setflags_out;
-				}
-			}
-			sd_attrs_to_i_attrs(flags, inode);
-			REISERFS_I(inode)->i_attrs = flags;
-			inode->i_ctime = current_time(inode);
-			mark_inode_dirty(inode);
-setflags_out:
-			mnt_drop_write_file(filp);
-			break;
-		}
 	case REISERFS_IOC_GETVERSION:
 		err = put_user(inode->i_generation, (int __user *)arg);
 		break;
@@ -138,12 +133,6 @@ long reiserfs_compat_ioctl(struct file *file, unsigned int cmd,
 	case REISERFS_IOC32_UNPACK:
 		cmd = REISERFS_IOC_UNPACK;
 		break;
-	case REISERFS_IOC32_GETFLAGS:
-		cmd = REISERFS_IOC_GETFLAGS;
-		break;
-	case REISERFS_IOC32_SETFLAGS:
-		cmd = REISERFS_IOC_SETFLAGS;
-		break;
 	case REISERFS_IOC32_GETVERSION:
 		cmd = REISERFS_IOC_GETVERSION;
 		break;
@@ -165,7 +154,7 @@ int reiserfs_commit_write(struct file *f, struct page *page,
  * Function try to convert tail from direct item into indirect.
  * It set up nopack attribute in the REISERFS_I(inode)->nopack
  */
-int reiserfs_unpack(struct inode *inode, struct file *filp)
+int reiserfs_unpack(struct inode *inode)
 {
 	int retval = 0;
 	int index;
diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index e6eb05e2b2f1..7d8a6b38e68a 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -1660,6 +1660,8 @@ const struct inode_operations reiserfs_dir_inode_operations = {
 	.permission = reiserfs_permission,
 	.get_acl = reiserfs_get_acl,
 	.set_acl = reiserfs_set_acl,
+	.miscattr_get = reiserfs_miscattr_get,
+	.miscattr_set = reiserfs_miscattr_set,
 };
 
 /*
diff --git a/fs/reiserfs/reiserfs.h b/fs/reiserfs/reiserfs.h
index 0ca2ac62e534..ba1d5b6fba47 100644
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -18,8 +18,6 @@
 
 /* the 32 bit compat definitions with int argument */
 #define REISERFS_IOC32_UNPACK		_IOW(0xCD, 1, int)
-#define REISERFS_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
-#define REISERFS_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
 #define REISERFS_IOC32_GETVERSION	FS_IOC32_GETVERSION
 #define REISERFS_IOC32_SETVERSION	FS_IOC32_SETVERSION
 
@@ -3408,7 +3406,10 @@ __u32 r5_hash(const signed char *msg, int len);
 #define SPARE_SPACE 500
 
 /* prototypes from ioctl.c */
+int reiserfs_miscattr_get(struct dentry *dentry, struct miscattr *ma);
+int reiserfs_miscattr_set(struct user_namespace *mnt_userns,
+			  struct dentry *dentry, struct miscattr *ma);
 long reiserfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long reiserfs_compat_ioctl(struct file *filp,
 		   unsigned int cmd, unsigned long arg);
-int reiserfs_unpack(struct inode *inode, struct file *filp);
+int reiserfs_unpack(struct inode *inode);
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 1b9c7a387dc7..3ffafc73acf0 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -2408,7 +2408,7 @@ static int reiserfs_quota_on(struct super_block *sb, int type, int format_id,
 	 * IO to work
 	 */
 	if (!(REISERFS_I(inode)->i_flags & i_nopack_mask)) {
-		err = reiserfs_unpack(inode, NULL);
+		err = reiserfs_unpack(inode);
 		if (err) {
 			reiserfs_warning(sb, "super-6520",
 				"Unpacking tail of quota file failed"
-- 
2.30.2

