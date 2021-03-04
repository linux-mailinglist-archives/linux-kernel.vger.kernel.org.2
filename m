Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0157632C935
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376970AbhCDBFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:05:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452926AbhCDAjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5BDCA64F0D;
        Thu,  4 Mar 2021 00:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818294;
        bh=iAUyPww0CwqwsPGXyb0IutCV0eWwmE0ObhDkQWjCwXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GSwRjMlX7ot1ceO3OYtxXKNtO8J6MnA6BURlcLX+0cImt4oyMIj7GeR2jxa4LaLZM
         z9Ih6RS3tctNwkbgl3HoqCRQ69/ZQD6d8baffPH8q7mNaIKulFvTnlQ3+3k5tI6WrO
         Kr/rHBxKKTa4kmUfUjo1uzfsVEpIHw068EM47FFEFv0Veqq9bPELnzub5VNkBxsXaX
         uQi31+cXaqpjF4irzVwulgYuILtYeo+m1cwxPFG8ejUNPVAW16vTJ9ffKHqTP7wyLG
         6BS4kTLSPgDH8hkNx1Aq56sd0kBTdG3T3GxnWoVZLxSfZ8AgX860P9XzuDkz8e/i8H
         w3QYhtZ0quvtg==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 06/28] refscale: Disable verbose torture-test output
Date:   Wed,  3 Mar 2021 16:37:50 -0800
Message-Id: <20210304003812.24833-6-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Given large numbers of threads, the quantity of torture-test output is
sufficient to sometimes result in RCU CPU stall warnings.  The probability
of these stall warnings was greatly reduced by batching the output,
but the warnings were not eliminated.  However, the actual test only
depends on console output that is printed even when refscale.verbose=0.
This commit therefore causes this test to run with refscale.verbose=0.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
index 321e826..f81fa2c 100644
--- a/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/refscale/ver_functions.sh
@@ -12,5 +12,5 @@
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
 	echo $1 refscale.shutdown=1 \
-		refscale.verbose=1
+		refscale.verbose=0
 }
-- 
2.9.5

