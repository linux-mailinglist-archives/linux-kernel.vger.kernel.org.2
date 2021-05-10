Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1274378E15
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240436AbhEJNEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350788AbhEJNB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620651622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59WvXkKWK9TiJShcfi5MfmltJqzgcioqs35N1ygEid0=;
        b=cnQGAdULDKx6oG24sd/pXm22Iyo0w5VZLb6U5WhGOVBoBlZeZU4EP6UgfFFvW1LJ/dzVOh
        qZ8qzIopWAJi01kU6+vPUK1519umS5ohP5QpqMcOUVi9HN5xasd0I0KKA2R8dlsqsADyfS
        CSxPsqzkv0yOim+zxUuTSEcY5SPTsEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-tkfmdDkSO8idJaVnnaoFlg-1; Mon, 10 May 2021 09:00:20 -0400
X-MC-Unique: tkfmdDkSO8idJaVnnaoFlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943741009600;
        Mon, 10 May 2021 13:00:19 +0000 (UTC)
Received: from lithium.homenet.telecomitalia.it (ovpn-115-83.ams2.redhat.com [10.36.115.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C8AB9F64;
        Mon, 10 May 2021 13:00:16 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, dwalsh@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com
Subject: [RFC PATCH 1/3] setgroups: new mode 'shadow' for /proc/PID/setgroups
Date:   Mon, 10 May 2021 15:00:09 +0200
Message-Id: <20210510130011.1441834-2-gscrivan@redhat.com>
In-Reply-To: <20210510130011.1441834-1-gscrivan@redhat.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add a new mode 'shadow' to the /proc/PID/setgroups file.

When the 'shadow' string is written to the file, the current process
groups are inherited from the process and stored into the user
namespace.  These groups will be silently added on each setgroups(2)
call.  A child user namespace won't be able to drop these groups
anymore.

It enables using setgroups(2) in user namespaces on systems where
negative ACLs are used.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 include/linux/cred.h           |  4 ++-
 include/linux/user_namespace.h | 11 +++++--
 kernel/groups.c                | 60 +++++++++++++++++++++++++---------
 kernel/uid16.c                 | 38 ++++++++++++++++-----
 kernel/user_namespace.c        | 34 +++++++++++++++----
 5 files changed, 114 insertions(+), 33 deletions(-)

diff --git a/include/linux/cred.h b/include/linux/cred.h
index 14971322e1a0..f3e631293532 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -63,7 +63,9 @@ extern int groups_search(const struct group_info *, kgid_t);
 
 extern int set_current_groups(struct group_info *);
 extern void set_groups(struct cred *, struct group_info *);
-extern bool may_setgroups(void);
+extern bool may_setgroups(struct group_info **shadowed_groups);
+extern void add_shadowed_groups(struct group_info *group_info,
+				struct group_info *shadowed);
 extern void groups_sort(struct group_info *);
 #else
 static inline void groups_free(struct group_info *group_info)
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 1d08dbbcfe32..cb003172de20 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -32,6 +32,7 @@ struct uid_gid_map { /* 64 bytes -- 1 cache line */
 };
 
 #define USERNS_SETGROUPS_ALLOWED 1UL
+#define USERNS_SETGROUPS_SHADOW  2UL
 
 #define USERNS_INIT_FLAGS USERNS_SETGROUPS_ALLOWED
 
@@ -93,6 +94,9 @@ struct user_namespace {
 #endif
 	struct ucounts		*ucounts;
 	int ucount_max[UCOUNT_COUNTS];
+
+	/* Supplementary groups when setgroups "shadow" mode is enabled.   */
+	struct group_info *shadow_group_info;
 } __randomize_layout;
 
 struct ucounts {
@@ -138,7 +142,8 @@ extern ssize_t proc_gid_map_write(struct file *, const char __user *, size_t, lo
 extern ssize_t proc_projid_map_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t proc_setgroups_write(struct file *, const char __user *, size_t, loff_t *);
 extern int proc_setgroups_show(struct seq_file *m, void *v);
-extern bool userns_may_setgroups(const struct user_namespace *ns);
+extern bool userns_may_setgroups(const struct user_namespace *ns,
+				 struct group_info **shadowed_groups);
 extern bool in_userns(const struct user_namespace *ancestor,
 		       const struct user_namespace *child);
 extern bool current_in_userns(const struct user_namespace *target_ns);
@@ -167,8 +172,10 @@ static inline void put_user_ns(struct user_namespace *ns)
 {
 }
 
-static inline bool userns_may_setgroups(const struct user_namespace *ns)
+static inline bool userns_may_setgroups(const struct user_namespace *ns,
+					struct group_info **shadowed_groups)
 {
+	*shadowed_groups = NULL;
 	return true;
 }
 
diff --git a/kernel/groups.c b/kernel/groups.c
index 787b381c7c00..f0c3b49da19e 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -52,11 +52,10 @@ static int groups_to_user(gid_t __user *grouplist,
 
 /* fill a group_info from a user-space array - it must be allocated already */
 static int groups_from_user(struct group_info *group_info,
-    gid_t __user *grouplist)
+			    gid_t __user *grouplist, int count)
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int i;
-	unsigned int count = group_info->ngroups;
 
 	for (i = 0; i < count; i++) {
 		gid_t gid;
@@ -169,12 +168,24 @@ SYSCALL_DEFINE2(getgroups, int, gidsetsize, gid_t __user *, grouplist)
 	return i;
 }
 
-bool may_setgroups(void)
+bool may_setgroups(struct group_info **shadowed_groups)
 {
 	struct user_namespace *user_ns = current_user_ns();
 
 	return ns_capable_setid(user_ns, CAP_SETGID) &&
-		userns_may_setgroups(user_ns);
+		userns_may_setgroups(user_ns, shadowed_groups);
+}
+
+void add_shadowed_groups(struct group_info *group_info, struct group_info *shadowed)
+{
+	int i, j;
+
+	for (i = 0; i < shadowed->ngroups; i++) {
+		kgid_t kgid = shadowed->gid[i];
+
+		j = group_info->ngroups - i - 1;
+		group_info->gid[j] = kgid;
+	}
 }
 
 /*
@@ -184,27 +195,44 @@ bool may_setgroups(void)
 
 SYSCALL_DEFINE2(setgroups, int, gidsetsize, gid_t __user *, grouplist)
 {
-	struct group_info *group_info;
+	struct group_info *shadowed_groups = NULL;
+	struct group_info *group_info = NULL;
+	unsigned int arraysize = gidsetsize;
 	int retval;
 
-	if (!may_setgroups())
-		return -EPERM;
-	if ((unsigned)gidsetsize > NGROUPS_MAX)
+	if (arraysize > NGROUPS_MAX)
 		return -EINVAL;
 
-	group_info = groups_alloc(gidsetsize);
-	if (!group_info)
-		return -ENOMEM;
-	retval = groups_from_user(group_info, grouplist);
-	if (retval) {
-		put_group_info(group_info);
-		return retval;
+	if (!may_setgroups(&shadowed_groups))
+		return -EPERM;
+
+	if (shadowed_groups) {
+		retval = -EINVAL;
+		if (shadowed_groups->ngroups + gidsetsize > NGROUPS_MAX)
+			goto out;
+		arraysize += shadowed_groups->ngroups;
 	}
 
+	group_info = groups_alloc(arraysize);
+	retval = -ENOMEM;
+	if (!group_info)
+		goto out;
+
+	retval = groups_from_user(group_info, grouplist, gidsetsize);
+	if (retval)
+		goto out;
+
+	if (shadowed_groups)
+		add_shadowed_groups(group_info, shadowed_groups);
+
 	groups_sort(group_info);
 	retval = set_current_groups(group_info);
-	put_group_info(group_info);
 
+out:
+	if (group_info)
+		put_group_info(group_info);
+	if (shadowed_groups)
+		put_group_info(shadowed_groups);
 	return retval;
 }
 
diff --git a/kernel/uid16.c b/kernel/uid16.c
index af6925d8599b..cb1110f083ce 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -130,14 +130,14 @@ static int groups16_to_user(old_gid_t __user *grouplist,
 }
 
 static int groups16_from_user(struct group_info *group_info,
-    old_gid_t __user *grouplist)
+			      old_gid_t __user *grouplist, int count)
 {
 	struct user_namespace *user_ns = current_user_ns();
 	int i;
 	old_gid_t group;
 	kgid_t kgid;
 
-	for (i = 0; i < group_info->ngroups; i++) {
+	for (i = 0; i < count; i++) {
 		if (get_user(group, grouplist+i))
 			return  -EFAULT;
 
@@ -177,25 +177,47 @@ SYSCALL_DEFINE2(getgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
 SYSCALL_DEFINE2(setgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
 {
 	struct group_info *group_info;
+	struct group_info *shadowed_groups = NULL;
 	int retval;
+	unsigned int arraysize = gidsetsize;
 
-	if (!may_setgroups())
-		return -EPERM;
-	if ((unsigned)gidsetsize > NGROUPS_MAX)
+	if (arraysize > NGROUPS_MAX)
 		return -EINVAL;
 
-	group_info = groups_alloc(gidsetsize);
-	if (!group_info)
+	if (!may_setgroups(&shadowed_groups))
+		return -EPERM;
+
+	if (shadowed_groups) {
+		if (shadowed_groups->ngroups + gidsetsize > NGROUPS_MAX) {
+			put_group_info(shadowed_groups);
+			return -EINVAL;
+		}
+		arraysize += shadowed_groups->ngroups;
+	}
+
+	group_info = groups_alloc(arraysize);
+	if (!group_info) {
+		if (shadowed_groups)
+			put_group_info(shadowed_groups);
 		return -ENOMEM;
-	retval = groups16_from_user(group_info, grouplist);
+	}
+
+	retval = groups16_from_user(group_info, grouplist, gidsetsize);
 	if (retval) {
+		if (shadowed_groups)
+			put_group_info(shadowed_groups);
 		put_group_info(group_info);
 		return retval;
 	}
 
+	if (shadowed_groups)
+		add_shadowed_groups(group_info, shadowed_groups);
+
 	groups_sort(group_info);
 	retval = set_current_groups(group_info);
 	put_group_info(group_info);
+	if (shadowed_groups)
+		put_group_info(shadowed_groups);
 
 	return retval;
 }
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 8d62863721b0..b1940b63f7ac 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -123,6 +123,7 @@ int create_user_ns(struct cred *new)
 		ns->ucount_max[i] = INT_MAX;
 	}
 	ns->ucounts = ucounts;
+	ns->shadow_group_info = get_current_groups();
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
 	mutex_lock(&userns_state_mutex);
@@ -177,6 +178,9 @@ static void free_user_ns(struct work_struct *work)
 	struct user_namespace *parent, *ns =
 		container_of(work, struct user_namespace, work);
 
+	if (ns->shadow_group_info)
+		put_group_info(ns->shadow_group_info);
+
 	do {
 		struct ucounts *ucounts = ns->ucounts;
 		parent = ns->parent;
@@ -1185,7 +1189,8 @@ int proc_setgroups_show(struct seq_file *seq, void *v)
 
 	seq_printf(seq, "%s\n",
 		   (userns_flags & USERNS_SETGROUPS_ALLOWED) ?
-		   "allow" : "deny");
+		   ((userns_flags & USERNS_SETGROUPS_SHADOW) ? "shadow" : "allow")
+		   : "deny");
 	return 0;
 }
 
@@ -1196,6 +1201,7 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	struct user_namespace *ns = seq->private;
 	char kbuf[8], *pos;
 	bool setgroups_allowed;
+	bool setgroups_shadow = false;
 	ssize_t ret;
 
 	/* Only allow a very narrow range of strings to be written */
@@ -1215,12 +1221,14 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	if (strncmp(pos, "allow", 5) == 0) {
 		pos += 5;
 		setgroups_allowed = true;
-	}
-	else if (strncmp(pos, "deny", 4) == 0) {
+	} else if (strncmp(pos, "shadow", 6) == 0) {
+		pos += 6;
+		setgroups_allowed = true;
+		setgroups_shadow = true;
+	} else if (strncmp(pos, "deny", 4) == 0) {
 		pos += 4;
 		setgroups_allowed = false;
-	}
-	else
+	} else
 		goto out;
 
 	/* Verify there is not trailing junk on the line */
@@ -1236,6 +1244,13 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 		 */
 		if (!(ns->flags & USERNS_SETGROUPS_ALLOWED))
 			goto out_unlock;
+
+		if (setgroups_shadow)
+			ns->flags |= USERNS_SETGROUPS_SHADOW;
+		else {
+			put_group_info(ns->shadow_group_info);
+			ns->shadow_group_info = NULL;
+		}
 	} else {
 		/* Permanently disabling setgroups after setgroups has
 		 * been enabled by writing the gid_map is not allowed.
@@ -1256,9 +1271,11 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 	goto out;
 }
 
-bool userns_may_setgroups(const struct user_namespace *ns)
+bool userns_may_setgroups(const struct user_namespace *ns,
+			 struct group_info **shadowed_groups)
 {
 	bool allowed;
+	struct group_info *shadowed = NULL;
 
 	mutex_lock(&userns_state_mutex);
 	/* It is not safe to use setgroups until a gid mapping in
@@ -1267,8 +1284,13 @@ bool userns_may_setgroups(const struct user_namespace *ns)
 	allowed = ns->gid_map.nr_extents != 0;
 	/* Is setgroups allowed? */
 	allowed = allowed && (ns->flags & USERNS_SETGROUPS_ALLOWED);
+	if (allowed && (ns->flags & USERNS_SETGROUPS_SHADOW))
+		shadowed = get_group_info(ns->shadow_group_info);
+
 	mutex_unlock(&userns_state_mutex);
 
+	*shadowed_groups = shadowed;
+
 	return allowed;
 }
 
-- 
2.31.1

