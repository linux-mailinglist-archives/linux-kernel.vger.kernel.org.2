Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16E034A3E3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 10:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhCZJMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 05:12:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F484C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hq27so7289662ejc.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pxNg+VtgFbRADA/oIf65maU4RwEik/35LQthQpAW9I=;
        b=TtkPWPcLe4I/CIoWiw++G07swgHetoG1GSngBovwM/bO7MjFwUrezIwebCKkWtFBpB
         34FeJWEy3FWh3Odd5amkSK8j/3wxoNAoabBc2wF/GsjQIZ4RiN0vriLQNSnIQeiEVKFj
         xlSTJhUnBm750zyWKs3a6P1prX1TKyUW9kLMLUAHjjb/gCTE39BA90o10OzcdK/qqCgu
         OHqXih169Q+PubHm3a6sJ3+uEAcAN6AZ4ifcD2MvP7aOqfviYrUaFz/ZBKUk0k+21k4A
         +fSSSi/W4LfqUG1PbQZkAGcXQBoPTSNWR3VX2n84c/eaW27TnksCDW7ylgsG5vuDaPEX
         NQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pxNg+VtgFbRADA/oIf65maU4RwEik/35LQthQpAW9I=;
        b=gFC3LEcLYEjK5sJ/sYBOklQHvLvCJoMiLIqFQYUakko1EqU6b+/dK0Wezx2rWZbHiE
         k49IOCeq5lz/dclcMIPy5LoWU44NaVVfqChftyG53f5TQs4StElhIeF5tXyJTdEZ3Z3h
         m+lOLsHi9tbsf2+sL53josgujcNRKi9G6U17U84QZVmXgVDfKRzoKVxjumVlgfHTtR/h
         +Zi49AeXSQzBiE8DfWgCU8keQ3DZi6ruMtc2U2E51ERuKa/0h0y3a91uc8yFe05egZVY
         VMW6ePKidRLKgsU526o/G2cxmRD1omWY4U6tUsfelkG1fRcxz2xsrNLtIksBJFnYPMtt
         dHYw==
X-Gm-Message-State: AOAM532U2ivFk4Bqze8LiJtWzGpxrTziyrn9pDER05KGLThj8IUzutYH
        u/dxXR+eQ02BakJP9gXxfIDBFg==
X-Google-Smtp-Source: ABdhPJziDl03qfoFrnO6tMQQoQxPK+B/djA1Wv1x/gXEDVc6MEnjYJJ/kR1Fmtbbt+SbQ8ijeF6YOg==
X-Received: by 2002:a17:907:75c7:: with SMTP id jl7mr14690318ejc.191.1616749924077;
        Fri, 26 Mar 2021 02:12:04 -0700 (PDT)
Received: from dell.default ([91.110.221.194])
        by smtp.gmail.com with ESMTPSA id r13sm3895645edy.3.2021.03.26.02.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 02:12:03 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com
Subject: [PATCH 10/18] fs: gfs2: inode: Fix worthy function headers demote others
Date:   Fri, 26 Mar 2021 09:11:43 +0000
Message-Id: <20210326091151.311647-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326091151.311647-1-lee.jones@linaro.org>
References: <20210326091151.311647-1-lee.jones@linaro.org>
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

