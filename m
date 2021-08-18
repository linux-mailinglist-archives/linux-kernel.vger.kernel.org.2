Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519943F04E3
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237836AbhHRNeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46342 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237694AbhHRNen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629293648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sdI0zO0U4tESozCIhpT5qJCrx4O9+KHKjI6mFEcj2rg=;
        b=XBOZgGBWlHAtcHHtReimf/kzvMtItMuoy8EvYFzo8+ydZbEZOMXnUQZpN30L2zUY0KmDZ2
        jQRzqs4yrMUpeRSjKFDiEftRYzQr7RNRqopVqRe4HAngHQvAIxHG6SojrUhBl8ZhdP8+DK
        exF0tCuXuRXeX4ANXqsNJ4tCeSc2nQY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-5H30oV_aOLeIJiKgJAuMiA-1; Wed, 18 Aug 2021 09:34:07 -0400
X-MC-Unique: 5H30oV_aOLeIJiKgJAuMiA-1
Received: by mail-ej1-f72.google.com with SMTP id s11-20020a170906060b00b005be824f15daso881456ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:34:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sdI0zO0U4tESozCIhpT5qJCrx4O9+KHKjI6mFEcj2rg=;
        b=Z8tWeWmn8oNngvjbjQFLITGUfiJXggvK/C5eshvlC6k7/k1CXEKppFZc5VYgbjEGXH
         +o49duroYXaF1hSHgSfqHLZJLGH7OTWKfEhRFY3r0xmFzERF94yaAfWa47XYjyCLrU8f
         +6ogogXT6tARuAn6FELYs1bJlLrcSinuZmd+B3a7E8NG6PS5GVQsPV4yOmCIBclsWTRz
         OvaRMRIN5+5K9P65D9ht0lXSYgf5hLCPSc6ksetTeOH5hceoo0iocKbqR2NdzSKFstuO
         rBuI8o0fnzJrBp/TS7t+ggCprCmlcyxB4s34NGOnb+sbDwn3giyOfhEfRbr4d4EbXhwP
         SN3g==
X-Gm-Message-State: AOAM533HllHHaEPSld9aofGzKKTO1znq+Nt1POXJ7wRgJsyYF4LmB7G1
        n+52JUfsDWkIreijIJaG6sCYBuwcy1aBHL/+JttxF0MmZghgKnJ433EGelgtJfi3BhF9F7ZPn9o
        yqygi/KaL61HP4BfQfWOvY/BX
X-Received: by 2002:a17:906:85d0:: with SMTP id i16mr9993257ejy.552.1629293645981;
        Wed, 18 Aug 2021 06:34:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOL3cCbGxWnE+tgrrzO5dzEtwXXaw2YaTmo1Qg/eVh4C6krWPbBo+gKKyyvsYpFmAPIJ7sjw==
X-Received: by 2002:a17:906:85d0:: with SMTP id i16mr9993227ejy.552.1629293645756;
        Wed, 18 Aug 2021 06:34:05 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-86-101-169-16.catv.broadband.hu. [86.101.169.16])
        by smtp.gmail.com with ESMTPSA id kg18sm2090922ejc.9.2021.08.18.06.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 06:34:05 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>,
        garyhuang <zjh.20052005@163.com>
Subject: [PATCH v2 2/2] ovl: enable RCU'd ->get_acl()
Date:   Wed, 18 Aug 2021 15:34:00 +0200
Message-Id: <20210818133400.830078-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818133400.830078-1-mszeredi@redhat.com>
References: <20210818133400.830078-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overlayfs does not cache ACL's (to avoid double caching).  Instead it just
calls the underlying filesystem's i_op->get_acl(), which will return the
cached value, if possible.

In rcu path walk, however, get_cached_acl_rcu() is employed to get the
value from the cache, which will fail on overlayfs resulting in dropping
out of rcu walk mode.  This can result in a big performance hit in certain
situations.

Fix by calling ->get_acl() with LOOKUP_RCU flag in case of ACL_DONT_CACHE
(which indicates pass-through)

Reported-by: garyhuang <zjh.20052005@163.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/overlayfs/inode.c      | 7 ++++---
 fs/posix_acl.c            | 8 +++++++-
 include/linux/fs.h        | 5 +++++
 include/linux/posix_acl.h | 3 ++-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 727154a1d3ce..6a55231b262a 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -13,6 +13,7 @@
 #include <linux/fiemap.h>
 #include <linux/fileattr.h>
 #include <linux/security.h>
+#include <linux/namei.h>
 #include "overlayfs.h"
 
 
@@ -454,12 +455,12 @@ struct posix_acl *ovl_get_acl(struct inode *inode, int type, int flags)
 	const struct cred *old_cred;
 	struct posix_acl *acl;
 
-	if (flags)
-		return ERR_PTR(-EINVAL);
-
 	if (!IS_ENABLED(CONFIG_FS_POSIX_ACL) || !IS_POSIXACL(realinode))
 		return NULL;
 
+	if (flags & LOOKUP_RCU)
+		return get_cached_acl_rcu(realinode, type);
+
 	old_cred = ovl_override_creds(inode->i_sb);
 	acl = get_acl(realinode, type);
 	revert_creds(old_cred);
diff --git a/fs/posix_acl.c b/fs/posix_acl.c
index 6b7f793e2b6f..4d1c6c266cf0 100644
--- a/fs/posix_acl.c
+++ b/fs/posix_acl.c
@@ -22,6 +22,7 @@
 #include <linux/xattr.h>
 #include <linux/export.h>
 #include <linux/user_namespace.h>
+#include <linux/namei.h>
 
 static struct posix_acl **acl_by_type(struct inode *inode, int type)
 {
@@ -56,7 +57,12 @@ EXPORT_SYMBOL(get_cached_acl);
 
 struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type)
 {
-	return rcu_dereference(*acl_by_type(inode, type));
+	struct posix_acl *acl = rcu_dereference(*acl_by_type(inode, type));
+
+	if (acl == ACL_DONT_CACHE)
+		acl = inode->i_op->get_acl(inode, type, LOOKUP_RCU);
+
+	return acl;
 }
 EXPORT_SYMBOL(get_cached_acl_rcu);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 1c56d4fc4efe..20b7db2d0a85 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -581,6 +581,11 @@ static inline void mapping_allow_writable(struct address_space *mapping)
 
 struct posix_acl;
 #define ACL_NOT_CACHED ((void *)(-1))
+/*
+ * ACL_DONT_CACHE is for stacked filesystems, that rely on underlying fs to
+ * cache the ACL.  This also means that ->get_acl() can be called in RCU mode
+ * with the LOOKUP_RCU flag.
+ */
 #define ACL_DONT_CACHE ((void *)(-3))
 
 static inline struct posix_acl *
diff --git a/include/linux/posix_acl.h b/include/linux/posix_acl.h
index 307094ebb88c..b65c877d92b8 100644
--- a/include/linux/posix_acl.h
+++ b/include/linux/posix_acl.h
@@ -72,6 +72,8 @@ extern struct posix_acl *get_posix_acl(struct inode *, int);
 extern int set_posix_acl(struct user_namespace *, struct inode *, int,
 			 struct posix_acl *);
 
+struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type);
+
 #ifdef CONFIG_FS_POSIX_ACL
 int posix_acl_chmod(struct user_namespace *, struct inode *, umode_t);
 extern int posix_acl_create(struct inode *, umode_t *, struct posix_acl **,
@@ -84,7 +86,6 @@ extern int simple_set_acl(struct user_namespace *, struct inode *,
 extern int simple_acl_create(struct inode *, struct inode *);
 
 struct posix_acl *get_cached_acl(struct inode *inode, int type);
-struct posix_acl *get_cached_acl_rcu(struct inode *inode, int type);
 void set_cached_acl(struct inode *inode, int type, struct posix_acl *acl);
 void forget_cached_acl(struct inode *inode, int type);
 void forget_all_cached_acls(struct inode *inode);
-- 
2.31.1

