Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1B358FE4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 00:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232909AbhDHWjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 18:39:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:48154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232918AbhDHWjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 18:39:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CC3F06115B;
        Thu,  8 Apr 2021 22:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617921559;
        bh=z7dimrIBQRXEUVolj+GSg0s9giIVZ5cvdNG3WhkYA8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFZSdENtSFfHIH92zu4xby/SCnVj7y+XH0HI2Ai4w4fsAV1ANvKtwrJqqPAk57gZ1
         g+F2CSlNcT1hM/QRugucN3qrAEu8GIzO8W11imQYBvyzGUGlIqgD8l/l+PxdJQSx18
         aD+SRw0Sf835WAEvyfKnxUxi2xOQenR6v3SPQmwZEVEZ6ciWmhpk2auDraW+qq9FNk
         Y70W9bdCrkuSCjr/l7vpqAOdbz6HG6Cymf+lAwtdGMK7Ga7dmZZAEkH0Jht9IxDnyB
         af2dM9Ajq4nNtUdUy+5AUuUniKXoV0hbCZ5QM5+msdfPM/X4mvBfEEsR6NxQLKXuLX
         PI4wyLH7ipk/Q==
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
Subject: [PATCH 5/5] srcu: Early test SRCU polling start
Date:   Fri,  9 Apr 2021 00:39:02 +0200
Message-Id: <20210408223902.6405-6-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210408223902.6405-1-frederic@kernel.org>
References: <20210408223902.6405-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test early calls to start_poll_synchronize_srcu(), mixed within the
early test to call_srcu(), and make sure that
poll_state_synchronize_srcu() correctly see the expired grace periods
after the srcu_barrier() on late initcall. Normally srcu_barrier()
doesn't wait for callback-less grace periods but early calls to
start_poll_synchronize_srcu() involve empty callbacks.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 kernel/rcu/update.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index dd94a602a6d2..7ee57d66a327 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -528,6 +528,7 @@ DEFINE_STATIC_SRCU(early_srcu);
 struct early_boot_kfree_rcu {
 	struct rcu_head rh;
 };
+static unsigned long early_cookie[3];
 
 static void early_boot_test_call_rcu(void)
 {
@@ -536,8 +537,14 @@ static void early_boot_test_call_rcu(void)
 	struct early_boot_kfree_rcu *rhp;
 
 	call_rcu(&head, test_callback);
-	if (IS_ENABLED(CONFIG_SRCU))
+	if (IS_ENABLED(CONFIG_SRCU)) {
+		int i;
+		early_cookie[0] = start_poll_synchronize_srcu(&early_srcu);
 		call_srcu(&early_srcu, &shead, test_callback);
+
+		for (i = 1; i < ARRAY_SIZE(early_cookie); i++)
+			early_cookie[i] = start_poll_synchronize_srcu(&early_srcu);
+	}
 	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 	if (!WARN_ON_ONCE(!rhp))
 		kfree_rcu(rhp, rh);
@@ -561,8 +568,11 @@ static int rcu_verify_early_boot_tests(void)
 		early_boot_test_counter++;
 		rcu_barrier();
 		if (IS_ENABLED(CONFIG_SRCU)) {
+			int i;
 			early_boot_test_counter++;
 			srcu_barrier(&early_srcu);
+			for (i = 0; i < ARRAY_SIZE(early_cookie); i++)
+				WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_cookie[i]));
 		}
 	}
 	if (rcu_self_test_counter != early_boot_test_counter) {
-- 
2.25.1

