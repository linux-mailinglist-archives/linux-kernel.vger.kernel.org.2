Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2185032C934
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359548AbhCDBFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:05:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452919AbhCDAjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4395064F2D;
        Thu,  4 Mar 2021 00:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818296;
        bh=S2/1hpx6p5g3yHCL8olMJbs2OKj7VmbYH1e0mv3W3R4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V6pHvmPADIEwpAS7Qv76HbufxT+IcrZZ8+m/PHUUTj0R+wZe0gbn2gBfJiaOXeV//
         /ZRZbXqlyM5zZ335JlyhXNnv1tkkz5vYY+JpR/MbaIeR+YEBSpAeFU5UY5Ppb61gSD
         uHVwNiJRy8z4QyyxWNR1/ShJo8PLY5etiZmaYd6iusRQtMCGr4QpRXG/GmL9waXLqY
         osWJiab5/H1WUes2VFA6/btxZmXyiu031J3CUgz73XtkKf8TRnkjB2/KzanCZGXupD
         f7243Nh8LB1fejBTpVC74pqiwTjGt+DCuLneYPDeO3jK8RniGN0QMk3m8MoPDjIaVr
         P9V7BCkoZDNOA==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 16/28] torture: Record kvm-test-1-run.sh and kvm-test-1-run-qemu.sh PIDs
Date:   Wed,  3 Mar 2021 16:38:00 -0800
Message-Id: <20210304003812.24833-16-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit records the process IDs of the kvm-test-1-run.sh and
kvm-test-1-run-qemu.sh scripts to ease monitoring of remotely running
instances of these scripts.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh | 2 ++
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh      | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
index 6b0d71b..576a9b7 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh
@@ -33,6 +33,8 @@ then
 	exit 1
 fi
 
+echo ' ---' `date`: Starting kernel, PID $$
+
 # Obtain settings from the qemu-cmd file.
 grep '^#' $resdir/qemu-cmd | sed -e 's/^# //' > $T/qemu-cmd-settings
 . $T/qemu-cmd-settings
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index a69f8ae..a386ca8d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -41,7 +41,7 @@ then
 	echo "kvm-test-1-run.sh :$resdir: Not a writable directory, cannot store results into it"
 	exit 1
 fi
-echo ' ---' `date`: Starting build
+echo ' ---' `date`: Starting build, PID $$
 echo ' ---' Kconfig fragment at: $config_template >> $resdir/log
 touch $resdir/ConfigFragment.input
 
-- 
2.9.5

