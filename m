Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E9D32C972
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356982AbhCDBFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:05:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:37844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452520AbhCDAiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:38:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E12E64EDB;
        Thu,  4 Mar 2021 00:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818293;
        bh=ql7I/2Z5pPWa7gHQF5PnrXkxLr/NyMbE4JCfAneArXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t7h4q5wb6EckQ2peZjZpUmpY7OWjT9HEO64q07SFhObkpoBToLMSh1japMBmNglCV
         mqQSLxBk83pgDkTsUE/3Br9HJlc3zTxv/71K199shD3AmcpS0+KgUdcqO1xIZ3C9Tv
         Yk6RqJQSmZROJMmBNevSk5E2R2VLCRcoOkgH4TP6TPAaxxEEp8VgY8vJx6NhB3Q8vB
         Sorq/EEBGjXlaT9mRMYTbPmcs9T/fUXpWQJx59tbW2Metxel0YCGkRuEkJZxg/dtTG
         ZMcCs7YGWBrDLNOYbik+PMYWn4MFgmujbupXos3VPRa6t/Huh1a1FAAHwTuuvHeTwM
         sDlgH45YR11+g==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 02/28] torture: Allow 1G of memory for torture.sh kvfree testing
Date:   Wed,  3 Mar 2021 16:37:46 -0800
Message-Id: <20210304003812.24833-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Yes, I do recall a time when 512MB of memory was a lot of mass storage,
much less main memory, but the rcuscale kvfree_rcu() testing invoked by
torture.sh can sometimes exceed it on large systems, resulting in OOM.
This commit therefore causes torture.sh to pase the "--memory 1G"
argument to kvm.sh to reserve a full gigabyte for this purpose.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index ad7525b..56e2e1a 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -374,7 +374,7 @@ done
 if test "$do_kvfree" = "yes"
 then
 	torture_bootargs="rcuscale.kfree_rcu_test=1 rcuscale.kfree_nthreads=16 rcuscale.holdoff=20 rcuscale.kfree_loops=10000 torture.disable_onoff_at_boot"
-	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --trust-make
+	torture_set "rcuscale-kvfree" tools/testing/selftests/rcutorture/bin/kvm.sh --torture rcuscale --allcpus --duration 10 --kconfig "CONFIG_NR_CPUS=$HALF_ALLOTED_CPUS" --memory 1G --trust-make
 fi
 
 echo " --- " $scriptname $args
-- 
2.9.5

