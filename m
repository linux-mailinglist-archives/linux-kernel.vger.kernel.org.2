Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A257D378E1B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351267AbhEJNFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 09:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350814AbhEJNBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 09:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620651631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qYJxIj3byUuRfvoDwZxiPqSPDM85oniejzPazMGcaYc=;
        b=RkC4jKzyt8Wt09Wa3ReD71zDL0zrO6OGvAayvoq1tczOp8Vi3ysZz+ozSZxpqZelMWlr0i
        +6oDMW03u1edBjsCIo0yRwnYA0nvz/oc95BV01Swuxfdlh+zIN8IXcC2YmVSr8jywH0By1
        +LWZnbofJXy+KCTjtgZJO/ewy/A9JHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-t8T9_VgtNmieHN64DMH8Zg-1; Mon, 10 May 2021 09:00:29 -0400
X-MC-Unique: t8T9_VgtNmieHN64DMH8Zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8E485107ACFB;
        Mon, 10 May 2021 13:00:28 +0000 (UTC)
Received: from lithium.homenet.telecomitalia.it (ovpn-115-83.ams2.redhat.com [10.36.115.83])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0321F60FC2;
        Mon, 10 May 2021 13:00:19 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     serge@hallyn.com, dwalsh@redhat.com, christian.brauner@ubuntu.com,
        ebiederm@xmission.com
Subject: [RFC PATCH 2/3] getgroups: hide unknown groups
Date:   Mon, 10 May 2021 15:00:10 +0200
Message-Id: <20210510130011.1441834-3-gscrivan@redhat.com>
In-Reply-To: <20210510130011.1441834-1-gscrivan@redhat.com>
References: <20210510130011.1441834-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do not copy to userspace the groups that are not known in the
namespace.

Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
---
 kernel/groups.c | 40 +++++++++++++++++++--------------------
 kernel/uid16.c  | 50 ++++++++++++++++++++++++-------------------------
 2 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/kernel/groups.c b/kernel/groups.c
index f0c3b49da19e..97fa9faa7813 100644
--- a/kernel/groups.c
+++ b/kernel/groups.c
@@ -35,19 +35,30 @@ EXPORT_SYMBOL(groups_free);
 
 /* export the group_info to a user-space array */
 static int groups_to_user(gid_t __user *grouplist,
-			  const struct group_info *group_info)
+			  const struct group_info *group_info,
+			  int gidsetsize)
 {
 	struct user_namespace *user_ns = current_user_ns();
-	int i;
 	unsigned int count = group_info->ngroups;
+	int i, ngroups = 0;
 
 	for (i = 0; i < count; i++) {
 		gid_t gid;
-		gid = from_kgid_munged(user_ns, group_info->gid[i]);
-		if (put_user(gid, grouplist+i))
-			return -EFAULT;
+		gid = from_kgid(user_ns, group_info->gid[i]);
+		if (gid == (gid_t)-1) {
+			if (user_ns->flags & USERNS_SETGROUPS_SHADOW)
+				continue;
+			gid = overflowgid;
+		}
+		if (gidsetsize) {
+			if (ngroups == gidsetsize)
+				return -EINVAL;
+			if (put_user(gid, grouplist + ngroups))
+				return -EFAULT;
+		}
+		ngroups++;
 	}
-	return 0;
+	return ngroups;
 }
 
 /* fill a group_info from a user-space array - it must be allocated already */
@@ -146,26 +157,13 @@ EXPORT_SYMBOL(set_current_groups);
 
 SYSCALL_DEFINE2(getgroups, int, gidsetsize, gid_t __user *, grouplist)
 {
+	/* no need to grab task_lock here; it cannot change */
 	const struct cred *cred = current_cred();
-	int i;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
 
-	/* no need to grab task_lock here; it cannot change */
-	i = cred->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize) {
-			i = -EINVAL;
-			goto out;
-		}
-		if (groups_to_user(grouplist, cred->group_info)) {
-			i = -EFAULT;
-			goto out;
-		}
-	}
-out:
-	return i;
+	return groups_to_user(grouplist, cred->group_info, gidsetsize);
 }
 
 bool may_setgroups(struct group_info **shadowed_groups)
diff --git a/kernel/uid16.c b/kernel/uid16.c
index cb1110f083ce..6f2dc793b5f8 100644
--- a/kernel/uid16.c
+++ b/kernel/uid16.c
@@ -112,21 +112,33 @@ SYSCALL_DEFINE1(setfsgid16, old_gid_t, gid)
 }
 
 static int groups16_to_user(old_gid_t __user *grouplist,
-    struct group_info *group_info)
+			    struct group_info *group_info,
+			    int gidsetsize)
 {
 	struct user_namespace *user_ns = current_user_ns();
-	int i;
-	old_gid_t group;
-	kgid_t kgid;
+	unsigned int count = group_info->ngroups;
+	int i, ngroups = 0;
 
-	for (i = 0; i < group_info->ngroups; i++) {
-		kgid = group_info->gid[i];
-		group = high2lowgid(from_kgid_munged(user_ns, kgid));
-		if (put_user(group, grouplist+i))
-			return -EFAULT;
+	for (i = 0; i < count; i++) {
+		gid_t gid;
+		old_gid_t group;
+
+		gid = from_kgid(user_ns, group_info->gid[i]);
+		if (gid == (gid_t)-1) {
+			if (user_ns->flags & USERNS_SETGROUPS_SHADOW)
+				continue;
+			gid = overflowgid;
+		}
+		group = high2lowgid(gid);
+		if (gidsetsize) {
+			if (ngroups == gidsetsize)
+				return -EINVAL;
+			if (put_user(group, grouplist + ngroups))
+				return -EFAULT;
+		}
+		ngroups++;
 	}
-
-	return 0;
+	return ngroups;
 }
 
 static int groups16_from_user(struct group_info *group_info,
@@ -153,25 +165,13 @@ static int groups16_from_user(struct group_info *group_info,
 
 SYSCALL_DEFINE2(getgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
 {
+	/* no need to grab task_lock here; it cannot change */
 	const struct cred *cred = current_cred();
-	int i;
 
 	if (gidsetsize < 0)
 		return -EINVAL;
 
-	i = cred->group_info->ngroups;
-	if (gidsetsize) {
-		if (i > gidsetsize) {
-			i = -EINVAL;
-			goto out;
-		}
-		if (groups16_to_user(grouplist, cred->group_info)) {
-			i = -EFAULT;
-			goto out;
-		}
-	}
-out:
-	return i;
+	return groups16_to_user(grouplist, cred->group_info, gidsetsize);
 }
 
 SYSCALL_DEFINE2(setgroups16, int, gidsetsize, old_gid_t __user *, grouplist)
-- 
2.31.1

