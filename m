Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899E0376A9F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 21:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhEGTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 15:21:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhEGTVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 15:21:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE24660FD7;
        Fri,  7 May 2021 19:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620415209;
        bh=gg837bJNuriV809ittHBKFQVmm43CpV7GRjwAdw357k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=geul1QjCQyax7vPCUImAAu2HBe45gM8ANrzMSqyZ5hDUPZZritEad+KsEq5xBQSWD
         YYMAB0EERA6F0tRokrTsRy/jdqL9B0FyzAjTiyOZlkSAXc/wE3f1CZU9TdCrW1s4LB
         Bmk2a2Z9gzvmuTeH3qypMM/2FP49oF0qF3DJ+xg21po32SHwS3Cmg8285teCN0VRXv
         o0qMFM/EYHKas+rA372p7R481gNrZ7DGJSoc7xu5rX5B5vmX3sjRnaW5yTjb2p/CX9
         TQMagOV5EtZOVb3UzfwpxeXAtK5GddVPRMAEsO86DsFBNMniwlbjthjsOLw8b4w+nX
         fPXC/BNilcEVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 711355C0293; Fri,  7 May 2021 12:20:09 -0700 (PDT)
Date:   Fri, 7 May 2021 12:20:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] torture: Add --cmdline-to-config parameter to kvm.sh
Message-ID: <20210507192009.GY975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210506131510.51488-1-frederic@kernel.org>
 <20210506131510.51488-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506131510.51488-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 03:15:08PM +0200, Frederic Weisbecker wrote:
> While running rcutorture on bare metal, an easy way to test is to build
> a kernel with the torture scenario parameters built-in using
> CONFIG_CMDLINE="". This way the remote box can simply download the image
> and the boot loader doesn't need to be updated with the new kernel
> parameters.

I had no idea about CONFIG_CMDLINE!  Thank you for introducing me to it!

> Provide kvm.sh with --cmdline-to-config to perform that.

If I understand correctly, kernel-boot parameters are processed after
the CONFIG_CMDLINE parameters.  If so, would it make sense (probably
as a separate patch) for the current --bootargs kernel parameters to be
supplied to CONFIG_CMDLINE in kvm.sh, and to add a --bootargs parameter
to kvm-again.sh which caused additional kernel-boot parameters to be
added to the end of the "-append" list in the qemu-cmd file?

As in, "Re-run this rcutorture run, but with rcutorture.onoff_interval=0
so as to disable CPU-hotplug operations"?

More on-point questions and comments interspersed below.  Well, hopefully
more on-point, anyway!

> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  .../selftests/rcutorture/bin/configinit.sh    | 13 +++++++
>  .../selftests/rcutorture/bin/kvm-build.sh     |  4 ++-
>  .../rcutorture/bin/kvm-test-1-run.sh          | 34 +++++++++++--------
>  tools/testing/selftests/rcutorture/bin/kvm.sh |  6 ++++
>  4 files changed, 41 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
> index d6e5ce084b1c..d2b8a68114e4 100755
> --- a/tools/testing/selftests/rcutorture/bin/configinit.sh
> +++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
> @@ -23,6 +23,8 @@ mkdir $T
>  
>  c=$1
>  resdir=$2
> +kboot_args=$3
> +modprobe_args=$4
>  
>  sed -e 's/^\(CONFIG[0-9A-Z_]*\)=.*$/grep -v "^# \1" |/' < $c > $T/u.sh
>  sed -e 's/^\(CONFIG[0-9A-Z_]*=\).*$/grep -v \1 |/' < $c >> $T/u.sh
> @@ -35,6 +37,17 @@ fi
>  make $TORTURE_KMAKE_ARG $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
>  mv .config .config.sav
>  sh $T/upd.sh < .config.sav > .config
> +
> +if test -n "$TORTURE_CMDLINE2CONFIG"
> +then
> +	cmdline=$(grep "CONFIG_CMDLINE=" .config | sed -E 's/CONFIG_CMDLINE="(.*)"/\1/')
> +	prefixed_modprobe_args=$(echo $modprobe_args | sed -E -e "s/([^ ]+?)(=[^ ]*)?/rcutorture.\1\2/g")

Doesn't this need to check for locktorture, refscale, rcuscale, and
scftorture as well as for rcutorture?  Maybe use the TORTURE_MOD
environment variable similar to the way you do in your change to
kvm-test-1-run.sh.

> +	cmdline="$kboot_args $prefixed_modprobe_args $cmdline"

This makes a "--kconfig CONFIG_CMDLINE=whatever" override the --bootargs
parameters.  Is that what we want?  Either way, why?

You could ask the same question about the current ordering of kernel
boot parameters from their various sources, and it would be good to do so.

> +	grep -Ev "CONFIG_CMDLINE[= ]" .config > .config.sav
> +	mv .config.sav .config
> +	echo "CONFIG_CMDLINE=\""$cmdline"\"" >> .config
> +fi
> +
>  cp .config .config.new
>  yes '' | make $TORTURE_KMAKE_ARG oldconfig > $resdir/Make.oldconfig.out 2> $resdir/Make.oldconfig.err
>  
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-build.sh b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
> index 5ad973dca820..9eb4324d42e1 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-build.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-build.sh
> @@ -22,6 +22,8 @@ then
>  	exit 1
>  fi
>  resdir=${2}
> +kboot_args=${3}
> +modprobe_args=${4}
>  
>  T=${TMPDIR-/tmp}/test-linux.sh.$$
>  trap 'rm -rf $T' 0
> @@ -34,7 +36,7 @@ CONFIG_VIRTIO_PCI=y
>  CONFIG_VIRTIO_CONSOLE=y
>  ___EOF___
>  
> -configinit.sh $T/config $resdir
> +configinit.sh $T/config $resdir "$kboot_args" "$modprobe_args"
>  retval=$?
>  if test $retval -gt 1
>  then
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> index 420ed5ce9d32..e6aece69d81b 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> @@ -71,6 +71,24 @@ config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
>  config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
>  cp $T/KcList $resdir/ConfigFragment
>  
> +seconds=$3
> +qemu_args=$4
> +boot_args_in=$5
> +
> +# Pull in Kconfig-fragment boot parameters
> +boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
> +# Generate kernel-version-specific boot parameters
> +boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
> +
> +if test -n "$TORTURE_BOOT_GDB_ARG"
> +then
> +	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
> +fi
> +
> +modprobe_args="`echo $boot_args | tr -s ' ' '\012' | grep "^$TORTURE_MOD\." | sed -e "s/$TORTURE_MOD\.//g"`"
> +kboot_args="`echo $boot_args | tr -s ' ' '\012' | grep -v "^$TORTURE_MOD\."`"
> +

We are in trouble if a kernel boot parameter contains a space character,
but we probably are already in trouble, so no problem.  ;-)

But don't we want to avoid adding these to the qemu -append argument
if they are already in CONFIG_CMDLINE?  Or is there some benefit to
duplicating them?

> +
>  base_resdir=`echo $resdir | sed -e 's/\.[0-9]\+$//'`
>  if test "$base_resdir" != "$resdir" && test -f $base_resdir/bzImage && test -f $base_resdir/vmlinux
>  then
> @@ -93,7 +111,7 @@ then
>  		mv $resdir/build.wait $resdir/build.ready
>  	fi
>  	exit 1
> -elif kvm-build.sh $T/KcList $resdir
> +elif kvm-build.sh $T/KcList $resdir "$kboot_args" "$modprobe_args"
>  then
>  	# Had to build a kernel for this test.
>  	QEMU="`identify_qemu vmlinux`"
> @@ -131,9 +149,6 @@ while test -f $resdir/build.ready
>  do
>  	sleep 1
>  done
> -seconds=$3
> -qemu_args=$4
> -boot_args_in=$5
>  
>  if test -z "$TORTURE_BUILDONLY"
>  then
> @@ -158,18 +173,7 @@ qemu_args="$qemu_args `identify_qemu_args "$QEMU" "$resdir/console.log"`"
>  # Generate qemu -append arguments
>  qemu_append="`identify_qemu_append "$QEMU"`"
>  
> -# Pull in Kconfig-fragment boot parameters
> -boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
> -# Generate kernel-version-specific boot parameters
> -boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
> -if test -n "$TORTURE_BOOT_GDB_ARG"
> -then
> -	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
> -fi
> -
>  # Give bare-metal advice
> -modprobe_args="`echo $boot_args | tr -s ' ' '\012' | grep "^$TORTURE_MOD\." | sed -e "s/$TORTURE_MOD\.//g"`"
> -kboot_args="`echo $boot_args | tr -s ' ' '\012' | grep -v "^$TORTURE_MOD\."`"
>  testid_txt="`dirname $resdir`/testid.txt"
>  touch $resdir/bare-metal
>  echo To run this scenario on bare metal: >> $resdir/bare-metal
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> index b4ac4ee33222..a05a20135de1 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> @@ -33,6 +33,7 @@ TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
>  TORTURE_DEFCONFIG=defconfig
>  TORTURE_BOOT_IMAGE=""
>  TORTURE_BUILDONLY=
> +TORTURE_CMDLINE2CONFIG=
>  TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
>  TORTURE_KCONFIG_ARG=""
>  TORTURE_KCONFIG_GDB_ARG=""
> @@ -64,6 +65,7 @@ usage () {
>  	echo "       --bootargs kernel-boot-arguments"
>  	echo "       --bootimage relative-path-to-kernel-boot-image"
>  	echo "       --buildonly"
> +	echo "       --cmdline-to-config"

Does it make sense to have a way to specify that some kernel-boot
paremeters go in through CONFIG_CMDLINE and others through the qemu
-append argument?

Does it make sense to make kvm.sh unconditionally pass the kernel boot
parameters in via CONFIG_CMDLINE, thus avoiding the need for the new
--cmdline_to_config argument?  (One reason to avoid this is that it is
probably easier to hand-edit the qemu-cmd file than the bzImage file.
Though the qemu-cmd edits would override the bzImage boot parameters,
right?)

>  	echo "       --configs \"config-file list w/ repeat factor (3*TINY01)\""
>  	echo "       --cpus N"
>  	echo "       --datestamp string"
> @@ -108,6 +110,9 @@ do
>  	--buildonly|--build-only)
>  		TORTURE_BUILDONLY=1
>  		;;
> +	--cmdline-to-config)
> +		TORTURE_CMDLINE2CONFIG=1
> +		;;
>  	--configs|--config)
>  		checkarg --configs "(list of config files)" "$#" "$2" '^[^/.a-z]\+$' '^--'
>  		configs="$configs $2"
> @@ -388,6 +393,7 @@ PATH="$PATH"; export PATH
>  TORTURE_ALLOTED_CPUS="$TORTURE_ALLOTED_CPUS"; export TORTURE_ALLOTED_CPUS
>  TORTURE_BOOT_IMAGE="$TORTURE_BOOT_IMAGE"; export TORTURE_BOOT_IMAGE
>  TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
> +TORTURE_CMDLINE2CONFIG="$TORTURE_CMDLINE2CONFIG"; export TORTURE_CMDLINE2CONFIG
>  TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
>  TORTURE_INITRD="$TORTURE_INITRD"; export TORTURE_INITRD
>  TORTURE_KCONFIG_ARG="$TORTURE_KCONFIG_ARG"; export TORTURE_KCONFIG_ARG
> -- 
> 2.25.1
> 
