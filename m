Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC034EE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 18:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhC3Qpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 12:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhC3QpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 12:45:12 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452EAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:12 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso8790387wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 09:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pxNg+VtgFbRADA/oIf65maU4RwEik/35LQthQpAW9I=;
        b=RbWVjOjQdRstmJKldJVmDBPvYvl+X+f+n50b+NMo2K6YfbGNlwMY7u2q5GYDj+MiNh
         UX4+2UiC99U4ard5x6x/RhzNN6QVsg8sD56LgefIYoJtrq8pu3o2bIqBiPtH/u0djxIa
         b3hdbHTmV6hc93x+DtFa7TOYog84Vzr7jQCR0uCMOfB/A/1x+3IAyouoi22Pm2iqeTRp
         7TpcHGfknKXjfwOXp/I0XRN//kXyqN5xaCYxu4mm7lQWaaZWz1y8aPHM1zSfpFwh+rzj
         PMOm37K9AUmtwlxB+dOFEw+xeV6r61DcC3OSIdtp/l5TunIvv5bivi9GLufi1QLoOUZm
         eSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pxNg+VtgFbRADA/oIf65maU4RwEik/35LQthQpAW9I=;
        b=IJ3ms6qkPJ1OxIuayPcVB6CLl6snV9xsLp29dtq8BY9tSTlvIob6SIyY3SIiLsoAiR
         WrN/KJQ87xNmkAkp+i6gzMf72mCpLHjBAksU09g00N74n+7X0npieXDudNQpyuRQBrCU
         tyZRaeE4Rh9o37CNRH4sfR4zCXyo5k7rurqGhgmmR5ZN88nyHbGj4daS6lDN9J0d+9wz
         sQsM9cCaNkce2/TgjH5iFUANGiPJhsoFDQ9XaOSVfa/1pZDGnbgLLewNBpWFWPudL0dm
         t3/4+Pghq948PACauSj0F4zwb/N/tGQB8lYhhd7rtXmM3fzTxLAvhl2UDUunm7DJmM+8
         iYqg==
X-Gm-Message-State: AOAM533IaCcEgm/Uat+QH10GHtM6DWhuTGgqpanrAMzYX9Vvk8IbtLJY
        DkcrEwJKXsqx62N3yBqe94OGZQ==
X-Google-Smtp-Source: ABdhPJyVkUveTYMwp1Bkkn9K9StXyRHeF6bR1BepENx3c8zj6jFiQAb1im/yFHJ3QFpVJt/YQBIWug==
X-Received: by 2002:a1c:771a:: with SMTP id t26mr5018941wmi.60.1617122710936;
        Tue, 30 Mar 2021 09:45:10 -0700 (PDT)
Received: from dell.default ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id a15sm25660805wrr.53.2021.03.30.09.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 09:45:10 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 10/31] fs: gfs2: inode: Fix worthy function headers demote others
Date:   Tue, 30 Mar 2021 17:44:37 +0100
Message-Id: <20210330164458.1625478-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210330164458.1625478-1-lee.jones@linaro.org>
References: <20210330164458.1625478-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 fs/gfs2/inode.c:303: warning: Function parameter or member 'dir' not described in 'gfs2_lookupi'
 fs/gfs2/inode.c:303: warning: Excess function parameter 'd_gh' description in 'gfs2_lookupi'
 fs/gfs2/inode.c:303: warning: Excess function parameter 'i_gh' description in 'gfs2_lookupi'
 fs/gfs2/inode.c:485: warning: Excess function parameter 'bhp' description in 'init_dinode'
 fs/gfs2/inode.c:533: warning: expecting prototype for gfs2_trans_da_blocks(). Prototype was for gfs2_trans_da_blks() instead
 fs/gfs2/inode.c:606: warning: Function parameter or member 'excl' not described in 'gfs2_create_inode'
 fs/gfs2/inode.c:849: warning: Function parameter or member 'mnt_userns' not described in 'gfs2_create'
 fs/gfs2/inode.c:849: warning: Function parameter or member 'excl' not described in 'gfs2_create'
 fs/gfs2/inode.c:1094: warning: Function parameter or member 'dentry' not described in 'gfs2_unlink_inode'
 fs/gfs2/inode.c:1094: warning: Excess function parameter 'name' description in 'gfs2_unlink_inode'
 fs/gfs2/inode.c:1094: warning: Excess function parameter 'inode' description in 'gfs2_unlink_inode'
 fs/gfs2/inode.c:1211: warning: Function parameter or member 'mnt_userns' not described in 'gfs2_symlink'
 fs/gfs2/inode.c:1232: warning: Function parameter or member 'mnt_userns' not described in 'gfs2_mkdir'
 fs/gfs2/inode.c:1248: warning: Function parameter or member 'mnt_userns' not described in 'gfs2_mknod'
 fs/gfs2/inode.c:1845: warning: Function parameter or member 'mnt_userns' not described in 'gfs2_permission'
 fs/gfs2/inode.c:1845: warning: Excess function parameter 'flags' description in 'gfs2_permission'
 fs/gfs2/inode.c:1886: warning: Function parameter or member 'inode' not described in 'gfs2_setattr_simple'
 fs/gfs2/inode.c:1976: warning: Function parameter or member 'mnt_userns' not described in 'gfs2_setattr'

Cc: Bob Peterson <rpeterso@redhat.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 fs/gfs2/inode.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index c9775d5c65949..8b1dfdb60d508 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -285,10 +285,9 @@ struct inode *gfs2_lookup_simple(struct inode *dip, const char *name)
 
 /**
  * gfs2_lookupi - Look up a filename in a directory and return its inode
- * @d_gh: An initialized holder for the directory glock
+ * @dir: The inode of the directory containing the inode to look-up
  * @name: The name of the inode to look for
  * @is_root: If 1, ignore the caller's permissions
- * @i_gh: An uninitialized holder for the new inode glock
  *
  * This can be called via the VFS filldir function when NFS is doing
  * a readdirplus and the inode which its intending to stat isn't
@@ -476,7 +475,6 @@ static void gfs2_init_xattr(struct gfs2_inode *ip)
  * @dip: The directory this inode is being created in
  * @ip: The inode
  * @symname: The symlink destination (if a symlink)
- * @bhp: The buffer head (returned to caller)
  *
  */
 
@@ -514,7 +512,7 @@ static void init_dinode(struct gfs2_inode *dip, struct gfs2_inode *ip,
 }
 
 /**
- * gfs2_trans_da_blocks - Calculate number of blocks to link inode
+ * gfs2_trans_da_blks - Calculate number of blocks to link inode
  * @dip: The directory we are linking into
  * @da: The dir add information
  * @nr_inodes: The number of inodes involved
@@ -595,6 +593,7 @@ static int gfs2_initxattrs(struct inode *inode, const struct xattr *xattr_array,
  * @dev: For device nodes, this is the device number
  * @symname: For symlinks, this is the link destination
  * @size: The initial size of the inode (ignored for directories)
+ * @excl: Force fail if directory exists
  *
  * Returns: 0 on success, or error code
  */
@@ -837,9 +836,11 @@ static int gfs2_create_inode(struct inode *dir, struct dentry *dentry,
 
 /**
  * gfs2_create - Create a file
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @dir: The directory in which to create the file
  * @dentry: The dentry of the new file
  * @mode: The mode of the new file
+ * @excl: Frorce fail if exists
  *
  * Returns: errno
  */
@@ -1080,8 +1081,7 @@ static int gfs2_unlink_ok(struct gfs2_inode *dip, const struct qstr *name,
 /**
  * gfs2_unlink_inode - Removes an inode from its parent dir and unlinks it
  * @dip: The parent directory
- * @name: The name of the entry in the parent directory
- * @inode: The inode to be removed
+ * @dentry: The dentry to unlink
  *
  * Called with all the locks and in a transaction. This will only be
  * called for a directory after it has been checked to ensure it is empty.
@@ -1199,6 +1199,7 @@ static int gfs2_unlink(struct inode *dir, struct dentry *dentry)
 
 /**
  * gfs2_symlink - Create a symlink
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @dir: The directory to create the symlink in
  * @dentry: The dentry to put the symlink in
  * @symname: The thing which the link points to
@@ -1220,6 +1221,7 @@ static int gfs2_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 
 /**
  * gfs2_mkdir - Make a directory
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @dir: The parent directory of the new one
  * @dentry: The dentry of the new directory
  * @mode: The mode of the new directory
@@ -1236,6 +1238,7 @@ static int gfs2_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 
 /**
  * gfs2_mknod - Make a special file
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @dir: The directory in which the special file will reside
  * @dentry: The dentry of the special file
  * @mode: The mode of the special file
@@ -1829,9 +1832,9 @@ static const char *gfs2_get_link(struct dentry *dentry,
 
 /**
  * gfs2_permission -
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @inode: The inode
  * @mask: The mask to be tested
- * @flags: Indicates whether this is an RCU path walk or not
  *
  * This may be called from the VFS directly, or from within GFS2 with the
  * inode locked, so we look to see if the glock is already locked and only
@@ -1874,10 +1877,8 @@ static int __gfs2_setattr_simple(struct inode *inode, struct iattr *attr)
 	return 0;
 }
 
-/**
+/*
  * gfs2_setattr_simple -
- * @ip:
- * @attr:
  *
  * Returns: errno
  */
@@ -1962,6 +1963,7 @@ static int setattr_chown(struct inode *inode, struct iattr *attr)
 
 /**
  * gfs2_setattr - Change attributes on an inode
+ * @mnt_userns: User namespace of the mount the inode was found from
  * @dentry: The dentry which is changing
  * @attr: The structure describing the change
  *
-- 
2.27.0

