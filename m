Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B6A44C37D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhKJPBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:01:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232361AbhKJPBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:01:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 271E56121F;
        Wed, 10 Nov 2021 14:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636556304;
        bh=bEYLEpQQ/QKPQQ1OXoATAhxucj4jMroHnPUyPDZXhY4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f1jSpjjjVxqXU2XTM9p8NxigTx/aKWoco2eyDBvti78m/lv/NvYKT5qm2sOVmhkr0
         x4K3tfxY7zTXaiItbmovJmSqr8VRgXzCV2fdq3IZVFfLA/pyBTl+GUSQBw1E6OeTko
         f8AFQVYDFuHBIanKTMKsSEGhcg6cCwf/IOX/OXkMwwqglHOOQ9V+KN6OcgWOz/9g/z
         +Y72/tlDfLwsz0ABVaHzLnbBARcqjqxmB2vx9SzsrpkVQNDlUcfHqF6+Oy6Z2jG8no
         PmNudwvFiZHJkbVg6/nlUIX2/urAg8quvydxZgyJ6ngnn9u6uzXmgfi/hSqdumq/RP
         z9jlYip3Yadbg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/2] mm/damon/dbgfs: Fix missed use of damon_dbgfs_lock
Date:   Wed, 10 Nov 2021 14:57:58 +0000
Message-Id: <20211110145758.16558-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110145758.16558-1-sj@kernel.org>
References: <20211110145758.16558-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON debugfs is supposed to protect dbgfs_ctxs, dbgfs_nr_ctxs, and
dbgfs_dirs using damon_dbgfs_lock.  However, some of the code is
accessing the variables without the protection.  This commit fixes it by
protecting all such accesses.

Fixes: 75c1c2b53c78 ("mm/damon/dbgfs: support multiple contexts")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 8ce1311ac533..9b520bb4a3e7 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -877,12 +877,14 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 		return -EINVAL;
 	}
 
+	mutex_lock(&damon_dbgfs_lock);
 	if (!strncmp(kbuf, "on", count)) {
 		int i;
 
 		for (i = 0; i < dbgfs_nr_ctxs; i++) {
 			if (damon_targets_empty(dbgfs_ctxs[i])) {
 				kfree(kbuf);
+				mutex_unlock(&damon_dbgfs_lock);
 				return -EINVAL;
 			}
 		}
@@ -892,6 +894,7 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 	} else {
 		ret = -EINVAL;
 	}
+	mutex_unlock(&damon_dbgfs_lock);
 
 	if (!ret)
 		ret = count;
@@ -944,15 +947,16 @@ static int __init __damon_dbgfs_init(void)
 
 static int __init damon_dbgfs_init(void)
 {
-	int rc;
+	int rc = -ENOMEM;
 
+	mutex_lock(&damon_dbgfs_lock);
 	dbgfs_ctxs = kmalloc(sizeof(*dbgfs_ctxs), GFP_KERNEL);
 	if (!dbgfs_ctxs)
-		return -ENOMEM;
+		goto out;
 	dbgfs_ctxs[0] = dbgfs_new_ctx();
 	if (!dbgfs_ctxs[0]) {
 		kfree(dbgfs_ctxs);
-		return -ENOMEM;
+		goto out;
 	}
 	dbgfs_nr_ctxs = 1;
 
@@ -963,6 +967,8 @@ static int __init damon_dbgfs_init(void)
 		pr_err("%s: dbgfs init failed\n", __func__);
 	}
 
+out:
+	mutex_unlock(&damon_dbgfs_lock);
 	return rc;
 }
 
-- 
2.17.1

