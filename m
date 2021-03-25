Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117D9349A85
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbhCYTjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:39:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30207 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbhCYTiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2CmF2Ok/7Yvm6l2sa99yQDF58c2hGs4kIiRgKHoCIgs=;
        b=CLIA95UysxhL7GpEKHs/DvRktv82R0gpAteU9D1HTiDq8z7tHYmgGa0MQ0xsXM7ScKUIXx
        vr1IKarxD+7LZpAJljDV8vukNlQW0xxARDvqY417dVvO9u3GGnj/LQ3x+cUyGJIR4OcUok
        5x5dIW/rI6T9lxkpolF8+NSKN2H8Eqg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-X54qy3NnPAuNossN3gwVDw-1; Thu, 25 Mar 2021 15:38:17 -0400
X-MC-Unique: X54qy3NnPAuNossN3gwVDw-1
Received: by mail-ej1-f69.google.com with SMTP id r26so3067988eja.22
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2CmF2Ok/7Yvm6l2sa99yQDF58c2hGs4kIiRgKHoCIgs=;
        b=RmB/uRTbKPWUBc/tq3F/RI6uqTZpMz1eocFqA27Hf7Rukxe7tUqfZ9T0xpubv9U7+1
         02Skig6QlPC1XX9mVFNTYm5y7ha3gKSYyj48hIUCMLdBYEapmed+vrx7Gv1grER/mr3L
         b9rhNdDUr1rtq++a87HiXZVAdvmQZAnBtnLyTDiX8ABxPi23Gmnpvyzt//0fIffPhP+m
         mxQ/EecPGb240ClGsPExJsGWB11jX5O4hG80RskdVngaLF7D01zqGdtvc7R6UrsHxt9C
         bnzkarpYbh0YwuPvRIA5KyXDxUUOBSDSWxP1FvbtZA1jxrGXLTHKxxm80l8K4Tiw9A2h
         2xDw==
X-Gm-Message-State: AOAM532LKzk/SZh4GyY76/svbVYAvgMwluSJmpl43PzZx8YATWDHT6TC
        RoOD1Y5lq27UTPJhR8Dr4Q4cZvTC74t1Q69JfFNeVeYfmEDRVX0sBMm9U/7lEnB+7erP7O9dM4S
        fc/ooMHDZ7NM4sOvv2LhnlVyG
X-Received: by 2002:a17:906:828e:: with SMTP id h14mr11382613ejx.529.1616701095859;
        Thu, 25 Mar 2021 12:38:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6XJUonAtbewCZ8Qz+G85LrYfaJA0lmTPg5npkZw8WwtZXu86Ao2ZtuI9y0QL+5MvOL3XrKw==
X-Received: by 2002:a17:906:828e:: with SMTP id h14mr11382598ejx.529.1616701095716;
        Thu, 25 Mar 2021 12:38:15 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:15 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: [PATCH v3 17/18] ubifs: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:54 +0100
Message-Id: <20210325193755.294925-18-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the fileattr API to let the VFS handle locking, permission checking and
conversion.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Cc: Richard Weinberger <richard@nod.at>
---
 fs/ubifs/dir.c   |  2 ++
 fs/ubifs/file.c  |  2 ++
 fs/ubifs/ioctl.c | 74 ++++++++++++++++++++----------------------------
 fs/ubifs/ubifs.h |  3 ++
 4 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index d9d8d7794eff..5bd8482e660a 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -1637,6 +1637,8 @@ const struct inode_operations ubifs_dir_inode_operations = {
 	.listxattr   = ubifs_listxattr,
 	.update_time = ubifs_update_time,
 	.tmpfile     = ubifs_tmpfile,
+	.fileattr_get = ubifs_fileattr_get,
+	.fileattr_set = ubifs_fileattr_set,
 };
 
 const struct file_operations ubifs_dir_operations = {
diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index 0e4b4be3aa26..2e4e1d159969 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1648,6 +1648,8 @@ const struct inode_operations ubifs_file_inode_operations = {
 	.getattr     = ubifs_getattr,
 	.listxattr   = ubifs_listxattr,
 	.update_time = ubifs_update_time,
+	.fileattr_get = ubifs_fileattr_get,
+	.fileattr_set = ubifs_fileattr_set,
 };
 
 const struct inode_operations ubifs_symlink_inode_operations = {
diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 2326d5122beb..073855b56c82 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -14,6 +14,7 @@
 
 #include <linux/compat.h>
 #include <linux/mount.h>
+#include <linux/fileattr.h>
 #include "ubifs.h"
 
 /* Need to be kept consistent with checked flags in ioctl2ubifs() */
@@ -103,7 +104,7 @@ static int ubifs2ioctl(int ubifs_flags)
 
 static int setflags(struct inode *inode, int flags)
 {
-	int oldflags, err, release;
+	int err, release;
 	struct ubifs_inode *ui = ubifs_inode(inode);
 	struct ubifs_info *c = inode->i_sb->s_fs_info;
 	struct ubifs_budget_req req = { .dirtied_ino = 1,
@@ -114,11 +115,6 @@ static int setflags(struct inode *inode, int flags)
 		return err;
 
 	mutex_lock(&ui->ui_mutex);
-	oldflags = ubifs2ioctl(ui->flags);
-	err = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (err)
-		goto out_unlock;
-
 	ui->flags &= ~ioctl2ubifs(UBIFS_SETTABLE_IOCTL_FLAGS);
 	ui->flags |= ioctl2ubifs(flags);
 	ubifs_set_inode_flags(inode);
@@ -132,54 +128,46 @@ static int setflags(struct inode *inode, int flags)
 	if (IS_SYNC(inode))
 		err = write_inode_now(inode, 1);
 	return err;
-
-out_unlock:
-	mutex_unlock(&ui->ui_mutex);
-	ubifs_release_budget(c, &req);
-	return err;
 }
 
-long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	int flags, err;
-	struct inode *inode = file_inode(file);
+	struct inode *inode = d_inode(dentry);
+	int flags = ubifs2ioctl(ubifs_inode(inode)->flags);
 
-	switch (cmd) {
-	case FS_IOC_GETFLAGS:
-		flags = ubifs2ioctl(ubifs_inode(inode)->flags);
+	dbg_gen("get flags: %#x, i_flags %#x", flags, inode->i_flags);
+	fileattr_fill_flags(fa, flags);
 
-		dbg_gen("get flags: %#x, i_flags %#x", flags, inode->i_flags);
-		return put_user(flags, (int __user *) arg);
+	return 0;
+}
 
-	case FS_IOC_SETFLAGS: {
-		if (IS_RDONLY(inode))
-			return -EROFS;
+int ubifs_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	int flags = fa->flags;
 
-		if (!inode_owner_or_capable(&init_user_ns, inode))
-			return -EACCES;
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
 
-		if (get_user(flags, (int __user *) arg))
-			return -EFAULT;
+	if (flags & ~UBIFS_GETTABLE_IOCTL_FLAGS)
+		return -EOPNOTSUPP;
 
-		if (flags & ~UBIFS_GETTABLE_IOCTL_FLAGS)
-			return -EOPNOTSUPP;
-		flags &= UBIFS_SETTABLE_IOCTL_FLAGS;
+	flags &= UBIFS_SETTABLE_IOCTL_FLAGS;
 
-		if (!S_ISDIR(inode->i_mode))
-			flags &= ~FS_DIRSYNC_FL;
+	if (!S_ISDIR(inode->i_mode))
+		flags &= ~FS_DIRSYNC_FL;
 
-		/*
-		 * Make sure the file-system is read-write and make sure it
-		 * will not become read-only while we are changing the flags.
-		 */
-		err = mnt_want_write_file(file);
-		if (err)
-			return err;
-		dbg_gen("set flags: %#x, i_flags %#x", flags, inode->i_flags);
-		err = setflags(inode, flags);
-		mnt_drop_write_file(file);
-		return err;
-	}
+	dbg_gen("set flags: %#x, i_flags %#x", flags, inode->i_flags);
+	return setflags(inode, flags);
+}
+
+long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	int err;
+	struct inode *inode = file_inode(file);
+
+	switch (cmd) {
 	case FS_IOC_SET_ENCRYPTION_POLICY: {
 		struct ubifs_info *c = inode->i_sb->s_fs_info;
 
diff --git a/fs/ubifs/ubifs.h b/fs/ubifs/ubifs.h
index 7fdfdbda4b8a..b65c599a386a 100644
--- a/fs/ubifs/ubifs.h
+++ b/fs/ubifs/ubifs.h
@@ -2053,6 +2053,9 @@ int ubifs_recover_size(struct ubifs_info *c, bool in_place);
 void ubifs_destroy_size_tree(struct ubifs_info *c);
 
 /* ioctl.c */
+int ubifs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int ubifs_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa);
 long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
 void ubifs_set_inode_flags(struct inode *inode);
 #ifdef CONFIG_COMPAT
-- 
2.30.2

