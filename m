Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85E3D9BFC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 05:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbhG2DGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 23:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbhG2DGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 23:06:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91386C061757
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 20:06:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso13358576pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jul 2021 20:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpErClwOanUU4e0v/IsqMs2/3aPGXDMvTtamo8TZTII=;
        b=l1ee9REmEqef9Prf3k3j0Ye3gzadCVGjzl7bz8bvWWVrHzD4KJyZ7N+8hsJypbGIl2
         Cx0eKO9eBOULrYUD1M/StC9AWMOeyGGTnEU9rdA35qasR7vZ0tj6EvDi8ff8zBfLZ07T
         AZ6cRTC4iygrTsrV/JZOBtlDnIFe+bM6KnJtVWreNR4L/c4MHaxiwEas/D/TDyZTfBxB
         xSiRd+c7YKAcsXKjyEoVSOQQMEPWcjTgVah5MDq4Z7gIVWqaGCB64GWlz31kbv4By9ww
         YiD0Lodva3CuVlXQXqKp4YRgrZL1MdKnRDXCmwY/6JIow6uWMmVdIfzBkiTzzJUmEo09
         u7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lpErClwOanUU4e0v/IsqMs2/3aPGXDMvTtamo8TZTII=;
        b=Zfl3Pr8VN7ibPiDfWFJhfuCkVKNtD9KRyjHTVpCkN99MHNSKfavKo/KpNUw1JbT3w4
         QldJZqBroW3Od9f6VxSTTIobOEvuHgWDqABYBfAjjjNZfH7M/fDh9SxVfiVkUvqUWQHz
         Np0DD/Ms2iGhcXEyWK8usoFXE/GAmSmF2V79FiL5EQAKMpl0Oqkgp8kDjkDFoUMX+0Hu
         H0jc7mj7D7TvFbTEHCMIW9sTEnLWRUriirwJEdsEskiFZsRmWFNn4Y7qLA+1QVDdlw8g
         kssZjQVvblxEuhKQiiSd2FwzVgWe3+d2gKGvRLxPBAU2R/ZaQ/0CNT5Kbs7J9Mc00vbB
         8Kgw==
X-Gm-Message-State: AOAM531KzfkiQpKWKw8XvsIVyoKv2r79EXb4FlOIYGY81tw0+a0siE8s
        YGn8ESKwG8EY7eLOerhWvls=
X-Google-Smtp-Source: ABdhPJxKu6ibq6UPNa3kQXEYiBbeLkHEmLpTUalLfVazf5i2kc1OTh1UUps3EFSpjIA48tF6lZF75w==
X-Received: by 2002:a17:90a:154e:: with SMTP id y14mr2938224pja.184.1627527970982;
        Wed, 28 Jul 2021 20:06:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 37sm1529404pgt.28.2021.07.28.20.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 20:06:10 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.xiaokai@zte.com.cn
To:     keescook@chromium.org, christian.brauner@ubuntu.com,
        ktkhai@virtuozzo.com, jamorris@linux.microsoft.com,
        varad.gautam@suse.com, legion@kernel.org, dbueso@suse.de
Cc:     linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: [PATCH] ipc: add set_ownership() and permissions() callbacks for posix mqueue sysctl
Date:   Wed, 28 Jul 2021 20:06:51 -0700
Message-Id: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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
rights to the ipc namespace resources.

$ id
uid=1200(u1200) gid=1200(u1200) groups=1200(u1200)
$ unshare -Ur -i
$ id
uid=0(root) gid=0(root) groups=0(root)
$ ls -l /proc/sys/fs/mqueue/
total 0
-rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msg_default
-rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msg_max
-rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msgsize_default
-rw-r--r-- 1 65534 65534 0 Jul 28 19:03 msgsize_max
-rw-r--r-- 1 65534 65534 0 Jul 28 19:03 queues_max
-sh: /proc/sys/fs/mqueue/msg_max: Permission denied

As opposite, inside a net namespace,
1. sysctl files owners are set to the local root user
   insede the user namespace, not the GLOBAL_ROOT_UID;
2. sysctl files are writable when accessed by root user
   inside the user namespace.

$ id
uid=1200(u1200) gid=1200(u1200) groups=1200(u1200)
$ unshare -Ur -n
$ id
uid=0(root) gid=0(root) groups=0(root)
$ ls -l /proc/sys/net/ipv4/ip_forward
-rw-r--r-- 1 root root 0 Jul 28 19:04 /proc/sys/net/ipv4/ip_forward
$ echo 1 > /proc/sys/net/ipv4/ip_forward
$ cat /proc/sys/net/ipv4/ip_forward
1

This patch adds a ctl_table_set per ipc namespace, and also the
set_ownership() and permissions() callbacks for the new ctl_table_root
for ipc mqueue syscgtls.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
---
 include/linux/ipc_namespace.h |  14 +++++
 ipc/mq_sysctl.c               | 116 ++++++++++++++++++++++++++++++++++++------
 ipc/mqueue.c                  |  10 +++-
 ipc/namespace.c               |   2 +
 4 files changed, 124 insertions(+), 18 deletions(-)

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
index 72a92a0..dbdd428 100644
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
@@ -96,25 +101,104 @@ static struct ctl_table mq_sysctls[] = {
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
+	else
+	/* Allow all others at most read-only access */
+		mode = table->mode & S_IROTH;
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


