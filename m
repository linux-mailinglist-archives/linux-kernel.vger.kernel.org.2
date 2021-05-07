Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B43F5376B33
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 22:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbhEGUin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 16:38:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhEGUin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 16:38:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDC7F61451;
        Fri,  7 May 2021 20:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620419862;
        bh=o7qoeXp3Duh7oduSzFAji7xb5/NEdV/naHbsxLhjKms=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dcDEXaIb1KxiZd7XuVJBKLMMszJ6W/TOYVdqo4q8FmriTA+K4OyVRskHHCqRSkwiM
         EL+WgpuB7jjuIwIa4Fn6Zi/TiX0ttd2Zud75RDiuj7eqtqk0BpSOFAWa4FoULtOCbM
         /p68BZKw/6Qtq+BFJSR225Rr8XImLzw9Wn75nvicsCpHK+HnW2oz+Y+lS1fcCLTiqb
         fN9GEOQ601AMvMe4WtKgRN3/My1aQ7PZTwivdKpiIlkQEtz2RatTGo4y24DQu4zPhX
         vnJcq3IQYu7pxTPpJ4uqtWtBFZSOQbWXMZYlPHIeIsUxtiOlEWbghkMpTvccgD1F8p
         NNO3JXXsKh4qA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 502E55C0293; Fri,  7 May 2021 13:37:42 -0700 (PDT)
Date:   Fri, 7 May 2021 13:37:42 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] torture: Update bare metal advices to latest kvm.sh
 options
Message-ID: <20210507203742.GA975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210506131510.51488-1-frederic@kernel.org>
 <20210506131510.51488-4-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506131510.51488-4-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 03:15:10PM +0200, Frederic Weisbecker wrote:
> kvm.sh is perfectly able to build a new kernel config from an existing
> one instead of using a defconfig. All we need to do is to pass:
> 
> 	--defconfig oldconfig
> 
> This is much easier than manually modifying a .config from a
> ConfigFragment file.
> 
> Then with the latest parameters that got added on kvm.sh, it's now
> easy to build a bare metal .config for a cross target for example:
> 
> 	./kvm.sh --configs "TREE01" --defconfig oldconfig --configonly
> 		--cmdline-to-config --kmake-arg ARCH=arm64 --no-initrd
> 
> After that all we need to do is to build the updated .config and run
> the resulting image.
> 
> Update bare metal advices to propose that.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

I am inclined to let you take the lead on this part of the file given
that I take other approaches to bare-metal rcutorture runs.

A few comments below, mostly wordsmithing.

							Thanx, Paul

> ---
>  .../rcutorture/bin/kvm-test-1-run.sh          | 21 ++++++++++---------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> index 6df9efc77469..47d69668ab37 100755
> --- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> +++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
> @@ -190,27 +190,28 @@ echo To run this scenario on bare metal: >> $resdir/bare-metal
>  echo >> $resdir/bare-metal
>  echo " 1." Set your bare-metal build tree to the state shown in this file: >> $resdir/bare-metal
>  echo "   " $testid_txt >> $resdir/bare-metal
> -echo " 2." Update your bare-metal build tree"'"s .config based on this file: >> $resdir/bare-metal
> -echo "   " $resdir/ConfigFragment >> $resdir/bare-metal
> -echo " 3." Make the bare-metal kernel"'"s build system aware of your .config updates: >> $resdir/bare-metal
> -echo "   " $ 'yes "" | make oldconfig' >> $resdir/bare-metal
> -echo " 4." Build your bare-metal kernel. >> $resdir/bare-metal
> +echo " 2." Prepare your bare-metal build tree"'"s .config on your root kernel directory >> $resdir/bare-metal
> +echo " 3." Run this scenario with "'--defconfig oldconfig --configonly --no-initrd'" >> $resdir/bare-metal
> +echo " 4." If you"'"re cross compiling then append the appropriate make arguments >> $resdir/bare-metal

In this case, I think that "you are" is going to be nicer than the fun
with quoting quotes.  ;-)

> +echo "   " eg: "'--kmake-arg ARCH=arm64'" >> $resdir/bare-metal
>  echo " 5." Boot your bare-metal kernel with the following parameters: >> $resdir/bare-metal
>  echo "   " $kboot_args >> $resdir/bare-metal
>  echo " 6." Start the test with the following command: >> $resdir/bare-metal
>  echo "   " $ modprobe $TORTURE_MOD $modprobe_args >> $resdir/bare-metal
>  echo " 7." After some time, end the test with the following command: >> $resdir/bare-metal
>  echo "   " $ rmmod $TORTURE_MOD >> $resdir/bare-metal
> -echo " 8." Copy your bare-metal kernel"'"s .config file, overwriting this file: >> $resdir/bare-metal
> +echo " 8." Alternatively if you run rcutorture in a built-in fashion and your kernel arguments are already >> $resdir/bare-metal

"Alternatively,"

Also "if you run rcutorture built in" should work.

> +echo "   " hardcoded in the kernel config, skip the previous 5/6/7 steps and append to kvm.sh arguments: >> $resdir/bare-metal

I suggest letting them know before step 5 that they might be able to skip
step 5.  ;-)

For example, something like: "5. If you run rcutorture as a module,
do steps 6-8, otherwise skip to step 9."

> +echo "   " --cmdline-to-config >> $resdir/bare-metal
> +echo "   " Then simply boot your kernel and wait for the end of the tests >> $resdir/bare-metal
> +echo " 9." Copy your bare-metal kernel"'"s .config file, overwriting this file: >> $resdir/bare-metal
>  echo "   " $resdir/.config >> $resdir/bare-metal
> -echo " 9." Copy the console output from just before the modprobe to just after >> $resdir/bare-metal
> +echo "10." Copy the console output from just before the modprobe to just after >> $resdir/bare-metal
>  echo "   " the rmmod into this file: >> $resdir/bare-metal

But if running built-in, we need the entire console output, correct?

>  echo "   " $resdir/console.log >> $resdir/bare-metal
> -echo "10." Check for runtime errors using the following command: >> $resdir/bare-metal
> +echo "11." Check for runtime errors using the following command: >> $resdir/bare-metal
>  echo "   " $ tools/testing/selftests/rcutorture/bin/kvm-recheck.sh `dirname $resdir` >> $resdir/bare-metal
>  echo >> $resdir/bare-metal
> -echo Some of the above steps may be skipped if you build your bare-metal >> $resdir/bare-metal
> -echo kernel here: `head -n 1 $testid_txt | sed -e 's/^Build directory: //'`  >> $resdir/bare-metal
>  
>  echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
>  echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
> -- 
> 2.25.1
> 
