Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C586E3F97DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbhH0KNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbhH0KNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:13:04 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F6AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:12:15 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id z2so3651423qvl.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 03:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vl7J8Cytot5nianG0qdw7azLZtTT5bF1UBQj5zfDHaQ=;
        b=gfgGnqq5cj0XS2nrk8MwNTIDhFkEWu95qHwa0V7pbO5e2oE1u+OuPjNhl0ID87gPOm
         i9DHYMjr2QCrh67QC3buNcTeE5Ndo+ea5cN7TC+Eb1CAzrzH0HH/zZ8zP+dHOU6lqz4o
         LgpK3SVMVqsxwSyB9KlhGeZby0UFaFNnrB/q5EesEPy+Z50oK3GFB+5NdUkun/9X3O6N
         zaZB4ELgEevKcq9Y0GVpqXgGngnkqXwOj+5oIfZAq3R2B8fAVoagz9pN/2lYTpNq4IIO
         KYj8RXGsWciT0FEl6dLnfuOtlpdrIOjkFTYMMEmNpZ+at8mWSr9vBzJXRLzd5Nv+r3Mw
         cmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vl7J8Cytot5nianG0qdw7azLZtTT5bF1UBQj5zfDHaQ=;
        b=gfRWAGBRfUbXjaVXS1vp6nENgV74U8g1o86PFBfiQvWzlbtu7VlMlOUmT7QFL2Fcr8
         9yNWsw8XLrbTMXuA9NIzrJfGvveiVzb5T5KDpTFHTcmWasso4GJUYtEZzQla51ycsP6e
         jO5xBaPCNXWOuymYBWamT6LT9YQcYgszpU0JtVs4OM+N4FxZxz9sr43kL4am888Anwqj
         eSydYg/VPa/IOCnGTa0rTOt7AHs4A8nNsqadHg+7FGbCE157CJOUhhCsPUL1rHw6yrj7
         GQ/C1PWFK4hyZSIkzIbDiBOqR+PjISBccXVhUixZZpNpsCxQpkF47/XqzcIgNa9C241k
         wc9Q==
X-Gm-Message-State: AOAM5334tiQBrOP8CEHdO8Q2WtxD5jP+Yix1iK0DiQrTqii0wgdJSrEu
        Cjfu3oAIp7Bw3NFiVQGGac0=
X-Google-Smtp-Source: ABdhPJzDwwcJpHxcn1dXLeyUkgfXmlmYrs/kfxcIK3GVRrgaet+jqxPqlY70D75b/w5IPDespdtrUw==
X-Received: by 2002:ad4:4f50:: with SMTP id eu16mr8432809qvb.27.1630059134384;
        Fri, 27 Aug 2021 03:12:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x125sm4445752qkd.8.2021.08.27.03.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 03:12:14 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <ran.xiaokai@zte.com.cn>
To:     christian.brauner@ubuntu.com, dbueso@suse.de
Cc:     cgel.zte@gmail.com, jamorris@linux.microsoft.com,
        keescook@chromium.org, ktkhai@virtuozzo.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, ran.xiaokai@zte.com.cn,
        varad.gautam@suse.com
Subject: [PATCH V2] ipc: add set_ownership() and permissions() callbacks for posix mqueue sysctl
Date:   Fri, 27 Aug 2021 03:12:06 -0700
Message-Id: <20210827101206.5810-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
References: <20210824120523.s5qnzt643yvgugpv@wittgenstein>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ran Xiaokai <ran.xiaokai@zte.com.cn>

When a non-root user process creates a user namespace and ipc namespace
with command "unshare -Ur -i", and map the root user inside
the user namesapce to the global owner of user namespace.
The newly created user namespace OWNS the ipc namespace,
So the root user inside the user namespace should have full access
rights to the ipc namespace resources and should be writable to
the ipc mqueue sysctls.

v2:
  - update commit msg.
  - fix the coding style issue.
Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/ipc_namespace.h |  14 +++++
 ipc/mq_sysctl.c               | 118 ++++++++++++++++++++++++++++++++++++------
 ipc/mqueue.c                  |  10 +++-
 ipc/namespace.c               |   2 +
 4 files changed, 126 insertions(+), 18 deletions(-)

diff --git a/include/linux/ipc_namespace.h b/include/linux/ipc_namespace.h
index 05e2277..3e8e340 100644
--- a/include/linux/ipc_namespace.h
+++ b/include/linux/ipc_namespace.h
@@ -10,6 +10,7 @@
 #include <linux/ns_common.h>
 #include <linux/refcount.h>
 #include <linux/rhashtable-types.h>
+#include <linux/sysctl.h>
 
 struct user_namespace;
 
@@ -67,6 +68,11 @@ struct ipc_namespace {
 	struct user_namespace *user_ns;
 	struct ucounts *ucounts;
 
+#ifdef CONFIG_POSIX_MQUEUE_SYSCTL
+	struct ctl_table_set	mq_set;
+	struct ctl_table_header	*sysctls;
+#endif
+
 	struct llist_node mnt_llist;
 
 	struct ns_common ns;
@@ -155,7 +161,10 @@ static inline void put_ipc_ns(struct ipc_namespace *ns)
 #ifdef CONFIG_POSIX_MQUEUE_SYSCTL
 
 struct ctl_table_header;
+extern struct ctl_table_header *mq_sysctl_table;
 extern struct ctl_table_header *mq_register_sysctl_table(void);
+bool setup_mq_sysctls(struct ipc_namespace *ns);
+void retire_mq_sysctls(struct ipc_namespace *ns);
 
 #else /* CONFIG_POSIX_MQUEUE_SYSCTL */
 
@@ -163,6 +172,11 @@ static inline struct ctl_table_header *mq_register_sysctl_table(void)
 {
 	return NULL;
 }
+static inline bool setup_mq_sysctls(struct ipc_namespace *ns)
+{
+	return true;
+}
+static inline void retire_mq_sysctls(struct ipc_namespace *ns) { }
 
 #endif /* CONFIG_POSIX_MQUEUE_SYSCTL */
 #endif
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 72a92a0..8d6b8ff 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -8,6 +8,11 @@
 #include <linux/nsproxy.h>
 #include <linux/ipc_namespace.h>
 #include <linux/sysctl.h>
+#include <linux/slab.h>
+#include <linux/user_namespace.h>
+#include <linux/capability.h>
+#include <linux/cred.h>
+#include <linux/stat.h>
 
 #ifdef CONFIG_PROC_SYSCTL
 static void *get_mq(struct ctl_table *table)
@@ -96,25 +101,106 @@ static struct ctl_table mq_sysctls[] = {
 	{}
 };
 
-static struct ctl_table mq_sysctl_dir[] = {
-	{
-		.procname	= "mqueue",
-		.mode		= 0555,
-		.child		= mq_sysctls,
-	},
-	{}
-};
+static int set_is_seen(struct ctl_table_set *set)
+{
+	return &current->nsproxy->ipc_ns->mq_set == set;
+}
 
-static struct ctl_table mq_sysctl_root[] = {
-	{
-		.procname	= "fs",
-		.mode		= 0555,
-		.child		= mq_sysctl_dir,
-	},
-	{}
+static struct ctl_table_set *
+set_lookup(struct ctl_table_root *root)
+{
+	return &current->nsproxy->ipc_ns->mq_set;
+}
+
+static int set_permissions(struct ctl_table_header *head,
+				struct ctl_table *table)
+{
+	struct ipc_namespace *ipc_ns =
+		container_of(head->set, struct ipc_namespace, mq_set);
+	struct user_namespace *user_ns = ipc_ns->user_ns;
+	int mode;
+
+	/* Allow users with CAP_SYS_RESOURCE unrestrained access */
+	if (ns_capable(user_ns, CAP_SYS_RESOURCE))
+		mode = (table->mode & S_IRWXU) >> 6;
+	else {
+		/* Allow all others at most read-only access */
+		mode = table->mode & S_IROTH;
+	}
+
+	return (mode << 6) | (mode << 3) | mode;
+}
+
+static void set_ownership(struct ctl_table_header *head,
+				struct ctl_table *table,
+				kuid_t *uid, kgid_t *gid)
+{
+	struct ipc_namespace *ipc_ns =
+		container_of(head->set, struct ipc_namespace, mq_set);
+	struct user_namespace *user_ns = ipc_ns->user_ns;
+	kuid_t ns_root_uid;
+	kgid_t ns_root_gid;
+
+	ns_root_uid = make_kuid(user_ns, 0);
+	if (uid_valid(ns_root_uid))
+		*uid = ns_root_uid;
+
+	ns_root_gid = make_kgid(user_ns, 0);
+	if (gid_valid(ns_root_gid))
+		*gid = ns_root_gid;
+}
+
+static struct ctl_table_root mq_sysctl_root = {
+	.lookup = set_lookup,
+	.permissions = set_permissions,
+	.set_ownership = set_ownership,
 };
 
+bool setup_mq_sysctls(struct ipc_namespace *ns)
+{
+	struct ctl_table *tbl;
+
+	if (!mq_sysctl_table)
+		return false;
+
+	setup_sysctl_set(&ns->mq_set, &mq_sysctl_root, set_is_seen);
+	tbl = kmemdup(mq_sysctls, sizeof(mq_sysctls), GFP_KERNEL);
+	if (!tbl)
+		goto out;
+
+	ns->sysctls = __register_sysctl_table(&ns->mq_set, "fs/mqueue", tbl);
+	if (!ns->sysctls)
+		goto out1;
+
+	return true;
+
+out1:
+	kfree(tbl);
+	retire_sysctl_set(&ns->mq_set);
+out:
+	return false;
+}
+
+void retire_mq_sysctls(struct ipc_namespace *ns)
+{
+	struct ctl_table *tbl;
+
+	if (!ns->sysctls)
+		return;
+
+	tbl = ns->sysctls->ctl_table_arg;
+	unregister_sysctl_table(ns->sysctls);
+	retire_sysctl_set(&ns->mq_set);
+	kfree(tbl);
+}
+
 struct ctl_table_header *mq_register_sysctl_table(void)
 {
-	return register_sysctl_table(mq_sysctl_root);
+	static struct ctl_table empty[1];
+
+	/*
+	 * Register the fs/mqueue directory in the default set so that
+	 * registrations in the child sets work properly.
+	 */
+	return register_sysctl("fs/mqueue", empty);
 }
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4e4e611..3b68564 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -163,7 +163,7 @@ static void remove_notification(struct mqueue_inode_info *info);
 
 static struct kmem_cache *mqueue_inode_cachep;
 
-static struct ctl_table_header *mq_sysctl_table;
+struct ctl_table_header *mq_sysctl_table;
 
 static inline struct mqueue_inode_info *MQUEUE_I(struct inode *inode)
 {
@@ -1713,6 +1713,10 @@ static int __init init_mqueue_fs(void)
 
 	/* ignore failures - they are not fatal */
 	mq_sysctl_table = mq_register_sysctl_table();
+	if (mq_sysctl_table && !setup_mq_sysctls(&init_ipc_ns)) {
+		unregister_sysctl_table(mq_sysctl_table);
+		mq_sysctl_table = NULL;
+	}
 
 	error = register_filesystem(&mqueue_fs_type);
 	if (error)
@@ -1729,8 +1733,10 @@ static int __init init_mqueue_fs(void)
 out_filesystem:
 	unregister_filesystem(&mqueue_fs_type);
 out_sysctl:
-	if (mq_sysctl_table)
+	if (mq_sysctl_table) {
+		retire_mq_sysctls(&init_ipc_ns);
 		unregister_sysctl_table(mq_sysctl_table);
+	}
 	kmem_cache_destroy(mqueue_inode_cachep);
 	return error;
 }
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 7bd0766..c891cc1 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -58,6 +58,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 	err = mq_init_ns(ns);
 	if (err)
 		goto fail_put;
+	setup_mq_sysctls(ns);
 
 	sem_init_ns(ns);
 	msg_init_ns(ns);
@@ -121,6 +122,7 @@ static void free_ipc_ns(struct ipc_namespace *ns)
 	 * uses synchronize_rcu().
 	 */
 	mq_put_mnt(ns);
+	retire_mq_sysctls(ns);
 	sem_exit_ns(ns);
 	msg_exit_ns(ns);
 	shm_exit_ns(ns);
-- 
2.15.2

