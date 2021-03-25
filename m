Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E58A349A83
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbhCYTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230330AbhCYTiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GizXdUuGbOlAXZSEFMPpS46MB5AxC3PE1iyOrg05GE=;
        b=VFjV8nfo1juYad0B9dQYHpjlW8rKqnx3B7TpUPrD4cQcRnDWig/Sw47osXI3GkF6NjkwD6
        o9JknB7F7NQ/bvPblHFuQ07krNhhcWVuanSsrdutnjahCWUOA8FNae42O3al7vdhA5WTQ4
        toD/o8borx+t05bZmn8CyB4jC84eBb0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-K8VCkbw_NLi7BtOo-Id_lg-1; Thu, 25 Mar 2021 15:38:15 -0400
X-MC-Unique: K8VCkbw_NLi7BtOo-Id_lg-1
Received: by mail-ed1-f69.google.com with SMTP id o24so3193902edt.15
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6GizXdUuGbOlAXZSEFMPpS46MB5AxC3PE1iyOrg05GE=;
        b=G2EjOdyTQe/JbbbqKsNcdOAFs+D8x08ZL8d3bQwycYp/fuUHZckQNOr950/TqUPSzK
         sc3/DLTzqXOtnLx1TuAi8A2hvcJWNlZ85LPD/M2cYKA9qEKk1i72Fc08vEzqoLYIetKr
         doccnZZx4jtIr7MnC4CMYc9NjH3HG54aFPTp1M4qI7QD/jnMxv3lCBS4N8gTTAJXgfzM
         cbAIJWLm4aD44u8F8Ctz1Ja1sryIfp9fG20PnJOrn+hKkKQJ6jr86Ge9SVj9N6knItw+
         3Dx4winOL90K8aSAeSH0BF4Fe+hPJehOJ5nklEW18udZO4YCfvsZYpq5BoSrlTAe7B0S
         E53A==
X-Gm-Message-State: AOAM532SWawuRGjon/J4nh8UTTrPQbxBpViLTetS7K81JEi6lSFo+TRv
        bvOd6eE90N85vLzS72FkB7wSSe0NHzFh3ax9T4UC+TJGJruPRyTFDB15I/jnGWQCcx3lS432vTt
        C8sblaGQF6Fx/zsiNExTpAk1P
X-Received: by 2002:a17:906:16ca:: with SMTP id t10mr11485449ejd.85.1616701093834;
        Thu, 25 Mar 2021 12:38:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6RDFXB1ljV8dUCwZxdY9397fwZZAURPGhwStZ2+VYbKU5IiJfnY+bfWhJ3GRGIGpcwbMjVQ==
X-Received: by 2002:a17:906:16ca:: with SMTP id t10mr11485433ejd.85.1616701093687;
        Thu, 25 Mar 2021 12:38:13 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:13 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Joel Becker <jlbec@evilplan.org>
Subject: [PATCH v3 15/18] ocfs2: convert to fileattr
Date:   Thu, 25 Mar 2021 20:37:52 +0100
Message-Id: <20210325193755.294925-16-mszeredi@redhat.com>
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
Cc: Joel Becker <jlbec@evilplan.org>
---
 fs/ocfs2/file.c        |  2 ++
 fs/ocfs2/ioctl.c       | 59 ++++++++++++++----------------------------
 fs/ocfs2/ioctl.h       |  3 +++
 fs/ocfs2/namei.c       |  3 +++
 fs/ocfs2/ocfs2_ioctl.h |  8 ------
 5 files changed, 27 insertions(+), 48 deletions(-)

diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index 6611c64ca0be..908d22b431fa 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -2645,6 +2645,8 @@ const struct inode_operations ocfs2_file_iops = {
 	.fiemap		= ocfs2_fiemap,
 	.get_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
+	.fileattr_get	= ocfs2_fileattr_get,
+	.fileattr_set	= ocfs2_fileattr_set,
 };
 
 const struct inode_operations ocfs2_special_file_iops = {
diff --git a/fs/ocfs2/ioctl.c b/fs/ocfs2/ioctl.c
index 50c9b30ee9f6..f59461d85da4 100644
--- a/fs/ocfs2/ioctl.c
+++ b/fs/ocfs2/ioctl.c
@@ -10,6 +10,7 @@
 #include <linux/mount.h>
 #include <linux/blkdev.h>
 #include <linux/compat.h>
+#include <linux/fileattr.h>
 
 #include <cluster/masklog.h>
 
@@ -61,8 +62,10 @@ static inline int o2info_coherent(struct ocfs2_info_request *req)
 	return (!(req->ir_flags & OCFS2_INFO_FL_NON_COHERENT));
 }
 
-static int ocfs2_get_inode_attr(struct inode *inode, unsigned *flags)
+int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa)
 {
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags;
 	int status;
 
 	status = ocfs2_inode_lock(inode, NULL, 0);
@@ -71,15 +74,19 @@ static int ocfs2_get_inode_attr(struct inode *inode, unsigned *flags)
 		return status;
 	}
 	ocfs2_get_inode_flags(OCFS2_I(inode));
-	*flags = OCFS2_I(inode)->ip_attr;
+	flags = OCFS2_I(inode)->ip_attr;
 	ocfs2_inode_unlock(inode, 0);
 
+	fileattr_fill_flags(fa, flags & OCFS2_FL_VISIBLE);
+
 	return status;
 }
 
-static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
-				unsigned mask)
+int ocfs2_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa)
 {
+	struct inode *inode = d_inode(dentry);
+	unsigned int flags = fa->flags;
 	struct ocfs2_inode_info *ocfs2_inode = OCFS2_I(inode);
 	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 	handle_t *handle = NULL;
@@ -87,7 +94,8 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 	unsigned oldflags;
 	int status;
 
-	inode_lock(inode);
+	if (fileattr_has_fsx(fa))
+		return -EOPNOTSUPP;
 
 	status = ocfs2_inode_lock(inode, &bh, 1);
 	if (status < 0) {
@@ -95,19 +103,17 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 		goto bail;
 	}
 
-	status = -EACCES;
-	if (!inode_owner_or_capable(&init_user_ns, inode))
-		goto bail_unlock;
-
 	if (!S_ISDIR(inode->i_mode))
 		flags &= ~OCFS2_DIRSYNC_FL;
 
 	oldflags = ocfs2_inode->ip_attr;
-	flags = flags & mask;
-	flags |= oldflags & ~mask;
+	flags = flags & OCFS2_FL_MODIFIABLE;
+	flags |= oldflags & ~OCFS2_FL_MODIFIABLE;
 
-	status = vfs_ioc_setflags_prepare(inode, oldflags, flags);
-	if (status)
+	/* Check already done by VFS, but repeat with ocfs lock */
+	status = -EPERM;
+	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
+	    !capable(CAP_LINUX_IMMUTABLE))
 		goto bail_unlock;
 
 	handle = ocfs2_start_trans(osb, OCFS2_INODE_UPDATE_CREDITS);
@@ -129,8 +135,6 @@ static int ocfs2_set_inode_attr(struct inode *inode, unsigned flags,
 bail_unlock:
 	ocfs2_inode_unlock(inode, 1);
 bail:
-	inode_unlock(inode);
-
 	brelse(bh);
 
 	return status;
@@ -836,7 +840,6 @@ static int ocfs2_info_handle(struct inode *inode, struct ocfs2_info *info,
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
-	unsigned int flags;
 	int new_clusters;
 	int status;
 	struct ocfs2_space_resv sr;
@@ -849,24 +852,6 @@ long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case OCFS2_IOC_GETFLAGS:
-		status = ocfs2_get_inode_attr(inode, &flags);
-		if (status < 0)
-			return status;
-
-		flags &= OCFS2_FL_VISIBLE;
-		return put_user(flags, (int __user *) arg);
-	case OCFS2_IOC_SETFLAGS:
-		if (get_user(flags, (int __user *) arg))
-			return -EFAULT;
-
-		status = mnt_want_write_file(filp);
-		if (status)
-			return status;
-		status = ocfs2_set_inode_attr(inode, flags,
-			OCFS2_FL_MODIFIABLE);
-		mnt_drop_write_file(filp);
-		return status;
 	case OCFS2_IOC_RESVSP:
 	case OCFS2_IOC_RESVSP64:
 	case OCFS2_IOC_UNRESVSP:
@@ -959,12 +944,6 @@ long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 	void __user *argp = (void __user *)arg;
 
 	switch (cmd) {
-	case OCFS2_IOC32_GETFLAGS:
-		cmd = OCFS2_IOC_GETFLAGS;
-		break;
-	case OCFS2_IOC32_SETFLAGS:
-		cmd = OCFS2_IOC_SETFLAGS;
-		break;
 	case OCFS2_IOC_RESVSP:
 	case OCFS2_IOC_RESVSP64:
 	case OCFS2_IOC_UNRESVSP:
diff --git a/fs/ocfs2/ioctl.h b/fs/ocfs2/ioctl.h
index 9f5e4d95e37f..0297c8846945 100644
--- a/fs/ocfs2/ioctl.h
+++ b/fs/ocfs2/ioctl.h
@@ -11,6 +11,9 @@
 #ifndef OCFS2_IOCTL_PROTO_H
 #define OCFS2_IOCTL_PROTO_H
 
+int ocfs2_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+int ocfs2_fileattr_set(struct user_namespace *mnt_userns,
+		       struct dentry *dentry, struct fileattr *fa);
 long ocfs2_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
 long ocfs2_compat_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 3abdd36da2e2..05ced86580d1 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -50,6 +50,7 @@
 #include "xattr.h"
 #include "acl.h"
 #include "ocfs2_trace.h"
+#include "ioctl.h"
 
 #include "buffer_head_io.h"
 
@@ -2918,4 +2919,6 @@ const struct inode_operations ocfs2_dir_iops = {
 	.fiemap         = ocfs2_fiemap,
 	.get_acl	= ocfs2_iop_get_acl,
 	.set_acl	= ocfs2_iop_set_acl,
+	.fileattr_get	= ocfs2_fileattr_get,
+	.fileattr_set	= ocfs2_fileattr_set,
 };
diff --git a/fs/ocfs2/ocfs2_ioctl.h b/fs/ocfs2/ocfs2_ioctl.h
index d7b31734f6be..273616bd4f19 100644
--- a/fs/ocfs2/ocfs2_ioctl.h
+++ b/fs/ocfs2/ocfs2_ioctl.h
@@ -12,14 +12,6 @@
 #ifndef OCFS2_IOCTL_H
 #define OCFS2_IOCTL_H
 
-/*
- * ioctl commands
- */
-#define OCFS2_IOC_GETFLAGS	FS_IOC_GETFLAGS
-#define OCFS2_IOC_SETFLAGS	FS_IOC_SETFLAGS
-#define OCFS2_IOC32_GETFLAGS	FS_IOC32_GETFLAGS
-#define OCFS2_IOC32_SETFLAGS	FS_IOC32_SETFLAGS
-
 /*
  * Space reservation / allocation / free ioctls and argument structure
  * are designed to be compatible with XFS.
-- 
2.30.2

