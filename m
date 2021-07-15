Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBCA3C965F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 05:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhGODTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 23:19:22 -0400
Received: from foss.arm.com ([217.140.110.172]:46038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234349AbhGODTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 23:19:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4418B11FB;
        Wed, 14 Jul 2021 20:16:25 -0700 (PDT)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.103])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E4B873F7D8;
        Wed, 14 Jul 2021 20:16:22 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com,
        Jia He <justin.he@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH RFC 09/13] mm/filemap: simplify the printing with '%pD' specifier
Date:   Thu, 15 Jul 2021 11:15:29 +0800
Message-Id: <20210715031533.9553-10-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210715031533.9553-1-justin.he@arm.com>
References: <20210715031533.9553-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the behavior of '%pD' is changed to print the full path of file,
the log printing in dio_warn_stale_pagecache() can be simplified.

Given that the error case is well handled in d_path_unsafe(), the error
string would be copied in '%pD' buffer, no need to additionally handle
IS_ERR().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jia He <justin.he@arm.com>
---
 mm/filemap.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index d1458ecf2f51..477288017765 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3497,16 +3497,11 @@ EXPORT_SYMBOL(pagecache_write_end);
 void dio_warn_stale_pagecache(struct file *filp)
 {
 	static DEFINE_RATELIMIT_STATE(_rs, 86400 * HZ, DEFAULT_RATELIMIT_BURST);
-	char pathname[128];
-	char *path;
 
 	errseq_set(&filp->f_mapping->wb_err, -EIO);
 	if (__ratelimit(&_rs)) {
-		path = file_path(filp, pathname, sizeof(pathname));
-		if (IS_ERR(path))
-			path = "(unknown)";
 		pr_crit("Page cache invalidation failure on direct I/O.  Possible data corruption due to collision with buffered I/O!\n");
-		pr_crit("File: %s PID: %d Comm: %.20s\n", path, current->pid,
+		pr_crit("File: %pD PID: %d Comm: %.20s\n", filp, current->pid,
 			current->comm);
 	}
 }
-- 
2.17.1

