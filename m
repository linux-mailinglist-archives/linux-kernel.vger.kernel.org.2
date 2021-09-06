Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0340198A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbhIFKNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:13:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:47599 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241736AbhIFKN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:13:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10098"; a="219990619"
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="gz'50?scan'50,208,50";a="219990619"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 03:12:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,272,1624345200"; 
   d="gz'50?scan'50,208,50";a="523102793"
Received: from lkp-server01.sh.intel.com (HELO 53c23d017ad5) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Sep 2021 03:12:20 -0700
Received: from kbuild by 53c23d017ad5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mNBbv-0000ZX-R4; Mon, 06 Sep 2021 10:12:19 +0000
Date:   Mon, 6 Sep 2021 18:12:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [linux-stable-rc:linux-4.19.y 9566/9999]
 drivers/android/binder.c:3739: Error: unrecognized keyword/register name
 `l.lwz ?ap,4(r19)'
Message-ID: <202109061810.3FaxElkv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
head:   6c3e013be752bf70e7321d7c813d68eac8ac36b0
commit: e8236726c616d8843bf936e2bafefc2540bb87a7 [9566/9999] arch/openrisc: Fix issues with access_ok()
config: openrisc-randconfig-r003-20210906 (attached as .config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e8236726c616d8843bf936e2bafefc2540bb87a7
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.19.y
        git checkout e8236726c616d8843bf936e2bafefc2540bb87a7
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/ptrace.h:119:9: note: in expansion of macro 'if'
     119 |         if (unlikely(task->ptrace))
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/ptrace.h:119:13: note: in expansion of macro 'unlikely'
     119 |         if (unlikely(task->ptrace))
         |             ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/ptrace.h:119:9: note: in expansion of macro 'if'
     119 |         if (unlikely(task->ptrace))
         |         ^~
   include/linux/ptrace.h: In function 'ptrace_event':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/ptrace.h:150:9: note: in expansion of macro 'if'
     150 |         if (unlikely(ptrace_event_enabled(current, event))) {
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/ptrace.h:150:13: note: in expansion of macro 'unlikely'
     150 |         if (unlikely(ptrace_event_enabled(current, event))) {
         |             ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/ptrace.h:150:9: note: in expansion of macro 'if'
     150 |         if (unlikely(ptrace_event_enabled(current, event))) {
         |         ^~
   include/linux/ptrace.h: In function 'ptrace_init_task':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/ptrace.h:209:9: note: in expansion of macro 'if'
     209 |         if (unlikely(ptrace) && current->ptrace) {
         |         ^~
   include/linux/compiler.h:48:26: note: in expansion of macro '__branch_check__'
      48 | #  define unlikely(x)   (__branch_check__(x, 0, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/ptrace.h:209:13: note: in expansion of macro 'unlikely'
     209 |         if (unlikely(ptrace) && current->ptrace) {
         |             ^~~~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/ptrace.h:209:9: note: in expansion of macro 'if'
     209 |         if (unlikely(ptrace) && current->ptrace) {
         |         ^~
   include/linux/cgroup.h: In function 'task_get_css':
   include/linux/compiler.h:25:39: warning: ignoring attribute 'section ("_ftrace_annotated_branch")' because it conflicts with previous 'section ("_ftrace_branch")' [-Wattributes]
      25 |                         static struct ftrace_likely_data                \
         |                                       ^~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:69:30: note: in definition of macro '__trace_if'
      69 |                 ______r = !!(cond);                                     \
         |                              ^~~~
   include/linux/cgroup.h:509:17: note: in expansion of macro 'if'
     509 |                 if (likely(css_tryget(css)))
         |                 ^~
   include/linux/compiler.h:45:26: note: in expansion of macro '__branch_check__'
      45 | #  define likely(x)     (__branch_check__(x, 1, __builtin_constant_p(x)))
         |                          ^~~~~~~~~~~~~~~~
   include/linux/cgroup.h:509:21: note: in expansion of macro 'likely'
     509 |                 if (likely(css_tryget(css)))
         |                     ^~~~~~
   include/linux/compiler.h:64:25: note: previous declaration here
      64 |                         ______f = {                                     \
         |                         ^~~~~~~
   include/linux/compiler.h:56:23: note: in expansion of macro '__trace_if'
      56 | #define if(cond, ...) __trace_if( (cond , ## __VA_ARGS__) )
         |                       ^~~~~~~~~~
   include/linux/cgroup.h:509:17: note: in expansion of macro 'if'
     509 |                 if (likely(css_tryget(css)))
         |                 ^~
   drivers/android/binder.c: Assembler messages:
>> drivers/android/binder.c:3739: Error: unrecognized keyword/register name `l.lwz ?ap,4(r19)'
   drivers/android/binder.c:3744: Error: unrecognized keyword/register name `l.addi ?ap,r0,0'


vim +3739 drivers/android/binder.c

355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3325  
fb07ebc3e82a98a drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3326  static int binder_thread_write(struct binder_proc *proc,
fb07ebc3e82a98a drivers/staging/android/binder.c Bojan Prtvar           2013-09-02  3327  			struct binder_thread *thread,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3328  			binder_uintptr_t binder_buffer, size_t size,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3329  			binder_size_t *consumed)
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3330  {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3331  	uint32_t cmd;
342e5c90b60134d drivers/android/binder.c         Martijn Coenen         2017-02-03  3332  	struct binder_context *context = proc->context;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3333  	void __user *buffer = (void __user *)(uintptr_t)binder_buffer;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3334  	void __user *ptr = buffer + *consumed;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3335  	void __user *end = buffer + size;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3336  
26549d17741035b drivers/android/binder.c         Todd Kjos              2017-06-29  3337  	while (ptr < end && thread->return_error.cmd == BR_OK) {
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3338  		int ret;
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3339  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3340  		if (get_user(cmd, (uint32_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3341  			return -EFAULT;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3342  		ptr += sizeof(uint32_t);
975a1ac9a9fe65d drivers/staging/android/binder.c Arve Hjønnevåg         2012-10-16  3343  		trace_binder_command(cmd);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3344  		if (_IOC_NR(cmd) < ARRAY_SIZE(binder_stats.bc)) {
0953c7976c36ce0 drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3345  			atomic_inc(&binder_stats.bc[_IOC_NR(cmd)]);
0953c7976c36ce0 drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3346  			atomic_inc(&proc->stats.bc[_IOC_NR(cmd)]);
0953c7976c36ce0 drivers/android/binder.c         Badhri Jagan Sridharan 2017-06-29  3347  			atomic_inc(&thread->stats.bc[_IOC_NR(cmd)]);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3348  		}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3349  		switch (cmd) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3350  		case BC_INCREFS:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3351  		case BC_ACQUIRE:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3352  		case BC_RELEASE:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3353  		case BC_DECREFS: {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3354  			uint32_t target;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3355  			const char *debug_string;
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3356  			bool strong = cmd == BC_ACQUIRE || cmd == BC_RELEASE;
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3357  			bool increment = cmd == BC_INCREFS || cmd == BC_ACQUIRE;
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3358  			struct binder_ref_data rdata;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3359  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3360  			if (get_user(target, (uint32_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3361  				return -EFAULT;
c44b1231ff11709 drivers/android/binder.c         Todd Kjos              2017-06-29  3362  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3363  			ptr += sizeof(uint32_t);
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3364  			ret = -1;
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3365  			if (increment && !target) {
c44b1231ff11709 drivers/android/binder.c         Todd Kjos              2017-06-29  3366  				struct binder_node *ctx_mgr_node;
c44b1231ff11709 drivers/android/binder.c         Todd Kjos              2017-06-29  3367  				mutex_lock(&context->context_mgr_node_lock);
c44b1231ff11709 drivers/android/binder.c         Todd Kjos              2017-06-29  3368  				ctx_mgr_node = context->binder_context_mgr_node;
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3369  				if (ctx_mgr_node)
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3370  					ret = binder_inc_ref_for_node(
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3371  							proc, ctx_mgr_node,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3372  							strong, NULL, &rdata);
c44b1231ff11709 drivers/android/binder.c         Todd Kjos              2017-06-29  3373  				mutex_unlock(&context->context_mgr_node_lock);
c44b1231ff11709 drivers/android/binder.c         Todd Kjos              2017-06-29  3374  			}
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3375  			if (ret)
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3376  				ret = binder_update_ref_for_handle(
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3377  						proc, target, increment, strong,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3378  						&rdata);
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3379  			if (!ret && rdata.desc != target) {
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3380  				binder_user_error("%d:%d tried to acquire reference to desc %d, got %d instead\n",
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3381  					proc->pid, thread->pid,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3382  					target, rdata.desc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3383  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3384  			switch (cmd) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3385  			case BC_INCREFS:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3386  				debug_string = "IncRefs";
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3387  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3388  			case BC_ACQUIRE:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3389  				debug_string = "Acquire";
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3390  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3391  			case BC_RELEASE:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3392  				debug_string = "Release";
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3393  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3394  			case BC_DECREFS:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3395  			default:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3396  				debug_string = "DecRefs";
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3397  				break;
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3398  			}
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3399  			if (ret) {
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3400  				binder_user_error("%d:%d %s %d refcount change on invalid ref %d ret %d\n",
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3401  					proc->pid, thread->pid, debug_string,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3402  					strong, target, ret);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3403  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3404  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3405  			binder_debug(BINDER_DEBUG_USER_REFS,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3406  				     "%d:%d %s ref %d desc %d s %d w %d\n",
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3407  				     proc->pid, thread->pid, debug_string,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3408  				     rdata.debug_id, rdata.desc, rdata.strong,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3409  				     rdata.weak);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3410  			break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3411  		}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3412  		case BC_INCREFS_DONE:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3413  		case BC_ACQUIRE_DONE: {
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3414  			binder_uintptr_t node_ptr;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3415  			binder_uintptr_t cookie;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3416  			struct binder_node *node;
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3417  			bool free_node;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3418  
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3419  			if (get_user(node_ptr, (binder_uintptr_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3420  				return -EFAULT;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3421  			ptr += sizeof(binder_uintptr_t);
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3422  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3423  				return -EFAULT;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3424  			ptr += sizeof(binder_uintptr_t);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3425  			node = binder_get_node(proc, node_ptr);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3426  			if (node == NULL) {
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3427  				binder_user_error("%d:%d %s u%016llx no match\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3428  					proc->pid, thread->pid,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3429  					cmd == BC_INCREFS_DONE ?
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3430  					"BC_INCREFS_DONE" :
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3431  					"BC_ACQUIRE_DONE",
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3432  					(u64)node_ptr);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3433  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3434  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3435  			if (cookie != node->cookie) {
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3436  				binder_user_error("%d:%d %s u%016llx node %d cookie mismatch %016llx != %016llx\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3437  					proc->pid, thread->pid,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3438  					cmd == BC_INCREFS_DONE ?
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3439  					"BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3440  					(u64)node_ptr, node->debug_id,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3441  					(u64)cookie, (u64)node->cookie);
adc1884222276df drivers/android/binder.c         Todd Kjos              2017-06-29  3442  				binder_put_node(node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3443  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3444  			}
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3445  			binder_node_inner_lock(node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3446  			if (cmd == BC_ACQUIRE_DONE) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3447  				if (node->pending_strong_ref == 0) {
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3448  					binder_user_error("%d:%d BC_ACQUIRE_DONE node %d has no pending acquire request\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3449  						proc->pid, thread->pid,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3450  						node->debug_id);
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3451  					binder_node_inner_unlock(node);
adc1884222276df drivers/android/binder.c         Todd Kjos              2017-06-29  3452  					binder_put_node(node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3453  					break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3454  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3455  				node->pending_strong_ref = 0;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3456  			} else {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3457  				if (node->pending_weak_ref == 0) {
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3458  					binder_user_error("%d:%d BC_INCREFS_DONE node %d has no pending increfs request\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3459  						proc->pid, thread->pid,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3460  						node->debug_id);
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3461  					binder_node_inner_unlock(node);
adc1884222276df drivers/android/binder.c         Todd Kjos              2017-06-29  3462  					binder_put_node(node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3463  					break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3464  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3465  				node->pending_weak_ref = 0;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3466  			}
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3467  			free_node = binder_dec_node_nilocked(node,
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3468  					cmd == BC_ACQUIRE_DONE, 0);
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3469  			WARN_ON(free_node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3470  			binder_debug(BINDER_DEBUG_USER_REFS,
adc1884222276df drivers/android/binder.c         Todd Kjos              2017-06-29  3471  				     "%d:%d %s node %d ls %d lw %d tr %d\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3472  				     proc->pid, thread->pid,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3473  				     cmd == BC_INCREFS_DONE ? "BC_INCREFS_DONE" : "BC_ACQUIRE_DONE",
adc1884222276df drivers/android/binder.c         Todd Kjos              2017-06-29  3474  				     node->debug_id, node->local_strong_refs,
adc1884222276df drivers/android/binder.c         Todd Kjos              2017-06-29  3475  				     node->local_weak_refs, node->tmp_refs);
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3476  			binder_node_inner_unlock(node);
adc1884222276df drivers/android/binder.c         Todd Kjos              2017-06-29  3477  			binder_put_node(node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3478  			break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3479  		}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3480  		case BC_ATTEMPT_ACQUIRE:
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3481  			pr_err("BC_ATTEMPT_ACQUIRE not supported\n");
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3482  			return -EINVAL;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3483  		case BC_ACQUIRE_RESULT:
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3484  			pr_err("BC_ACQUIRE_RESULT not supported\n");
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3485  			return -EINVAL;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3486  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3487  		case BC_FREE_BUFFER: {
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3488  			binder_uintptr_t data_ptr;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3489  			struct binder_buffer *buffer;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3490  
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3491  			if (get_user(data_ptr, (binder_uintptr_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3492  				return -EFAULT;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3493  			ptr += sizeof(binder_uintptr_t);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3494  
53d311cfa19ad35 drivers/android/binder.c         Todd Kjos              2017-06-29  3495  			buffer = binder_alloc_prepare_to_free(&proc->alloc,
19c987241ca1216 drivers/android/binder.c         Todd Kjos              2017-06-29  3496  							      data_ptr);
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3497  			if (IS_ERR_OR_NULL(buffer)) {
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3498  				if (PTR_ERR(buffer) == -EPERM) {
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3499  					binder_user_error(
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3500  						"%d:%d BC_FREE_BUFFER u%016llx matched unreturned or currently freeing buffer\n",
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3501  						proc->pid, thread->pid,
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3502  						(u64)data_ptr);
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3503  				} else {
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3504  					binder_user_error(
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3505  						"%d:%d BC_FREE_BUFFER u%016llx no match\n",
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3506  						proc->pid, thread->pid,
553927d6aab993e drivers/android/binder.c         Todd Kjos              2018-11-06  3507  						(u64)data_ptr);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3508  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3509  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3510  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3511  			binder_debug(BINDER_DEBUG_FREE_BUFFER,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3512  				     "%d:%d BC_FREE_BUFFER u%016llx found buffer %d for %s transaction\n",
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3513  				     proc->pid, thread->pid, (u64)data_ptr,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3514  				     buffer->debug_id,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3515  				     buffer->transaction ? "active" : "finished");
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3516  
22068d49d09d2b3 drivers/android/binder.c         Todd Kjos              2019-06-12  3517  			binder_inner_proc_lock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3518  			if (buffer->transaction) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3519  				buffer->transaction->buffer = NULL;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3520  				buffer->transaction = NULL;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3521  			}
22068d49d09d2b3 drivers/android/binder.c         Todd Kjos              2019-06-12  3522  			binder_inner_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3523  			if (buffer->async_transaction && buffer->target_node) {
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3524  				struct binder_node *buf_node;
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3525  				struct binder_work *w;
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3526  
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3527  				buf_node = buffer->target_node;
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3528  				binder_node_inner_lock(buf_node);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3529  				BUG_ON(!buf_node->has_async_transaction);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3530  				BUG_ON(buf_node->proc != proc);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3531  				w = binder_dequeue_work_head_ilocked(
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3532  						&buf_node->async_todo);
3a6430ce462172c drivers/android/binder.c         Martijn Coenen         2017-08-31  3533  				if (!w) {
197410ad884eb18 drivers/android/binder.c         Gustavo A. R. Silva    2018-01-23  3534  					buf_node->has_async_transaction = false;
3a6430ce462172c drivers/android/binder.c         Martijn Coenen         2017-08-31  3535  				} else {
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3536  					binder_enqueue_work_ilocked(
3a6430ce462172c drivers/android/binder.c         Martijn Coenen         2017-08-31  3537  							w, &proc->todo);
3a6430ce462172c drivers/android/binder.c         Martijn Coenen         2017-08-31  3538  					binder_wakeup_proc_ilocked(proc);
3a6430ce462172c drivers/android/binder.c         Martijn Coenen         2017-08-31  3539  				}
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3540  				binder_node_inner_unlock(buf_node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3541  			}
975a1ac9a9fe65d drivers/staging/android/binder.c Arve Hjønnevåg         2012-10-16  3542  			trace_binder_transaction_buffer_release(buffer);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3543  			binder_transaction_buffer_release(proc, buffer, NULL);
19c987241ca1216 drivers/android/binder.c         Todd Kjos              2017-06-29  3544  			binder_alloc_free_buf(&proc->alloc, buffer);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3545  			break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3546  		}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3547  
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3548  		case BC_TRANSACTION_SG:
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3549  		case BC_REPLY_SG: {
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3550  			struct binder_transaction_data_sg tr;
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3551  
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3552  			if (copy_from_user(&tr, ptr, sizeof(tr)))
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3553  				return -EFAULT;
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3554  			ptr += sizeof(tr);
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3555  			binder_transaction(proc, thread, &tr.transaction_data,
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3556  					   cmd == BC_REPLY_SG, tr.buffers_size);
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3557  			break;
7980240b6d63e06 drivers/android/binder.c         Martijn Coenen         2017-02-03  3558  		}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3559  		case BC_TRANSACTION:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3560  		case BC_REPLY: {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3561  			struct binder_transaction_data tr;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3562  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3563  			if (copy_from_user(&tr, ptr, sizeof(tr)))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3564  				return -EFAULT;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3565  			ptr += sizeof(tr);
4bfac80af3a63f2 drivers/android/binder.c         Martijn Coenen         2017-02-03  3566  			binder_transaction(proc, thread, &tr,
4bfac80af3a63f2 drivers/android/binder.c         Martijn Coenen         2017-02-03  3567  					   cmd == BC_REPLY, 0);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3568  			break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3569  		}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3570  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3571  		case BC_REGISTER_LOOPER:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3572  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3573  				     "%d:%d BC_REGISTER_LOOPER\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3574  				     proc->pid, thread->pid);
b3e6861283790d7 drivers/android/binder.c         Todd Kjos              2017-06-29  3575  			binder_inner_proc_lock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3576  			if (thread->looper & BINDER_LOOPER_STATE_ENTERED) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3577  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3578  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called after BC_ENTER_LOOPER\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3579  					proc->pid, thread->pid);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3580  			} else if (proc->requested_threads == 0) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3581  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3582  				binder_user_error("%d:%d ERROR: BC_REGISTER_LOOPER called without request\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3583  					proc->pid, thread->pid);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3584  			} else {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3585  				proc->requested_threads--;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3586  				proc->requested_threads_started++;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3587  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3588  			thread->looper |= BINDER_LOOPER_STATE_REGISTERED;
b3e6861283790d7 drivers/android/binder.c         Todd Kjos              2017-06-29  3589  			binder_inner_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3590  			break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3591  		case BC_ENTER_LOOPER:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3592  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3593  				     "%d:%d BC_ENTER_LOOPER\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3594  				     proc->pid, thread->pid);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3595  			if (thread->looper & BINDER_LOOPER_STATE_REGISTERED) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3596  				thread->looper |= BINDER_LOOPER_STATE_INVALID;
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3597  				binder_user_error("%d:%d ERROR: BC_ENTER_LOOPER called after BC_REGISTER_LOOPER\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3598  					proc->pid, thread->pid);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3599  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3600  			thread->looper |= BINDER_LOOPER_STATE_ENTERED;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3601  			break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3602  		case BC_EXIT_LOOPER:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3603  			binder_debug(BINDER_DEBUG_THREADS,
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3604  				     "%d:%d BC_EXIT_LOOPER\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3605  				     proc->pid, thread->pid);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3606  			thread->looper |= BINDER_LOOPER_STATE_EXITED;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3607  			break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3608  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3609  		case BC_REQUEST_DEATH_NOTIFICATION:
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3610  		case BC_CLEAR_DEATH_NOTIFICATION: {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3611  			uint32_t target;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3612  			binder_uintptr_t cookie;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3613  			struct binder_ref *ref;
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3614  			struct binder_ref_death *death = NULL;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3615  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3616  			if (get_user(target, (uint32_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3617  				return -EFAULT;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3618  			ptr += sizeof(uint32_t);
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3619  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3620  				return -EFAULT;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3621  			ptr += sizeof(binder_uintptr_t);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3622  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3623  				/*
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3624  				 * Allocate memory for death notification
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3625  				 * before taking lock
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3626  				 */
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3627  				death = kzalloc(sizeof(*death), GFP_KERNEL);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3628  				if (death == NULL) {
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3629  					WARN_ON(thread->return_error.cmd !=
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3630  						BR_OK);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3631  					thread->return_error.cmd = BR_ERROR;
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3632  					binder_enqueue_thread_work(
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3633  						thread,
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3634  						&thread->return_error.work);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3635  					binder_debug(
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3636  						BINDER_DEBUG_FAILED_TRANSACTION,
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3637  						"%d:%d BC_REQUEST_DEATH_NOTIFICATION failed\n",
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3638  						proc->pid, thread->pid);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3639  					break;
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3640  				}
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3641  			}
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3642  			binder_proc_lock(proc);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3643  			ref = binder_get_ref_olocked(proc, target, false);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3644  			if (ref == NULL) {
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3645  				binder_user_error("%d:%d %s invalid ref %d\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3646  					proc->pid, thread->pid,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3647  					cmd == BC_REQUEST_DEATH_NOTIFICATION ?
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3648  					"BC_REQUEST_DEATH_NOTIFICATION" :
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3649  					"BC_CLEAR_DEATH_NOTIFICATION",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3650  					target);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3651  				binder_proc_unlock(proc);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3652  				kfree(death);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3653  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3654  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3655  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3656  			binder_debug(BINDER_DEBUG_DEATH_NOTIFICATION,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3657  				     "%d:%d %s %016llx ref %d desc %d s %d w %d for node %d\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3658  				     proc->pid, thread->pid,
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3659  				     cmd == BC_REQUEST_DEATH_NOTIFICATION ?
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3660  				     "BC_REQUEST_DEATH_NOTIFICATION" :
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3661  				     "BC_CLEAR_DEATH_NOTIFICATION",
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3662  				     (u64)cookie, ref->data.debug_id,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3663  				     ref->data.desc, ref->data.strong,
372e3147df7016e drivers/android/binder.c         Todd Kjos              2017-06-29  3664  				     ref->data.weak, ref->node->debug_id);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3665  
ab51ec6bdf0b7af drivers/android/binder.c         Martijn Coenen         2017-06-29  3666  			binder_node_lock(ref->node);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3667  			if (cmd == BC_REQUEST_DEATH_NOTIFICATION) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3668  				if (ref->death) {
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3669  					binder_user_error("%d:%d BC_REQUEST_DEATH_NOTIFICATION death notification already set\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3670  						proc->pid, thread->pid);
ab51ec6bdf0b7af drivers/android/binder.c         Martijn Coenen         2017-06-29  3671  					binder_node_unlock(ref->node);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3672  					binder_proc_unlock(proc);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3673  					kfree(death);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3674  					break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3675  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3676  				binder_stats_created(BINDER_STAT_DEATH);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3677  				INIT_LIST_HEAD(&death->work.entry);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3678  				death->cookie = cookie;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3679  				ref->death = death;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3680  				if (ref->node->proc == NULL) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3681  					ref->death->work.type = BINDER_WORK_DEAD_BINDER;
bb74562a7f83982 drivers/android/binder.c         Martijn Coenen         2017-08-31  3682  
1b77e9dcc3da935 drivers/android/binder.c         Martijn Coenen         2017-08-31  3683  					binder_inner_proc_lock(proc);
1b77e9dcc3da935 drivers/android/binder.c         Martijn Coenen         2017-08-31  3684  					binder_enqueue_work_ilocked(
bb74562a7f83982 drivers/android/binder.c         Martijn Coenen         2017-08-31  3685  						&ref->death->work, &proc->todo);
bb74562a7f83982 drivers/android/binder.c         Martijn Coenen         2017-08-31  3686  					binder_wakeup_proc_ilocked(proc);
1b77e9dcc3da935 drivers/android/binder.c         Martijn Coenen         2017-08-31  3687  					binder_inner_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3688  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3689  			} else {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3690  				if (ref->death == NULL) {
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3691  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification not active\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3692  						proc->pid, thread->pid);
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3693  					binder_node_unlock(ref->node);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3694  					binder_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3695  					break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3696  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3697  				death = ref->death;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3698  				if (death->cookie != cookie) {
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3699  					binder_user_error("%d:%d BC_CLEAR_DEATH_NOTIFICATION death notification cookie mismatch %016llx != %016llx\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3700  						proc->pid, thread->pid,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3701  						(u64)death->cookie,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3702  						(u64)cookie);
673068eee8560d5 drivers/android/binder.c         Todd Kjos              2017-06-29  3703  					binder_node_unlock(ref->node);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3704  					binder_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3705  					break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3706  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3707  				ref->death = NULL;
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3708  				binder_inner_proc_lock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3709  				if (list_empty(&death->work.entry)) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3710  					death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3711  					if (thread->looper &
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3712  					    (BINDER_LOOPER_STATE_REGISTERED |
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3713  					     BINDER_LOOPER_STATE_ENTERED))
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3714  						binder_enqueue_thread_work_ilocked(
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3715  								thread,
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3716  								&death->work);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3717  					else {
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3718  						binder_enqueue_work_ilocked(
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3719  								&death->work,
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3720  								&proc->todo);
1b77e9dcc3da935 drivers/android/binder.c         Martijn Coenen         2017-08-31  3721  						binder_wakeup_proc_ilocked(
408c68b17aea2f2 drivers/android/binder.c         Martijn Coenen         2017-08-31  3722  								proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3723  					}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3724  				} else {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3725  					BUG_ON(death->work.type != BINDER_WORK_DEAD_BINDER);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3726  					death->work.type = BINDER_WORK_DEAD_BINDER_AND_CLEAR;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3727  				}
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3728  				binder_inner_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3729  			}
ab51ec6bdf0b7af drivers/android/binder.c         Martijn Coenen         2017-06-29  3730  			binder_node_unlock(ref->node);
2c1838dc6817dd2 drivers/android/binder.c         Todd Kjos              2017-06-29  3731  			binder_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3732  		} break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3733  		case BC_DEAD_BINDER_DONE: {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3734  			struct binder_work *w;
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3735  			binder_uintptr_t cookie;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3736  			struct binder_ref_death *death = NULL;
10f62861b4a2f22 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  3737  
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3738  			if (get_user(cookie, (binder_uintptr_t __user *)ptr))
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30 @3739  				return -EFAULT;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3740  
7a64cd887fdb97f drivers/android/binder.c         Lisa Du                2016-02-17  3741  			ptr += sizeof(cookie);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3742  			binder_inner_proc_lock(proc);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3743  			list_for_each_entry(w, &proc->delivered_death,
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3744  					    entry) {
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3745  				struct binder_ref_death *tmp_death =
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3746  					container_of(w,
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3747  						     struct binder_ref_death,
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3748  						     work);
10f62861b4a2f22 drivers/staging/android/binder.c Seunghun Lee           2014-05-01  3749  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3750  				if (tmp_death->cookie == cookie) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3751  					death = tmp_death;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3752  					break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3753  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3754  			}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3755  			binder_debug(BINDER_DEBUG_DEAD_BINDER,
8ca86f1639ec589 drivers/android/binder.c         Todd Kjos              2018-02-07  3756  				     "%d:%d BC_DEAD_BINDER_DONE %016llx found %pK\n",
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3757  				     proc->pid, thread->pid, (u64)cookie,
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3758  				     death);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3759  			if (death == NULL) {
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3760  				binder_user_error("%d:%d BC_DEAD_BINDER_DONE %016llx not found\n",
da49889deb34d35 drivers/staging/android/binder.c Arve Hjønnevåg         2014-02-21  3761  					proc->pid, thread->pid, (u64)cookie);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3762  				binder_inner_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3763  				break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3764  			}
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3765  			binder_dequeue_work_ilocked(&death->work);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3766  			if (death->work.type == BINDER_WORK_DEAD_BINDER_AND_CLEAR) {
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3767  				death->work.type = BINDER_WORK_CLEAR_DEATH_NOTIFICATION;
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3768  				if (thread->looper &
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3769  					(BINDER_LOOPER_STATE_REGISTERED |
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3770  					 BINDER_LOOPER_STATE_ENTERED))
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3771  					binder_enqueue_thread_work_ilocked(
148ade2c4d4f46b drivers/android/binder.c         Martijn Coenen         2017-11-15  3772  						thread, &death->work);
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3773  				else {
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3774  					binder_enqueue_work_ilocked(
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3775  							&death->work,
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3776  							&proc->todo);
408c68b17aea2f2 drivers/android/binder.c         Martijn Coenen         2017-08-31  3777  					binder_wakeup_proc_ilocked(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3778  				}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3779  			}
72196393a5e3d28 drivers/android/binder.c         Todd Kjos              2017-06-29  3780  			binder_inner_proc_unlock(proc);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3781  		} break;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3782  
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3783  		default:
56b468fc709b2b9 drivers/staging/android/binder.c Anmol Sarma            2012-10-30  3784  			pr_err("%d:%d unknown command %d\n",
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3785  			       proc->pid, thread->pid, cmd);
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3786  			return -EINVAL;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3787  		}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3788  		*consumed = ptr - buffer;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3789  	}
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3790  	return 0;
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3791  }
355b0502f6efea0 drivers/staging/android/binder.c Greg Kroah-Hartman     2011-11-30  3792  

:::::: The code at line 3739 was first introduced by commit
:::::: 355b0502f6efea0ff9492753888772c96972d2a3 Revert "Staging: android: delete android drivers"

:::::: TO: Greg Kroah-Hartman <gregkh@suse.de>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--NzB8fVQJ5HfG6fxh--
