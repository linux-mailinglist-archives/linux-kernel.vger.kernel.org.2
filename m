Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A23429945
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 00:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhJKWCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 18:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhJKWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 18:02:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA5C061762
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 15:00:00 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so430313pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=h+UuBB74dp6dFs0iD7QPMUidFH3fHPkJ6xt8NL1Oem8=;
        b=c4/tsr64anpuq5gWMmEKxFswCIX6hKHC+3Uuc0LxCViLvPquWQcPPIWncLY2BizNRc
         I1bKZUqj5c5nBLYQOf5lr9iAXtWNKdggQQj0lKYM0EkUiH/1a1raNVtlAs2tR+oQqnys
         +jIJJJzv+8R66TJI3bWTmDYyqaH/0vtCYsitCMjYH/LZSgqnJwOe3TsXJ6KClIOHet7F
         DeFrSY2gRDvfyipJozG9WACTaALlPt3b1DW0gEKSi0Uaeq375cXiswUnLEMfUH6EO8pg
         QYrAopvRvWFAZFr7mSo8VYHe9Sz1iB/IcRA2amb4ukD62LJ+mO3JpRyoiZ4wL4GLNI3B
         +O9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=h+UuBB74dp6dFs0iD7QPMUidFH3fHPkJ6xt8NL1Oem8=;
        b=2ATBDBHWN9THO8EWc4wOau9aiZy4g4TcCKrgUZ5XgYkSJ5lwKl/TuyXzHgmocn4qJ0
         txcX/7+FymF8Nw6TGe3GVuBh+EIOd35yP+hBRDUW+m710ajJ7tlTKUdjCHoz4xpposph
         kVgmppFVP/cm6gUCA0K3GN+iIr026wJnTERO1u/98pwoCR3DjAZ4DgwEGCPUbOAjhS7j
         iXYOQn4tQaeOSbVKupZeD1Eq/cROaCZcWqGIklQm2N1EgsH6wqZOzrjIkzr7NEmT0zK0
         qkX3dXt/uS6kAIpbWrOpQoFWW0jovYw7vIGFGVEH9bvoTCSOMaNIjlfh2iAq/yJiFk/r
         GI3A==
X-Gm-Message-State: AOAM530paDiWBWnyQUbkAwq2/78K/CthzuI3e154tO/64k8DxO0JfBsq
        acHoNuP9G7uqhTDYek7QQ5k=
X-Google-Smtp-Source: ABdhPJztwHtTKxxKf26opkiw3aCnR1iNKdwqAm1U17Zsu71r9rNykvuZP49eiqerKC1YYL1v1nfHHw==
X-Received: by 2002:a17:903:24c:b0:13f:2377:ef3a with SMTP id j12-20020a170903024c00b0013f2377ef3amr15110549plh.59.1633989599839;
        Mon, 11 Oct 2021 14:59:59 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id r7sm8643683pff.112.2021.10.11.14.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 14:59:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 11 Oct 2021 11:59:57 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] workqueue fixes for v5.15-rc6
Message-ID: <YWSz3QlxFgafawt6@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus.

One patch to add a missing __printf and the other to enable deferred
printing for debug dumps to avoid deadlocks when triggered from some
contexts (e.g. console drivers).

Thanks.

The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:

  Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-5.15-fixes

for you to fetch changes up to 57116ce17b04fde2fe30f0859df69d8dbe5809f6:

  workqueue: fix state-dump console deadlock (2021-10-11 06:50:28 -1000)

----------------------------------------------------------------
Johan Hovold (1):
      workqueue: fix state-dump console deadlock

Rolf Eike Beer (1):
      workqueue: annotate alloc_workqueue() as printf

 include/linux/workqueue.h |  5 ++---
 kernel/workqueue.c        | 18 ++++++++++++++++--
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2ebef6b1a3d6..74d3c1efd9bb 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -399,9 +399,8 @@ extern struct workqueue_struct *system_freezable_power_efficient_wq;
  * RETURNS:
  * Pointer to the allocated workqueue on success, %NULL on failure.
  */
-struct workqueue_struct *alloc_workqueue(const char *fmt,
-					 unsigned int flags,
-					 int max_active, ...);
+__printf(1, 4) struct workqueue_struct *
+alloc_workqueue(const char *fmt, unsigned int flags, int max_active, ...);
 
 /**
  * alloc_ordered_workqueue - allocate an ordered workqueue
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 33a6b4a2443d..1b3eb1e9531f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4830,8 +4830,16 @@ void show_workqueue_state(void)
 
 		for_each_pwq(pwq, wq) {
 			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-			if (pwq->nr_active || !list_empty(&pwq->inactive_works))
+			if (pwq->nr_active || !list_empty(&pwq->inactive_works)) {
+				/*
+				 * Defer printing to avoid deadlocks in console
+				 * drivers that queue work while holding locks
+				 * also taken in their write paths.
+				 */
+				printk_deferred_enter();
 				show_pwq(pwq);
+				printk_deferred_exit();
+			}
 			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 			/*
 			 * We could be printing a lot from atomic context, e.g.
@@ -4849,7 +4857,12 @@ void show_workqueue_state(void)
 		raw_spin_lock_irqsave(&pool->lock, flags);
 		if (pool->nr_workers == pool->nr_idle)
 			goto next_pool;
-
+		/*
+		 * Defer printing to avoid deadlocks in console drivers that
+		 * queue work while holding locks also taken in their write
+		 * paths.
+		 */
+		printk_deferred_enter();
 		pr_info("pool %d:", pool->id);
 		pr_cont_pool_info(pool);
 		pr_cont(" hung=%us workers=%d",
@@ -4864,6 +4877,7 @@ void show_workqueue_state(void)
 			first = false;
 		}
 		pr_cont("\n");
+		printk_deferred_exit();
 	next_pool:
 		raw_spin_unlock_irqrestore(&pool->lock, flags);
 		/*
