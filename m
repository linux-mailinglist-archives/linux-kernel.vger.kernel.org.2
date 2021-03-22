Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C2634401C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhCVLqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230015AbhCVLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:45:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71BF76198D;
        Mon, 22 Mar 2021 11:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616413539;
        bh=AhqyUvuSkgwMKFkXzmAQIx+J10dGdjipgYaeKlOyw2E=;
        h=From:To:Cc:Subject:Date:From;
        b=STqHgweUfzSJ9/f7W4KQSwiYvG6U+oaTg+zVY1VgB8IK+1PgrYJyClD7TM0nrBIJx
         WdVPuBrKnGWrAVkl0l9QjgP+aeKSr+Ds8oreLfUwDQ1EhPjNkIT9OVyXFIOYzHRlZn
         zaT7vN89vSkRkoXto2S/v/MK8qW/hIj0E7bt6bGxxRZ8PEQX/j01kHp78p8QJScxk8
         x1iTg1vxrXDUJLw4PCEphioUvmLgprGrDbCzVo9k4baudDNhejGJUq7Q3HOMTB6zud
         1tJgT2GlNzajrdH3GqBFVFG2S4yrlsj38GfgmbzB/ylwuFQJPb1zCQHnGNvQ7KoQED
         AGlcpPuO+zg4Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Richard Guy Briggs <rgb@redhat.com>,
        Jules Irenge <jbi.octave@gmail.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] audit: avoid -Wempty-body warning
Date:   Mon, 22 Mar 2021 12:45:32 +0100
Message-Id: <20210322114536.3517661-1-arnd@kernel.org>
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
 kernel/audit.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.h b/kernel/audit.h
index 3b9c0945225a..c39c5f3b8422 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
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

