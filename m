Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A20C32C941
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383987AbhCDBGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452950AbhCDAjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5503E64F49;
        Thu,  4 Mar 2021 00:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818298;
        bh=JliU1HJkmj44PJh3uvIhiLKhmFHGenS52iQjT5s/a9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pmR2tZN3TxbH1Hcy4AD2LHhPKWMoCdXvghMTzrCoxGxJ/nunpr49PEnbgm4Fx7fL4
         Ytcp2K7hXMfAqQWWCfd2MvtQbt1ceh9GxULXZ90LstUvR8LXB9U7AxLVSUN4+ZhoyA
         hAwZlew4cxdtABKq9qAVteWrYLSjeaAQV2RxCtmRkyeIWVhcV4kCUmUJtnOW+J+yQq
         919ZoZST6BxtHYlRgcVEPrTeZmoLWoDDn+O/iiikyq5SFb7gWzInlrOuj/JdiWQFiX
         TX7sllRc3KdznT3sQb2doxlclDqAZIsQfLxW6SCSx7uQzpEQNTYWDBUw2JQZ/fkJg1
         hZlNPIQ3uHQ5A==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 27/28] torture: Consolidate qemu-cmd duration editing into kvm-transform.sh
Date:   Wed,  3 Mar 2021 16:38:11 -0800
Message-Id: <20210304003812.24833-27-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, kvm-again.sh updates the duration in the "seconds=" comment
in the qemu-cmd file, but kvm-transform.sh updates the duration in the
actual qemu command arguments.  This is an accident waiting to happen.

This commit therefore consolidates these updates into kvm-transform.sh.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh     | 4 ----
 tools/testing/selftests/rcutorture/bin/kvm-transform.sh | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 75e6afe..33ba6b0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -155,10 +155,6 @@ do
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
 	jitter_dir="`dirname "$kernel_dir"`"
 	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" $dur < $T/qemu-cmd > $i
-	if test -n "$dur"
-	then
-		echo "# seconds=$dur" >> $i
-	fi
 	if test -n "$arg_remote"
 	then
 		echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
index e9dcbce..d40b4e6 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -44,6 +44,14 @@ fi
 
 awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
     -v seconds="$seconds" '
+/^# seconds=/ {
+	if (seconds == "")
+		print $0;
+	else
+		print "# seconds=" seconds;
+	next;
+}
+
 /^# TORTURE_JITTER_START=/ {
 	print "# TORTURE_JITTER_START=\". jitterstart.sh " $4 " " jitter_dir " " $6 " " $7;
 	next;
-- 
2.9.5

