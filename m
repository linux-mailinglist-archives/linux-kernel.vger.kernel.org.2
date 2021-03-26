Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9752134AA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhCZOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbhCZOvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:51:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB016C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=innx/Y3CxbQH9XIr+JR3e5Yn1P/CEXqL5hVTPv63044=; b=Rk6v5wp2rCMb2nM/wHSLmObSGs
        av2c/qVhEOn5nZZougvs0gSdpF869v1DY11/I5afuPgs1Wjr/QXsB1ZCCqrBhw96V5qXVmaquPv5G
        +hga9R3w2bn1ERKhvAG/1do5/W09pCj2IZyruNYE6BS+3d9DfYFiFTTb/3fFmJBAtLnCstAd80O3w
        17JUSWXZXpdzOH2KDxFN1Vjr4E4U5a5Sg/550Y07BBI2ghJyOWCytmvE3ZU5FjDoiR4U2oguyI/O6
        6iktesekrolu89JXVEDSXDpwbePe8Ig3t9BLS6bNjiGonpGdZG10Hjh/L+7Bc+35HXAxFvx5LxMPa
        sjna3g6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPnmi-00EymO-R1; Fri, 26 Mar 2021 14:50:03 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D3F8980FEF; Fri, 26 Mar 2021 15:50:00 +0100 (CET)
Date:   Fri, 26 Mar 2021 15:50:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux@rasmusvillemoes.dk
Cc:     linux-kernel@vger.kernel.org, greg@kroah.com
Subject: [PATCH v3 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <20210326145000.GK4746@worktop.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326103935.183934395@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: debugfs: Implement debugfs_create_str()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Mar 25 10:53:55 CET 2021

Implement debugfs_create_str() to easily display names and such in
debugfs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/debugfs/file.c       |   94 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |   17 ++++++++
 2 files changed, 111 insertions(+)

--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -865,6 +865,100 @@ struct dentry *debugfs_create_bool(const
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
+	copy = kmalloc(len + 1, GFP_KERNEL);
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
+	copy[copy_len]     = '\n';
+	copy[copy_len + 1] = '\0';
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, copy, copy_len + 1);
+	kfree(copy);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(debugfs_read_file_str);
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
+EXPORT_SYMBOL_GPL(debugfs_create_str);
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
 
