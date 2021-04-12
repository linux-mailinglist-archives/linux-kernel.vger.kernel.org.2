Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48B735C3AA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238520AbhDLKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbhDLKVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:21:35 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACF5C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=suS2jhvKqcy3Sty7ScVC2iQKhuVPP5ZHHrLkCTVIKh0=; b=lmKqqzdiyZ0bAv8wrscI8iApb7
        lUQRcv7lhrWH5XQZA2LmPwl/w6k/hx567Bj93okroeITBnnPIoNxSmHJNeaQ+Q/WMEyazFrFw1Uf1
        UvWX0wDfANycyVxU9V0EBRI+vuITEfMIL/FPNGAm6vDYEu/pQdRDPVABJ9UfRwQT8xSqXmMJhWcNv
        0R7N419wWxIIggkBDI+TerjZClhh9xXsjTJIcWTYSXLTIo0WVTJveG8hye6G7mp1lY3OyMz9At9M9
        O4JLPMalE38epQjzAcD/7yYxs+rSGJCxDXkSUe3N9YqgC8ZsSuhPwY6syPvJXf5k0YRh1ccsdVtgj
        HtPKcFrw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVtgj-006QVJ-Hf; Mon, 12 Apr 2021 10:21:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D136630026E;
        Mon, 12 Apr 2021 12:20:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CD2D029D8B773; Mon, 12 Apr 2021 12:20:58 +0200 (CEST)
Message-ID: <20210412102001.415407080@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 12 Apr 2021 12:14:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com,
        linux@rasmusvillemoes.dk,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
References: <20210412101421.609526370@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement debugfs_create_str() to easily display names and such in
debugfs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/debugfs/file.c       |   91 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |   17 ++++++++
 2 files changed, 108 insertions(+)

--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -865,6 +865,97 @@ struct dentry *debugfs_create_bool(const
 }
 EXPORT_SYMBOL_GPL(debugfs_create_bool);
 
+ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos)
+{
+	struct dentry *dentry = F_DENTRY(file);
+	char *str, *copy = NULL;
+	int copy_len, len;
+	ssize_t ret;
+
+	ret = debugfs_file_get(dentry);
+	if (unlikely(ret))
+		return ret;
+
+	str = *(char **)file->private_data;
+	len = strlen(str) + 1;
+	copy = kmalloc(len, GFP_KERNEL);
+	if (!copy) {
+		debugfs_file_put(dentry);
+		return -ENOMEM;
+	}
+
+	copy_len = strscpy(copy, str, len);
+	debugfs_file_put(dentry);
+	if (copy_len < 0) {
+		kfree(copy);
+		return copy_len;
+	}
+
+	copy[copy_len] = '\n';
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, copy, copy_len);
+	kfree(copy);
+
+	return ret;
+}
+
+static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	/* This is really only for read-only strings */
+	return -EINVAL;
+}
+
+static const struct file_operations fops_str = {
+	.read =		debugfs_read_file_str,
+	.write =	debugfs_write_file_str,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+static const struct file_operations fops_str_ro = {
+	.read =		debugfs_read_file_str,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+static const struct file_operations fops_str_wo = {
+	.write =	debugfs_write_file_str,
+	.open =		simple_open,
+	.llseek =	default_llseek,
+};
+
+/**
+ * debugfs_create_str - create a debugfs file that is used to read and write a string value
+ * @name: a pointer to a string containing the name of the file to create.
+ * @mode: the permission that the file should have
+ * @parent: a pointer to the parent dentry for this file.  This should be a
+ *          directory dentry if set.  If this parameter is %NULL, then the
+ *          file will be created in the root of the debugfs filesystem.
+ * @value: a pointer to the variable that the file should read to and write
+ *         from.
+ *
+ * This function creates a file in debugfs with the given name that
+ * contains the value of the variable @value.  If the @mode variable is so
+ * set, it can be read from, and written to.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  This
+ * pointer must be passed to the debugfs_remove() function when the file is
+ * to be removed (no automatic cleanup happens if your module is unloaded,
+ * you are responsible here.)  If an error occurs, ERR_PTR(-ERROR) will be
+ * returned.
+ *
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
+ * be returned.
+ */
+void debugfs_create_str(const char *name, umode_t mode,
+			struct dentry *parent, char **value)
+{
+	debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
+				   &fops_str_ro, &fops_str_wo);
+}
+
 static ssize_t read_file_blob(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos)
 {
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -128,6 +128,8 @@ void debugfs_create_atomic_t(const char
 			     struct dentry *parent, atomic_t *value);
 struct dentry *debugfs_create_bool(const char *name, umode_t mode,
 				  struct dentry *parent, bool *value);
+void debugfs_create_str(const char *name, umode_t mode,
+			struct dentry *parent, char **value);
 
 struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
@@ -156,6 +158,9 @@ ssize_t debugfs_read_file_bool(struct fi
 ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos);
 
+ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos);
+
 #else
 
 #include <linux/err.h>
@@ -297,6 +302,11 @@ static inline struct dentry *debugfs_cre
 	return ERR_PTR(-ENODEV);
 }
 
+static inline void debugfs_create_str(const char *name, umode_t mode,
+				      struct dentry *parent,
+				      char **value)
+{ }
+
 static inline struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
 				  struct debugfs_blob_wrapper *blob)
@@ -347,6 +357,13 @@ static inline ssize_t debugfs_write_file
 {
 	return -ENODEV;
 }
+
+static inline ssize_t debugfs_read_file_str(struct file *file,
+					    char __user *user_buf,
+					    size_t count, loff_t *ppos)
+{
+	return -ENODEV;
+}
 
 #endif
 


