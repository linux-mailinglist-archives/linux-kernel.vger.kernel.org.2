Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E96C455303
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 04:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242373AbhKRDEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 22:04:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:52300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242292AbhKRDEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 22:04:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CACF61078;
        Thu, 18 Nov 2021 03:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637204468;
        bh=MwxtuqderSqLaeWafGO5uIaC0hUNm+ssOzZuscigoxg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Jdaq5iEuYsAfYBAYMLrOcbE2kAaVbMCLCKeOK0VRFw8qxqRSzAW0s5jar7uy4oJ+m
         wvNO6p0M20/4cuyVMeTp9d/kYs7TMTHsNAvMNTMlPmqRFjP8v2PThodRwfk+2Oau4M
         t/khwEtJzHytu5Z3+HpmRwRnWqvW937RSV4PN1qvCpFaFtdmUC3q6GMcPMrPiPhmM4
         E6JWrCZoE03ufTxtdAiM+8NlbBluQwHOd6wuKxZVlvCvMfFVyRexzJk5YO1p/1DXMO
         aXLruE1zfeZPTMBbHjKqLrpiEaMgqRpYPkOiyHB7CdjAvsfTTKaT50jhcvXygzCQOA
         a2mm3ZrMlaJjw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3D03A5C0433; Wed, 17 Nov 2021 19:01:08 -0800 (PST)
Date:   Wed, 17 Nov 2021 19:01:08 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2021.11.10a 81/96] kernel/rcu/tasks.h:181:25:
 sparse: sparse: incorrect type in argument 1 (different modifiers)
Message-ID: <20211118030108.GS641268@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202111180932.MZGOKear-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111180932.MZGOKear-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 09:41:40AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.11.10a
> head:   cfbd3769397911e7f1561fa57b4490b1e4fed9de
> commit: a3ecbdd6d841a025ebe87b79c7538b4dc44edc94 [81/96] rcu-tasks: Use spin_lock_rcu_node() and friends
> config: arm-randconfig-s032-20211115 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.4-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=a3ecbdd6d841a025ebe87b79c7538b4dc44edc94
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu dev.2021.11.10a
>         git checkout a3ecbdd6d841a025ebe87b79c7538b4dc44edc94
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

Good catch, a missing ACCESS_PRIVATE.  Will fix, thank you!

								Thanx, Paul

> sparse warnings: (new ones prefixed by >>)
>    kernel/rcu/update.c: note: in included file:
> >> kernel/rcu/tasks.h:181:25: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected struct raw_spinlock [usertype] *lock @@     got struct raw_spinlock [noderef] * @@
>    kernel/rcu/tasks.h:181:25: sparse:     expected struct raw_spinlock [usertype] *lock
>    kernel/rcu/tasks.h:181:25: sparse:     got struct raw_spinlock [noderef] *
> 
> vim +181 kernel/rcu/tasks.h
> 
>    165	
>    166	// Initialize per-CPU callback lists for the specified flavor of
>    167	// Tasks RCU.
>    168	static void cblist_init_generic(struct rcu_tasks *rtp)
>    169	{
>    170		int cpu;
>    171		unsigned long flags;
>    172	
>    173		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
>    174		rtp->percpu_enqueue_shift = ilog2(nr_cpu_ids);
>    175		for_each_possible_cpu(cpu) {
>    176			struct rcu_tasks_percpu *rtpcp = per_cpu_ptr(rtp->rtpcpu, cpu);
>    177	
>    178			pr_info("%s initializing CPU %d rcu_tasks_percpu structure for %s\n", __func__, cpu, rtp->name);
>    179			WARN_ON_ONCE(!rtpcp);
>    180			if (cpu)
>  > 181				raw_spin_lock_init(&rtpcp->lock);
>    182			raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
>    183			if (rcu_segcblist_empty(&rtpcp->cblist))
>    184				rcu_segcblist_init(&rtpcp->cblist);
>    185			raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>    186		}
>    187		raw_spin_unlock_irqrestore(&rtp->cbs_gbl_lock, flags);
>    188	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


