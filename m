Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5175375485
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhEFNQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:40792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233521AbhEFNQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:16:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EE0E61042;
        Thu,  6 May 2021 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620306919;
        bh=op5ex0Fi0Betr2wW0CnZmbJS/BItv19K7TubLeKLbxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z/ZVl76QgCTkqTmxLGuVHc9CvcDL/+h2UVorkUG5WLTnJ0//+ijHvok1wgpoi/ciJ
         YtwUCJjA0ETRPX66J8teG1/Gkg6RpGjd4cmWDCQ3HASqcoC1J1TBnYD/Au0a5364SN
         JkwjuMyu4BYj7uK7CkpzCto6bnG+pvPEL1PRk5m6KOqJXXEg0dLbmT+ae9Fr7oOzmw
         wkxNQmzCPrD7dqHljlxX5MDxiNpYAkLAl7Yg72SNF8pHTO8C8A+VT9TLsDPYJQEEOT
         Yvx5nauN6Bez7IstSKOtqzsOBllYhoUyKY6N+AyhwBjTlbd76y81O54BMzW1MVQXkJ
         q2JdfUO7PwS9w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 3/3] torture: Update bare metal advices to latest kvm.sh options
Date:   Thu,  6 May 2021 15:15:10 +0200
Message-Id: <20210506131510.51488-4-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210506131510.51488-1-frederic@kernel.org>
References: <20210506131510.51488-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kvm.sh is perfectly able to build a new kernel config from an existing
one instead of using a defconfig. All we need to do is to pass:

	--defconfig oldconfig

This is much easier than manually modifying a .config from a
ConfigFragment file.

Then with the latest parameters that got added on kvm.sh, it's now
easy to build a bare metal .config for a cross target for example:

	./kvm.sh --configs "TREE01" --defconfig oldconfig --configonly
		--cmdline-to-config --kmake-arg ARCH=arm64 --no-initrd

After that all we need to do is to build the updated .config and run
the resulting image.

Update bare metal advices to propose that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 .../rcutorture/bin/kvm-test-1-run.sh          | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 6df9efc77469..47d69668ab37 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -190,27 +190,28 @@ echo To run this scenario on bare metal: >> $resdir/bare-metal
 echo >> $resdir/bare-metal
 echo " 1." Set your bare-metal build tree to the state shown in this file: >> $resdir/bare-metal
 echo "   " $testid_txt >> $resdir/bare-metal
-echo " 2." Update your bare-metal build tree"'"s .config based on this file: >> $resdir/bare-metal
-echo "   " $resdir/ConfigFragment >> $resdir/bare-metal
-echo " 3." Make the bare-metal kernel"'"s build system aware of your .config updates: >> $resdir/bare-metal
-echo "   " $ 'yes "" | make oldconfig' >> $resdir/bare-metal
-echo " 4." Build your bare-metal kernel. >> $resdir/bare-metal
+echo " 2." Prepare your bare-metal build tree"'"s .config on your root kernel directory >> $resdir/bare-metal
+echo " 3." Run this scenario with "'--defconfig oldconfig --configonly --no-initrd'" >> $resdir/bare-metal
+echo " 4." If you"'"re cross compiling then append the appropriate make arguments >> $resdir/bare-metal
+echo "   " eg: "'--kmake-arg ARCH=arm64'" >> $resdir/bare-metal
 echo " 5." Boot your bare-metal kernel with the following parameters: >> $resdir/bare-metal
 echo "   " $kboot_args >> $resdir/bare-metal
 echo " 6." Start the test with the following command: >> $resdir/bare-metal
 echo "   " $ modprobe $TORTURE_MOD $modprobe_args >> $resdir/bare-metal
 echo " 7." After some time, end the test with the following command: >> $resdir/bare-metal
 echo "   " $ rmmod $TORTURE_MOD >> $resdir/bare-metal
-echo " 8." Copy your bare-metal kernel"'"s .config file, overwriting this file: >> $resdir/bare-metal
+echo " 8." Alternatively if you run rcutorture in a built-in fashion and your kernel arguments are already >> $resdir/bare-metal
+echo "   " hardcoded in the kernel config, skip the previous 5/6/7 steps and append to kvm.sh arguments: >> $resdir/bare-metal
+echo "   " --cmdline-to-config >> $resdir/bare-metal
+echo "   " Then simply boot your kernel and wait for the end of the tests >> $resdir/bare-metal
+echo " 9." Copy your bare-metal kernel"'"s .config file, overwriting this file: >> $resdir/bare-metal
 echo "   " $resdir/.config >> $resdir/bare-metal
-echo " 9." Copy the console output from just before the modprobe to just after >> $resdir/bare-metal
+echo "10." Copy the console output from just before the modprobe to just after >> $resdir/bare-metal
 echo "   " the rmmod into this file: >> $resdir/bare-metal
 echo "   " $resdir/console.log >> $resdir/bare-metal
-echo "10." Check for runtime errors using the following command: >> $resdir/bare-metal
+echo "11." Check for runtime errors using the following command: >> $resdir/bare-metal
 echo "   " $ tools/testing/selftests/rcutorture/bin/kvm-recheck.sh `dirname $resdir` >> $resdir/bare-metal
 echo >> $resdir/bare-metal
-echo Some of the above steps may be skipped if you build your bare-metal >> $resdir/bare-metal
-echo kernel here: `head -n 1 $testid_txt | sed -e 's/^Build directory: //'`  >> $resdir/bare-metal
 
 echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
 echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
-- 
2.25.1

