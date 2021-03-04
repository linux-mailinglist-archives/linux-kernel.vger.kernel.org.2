Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3645F32C945
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389057AbhCDBGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452975AbhCDAkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:40:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2B0164F4B;
        Thu,  4 Mar 2021 00:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818298;
        bh=0JQ4qk/ipeJkT1zZcANrXGpW+tiGP1iad0WVWjYDYI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVuRsOFmKDx8h1rESCJkzPuX6FtBOjr/C68dnoMeVMMF6nKuv54/KX7K3T/XM2GQ+
         M11EXAdQE/SYQSf13FFc5svMpfdB0V9EeZmfQ+1M2NJpRCSATaj8KllrUtM4Db/3YS
         JjfYJZBL+sn3NSbuzEza4FhwGRBJBw6vDnYrcFcdiQ61RU9tCrva7jThsMn2C0oXLj
         u/WiyR/3zT22GEzNAEZt5DcHahhLbWFf3BoCWx6eDRX9jqHvOahWbIge8ZjmX3WIL5
         P66thP8Zb4AE9Uwv0QLZ9HbHlreR1DpfXIbZ181LcszmvfdE84zFM7J/F6r5B4ck8h
         7rPSzVbhO1hFw==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 25/28] torture: Make TORTURE_TRUST_MAKE available in kvm-again.sh environment
Date:   Wed,  3 Mar 2021 16:38:09 -0800
Message-Id: <20210304003812.24833-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Because the TORTURE_TRUST_MAKE environment variable is not recorded,
kvm-again.sh runs can result in the parse-build.sh script emitting
false-positive "BUG: TREE03 no build" messages.  These messages are
intended to complain about any lack of compiler invocations when the
--trust-make flag is not given to kvm.sh.  However, when this flag is
given to kvm.sh (and thus when TORTURE_TRUST_MAKE=y), lack of compiler
invocations is expected behavior when rebuilding from identical source
code.

This commit therefore makes kvm-test-1-run.sh record the value of the
TORTURE_TRUST_MAKE environment variable as an additional comment in the
qemu-cmd file, and also makes kvm-again.sh reconstitute that variable
from that comment.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh      | 5 +++++
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index 21d1e99..0407df8 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -161,6 +161,11 @@ do
 	fi
 	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
 done
+
+# Extract settings from the last qemu-cmd file transformed above.
+grep '^#' $i | sed -e 's/^# //' > $T/qemu-cmd-settings
+. $T/qemu-cmd-settings
+
 grep -v '^#' $T/batches.oldrun | awk '
 BEGIN {
 	oldbatch = 1;
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index a386ca8d..420ed5c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -204,6 +204,7 @@ echo "# seconds=$seconds" >> $resdir/qemu-cmd
 echo "# TORTURE_KCONFIG_GDB_ARG=\"$TORTURE_KCONFIG_GDB_ARG\"" >> $resdir/qemu-cmd
 echo "# TORTURE_JITTER_START=\"$TORTURE_JITTER_START\"" >> $resdir/qemu-cmd
 echo "# TORTURE_JITTER_STOP=\"$TORTURE_JITTER_STOP\"" >> $resdir/qemu-cmd
+echo "# TORTURE_TRUST_MAKE=\"$TORTURE_TRUST_MAKE\"; export TORTURE_TRUST_MAKE" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
-- 
2.9.5

