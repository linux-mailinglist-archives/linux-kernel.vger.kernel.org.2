Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2863CCBEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 03:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhGSBY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 21:24:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:43295 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232895AbhGSBY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 21:24:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10049"; a="232743863"
X-IronPort-AV: E=Sophos;i="5.84,250,1620716400"; 
   d="gz'50?scan'50,208,50";a="232743863"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 18:21:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,250,1620716400"; 
   d="gz'50?scan'50,208,50";a="430424427"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2021 18:21:55 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5Hyk-0000VO-Du; Mon, 19 Jul 2021 01:21:54 +0000
Date:   Mon, 19 Jul 2021 09:21:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:locking/ww_rt_mutex 4/18] lib/test_lockup.c:505:43:
 error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named
 'rlock'; did you mean 'raw_lock'?
Message-ID: <202107190928.EsYcI3n1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/ww_rt_mutex
head:   401531ec0e4c84f3d26d07d1171f893fee6a08aa
commit: 511b1625b0aa486360862d240d93d54c005ccaf0 [4/18] locking/mutex: Make mutex::wait_lock raw
config: nios2-buildonly-randconfig-r003-20210718 (attached as .config)
compiler: nios2-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=511b1625b0aa486360862d240d93d54c005ccaf0
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue locking/ww_rt_mutex
        git checkout 511b1625b0aa486360862d240d93d54c005ccaf0
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   lib/test_lockup.c: In function 'test_lockup_init':
>> lib/test_lockup.c:505:43: error: 'raw_spinlock_t' {aka 'struct raw_spinlock'} has no member named 'rlock'; did you mean 'raw_lock'?
     505 |          offsetof(struct mutex, wait_lock.rlock.magic),
         |                                           ^~~~~
   include/linux/compiler_types.h:140:57: note: in definition of macro '__compiler_offsetof'
     140 | #define __compiler_offsetof(a, b) __builtin_offsetof(a, b)
         |                                                         ^
   lib/test_lockup.c:505:10: note: in expansion of macro 'offsetof'
     505 |          offsetof(struct mutex, wait_lock.rlock.magic),
         |          ^~~~~~~~


vim +505 lib/test_lockup.c

30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  448  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  449  static int __init test_lockup_init(void)
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  450  {
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  451  	u64 test_start = local_clock();
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  452  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  453  	main_task = current;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  454  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  455  	switch (state[0]) {
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  456  	case 'S':
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  457  		wait_state = TASK_INTERRUPTIBLE;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  458  		break;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  459  	case 'D':
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  460  		wait_state = TASK_UNINTERRUPTIBLE;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  461  		break;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  462  	case 'K':
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  463  		wait_state = TASK_KILLABLE;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  464  		break;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  465  	case 'R':
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  466  		wait_state = TASK_RUNNING;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  467  		break;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  468  	default:
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  469  		pr_err("unknown state=%s\n", state);
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  470  		return -EINVAL;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  471  	}
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  472  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  473  	if (alloc_pages_atomic)
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  474  		alloc_pages_gfp = GFP_ATOMIC;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  475  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  476  	if (test_kernel_ptr(lock_spinlock_ptr, sizeof(spinlock_t)) ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  477  	    test_kernel_ptr(lock_rwlock_ptr, sizeof(rwlock_t)) ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  478  	    test_kernel_ptr(lock_mutex_ptr, sizeof(struct mutex)) ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  479  	    test_kernel_ptr(lock_rwsem_ptr, sizeof(struct rw_semaphore)))
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  480  		return -EINVAL;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  481  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  482  #ifdef CONFIG_DEBUG_SPINLOCK
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  483  #ifdef CONFIG_PREEMPT_RT
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  484  	if (test_magic(lock_spinlock_ptr,
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  485  		       offsetof(spinlock_t, lock.wait_lock.magic),
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  486  		       SPINLOCK_MAGIC) ||
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  487  	    test_magic(lock_rwlock_ptr,
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  488  		       offsetof(rwlock_t, rtmutex.wait_lock.magic),
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  489  		       SPINLOCK_MAGIC) ||
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  490  	    test_magic(lock_mutex_ptr,
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  491  		       offsetof(struct mutex, lock.wait_lock.magic),
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  492  		       SPINLOCK_MAGIC) ||
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  493  	    test_magic(lock_rwsem_ptr,
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  494  		       offsetof(struct rw_semaphore, rtmutex.wait_lock.magic),
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  495  		       SPINLOCK_MAGIC))
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  496  		return -EINVAL;
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  497  #else
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  498  	if (test_magic(lock_spinlock_ptr,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  499  		       offsetof(spinlock_t, rlock.magic),
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  500  		       SPINLOCK_MAGIC) ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  501  	    test_magic(lock_rwlock_ptr,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  502  		       offsetof(rwlock_t, magic),
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  503  		       RWLOCK_MAGIC) ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  504  	    test_magic(lock_mutex_ptr,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06 @505  		       offsetof(struct mutex, wait_lock.rlock.magic),
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  506  		       SPINLOCK_MAGIC) ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  507  	    test_magic(lock_rwsem_ptr,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  508  		       offsetof(struct rw_semaphore, wait_lock.magic),
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  509  		       SPINLOCK_MAGIC))
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  510  		return -EINVAL;
45e3d5a2af1d53 Sebastian Andrzej Siewior 2020-12-15  511  #endif
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  512  #endif
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  513  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  514  	if ((wait_state != TASK_RUNNING ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  515  	     (call_cond_resched && !reacquire_locks) ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  516  	     (alloc_pages_nr && gfpflags_allow_blocking(alloc_pages_gfp))) &&
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  517  	    (test_disable_irq || disable_softirq || disable_preempt ||
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  518  	     lock_rcu || lock_spinlock_ptr || lock_rwlock_ptr)) {
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  519  		pr_err("refuse to sleep in atomic context\n");
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  520  		return -EINVAL;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  521  	}
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  522  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  523  	if (lock_mmap_sem && !main_task->mm) {
c1e8d7c6a7a682 Michel Lespinasse         2020-06-08  524  		pr_err("no mm to lock mmap_lock\n");
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  525  		return -EINVAL;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  526  	}
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  527  
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  528  	if (test_file_path[0]) {
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  529  		test_file = filp_open(test_file_path, O_RDONLY, 0);
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  530  		if (IS_ERR(test_file)) {
3adf3bae0d6123 Tiezhu Yang               2020-08-11  531  			pr_err("failed to open %s: %ld\n", test_file_path, PTR_ERR(test_file));
3adf3bae0d6123 Tiezhu Yang               2020-08-11  532  			return PTR_ERR(test_file);
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  533  		}
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  534  		test_inode = file_inode(test_file);
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  535  	} else if (test_lock_inode ||
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  536  		   test_lock_mapping ||
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  537  		   test_lock_sb_umount) {
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  538  		pr_err("no file to lock\n");
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  539  		return -EINVAL;
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  540  	}
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  541  
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  542  	if (test_lock_inode && test_inode)
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  543  		lock_rwsem_ptr = (unsigned long)&test_inode->i_rwsem;
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  544  
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  545  	if (test_lock_mapping && test_file && test_file->f_mapping)
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  546  		lock_rwsem_ptr = (unsigned long)&test_file->f_mapping->i_mmap_rwsem;
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  547  
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  548  	if (test_lock_sb_umount && test_inode)
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  549  		lock_rwsem_ptr = (unsigned long)&test_inode->i_sb->s_umount;
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  550  
ad3f434b87e7d2 Colin Ian King            2020-04-06  551  	pr_notice("START pid=%d time=%u +%u ns cooldown=%u +%u ns iterations=%u state=%s %s%s%s%s%s%s%s%s%s%s%s\n",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  552  		  main_task->pid, time_secs, time_nsecs,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  553  		  cooldown_secs, cooldown_nsecs, iterations, state,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  554  		  all_cpus ? "all_cpus " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  555  		  iowait ? "iowait " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  556  		  test_disable_irq ? "disable_irq " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  557  		  disable_softirq ? "disable_softirq " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  558  		  disable_preempt ? "disable_preempt " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  559  		  lock_rcu ? "lock_rcu " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  560  		  lock_read ? "lock_read " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  561  		  touch_softlockup ? "touch_softlockup " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  562  		  touch_hardlockup ? "touch_hardlockup " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  563  		  call_cond_resched ? "call_cond_resched " : "",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  564  		  reacquire_locks ? "reacquire_locks " : "");
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  565  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  566  	if (alloc_pages_nr)
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  567  		pr_notice("ALLOCATE PAGES nr=%u order=%u gfp=%pGg %s\n",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  568  			  alloc_pages_nr, alloc_pages_order, &alloc_pages_gfp,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  569  			  reallocate_pages ? "reallocate_pages " : "");
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  570  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  571  	if (all_cpus) {
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  572  		unsigned int cpu;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  573  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  574  		cpus_read_lock();
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  575  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  576  		preempt_disable();
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  577  		master_cpu = smp_processor_id();
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  578  		for_each_online_cpu(cpu) {
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  579  			INIT_WORK(per_cpu_ptr(&test_works, cpu), test_work_fn);
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  580  			queue_work_on(cpu, system_highpri_wq,
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  581  				      per_cpu_ptr(&test_works, cpu));
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  582  		}
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  583  		preempt_enable();
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  584  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  585  		for_each_online_cpu(cpu)
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  586  			flush_work(per_cpu_ptr(&test_works, cpu));
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  587  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  588  		cpus_read_unlock();
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  589  	} else {
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  590  		test_lockup(true);
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  591  	}
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  592  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  593  	if (measure_lock_wait)
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  594  		pr_notice("Maximum lock wait: %lld ns\n",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  595  			  atomic64_read(&max_lock_wait));
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  596  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  597  	if (alloc_pages_nr)
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  598  		pr_notice("Page allocation failed %u times\n",
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  599  			  atomic_read(&alloc_pages_failed));
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  600  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  601  	pr_notice("FINISH in %llu ns\n", local_clock() - test_start);
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  602  
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  603  	if (test_file)
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  604  		fput(test_file);
aecd42df6d3993 Konstantin Khlebnikov     2020-04-06  605  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  606  	if (signal_pending(main_task))
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  607  		return -EINTR;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  608  
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  609  	return -EAGAIN;
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  610  }
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  611  module_init(test_lockup_init);
30428ef5d1e8ca Konstantin Khlebnikov     2020-04-06  612  

:::::: The code at line 505 was first introduced by commit
:::::: 30428ef5d1e8caf78639cc70a802f1cb7b1cec04 lib/test_lockup: test module to generate lockups

:::::: TO: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--tKW2IUtsqtDRztdT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1eyKDuTtGdD+H2alIMiO6gEA

--tKW2IUtsqtDRztdT--
