Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38203375484
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhEFNQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233327AbhEFNQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:16:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 46229613C2;
        Thu,  6 May 2021 13:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620306918;
        bh=nTr/gFQfdzF0LhJ7VNXhmo9HOsu0CSUQyFoaljuwPn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LGMouJlBEnuEK9HlSaqS8pE0p3LzC4HW+Tn9f4NHDVXeT31fEpfzGXfNPUdKG1ExV
         mj9+HC1uOANHjx5hpzSvgfx3dAElXXp9kTkvM5BasFmSJnMmMOWldtMkDtwqz3S8+Y
         dJe3+s2+gBZoVGKJGSbHurZ9X4r6kUWplCz8y86xcT4SQF0rW2Mfxh/4uUL7SGkijl
         L8Ig0EL/NTOEGNe5BwxGZMUJ/sc9Ec6Pf8HmKIeKyw2CaXvi+lq1iTzF0xKOYFwiVa
         X9A1Tknw35YfEzNxjesKgtCiVn4ir0ps51TcDRfK2ayelv2f9EK53yl6sgHDsA6hI3
         FLpHlbczMIuVg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 2/3] torture: Add --configonly parameter for kvm.sh
Date:   Thu,  6 May 2021 15:15:09 +0200
Message-Id: <20210506131510.51488-3-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506131510.51488-1-frederic@kernel.org>
References: <20210506131510.51488-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those who just want the resulting config file to generate for bare metal
don't need to wait for the build. Provide an option to only produce
the .config file.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-build.sh     |  5 ++++
 .../selftests/rcutorture/bin/kvm-recheck.sh   |  6 ++++-
 .../rcutorture/bin/kvm-test-1-run.sh          | 12 ++++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh | 26 +++++++++++++------
 4 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 9eb4324d42e1..463db5590220 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -43,6 +43,11 @@ then
 	exit 2
 fi
 
+if test -n "$TORTURE_CONFIGONLY"
+then
+    exit 0
+fi
+
 # Tell "make" to use double the number of real CPUs on the build system.
 ncpus="`getconf _NPROCESSORS_ONLN`"
 make -j$((2 * ncpus)) $TORTURE_KMAKE_ARG > $resdir/Make.out 2>&1
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
index e01b31b87044..68b521b5961e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh
@@ -57,7 +57,11 @@ do
 				cat $i/Warnings
 			fi
 		else
-			if test -f "$i/buildonly"
+			if test -f "$i/configonly"
+			then
+				echo Config-only run, no build/boot/test
+				configcheck.sh $i/.config $i/ConfigFragment
+			elif test -f "$i/buildonly"
 			then
 				echo Build-only run, no boot/test
 				configcheck.sh $i/.config $i/ConfigFragment
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index e6aece69d81b..6df9efc77469 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -113,11 +113,21 @@ then
 	exit 1
 elif kvm-build.sh $T/KcList $resdir "$kboot_args" "$modprobe_args"
 then
+	cp .config $resdir
+	if test -n "$TORTURE_CONFIGONLY"
+	then
+		if test -f $resdir/build.wait
+		then
+			rm $resdir/build.wait
+		fi
+		echo Config-only run specified, build/boot/test omitted.
+		touch $resdir/configonly
+		exit 0
+	fi
 	# Had to build a kernel for this test.
 	QEMU="`identify_qemu vmlinux`"
 	BOOT_IMAGE="`identify_boot_image $QEMU`"
 	cp vmlinux $resdir
-	cp .config $resdir
 	cp Module.symvers $resdir > /dev/null || :
 	cp System.map $resdir > /dev/null || :
 	if test -n "$BOOT_IMAGE"
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index a05a20135de1..283f5d896234 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -34,6 +34,7 @@ TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_BUILDONLY=
 TORTURE_CMDLINE2CONFIG=
+TORTURE_CONFIGONLY=
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
@@ -66,6 +67,7 @@ usage () {
 	echo "       --bootimage relative-path-to-kernel-boot-image"
 	echo "       --buildonly"
 	echo "       --cmdline-to-config"
+	echo "       --configonly"
 	echo "       --configs \"config-file list w/ repeat factor (3*TINY01)\""
 	echo "       --cpus N"
 	echo "       --datestamp string"
@@ -113,6 +115,9 @@ do
 	--cmdline-to-config)
 		TORTURE_CMDLINE2CONFIG=1
 		;;
+	--configonly|--config-only)
+		TORTURE_CONFIGONLY=1
+		;;
 	--configs|--config)
 		checkarg --configs "(list of config files)" "$#" "$2" '^[^/.a-z]\+$' '^--'
 		configs="$configs $2"
@@ -394,6 +399,7 @@ TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
 TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
 TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
 TORTURE_CMDLINE2CONFIG="$TORTURE_CMDLINE2CONFIG"; export TORTURE_CMDLINE2CONFIG
+TORTURE_CONFIGONLY="$TORTURE_CONFIGONLY"; export TORTURE_CONFIGONLY
 TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
 TORTURE_INITRD="$TORTURE_INITRD"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG="$TORTURE_KCONFIG_ARG"; export TORTURE_KCONFIG_ARG
@@ -438,6 +444,7 @@ fi
 ___EOF___
 awk < $T/cfgcpu.pack \
 	-v TORTURE_BUILDONLY="$TORTURE_BUILDONLY" \
+	-v TORTURE_CONFIGONLY="$TORTURE_CONFIGONLY" \
 	-v CONFIGDIR="$CONFIGFRAG/" \
 	-v KVM="$KVM" \
 	-v ncpus=$cpus \
@@ -490,12 +497,14 @@ function dump(first, pastlast, batchnum)
 		print "mkdir " rd cfr[jn] " || :";
 		print "touch " builddir ".wait";
 		print "kvm-test-1-run.sh " CONFIGDIR cf[j], rd cfr[jn], dur " \"" TORTURE_QEMU_ARG "\" \"" TORTURE_BOOTARGS "\" > " rd cfr[jn]  "/kvm-test-1-run.sh.out 2>&1 &"
-		print "echo ", cfr[jn], cpusr[jn] ovf ": Waiting for build to complete. `date` | tee -a " rd "log";
-		print "while test -f " builddir ".wait"
-		print "do"
-		print "\tsleep 1"
-		print "done"
-		print "echo ", cfr[jn], cpusr[jn] ovf ": Build complete. `date` | tee -a " rd "log";
+		if (!TORTURE_CONFIGONLY) {
+			print "echo ", cfr[jn], cpusr[jn] ovf ": Waiting for build to complete. `date` | tee -a " rd "log";
+			print "while test -f " builddir ".wait"
+			print "do"
+			print "\tsleep 1"
+			print "done"
+			print "echo ", cfr[jn], cpusr[jn] ovf ": Build complete. `date` | tee -a " rd "log";
+		}
 		jn++;
 	}
 	print "runfiles="
@@ -503,7 +512,7 @@ function dump(first, pastlast, batchnum)
 		builddir=rd cfr[j] "/build";
 		if (TORTURE_BUILDONLY)
 			print "rm -f " builddir ".ready"
-		else
+		else if (!TORTURE_CONFIGONLY)
 			print "mv " builddir ".ready " builddir ".run"
 			print "runfiles=\"$runfiles " builddir ".run\""
 		fi
@@ -517,7 +526,8 @@ function dump(first, pastlast, batchnum)
 		njitter = 0;
 		print "echo Build-only run, so suppressing jitter | tee -a " rd "log"
 	}
-	if (TORTURE_BUILDONLY) {
+
+	if (TORTURE_BUILDONLY || TORTURE_CONFIGONLY) {
 		print "needqemurun="
 	}
 	print "if test -n \"$needqemurun\""
-- 
2.25.1

