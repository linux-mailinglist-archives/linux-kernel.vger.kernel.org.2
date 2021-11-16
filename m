Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7D2453A59
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbhKPTqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:46:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbhKPTqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:46:18 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97909C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:43:21 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id q12so97727pgh.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aPOYW20bP9axR+huv2l40pnrQ8xrHrsRaFVlcPUQJRE=;
        b=b/tDytIcwvHt9kT147ZgbyOV6huXsUHxKjT6i253GBWKL2vi5zQ7KH1+WrlJEOfQAT
         VaCxa5zdckSJWk+FiaUpAFA9sbQwvusr1KpE1wM3I6qgqW8ggHpbkCN+pMu1x7Gf9AI0
         bFjES3U9eJD40dh0IYXqJ3EoGYWuuWrmi+w03HB05kQ92f5Y/Qlm3cfAhZFpBYZCxB+h
         lvLmCauoIW+YgCuj5/CyphT/6baQ2ZnsAGkfdbMy8pVQc1HA80xbtobRT5i4+0eEx1Gl
         WzTkOAeZUg8c3Cas8R6Gj7xfsoV1d6N7LMCEE4oX1q645kNtAlAYlJWIGsE2kO9JNYyp
         lk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=aPOYW20bP9axR+huv2l40pnrQ8xrHrsRaFVlcPUQJRE=;
        b=T/4CALUJjSjFXWxLrlVanNMThWOer8DJIuSWP5lzXZ8IAcCPxtc0RTIbU6z35uR2UB
         DQlltczKNhQSTuzPwkLjwcCz6G2grFlV83KKMTPFc5JeYrmjtU6ud/p8iybZot+/q/YY
         dfPLr+syari6iOERbokQuaODAsRoyu9VOkqO0S9PcxwjYnRZI0c+Pk7yUy/QZtOFkK3K
         DGsrPf+FDieTn/iF1S49gs4qN6R6sgr7MJXsWyad8afwyOn/Oy9EFYIwct0ETx6Wm1TS
         /4J3ovt6tAdLo7IF/VbSzCr+wBD1Yxz0jEjV0jpHOPErZFgMr69eOHmulSRbwwcz5C90
         6V1g==
X-Gm-Message-State: AOAM532Xo9KWYo1uXrpHawKbezEwIDITAlb/jZzz/QRlzExK/BWbRTHc
        ZK+KcwGPZNzlYK8aqm5rhXdljGdhR8k=
X-Google-Smtp-Source: ABdhPJw/3XDiznj8S8mykd65Ahpj91WYQGjhIr10eS9bIqY6W/XSiOsBfVnjNQtdVdPz0NI9v8UWoA==
X-Received: by 2002:aa7:88cb:0:b0:49f:ad17:c08 with SMTP id k11-20020aa788cb000000b0049fad170c08mr42243482pff.19.1637091801086;
        Tue, 16 Nov 2021 11:43:21 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:3a93:19e8:b5b5:97fd])
        by smtp.gmail.com with ESMTPSA id ep15sm2407300pjb.3.2021.11.16.11.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 11:43:20 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>
Subject: [RFC PATCH] kernfs: release kernfs_mutex before the inode allocation
Date:   Tue, 16 Nov 2021 11:43:17 -0800
Message-Id: <20211116194317.1430399-1-minchan@kernel.org>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernfs implementation has big lock granularity(kernfs_rwsem) so
every kernfs-based(e.g., sysfs, cgroup, dmabuf) fs are able to compete
the lock. Thus, if one of userspace goes the sleep under holding
the lock for a long time, rest of them should wait it. A example is
the holder goes direct reclaim with the lock since it needs memory
allocation. Let's fix it at common technique that release the lock
and then allocate the memory. Fortunately, kernfs looks like have
an refcount so I hope it's fine.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 fs/kernfs/dir.c             | 14 +++++++++++---
 fs/kernfs/inode.c           |  2 +-
 fs/kernfs/kernfs-internal.h |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 8e0a1378a4b1..ecdb2975060d 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1119,9 +1119,17 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 			up_read(&kernfs_rwsem);
 			return NULL;
 		}
-		inode = kernfs_get_inode(dir->i_sb, kn);
-		if (!inode)
-			inode = ERR_PTR(-ENOMEM);
+		kernfs_get(kn);
+		up_read(&kernfs_rwsem);
+		inode = iget_locked(dir->i_sb, kernfs_ino(kn));
+		if (!inode) {
+			kernfs_put(kn);
+			return ERR_PTR(-ENOMEM);
+		}
+		down_read(&kernfs_rwsem);
+		if (inode->i_state & I_NEW)
+			kernfs_init_inode(kn, inode);
+		kernfs_put(kn);
 	}
 	/*
 	 * Needed for negative dentry validation.
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index c0eae1725435..6e2004010435 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -195,7 +195,7 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 	return 0;
 }
 
-static void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
+void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode)
 {
 	kernfs_get(kn);
 	inode->i_private = kn;
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f9cc912c31e1..eef7656f7cd8 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -118,6 +118,7 @@ int kernfs_iop_getattr(struct user_namespace *mnt_userns,
 		       u32 request_mask, unsigned int query_flags);
 ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size);
 int __kernfs_setattr(struct kernfs_node *kn, const struct iattr *iattr);
+void kernfs_init_inode(struct kernfs_node *kn, struct inode *inode);
 
 /*
  * dir.c
-- 
2.34.0.rc1.387.gb447b232ab-goog

