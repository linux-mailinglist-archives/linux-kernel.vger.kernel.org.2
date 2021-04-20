Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A24B3660C3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 22:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhDTUV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 16:21:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233619AbhDTUVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 16:21:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 206B0613D7;
        Tue, 20 Apr 2021 20:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618950082;
        bh=G7VEOYGqaOyCpsNmXBeRpuQcpOcC42F5/pz/cPUGDyE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jy4gUzFEbN9LYnW3UwlQHHFklCu4xvowigeh+oerxegPIZ2A5D0AzPi6rFYkJVbiu
         dQ3KZdjSzoZRs+FFu/MtGaZ7d1m1WNBRo4JwGCjbLAP0cdcmT8IFTvZeviuAV0onGj
         vIwWGXX0ckJivczPD655bO1ddjDsVdJpmLzus9xd5JP398tGPBAcJYt+bC7nrS5icM
         uyfJ2xBzGnrtyiWzexqIB64vKsMq2fAGbSpSDbFwAW/RiopQUQPgBxLo82xPBbEFs0
         q6BF3PhusYtoVcOQGIiLb5k4Q8ijwcR/u+EKmAjpal4w1T/X6pEklBgP7DJHLvKC8I
         1e3M/iLvcNO4w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A23AF5C052F; Tue, 20 Apr 2021 13:21:21 -0700 (PDT)
Date:   Tue, 20 Apr 2021 13:21:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: kernel/rcu/tasks.h:1031:6: warning: no previous prototype for
 'show_rcu_tasks_gp_kthreads'
Message-ID: <20210420202121.GO975577@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202104201428.oLpgo4lI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104201428.oLpgo4lI-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 02:56:30PM +0800, kernel test robot wrote:
> Hi Paul,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7af08140979a6e7e12b78c93b8625c8d25b084e2
> commit: e21408ceec2de5be418efa39feb1e2c00f824a72 rcu-tasks: Add RCU tasks to rcutorture writer stall output
> date:   12 months ago
> config: h8300-allnoconfig (attached as .config)
> compiler: h8300-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e21408ceec2de5be418efa39feb1e2c00f824a72
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout e21408ceec2de5be418efa39feb1e2c00f824a72
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross W=1 ARCH=h8300 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good catch, fixed with attribution by adding "static inline".

							Thanx, Paul

> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/rcu/update.c:587:
> >> kernel/rcu/tasks.h:1031:6: warning: no previous prototype for 'show_rcu_tasks_gp_kthreads' [-Wmissing-prototypes]
>     1031 | void show_rcu_tasks_gp_kthreads(void) {}
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
> vim +/show_rcu_tasks_gp_kthreads +1031 kernel/rcu/tasks.h
> 
>   1028	
>   1029	#else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
>   1030	static inline void rcu_tasks_bootup_oddness(void) {}
> > 1031	void show_rcu_tasks_gp_kthreads(void) {}
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


