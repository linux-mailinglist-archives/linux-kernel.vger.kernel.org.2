Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62243BBECD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhGEPXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 11:23:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230364AbhGEPXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 11:23:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 30D7561946;
        Mon,  5 Jul 2021 15:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625498468;
        bh=w2PzVMO4YdTBWIzA/MqnzkPzHeCCc8l5tv51lS8IjsY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=gs9stn9CVPt0REoqgUjbewYOK9VQt8CxaZRpApu8+RO2GkcWQAxZN4Dw42kRYRq1f
         9VEvbfUi7IvD5QjHhoSrsOV5pRO8qpVlcpEUpxXRFPHXfkUACQfCpbTIwAJV8dU9Fe
         T4DXZF8ozLxR/1dh/kP5/exkYxP8LkXamiwxKochUAytduk/Vv6rdfwJqaBz+AhaRX
         fsoK8TnUvq03jHC/qPwoHLjYPDu6dV0D4dabUDpSjGxEkrTvHGpEoFadLiUIH3aUzJ
         rcWNdX3LqhGPVYy5QBLVIPtYRAMb/j5OZYlFQN9x4Ex6DrT1aCCW5GmThEk5WJLj5Y
         fPK23b6vYRA+Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 002415C016B; Mon,  5 Jul 2021 08:21:07 -0700 (PDT)
Date:   Mon, 5 Jul 2021 08:21:07 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [kbuild-all] Re: kernel/time/clocksource-wdtest.c:47:22:
 warning: signed shift result (0x27BC86B00) requires 35 bits to represent,
 but 'long' only has 32 bits
Message-ID: <20210705152107.GV4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202107040532.wqL30yFp-lkp@intel.com>
 <20210704174310.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <254ab0ec-2c25-29fd-cbe1-eaf2bc135326@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <254ab0ec-2c25-29fd-cbe1-eaf2bc135326@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2021 at 03:47:09PM +0800, Rong Chen wrote:
> 
> 
> On 7/5/21 1:43 AM, Paul E. McKenney wrote:
> > On Sun, Jul 04, 2021 at 05:42:36AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   303392fd5c160822bf778270b28ec5ea50cab2b4
> > > commit: 1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff clocksource: Provide kernel module to test clocksource watchdog
> > > date:   11 days ago
> > > config: mips-randconfig-r015-20210702 (attached as .config)
> > > compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 9eb613b2de3163686b1a4bd1160f15ac56a4b083)
> > > reproduce (this is a W=1 build):
> > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >          chmod +x ~/bin/make.cross
> > >          # install mips cross compiling tool for clang build
> > >          # apt-get install binutils-mips-linux-gnu
> > >          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff
> > >          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > >          git fetch --no-tags linus master
> > >          git checkout 1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff
> > >          # save the attached .config to linux build tree
> > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > 
> > > All warnings (new ones prefixed by >>):
> > > 
> > > > > kernel/time/clocksource-wdtest.c:47:22: warning: signed shift result (0x27BC86B00) requires 35 bits to represent, but 'long' only has 32 bits [-Wshift-overflow]
> > >             .mult                   = TICK_NSEC << JIFFIES_SHIFT, /* details above */
> > >                                       ~~~~~~~~~ ^  ~~~~~~~~~~~~~
> > >     1 warning generated.
> > You have CONFIG_HZ_24=y and this test module assumes HZ > 100, as noted
> > just above the excerpt below:
> > 
> > /* Assume HZ > 100. */
> > #define JIFFIES_SHIFT   8
> > 
> > So this is expected behavior.
> > 
> > Would it help if I gave that comment some teeth, for example, as
> > shown at the end of this email?
> 
> Hi Paul,
> 
> I have confirmed that the below change can avoid the warning.

Very good, and thank you!  May I add your Tested-by?

							Thanx, Paul

> Best Regards,
> Rong Chen
> 
> > 
> > ------------------------------------------------------------------------
> > 
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index e1856030fa66..8f0ad6e4183c 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -2573,6 +2573,7 @@ config TEST_FPU
> >   config TEST_CLOCKSOURCE_WATCHDOG
> >   	tristate "Test clocksource watchdog in kernel space"
> >   	depends on CLOCKSOURCE_WATCHDOG
> > +	depends on HZ >= 100
> >   	help
> >   	  Enable this option to create a kernel module that will trigger
> >   	  a test of the clocksource watchdog.  This module may be loaded
> > _______________________________________________
> > kbuild-all mailing list -- kbuild-all@lists.01.org
> > To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
