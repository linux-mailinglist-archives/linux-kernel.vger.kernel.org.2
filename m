Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968A644C37C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 15:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhKJPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 10:01:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:44714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232348AbhKJPBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 10:01:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 50CB761205;
        Wed, 10 Nov 2021 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636556300;
        bh=wVl1UaUEL3yKERyB5XOdBAhxETQh6Uu2L+EMIBFpdJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UdJH0Kkp3Hv2JMeVRT8GM3ZpEkDybXPwgajDyAEGPu2FCYpuExvUJj3JAw89DBk0+
         rT5BhZ1jC+H1ZzRxNaZdRby06mQ8dUzlwNvz6GIgzVUQsHGIM8TdtcVEdfh/XXik7f
         v8Yn9TzaaR3oB9CQiSuN2EFuWkb+57chN3lR89DObknWbgBKTmzIZPXhTOY8194nwi
         xsHkGxg/R2UM6sYe/aB44xf3JKa7POtZpQ+tsZ+juYGzCQg4YJVzkRNLMayummZAj0
         GTD1c8NEIIHRPWYxTHe2vBONKg/eL0ADR3La9+5NfkBu3rvAIA1P9v4hfDyMqpjPiO
         Ffff0YYsNjpiw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/2] mm/damon/dbgfs: Use '__GFP_NOWARN' for user-specified size buffer allocation
Date:   Wed, 10 Nov 2021 14:57:57 +0000
Message-Id: <20211110145758.16558-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211110145758.16558-1-sj@kernel.org>
References: <20211110145758.16558-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON users can trigger below warning in '__alloc_pages()' by invoking
write() to some DAMON debugfs files with arbitrarily high count
argument, because DAMON debugfs interface allocates some buffers based
on the user-specified 'count'.

        if (unlikely(order >= MAX_ORDER)) {
                WARN_ON_ONCE(!(gfp & __GFP_NOWARN));
                return NULL;
        }

Because the DAMON debugfs interface code checks failure of the
'kmalloc()', this commit simply suppresses the warnings by adding
'__GFP_NOWARN' flag.

Fixes: 4bc05954d007 ("mm/damon: implement a debugfs-based user space interface")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index eccc14b34901..8ce1311ac533 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -32,7 +32,7 @@ static char *user_input_str(const char __user *buf, size_t count, loff_t *ppos)
 	if (*ppos)
 		return ERR_PTR(-EINVAL);
 
-	kbuf = kmalloc(count + 1, GFP_KERNEL);
+	kbuf = kmalloc(count + 1, GFP_KERNEL | __GFP_NOWARN);
 	if (!kbuf)
 		return ERR_PTR(-ENOMEM);
 
@@ -133,7 +133,7 @@ static ssize_t dbgfs_schemes_read(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t len;
 
-	kbuf = kmalloc(count, GFP_KERNEL);
+	kbuf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
 	if (!kbuf)
 		return -ENOMEM;
 
@@ -452,7 +452,7 @@ static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
 	char *kbuf;
 	ssize_t len;
 
-	kbuf = kmalloc(count, GFP_KERNEL);
+	kbuf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
 	if (!kbuf)
 		return -ENOMEM;
 
@@ -578,7 +578,7 @@ static ssize_t dbgfs_kdamond_pid_read(struct file *file,
 	char *kbuf;
 	ssize_t len;
 
-	kbuf = kmalloc(count, GFP_KERNEL);
+	kbuf = kmalloc(count, GFP_KERNEL | __GFP_NOWARN);
 	if (!kbuf)
 		return -ENOMEM;
 
-- 
2.17.1

