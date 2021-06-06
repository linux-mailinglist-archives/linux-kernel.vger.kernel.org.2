Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B07939CD3E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFFEvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 00:51:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhFFEvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 00:51:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AB2E761421;
        Sun,  6 Jun 2021 04:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622954966;
        bh=ww2ngwIv1lpbFJZ0+wx9Ny5OBs1yVrdKvStoC2hD8Vg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=biCbh5Ch0C4U+ikFlrUzeDTOnjo8NMqeojEOyNez4ahHpKFBCPLFV7KlfSJ8ceJGz
         iKTV4bnS9IV0Y48ZC6h/Z6s4h1YT3AHPddszGFrdiR1mq+DXiZcfUZWzybZhF1knWr
         e3+dnp+Q1POc9niXqVVNzpmYQKcf5tq/O+FDjErYkWxa3Q0TMr8AmVP9gQj7rv3mAQ
         sBSY9CJMYMVOCQex+5cTcOEHnC/fBjJJODqFRs/sh1vNCgHHBEBpUT+jLXHUwHcF5Y
         +NenZwiWbuOiwUIgqqVsqNnZkkxNmaLls3TcpMXp+xy47etWna3H51hJkjz8o601f2
         0xoTS4U2iS4Hg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7B2BE5C0991; Sat,  5 Jun 2021 21:49:26 -0700 (PDT)
Date:   Sat, 5 Jun 2021 21:49:26 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/rcu/tree.c:2073:23: warning: stack frame size of 2704
 bytes in function 'rcu_gp_kthread'
Message-ID: <20210606044926.GJ4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202106061253.0X2QKyyI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202106061253.0X2QKyyI-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 06, 2021 at 12:19:57PM +0800, kernel test robot wrote:
> Hi Paul,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f5b6eb1e018203913dfefcf6fa988649ad11ad6e
> commit: 7dffe01765d9309b8bd5505503933ec0ec53d192 rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
> date:   5 months ago
> config: powerpc-randconfig-r023-20210606 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 551a697c5cf33275b66add4fc467fcf59084cffb)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7dffe01765d9309b8bd5505503933ec0ec53d192
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7dffe01765d9309b8bd5505503933ec0ec53d192
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/tree.c:21:
>    In file included from include/linux/kernel.h:12:
>    In file included from include/linux/bitops.h:29:
>    In file included from arch/powerpc/include/asm/bitops.h:62:
>    arch/powerpc/include/asm/barrier.h:49:9: warning: '__lwsync' macro redefined [-Wmacro-redefined]
>    #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
>            ^
>    <built-in>:310:9: note: previous definition is here
>    #define __lwsync __builtin_ppc_lwsync
>            ^
> >> kernel/rcu/tree.c:2073:23: warning: stack frame size of 2704 bytes in function 'rcu_gp_kthread' [-Wframe-larger-than=]
>    static int __noreturn rcu_gp_kthread(void *unused)

Does -rcu commit 2f20de99a63b ("rcu: Make rcu_gp_cleanup() be noinline
for tracing") help?

							Thanx, Paul

>    2 warnings generated.
> 
> 
> vim +/rcu_gp_kthread +2073 kernel/rcu/tree.c
> 
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2069  
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2070  /*
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2071   * Body of kthread that handles grace periods.
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2072   */
> 0854a05c9fa554 kernel/rcu/tree.c Paul E. McKenney 2018-07-03 @2073  static int __noreturn rcu_gp_kthread(void *unused)
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2074  {
> 5871968d531f39 kernel/rcu/tree.c Paul E. McKenney 2015-02-24  2075  	rcu_bind_gp_kthread();
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2076  	for (;;) {
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2077  
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2078  		/* Handle grace-period start. */
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2079  		for (;;) {
> 0f11ad323dd3d3 kernel/rcu/tree.c Paul E. McKenney 2020-02-10  2080  			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> 63c4db78e80407 kernel/rcutree.c  Paul E. McKenney 2013-08-09  2081  					       TPS("reqwait"));
> 9cbc5b97029bff kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2082  			rcu_state.gp_state = RCU_GP_WAIT_GPS;
> 9cbc5b97029bff kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2083  			swait_event_idle_exclusive(rcu_state.gp_wq,
> 9cbc5b97029bff kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2084  					 READ_ONCE(rcu_state.gp_flags) &
> 4cdfc175c25c89 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2085  					 RCU_GP_FLAG_INIT);
> 55b2dcf5870004 kernel/rcu/tree.c Paul E. McKenney 2020-04-01  2086  			rcu_gp_torture_wait();
> 9cbc5b97029bff kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2087  			rcu_state.gp_state = RCU_GP_DONE_GPS;
> 78e4bc34e5d966 kernel/rcu/tree.c Paul E. McKenney 2013-09-24  2088  			/* Locking provides needed memory barrier. */
> 0854a05c9fa554 kernel/rcu/tree.c Paul E. McKenney 2018-07-03  2089  			if (rcu_gp_init())
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2090  				break;
> cee43939893337 kernel/rcu/tree.c Paul E. McKenney 2018-03-02  2091  			cond_resched_tasks_rcu_qs();
> 9cbc5b97029bff kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2092  			WRITE_ONCE(rcu_state.gp_activity, jiffies);
> 73a860cd58a1eb kernel/rcu/tree.c Paul E. McKenney 2014-08-14  2093  			WARN_ON(signal_pending(current));
> 0f11ad323dd3d3 kernel/rcu/tree.c Paul E. McKenney 2020-02-10  2094  			trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq,
> 63c4db78e80407 kernel/rcutree.c  Paul E. McKenney 2013-08-09  2095  					       TPS("reqwaitsig"));
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2096  		}
> 7fdefc10e1d730 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2097  
> 4cdfc175c25c89 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2098  		/* Handle quiescent-state forcing. */
> c3854a055bc834 kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2099  		rcu_gp_fqs_loop();
> 4cdfc175c25c89 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2100  
> 4cdfc175c25c89 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2101  		/* Handle grace-period end. */
> 9cbc5b97029bff kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2102  		rcu_state.gp_state = RCU_GP_CLEANUP;
> 0854a05c9fa554 kernel/rcu/tree.c Paul E. McKenney 2018-07-03  2103  		rcu_gp_cleanup();
> 9cbc5b97029bff kernel/rcu/tree.c Paul E. McKenney 2018-07-05  2104  		rcu_state.gp_state = RCU_GP_CLEANED;
> 4cdfc175c25c89 kernel/rcutree.c  Paul E. McKenney 2012-06-22  2105  	}
> b3dbec76e5334f kernel/rcutree.c  Paul E. McKenney 2012-06-18  2106  }
> b3dbec76e5334f kernel/rcutree.c  Paul E. McKenney 2012-06-18  2107  
> 
> :::::: The code at line 2073 was first introduced by commit
> :::::: 0854a05c9fa554930174f0fa7453c18f99108a4a rcu: Remove rsp parameter from rcu_gp_kthread() and friends
> 
> :::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> :::::: CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


