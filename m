Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09AC30DA17
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhBCMqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230249AbhBCMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612356107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MMgdS2XXUW3T8Zs5FriS33C7AhYQ6oZENalDXPTydoE=;
        b=J0Ipx663PyexXJPzYhd9SAwaCiS1BVa8EO55SXtKL8u5UQeVgH1WU7mpGlRJxridg5t533
        IfHWZYfD13FFPmiw1qxpl+QBNFO0hNVIlD96iJ8J3+Yy/R+h7gur05jSuRTDaCBMRX1K8J
        nKcfaXBqgPqBgZ4ReQEJTeE89l6nNFE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-I-_q1HQUNWSRcscnJ1HgKg-1; Wed, 03 Feb 2021 07:41:45 -0500
X-MC-Unique: I-_q1HQUNWSRcscnJ1HgKg-1
Received: by mail-ed1-f70.google.com with SMTP id u19so11409549edr.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 04:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MMgdS2XXUW3T8Zs5FriS33C7AhYQ6oZENalDXPTydoE=;
        b=eqkuBI1PnL/OERivylKwBWKyfUGN05v8ZH+hMPxf+Oy4SoJ5dCY3fJUoCNyUVjRXcI
         QFDSPr6vJ+oa4PuANqRdGMskXuUiOvn2LUQE3Ajm/klHshkFF12TOYFNjNtDkVQhkJNA
         F3qgl1zsryO1Sp2+H7n8nZq9yYqc3lmvv8hUgk9a6IFloEuH7tfYzhCpD2XacRQB5m6y
         U4UmsWPyAJLfb5qQMcXYg2brltlP92CucmOxX+ucHrviLuhUT+/4j+tD6DrX+mZkoZjQ
         3R9aYNwkg+8g2BJA4TqoVM8kCw6WebalfXGPP4SFUrLT3jl/tzzHlfsXiX70Sh/4B0jv
         Xg0w==
X-Gm-Message-State: AOAM5335wXmRhQQ69sa6JfBYUeEhlxrcQ5upJka5tyX0iUej0itk5tNQ
        OyCnUZy4p+iKWs6cMGDqjYPTvqmzQZHNOiLGXnE5S4dhR9UtWS1RpFN+h1Lnf3UYGwSuqJqfwL+
        R+vztMkraY9cxWZWqEWJ4z7tt
X-Received: by 2002:a17:906:a295:: with SMTP id i21mr3036362ejz.334.1612356104382;
        Wed, 03 Feb 2021 04:41:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxjYYrOxQUOqkr3O16tiB8L27ZBHg4oeQlYylE+nWOUf6OpV0TCxXzHhcq7WYKB6/vzMH5nTw==
X-Received: by 2002:a17:906:a295:: with SMTP id i21mr3036353ejz.334.1612356104175;
        Wed, 03 Feb 2021 04:41:44 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id u9sm953320ejc.57.2021.02.03.04.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 04:41:43 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>
Subject: [PATCH 09/18] orangefs: convert to miscattr
Date:   Wed,  3 Feb 2021 13:41:03 +0100
Message-Id: <20210203124112.1182614-10-mszeredi@redhat.com>
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
Cc: Mike Marshall <hubcap@omnibond.com>
---
 fs/orangefs/file.c  | 79 ---------------------------------------------
 fs/orangefs/inode.c | 49 ++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 79 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index ec8ae4257975..8958bf9c5786 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -375,84 +375,6 @@ static ssize_t orangefs_file_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
-static int orangefs_getflags(struct inode *inode, unsigned long *uval)
-{
-	__u64 val = 0;
-	int ret;
-
-	ret = orangefs_inode_getxattr(inode,
-				      "user.pvfs2.meta_hint",
-				      &val, sizeof(val));
-	if (ret < 0 && ret != -ENODATA)
-		return ret;
-	else if (ret == -ENODATA)
-		val = 0;
-	*uval = val;
-	return 0;
-}
-
-/*
- * Perform a miscellaneous operation on a file.
- */
-static long orangefs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	struct inode *inode = file_inode(file);
-	int ret = -ENOTTY;
-	__u64 val = 0;
-	unsigned long uval;
-
-	gossip_debug(GOSSIP_FILE_DEBUG,
-		     "orangefs_ioctl: called with cmd %d\n",
-		     cmd);
-
-	/*
-	 * we understand some general ioctls on files, such as the immutable
-	 * and append flags
-	 */
-	if (cmd == FS_IOC_GETFLAGS) {
-		ret = orangefs_getflags(inode, &uval);
-		if (ret)
-			return ret;
-		gossip_debug(GOSSIP_FILE_DEBUG,
-			     "orangefs_ioctl: FS_IOC_GETFLAGS: %llu\n",
-			     (unsigned long long)uval);
-		return put_user(uval, (int __user *)arg);
-	} else if (cmd == FS_IOC_SETFLAGS) {
-		unsigned long old_uval;
-
-		ret = 0;
-		if (get_user(uval, (int __user *)arg))
-			return -EFAULT;
-		/*
-		 * ORANGEFS_MIRROR_FL is set internally when the mirroring mode
-		 * is turned on for a file. The user is not allowed to turn
-		 * on this bit, but the bit is present if the user first gets
-		 * the flags and then updates the flags with some new
-		 * settings. So, we ignore it in the following edit. bligon.
-		 */
-		if ((uval & ~ORANGEFS_MIRROR_FL) &
-		    (~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL))) {
-			gossip_err("orangefs_ioctl: the FS_IOC_SETFLAGS only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n");
-			return -EINVAL;
-		}
-		ret = orangefs_getflags(inode, &old_uval);
-		if (ret)
-			return ret;
-		ret = vfs_ioc_setflags_prepare(inode, old_uval, uval);
-		if (ret)
-			return ret;
-		val = uval;
-		gossip_debug(GOSSIP_FILE_DEBUG,
-			     "orangefs_ioctl: FS_IOC_SETFLAGS: %llu\n",
-			     (unsigned long long)val);
-		ret = orangefs_inode_setxattr(inode,
-					      "user.pvfs2.meta_hint",
-					      &val, sizeof(val), 0);
-	}
-
-	return ret;
-}
-
 static vm_fault_t orangefs_fault(struct vm_fault *vmf)
 {
 	struct file *file = vmf->vma->vm_file;
@@ -660,7 +582,6 @@ const struct file_operations orangefs_file_operations = {
 	.read_iter	= orangefs_file_read_iter,
 	.write_iter	= orangefs_file_write_iter,
 	.lock		= orangefs_lock,
-	.unlocked_ioctl	= orangefs_ioctl,
 	.mmap		= orangefs_file_mmap,
 	.open		= generic_file_open,
 	.splice_read    = generic_file_splice_read,
diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 48f0547d4850..84461d2229ac 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -11,6 +11,7 @@
  */
 
 #include <linux/bvec.h>
+#include <linux/miscattr.h>
 #include "protocol.h"
 #include "orangefs-kernel.h"
 #include "orangefs-bufmap.h"
@@ -952,6 +953,52 @@ int orangefs_update_time(struct inode *inode, struct timespec64 *time, int flags
 	return __orangefs_setattr(inode, &iattr);
 }
 
+static int orangefs_miscattr_get(struct dentry *dentry, struct miscattr *ma)
+{
+	u64 val = 0;
+	int ret;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: called on %pd\n", __func__,
+		     dentry);
+
+	ret = orangefs_inode_getxattr(d_inode(dentry),
+				      "user.pvfs2.meta_hint",
+				      &val, sizeof(val));
+	if (ret < 0 && ret != -ENODATA)
+		return ret;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: flags=%u\n", __func__, (u32) val);
+
+	miscattr_fill_flags(ma, val);
+	return 0;
+}
+
+static int orangefs_miscattr_set(struct dentry *dentry, struct miscattr *ma)
+{
+	u64 val = 0;
+
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: called on %pd\n", __func__,
+		     dentry);
+	/*
+	 * ORANGEFS_MIRROR_FL is set internally when the mirroring mode is
+	 * turned on for a file. The user is not allowed to turn on this bit,
+	 * but the bit is present if the user first gets the flags and then
+	 * updates the flags with some new settings. So, we ignore it in the
+	 * following edit. bligon.
+	 */
+	if (miscattr_has_xattr(ma) ||
+	    (ma->flags & ~(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NOATIME_FL | ORANGEFS_MIRROR_FL))) {
+		gossip_err("%s: only supports setting one of FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NOATIME_FL\n",
+			   __func__);
+		return -EOPNOTSUPP;
+	}
+	val = ma->flags;
+	gossip_debug(GOSSIP_FILE_DEBUG, "%s: flags=%u\n", __func__, (u32) val);
+	return orangefs_inode_setxattr(d_inode(dentry),
+				       "user.pvfs2.meta_hint",
+				       &val, sizeof(val), 0);
+}
+
 /* ORANGEFS2 implementation of VFS inode operations for files */
 static const struct inode_operations orangefs_file_inode_operations = {
 	.get_acl = orangefs_get_acl,
@@ -961,6 +1008,8 @@ static const struct inode_operations orangefs_file_inode_operations = {
 	.listxattr = orangefs_listxattr,
 	.permission = orangefs_permission,
 	.update_time = orangefs_update_time,
+	.miscattr_get = orangefs_miscattr_get,
+	.miscattr_set = orangefs_miscattr_set,
 };
 
 static int orangefs_init_iops(struct inode *inode)
-- 
2.26.2

