Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D7F35242A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 01:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbhDAXrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 19:47:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:50802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235847AbhDAXrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 19:47:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1208B61108;
        Thu,  1 Apr 2021 23:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617320835;
        bh=iQjrDtOXaDMnCugfajjwYEuXjEhJ2bdNWU7nzh347Cg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZhDrQEUKt+bu7iTw3BE837RsKeV/JssS54buUYARKmK/ETO2wOE25Bn34f6idCBD/
         k8dMLBCOW9KuRO0N4VYDbE7561zTMXbJq0opFT390SGgHKTyTTCC9+Ve5SYL3AyYzM
         fHFKdP9t7wyEzk3wE4j5UsvEdQIWWyLZhNlUEpLOXG+D6aTq/XbuPJ1mFqUSLxOxN8
         yvbfP1TwFfAHYkUktpypHNG7jgbaJtPxpxzuXOi8pZ8AsxGX1ZDflG4XfTGrlw4YJr
         yDA67J5J0zY9alXEIdZadX0QYBiXG/AiMLMps5lehiuex7hSMSVXzuK56rrcaGrCht
         hFn5caFzkS9Fg==
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
Subject: [PATCH 1/3] srcu: Remove superfluous ssp initialization on deferred work queue
Date:   Fri,  2 Apr 2021 01:47:02 +0200
Message-Id: <20210401234704.125498-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210401234704.125498-1-frederic@kernel.org>
References: <20210401234704.125498-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an ssp has already started a grace period and queued an early work
to flush after SRCU workqueues are created, we expect the ssp to be
properly initialized already. So we can skip this step at this stage.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 kernel/rcu/srcutree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 036ff5499ad5..7197156418e4 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1396,7 +1396,6 @@ void __init srcu_init(void)
 	while (!list_empty(&srcu_boot_list)) {
 		ssp = list_first_entry(&srcu_boot_list, struct srcu_struct,
 				      work.work.entry);
-		check_init_srcu_struct(ssp);
 		list_del_init(&ssp->work.work.entry);
 		queue_work(rcu_gp_wq, &ssp->work.work);
 	}
-- 
2.25.1

