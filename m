Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1B040CCD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 20:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhIOS45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 14:56:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:51990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229479AbhIOS44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 14:56:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FA53610E8;
        Wed, 15 Sep 2021 18:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631732137;
        bh=5psLZCnBqTmsHdnzU2uXoYD3geUwmJUsM+yhz6blJUo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=bbPpAcRjoC4d288g/tDGiaLwea94iJ0jzYQ5vCuz1ik2cRdA3N8N0bCIgODeP/KX4
         RvVVc0DjChfBt41f2UBbWz+lDuQUh6i4IEVBjM2GCEbuByPNNvKQAnzz2NZAhROrX6
         c8KM+DnvKWRXd9ggfJPP3n9oj/wxXZgGe2UCiwzhNM+GkJzZrWJPpU6ipLG+zOr4hE
         Hk2OozCua7jsT9Tfd7d/RT4VCvsnUR5TCoSv6cNws6/x4tCoykEW66Fu4ZY3tcp5EE
         psL8h8fFl1LZClsxVmPSQ10K7GwaLvXul5Ihzg58/9h+ANsG6GWSQbVK+krK5xqiJ7
         1VgOua00vsJDw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 680CC5C054E; Wed, 15 Sep 2021 11:55:37 -0700 (PDT)
Date:   Wed, 15 Sep 2021 11:55:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2021.08.25a 77/115] kernel/cpu.c:158:6: error:
 conflicting types for 'cpu_hp_check_delay'; have 'bool(const char *, const
 void *)' {aka '_Bool(const char *, const void *)'}
Message-ID: <20210915185537.GW4156@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <202109160226.7cwfofOa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109160226.7cwfofOa-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 02:41:29AM +0800, kernel test robot wrote:
> Hi Paul,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.25a
> head:   2ba1d046d9bc5b4496027d120e3ddcdfbb2fe9f4
> commit: 545fb85f707c973cc4f1718572e33267c9c110a2 [77/115] EXP cpu: Make cpu_hp_check_delay() return true when detecting an anomaly
> config: arc-randconfig-r001-20210915 (attached as .config)
> compiler: arc-elf-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=545fb85f707c973cc4f1718572e33267c9c110a2
>         git remote add paulmck-rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
>         git fetch --no-tags paulmck-rcu dev.2021.08.25a
>         git checkout 545fb85f707c973cc4f1718572e33267c9c110a2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

This commit is long gone, courtesy of a fix for the underlying problem
being supplied by Frederic.

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    kernel/cpu.c:137:6: error: redefinition of 'cpu_hp_start_now'
>      137 | void cpu_hp_start_now(void)
>          |      ^~~~~~~~~~~~~~~~
>    In file included from kernel/cpu.c:17:
>    include/linux/cpu.h:147:20: note: previous definition of 'cpu_hp_start_now' with type 'void(void)'
>      147 | static inline void cpu_hp_start_now(void) { }
>          |                    ^~~~~~~~~~~~~~~~
>    kernel/cpu.c:146:6: error: redefinition of 'cpu_hp_stop_now'
>      146 | void cpu_hp_stop_now(void)
>          |      ^~~~~~~~~~~~~~~
>    In file included from kernel/cpu.c:17:
>    include/linux/cpu.h:148:20: note: previous definition of 'cpu_hp_stop_now' with type 'void(void)'
>      148 | static inline void cpu_hp_stop_now(void) { }
>          |                    ^~~~~~~~~~~~~~~
> >> kernel/cpu.c:158:6: error: conflicting types for 'cpu_hp_check_delay'; have 'bool(const char *, const void *)' {aka '_Bool(const char *, const void *)'}
>      158 | bool cpu_hp_check_delay(const char *s, const void *func)
>          |      ^~~~~~~~~~~~~~~~~~
>    In file included from kernel/cpu.c:17:
>    include/linux/cpu.h:149:20: note: previous definition of 'cpu_hp_check_delay' with type 'bool(const char *, void *)' {aka '_Bool(const char *, void *)'}
>      149 | static inline bool cpu_hp_check_delay(const char *s, void *func) { return false; }
>          |                    ^~~~~~~~~~~~~~~~~~
>    In file included from arch/arc/include/asm/bug.h:30,
>                     from include/linux/bug.h:5,
>                     from include/linux/thread_info.h:13,
>                     from include/asm-generic/preempt.h:5,
>                     from ./arch/arc/include/generated/asm/preempt.h:1,
>                     from include/linux/preempt.h:78,
>                     from include/linux/rcupdate.h:27,
>                     from include/linux/rculist.h:11,
>                     from include/linux/pid.h:5,
>                     from include/linux/sched.h:14,
>                     from include/linux/sched/mm.h:7,
>                     from kernel/cpu.c:6:
>    kernel/cpu.c: In function 'cpu_hp_check_delay':
>    kernel/cpu.c:170:48: warning: integer overflow in expression of type 'long int' results in '1215752192' [-Woverflow]
>      170 |         if (WARN_ONCE(time_after64(t1, t + 100 * NSEC_PER_SEC), "%s %ps took %llu milliseconds\n", s, func, (t1 - t) / NSEC_PER_MSEC)) {
>          |                                                ^
>    include/asm-generic/bug.h:173:32: note: in definition of macro 'WARN'
>      173 |         int __ret_warn_on = !!(condition);                              \
>          |                                ^~~~~~~~~
>    kernel/cpu.c:170:13: note: in expansion of macro 'WARN_ONCE'
>      170 |         if (WARN_ONCE(time_after64(t1, t + 100 * NSEC_PER_SEC), "%s %ps took %llu milliseconds\n", s, func, (t1 - t) / NSEC_PER_MSEC)) {
>          |             ^~~~~~~~~
>    kernel/cpu.c:170:23: note: in expansion of macro 'time_after64'
>      170 |         if (WARN_ONCE(time_after64(t1, t + 100 * NSEC_PER_SEC), "%s %ps took %llu milliseconds\n", s, func, (t1 - t) / NSEC_PER_MSEC)) {
>          |                       ^~~~~~~~~~~~
> 
> 
> vim +158 kernel/cpu.c
> 
>    156	
>    157	/* Return true if a time-delay anomaly was detected. */
>  > 158	bool cpu_hp_check_delay(const char *s, const void *func)
>    159	{
>    160		bool ret = false;
>    161		u64 t, t1;
>    162	
>    163		if (!smp_load_acquire(&cpu_hp_start_time_valid))
>    164			return false;
>    165		t = READ_ONCE(cpu_hp_start_time);
>    166		smp_mb();
>    167		if (!READ_ONCE(cpu_hp_start_time_valid))
>    168			return false;
>    169		t1 = ktime_get();
>    170		if (WARN_ONCE(time_after64(t1, t + 100 * NSEC_PER_SEC), "%s %ps took %llu milliseconds\n", s, func, (t1 - t) / NSEC_PER_MSEC)) {
>    171			WRITE_ONCE(cpu_hp_start_time, t1);
>    172			ret = true;
>    173		}
>    174		if (WARN_ONCE(time_before64(t1, t - 25 * NSEC_PER_MSEC), "%s %ps clock went backwards %llu milliseconds\n", s, func, (t - t1) / NSEC_PER_MSEC)){
>    175			WRITE_ONCE(cpu_hp_start_time, t1);
>    176			ret = true;
>    177		}
>    178		return ret;
>    179	}
>    180	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


