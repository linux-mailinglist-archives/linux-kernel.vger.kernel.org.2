Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC1C3BAE1C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 19:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbhGDRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 13:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhGDRpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 13:45:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BFF3611AD;
        Sun,  4 Jul 2021 17:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625420591;
        bh=vsZB68diUrd5nfeZ0c9PmU0Qj/RLt1a+fD+ihKVHCw0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k4txGoC6Wop6rpshn9r6AjMnsgGpoB4+wAZdw3g6GnVvxZa+ddjT4Voa+UL6kXp+o
         LkzjpmzeqGIjfPdJ4rPszzDH9kHsfpM98x90qHg+hZw+eocf+gFTRq6H/q/50RmyJi
         2UyQfxafpZHePMVa42BrL+A6smRH/qX15YviL0aDw3x8Qgf3IjQN9M3GVIN/Gb5F1X
         b0I/2WDWj41QPezOmmu2DVfHl+T42lT0DwBdWDuifIzISK9mbaDJfLqLxfh2NdHJDt
         OqnLfGNhqsJh8smUvAxklZNYbJghdnL6CJYkVfTiFkLi1seweI7IxbS37tCoGX0Euw
         gLeQkTRuO+lXg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CFE875C0147; Sun,  4 Jul 2021 10:43:10 -0700 (PDT)
Date:   Sun, 4 Jul 2021 10:43:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: kernel/time/clocksource-wdtest.c:47:22: warning: signed shift
 result (0x27BC86B00) requires 35 bits to represent, but 'long' only has 32
 bits
Message-ID: <20210704174310.GR4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202107040532.wqL30yFp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202107040532.wqL30yFp-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 05:42:36AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   303392fd5c160822bf778270b28ec5ea50cab2b4
> commit: 1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff clocksource: Provide kernel module to test clocksource watchdog
> date:   11 days ago
> config: mips-randconfig-r015-20210702 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 9eb613b2de3163686b1a4bd1160f15ac56a4b083)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> kernel/time/clocksource-wdtest.c:47:22: warning: signed shift result (0x27BC86B00) requires 35 bits to represent, but 'long' only has 32 bits [-Wshift-overflow]
>            .mult                   = TICK_NSEC << JIFFIES_SHIFT, /* details above */
>                                      ~~~~~~~~~ ^  ~~~~~~~~~~~~~
>    1 warning generated.

You have CONFIG_HZ_24=y and this test module assumes HZ > 100, as noted
just above the excerpt below:

/* Assume HZ > 100. */
#define JIFFIES_SHIFT   8

So this is expected behavior.

Would it help if I gave that comment some teeth, for example, as
shown at the end of this email?

> vim +/long +47 kernel/time/clocksource-wdtest.c
> 
>     39	
>     40	static struct clocksource clocksource_wdtest_jiffies = {
>     41		.name			= "wdtest-jiffies",
>     42		.rating			= 1, /* lowest valid rating*/
>     43		.uncertainty_margin	= TICK_NSEC,
>     44		.read			= wdtest_jiffies_read,
>     45		.mask			= CLOCKSOURCE_MASK(32),
>     46		.flags			= CLOCK_SOURCE_MUST_VERIFY,
>   > 47		.mult			= TICK_NSEC << JIFFIES_SHIFT, /* details above */
>     48		.shift			= JIFFIES_SHIFT,
>     49		.max_cycles		= 10,
>     50	};
>     51	

------------------------------------------------------------------------

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e1856030fa66..8f0ad6e4183c 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2573,6 +2573,7 @@ config TEST_FPU
 config TEST_CLOCKSOURCE_WATCHDOG
 	tristate "Test clocksource watchdog in kernel space"
 	depends on CLOCKSOURCE_WATCHDOG
+	depends on HZ >= 100
 	help
 	  Enable this option to create a kernel module that will trigger
 	  a test of the clocksource watchdog.  This module may be loaded
