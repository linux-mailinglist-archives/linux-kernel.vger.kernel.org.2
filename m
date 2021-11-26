Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D545F008
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 15:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377859AbhKZOmy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Nov 2021 09:42:54 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:57126 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353906AbhKZOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 09:40:52 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-jANhLnqkPPyCQMEiZnipkw-1; Fri, 26 Nov 2021 09:37:37 -0500
X-MC-Unique: jANhLnqkPPyCQMEiZnipkw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 435DE102CB77;
        Fri, 26 Nov 2021 14:37:36 +0000 (UTC)
Received: from comp-core-i7-2640m-0182e6.redhat.com (unknown [10.36.110.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4454D60C04;
        Fri, 26 Nov 2021 14:37:35 +0000 (UTC)
From:   Alexey Gladkov <legion@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>
Subject: [PATCH v1 2/2] ucounts: Move rlimit max values from ucounts max
Date:   Fri, 26 Nov 2021 15:37:27 +0100
Message-Id: <bcc85eae4f5e3799f9efdf2d73572bb88616ebac.1637934917.git.legion@kernel.org>
In-Reply-To: <cover.1637934917.git.legion@kernel.org>
References: <cover.1637934917.git.legion@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=legion@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the semantics of maximum rlimit values are different, they need to
be separated from ucount_max. This will prevent the error of using
inc_count/dec_ucount for rlimit parameters.

This patch also renames the functions to emphasize the lack of
connection between rlimit_max and ucount_max.

Signed-off-by: Alexey Gladkov <legion@kernel.org>
---
 include/linux/user_namespace.h | 13 ++++++++++---
 kernel/fork.c                  |  8 ++++----
 kernel/ucount.c                |  6 +++---
 kernel/user_namespace.c        |  8 ++++----
 4 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..47fd841dec43 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -62,6 +62,7 @@ enum ucount_type {
 };
 
 #define MAX_PER_NAMESPACE_UCOUNTS UCOUNT_RLIMIT_NPROC
+#define RLIMIT_COUNTS UCOUNT_COUNTS - MAX_PER_NAMESPACE_UCOUNTS + 1
 
 struct user_namespace {
 	struct uid_gid_map	uid_map;
@@ -98,7 +99,8 @@ struct user_namespace {
 	struct ctl_table_header *sysctls;
 #endif
 	struct ucounts		*ucounts;
-	long ucount_max[UCOUNT_COUNTS];
+	long ucount_max[MAX_PER_NAMESPACE_UCOUNTS];
+	long rlimit_max[RLIMIT_COUNTS];
 } __randomize_layout;
 
 struct ucounts {
@@ -131,10 +133,15 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
 void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
 bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
 
-static inline void set_rlimit_ucount_max(struct user_namespace *ns,
+static inline long get_userns_rlimit_max(struct user_namespace *ns, enum ucount_type type)
+{
+	return READ_ONCE(ns->rlimit_max[type - MAX_PER_NAMESPACE_UCOUNTS]);
+}
+
+static inline void set_userns_rlimit_max(struct user_namespace *ns,
 		enum ucount_type type, unsigned long max)
 {
-	ns->ucount_max[type] = max <= LONG_MAX ? max : LONG_MAX;
+	ns->rlimit_max[type - MAX_PER_NAMESPACE_UCOUNTS] = max <= LONG_MAX ? max : LONG_MAX;
 }
 
 #ifdef CONFIG_USER_NS
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..e4fce0303a26 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -839,10 +839,10 @@ void __init fork_init(void)
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++)
 		init_user_ns.ucount_max[i] = max_threads/2;
 
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
-	set_rlimit_ucount_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_NPROC,      RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MSGQUEUE,   RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_SIGPENDING, RLIM_INFINITY);
+	set_userns_rlimit_max(&init_user_ns, UCOUNT_RLIMIT_MEMLOCK,    RLIM_INFINITY);
 
 #ifdef CONFIG_VMAP_STACK
 	cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "fork:vm_stack_cache",
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 7b32c356ebc5..426bd22b0d6d 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -273,7 +273,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v)
 			ret = LONG_MAX;
 		else if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 	}
 	return ret;
 }
@@ -322,7 +322,7 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 			goto unwind;
 		if (iter == ucounts)
 			ret = new;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 		/*
 		 * Grab an extra ucount reference for the caller when
 		 * the rlimit count was previously 0.
@@ -350,7 +350,7 @@ bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsign
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
 		if (get_ucounts_value(iter, type) > max)
 			return true;
-		max = READ_ONCE(iter->ns->ucount_max[type]);
+		max = get_userns_rlimit_max(iter->ns, type);
 	}
 	return false;
 }
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..106ad0a6188c 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -122,10 +122,10 @@ int create_user_ns(struct cred *new)
 	for (i = 0; i < MAX_PER_NAMESPACE_UCOUNTS; i++) {
 		ns->ucount_max[i] = INT_MAX;
 	}
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
-	set_rlimit_ucount_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MSGQUEUE, rlimit(RLIMIT_MSGQUEUE));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_SIGPENDING, rlimit(RLIMIT_SIGPENDING));
+	set_userns_rlimit_max(ns, UCOUNT_RLIMIT_MEMLOCK, rlimit(RLIMIT_MEMLOCK));
 	ns->ucounts = ucounts;
 
 	/* Inherit USERNS_SETGROUPS_ALLOWED from our parent */
-- 
2.33.0

