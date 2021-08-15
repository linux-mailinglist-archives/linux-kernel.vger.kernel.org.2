Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 199B73EC8FC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 14:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238047AbhHOMaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 08:30:16 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:33640 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237963AbhHOMaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 08:30:15 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437576|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0345704-0.00313027-0.962299;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=guan@eryu.me;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.L.e0yvt_1629030582;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.L.e0yvt_1629030582)
          by smtp.aliyun-inc.com(10.147.41.231);
          Sun, 15 Aug 2021 20:29:42 +0800
Date:   Sun, 15 Aug 2021 20:29:42 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, hare@suse.de, dgilbert@interlog.com,
        jeyu@kernel.org, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] common/module: add patient module rmmod support
Message-ID: <YRkIttM75q3gLxpN@desktop>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
 <20210811154512.1813622-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811154512.1813622-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2021 at 08:45:11AM -0700, Luis Chamberlain wrote:
> When we call rmmod it will fail if the refcnt is greater than 0.
> This is expected, however, if using test modules such as scsi_debug,
> userspace tests may expect that once userspace is done issuing out
> commands it can safely remove the module, and the module will be
> removed.
> 
> This is not true for few reasons. First, a module might take a while
> to quiesce after its used. This varies module by module. For example,
> at least for scsi_debug there is one patch to help with this but
> that is not sufficient to address all the removal issues, it just helps
> quiesce the module faster. If something like LVM pvremove is used, as in
> the case of generic/108, it may take time before the module's refcnt goes
> to 0 even if DM_DEFERRED_REMOVE is *not* used and even if udevadm settle
> is used. Even *after* all this... the module refcnt is still very
> fickle. For example, any blkdev_open() against a block device will bump
> a module refcnt up and we have little control over stopping these
> sporadic userspace calls after a test. A failure on module removal then
> just becomes an inconvenience on false positives.
> 
> This was first observed on scsi_debug [0]. Doug worked on a patch to
> help the driver quiesce [1]. Later the issue has been determined to be
> generic [2]. The only way to properly resolve these issues is with a
> patient module remover. The kernel used to support a wait for the
> delete_module() system call, however this was later deprecated into
> kmod with a 10 second userspace sleep. That 10 second sleep is long gone
> from kmod now though. I've posted patches now for a kmod patient module
> remover then [3], in light of the fact that this issue is generic and
> the only way to then properly deal with this is implementing a userspace
> patient module remover.
> 
> Use the kmod patient module remover when supported, otherwise we open
> code our own solution inside fstests. We default to a timeout of 100
> seconds. Each test can override the timeout by setting the variable
> MODPROBE_PATIENT_RM_TIMEOUT_SECONDS or setting it to "forever" if they
> wish for the patience to be infinite.
> 
> This uses kmod's patient module remover if you have that feature,
> otherwise we open code a solution in fstests which is a simplified
> version of what has been proposed for kmod.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
> [1] https://lore.kernel.org/linux-scsi/20210508230745.27923-1-dgilbert@interlog.com/
> [2] https://bugzilla.kernel.org/show_bug.cgi?id=214015
> [3] https://lkml.kernel.org/r/20210810051602.3067384-1-mcgrof@kernel.org
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/config |  31 +++++++++++++++
>  common/module | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++

Please also update README to document the new configurable variables.

>  2 files changed, 138 insertions(+)
> 
> diff --git a/common/config b/common/config
> index 005fd50a..9b8a2bc4 100644
> --- a/common/config
> +++ b/common/config
> @@ -252,6 +252,37 @@ if [[ "$UDEV_SETTLE_PROG" == "" || ! -d /proc/net ]]; then
>  fi
>  export UDEV_SETTLE_PROG
>  
> +# Set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS to "forever" if you want the patient
> +# modprobe removal to run forever trying to remove a module.
> +MODPROBE_REMOVE_PATIENT=""
> +modprobe --help | grep -q -1 "remove-patiently"
> +if [[ $? -ne 0 ]]; then
> +	if [[ -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> +		# We will open code our own implementation of patien module
> +		# remover in fstests. Use 100 second default.
> +		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="100"

100s as default seems a bit long to me, use 10s as in v1 patch?

> +	fi
> +else
> +	MODPROBE_RM_PATIENT_TIMEOUT_ARGS=""
> +	if [[ ! -z "$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS" ]]; then
> +		if [[ "$MODPROBE_PATIENT_RM_TIMEOUT_MS" != "forever" ]]; then

Should check MODPROBE_PATIENT_RM_TIMEOUT_SECONDS instead?

> +			MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
> +			MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
> +		fi
> +	else
> +		# We export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS here for parity
> +		# with environments without support for modprobe -p, but we
> +		# only really need it exported right now for environments which
> +		# don't have support for modprobe -p to implement our own
> +		# patient module removal support within fstests.
> +		export MODPROBE_PATIENT_RM_TIMEOUT_SECONDS="100"
> +		MODPROBE_PATIENT_RM_TIMEOUT_MS="$((MODPROBE_PATIENT_RM_TIMEOUT_SECONDS * 1000))"
> +		MODPROBE_RM_PATIENT_TIMEOUT_ARGS="-t $MODPROBE_PATIENT_RM_TIMEOUT_MS"
> +	fi
> +	MODPROBE_REMOVE_PATIENT="modprobe -p $MODPROBE_RM_TIMEOUT_ARGS"
> +fi
> +export MODPROBE_REMOVE_PATIENT
> +
>  export MKFS_XFS_PROG=$(type -P mkfs.xfs)
>  export MKFS_EXT4_PROG=$(type -P mkfs.ext4)
>  export MKFS_UDF_PROG=$(type -P mkudffs)
> diff --git a/common/module b/common/module
> index 39e4e793..03953fa1 100644
> --- a/common/module
> +++ b/common/module
> @@ -4,6 +4,8 @@
>  #
>  # Routines for messing around with loadable kernel modules
>  
> +source common/config
> +

Seems there's no need to source common/config here, as it's sourced in
common/rc, which is sourced by every test.

>  # Return the module name for this fs.
>  _module_for_fs()
>  {
> @@ -81,3 +83,108 @@ _get_fs_module_param()
>  {
>  	cat /sys/module/${FSTYP}/parameters/${1} 2>/dev/null
>  }
> +
> +# checks the refcount and returns 0 if we can safely remove the module. rmmod
> +# does this check for us, but we can use this to also iterate checking for this
> +# refcount before we even try to remove the module. This is useful when using
> +# debug test modules which take a while to quiesce.
> +_patient_rmmod_check_refcnt()
> +{
> +	local module=$1
> +	local refcnt=0
> +
> +	if [[ -f /sys/module/$module/refcnt ]]; then
> +		refcnt=$(cat /sys/module/$module/refcnt 2>/dev/null)
> +		if [[ $? -ne 0 || $refcnt -eq 0 ]]; then
> +			return 0
> +		fi
> +		return 1
> +	fi
> +	return 0
> +}
> +
> +# Patiently tries to wait to remove a module by ensuring first
> +# the refcnt is 0 and then trying to persistently remove the module within
> +# the time allowed. The timeout is configurable per test, just set
> +# MODPROBE_PATIENT_RM_TIMEOUT_SECONDS prior to including this file.
> +# If you want this to try forever just set MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
> +# to the special value of "forever". This applies to both cases where kmod
> +# supports the patient module remover (modrobe -p) and where it does not.
> +#
> +# If your version of kmod supports modprobe -p, we instead use that
> +# instead. Otherwise we have to implement a patient module remover
> +# ourselves.
> +_patient_rmmod()
> +{
> +	local module=$1
> +	local max_tries_max=$MODPROBE_PATIENT_RM_TIMEOUT_SECONDS
> +	local max_tries=0
> +	local mod_ret=0
> +	local refcnt_is_zero=0
> +
> +	if [[ ! -z $MODPROBE_REMOVE_PATIENT ]]; then
> +		$MODPROBE_REMOVE_PATIENT $module
> +		mod_ret=$?
> +		if [[ $mod_ret -ne 0 ]]; then
> +			echo "kmod patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max returned $mod_ret"
> +		fi
> +		return $mod_ret
> +	fi
> +
> +	max_tries=$max_tries_max
> +
> +	while [[ "$max_tries" != "0" ]]; do

Use "$max_tries -ne 0" to check inters seems better.

> +		_patient_rmmod_check_refcnt $module
> +		if [[ $? -eq 0 ]]; then

Like above

> +			refcnt_is_zero=1
> +			break
> +		fi
> +		sleep 1
> +		if [[ "$max_tries" == "forever" ]]; then
> +			continue
> +		fi
> +		let max_tries=$max_tries-1
> +	done
> +
> +	if [[ $refcnt_is_zero -ne 1 ]]; then
> +		echo "custom patient module removal for $module timed out waiting for refcnt to become 0 using timeout of $max_tries_max"
> +		return -1
> +	fi
> +
> +	# If we ran out of time but our refcnt check confirms we had
> +	# a refcnt of 0, just try to remove the module once.
> +	if [[ "$max_tries" == "0" ]]; then

$max_tries -eq 0

Thanks,
Eryu

> +		modprobe -r $module
> +		return $?
> +	fi
> +
> +	# If we have extra time left. Use the time left to now try to
> +	# persistently remove the module. We do this because although through
> +	# the above we found refcnt to be 0, removal can still fail since
> +	# userspace can always race to bump the refcnt. An example is any
> +	# blkdev_open() calls against a block device. These issues have been
> +	# tracked and documented in the following bug reports, which justifies
> +	# our need to do this in userspace:
> +	# https://bugzilla.kernel.org/show_bug.cgi?id=212337
> +	# https://bugzilla.kernel.org/show_bug.cgi?id=214015
> +	while [[ $max_tries != 0 ]]; do
> +		if [[ -d /sys/module/$module ]]; then
> +			modprobe -r $module 2> /dev/null
> +			mod_ret=$?
> +			if [[ $mod_ret == 0 ]]; then
> +				break;
> +			fi
> +			sleep 1
> +			if [[ "$max_tries" == "forever" ]]; then
> +				continue
> +			fi
> +			let max_tries=$max_tries-1
> +		fi
> +	done
> +
> +	if [[ $mod_ret -ne 0 ]]; then
> +		echo "custom patient module removal for $module timed out trying to remove $module using timeout of $max_tries_max last try returned $mod_ret"
> +	fi
> +
> +	return $mod_ret
> +}
> -- 
> 2.30.2
