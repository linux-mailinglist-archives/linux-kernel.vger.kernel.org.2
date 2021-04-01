Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14E735242B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhDAXrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235912AbhDAXrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:47:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66C1B601FB;
        Thu,  1 Apr 2021 23:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617320837;
        bh=scA4/sv5TOfqpDS5UA4Xg6bJsHw3G9zjuPFH2y9nhJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QV+oN7SFcp+ieBNyzU913jBsyt7NwMJXWdbWltXXYcBX+L9QNESDRt3eOPpyULqHS
         Upp+Xa/q2lcsgjM3HpQr/5HsKy94wCvHEvnRg4B+8lz/DF3mA9pCyOtH+7b5zrEz/w
         57ViFsg6aUOYxxGlEgMa3V5EgkCwMsyTc/jCNyb5L0iIn0ilHEb2RhYeP5e48sBiWJ
         /CJZu2HSVvAPZG+j7RAt/v1BxKfIRuHmdDZOwX7M29QM9ez9bBR3B8Bno3XFN7b0So
         s4yrGVsde7AB27ztXZy7otc6OxyFlFf5GVKF38sD4IzZFeB9oBpwcR1XYqL84KNo0C
         seop5nFY649WA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/3] srcu: Remove superfluous sdp->srcu_lock_count zero filling
Date:   Fri,  2 Apr 2021 01:47:03 +0200
Message-Id: <20210401234704.125498-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401234704.125498-1-frederic@kernel.org>
References: <20210401234704.125498-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alloc_percpu() zeroes out the allocated memory. Therefore we can assume
the whole struct srcu_data to be clear after calling it, just like after
a static initialization. No need for a special treatment in the dynamic
allocation case.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 kernel/rcu/srcutree.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 7197156418e4..10e681ea7051 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -80,7 +80,7 @@ do {									\
  * srcu_read_unlock() running against them.  So if the is_static parameter
  * is set, don't initialize ->srcu_lock_count[] and ->srcu_unlock_count[].
  */
-static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
+static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 {
 	int cpu;
 	int i;
@@ -148,14 +148,6 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp, bool is_static)
 		timer_setup(&sdp->delay_work, srcu_delay_timer, 0);
 		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
-		if (is_static)
-			continue;
-
-		/* Dynamically allocated, better be no srcu_read_locks()! */
-		for (i = 0; i < ARRAY_SIZE(sdp->srcu_lock_count); i++) {
-			sdp->srcu_lock_count[i] = 0;
-			sdp->srcu_unlock_count[i] = 0;
-		}
 	}
 }
 
@@ -179,7 +171,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
 	if (!ssp->sda)
 		return -ENOMEM;
-	init_srcu_struct_nodes(ssp, is_static);
+	init_srcu_struct_nodes(ssp);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
-- 
2.25.1

