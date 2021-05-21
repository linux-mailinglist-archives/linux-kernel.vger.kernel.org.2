Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C485638CDB5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbhEUSpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230462AbhEUSpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:45:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA43B61175;
        Fri, 21 May 2021 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621622624;
        bh=JGwzVWG0oaJPVbHUFXeJg85XoVr3cUq6OrUe8Vhri5M=;
        h=From:To:Cc:Subject:Date:From;
        b=SJA/q5OIvgx+IlAjUa/LdplP0J5HtRj2vVygrgv+gwA/K4zootbrLAEhidLHUsDrY
         fNYB7sKjMOSqbqWBcRQOUQAz9Rj0udSTceQeSc+7f0+f/zSjq2+Xn3ITLN1EJmRotx
         T5IbbGSwdWxGIlgRtpiBq1b9ANl28dGcPusgRm5I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] debugfs: remove return value of debugfs_create_ulong()
Date:   Fri, 21 May 2021 20:43:40 +0200
Message-Id: <20210521184340.1348539-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_ulong(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/file.c       | 18 ++++--------------
 include/linux/debugfs.h | 14 +++++---------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index e813acfaa6e8..d513d5465c89 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -582,22 +582,12 @@ DEFINE_DEBUGFS_ATTRIBUTE(fops_ulong_wo, NULL, debugfs_ulong_set, "%llu\n");
  * This function creates a file in debugfs with the given name that
  * contains the value of the variable @value.  If the @mode variable is so
  * set, it can be read from, and written to.
- *
- * This function will return a pointer to a dentry if it succeeds.  This
- * pointer must be passed to the debugfs_remove() function when the file is
- * to be removed (no automatic cleanup happens if your module is unloaded,
- * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
- * returned.
- *
- * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
- * be returned.
  */
-struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
-				    struct dentry *parent, unsigned long *value)
+void debugfs_create_ulong(const char *name, umode_t mode, struct dentry *parent,
+			  unsigned long *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value,
-					&fops_ulong, &fops_ulong_ro,
-					&fops_ulong_wo);
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_ulong,
+				   &fops_ulong_ro, &fops_ulong_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_ulong);
 
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 1fdb4343af9c..4e82f2b1fa62 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -112,8 +112,8 @@ void debugfs_create_u32(const char *name, umode_t mode, struct dentry *parent,
 			u32 *value);
 void debugfs_create_u64(const char *name, umode_t mode, struct dentry *parent,
 			u64 *value);
-struct dentry *debugfs_create_ulong(const char *name, umode_t mode,
-				    struct dentry *parent, unsigned long *value);
+void debugfs_create_ulong(const char *name, umode_t mode, struct dentry *parent,
+			  unsigned long *value);
 void debugfs_create_x8(const char *name, umode_t mode, struct dentry *parent,
 		       u8 *value);
 void debugfs_create_x16(const char *name, umode_t mode, struct dentry *parent,
@@ -266,13 +266,9 @@ static inline void debugfs_create_u32(const char *name, umode_t mode,
 static inline void debugfs_create_u64(const char *name, umode_t mode,
 				      struct dentry *parent, u64 *value) { }
 
-static inline struct dentry *debugfs_create_ulong(const char *name,
-						umode_t mode,
-						struct dentry *parent,
-						unsigned long *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_ulong(const char *name, umode_t mode,
+					struct dentry *parent,
+					unsigned long *value) { }
 
 static inline void debugfs_create_x8(const char *name, umode_t mode,
 				     struct dentry *parent, u8 *value) { }
-- 
2.31.1

