Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB813F2446
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 03:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbhHTBEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 21:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbhHTBEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 21:04:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF71AC061757;
        Thu, 19 Aug 2021 18:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Nfe5C/ikZRIAMRtvXT6YnyM7/jPmCqTwFy+hU2RJqRQ=; b=fiIC75sFwxlPbqIuDj2grZdrKT
        fx6JFOpCpeLONZeTPL/prZ3NqShzXX2NFmKSMDyH3Aa4h9jtxQhfgg7Z0VOpxzfw7G0pf8u23DzMA
        Gfh3mQXBOlXciHXqfT674WsYFjowC5hUSdzx76Q/f4RsR0lDXw4nArAOAOcowJn6AHQfOSN5xT42f
        8u1Ly18w2jbICdvh7YYEcaxGqg+pAC2vATCs7SsGoZ2ti/wrbnInYxCJGUVby2hMTTO/1wgVWWX7i
        Bsxrv+D9pPy/7ufqKxGSSsYUJCs9iOIMlo1g1nnDHnTnrj8w55EpzC1cJi4AC5hTgjjt5KjczfabA
        HeXEFzpg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGsx1-009pcH-It; Fri, 20 Aug 2021 01:04:03 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     fstests@vger.kernel.org
Cc:     hare@suse.de, dgilbert@interlog.com, jeyu@kernel.org,
        lucas.demarchi@intel.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v5 1/2] common/module: add patient module rmmod support
Date:   Thu, 19 Aug 2021 18:04:01 -0700
Message-Id: <20210820010402.2343320-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820010402.2343320-1-mcgrof@kernel.org>
References: <20210820010402.2343320-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we call rmmod it will fail if the refcnt is greater than 0.
This is expected, however, if using test modules such as scsi_debug,
userspace tests may expect that once userspace is done issuing out
commands it can safely remove the module, and the module will be
removed.

This is not true for few reasons. First, a module might take a while
to quiesce after its used. This varies module by module. For example,
at least for scsi_debug there is one patch to help with this but
that is not sufficient to address all the removal issues, it just helps
quiesce the module faster. If something like LVM pvremove is used, as in
the case of generic/108, it may take time before the module's refcnt goes
to 0 even if DM_DEFERRED_REMOVE is *not* used and even if udevadm settle
is used. Even *after* all this... the module refcnt is still very
fickle. For example, any blkdev_open() against a block device will bump
a module refcnt up and we have little control over stopping these
sporadic userspace calls after a test. A failure on module removal then
just becomes an inconvenience on false positives.

This was first observed on scsi_debug [0]. Doug worked on a patch to
help the driver quiesce [1]. Later the issue has been determined to be
generic [2]. The only way to properly resolve these issues is with a
patient module remover. The kernel used to support a wait for the
delete_module() system call, however this was later deprecated into
kmod with a 10 second userspace sleep. That 10 second sleep is long gone
from kmod now though. I've posted patches now for a kmod patient module
remover then [3], in light of the fact that this issue is generic and
the only way to then properly deal with this is implementing a userspace
patient module remover.

Use the kmod patient module remover when supported, otherwise we open
code our own solution inside fstests. We default to a timeout of 100
seconds. Each test can override the timeout by setting the variable
MODPROBE_PATIENT_RM_TIMEOUT_SECONDS or setting it to "forever" if they
wish for the patience to be infinite.

This uses kmod's patient module remover if you have that feature,
otherwise we open code a solution in fstests which is a simplified
version of what has been proposed for kmod.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
[1] https://lore.kernel.org/linux-scsi/20210508230745.27923-1-dgilbert@interlog.com/
[2] https://bugzilla.kernel.org/show_bug.cgi?id=214015
[3] https://lkml.kernel.org/r/20210810051602.3067384-1-mcgrof@kernel.org
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 README        |   4 ++
 common/config |  31 +++++++++++++++
 common/module | 108 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 143 insertions(+)

diff --git a/README b/README
index b9877b7d..84c217ce 100644
--- a/README
+++ b/README
@@ -121,6 +121,10 @@ Preparing system for tests:
                filesystem we can create. Setting this parameter will
                skip the tests creating a filesystem less than
                MIN_FSSIZE.
+	     - Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to specify the amount of
+	       time we should try a patient module remove. The default is 50
+	       seconds. Set this to "forever" and we'll wait forever until the
+	       module is gone.
 
         - or add a case to the switch in common/config assigning
           these variables based on the hostname of your test
diff --git a/common/config b/common/config
index 005fd50a..164381b7 100644
--- a/common/config
+++ b/common/config
@@ -252,6 +252,37 @@ if [[ "$UDEV_SETTLE_PROG" == "" || ! -d /proc/net ]]; then
 fi
 export UDEV_SETTLE_PROG
 
+# Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
+# modprobe removal to run forever trying to remove a module.
+MODPROBE_REMOVE_PATIENT=""
+modprobe --help | grep -q -1 "remove-patiently"
+if [[ $? -ne 0 ]]; then
+	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+		# We will open code our own implementation of patient module
+		# remover in fstests. Use a 50 second default.
+		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
+	fi
+else
+	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
+	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
+		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" != "forever" ]]; then
+			MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
+			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+		fi
+	else
+		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
+		# with environments without support for modprobe -p, but we
+		# only really need it exported right now for environments which
+		# don't have support for modprobe -p to implement our own
+		# patient module removal support within fstests.
+		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="50"
+		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
+		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
+	fi
+	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_TIMEOUT_ARGS"
+fi
+export MODPROBE_REMOVE_PATIENT
+
 export MKFS_XFS_PROG=$(type -P mkfs.xfs)
 export MKFS_EXT4_PROG=$(type -P mkfs.ext4)
 export MKFS_UDF_PROG=$(type -P mkudffs)
diff --git a/common/module b/common/module
index 39e4e793..0392f20c 100644
--- a/common/module
+++ b/common/module
@@ -81,3 +81,111 @@ _get_fs_module_param()
 {
 	cat /sys/module/${FSTYP}/parameters/${1} 2>/dev/null
 }
+
+# checks the refcount and returns 0 if we can safely remove the module. rmmod
+# does this check for us, but we can use this to also iterate checking for this
+# refcount before we even try to remove the module. This is useful when using
+# debug test modules which take a while to quiesce.
+_patient_rmmod_check_refcnt()
+{
+	local module=$1
+	local refcnt=0
+
+	if [[ -f /sys/module/$module/refcnt ]]; then
+		refcnt=$(cat /sys/module/$module/refcnt 2>/dev/null)
+		if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
+			return 0
+		fi
+		return 1
+	fi
+	return 0
+}
+
+# Patiently tries to wait to remove a module by ensuring first
+# the refcnt is 0 and then trying to persistently remove the module within
+# the time allowed. The timeout is configurable per test, just set
+# MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to including this file.
+# If you want this to try forever just set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
+# to the special value of "forever". This applies to both cases where kmod
+# supports the patient module remover (modrobe -p) and where it does not.
+#
+# If your version of kmod supports modprobe -p, we instead use that
+# instead. Otherwise we have to implement a patient module remover
+# ourselves.
+_patient_rmmod()
+{
+	local module=$1
+	local max_tries_max=$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
+	local max_tries=0
+	local mod_ret=0
+	local refcnt_is_zero=0
+
+	if [[ ! -z $MODPROBE_REMOVE_PATIENT ]]; then
+		$MODPROBE_REMOVE_PATIENT $module
+		mod_ret=$?
+		if [[ $mod_ret -ne 0 ]]; then
+			echo "kmod patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max returned $mod_ret"
+		fi
+		return $mod_ret
+	fi
+
+	max_tries=$max_tries_max
+
+	# We must use a string check as otherwise if max_tries is set to
+	# "forever" and we don't use a string check we can end up skipping
+	# entering this loop.
+	while [[ "$max_tries" != "0" ]]; do
+		_patient_rmmod_check_refcnt $module
+		if [[ $? -eq 0 ]]; then
+			refcnt_is_zero=1
+			break
+		fi
+		sleep 1
+		if [[ "$max_tries" == "forever" ]]; then
+			continue
+		fi
+		let max_tries=$max_tries-1
+	done
+
+	if [[ $refcnt_is_zero -ne 1 ]]; then
+		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max"
+		return -1
+	fi
+
+	# If we ran out of time but our refcnt check confirms we had
+	# a refcnt of 0, just try to remove the module once.
+	if [[ "$max_tries" == "0" ]]; then
+		modprobe -r $module
+		return $?
+	fi
+
+	# If we have extra time left. Use the time left to now try to
+	# persistently remove the module. We do this because although through
+	# the above we found refcnt to be 0, removal can still fail since
+	# userspace can always race to bump the refcnt. An example is any
+	# blkdev_open() calls against a block device. These issues have been
+	# tracked and documented in the following bug reports, which justifies
+	# our need to do this in userspace:
+	# https://bugzilla.kernel.org/show_bug.cgi?id=212337
+	# https://bugzilla.kernel.org/show_bug.cgi?id=214015
+	while [[ $max_tries != 0 ]]; do
+		if [[ -d /sys/module/$module ]]; then
+			modprobe -r $module 2> /dev/null
+			mod_ret=$?
+			if [[ $mod_ret == 0 ]]; then
+				break;
+			fi
+			sleep 1
+			if [[ "$max_tries" == "forever" ]]; then
+				continue
+			fi
+			let max_tries=$max_tries-1
+		fi
+	done
+
+	if [[ $mod_ret -ne 0 ]]; then
+		echo "custom patient module removal for $module timed out trying to remove $module using timeout of $max_tries_max last try returned $mod_ret"
+	fi
+
+	return $mod_ret
+}
-- 
2.30.2

