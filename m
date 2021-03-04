Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9630E32C93D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382702AbhCDBGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452942AbhCDAjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 13A5864F44;
        Thu,  4 Mar 2021 00:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818297;
        bh=S+tkJ6mthzliqe3FTyWleSxDYfaXB4jmpy9dqnQjY1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWyYcOxO1LEXO9TIBLSjLOJhlGMLwxvRE7/NCWrYMiVwJiK4pLfLe2trc4Z65KvTR
         vNixbdQ2EzBQjA4UpQe4GuS7WyNxCe/OVFFOjG/EnbSjcjFUsAQBy73Hdt/s1hzHlD
         yuXGz7ueOmm2vDL86Bmi8wWhahrBG75MlZ5FutjV7kbRtvFJhzrZtBd1JeYURFDtTo
         COZrAKwRgycj8/nt1ypCbOe9okjtWhNBkSuwMeEkMryfwUVfO7p7jmOUw5phX/K7ep
         Pkiakieq8/6Ds6RdKJQGvatSnxfKR/+WRsR41oDPVlunmkye+oPKvtKewsMBc4P3ul
         fQjUs00fC47aQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 20/28] torture: De-capitalize TORTURE_SUITE
Date:   Wed,  3 Mar 2021 16:38:04 -0800
Message-Id: <20210304003812.24833-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although it might be unlikely that someone would name a scenario
"TORTURE_SUITE", they are within their rights to do so.  This script
therefore renames the "TORTURE_SUITE" file in the top-level date-stamped
directory within "res" to "torture_suite" to avoid this name collision.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck.sh | 2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index 47cf4db..e01b31b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -30,7 +30,7 @@ do
 			resdir=`echo $i | sed -e 's,/$,,' -e 's,/[^/]*$,,'`
 			head -1 $resdir/log
 		fi
-		TORTURE_SUITE="`cat $i/../TORTURE_SUITE`"
+		TORTURE_SUITE="`cat $i/../torture_suite`"
 		configfile=`echo $i | sed -e 's,^.*/,,'`
 		rm -f $i/console.log.*.diags
 		kvm-recheck-${TORTURE_SUITE}.sh $i
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 03364f4..a1cd05c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -405,7 +405,7 @@ echo Results directory: $resdir/$ds
 echo $scriptname $args
 touch $resdir/$ds/log
 echo $scriptname $args >> $resdir/$ds/log
-echo ${TORTURE_SUITE} > $resdir/$ds/TORTURE_SUITE
+echo ${TORTURE_SUITE} > $resdir/$ds/torture_suite
 echo Build directory: `pwd` > $resdir/$ds/testid.txt
 if test -d .git
 then
-- 
2.9.5

