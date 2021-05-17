Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5953382A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 12:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhEQKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 06:43:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236319AbhEQKny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 06:43:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 442D661028;
        Mon, 17 May 2021 10:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621248158;
        bh=0Ciz4WDhghzNtZO7U8J4u96RPOXSntTLU933AP+Ph1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LP9iUR6cPvSes/voOFkzj7aUS63i8xFQ4ey36jVBZlnMy1IQIpfjApJiAkvkkp/wR
         z8R8Gn45JdvqRmSVbBo0SjSDvd7d10FTanVmMM6viZJCTOa5R+YH7mI+YuXDOvaF7D
         ymAZ6ldxzTnkHkFGDG9Ap7bmhbCzSOx5t2MeX6uN/+SUXF+SQCRs+dN4b0o7slMfGo
         UERIHFfv5YNJ6tZeg3rV88PDjxDEUvsO8sLOfvzykZ22/OMpu4VTRrwDUZLyMv6gAr
         6l7kzbMKAPIvT2huLHvhyKS3T578Wh0WttD32VM6wE2oFaFk7ipauG1AWjh47FDytX
         1ExP+5xHyMT0w==
Date:   Mon, 17 May 2021 12:42:36 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] torture: Add --cmdline-to-config parameter to kvm.sh
Message-ID: <20210517104236.GA199206@lothringen>
References: <20210506131510.51488-1-frederic@kernel.org>
 <20210506131510.51488-2-frederic@kernel.org>
 <20210507192009.GY975577@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507192009.GY975577@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 12:20:09PM -0700, Paul E. McKenney wrote:
> On Thu, May 06, 2021 at 03:15:08PM +0200, Frederic Weisbecker wrote:
> > While running rcutorture on bare metal, an easy way to test is to build
> > a kernel with the torture scenario parameters built-in using
> > CONFIG_CMDLINE="". This way the remote box can simply download the image
> > and the boot loader doesn't need to be updated with the new kernel
> > parameters.
> 
> I had no idea about CONFIG_CMDLINE!  Thank you for introducing me to it!
> 
> > Provide kvm.sh with --cmdline-to-config to perform that.
> 
> If I understand correctly, kernel-boot parameters are processed after
> the CONFIG_CMDLINE parameters.  If so, would it make sense (probably
> as a separate patch) for the current --bootargs kernel parameters to be
> supplied to CONFIG_CMDLINE in kvm.sh, and to add a --bootargs parameter
> to kvm-again.sh which caused additional kernel-boot parameters to be
> added to the end of the "-append" list in the qemu-cmd file?
> 
> As in, "Re-run this rcutorture run, but with rcutorture.onoff_interval=0
> so as to disable CPU-hotplug operations"?

Sure that looks possible.

> > diff --git a/tools/testing/selftests/rcutorture/bin/configinit.sh b/tools/testing/selftests/rcutorture/bin/configinit.sh
> > index d6e5ce084b1c..d2b8a68114e4 100755
> > --- a/tools/testing/selftests/rcutorture/bin/configinit.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/configinit.sh
> > @@ -23,6 +23,8 @@ mkdir $T
> >  
> >  c=$1
> >  resdir=$2
> > +kboot_args=$3
> > +modprobe_args=$4
> >  
> >  sed -e 's/^\(CONFIG[0-9A-Z_]*\)=.*$/grep -v "^# \1" |/' < $c > $T/u.sh
> >  sed -e 's/^\(CONFIG[0-9A-Z_]*=\).*$/grep -v \1 |/' < $c >> $T/u.sh
> > @@ -35,6 +37,17 @@ fi
> >  make $TORTURE_KMAKE_ARG $TORTURE_DEFCONFIG > $resdir/Make.defconfig.out 2>&1
> >  mv .config .config.sav
> >  sh $T/upd.sh < .config.sav > .config
> > +
> > +if test -n "$TORTURE_CMDLINE2CONFIG"
> > +then
> > +	cmdline=$(grep "CONFIG_CMDLINE=" .config | sed -E 's/CONFIG_CMDLINE="(.*)"/\1/')
> > +	prefixed_modprobe_args=$(echo $modprobe_args | sed -E -e "s/([^ ]+?)(=[^ ]*)?/rcutorture.\1\2/g")
> 
> Doesn't this need to check for locktorture, refscale, rcuscale, and
> scftorture as well as for rcutorture?  Maybe use the TORTURE_MOD
> environment variable similar to the way you do in your change to
> kvm-test-1-run.sh.

Ah! Right I missed all that. Ok I'll need to handle all those other modules.

> 
> > +	cmdline="$kboot_args $prefixed_modprobe_args $cmdline"
> 
> This makes a "--kconfig CONFIG_CMDLINE=whatever" override the --bootargs
> parameters.  Is that what we want?  Either way, why?

I guess it's up to the user not to try dangerous mixes. But we could forbid
--kconfig CONFIG_CMDLINE= for example.

> You could ask the same question about the current ordering of kernel
> boot parameters from their various sources, and it would be good to do so.

Heh.

> > +seconds=$3
> > +qemu_args=$4
> > +boot_args_in=$5
> > +
> > +# Pull in Kconfig-fragment boot parameters
> > +boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
> > +# Generate kernel-version-specific boot parameters
> > +boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
> > +
> > +if test -n "$TORTURE_BOOT_GDB_ARG"
> > +then
> > +	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
> > +fi
> > +
> > +modprobe_args="`echo $boot_args | tr -s ' ' '\012' | grep "^$TORTURE_MOD\." | sed -e "s/$TORTURE_MOD\.//g"`"
> > +kboot_args="`echo $boot_args | tr -s ' ' '\012' | grep -v "^$TORTURE_MOD\."`"
> > +
> 
> We are in trouble if a kernel boot parameter contains a space character,
> but we probably are already in trouble, so no problem.  ;-)

:o)

> 
> But don't we want to avoid adding these to the qemu -append argument
> if they are already in CONFIG_CMDLINE?  Or is there some benefit to
> duplicating them?

Indeed I only used it with --configonly so far so I didn't bother checking.
But you're right, I should avoid passing these twice.

> > diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
> > index b4ac4ee33222..a05a20135de1 100755
> > --- a/tools/testing/selftests/rcutorture/bin/kvm.sh
> > +++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
> > @@ -33,6 +33,7 @@ TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
> >  TORTURE_DEFCONFIG=defconfig
> >  TORTURE_BOOT_IMAGE=""
> >  TORTURE_BUILDONLY=
> > +TORTURE_CMDLINE2CONFIG=
> >  TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
> >  TORTURE_KCONFIG_ARG=""
> >  TORTURE_KCONFIG_GDB_ARG=""
> > @@ -64,6 +65,7 @@ usage () {
> >  	echo "       --bootargs kernel-boot-arguments"
> >  	echo "       --bootimage relative-path-to-kernel-boot-image"
> >  	echo "       --buildonly"
> > +	echo "       --cmdline-to-config"
> 
> Does it make sense to have a way to specify that some kernel-boot
> paremeters go in through CONFIG_CMDLINE and others through the qemu
> -append argument?
> 
> Does it make sense to make kvm.sh unconditionally pass the kernel boot
> parameters in via CONFIG_CMDLINE, thus avoiding the need for the new
> --cmdline_to_config argument?  (One reason to avoid this is that it is
> probably easier to hand-edit the qemu-cmd file than the bzImage file.
> Though the qemu-cmd edits would override the bzImage boot parameters,
> right?)

I guess it depends if you ever plan to be able to re-launch qemu with different
parameters without rebuilding the bzImage. Perhaps it's even something that can
be done currently?

Thanks!
