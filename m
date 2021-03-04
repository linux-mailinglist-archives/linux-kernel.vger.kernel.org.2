Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA5132C940
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383667AbhCDBGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:06:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452944AbhCDAjw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:39:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BAF264F47;
        Thu,  4 Mar 2021 00:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614818297;
        bh=XM7p4QSV/GFErVqA0Lu0fJQjVwCIBEYZrNLSRyI+w1Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDe9nJFBwxmBI4n0WfPa/fnazn1Vsza4IPAj+G/vtKf55ZMq3gY0ebl/jVnLx2gyd
         JWel8ynrSWtSYBMcmVlNikQsamiSmtk+F9imnFpY6ro3llRFCJ8d2It8n3o74jwR+X
         5Jj4mO/oTIzmVaKOHjPeRjwf25k81Y2Av4mANrYryXMxzBQCMHsNbj5KQyCsjD8wVo
         ESHKCSFIvJYROlOv2PkyNko/X20C9URGj4ayjyfjfCgX0E/Cjz9ZrTwHbZYcwlt8Cy
         2Ca5JDVNG8fxr4aaOa4PKXl2/Jhh+CqfjmWQdfNOoAxC/avhbqds0jHjl4YNI33s5e
         pXil1b60Dh4ng==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 22/28] torture: Add kvm-again.sh to rerun a previous torture-test
Date:   Wed,  3 Mar 2021 16:38:06 -0800
Message-Id: <20210304003812.24833-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210304003750.GA24696@paulmck-ThinkPad-P72>
References: <20210304003750.GA24696@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a kvm-again.sh script that, given the results directory
of a torture-test run, re-runs that test.  This means that the kernels
need not be rebuilt, but it also is a step towards running torture tests
on remote systems.

This commit also adds a kvm-test-1-run-batch.sh script that runs one
batch out of the torture test.  The idea is to copy a results directory
tree to remote systems, then use kvm-test-1-run-batch.sh to run batches
on these systems.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/kvm-again.sh  | 171 +++++++++++++++++++++
 .../rcutorture/bin/kvm-test-1-run-batch.sh         |  67 ++++++++
 2 files changed, 238 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-again.sh
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
new file mode 100755
index 0000000..92cf396
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -0,0 +1,171 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Rerun a series of tests under KVM.
+#
+# Usage: kvm.sh /path/to/old/run [ options ]
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+scriptname=$0
+args="$*"
+
+T=${TMPDIR-/tmp}/kvm-again.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+if ! test -d tools/testing/selftests/rcutorture/bin
+then
+	echo $scriptname must be run from top-level directory of kernel source tree.
+	exit 1
+fi
+
+oldrun=$1
+shift
+if ! test -d "$oldrun"
+then
+	echo "Usage: $scriptname /path/to/old/run [ options ]"
+	exit 1
+fi
+if ! cp "$oldrun/batches" $T/batches.oldrun
+then
+	# Later on, can reconstitute this from console.log files.
+	echo Prior run batches file does not exist: $oldrun/batches
+	exit 1
+fi
+
+if test -f "$oldrun/torture_suite"
+then
+	torture_suite="`cat $oldrun/torture_suite`"
+elif test -f "$oldrun/TORTURE_SUITE"
+then
+	torture_suite="`cat $oldrun/TORTURE_SUITE`"
+else
+	echo "Prior run torture_suite file does not exist: $oldrun/{torture_suite,TORTURE_SUITE}"
+	exit 1
+fi
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+
+dryrun=
+default_link="cp -R"
+rundir="`pwd`/tools/testing/selftests/rcutorture/res/`date +%Y.%m.%d-%H.%M.%S-again`"
+
+startdate="`date`"
+starttime="`get_starttime`"
+
+usage () {
+	echo "Usage: $scriptname $oldrun [ arguments ]:"
+	echo "       --dryrun"
+	echo "       --link hard|soft|copy"
+	echo "       --remote"
+	echo "       --rundir /new/res/path"
+	exit 1
+}
+
+while test $# -gt 0
+do
+	case "$1" in
+	--dryrun)
+		dryrun=1
+		;;
+	--link)
+		checkarg --link "hard|soft|copy" "$#" "$2" 'hard\|soft\|copy' '^--'
+		case "$2" in
+		copy)
+			arg_link="cp -R"
+			;;
+		hard)
+			arg_link="cp -Rl"
+			;;
+		soft)
+			arg_link="cp -Rs"
+			;;
+		esac
+		shift
+		;;
+	--remote)
+		arg_remote=1
+		default_link="cp -as"
+		;;
+	--rundir)
+		checkarg --rundir "(absolute pathname)" "$#" "$2" '^/' '^error'
+		rundir=$2
+		if test -e "$rundir"
+		then
+			echo "--rundir $2: Already exists."
+			usage
+		fi
+		shift
+		;;
+	*)
+		echo Unknown argument $1
+		usage
+		;;
+	esac
+	shift
+done
+if test -z "$arg_link"
+then
+	arg_link="$default_link"
+fi
+
+echo ---- Re-run results directory: $rundir
+
+# Copy old run directory tree over and adjust.
+mkdir -p "`dirname "$rundir"`"
+if ! $arg_link "$oldrun" "$rundir"
+then
+	echo "Cannot copy from $oldrun to $rundir."
+	usage
+fi
+rm -f "$rundir"/*/{console.log,console.log.diags,qemu_pid,qemu-retval,Warnings,kvm-test-1-run.sh.out,kvm-test-1-run-qemu.sh.out,vmlinux} "$rundir"/log
+echo $oldrun > "$rundir/re-run"
+if ! test -d "$rundir/../../bin"
+then
+	$arg_link "$oldrun/../../bin" "$rundir/../.."
+fi
+for i in $rundir/*/qemu-cmd
+do
+	cp "$i" $T
+	qemu_cmd_dir="`dirname "$i"`"
+	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
+	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log < $T/qemu-cmd > $i
+	echo "# TORTURE_KCONFIG_GDB_ARG=''" >> $i
+done
+grep -v '^#' $T/batches.oldrun | awk '
+BEGIN {
+	oldbatch = 1;
+}
+
+{
+	if (oldbatch != $1) {
+		print "kvm-test-1-run-batch.sh" curbatch;
+		curbatch = "";
+		oldbatch = $1;
+	}
+	curbatch = curbatch " " $2;
+}
+
+END {
+	print "kvm-test-1-run-batch.sh" curbatch
+}' > $T/runbatches.sh
+
+if test -n "$dryrun"
+then
+	echo ---- Dryrun complete, directory: $rundir | tee -a "$rundir/log"
+else
+	( cd "$rundir"; sh $T/runbatches.sh )
+	kcsan-collapse.sh "$rundir" | tee -a "$rundir/log"
+	echo | tee -a "$rundir/log"
+	echo ---- Results directory: $rundir | tee -a "$rundir/log"
+	kvm-recheck.sh "$rundir" > $T/kvm-recheck.sh.out 2>&1
+	ret=$?
+	cat $T/kvm-recheck.sh.out | tee -a "$rundir/log"
+	echo " --- Done at `date` (`get_starttime_duration $starttime`) exitcode $ret" | tee -a "$rundir/log"
+	exit $ret
+fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
new file mode 100755
index 0000000..7ea0809e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh
@@ -0,0 +1,67 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Carry out a kvm-based run for the specified batch of scenarios, which
+# might have been built by --build-only kvm.sh run.
+#
+# Usage: kvm-test-1-run-batch.sh SCENARIO [ SCENARIO ... ]
+#
+# Each SCENARIO is the name of a directory in the current directory
+#	containing a ready-to-run qemu-cmd file.
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+T=${TMPDIR-/tmp}/kvm-test-1-run-batch.sh.$$
+trap 'rm -rf $T' 0
+mkdir $T
+
+echo ---- Running batch $*
+# Check arguments
+runfiles=
+for i in "$@"
+do
+	if ! echo $i | grep -q '^[^/.a-z]\+\(\.[0-9]\+\)\?$'
+	then
+		echo Bad scenario name: \"$i\" 1>&2
+		exit 1
+	fi
+	if ! test -d "$i"
+	then
+		echo Scenario name not a directory: \"$i\" 1>&2
+		exit 2
+	fi
+	if ! test -f "$i/qemu-cmd"
+	then
+		echo Scenario lacks a command file: \"$i/qemu-cmd\" 1>&2
+		exit 3
+	fi
+	rm -f $i/build.*
+	touch $i/build.run
+	runfiles="$runfiles $i/build.run"
+done
+
+# Extract settings from the qemu-cmd file.
+grep '^#' $1/qemu-cmd | sed -e 's/^# //' > $T/qemu-cmd-settings
+. $T/qemu-cmd-settings
+
+# Start up jitter, start each scenario, wait, end jitter.
+echo ---- System running test: `uname -a`
+echo ---- Starting kernels. `date` | tee -a log
+$TORTURE_JITTER_START
+for i in "$@"
+do
+	echo ---- System running test: `uname -a` > $i/kvm-test-1-run-qemu.sh.out
+	echo > $i/kvm-test-1-run-qemu.sh.out
+	kvm-test-1-run-qemu.sh $i >> $i/kvm-test-1-run-qemu.sh.out 2>&1 &
+done
+for i in $runfiles
+do
+	while ls $i > /dev/null 2>&1
+	do
+		:
+	done
+done
+echo ---- All kernel runs complete. `date` | tee -a log
+$TORTURE_JITTER_STOP
-- 
2.9.5

