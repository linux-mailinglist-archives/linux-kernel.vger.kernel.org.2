Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC06142AE52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbhJLU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 16:59:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235422AbhJLU7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 16:59:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFB1B610A2;
        Tue, 12 Oct 2021 20:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634072262;
        bh=OwaIL57E/9OtVPX6GwtLryDEvm3urcjWgPRZ8ijhkuE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RQNf9JzwXSzVltFiiczo8aEqz5a3UIeewpc2Mul8pAzU5h6QOiCUsCbLQGUUfHYfV
         k0ENyDoGNx1IaVoA+HUTmfN9Im58oj5mt9iDnqcH0DX4BSYFXQL2GynFPxtcK/Wevg
         pHDkdrHXF2Yg+VEudwifDloZdSL2/FNSyK6Vaxb+aOIPx+htQw4TpRkL1a701YAH0C
         GabmokdplwdT01d/J9/ZYlFwQZi4RXGWWYM7Ad0SwPXlCQHuBIgxmZix6AE8AeuDYL
         7S/Cgsa2XLZvmKOOG3w3p3Iyqde62iX9o/+8ku8H8vNzG5hPoEUgtJ7CauwutRG0HV
         XsOyCc+fUgq4A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     SeongJae Park <sj@kernel.org>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] mm/damon/dbgfs: Support physical memory monitoring
Date:   Tue, 12 Oct 2021 20:57:10 +0000
Message-Id: <20211012205711.29216-7-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012205711.29216-1-sj@kernel.org>
References: <20211012205711.29216-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes the 'damon-dbgfs' to support the physical memory
monitoring, in addition to the virtual memory monitoring.

Users can do the physical memory monitoring by writing a special
keyword, 'paddr\n' to the 'target_ids' debugfs file.  Then, DAMON will
check the special keyword and configure the monitoring context to run
with the primitives for the physical address space.

Unlike the virtual memory monitoring, the monitoring target region will
not be automatically set.  Therefore, users should also set the
monitoring target address region using the 'init_regions' debugfs file.

Also, note that the physical memory monitoring will not automatically
terminated.  The user should explicitly turn off the monitoring by
writing 'off' to the 'monitor_on' debugfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/Kconfig |  2 +-
 mm/damon/dbgfs.c | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
index 2a5923be631e..ca33b289ebbe 100644
--- a/mm/damon/Kconfig
+++ b/mm/damon/Kconfig
@@ -54,7 +54,7 @@ config DAMON_VADDR_KUNIT_TEST
 
 config DAMON_DBGFS
 	bool "DAMON debugfs interface"
-	depends on DAMON_VADDR && DEBUG_FS
+	depends on DAMON_VADDR && DAMON_PADDR && DEBUG_FS
 	help
 	  This builds the debugfs interface for DAMON.  The user space admins
 	  can use the interface for arbitrary data access monitoring.
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 1cce53cd241d..38188347d8ab 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -339,6 +339,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
+	bool id_is_pid = true;
 	char *kbuf, *nrs;
 	unsigned long *targets;
 	ssize_t nr_targets;
@@ -351,6 +352,11 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		return PTR_ERR(kbuf);
 
 	nrs = kbuf;
+	if (!strncmp(kbuf, "paddr\n", count)) {
+		id_is_pid = false;
+		/* target id is meaningless here, but we set it just for fun */
+		scnprintf(kbuf, count, "42    ");
+	}
 
 	targets = str_to_target_ids(nrs, ret, &nr_targets);
 	if (!targets) {
@@ -358,7 +364,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 		goto out;
 	}
 
-	if (targetid_is_pid(ctx)) {
+	if (id_is_pid) {
 		for (i = 0; i < nr_targets; i++) {
 			targets[i] = (unsigned long)find_get_pid(
 					(int)targets[i]);
@@ -372,15 +378,24 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 
 	mutex_lock(&ctx->kdamond_lock);
 	if (ctx->kdamond) {
-		if (targetid_is_pid(ctx))
+		if (id_is_pid)
 			dbgfs_put_pids(targets, nr_targets);
 		ret = -EBUSY;
 		goto unlock_out;
 	}
 
+	/* remove targets with previously-set primitive */
+	damon_set_targets(ctx, NULL, 0);
+
+	/* Configure the context for the address space type */
+	if (id_is_pid)
+		damon_va_set_primitives(ctx);
+	else
+		damon_pa_set_primitives(ctx);
+
 	err = damon_set_targets(ctx, targets, nr_targets);
 	if (err) {
-		if (targetid_is_pid(ctx))
+		if (id_is_pid)
 			dbgfs_put_pids(targets, nr_targets);
 		ret = err;
 	}
-- 
2.17.1

