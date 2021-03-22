Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F3C344B4C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhCVQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230345AbhCVQ2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:28:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DD75861923;
        Mon, 22 Mar 2021 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616430491;
        bh=MhahTBtlXOdWZW9QKwHmL4yqr9I4b2zZUjf9isGSNKA=;
        h=From:To:Cc:Subject:Date:From;
        b=VNJG7KvNYpjsVuIlhBQn5Ymq3CtXSYUnSrGI4oDwL1YH5YAuZz1weeYGlo1KU3f5G
         sBpkzgrAG+vXKySK/VtLW9XkpsOPoUXKS6gwhWeDbrVxlsLSk706OLFO2ymmjuG22x
         F/oULe+r40FEJ4zwLqU+aCY9jrWLpdRbDfnsGxHmvJLaTcs6cNC6Vcp4RVzwxLOmFk
         35d31OikyF93PrmB39bdf7CpdfUobWHXOHARdSwO9axdrkZ2TjdVJCUryrR9kr6vq8
         Wc3Z5PUQfBpmVI2U/QTsodmMHBIztU0cNnits/HrN4VBavEHbjLWTxs853NUIsUt3h
         g2ZHc9XNv2vZg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Guy Briggs <rgb@redhat.com>,
        Jules Irenge <jbi.octave@gmail.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] audit: avoid -Wempty-body warning
Date:   Mon, 22 Mar 2021 17:27:45 +0100
Message-Id: <20210322162807.679370-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

gcc warns about an empty statement when audit_remove_mark is defined to
nothing:

kernel/auditfilter.c: In function 'audit_data_to_entry':
kernel/auditfilter.c:609:51: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
  609 |                 audit_remove_mark(entry->rule.exe); /* that's the template one */
      |                                                   ^

Change the macros to use the usual "do { } while (0)" instead, and change a
few more that were (void)0, for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: convert two more macros
---
 kernel/audit.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 3b9c0945225a..1522e100fd17 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -292,8 +292,8 @@ extern void audit_filter_inodes(struct task_struct *tsk,
 extern struct list_head *audit_killed_trees(void);
 #else /* CONFIG_AUDITSYSCALL */
 #define auditsc_get_stamp(c, t, s) 0
-#define audit_put_watch(w) {}
-#define audit_get_watch(w) {}
+#define audit_put_watch(w) do { } while (0)
+#define audit_get_watch(w) do { } while (0)
 #define audit_to_watch(k, p, l, o) (-EINVAL)
 #define audit_add_watch(k, l) (-EINVAL)
 #define audit_remove_watch_rule(k) BUG()
@@ -302,8 +302,8 @@ extern struct list_head *audit_killed_trees(void);
 
 #define audit_alloc_mark(k, p, l) (ERR_PTR(-EINVAL))
 #define audit_mark_path(m) ""
-#define audit_remove_mark(m)
-#define audit_remove_mark_rule(k)
+#define audit_remove_mark(m) do { } while (0)
+#define audit_remove_mark_rule(k) do { } while (0)
 #define audit_mark_compare(m, i, d) 0
 #define audit_exe_compare(t, m) (-EINVAL)
 #define audit_dupe_exe(n, o) (-EINVAL)
@@ -311,8 +311,8 @@ extern struct list_head *audit_killed_trees(void);
 #define audit_remove_tree_rule(rule) BUG()
 #define audit_add_tree_rule(rule) -EINVAL
 #define audit_make_tree(rule, str, op) -EINVAL
-#define audit_trim_trees() (void)0
-#define audit_put_tree(tree) (void)0
+#define audit_trim_trees() do { } while (0)
+#define audit_put_tree(tree) do { } while (0)
 #define audit_tag_tree(old, new) -EINVAL
 #define audit_tree_path(rule) ""	/* never called */
 #define audit_kill_trees(context) BUG()
-- 
2.29.2

