Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703BF349A86
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 20:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbhCYTjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 15:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39793 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230336AbhCYTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 15:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616701100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xe1RgBQE/G9XF6ytQooX6iFiFRZ4POCra4z89XvkUPk=;
        b=bv8rVwqgg4vp37IELv55gLkTJ5dxGXVtjj218QPj++8Y4/7s9AtJHIW0QAokH03CpvMxsd
        Cz2iwJbyuEjPavwmKGNQXgPguMoLecRQjXublQQvqrwuwO0XkTNq6KMgVveFi+RLOQlkQ6
        4N6BN8SQpYNgEhIJK5qWHC41VQc/xuU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-wB4Z5PwgMg2JXO-aYHtpcQ-1; Thu, 25 Mar 2021 15:38:18 -0400
X-MC-Unique: wB4Z5PwgMg2JXO-aYHtpcQ-1
Received: by mail-ed1-f70.google.com with SMTP id bi17so3202115edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 12:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xe1RgBQE/G9XF6ytQooX6iFiFRZ4POCra4z89XvkUPk=;
        b=Hgc5KKGS8K35nIbabtJouNRg6xEx+Wi7AipBD0jlMtQSzNJIvX5LZihL65r0aWIxXl
         akOBfmK3K6QC7+jEm5Ku4hAZxBOOyzQ7l5IVgct3tnjPgH9FfB+in1zM3CQJQNwuAgiX
         3kHkt12qx65igCC6P3SyAR0LsJt41tofveCvTh3ZoK4N3Omx2d45NuzJ/KvEpZpw2kz5
         mn6++kcd4H5RdZ2J8PKZ8xq5qATUmUeBvkqAMNP3DDD7QrhPq7bQWN1tKNbSILIvC0Rg
         gKy5F1oVjOMoCd49wOfu6zQrMtmjD50A0GTNqG4fbjVN6aZ2Cv9QtXMkv5V01byu52fM
         v9Mg==
X-Gm-Message-State: AOAM531H187CHywu/jEUCFTQR9OkU15Z/ueu3CjdrML/MYEctKEKv6HF
        IrWK3q6L2SpvyQMNkc2tDT1bjY5EWnw4f9HXAKzLkKaUTkxtkKO0BK6IAYEY20e432RiYhr1ArE
        mirEIqdsFbso7X4HCBUTRflwG
X-Received: by 2002:a17:907:720a:: with SMTP id dr10mr11045117ejc.375.1616701096907;
        Thu, 25 Mar 2021 12:38:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFV1oZ+BK7v8WO040FkXSjAZV626OHX3ZFmSFkpTQMQ85TXUe3JuTEsoL0uvpq7ySkkOUKOw==
X-Received: by 2002:a17:907:720a:: with SMTP id dr10mr11045102ejc.375.1616701096688;
        Thu, 25 Mar 2021 12:38:16 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id si7sm2881996ejb.84.2021.03.25.12.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 12:38:16 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 18/18] vfs: remove unused ioctl helpers
Date:   Thu, 25 Mar 2021 20:37:55 +0100
Message-Id: <20210325193755.294925-19-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210325193755.294925-1-mszeredi@redhat.com>
References: <20210325193755.294925-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove vfs_ioc_setflags_prepare(), vfs_ioc_fssetxattr_check() and
simple_fill_fsxattr(), which are no longer used.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/inode.c         | 87 ----------------------------------------------
 include/linux/fs.h | 12 -------
 2 files changed, 99 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index a047ab306f9a..ae526fd9c0a4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -12,7 +12,6 @@
 #include <linux/security.h>
 #include <linux/cdev.h>
 #include <linux/memblock.h>
-#include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
@@ -2314,89 +2313,3 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
-
-/*
- * Generic function to check FS_IOC_SETFLAGS values and reject any invalid
- * configurations.
- *
- * Note: the caller should be holding i_mutex, or else be sure that they have
- * exclusive access to the inode structure.
- */
-int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
-			     unsigned int flags)
-{
-	/*
-	 * The IMMUTABLE and APPEND_ONLY flags can only be changed by
-	 * the relevant capability.
-	 *
-	 * This test looks nicer. Thanks to Pauline Middelink
-	 */
-	if ((flags ^ oldflags) & (FS_APPEND_FL | FS_IMMUTABLE_FL) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	return fscrypt_prepare_setflags(inode, oldflags, flags);
-}
-EXPORT_SYMBOL(vfs_ioc_setflags_prepare);
-
-/*
- * Generic function to check FS_IOC_FSSETXATTR values and reject any invalid
- * configurations.
- *
- * Note: the caller should be holding i_mutex, or else be sure that they have
- * exclusive access to the inode structure.
- */
-int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
-			     struct fsxattr *fa)
-{
-	/*
-	 * Can't modify an immutable/append-only file unless we have
-	 * appropriate permission.
-	 */
-	if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
-			(FS_XFLAG_IMMUTABLE | FS_XFLAG_APPEND) &&
-	    !capable(CAP_LINUX_IMMUTABLE))
-		return -EPERM;
-
-	/*
-	 * Project Quota ID state is only allowed to change from within the init
-	 * namespace. Enforce that restriction only if we are trying to change
-	 * the quota ID state. Everything else is allowed in user namespaces.
-	 */
-	if (current_user_ns() != &init_user_ns) {
-		if (old_fa->fsx_projid != fa->fsx_projid)
-			return -EINVAL;
-		if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
-				FS_XFLAG_PROJINHERIT)
-			return -EINVAL;
-	}
-
-	/* Check extent size hints. */
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSIZE) && !S_ISREG(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_EXTSZINHERIT) &&
-			!S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	if ((fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
-	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
-		return -EINVAL;
-
-	/*
-	 * It is only valid to set the DAX flag on regular files and
-	 * directories on filesystems.
-	 */
-	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
-	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
-		return -EINVAL;
-
-	/* Extent size hints of zero turn off the flags. */
-	if (fa->fsx_extsize == 0)
-		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);
-	if (fa->fsx_cowextsize == 0)
-		fa->fsx_xflags &= ~FS_XFLAG_COWEXTSIZE;
-
-	return 0;
-}
-EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 156b78f42a28..820fdc62ac30 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3571,18 +3571,6 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
-int vfs_ioc_setflags_prepare(struct inode *inode, unsigned int oldflags,
-			     unsigned int flags);
-
-int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
-			     struct fsxattr *fa);
-
-static inline void simple_fill_fsxattr(struct fsxattr *fa, __u32 xflags)
-{
-	memset(fa, 0, sizeof(*fa));
-	fa->fsx_xflags = xflags;
-}
-
 /*
  * Flush file data before changing attributes.  Caller must hold any locks
  * required to prevent further writes to this file until we're done setting
-- 
2.30.2

