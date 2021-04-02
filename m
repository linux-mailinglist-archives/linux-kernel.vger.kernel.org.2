Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF93B352CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235735AbhDBPwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:52:05 -0400
Received: from mail-eopbgr40096.outbound.protection.outlook.com ([40.107.4.96]:18314
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229553AbhDBPwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:52:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eoECFDv8/hLYzbOGyNknELKl4a10FLZ3aRtCrnIH2U2ewqfLQWShqSqtHd8lzMnnXQOu7KJkddrHO69SGf2B2o/5amE0NhXcpfRabCDIuRmrSAUyJ5JFi+1Rs+FqvlV6MqzPk9wE6Npa9jTJDQJgls8ZgAwDsiwYMeec/zfJrw4UV4SxQZrXJABxq7JiE9W3GpCvVjhOrcY7nmXEl8XyMtzli2bhC5wAQlmXuDC87wuSlIGn9U8JJoLZUKlQy1hCiONSTiaWpkPFA9MQPHw6TZB/D2A1eujwqp16p9Ql28eEiXCF/dB9XXQ1yUJjXhbqJ2SY1o9bE01KraclGjZqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/rRXVcD+fYH04WFfYCJmfHgYSsaP+n6al4yIijDu44=;
 b=ZK/zw/Pti6WBUsRMVP9bPBFIi5y0fnTOqpAeUoTxTn8Y8V6fo+GJ4tQ9keDa1HQJ27mGCmUzsARfSh3oZG5em08wSMga28gZYVUamtdNHgq7NybR8QYx2v/sIf6K4CD7AnArPcUIeZx7dCSq5srmuS0uTY0ZDUw2mwUl3RYeyw3vqpY5gmRDk9xo50hkYjsWiX5qwCrceITLHEq0R/OGdPfM5Ul/aL+wI8hgUIS/E38bMieLU4eVgkc71UGo82x+jeF/Da6DnegOW2qa6SF+3TTfRypWZz1nyZWnkAeU+nkEYp7v/+6Edo1rzcZw4/4eopZLJZWHxZ7p7SjI1SMhhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/rRXVcD+fYH04WFfYCJmfHgYSsaP+n6al4yIijDu44=;
 b=g1z7Auw82QIsF13ijY5yAABuOqLuUU8p6Pj8lFQzeQIWDOGmA2MeyoItIX0IKsTjhRD8N3JbvwNElbZ585YRO1MhPtaHAQxbaUpdAayTWVyIdEjzQjG5bjKHxMOPJvnc57Pevvlz9s+suJrBrVMGGj88nBmnz9iVhU2zfCd5/zM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com (2603:10a6:803:114::19)
 by VI1PR0801MB1838.eurprd08.prod.outlook.com (2603:10a6:800:56::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 2 Apr
 2021 15:51:58 +0000
Received: from VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a]) by VE1PR08MB4989.eurprd08.prod.outlook.com
 ([fe80::d1ec:aee1:885c:ad1a%5]) with mapi id 15.20.3999.028; Fri, 2 Apr 2021
 15:51:58 +0000
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Adrian Reber <areber@redhat.com>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-kernel@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: [PATCH] clone3: add option to change owner of newly created namespaces
Date:   Fri,  2 Apr 2021 18:51:31 +0300
Message-Id: <20210402155131.119872-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [81.200.17.122]
X-ClientProxiedBy: AM3PR07CA0080.eurprd07.prod.outlook.com
 (2603:10a6:207:6::14) To VE1PR08MB4989.eurprd08.prod.outlook.com
 (2603:10a6:803:114::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (81.200.17.122) by AM3PR07CA0080.eurprd07.prod.outlook.com (2603:10a6:207:6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Fri, 2 Apr 2021 15:51:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31f655b1-658b-4406-43cf-08d8f5ef3f1b
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1838:
X-LD-Processed: 0bc7f26d-0264-416e-a6fc-8352af79c58f,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB18380BFD58C3F7F46B1E9F98B77A9@VI1PR0801MB1838.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDZJq+7TvcAT8J6rRF4HxsGDwJkoriH9qZUaUdOf0RK5La5UvU6JF9UeALf2aTyd8qYrGLqgluJXrFKzvoQdkj3zu25tr5jvG1fyfKZYhF0rx9FFpcJlbQEc+zTETKjfLa4K5XVKLWq0EwFVbffpj8d0AbqOqImJhIiTvruyBlXWWwM+bvCMhG3i7wZhZ+kObbMqKzP2Bc4BldzftXI+SoIQ9/qqMww5ndbbiTqHddlbCOMZT0vf0QAAsJ/u3Zon1KHRY7GjA5iNo0ZMZ2aljM8AOsMtHIYSR++SL79H1QWDsbg4Erufg/iv/KYz0uKGIbNutp6yiVOUCDjJnIGSPX/P4miDVSTFvaqXHKoytHvZzMuipXABVmVHxqmDz5UrEINcddXktDoBow3+nGtrVQm3VEJPp9eZRotSU9AnhCDQbOyeShDKyQNCSMlFJdY3LuWu48e/4TWKlnpsB87dva9zEPYPeflQBTCgeR2BiuWH2kAHv6c6IVzvJtwzpgj6iO5p3l+7jorJAtdefRiR1WmK0I71XiKPLi+1CMmdfFMRjlT7Y9a3ZvT40RhzHWNgkJtrg/oC5G0/w5fYyDCnwBu8HAQWaBcu49/uEH9eaCGn1d93ueZa34VhtY4/WjaGVCD502MoHvpIWjzWBuu7L91OcjVM8AOGRr0BonAys/svYz61RTkprayYa/xRkGHMCQGzt7p4tL+h/DrOeaOQnx6/6mP7DRKOSTyIdatS+OQDVIulfNU4Sn23LKdaVmLmiqAZG8Pp4Up4WHcvfM5OMEEKNj872whF8DBJaR0Qj8M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4989.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(6486002)(5660300002)(186003)(83380400001)(66556008)(36756003)(2906002)(2616005)(69590400012)(26005)(6666004)(1076003)(4326008)(107886003)(110136005)(54906003)(8936002)(6512007)(7416002)(30864003)(8676002)(66476007)(86362001)(38100700001)(956004)(6506007)(16526019)(498600001)(52116002)(66946007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?bQo7uuRsTDUbLapNTnlb4Kg4YT/UiOxyHLcQzQAnPdUkKlap/BpDAJYcRr7Y?=
 =?us-ascii?Q?HZNKf5EBOsjnIbqA19Nt6tyzhSw74jiIZ60Mjlz7mDWro4vkU2fYnVsLg8G1?=
 =?us-ascii?Q?vdRfANtxymT0rTGpTHJuGO0Z3OwGX+UMXmWF8heP1yLuOFokdQDb3mBMXiFO?=
 =?us-ascii?Q?zK8eo+oLyw+aE9PGz3QzHfkI7D7n+3pcOsQf5dxpqFwbPNi6c9JLOdGS5iJW?=
 =?us-ascii?Q?16i0TBreiE/3zYbNO4QHGj10jU2W9DeKWyjDrEmyVSEcY/yImkgTICKLboQx?=
 =?us-ascii?Q?V0UlpiT4aeUtZ/86C4fAohDsm1JlIwIFqF8R3ss0UQ5U7LsQF/FCgsizXPEc?=
 =?us-ascii?Q?qusq5/5sBBF+59tmhbthVsxUrWU2GRMHuQor6UknqBb44RoAym1ijoO8f31B?=
 =?us-ascii?Q?glFuMUqSnfCFUSES5SUMFYbLUsxgBN1Yt8mTW24cjrpySny5KihzdQd0wY//?=
 =?us-ascii?Q?oE+tECYUvadHcOpgZP+aNfkCOHFVo1+A+Rvb9Vw18LBjReUbH/GOhd89da6C?=
 =?us-ascii?Q?rJGnpiQ5tSNeMwh3B5IKTqcKGuFrKNh2w8kRMMzDAjHd8WfCC5C59aZ+jz3J?=
 =?us-ascii?Q?N2C1+xdU9LDqBWLtJi5b3nrR/EIWnHcUgclA4y+3RwMCV8QzzPXhndH+5mvc?=
 =?us-ascii?Q?8OHAUVXhmElr26C8y+ZDHp0Xj7D3MXdbEkaeEMS8Of172d8Z/CBLmnSI07v2?=
 =?us-ascii?Q?n1VvZLjCT3TSjODgRt0jzw2R6ZxpIJwjycPbsZDEvO+qDN7eILPdfCKWaYLG?=
 =?us-ascii?Q?kiB7eBEQAXPphdJClF0b75UZGprJCzJlzSr7YTNRZEVKTfwyU+fh4hoo39kh?=
 =?us-ascii?Q?FHeeNSKcPhtfw02vLcmzIaWwTHk2AfPGAnA08DRVCwht4kOKFRCuikHWddiD?=
 =?us-ascii?Q?z826iWLsnfRSf/w6BM5LAJm2w70a5UMvVw5+bPTJyUfP3lMiPsSDyQX75341?=
 =?us-ascii?Q?J4eN5dxRVGBWotVsWc5O24Tj8UcACFZRv7CzI/HJtFic5UH9xXAqA0up1Psi?=
 =?us-ascii?Q?02vSHPFH4BOEQRZT+P/6iAg67/E+xHBcaWldL/Jugil0oC0CuSyFV7ItUjXs?=
 =?us-ascii?Q?9kxnX7PxZaLyY6pYQWiAZD6cbSqA5xR+qZyN7t1ABTbQjk5GZnlEAB2+xFWw?=
 =?us-ascii?Q?PNSM0gl46uj0xXKAxJGBWl9bDP00+o3Uok38T49PqjigHiXbySmYVj/Mqvic?=
 =?us-ascii?Q?ZuhGz3V7I0XNEfkeZPb/gSZ/mgzlgAn7adkU9/V16rZ3Z8qhqbYfB9OGV4zv?=
 =?us-ascii?Q?fQEnLNx+ozwBkHDQUHF6IaukoVoONtga+BNKl/LjiNJ6TqXLT8gWUz2+Sv7+?=
 =?us-ascii?Q?/zWtxuFx5j4t5cW5R9ftjbFN?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f655b1-658b-4406-43cf-08d8f5ef3f1b
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4989.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 15:51:57.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WO2lTqmCg4kdyVJZa/vyAEJcko1+K3a/JIcIZSFla+Y/h+5mCc9zgffhIsVeZBWh9xBnthyfSuzoWbh1g6nuAkWqxm3yVBgSlAbsTBxCXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1838
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a flag CLONE_OWNER_NS and clone_args.userns_fd field to
specify a user namespace for clone3 which would become an owner of newly
created namespaces. This owner is restricted to be a descendant of
current user namespace. It means that we can do clone while in more
privileged user namespace than the one which would become an owner.

We need this for CRIU.

1) When CRIU is dumping a container it can face nested user namespaces
and pid namespaces, to properly dump/restore them CRIU needs to also
restore all dependencies between namespaces: parent-child and
userns-owner.

Previously when CRIU was recreating the process tree of container during
restore if we needed to restore a pid namespace init we should first
enter a proper user namespace which should be an owner of restored pid
namespace and only than can clone. That means that the cloned process is
initially created in probably unprivileged user namespace and it brings
a lot of restrictions on what it can do (e.g. we should probably enter
it's ipc/uts/net namespaces already, if they are owned by more
privileged user namespace we would not be able to enter them later).

With new userns_fd option we would be able to recreate process tree with
all container pid namespaces with proper user namespace owners for them
while all processes are left in most privileged user namespace, and it
would be easier to restore all resources of those processes. We can
restore user namespace of each process later when needed.

2) Other problem which this option is trying to solve is that clone3()
with set_tid does not work as desired when we try to recreate a process
in the container which has nested user and pid namespaces.

Imagine that in container we have a chain of processes each of them was
created with clone() with (CLONE_NEWPID | CLONE_NEWUSER) from previous
process and in each pid namespace of this chain we've also created some
amount of processes to hold pid numbers. Next we create one more
"target" process with new pid and user namespaces in the end of chain,
it can have random pids in each pid namespace of the chain.

When CRIU would restore this container it would not be able to restore
pids of "target" process on each pid namespace level with clone3()+
set_tid because it would need to call clone from owner user namespace
(or it's parent if we use CLONE_NEWUSER) of the "target"'s pid
namespace, which has no rights to set_tid on each needed level.

With new userns_fd option we would easily do it, we just need to have
current user namespace to be root user namespace of the container and
pass "target"'s pid namespace owner user namespace to userns_fd.

Here are two examples on the use of new userns_fd option:

- clone3_owner_ns.c - is simple demonstration of how process can create
pid namespace owned by it's user namespace descendant;
- clone3_set_tid_vs_owner_ns.c - is a bit more complex demonstration
on how clone3+set_tid can work for restoring pids on each level of
nested user and pid namespaces when used together with userns_fd:

https://github.com/Snorch/clone3_owner_ns

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 include/linux/nsproxy.h        |  3 ++-
 include/linux/sched/task.h     |  1 +
 include/linux/user_namespace.h |  6 ++++++
 include/uapi/linux/sched.h     |  3 +++
 kernel/fork.c                  | 18 +++++++++++++++---
 kernel/nsproxy.c               | 19 ++++++++++++++++++-
 kernel/user_namespace.c        | 22 ++++++++++++++++++++++
 7 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/include/linux/nsproxy.h b/include/linux/nsproxy.h
index cdb171efc7cb..201bbb75637d 100644
--- a/include/linux/nsproxy.h
+++ b/include/linux/nsproxy.h
@@ -91,7 +91,8 @@ static inline struct cred *nsset_cred(struct nsset *set)
  *
  */
 
-int copy_namespaces(unsigned long flags, struct task_struct *tsk);
+int copy_namespaces(unsigned long flags, struct task_struct *tsk,
+		    int userns_fd);
 void exit_task_namespaces(struct task_struct *tsk);
 void switch_task_namespaces(struct task_struct *tsk, struct nsproxy *new);
 void free_nsproxy(struct nsproxy *ns);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index c0f71f2e7160..176b087443a0 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -33,6 +33,7 @@ struct kernel_clone_args {
 	int cgroup;
 	struct cgroup *cgrp;
 	struct css_set *cset;
+	int userns_fd;
 };
 
 /*
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 64cf8ebdc4ec..cecc4c55b7cb 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -136,6 +136,7 @@ extern bool in_userns(const struct user_namespace *ancestor,
 		       const struct user_namespace *child);
 extern bool current_in_userns(const struct user_namespace *target_ns);
 struct ns_common *ns_get_owner(struct ns_common *ns);
+extern struct user_namespace *get_user_ns_by_fd(int fd);
 #else
 
 static inline struct user_namespace *get_user_ns(struct user_namespace *ns)
@@ -180,6 +181,11 @@ static inline struct ns_common *ns_get_owner(struct ns_common *ns)
 {
 	return ERR_PTR(-EPERM);
 }
+
+static inline struct user_namespace *get_user_ns_by_fd(int fd)
+{
+	return ERR_PTR(-EINVAL);
+}
 #endif
 
 #endif /* _LINUX_USER_H */
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3bac0a8ceab2..77dfa0bb4d73 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -36,6 +36,7 @@
 /* Flags for the clone3() syscall. */
 #define CLONE_CLEAR_SIGHAND 0x100000000ULL /* Clear any signal handler and reset to SIG_DFL. */
 #define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
+#define CLONE_OWNER_NS 0x400000000ULL /* Clone with changed owner userns */
 
 /*
  * cloning flags intersect with CSIGNAL so can be used with unshare and clone3
@@ -101,12 +102,14 @@ struct clone_args {
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
 	__aligned_u64 cgroup;
+	__aligned_u64 userns_fd;
 };
 #endif
 
 #define CLONE_ARGS_SIZE_VER0 64 /* sizeof first published struct */
 #define CLONE_ARGS_SIZE_VER1 80 /* sizeof second published struct */
 #define CLONE_ARGS_SIZE_VER2 88 /* sizeof third published struct */
+#define CLONE_ARGS_SIZE_VER3 96 /* sizeof forth published struct */
 
 /*
  * Scheduling policies
diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..a22acfa4b618 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2097,7 +2097,7 @@ static __latent_entropy struct task_struct *copy_process(
 	retval = copy_mm(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_signal;
-	retval = copy_namespaces(clone_flags, p);
+	retval = copy_namespaces(clone_flags, p, args->userns_fd);
 	if (retval)
 		goto bad_fork_cleanup_mm;
 	retval = copy_io(clone_flags, p);
@@ -2596,7 +2596,9 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		     CLONE_ARGS_SIZE_VER1);
 	BUILD_BUG_ON(offsetofend(struct clone_args, cgroup) !=
 		     CLONE_ARGS_SIZE_VER2);
-	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER2);
+	BUILD_BUG_ON(offsetofend(struct clone_args, userns_fd) !=
+		     CLONE_ARGS_SIZE_VER3);
+	BUILD_BUG_ON(sizeof(struct clone_args) != CLONE_ARGS_SIZE_VER3);
 
 	if (unlikely(usize > PAGE_SIZE))
 		return -E2BIG;
@@ -2628,6 +2630,10 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 	    (args.cgroup > INT_MAX || usize < CLONE_ARGS_SIZE_VER2))
 		return -EINVAL;
 
+	if ((args.flags & CLONE_OWNER_NS) &&
+	    (usize < CLONE_ARGS_SIZE_VER3))
+		return -EINVAL;
+
 	*kargs = (struct kernel_clone_args){
 		.flags		= args.flags,
 		.pidfd		= u64_to_user_ptr(args.pidfd),
@@ -2639,6 +2645,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 		.tls		= args.tls,
 		.set_tid_size	= args.set_tid_size,
 		.cgroup		= args.cgroup,
+		.userns_fd	= args.userns_fd,
 	};
 
 	if (args.set_tid &&
@@ -2683,7 +2690,8 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
 	if (kargs->flags &
-	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND | CLONE_INTO_CGROUP))
+	    ~(CLONE_LEGACY_FLAGS | CLONE_CLEAR_SIGHAND |
+	      CLONE_INTO_CGROUP | CLONE_OWNER_NS))
 		return false;
 
 	/*
@@ -2704,6 +2712,10 @@ static bool clone3_args_valid(struct kernel_clone_args *kargs)
 	if (!clone3_stack_valid(kargs))
 		return false;
 
+	if ((kargs->flags & (CLONE_OWNER_NS | CLONE_NEWUSER)) ==
+	    (CLONE_OWNER_NS | CLONE_NEWUSER))
+		return false;
+
 	return true;
 }
 
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index abc01fcad8c7..43326dd0df3f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -19,6 +19,7 @@
 #include <net/net_namespace.h>
 #include <linux/ipc_namespace.h>
 #include <linux/time_namespace.h>
+#include <linux/user_namespace.h>
 #include <linux/fs_struct.h>
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
@@ -148,10 +149,12 @@ static struct nsproxy *create_new_namespaces(unsigned long flags,
  * called from clone.  This now handles copy for nsproxy and all
  * namespaces therein.
  */
-int copy_namespaces(unsigned long flags, struct task_struct *tsk)
+int copy_namespaces(unsigned long flags, struct task_struct *tsk,
+		    int userns_fd)
 {
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
+	struct user_namespace *owner = NULL;
 	struct nsproxy *new_ns;
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
@@ -175,7 +178,21 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 		(CLONE_NEWIPC | CLONE_SYSVSEM))
 		return -EINVAL;
 
+	if (flags & CLONE_OWNER_NS) {
+		owner = get_user_ns_by_fd(userns_fd);
+		if (IS_ERR(owner))
+			return -EINVAL;
+
+		if (!in_userns(user_ns, owner)) {
+			put_user_ns(owner);
+			return -EPERM;
+		}
+
+		user_ns = owner;
+	}
+
 	new_ns = create_new_namespaces(flags, tsk, user_ns, tsk->fs);
+	put_user_ns(owner);
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index af612945a4d0..c578f478eedc 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/file.h>
 
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -1253,6 +1254,27 @@ static void userns_put(struct ns_common *ns)
 	put_user_ns(to_user_ns(ns));
 }
 
+struct user_namespace *get_user_ns_by_fd(int fd)
+{
+	struct file *file;
+	struct ns_common *ns;
+	struct user_namespace *user_ns;
+
+	file = proc_ns_fget(fd);
+	if (IS_ERR(file))
+		return ERR_CAST(file);
+
+	ns = get_proc_ns(file_inode(file));
+	if (ns->ops == &userns_operations)
+		user_ns = get_user_ns(to_user_ns(ns));
+	else
+		user_ns = ERR_PTR(-EINVAL);
+
+	fput(file);
+	return user_ns;
+}
+EXPORT_SYMBOL(get_user_ns_by_fd);
+
 static int userns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct user_namespace *user_ns = to_user_ns(ns);
-- 
2.30.2

