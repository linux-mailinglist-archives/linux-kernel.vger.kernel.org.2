Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC62D388C20
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhESKzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:55:46 -0400
Received: from mga18.intel.com ([134.134.136.126]:21437 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhESKzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:55:45 -0400
IronPort-SDR: 5hnOAZgnCwUKUM4IGfS7zxHIdFQl81dTS5iCV85HWECvABARYPVRs4hPQZ2EVADy8LI0VtVT6K
 IJvuX0VHLakw==
X-IronPort-AV: E=McAfee;i="6200,9189,9988"; a="188356028"
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="gz'50?scan'50,208,50";a="188356028"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2021 03:54:25 -0700
IronPort-SDR: +D3oyQI9XVLcv543XwhbPnup02eCd6NFqweOwrVgHeBOLQwF+4qzZyQGzMqgYa3R8MZOBsThQr
 vVc/vsuGh5pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,312,1613462400"; 
   d="gz'50?scan'50,208,50";a="473442799"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 May 2021 03:54:23 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljJqJ-00006c-6L; Wed, 19 May 2021 10:54:23 +0000
Date:   Wed, 19 May 2021 18:53:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Helge Deller <deller@gmx.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/parisc/kernel/sys_parisc.c:415:17: warning: no previous
 prototype for 'parisc_compat_signalfd4'
Message-ID: <202105191822.gRrRIfRt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8ac91e6c6033ebc12c5c1e4aa171b81a662bd70f
commit: 44a4c9e443674e6cd3368d3e642dfe9c429d5525 parisc: Add wrapper syscalls to fix O_NONBLOCK flag usage
date:   7 months ago
config: parisc-randconfig-r001-20210519 (attached as .config)
compiler: hppa64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44a4c9e443674e6cd3368d3e642dfe9c429d5525
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44a4c9e443674e6cd3368d3e642dfe9c429d5525
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/parisc/kernel/sys_parisc.c:228:15: warning: no previous prototype for 'arch_mmap_rnd' [-Wmissing-prototypes]
     228 | unsigned long arch_mmap_rnd(void)
         |               ^~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:256:26: warning: no previous prototype for 'sys_mmap2' [-Wmissing-prototypes]
     256 | asmlinkage unsigned long sys_mmap2(unsigned long addr, unsigned long len,
         |                          ^~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:266:26: warning: no previous prototype for 'sys_mmap' [-Wmissing-prototypes]
     266 | asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
         |                          ^~~~~~~~
   arch/parisc/kernel/sys_parisc.c:281:17: warning: no previous prototype for 'parisc_truncate64' [-Wmissing-prototypes]
     281 | asmlinkage long parisc_truncate64(const char __user * path,
         |                 ^~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:287:17: warning: no previous prototype for 'parisc_ftruncate64' [-Wmissing-prototypes]
     287 | asmlinkage long parisc_ftruncate64(unsigned int fd,
         |                 ^~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:295:17: warning: no previous prototype for 'sys_truncate64' [-Wmissing-prototypes]
     295 | asmlinkage long sys_truncate64(const char __user * path, unsigned long length)
         |                 ^~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:299:17: warning: no previous prototype for 'sys_ftruncate64' [-Wmissing-prototypes]
     299 | asmlinkage long sys_ftruncate64(unsigned int fd, unsigned long length)
         |                 ^~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:303:17: warning: no previous prototype for 'sys_fcntl64' [-Wmissing-prototypes]
     303 | asmlinkage long sys_fcntl64(unsigned int fd, unsigned int cmd, unsigned long arg)
         |                 ^~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:322:20: warning: no previous prototype for 'parisc_pread64' [-Wmissing-prototypes]
     322 | asmlinkage ssize_t parisc_pread64(unsigned int fd, char __user *buf, size_t count,
         |                    ^~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:328:20: warning: no previous prototype for 'parisc_pwrite64' [-Wmissing-prototypes]
     328 | asmlinkage ssize_t parisc_pwrite64(unsigned int fd, const char __user *buf,
         |                    ^~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:334:20: warning: no previous prototype for 'parisc_readahead' [-Wmissing-prototypes]
     334 | asmlinkage ssize_t parisc_readahead(int fd, unsigned int high, unsigned int low,
         |                    ^~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:340:17: warning: no previous prototype for 'parisc_fadvise64_64' [-Wmissing-prototypes]
     340 | asmlinkage long parisc_fadvise64_64(int fd,
         |                 ^~~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:348:17: warning: no previous prototype for 'parisc_sync_file_range' [-Wmissing-prototypes]
     348 | asmlinkage long parisc_sync_file_range(int fd,
         |                 ^~~~~~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:356:17: warning: no previous prototype for 'parisc_fallocate' [-Wmissing-prototypes]
     356 | asmlinkage long parisc_fallocate(int fd, int mode, u32 offhi, u32 offlo,
         |                 ^~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:363:6: warning: no previous prototype for 'parisc_personality' [-Wmissing-prototypes]
     363 | long parisc_personality(unsigned long personality)
         |      ^~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:401:17: warning: no previous prototype for 'parisc_timerfd_create' [-Wmissing-prototypes]
     401 | asmlinkage long parisc_timerfd_create(int clockid, int flags)
         |                 ^~~~~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:407:17: warning: no previous prototype for 'parisc_signalfd4' [-Wmissing-prototypes]
     407 | asmlinkage long parisc_signalfd4(int ufd, sigset_t __user *user_mask,
         |                 ^~~~~~~~~~~~~~~~
>> arch/parisc/kernel/sys_parisc.c:415:17: warning: no previous prototype for 'parisc_compat_signalfd4' [-Wmissing-prototypes]
     415 | asmlinkage long parisc_compat_signalfd4(int ufd,
         |                 ^~~~~~~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:424:17: warning: no previous prototype for 'parisc_eventfd2' [-Wmissing-prototypes]
     424 | asmlinkage long parisc_eventfd2(unsigned int count, int flags)
         |                 ^~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:430:17: warning: no previous prototype for 'parisc_userfaultfd' [-Wmissing-prototypes]
     430 | asmlinkage long parisc_userfaultfd(int flags)
         |                 ^~~~~~~~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:436:17: warning: no previous prototype for 'parisc_pipe2' [-Wmissing-prototypes]
     436 | asmlinkage long parisc_pipe2(int __user *fildes, int flags)
         |                 ^~~~~~~~~~~~
   arch/parisc/kernel/sys_parisc.c:442:17: warning: no previous prototype for 'parisc_inotify_init1' [-Wmissing-prototypes]
     442 | asmlinkage long parisc_inotify_init1(int flags)
         |                 ^~~~~~~~~~~~~~~~~~~~


vim +/parisc_compat_signalfd4 +415 arch/parisc/kernel/sys_parisc.c

   362	
 > 363	long parisc_personality(unsigned long personality)
   364	{
   365		long err;
   366	
   367		if (personality(current->personality) == PER_LINUX32
   368		    && personality(personality) == PER_LINUX)
   369			personality = (personality & ~PER_MASK) | PER_LINUX32;
   370	
   371		err = sys_personality(personality);
   372		if (personality(err) == PER_LINUX32)
   373			err = (err & ~PER_MASK) | PER_LINUX;
   374	
   375		return err;
   376	}
   377	
   378	/*
   379	 * Up to kernel v5.9 we defined O_NONBLOCK as 000200004,
   380	 * since then O_NONBLOCK is defined as 000200000.
   381	 *
   382	 * The following wrapper functions mask out the old
   383	 * O_NDELAY bit from calls which use O_NONBLOCK.
   384	 *
   385	 * XXX: Remove those in year 2022 (or later)?
   386	 */
   387	
   388	#define O_NONBLOCK_OLD		000200004
   389	#define O_NONBLOCK_MASK_OUT	(O_NONBLOCK_OLD & ~O_NONBLOCK)
   390	
   391	static int FIX_O_NONBLOCK(int flags)
   392	{
   393		if (flags & O_NONBLOCK_MASK_OUT) {
   394			struct task_struct *tsk = current;
   395			pr_warn_once("%s(%d) uses a deprecated O_NONBLOCK value.\n",
   396				tsk->comm, tsk->pid);
   397		}
   398		return flags & ~O_NONBLOCK_MASK_OUT;
   399	}
   400	
   401	asmlinkage long parisc_timerfd_create(int clockid, int flags)
   402	{
   403		flags = FIX_O_NONBLOCK(flags);
   404		return sys_timerfd_create(clockid, flags);
   405	}
   406	
   407	asmlinkage long parisc_signalfd4(int ufd, sigset_t __user *user_mask,
   408		size_t sizemask, int flags)
   409	{
   410		flags = FIX_O_NONBLOCK(flags);
   411		return sys_signalfd4(ufd, user_mask, sizemask, flags);
   412	}
   413	
   414	#ifdef CONFIG_COMPAT
 > 415	asmlinkage long parisc_compat_signalfd4(int ufd,
   416		compat_sigset_t __user *user_mask,
   417		compat_size_t sizemask, int flags)
   418	{
   419		flags = FIX_O_NONBLOCK(flags);
   420		return compat_sys_signalfd4(ufd, user_mask, sizemask, flags);
   421	}
   422	#endif
   423	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--opJtzjQTFsWo+cga--
