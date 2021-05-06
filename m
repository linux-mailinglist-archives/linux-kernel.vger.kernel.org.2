Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55822375483
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbhEFNQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232756AbhEFNQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:16:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E710661042;
        Thu,  6 May 2021 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620306916;
        bh=vTvzD/eo59vZ9YZesgK+Sp65q+1dNs+voHFYeCZGtiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vjk3dyCOqrC9mkWiXJ2noHt2CpLCRIyPAYr1bVmyGoGImpQ3CqgaxhigqMnLY0S7J
         MoKcRypf4zMjqPZgWhRB/krGhPBasEW2QpoQ7jlKwL6EZkE4HDcqZ63PJdguzgWqru
         9G22vJA0xsQWJrc2Qe5ivd5zjfMA5zYbyZZLsZfTdV8s9EXpwlLisDUZtmaFdF4QPk
         ruEX5FVDXegArCEXSrNiF0fLPePpz5aigvcCv1HQd5fasId/tTyWn8edlcLX+grHTW
         mDktYW7wUZmZrXuHb9Ru594g2rEpSA87Yvn4DgBKytxBaRFNpUNfLHoCq0GROHbnv8
         IJedylSslV8aA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 1/3] torture: Add --cmdline-to-config parameter to kvm.sh
Date:   Thu,  6 May 2021 15:15:08 +0200
Message-Id: <20210506131510.51488-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506131510.51488-1-frederic@kernel.org>
References: <20210506131510.51488-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running rcutorture on bare metal, an easy way to test is to build
a kernel with the torture scenario parameters built-in using
CONFIG_CMDLINE="". This way the remote box can simply download the image
and the boot loader doesn't need to be updated with the new kernel
parameters.

Provide kvm.sh with --cmdline-to-config to perform that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../selftests/rcutorture/bin/configinit.sh    | 13 +++++++
 .../selftests/rcutorture/bin/kvm-build.sh     |  4 ++-
 .../rcutorture/bin/kvm-test-1-run.sh          | 34 +++++++++++--------
 tools/testing/selftests/rcutorture/bin/kvm.sh |  6 ++++
 4 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
index d6e5ce084b1c..d2b8a68114e4 100755
--- a/tools/testing/selftests/rcutorture/bin/configinit.sh
+++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
@@ -23,6 +23,8 @@ mkdir $T
 
 c=$1
 resdir=$2
+kboot_args=$3
+modprobe_args=$4
 
 sed -e 's/^\(CONFIG[0-9A-Z_]*\)=.*$/grep -v "^# \1" |/' < $c > $T/u.sh
 sed -e 's/^\(CONFIG[0-9A-Z_]*=\).*$/grep -v \1 |/' < $c >> $T/u.sh
@@ -35,6 +37,17 @@ fi
 make $TORTURE_KMAKE_ARG $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
 mv .config .config.sav
 sh $T/upd.sh < .config.sav > .config
+
+if test -n "$TORTURE_CMDLINE2CONFIG"
+then
+	cmdline=$(grep "CONFIG_CMDLINE=" .config | sed -E 's/CONFIG_CMDLINE="(.*)"/\1/')
+	prefixed_modprobe_args=$(echo $modprobe_args | sed -E -e "s/([^ ]+?)(=[^ ]*)?/rcutorture.\1\2/g")
+	cmdline="$kboot_args $prefixed_modprobe_args $cmdline"
+	grep -Ev "CONFIG_CMDLINE[= ]" .config > .config.sav
+	mv .config.sav .config
+	echo "CONFIG_CMDLINE=\""$cmdline"\"" >> .config
+fi
+
 cp .config .config.new
 yes '' | make $TORTURE_KMAKE_ARG oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
index 5ad973dca820..9eb4324d42e1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
@@ -22,6 +22,8 @@ then
 	exit 1
 fi
 resdir=${2}
+kboot_args=${3}
+modprobe_args=${4}
 
 T=${TMPDIR-/tmp}/test-linux.sh.$$
 trap 'rm -rf $T' 0
@@ -34,7 +36,7 @@ CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_CONSOLE=y
 ___EOF___
 
-configinit.sh $T/config $resdir
+configinit.sh $T/config $resdir "$kboot_args" "$modprobe_args"
 retval=$?
 if test $retval -gt 1
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 420ed5ce9d32..e6aece69d81b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -71,6 +71,24 @@ config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
 cp $T/KcList $resdir/ConfigFragment
 
+seconds=$3
+qemu_args=$4
+boot_args_in=$5
+
+# Pull in Kconfig-fragment boot parameters
+boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
+# Generate kernel-version-specific boot parameters
+boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
+
+if test -n "$TORTURE_BOOT_GDB_ARG"
+then
+	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
+fi
+
+modprobe_args="`echo $boot_args | tr -s ' ' '\012' | grep "^$TORTURE_MOD\." | sed -e "s/$TORTURE_MOD\.//g"`"
+kboot_args="`echo $boot_args | tr -s ' ' '\012' | grep -v "^$TORTURE_MOD\."`"
+
+
 base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
 if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f $base_resdir/vmlinux
 then
@@ -93,7 +111,7 @@ then
 		mv $resdir/build.wait $resdir/build.ready
 	fi
 	exit 1
-elif kvm-build.sh $T/KcList $resdir
+elif kvm-build.sh $T/KcList $resdir "$kboot_args" "$modprobe_args"
 then
 	# Had to build a kernel for this test.
 	QEMU="`identify_qemu vmlinux`"
@@ -131,9 +149,6 @@ while test -f $resdir/build.ready
 do
 	sleep 1
 done
-seconds=$3
-qemu_args=$4
-boot_args_in=$5
 
 if test -z "$TORTURE_BUILDONLY"
 then
@@ -158,18 +173,7 @@ qemu_args="$qemu_args `identify_qemu_args "$QEMU" "$resdir/console.log"`"
 # Generate qemu -append arguments
 qemu_append="`identify_qemu_append "$QEMU"`"
 
-# Pull in Kconfig-fragment boot parameters
-boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
-# Generate kernel-version-specific boot parameters
-boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
-if test -n "$TORTURE_BOOT_GDB_ARG"
-then
-	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
-fi
-
 # Give bare-metal advice
-modprobe_args="`echo $boot_args | tr -s ' ' '\012' | grep "^$TORTURE_MOD\." | sed -e "s/$TORTURE_MOD\.//g"`"
-kboot_args="`echo $boot_args | tr -s ' ' '\012' | grep -v "^$TORTURE_MOD\."`"
 testid_txt="`dirname $resdir`/testid.txt"
 touch $resdir/bare-metal
 echo To run this scenario on bare metal: >> $resdir/bare-metal
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index b4ac4ee33222..a05a20135de1 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -33,6 +33,7 @@ TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_BUILDONLY=
+TORTURE_CMDLINE2CONFIG=
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
@@ -64,6 +65,7 @@ usage () {
 	echo "       --bootargs kernel-boot-arguments"
 	echo "       --bootimage relative-path-to-kernel-boot-image"
 	echo "       --buildonly"
+	echo "       --cmdline-to-config"
 	echo "       --configs \"config-file list w/ repeat factor (3*TINY01)\""
 	echo "       --cpus N"
 	echo "       --datestamp string"
@@ -108,6 +110,9 @@ do
 	--buildonly|--build-only)
 		TORTURE_BUILDONLY=1
 		;;
+	--cmdline-to-config)
+		TORTURE_CMDLINE2CONFIG=1
+		;;
 	--configs|--config)
 		checkarg --configs "(list of config files)" "$#" "$2" '^[^/.a-z]\+$' '^--'
 		configs="$configs $2"
@@ -388,6 +393,7 @@ PATH="$PATH"; export PATH
 TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
 TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
 TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
+TORTURE_CMDLINE2CONFIG="$TORTURE_CMDLINE2CONFIG"; export TORTURE_CMDLINE2CONFIG
 TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
 TORTURE_INITRD="$TORTURE_INITRD"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG="$TORTURE_KCONFIG_ARG"; export TORTURE_KCONFIG_ARG
-- 
2.25.1

