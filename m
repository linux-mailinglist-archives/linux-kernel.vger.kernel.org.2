Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B670034A5C3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 11:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhCZKoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 06:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhCZKoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 06:44:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC877C0613B2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=rUfDSYF0So8ybPxQpD/JGMtIqLkWHndSxgO2xWKJ9LU=; b=Zh2Elp1C9jO7nF5zZauHdxf3nK
        6FruguSPMuutEloeYgZW0+wtZoQcqbEcPHe+XarpRzfUSV+U41Eekvy7T7ZdAtJPm76PbzB5+8EZi
        dtHpv6jyQ76du4Wex3oTxZK5mMZWT30l0KRrCpJ7sZRsIVe0o3Jb9s74ITy/unSxR0TFxQ/3d2qWW
        HDEvNBYNIelwRfgTMprVVFQo0GWFHV3moiVJBKxlbRyb+20KNu8q63FwXr3Hb5pmSHxmDXpKqI/gL
        cICbsPLdkuC39/JwChO5XWCCV5YV3CaMx030iaVbkJxQj8uZhcL14elmvASsuMqZza1/MpT5e/pJ8
        xycC4jfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPjvF-00EgYU-M2; Fri, 26 Mar 2021 10:42:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AA3530768E;
        Fri, 26 Mar 2021 11:42:32 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id BA1E92BCA7ED3; Fri, 26 Mar 2021 11:42:31 +0100 (CET)
Message-ID: <20210326103935.183934395@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 Mar 2021 11:33:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, greg@kroah.com
Subject: [PATCH 6/9] debugfs: Implement debugfs_create_str()
References: <20210326103352.603456266@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/debugfs/file.c       |  144 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |   29 +++++++++
 2 files changed, 173 insertions(+)

--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -865,6 +865,150 @@ struct dentry *debugfs_create_bool(const
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
+again:
+	rcu_read_lock();
+	str = rcu_dereference(*(char **)file->private_data);
+	len = strlen(str) + 1;
+
+	if (!copy || copy_len < len) {
+		rcu_read_unlock();
+		kfree(copy);
+		copy = kmalloc(len + 1, GFP_KERNEL);
+		if (!copy) {
+			debugfs_file_put(dentry);
+			return -ENOMEM;
+		}
+		copy_len = len;
+		goto again;
+	}
+
+	strncpy(copy, str, len);
+	copy[len] = '\n';
+	copy[len+1] = '\0';
+	rcu_read_unlock();
+
+	debugfs_file_put(dentry);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, copy, len + 1);
+	kfree(copy);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(debugfs_read_file_str);
+
+ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos)
+{
+	struct dentry *dentry = F_DENTRY(file);
+	char *old, *new = NULL;
+	int pos = *ppos;
+	int r;
+
+	r = debugfs_file_get(dentry);
+	if (unlikely(r))
+		return r;
+
+	old = *(char **)file->private_data;
+
+	/* only allow strict concattenation */
+	r = -EINVAL;
+	if (pos && pos != strlen(old))
+		goto error;
+
+	r = -ENOMEM;
+	new = kmalloc(pos + count + 1, GFP_KERNEL);
+	if (!new)
+		goto error;
+
+	if (pos)
+		memcpy(new, old, pos);
+
+	r = -EFAULT;
+	if (copy_from_user(new + pos, user_buf, count))
+		goto error;
+
+	new[pos + count] = '\0';
+	strim(new);
+
+	rcu_assign_pointer(*(char **)file->private_data, new);
+	synchronize_rcu();
+	kfree(old);
+
+	debugfs_file_put(dentry);
+	return count;
+
+error:
+	kfree(new);
+	debugfs_file_put(dentry);
+	return r;
+}
+EXPORT_SYMBOL_GPL(debugfs_write_file_str);
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
+ * NOTE: when writing is enabled it will replace the string, string lifetime is
+ * assumed to be RCU managed.
+ *
+ * If debugfs is not enabled in the kernel, the value ERR_PTR(-ENODEV) will
+ * be returned.
+ */
+struct dentry *debugfs_create_str(const char *name, umode_t mode,
+				   struct dentry *parent, char **value)
+{
+	return debugfs_create_mode_unsafe(name, mode, parent, value, &fops_str,
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
+struct dentry *debugfs_create_str(const char *name, umode_t mode,
+				  struct dentry *parent, char **value);
 
 struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
@@ -156,6 +158,12 @@ ssize_t debugfs_read_file_bool(struct fi
 ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 				size_t count, loff_t *ppos);
 
+ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
+			      size_t count, loff_t *ppos);
+
+ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
+			       size_t count, loff_t *ppos);
+
 #else
 
 #include <linux/err.h>
@@ -297,6 +305,13 @@ static inline struct dentry *debugfs_cre
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct dentry *debugfs_create_str(const char *name, umode_t mode,
+						struct dentry *parent,
+						char **value)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct dentry *debugfs_create_blob(const char *name, umode_t mode,
 				  struct dentry *parent,
 				  struct debugfs_blob_wrapper *blob)
@@ -347,6 +362,20 @@ static inline ssize_t debugfs_write_file
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
+
+static inline ssize_t debugfs_write_file_str(struct file *file,
+					     const char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	return -ENODEV;
+}
 
 #endif
 


