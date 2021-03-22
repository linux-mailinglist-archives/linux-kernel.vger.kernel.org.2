Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA6E344826
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhCVOwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:52:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231248AbhCVOtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616424582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzzrxrfbZ6Li1+rV206VufAvp4kmrq19gDEYr0Sjiyg=;
        b=Fw9jMYN928gBZONMCRjUMkOs/56SDbmUJVxMaIh1lxQy7LY+78dqhzKam7Lu1TXB5FI/GV
        d37T+0G5ydi3AN70xGF7T3VYoZLZgnQo8lOWnZuefqWww3h1Q0YPuIck+yT5kWMB/FZltS
        4kzPZE0capz9GzG29qPL7CcDJJr3AtE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-OST-mRv-NT2NChzAiTISVw-1; Mon, 22 Mar 2021 10:49:41 -0400
X-MC-Unique: OST-mRv-NT2NChzAiTISVw-1
Received: by mail-ed1-f69.google.com with SMTP id y10so15195951edr.20
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:49:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzzrxrfbZ6Li1+rV206VufAvp4kmrq19gDEYr0Sjiyg=;
        b=l3M9zLb+sdSd1Ei5bhYgnBJYIdS/Tij47xhHAp77a1dSK7n1WXMoK+ldmNEK36CFQ1
         kN0QDcwpSfVpUI81I2Ok3zUGbjPlRPZ++L89alHrPn/ouo7Z3UI8Rc5aohj7bYLS7lIw
         b4hVzvQXdlo6Kr3V2dMoTrh5nLj3fROvBWWtObejKATpNhW4asQlMIJDUH9QuwFL385V
         XPtcFo/rSVw139NjfcRZOmgeQQNd5Pe8Vui96XVARvNBh5Oz+ijpObOrJbAmU70fqLhl
         roUABI3Y1H9OSfym2oY6mW6jp5+u5+heCoBrwCEgrI2sFhSOno3dWJ09hIUp/vy2xNV8
         EfGw==
X-Gm-Message-State: AOAM530YXGxlZuRFTH7kcYPfxwDeK0IVP2GWkVM+XNGio4lHjYnD68Xb
        qXj/Io09omfnQXfuONWQk3XBszEiX6b078AvahJgveE1u1ZrhDQiqj/P1L3wDVJn5EFyb3lcqtm
        AZ6Zg7yjnvz5UHQrqL0MbfYPQ
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr26122490edy.225.1616424579944;
        Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmA+7jm77Yf7uBGUKOCjGtM76lqZiG9z471QyGjwDECbN0X/0/eSaIJdwN8mOgSCCGtChCmA==
X-Received: by 2002:a05:6402:181a:: with SMTP id g26mr26122467edy.225.1616424579749;
        Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-67.catv.broadband.hu. [86.101.169.67])
        by smtp.gmail.com with ESMTPSA id r4sm9793117ejd.125.2021.03.22.07.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:49:39 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 18/18] vfs: remove unused ioctl helpers
Date:   Mon, 22 Mar 2021 15:49:16 +0100
Message-Id: <20210322144916.137245-19-mszeredi@redhat.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322144916.137245-1-mszeredi@redhat.com>
References: <20210322144916.137245-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove vfs_ioc_setflags_prepare(), vfs_ioc_fssetxattr_check() and
simple_fill_fsxattr(), which are no longer used.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
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
index 9e7f6a592a70..1e88ace15004 100644
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

