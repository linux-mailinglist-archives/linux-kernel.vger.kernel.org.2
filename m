Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF3338CDBF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 20:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbhEUSqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 14:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEUSqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 14:46:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBF161163;
        Fri, 21 May 2021 18:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621622722;
        bh=Nm8Cfc8aRBpj9UuxNsnBPYL/hKeRFeJTjmPOBDEyCZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=COaStRG7C2aYJGo0+x+V8wBNuuiGgV/jNEaUd245CM5uVyshAIUfo2fYp0kTpovW7
         sc/y2VFnLDURfTEhlQWz9U4MkzUpxmrE7VA94YgpG1mxIHj3wIieBAsZUIE/QHMd41
         FZ+MW6bzcekTup397MEdXsmLACeQeGaLwL9WkTGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] debugfs: remove return value of debugfs_create_bool()
Date:   Fri, 21 May 2021 20:45:19 +0200
Message-Id: <20210521184519.1356639-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No one checks the return value of debugfs_create_bool(), as it's not
needed, so make the return value void, so that no one tries to do so in
the future.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/filesystems/debugfs.rst |  4 ++--
 fs/debugfs/file.c                     | 15 +++------------
 include/linux/debugfs.h               | 12 ++++--------
 3 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/Documentation/filesystems/debugfs.rst b/Documentation/filesystems/debugfs.rst
index 0f2292e367e6..71b1fee56d2a 100644
--- a/Documentation/filesystems/debugfs.rst
+++ b/Documentation/filesystems/debugfs.rst
@@ -120,8 +120,8 @@ and hexadecimal::
 
 Boolean values can be placed in debugfs with::
 
-    struct dentry *debugfs_create_bool(const char *name, umode_t mode,
-				       struct dentry *parent, bool *value);
+    void debugfs_create_bool(const char *name, umode_t mode,
+                             struct dentry *parent, bool *value);
 
 A read on the resulting file will yield either Y (for non-zero values) or
 N, followed by a newline.  If written to, it will accept either upper- or
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index d513d5465c89..6ede714cb551 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -836,20 +836,11 @@ static const struct file_operations fops_bool_wo = {
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
-struct dentry *debugfs_create_bool(const char *name, umode_t mode,
-				   struct dentry *parent, bool *value)
+void debugfs_create_bool(const char *name, umode_t mode, struct dentry *parent,
+			 bool *value)
 {
-	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_bool,
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_bool,
 				   &fops_bool_ro, &fops_bool_wo);
 }
 EXPORT_SYMBOL_GPL(debugfs_create_bool);
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 4e82f2b1fa62..c869f1e73d75 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -126,8 +126,8 @@ void debugfs_create_size_t(const char *name, umode_t mode,
 			   struct dentry *parent, size_t *value);
 void debugfs_create_atomic_t(const char *name, umode_t mode,
 			     struct dentry *parent, atomic_t *value);
-struct dentry *debugfs_create_bool(const char *name, umode_t mode,
-				  struct dentry *parent, bool *value);
+void debugfs_create_bool(const char *name, umode_t mode, struct dentry *parent,
+			 bool *value);
 void debugfs_create_str(const char *name, umode_t mode,
 			struct dentry *parent, char **value);
 
@@ -291,12 +291,8 @@ static inline void debugfs_create_atomic_t(const char *name, umode_t mode,
 					   atomic_t *value)
 { }
 
-static inline struct dentry *debugfs_create_bool(const char *name, umode_t mode,
-						 struct dentry *parent,
-						 bool *value)
-{
-	return ERR_PTR(-ENODEV);
-}
+static inline void debugfs_create_bool(const char *name, umode_t mode,
+				       struct dentry *parent, bool *value) { }
 
 static inline void debugfs_create_str(const char *name, umode_t mode,
 				      struct dentry *parent,
-- 
2.31.1

