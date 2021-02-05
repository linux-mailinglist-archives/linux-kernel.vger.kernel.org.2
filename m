Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C033110D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233586AbhBERaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:30:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233470AbhBEP7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:59:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F38F665030;
        Fri,  5 Feb 2021 14:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612534293;
        bh=CJzhquXinqJ4mwJA43A2q4mP/ri/sWG3gbVv80b/q+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NVefQ4iUx70ot9d6QQMtJpP7BwpCRHU4MPG2lkr8fW6hQlbWhvSiZ6eH7rgWizSuA
         xnTTOQcieX1/2qwiAvCQWyQK2k12EkLKLKv8hbMDxaoJcHe0Ef8IfR96pXPN9B4nHF
         GPpfJa8w5eQJiwuNuKy0k3I0XFgrLR2+CUl/gdng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 57/57] workqueue: Restrict affinity change to rescuer
Date:   Fri,  5 Feb 2021 15:07:23 +0100
Message-Id: <20210205140658.433231033@linuxfoundation.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210205140655.982616732@linuxfoundation.org>
References: <20210205140655.982616732@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 640f17c82460e9724fd256f0a1f5d99e7ff0bda4 ]

create_worker() will already set the right affinity using
kthread_bind_mask(), this means only the rescuer will need to change
it's affinity.

Howveer, while in cpu-hot-unplug a regular task is not allowed to run
on online&&!active as it would be pushed away quite agressively. We
need KTHREAD_IS_PER_CPU to survive in that environment.

Therefore set the affinity after getting that magic flag.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210121103506.826629830@infradead.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/workqueue.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0695c7895c892..1d99c52cc99a6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1845,12 +1845,6 @@ static void worker_attach_to_pool(struct worker *worker,
 {
 	mutex_lock(&wq_pool_attach_mutex);
 
-	/*
-	 * set_cpus_allowed_ptr() will fail if the cpumask doesn't have any
-	 * online CPUs.  It'll be re-applied when any of the CPUs come up.
-	 */
-	set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
-
 	/*
 	 * The wq_pool_attach_mutex ensures %POOL_DISASSOCIATED remains
 	 * stable across this function.  See the comments above the flag
@@ -1859,6 +1853,9 @@ static void worker_attach_to_pool(struct worker *worker,
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
 
+	if (worker->rescue_wq)
+		set_cpus_allowed_ptr(worker->task, pool->attrs->cpumask);
+
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
 
-- 
2.27.0



