Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ADE34A685
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhCZLj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhCZLi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:38:59 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9929C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 04:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mktisea4Z4cTtpOJLiT4dlCMI4XtzjXEktyvRdN2mvU=; b=pQCprxJu08+ESB6IPGA/KoPJMM
        cF6D+ya4mE+0MOjpYwr92AvUitw3B+QL1tLa/4rZ/pZac0l367Ycxe1swUqJjtfEjmthlMDCj27F1
        /WP5nSJ0AvwTNv5bgmNJgAqOSgMyVurG97q7P+iiugLhgqYyRNBi4gS2aToQprlzlFqmwQ+GUWMT/
        8xUOkfvlfh4FFUNtw+RJFcQyXMdpTHSXwAaH6nm3p5fpDgWmNh5IOr1q+oUX2oJNskSz+csD2SEiP
        7n8SCdDpKsGY+F4PtdTWqHETNOhG3+7qgFK9Mu7GWXMDc7/QKTcLJeQQqEG5dgvkh+NM2jZU1omMf
        HXITnxZg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lPknY-003Rfb-Dt; Fri, 26 Mar 2021 11:38:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CC492306099;
        Fri, 26 Mar 2021 12:38:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 920CE2BD94356; Fri, 26 Mar 2021 12:38:39 +0100 (CET)
Date:   Fri, 26 Mar 2021 12:38:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Greg KH <greg@kroah.com>
Cc:     mingo@kernel.org, mgorman@suse.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        joshdon@google.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] debugfs: Implement debugfs_create_str()
Message-ID: <YF3Hv5zXb/6lauzs@hirez.programming.kicks-ass.net>
References: <20210326103352.603456266@infradead.org>
 <20210326103935.183934395@infradead.org>
 <YF2/41K4xs3ZOQdV@kroah.com>
 <YF3DF+T8nPRgt7Ao@hirez.programming.kicks-ass.net>
 <YF3F0JbbEpeSGzW6@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YF3F0JbbEpeSGzW6@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 12:30:24PM +0100, Greg KH wrote:
> Great, change that and limit the size of the string that can be written
> and it looks good to me, thanks for adding this.

Here goes..

---
Subject: debugfs: Implement debugfs_create_str()
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Mar 25 10:53:55 CET 2021

Implement debugfs_create_str() to easily display names and such in
debugfs.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 fs/debugfs/file.c       |  148 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |   27 ++++++++
 2 files changed, 175 insertions(+)

--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -865,6 +865,154 @@ struct dentry *debugfs_create_bool(const
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
+	r = -E2BIG;
+	if (pos + count + 1 > PAGE_SIZE)
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
@@ -297,6 +305,11 @@ static inline struct dentry *debugfs_cre
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
@@ -347,6 +360,20 @@ static inline ssize_t debugfs_write_file
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
 
