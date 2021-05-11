Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7937B24B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 01:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhEKXOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 19:14:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:48054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhEKXNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 19:13:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 043166193A;
        Tue, 11 May 2021 23:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620774745;
        bh=nT+WwqTuijqKEBiwpVUa2iZqdt8xinIz/AGYesgwAoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRblfLqdhDAf8BzBfwoHbPD2tK9fsGfbPGuHLwsNcRvy3rT8ogKKQnb1SX7PPhml1
         9KB+vzhb59+vNUwchZE2z4rlPmPjKYBctqlGW/eXqjudtKlPXvIPq59DtfIliXKInH
         llDuMiPd3eMk8vpSwD77M0kuOIjx6pGeF9T8G70Q3P8Jy4b/E1cZY0LrRYFEOv5X09
         n7VJ5sjzYWS0kz87b+TLBXVVY6CYl+CaNP3wzUhid+rKjoMLn1d5pWxHviVO5lVr7V
         x4u97YMA9MajFPiZ9fCHKm4aWzMIuTu1ebkKa/53XnWbIj1uUDQ93catIxGA9miQ2t
         XAvB9MM1oEGcQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 79C8C5C0DE7; Tue, 11 May 2021 16:12:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/26] torture: Fix grace-period rate output
Date:   Tue, 11 May 2021 16:12:06 -0700
Message-Id: <20210511231223.2895398-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
References: <20210511231149.GA2895263@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kvm-again.sh script relies on shell comments added to the qemu-cmd
file, but this means that code extracting values from the QEMU command in
this file must grep out those commment.  Which kvm-recheck-rcu.sh failed
to do, which destroyed its grace-period-per-second calculation.  This
commit therefore adds the needed "grep -v '^#'" to kvm-recheck-rcu.sh.

Fixes: 315957cad445 ("torture: Prepare for splitting qemu execution from kvm-test-1-run.sh")
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
index 1706cd4466b4..fbdf162b6acd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcu.sh
@@ -31,7 +31,7 @@ then
 	echo "$configfile ------- " $stopstate
 else
 	title="$configfile ------- $ngps GPs"
-	dur=`sed -e 's/^.* rcutorture.shutdown_secs=//' -e 's/ .*$//' < $i/qemu-cmd 2> /dev/null`
+	dur=`grep -v '^#' $i/qemu-cmd | sed -e 's/^.* rcutorture.shutdown_secs=//' -e 's/ .*$//'`
 	if test -z "$dur"
 	then
 		:
-- 
2.31.1.189.g2e36527f23

