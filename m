Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38063D6E20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 07:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbhG0FeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 01:34:18 -0400
Received: from relay.sw.ru ([185.231.240.75]:40228 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235366AbhG0FeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 01:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=UU0ihg9gpIU2ETIEEVHf9ojIMqYJGQmgGhH1Q5hbf5E=; b=xV3EVqrAVgX8lwBDqLS
        2kB1Pw/2Obz42IJs7oUuOqWX8N1tMlT78KThukP7tX8jA4Z3aZkFcKF4VmkZ/pKRhIettk+N3hixt
        XcLg0/H9/X3pw31glKtUzsw/51UxdgdW7wOuVUM2Q3DQcsHfMQpGjDiaQI0W/JKqKyXd2vvnnu4=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1m8Fin-005LXo-1Y; Tue, 27 Jul 2021 08:33:41 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH v7 05/10] memcg: enable accounting for new namesapces and
 struct nsproxy
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Roman Gushchin <guro@fb.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
References: <6f21a0e0-bd36-b6be-1ffa-0dc86c06c470@virtuozzo.com>
 <cover.1627362057.git.vvs@virtuozzo.com>
Message-ID: <5525bcbf-533e-da27-79b7-158686c64e13@virtuozzo.com>
Date:   Tue, 27 Jul 2021 08:33:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1627362057.git.vvs@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Container admin can create new namespaces and force kernel to allocate
up to several pages of memory for the namespaces and its associated
structures.
Net and uts namespaces have enabled accounting for such allocations.
It makes sense to account for rest ones to restrict the host's memory
consumption from inside the memcg-limited container.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/namespace.c            | 2 +-
 ipc/namespace.c           | 2 +-
 kernel/cgroup/namespace.c | 2 +-
 kernel/nsproxy.c          | 2 +-
 kernel/pid_namespace.c    | 2 +-
 kernel/time/namespace.c   | 4 ++--
 kernel/user_namespace.c   | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c6a74e5..e443ee6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3289,7 +3289,7 @@ static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *user_ns, bool a
 	if (!ucounts)
 		return ERR_PTR(-ENOSPC);
 
-	new_ns = kzalloc(sizeof(struct mnt_namespace), GFP_KERNEL);
+	new_ns = kzalloc(sizeof(struct mnt_namespace), GFP_KERNEL_ACCOUNT);
 	if (!new_ns) {
 		dec_mnt_namespaces(ucounts);
 		return ERR_PTR(-ENOMEM);
diff --git a/ipc/namespace.c b/ipc/namespace.c
index 7bd0766..ae83f0f 100644
--- a/ipc/namespace.c
+++ b/ipc/namespace.c
@@ -42,7 +42,7 @@ static struct ipc_namespace *create_ipc_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = kzalloc(sizeof(struct ipc_namespace), GFP_KERNEL);
+	ns = kzalloc(sizeof(struct ipc_namespace), GFP_KERNEL_ACCOUNT);
 	if (ns == NULL)
 		goto fail_dec;
 
diff --git a/kernel/cgroup/namespace.c b/kernel/cgroup/namespace.c
index f5e8828..0d5c298 100644
--- a/kernel/cgroup/namespace.c
+++ b/kernel/cgroup/namespace.c
@@ -24,7 +24,7 @@ static struct cgroup_namespace *alloc_cgroup_ns(void)
 	struct cgroup_namespace *new_ns;
 	int ret;
 
-	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL);
+	new_ns = kzalloc(sizeof(struct cgroup_namespace), GFP_KERNEL_ACCOUNT);
 	if (!new_ns)
 		return ERR_PTR(-ENOMEM);
 	ret = ns_alloc_inum(&new_ns->ns);
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index abc01fc..eec72ca 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -568,6 +568,6 @@ static void commit_nsset(struct nsset *nsset)
 
 int __init nsproxy_cache_init(void)
 {
-	nsproxy_cachep = KMEM_CACHE(nsproxy, SLAB_PANIC);
+	nsproxy_cachep = KMEM_CACHE(nsproxy, SLAB_PANIC|SLAB_ACCOUNT);
 	return 0;
 }
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index ca43239..6cd6715 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -449,7 +449,7 @@ static struct user_namespace *pidns_owner(struct ns_common *ns)
 
 static __init int pid_namespaces_init(void)
 {
-	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC);
+	pid_ns_cachep = KMEM_CACHE(pid_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
 	register_sysctl_paths(kern_path, pid_ns_ctl_table);
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 12eab0d..aec8328 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -88,13 +88,13 @@ static struct time_namespace *clone_time_ns(struct user_namespace *user_ns,
 		goto fail;
 
 	err = -ENOMEM;
-	ns = kmalloc(sizeof(*ns), GFP_KERNEL);
+	ns = kmalloc(sizeof(*ns), GFP_KERNEL_ACCOUNT);
 	if (!ns)
 		goto fail_dec;
 
 	refcount_set(&ns->ns.count, 1);
 
-	ns->vvar_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+	ns->vvar_page = alloc_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (!ns->vvar_page)
 		goto fail_free;
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index ef82d40..6b2e3ca 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1385,7 +1385,7 @@ static struct user_namespace *userns_owner(struct ns_common *ns)
 
 static __init int user_namespaces_init(void)
 {
-	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC);
+	user_ns_cachep = KMEM_CACHE(user_namespace, SLAB_PANIC | SLAB_ACCOUNT);
 	return 0;
 }
 subsys_initcall(user_namespaces_init);
-- 
1.8.3.1

