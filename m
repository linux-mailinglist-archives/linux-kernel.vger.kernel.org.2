Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3793D370576
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 06:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhEAE1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 00:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229461AbhEAE1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 00:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD803611EE;
        Sat,  1 May 2021 04:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619843203;
        bh=1jzdun1GW1M9A2MagJNa0iIaIje+bfMd8QTvyu4GNWA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q//JDq07lF6pzi6htADXESwWN7stEmQ1BYmZg5xx0DsWyamVAL9iz6zMvYwduyt6C
         cWpu5fIQnut7SrZwTnvL39jH+0khaXXHZ1aDw/Xrp1HhSLU8PqX6nsR373TMXemkAe
         bvgeN7p0Az0JnJGFwJCHIRwYzvZRVSmWSyq34D8Y3rw37tYomorIsy9XQ6ltGVpjTl
         /Ds7ANPr5+cm3KQqKfVMT+SeWCqDJ8AcPjqpISDFdKyrpwpzzCHo8jOYeUmN3IMl++
         H0VSrjZqEj/Vb7iNzTBQJEmyLc1lVs4+Ug1ATgRa9/kV5POBQIiR+IWN1Nkb/DZ4Yn
         RkBfjiabJKa7g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9EEFE5C0153; Fri, 30 Apr 2021 21:26:43 -0700 (PDT)
Date:   Fri, 30 Apr 2021 21:26:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2021.04.20a 98/101] kernel/rcu/tasks.h:1404:20: error:
 static declaration of 'show_rcu_tasks_gp_kthreads' follows non-static
 declaration
Message-ID: <20210501042643.GJ975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202105010944.UNfWx1By-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202105010944.UNfWx1By-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 09:48:46AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.20a
> head:   fe7d174b033dcf9367759b3c14febb31525aad39
> commit: a1ec494e1eef0c72d8f89bbf916a4b291273d2e5 [98/101] tasks-rcu: Make show_rcu_tasks_gp_kthreads() be static inline
> config: arm-spear13xx_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=a1ec494e1eef0c72d8f89bbf916a4b291273d2e5
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags rcu dev.2021.04.20a
>         git checkout a1ec494e1eef0c72d8f89bbf916a4b291273d2e5
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=arm 

This has since been obsoleted by b5200edc0c43 ("tasks-rcu: Make
show_rcu_tasks_gp_kthreads() be static inline").

						Thanx, Paul

> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:584:
> >> kernel/rcu/tasks.h:1404:20: error: static declaration of 'show_rcu_tasks_gp_kthreads' follows non-static declaration
>     1404 | static inline void show_rcu_tasks_gp_kthreads(void) {}
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    In file included from kernel/rcu/update.c:49:
>    kernel/rcu/rcu.h:440:6: note: previous declaration of 'show_rcu_tasks_gp_kthreads' was here
>      440 | void show_rcu_tasks_gp_kthreads(void);
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/show_rcu_tasks_gp_kthreads +1404 kernel/rcu/tasks.h
> 
>   1401	
>   1402	#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>   1403	static inline void rcu_tasks_bootup_oddness(void) {}
> > 1404	static inline void show_rcu_tasks_gp_kthreads(void) {}
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


