Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0BC3A0A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFIC3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:29:46 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3911 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhFIC3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:29:44 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4G09t55NLYz6wBb;
        Wed,  9 Jun 2021 10:24:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 10:27:49 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 9 Jun 2021 10:27:48 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Richard Guy Briggs <rgb@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit <linux-audit@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] audit: remove trailing spaces and tabs
Date:   Wed, 9 Jun 2021 10:27:01 +0800
Message-ID: <20210609022701.13768-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210609022701.13768-1-thunder.leizhen@huawei.com>
References: <20210609022701.13768-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

sed -r -i 's/[ \t]+$//' <audit_files>

The files to be checked are as follows:
kernel/audit*
include/linux/audit.h
include/uapi/linux/audit.h

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 include/uapi/linux/audit.h | 4 ++--
 kernel/audit.h             | 2 +-
 kernel/auditsc.c           | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index cd2d8279a5e4..daa481729e9b 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -48,7 +48,7 @@
  * 2500 - 2999 future user space (maybe integrity labels and related events)
  *
  * Messages from 1000-1199 are bi-directional. 1200-1299 & 2100 - 2999 are
- * exclusively user space. 1300-2099 is kernel --> user space 
+ * exclusively user space. 1300-2099 is kernel --> user space
  * communication.
  */
 #define AUDIT_GET		1000	/* Get status */
@@ -78,7 +78,7 @@
 #define AUDIT_LAST_USER_MSG	1199
 #define AUDIT_FIRST_USER_MSG2	2100	/* More user space messages */
 #define AUDIT_LAST_USER_MSG2	2999
- 
+
 #define AUDIT_DAEMON_START      1200    /* Daemon startup record */
 #define AUDIT_DAEMON_END        1201    /* Daemon normal stop record */
 #define AUDIT_DAEMON_ABORT      1202    /* Daemon error stop record */
diff --git a/kernel/audit.h b/kernel/audit.h
index 1522e100fd17..cab3e2652dab 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
-/* audit -- definition of audit_context structure and supporting types 
+/* audit -- definition of audit_context structure and supporting types
  *
  * Copyright 2003-2004 Red Hat, Inc.
  * Copyright 2005 Hewlett-Packard Development Company, L.P.
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0a9a1569f1ea..679a43fd342a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -343,13 +343,13 @@ static int audit_compare_uid(kuid_t uid,
 {
 	struct audit_names *n;
 	int rc;
- 
+
 	if (name) {
 		rc = audit_uid_comparator(uid, f->op, name->uid);
 		if (rc)
 			return rc;
 	}
- 
+
 	if (ctx) {
 		list_for_each_entry(n, &ctx->names_list, list) {
 			rc = audit_uid_comparator(uid, f->op, n->uid);
@@ -367,13 +367,13 @@ static int audit_compare_gid(kgid_t gid,
 {
 	struct audit_names *n;
 	int rc;
- 
+
 	if (name) {
 		rc = audit_gid_comparator(gid, f->op, name->gid);
 		if (rc)
 			return rc;
 	}
- 
+
 	if (ctx) {
 		list_for_each_entry(n, &ctx->names_list, list) {
 			rc = audit_gid_comparator(gid, f->op, n->gid);
-- 
2.25.1


