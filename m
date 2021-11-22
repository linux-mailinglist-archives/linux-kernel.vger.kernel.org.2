Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5B84596C2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 22:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbhKVVgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 16:36:16 -0500
Received: from mga05.intel.com ([192.55.52.43]:48008 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232661AbhKVVgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 16:36:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321116719"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="gz'50?scan'50,208,50";a="321116719"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 13:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="gz'50?scan'50,208,50";a="674216238"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 22 Nov 2021 13:33:04 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpGvv-0000ij-Ri; Mon, 22 Nov 2021 21:33:03 +0000
Date:   Tue, 23 Nov 2021 05:32:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [mcgrof-next:20211116-sysctl-cleanups-v4 2/35]
 kernel/sysctl.c:2672:36: error: 'two' undeclared here (not in a function)
Message-ID: <202111230502.zgbSJBW7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211116-sysctl-cleanups-v4
head:   5347239461f25fc50aa761923245b9ec4a4aafec
commit: 37e460619d410ba6d64ba60869e4883fb0b397ee [2/35] sysctl: Move some boundary constants form sysctl.c to sysctl_vals
config: m68k-defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=37e460619d410ba6d64ba60869e4883fb0b397ee
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211116-sysctl-cleanups-v4
        git checkout 37e460619d410ba6d64ba60869e4883fb0b397ee
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mcgrof-next/20211116-sysctl-cleanups-v4 HEAD 5347239461f25fc50aa761923245b9ec4a4aafec builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> kernel/sysctl.c:2672:36: error: 'two' undeclared here (not in a function)
    2672 |                 .extra2         = &two,
         |                                    ^~~


vim +/two +2672 kernel/sysctl.c

cb8e59cc87201a Linus Torvalds               2020-06-03  2417  
cb8e59cc87201a Linus Torvalds               2020-06-03  2418  #if (defined(CONFIG_X86_32) || defined(CONFIG_PARISC)) && \
cb8e59cc87201a Linus Torvalds               2020-06-03  2419  	defined(CONFIG_DEBUG_STACKOVERFLOW)
^1da177e4c3f41 Linus Torvalds               2005-04-16  2420  	{
cb8e59cc87201a Linus Torvalds               2020-06-03  2421  		.procname	= "panic_on_stackoverflow",
cb8e59cc87201a Linus Torvalds               2020-06-03  2422  		.data		= &sysctl_panic_on_stackoverflow,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2423  		.maxlen		= sizeof(int),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2424  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2425  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2426  	},
cb8e59cc87201a Linus Torvalds               2020-06-03  2427  #endif
cb8e59cc87201a Linus Torvalds               2020-06-03  2428  #if defined(CONFIG_X86)
9cfe015aa424b3 Eric Dumazet                 2008-02-06  2429  	{
cb8e59cc87201a Linus Torvalds               2020-06-03  2430  		.procname	= "panic_on_unrecovered_nmi",
cb8e59cc87201a Linus Torvalds               2020-06-03  2431  		.data		= &panic_on_unrecovered_nmi,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2432  		.maxlen		= sizeof(int),
9cfe015aa424b3 Eric Dumazet                 2008-02-06  2433  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2434  		.proc_handler	= proc_dointvec,
9cfe015aa424b3 Eric Dumazet                 2008-02-06  2435  	},
^1da177e4c3f41 Linus Torvalds               2005-04-16  2436  	{
cb8e59cc87201a Linus Torvalds               2020-06-03  2437  		.procname	= "panic_on_io_nmi",
cb8e59cc87201a Linus Torvalds               2020-06-03  2438  		.data		= &panic_on_io_nmi,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2439  		.maxlen		= sizeof(int),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2440  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2441  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2442  	},
^1da177e4c3f41 Linus Torvalds               2005-04-16  2443  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2444  		.procname	= "bootloader_type",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2445  		.data		= &bootloader_type,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2446  		.maxlen		= sizeof (int),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2447  		.mode		= 0444,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2448  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2449  	},
^1da177e4c3f41 Linus Torvalds               2005-04-16  2450  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2451  		.procname	= "bootloader_version",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2452  		.data		= &bootloader_version,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2453  		.maxlen		= sizeof (int),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2454  		.mode		= 0444,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2455  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2456  	},
^1da177e4c3f41 Linus Torvalds               2005-04-16  2457  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2458  		.procname	= "io_delay_type",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2459  		.data		= &io_delay_type,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2460  		.maxlen		= sizeof(int),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2461  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman            2009-11-16  2462  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2463  	},
bfcd17a6c5529b Thomas Petazzoni             2008-08-06  2464  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2465  #if defined(CONFIG_MMU)
^1da177e4c3f41 Linus Torvalds               2005-04-16  2466  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2467  		.procname	= "randomize_va_space",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2468  		.data		= &randomize_va_space,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2469  		.maxlen		= sizeof(int),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2470  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman            2009-11-16  2471  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2472  	},
^1da177e4c3f41 Linus Torvalds               2005-04-16  2473  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2474  #if defined(CONFIG_S390) && defined(CONFIG_SMP)
^1da177e4c3f41 Linus Torvalds               2005-04-16  2475  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2476  		.procname	= "spin_retry",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2477  		.data		= &spin_retry,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2478  		.maxlen		= sizeof (int),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2479  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman            2009-11-16  2480  		.proc_handler	= proc_dointvec,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2481  	},
bfcd17a6c5529b Thomas Petazzoni             2008-08-06  2482  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2483  #if	defined(CONFIG_ACPI_SLEEP) && defined(CONFIG_X86)
^1da177e4c3f41 Linus Torvalds               2005-04-16  2484  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2485  		.procname	= "acpi_video_flags",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2486  		.data		= &acpi_realmode_flags,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2487  		.maxlen		= sizeof (unsigned long),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2488  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman            2009-11-16  2489  		.proc_handler	= proc_doulongvec_minmax,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2490  	},
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2491  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2492  #ifdef CONFIG_SYSCTL_ARCH_UNALIGN_NO_WARN
0399cb08c54708 Robert Love                  2005-07-13  2493  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2494  		.procname	= "ignore-unaligned-usertrap",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2495  		.data		= &no_unaligned_warning,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2496  		.maxlen		= sizeof (int),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2497  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2498  		.proc_handler	= proc_dointvec,
0399cb08c54708 Robert Love                  2005-07-13  2499  	},
0399cb08c54708 Robert Love                  2005-07-13  2500  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2501  #ifdef CONFIG_IA64
7ef9964e6d1b91 Davide Libenzi               2008-12-01  2502  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2503  		.procname	= "unaligned-dump-stack",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2504  		.data		= &unaligned_dump_stack,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2505  		.maxlen		= sizeof (int),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2506  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2507  		.proc_handler	= proc_dointvec,
7ef9964e6d1b91 Davide Libenzi               2008-12-01  2508  	},
7ef9964e6d1b91 Davide Libenzi               2008-12-01  2509  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2510  #ifdef CONFIG_DETECT_HUNG_TASK
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2511  #ifdef CONFIG_SMP
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2512  	{
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2513  		.procname	= "hung_task_all_cpu_backtrace",
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2514  		.data		= &sysctl_hung_task_all_cpu_backtrace,
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2515  		.maxlen		= sizeof(int),
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2516  		.mode		= 0644,
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2517  		.proc_handler	= proc_dointvec_minmax,
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2518  		.extra1		= SYSCTL_ZERO,
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2519  		.extra2		= SYSCTL_ONE,
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2520  	},
0ec9dc9bcba0a6 Guilherme G. Piccoli         2020-06-07  2521  #endif /* CONFIG_SMP */
800179c9b8a1e7 Kees Cook                    2012-07-25  2522  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2523  		.procname	= "hung_task_panic",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2524  		.data		= &sysctl_hung_task_panic,
800179c9b8a1e7 Kees Cook                    2012-07-25  2525  		.maxlen		= sizeof(int),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2526  		.mode		= 0644,
800179c9b8a1e7 Kees Cook                    2012-07-25  2527  		.proc_handler	= proc_dointvec_minmax,
eec4844fae7c03 Matteo Croce                 2019-07-18  2528  		.extra1		= SYSCTL_ZERO,
eec4844fae7c03 Matteo Croce                 2019-07-18  2529  		.extra2		= SYSCTL_ONE,
800179c9b8a1e7 Kees Cook                    2012-07-25  2530  	},
800179c9b8a1e7 Kees Cook                    2012-07-25  2531  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2532  		.procname	= "hung_task_check_count",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2533  		.data		= &sysctl_hung_task_check_count,
800179c9b8a1e7 Kees Cook                    2012-07-25  2534  		.maxlen		= sizeof(int),
9cfe015aa424b3 Eric Dumazet                 2008-02-06  2535  		.mode		= 0644,
800179c9b8a1e7 Kees Cook                    2012-07-25  2536  		.proc_handler	= proc_dointvec_minmax,
eec4844fae7c03 Matteo Croce                 2019-07-18  2537  		.extra1		= SYSCTL_ZERO,
800179c9b8a1e7 Kees Cook                    2012-07-25  2538  	},
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2539  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2540  		.procname	= "hung_task_timeout_secs",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2541  		.data		= &sysctl_hung_task_timeout_secs,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2542  		.maxlen		= sizeof(unsigned long),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2543  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2544  		.proc_handler	= proc_dohung_task_timeout_secs,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2545  		.extra2		= &hung_task_timeout_max,
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2546  	},
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2547  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2548  		.procname	= "hung_task_check_interval_secs",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2549  		.data		= &sysctl_hung_task_check_interval_secs,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2550  		.maxlen		= sizeof(unsigned long),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2551  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2552  		.proc_handler	= proc_dohung_task_timeout_secs,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2553  		.extra2		= &hung_task_timeout_max,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2554  	},
^1da177e4c3f41 Linus Torvalds               2005-04-16  2555  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2556  		.procname	= "hung_task_warnings",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2557  		.data		= &sysctl_hung_task_warnings,
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2558  		.maxlen		= sizeof(int),
^1da177e4c3f41 Linus Torvalds               2005-04-16  2559  		.mode		= 0644,
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2560  		.proc_handler	= proc_dointvec_minmax,
37e460619d410b Xiaoming Ni                  2020-05-16  2561  		.extra1		= SYSCTL_NEG_ONE,
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2562  	},
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2563  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2564  #ifdef CONFIG_RT_MUTEXES
d6e711448137ca Alan Cox                     2005-06-23  2565  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2566  		.procname	= "max_lock_depth",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2567  		.data		= &max_lock_depth,
d6e711448137ca Alan Cox                     2005-06-23  2568  		.maxlen		= sizeof(int),
d6e711448137ca Alan Cox                     2005-06-23  2569  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman            2009-11-16  2570  		.proc_handler	= proc_dointvec,
d6e711448137ca Alan Cox                     2005-06-23  2571  	},
bfcd17a6c5529b Thomas Petazzoni             2008-08-06  2572  #endif
2abc26fc6b6f60 Eric W. Biederman            2007-02-14  2573  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2574  		.procname	= "poweroff_cmd",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2575  		.data		= &poweroff_cmd,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2576  		.maxlen		= POWEROFF_CMD_PATH_LEN,
^1da177e4c3f41 Linus Torvalds               2005-04-16  2577  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2578  		.proc_handler	= proc_dostring,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2579  	},
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2580  #ifdef CONFIG_KEYS
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2581  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2582  		.procname	= "keys",
2abc26fc6b6f60 Eric W. Biederman            2007-02-14  2583  		.mode		= 0555,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2584  		.child		= key_sysctls,
2abc26fc6b6f60 Eric W. Biederman            2007-02-14  2585  	},
2abc26fc6b6f60 Eric W. Biederman            2007-02-14  2586  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2587  #ifdef CONFIG_PERF_EVENTS
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2588  	/*
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2589  	 * User-space scripts rely on the existence of this file
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2590  	 * as a feature check for perf_events being enabled.
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2591  	 *
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2592  	 * So it's an ABI, do not remove!
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2593  	 */
b492e95be0ae67 Jens Axboe                   2010-05-19  2594  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2595  		.procname	= "perf_event_paranoid",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2596  		.data		= &sysctl_perf_event_paranoid,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2597  		.maxlen		= sizeof(sysctl_perf_event_paranoid),
b492e95be0ae67 Jens Axboe                   2010-05-19  2598  		.mode		= 0644,
6d4561110a3e9f Eric W. Biederman            2009-11-16  2599  		.proc_handler	= proc_dointvec,
b492e95be0ae67 Jens Axboe                   2010-05-19  2600  	},
759c01142a5d0f Willy Tarreau                2016-01-18  2601  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2602  		.procname	= "perf_event_mlock_kb",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2603  		.data		= &sysctl_perf_event_mlock,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2604  		.maxlen		= sizeof(sysctl_perf_event_mlock),
759c01142a5d0f Willy Tarreau                2016-01-18  2605  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2606  		.proc_handler	= proc_dointvec,
759c01142a5d0f Willy Tarreau                2016-01-18  2607  	},
759c01142a5d0f Willy Tarreau                2016-01-18  2608  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2609  		.procname	= "perf_event_max_sample_rate",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2610  		.data		= &sysctl_perf_event_sample_rate,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2611  		.maxlen		= sizeof(sysctl_perf_event_sample_rate),
759c01142a5d0f Willy Tarreau                2016-01-18  2612  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2613  		.proc_handler	= perf_proc_update_handler,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2614  		.extra1		= SYSCTL_ONE,
759c01142a5d0f Willy Tarreau                2016-01-18  2615  	},
d29216842a85c7 Eric W. Biederman            2016-09-28  2616  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2617  		.procname	= "perf_cpu_time_max_percent",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2618  		.data		= &sysctl_perf_cpu_time_max_percent,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2619  		.maxlen		= sizeof(sysctl_perf_cpu_time_max_percent),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2620  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2621  		.proc_handler	= perf_cpu_time_max_percent_handler,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2622  		.extra1		= SYSCTL_ZERO,
37e460619d410b Xiaoming Ni                  2020-05-16  2623  		.extra2		= SYSCTL_ONE_HUNDRED,
0399cb08c54708 Robert Love                  2005-07-13  2624  	},
7ef9964e6d1b91 Davide Libenzi               2008-12-01  2625  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2626  		.procname	= "perf_event_max_stack",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2627  		.data		= &sysctl_perf_event_max_stack,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2628  		.maxlen		= sizeof(sysctl_perf_event_max_stack),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2629  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2630  		.proc_handler	= perf_event_max_stack_handler,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2631  		.extra1		= SYSCTL_ZERO,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2632  		.extra2		= &six_hundred_forty_kb,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2633  	},
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2634  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2635  		.procname	= "perf_event_max_contexts_per_stack",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2636  		.data		= &sysctl_perf_event_max_contexts_per_stack,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2637  		.maxlen		= sizeof(sysctl_perf_event_max_contexts_per_stack),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2638  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2639  		.proc_handler	= perf_event_max_stack_handler,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2640  		.extra1		= SYSCTL_ZERO,
37e460619d410b Xiaoming Ni                  2020-05-16  2641  		.extra2		= SYSCTL_ONE_THOUSAND,
7ef9964e6d1b91 Davide Libenzi               2008-12-01  2642  	},
^1da177e4c3f41 Linus Torvalds               2005-04-16  2643  #endif
800179c9b8a1e7 Kees Cook                    2012-07-25  2644  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2645  		.procname	= "panic_on_warn",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2646  		.data		= &panic_on_warn,
800179c9b8a1e7 Kees Cook                    2012-07-25  2647  		.maxlen		= sizeof(int),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2648  		.mode		= 0644,
800179c9b8a1e7 Kees Cook                    2012-07-25  2649  		.proc_handler	= proc_dointvec_minmax,
eec4844fae7c03 Matteo Croce                 2019-07-18  2650  		.extra1		= SYSCTL_ZERO,
eec4844fae7c03 Matteo Croce                 2019-07-18  2651  		.extra2		= SYSCTL_ONE,
800179c9b8a1e7 Kees Cook                    2012-07-25  2652  	},
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2653  #if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
800179c9b8a1e7 Kees Cook                    2012-07-25  2654  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2655  		.procname	= "timer_migration",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2656  		.data		= &sysctl_timer_migration,
d29216842a85c7 Eric W. Biederman            2016-09-28  2657  		.maxlen		= sizeof(unsigned int),
d29216842a85c7 Eric W. Biederman            2016-09-28  2658  		.mode		= 0644,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2659  		.proc_handler	= timer_migration_handler,
eec4844fae7c03 Matteo Croce                 2019-07-18  2660  		.extra1		= SYSCTL_ZERO,
eec4844fae7c03 Matteo Croce                 2019-07-18  2661  		.extra2		= SYSCTL_ONE,
800179c9b8a1e7 Kees Cook                    2012-07-25  2662  	},
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2663  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2664  #ifdef CONFIG_BPF_SYSCALL
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2665  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2666  		.procname	= "unprivileged_bpf_disabled",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2667  		.data		= &sysctl_unprivileged_bpf_disabled,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2668  		.maxlen		= sizeof(sysctl_unprivileged_bpf_disabled),
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2669  		.mode		= 0644,
08389d888287c3 Daniel Borkmann              2021-05-11  2670  		.proc_handler	= bpf_unpriv_handler,
08389d888287c3 Daniel Borkmann              2021-05-11  2671  		.extra1		= SYSCTL_ZERO,
08389d888287c3 Daniel Borkmann              2021-05-11 @2672  		.extra2		= &two,
d29216842a85c7 Eric W. Biederman            2016-09-28  2673  	},
abd4f7505bafdd Masoud Asgharifard Sharbiani 2007-07-22  2674  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2675  		.procname	= "bpf_stats_enabled",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2676  		.data		= &bpf_stats_enabled_key.key,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2677  		.maxlen		= sizeof(bpf_stats_enabled_key),
abd4f7505bafdd Masoud Asgharifard Sharbiani 2007-07-22  2678  		.mode		= 0644,
d46edd671a1470 Song Liu                     2020-04-30  2679  		.proc_handler	= bpf_stats_handler,
abd4f7505bafdd Masoud Asgharifard Sharbiani 2007-07-22  2680  	},
b2be84df99ebc9 Masami Hiramatsu             2010-02-25  2681  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2682  #if defined(CONFIG_TREE_RCU)
b2be84df99ebc9 Masami Hiramatsu             2010-02-25  2683  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2684  		.procname	= "panic_on_rcu_stall",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2685  		.data		= &sysctl_panic_on_rcu_stall,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2686  		.maxlen		= sizeof(sysctl_panic_on_rcu_stall),
b2be84df99ebc9 Masami Hiramatsu             2010-02-25  2687  		.mode		= 0644,
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2688  		.proc_handler	= proc_dointvec_minmax,
eec4844fae7c03 Matteo Croce                 2019-07-18  2689  		.extra1		= SYSCTL_ZERO,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2690  		.extra2		= SYSCTL_ONE,
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2691  	},
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2692  #endif
dfe564045c653d chao                         2020-08-30  2693  #if defined(CONFIG_TREE_RCU)
dfe564045c653d chao                         2020-08-30  2694  	{
dfe564045c653d chao                         2020-08-30  2695  		.procname	= "max_rcu_stall_to_panic",
dfe564045c653d chao                         2020-08-30  2696  		.data		= &sysctl_max_rcu_stall_to_panic,
dfe564045c653d chao                         2020-08-30  2697  		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
dfe564045c653d chao                         2020-08-30  2698  		.mode		= 0644,
dfe564045c653d chao                         2020-08-30  2699  		.proc_handler	= proc_dointvec_minmax,
dfe564045c653d chao                         2020-08-30  2700  		.extra1		= SYSCTL_ONE,
dfe564045c653d chao                         2020-08-30  2701  		.extra2		= SYSCTL_INT_MAX,
dfe564045c653d chao                         2020-08-30  2702  	},
dfe564045c653d chao                         2020-08-30  2703  #endif
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2704  #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2705  	{
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2706  		.procname	= "stack_erasing",
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2707  		.data		= NULL,
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2708  		.maxlen		= sizeof(int),
30aba6656f61ed Salvatore Mesoraca           2018-08-23  2709  		.mode		= 0600,
f461d2dcd511c0 Christoph Hellwig            2020-04-24  2710  		.proc_handler	= stack_erasing_sysctl,
eec4844fae7c03 Matteo Croce                 2019-07-18  2711  		.extra1		= SYSCTL_ZERO,
eec4844fae7c03 Matteo Croce                 2019-07-18  2712  		.extra2		= SYSCTL_ONE,
b2be84df99ebc9 Masami Hiramatsu             2010-02-25  2713  	},
abd4f7505bafdd Masoud Asgharifard Sharbiani 2007-07-22  2714  #endif
6fce56ec91b502 Eric W. Biederman            2009-04-03  2715  	{ }
^1da177e4c3f41 Linus Torvalds               2005-04-16  2716  };
^1da177e4c3f41 Linus Torvalds               2005-04-16  2717  

:::::: The code at line 2672 was first introduced by commit
:::::: 08389d888287c3823f80b0216766b71e17f0aba5 bpf: Add kconfig knob for disabling unpriv bpf by default

:::::: TO: Daniel Borkmann <daniel@iogearbox.net>
:::::: CC: Alexei Starovoitov <ast@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
//fjSbkrdcxfg1s2WAL+/zuizOS9GAEA

--xHFwDpU9dbj6ez1V--
