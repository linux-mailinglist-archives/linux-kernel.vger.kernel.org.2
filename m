Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C0935F4C9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351340AbhDNNY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233255AbhDNNYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90A936117A;
        Wed, 14 Apr 2021 13:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618406663;
        bh=wZaZyLSKW3Uw9c3+YybApCz/BWlPreYcnusf3ah75xE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mTLrtVAe0G+S2ZWTmc1GR/0vdQk7iDWHMmsKTFEhYvZqPwbmyDJHPpax/Z7SkXySC
         6x/cWIokrcVkFk4P3NA3t18DUnaHoduOKuc6PXc/CXNI0vpsal3aw+3lQTCDU97+vb
         pHlIlZm2MB2xiRG5SCiooYsycUKk+uxvz1nz6qPVV+LPgQ3JB7kKis9jErWHrzbHgB
         oKdok5wSQ7hhGz7UQPhbL/Bzo2yD4NPhrjWxNA0tNdjVwkg27tdCnUsMHRqKnKjzED
         URIyMul3NsUkvfEgKVvv12E5Jy+3svsuqq12mPijrMUvfQqujqs7ldjPSp4ksodBwC
         BF8stBkayI18g==
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
Subject: [PATCH 2/2] srcu: Early test SRCU polling start
Date:   Wed, 14 Apr 2021 15:24:13 +0200
Message-Id: <20210414132413.98062-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210414132413.98062-1-frederic@kernel.org>
References: <20210414132413.98062-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Test an early call to start_poll_synchronize_srcu() and place it before
the early test to call_srcu() on the same ssp.

After the later call to srcu_barrier(), we expect the first grace period
completion to be visible by a subsequent call to
poll_state_synchronize_srcu(). Report otherwise.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>
---
 kernel/rcu/update.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index dd94a602a6d2..c21b38cc25e9 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -524,6 +524,7 @@ static void test_callback(struct rcu_head *r)
 }
 
 DEFINE_STATIC_SRCU(early_srcu);
+static unsigned long early_srcu_cookie;
 
 struct early_boot_kfree_rcu {
 	struct rcu_head rh;
@@ -536,8 +537,10 @@ static void early_boot_test_call_rcu(void)
 	struct early_boot_kfree_rcu *rhp;
 
 	call_rcu(&head, test_callback);
-	if (IS_ENABLED(CONFIG_SRCU))
+	if (IS_ENABLED(CONFIG_SRCU)) {
+		early_srcu_cookie = start_poll_synchronize_srcu(&early_srcu);
 		call_srcu(&early_srcu, &shead, test_callback);
+	}
 	rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 	if (!WARN_ON_ONCE(!rhp))
 		kfree_rcu(rhp, rh);
@@ -563,6 +566,7 @@ static int rcu_verify_early_boot_tests(void)
 		if (IS_ENABLED(CONFIG_SRCU)) {
 			early_boot_test_counter++;
 			srcu_barrier(&early_srcu);
+			WARN_ON_ONCE(!poll_state_synchronize_srcu(&early_srcu, early_srcu_cookie));
 		}
 	}
 	if (rcu_self_test_counter != early_boot_test_counter) {
-- 
2.25.1

