Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51254349A7B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhCYTiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:38:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230240AbhCYTiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQQbc5zk+U36p6UN2mxt6grR8E6eAwJTRu6KEH3FV8k=;
        b=AYUN5Z6C55y0bSsuoyITMNTmYZwafCz9T6LY7Mng4UCrObGtzmqn0QWWPbXxDYfdjeN/xF
        p3SxeOqelntNK3s4NCBAhOsrj3J9qpMTpyytKPLRP4LHlT+bQybnPhkYkdL0by13XbSoLg
        YeOhJnrakRJO80TF2ep/Y23DygpwMHc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-kMy9hbkFO4u_RyXxUpbuPQ-1; Thu, 25 Mar 2021 15:38:04 -0400
X-MC-Unique: kMy9hbkFO4u_RyXxUpbuPQ-1
Received: by mail-ed1-f70.google.com with SMTP id o15so3222573edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FQQbc5zk+U36p6UN2mxt6grR8E6eAwJTRu6KEH3FV8k=;
        b=ATz1Y3Mu/idUVix7DO5RmMl8Oo3c9MH7yowYmOL0mL8BIqIY0VPk1I65xJhntGGU2Y
         5EB7DUuPIdlkC04YZ3nF0yj/F+EPYi6JMMKonw9SnGLJAI52oMpd9LhPLr2ObkmrJTKl
         6GOblun2BYNyQHZ5DgvTtZQt9Txwv+RDYWqAEbLHuTMAH5UsOqhDt90dPKnTBe3uzJcu
         51y4J44q5mtoCT5hPiy2a8zRmOVFOlrvt5hw0JhgY1soJ+MgwwHZfMh/7Cjeuwd/e7L9
         8TNEMQVhCThZ+g/PPc28X+gw/uz8gqlXoB7/bf/BneK5jVRzRb2F+M5ZHSXudPxyo0Lq
         t+Pw==
X-Gm-Message-State: AOAM530t/LdNsfFK9+rH6JkoultusgrMRBONPsBHt+ULZgBH1AsCnmls
        8aXGPENlSXB7R2jQxddgGRiRvA5+3jLbCVLXO3TVZiYREdeamMn6KtLFBb5bRuk/L2rIcBQlylN
        oQ29m2Xa3ixnVzdnwc0sfLVIR
X-Received: by 2002:a17:906:b846:: with SMTP id ga6mr11225854ejb.542.1616701083056;
        Thu, 25 Mar 2021 12:38:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtOH3s+nZ6mR/73hUnsZeVXNtuHgwt1PzOhLfeMk8hd4rTnGr6y9dzJLHw42g7Wjq8CuWG1A==
X-Received: by 2002:a17:906:b846:: with SMTP id ga6mr11225840ejb.542.1616701082856;
        Thu, 25 Mar 2021 12:38:02 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:02 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Subject: [PATCH v3 05/18] ext2: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:42 +0100
Message-Id: <20210325193755.294925-6-mszeredi@redhat.com>
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
Cc: Jan Kara <jack@suse.cz>
---
 fs/ext2/ext2.h  |  7 ++--
 fs/ext2/file.c  |  2 ++
 fs/ext2/ioctl.c | 88 ++++++++++++++++++-------------------------------
 fs/ext2/namei.c |  2 ++
 4 files changed, 39 insertions(+), 60 deletions(-)

diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
index 3309fb2d327a..23ffe5b96010 100644
--- a/fs/ext2/ext2.h
+++ b/fs/ext2/ext2.h
@@ -283,8 +283,6 @@ static inline __u32 ext2_mask_flags(umode_t mode, __u32 flags)
 /*
  * ioctl commands
  */
-#define	EXT2_IOC_GETFLAGS		FS_IOC_GETFLAGS
-#define	EXT2_IOC_SETFLAGS		FS_IOC_SETFLAGS
 #define	EXT2_IOC_GETVERSION		FS_IOC_GETVERSION
 #define	EXT2_IOC_SETVERSION		FS_IOC_SETVERSION
 #define	EXT2_IOC_GETRSVSZ		_IOR('f', 5, long)
@@ -293,8 +291,6 @@ static inline __u32 ext2_mask_flags(umode_t mode, __u32 flags)
 /*
  * ioctl commands in 32 bit emulation
  */
-#define EXT2_IOC32_GETFLAGS		FS_IOC32_GETFLAGS
-#define EXT2_IOC32_SETFLAGS		FS_IOC32_SETFLAGS
 #define EXT2_IOC32_GETVERSION		FS_IOC32_GETVERSION
 #define EXT2_IOC32_SETVERSION		FS_IOC32_SETVERSION
 
@@ -772,6 +768,9 @@ extern int ext2_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		       u64 start, u64 len);
 
 /* ioctl.c */
+extern int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+extern int ext2_fileattr_set(struct user_namespace *mnt_userns,
+			     struct dentry *dentry, struct fileattr *fa);
 extern long ext2_ioctl(struct file *, unsigned int, unsigned long);
 extern long ext2_compat_ioctl(struct file *, unsigned int, unsigned long);
 
diff --git a/fs/ext2/file.c b/fs/ext2/file.c
index 96044f5dbc0e..f98466acc672 100644
--- a/fs/ext2/file.c
+++ b/fs/ext2/file.c
@@ -204,4 +204,6 @@ const struct inode_operations ext2_file_inode_operations = {
 	.get_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.fiemap		= ext2_fiemap,
+	.fileattr_get	= ext2_fileattr_get,
+	.fileattr_set	= ext2_fileattr_set,
 };
diff --git a/fs/ext2/ioctl.c b/fs/ext2/ioctl.c
index b399cbb7022d..e8340bf09b10 100644
--- a/fs/ext2/ioctl.c
+++ b/fs/ext2/ioctl.c
@@ -16,69 +16,51 @@
 #include <linux/mount.h>
 #include <asm/current.h>
 #include <linux/uaccess.h>
+#include <linux/fileattr.h>
 
-
-long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+int ext2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
-	struct inode *inode = file_inode(filp);
-	struct ext2_inode_info *ei = EXT2_I(inode);
-	unsigned int flags;
-	unsigned short rsv_window_size;
-	int ret;
+	struct ext2_inode_info *ei = EXT2_I(d_inode(dentry));
 
-	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
+	fileattr_fill_flags(fa, ei->i_flags & EXT2_FL_USER_VISIBLE);
 
-	switch (cmd) {
-	case EXT2_IOC_GETFLAGS:
-		flags = ei->i_flags & EXT2_FL_USER_VISIBLE;
-		return put_user(flags, (int __user *) arg);
-	case EXT2_IOC_SETFLAGS: {
-		unsigned int oldflags;
+	return 0;
+}
 
-		ret = mnt_want_write_file(filp);
-		if (ret)
-			return ret;
+int ext2_fileattr_set(struct user_namespace *mnt_userns,
+		      struct dentry *dentry, struct fileattr *fa)
+{
+	struct inode *inode = d_inode(dentry);
+	struct ext2_inode_info *ei = EXT2_I(inode);
 
-		if (!inode_owner_or_capable(&init_user_ns, inode)) {
-			ret = -EACCES;
-			goto setflags_out;
-		}
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
 
-		if (get_user(flags, (int __user *) arg)) {
-			ret = -EFAULT;
-			goto setflags_out;
-		}
+	/* Is it quota file? Do not allow user to mess with it */
+	if (IS_NOQUOTA(inode))
+		return -EPERM;
 
-		flags = ext2_mask_flags(inode->i_mode, flags);
+	ei->i_flags = (ei->i_flags & ~EXT2_FL_USER_MODIFIABLE) |
+		(fa->flags & EXT2_FL_USER_MODIFIABLE);
 
-		inode_lock(inode);
-		/* Is it quota file? Do not allow user to mess with it */
-		if (IS_NOQUOTA(inode)) {
-			inode_unlock(inode);
-			ret = -EPERM;
-			goto setflags_out;
-		}
-		oldflags = ei->i_flags;
+	ext2_set_inode_flags(inode);
+	inode->i_ctime = current_time(inode);
+	mark_inode_dirty(inode);
 
-		ret = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-		if (ret) {
-			inode_unlock(inode);
-			goto setflags_out;
-		}
+	return 0;
+}
 
-		flags = flags & EXT2_FL_USER_MODIFIABLE;
-		flags |= oldflags & ~EXT2_FL_USER_MODIFIABLE;
-		ei->i_flags = flags;
 
-		ext2_set_inode_flags(inode);
-		inode->i_ctime = current_time(inode);
-		inode_unlock(inode);
+long ext2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct inode *inode = file_inode(filp);
+	struct ext2_inode_info *ei = EXT2_I(inode);
+	unsigned short rsv_window_size;
+	int ret;
 
-		mark_inode_dirty(inode);
-setflags_out:
-		mnt_drop_write_file(filp);
-		return ret;
-	}
+	ext2_debug ("cmd = %u, arg = %lu\n", cmd, arg);
+
+	switch (cmd) {
 	case EXT2_IOC_GETVERSION:
 		return put_user(inode->i_generation, (int __user *) arg);
 	case EXT2_IOC_SETVERSION: {
@@ -163,12 +145,6 @@ long ext2_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	/* These are just misnamed, they actually get/put from/to user an int */
 	switch (cmd) {
-	case EXT2_IOC32_GETFLAGS:
-		cmd = EXT2_IOC_GETFLAGS;
-		break;
-	case EXT2_IOC32_SETFLAGS:
-		cmd = EXT2_IOC_SETFLAGS;
-		break;
 	case EXT2_IOC32_GETVERSION:
 		cmd = EXT2_IOC_GETVERSION;
 		break;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 3367384d344d..c03fc3c1533e 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -427,6 +427,8 @@ const struct inode_operations ext2_dir_inode_operations = {
 	.get_acl	= ext2_get_acl,
 	.set_acl	= ext2_set_acl,
 	.tmpfile	= ext2_tmpfile,
+	.fileattr_get	= ext2_fileattr_get,
+	.fileattr_set	= ext2_fileattr_set,
 };
 
 const struct inode_operations ext2_special_inode_operations = {
-- 
2.30.2

