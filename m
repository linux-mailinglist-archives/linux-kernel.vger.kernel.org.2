Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B7345B620
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240970AbhKXIFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:05:51 -0500
Received: from mga12.intel.com ([192.55.52.136]:1620 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240965AbhKXIFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:05:49 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="215254439"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="215254439"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 00:02:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="674778578"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 00:02:38 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpnEj-0004VS-PU; Wed, 24 Nov 2021 08:02:37 +0000
Date:   Wed, 24 Nov 2021 16:01:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof-next:20211123-sysctl-cleanups 41/41] kernel/kprobes.c:52:1:
 error: function declaration isn't a prototype
Message-ID: <202111241540.e3ukBGer-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211123-sysctl-cleanups
head:   c18add41d859b4feec081eab6cfd624a5642973d
commit: c18add41d859b4feec081eab6cfd624a5642973d [41/41] kprobe: move sysctl_kprobes_optimization to kprobes.c
config: sparc-randconfig-r002-20211123 (https://download.01.org/0day-ci/archive/20211124/202111241540.e3ukBGer-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=c18add41d859b4feec081eab6cfd624a5642973d
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211123-sysctl-cleanups
        git checkout c18add41d859b4feec081eab6cfd624a5642973d
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/key.h:17,
                    from include/linux/cred.h:13,
                    from include/linux/sched/signal.h:10,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/huge_mm.h:8,
                    from include/linux/mm.h:717,
                    from include/linux/kallsyms.h:13,
                    from include/linux/ftrace.h:12,
                    from include/linux/kprobes.h:28,
                    from kernel/kprobes.c:23:
   include/linux/sysctl.h: In function 'register_sysctl_mount_point':
   include/linux/sysctl.h:270:1: error: expected ';' before '}' token
     270 | }
         | ^
   kernel/kprobes.c: At top level:
   kernel/kprobes.c:52:1: error: return type defaults to 'int' [-Werror=return-type]
      52 | kprobe_sysctls_init() do { } while (0)
         | ^~~~~~~~~~~~~~~~~~~
>> kernel/kprobes.c:52:1: error: function declaration isn't a prototype [-Werror=strict-prototypes]
   kernel/kprobes.c: In function 'kprobe_sysctls_init':
>> kernel/kprobes.c:52:23: error: expected declaration specifiers before 'do'
      52 | kprobe_sysctls_init() do { } while (0)
         |                       ^~
>> kernel/kprobes.c:52:30: error: expected declaration specifiers before 'while'
      52 | kprobe_sysctls_init() do { } while (0)
         |                              ^~~~~
>> kernel/kprobes.c:61:26: error: storage class specified for parameter 'kprobe_table'
      61 | static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
         |                          ^~~~~~~~~~~~
>> kernel/kprobes.c:64:13: error: storage class specified for parameter 'kprobes_all_disarmed'
      64 | static bool kprobes_all_disarmed;
         |             ^~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/notifier.h:14,
                    from include/linux/kprobes.h:21,
                    from kernel/kprobes.c:23:
>> kernel/kprobes.c:67:21: error: storage class specified for parameter 'kprobe_mutex'
      67 | static DEFINE_MUTEX(kprobe_mutex);
         |                     ^~~~~~~~~~~~
   include/linux/mutex.h:116:22: note: in definition of macro 'DEFINE_MUTEX'
     116 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                      ^~~~~~~~~
>> include/linux/mutex.h:116:16: error: parameter 'kprobe_mutex' is initialized
     116 |         struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
         |                ^~~~~
   kernel/kprobes.c:67:8: note: in expansion of macro 'DEFINE_MUTEX'
      67 | static DEFINE_MUTEX(kprobe_mutex);
         |        ^~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7,
                    from arch/sparc/include/asm/percpu_64.h:25,
                    from arch/sparc/include/asm/percpu.h:5,
                    from include/linux/irqflags.h:17,
                    from include/asm-generic/cmpxchg-local.h:6,
                    from arch/sparc/include/asm/cmpxchg_64.h:111,
                    from arch/sparc/include/asm/cmpxchg.h:5,
                    from arch/sparc/include/asm/atomic_64.h:12,
                    from arch/sparc/include/asm/atomic.h:5,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/lock.h:5,
                    from arch/sparc/include/asm/bitops_64.h:52,
                    from arch/sparc/include/asm/bitops.h:5,
                    from include/linux/bitops.h:33,
                    from include/linux/thread_info.h:27,
                    from arch/sparc/include/asm/current.h:15,
                    from include/linux/mutex.h:14,
                    from include/linux/notifier.h:14,
                    from include/linux/kprobes.h:21,
                    from kernel/kprobes.c:23:
>> kernel/kprobes.c:68:40: error: storage class specified for parameter 'kprobe_instance'
      68 | static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
         |                                        ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:104:44: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     104 |         __PCPU_ATTRS(sec) __typeof__(type) name
         |                                            ^~~~
   kernel/kprobes.c:68:8: note: in expansion of macro 'DEFINE_PER_CPU'
      68 | static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
         |        ^~~~~~~~~~~~~~
>> kernel/kprobes.c:68:40: error: section attribute not allowed for 'kprobe_instance'
      68 | static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
         |                                        ^~~~~~~~~~~~~~~
   include/linux/percpu-defs.h:104:44: note: in definition of macro 'DEFINE_PER_CPU_SECTION'
     104 |         __PCPU_ATTRS(sec) __typeof__(type) name
         |                                            ^~~~
   kernel/kprobes.c:68:8: note: in expansion of macro 'DEFINE_PER_CPU'
      68 | static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
         |        ^~~~~~~~~~~~~~
>> kernel/kprobes.c:72:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
      72 | {
         | ^
   In file included from include/linux/kprobes.h:20,
                    from kernel/kprobes.c:23:
>> kernel/kprobes.c:80:18: error: storage class specified for parameter 'kprobe_blacklist'
      80 | static LIST_HEAD(kprobe_blacklist);
         |                  ^~~~~~~~~~~~~~~~
   include/linux/list.h:26:26: note: in definition of macro 'LIST_HEAD'
      26 |         struct list_head name = LIST_HEAD_INIT(name)
         |                          ^~~~
>> include/linux/list.h:26:16: error: parameter 'kprobe_blacklist' is initialized
      26 |         struct list_head name = LIST_HEAD_INIT(name)
         |                ^~~~~~~~~
   kernel/kprobes.c:80:8: note: in expansion of macro 'LIST_HEAD'
      80 | static LIST_HEAD(kprobe_blacklist);
         |        ^~~~~~~~~
   kernel/kprobes.c:361:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     361 | {
         | ^
   kernel/kprobes.c:366:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     366 | {
         | ^
   kernel/kprobes.c:377:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     377 | {
         | ^
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
>> include/asm-generic/kprobes.h:14:9: error: storage class specified for parameter '_kbl_addr_get_kprobe'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:390:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
     390 | NOKPROBE_SYMBOL(get_kprobe);
         | ^~~~~~~~~~~~~~~
>> kernel/kprobes.c:390:1: error: parameter '_kbl_addr_get_kprobe' is initialized
>> kernel/kprobes.c:390:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
>> include/asm-generic/kprobes.h:14:9: error: section attribute not allowed for '_kbl_addr_get_kprobe'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:390:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
     390 | NOKPROBE_SYMBOL(get_kprobe);
         | ^~~~~~~~~~~~~~~
>> kernel/kprobes.c:390:28: error: expected declaration specifiers before ';' token
     390 | NOKPROBE_SYMBOL(get_kprobe);
         |                            ^
>> kernel/kprobes.c:392:12: error: storage class specified for parameter 'aggr_pre_handler'
     392 | static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs);
         |            ^~~~~~~~~~~~~~~~
   kernel/kprobes.c:396:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     396 | {
         | ^
   kernel/kprobes.c:402:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     402 | {
         | ^
   kernel/kprobes.c:409:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
     409 | {
         | ^
   kernel/kprobes.c:1038:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1038 | {
         | ^
   kernel/kprobes.c:1050:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1050 | {
         | ^
   kernel/kprobes.c:1056:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1056 | {
         | ^
   kernel/kprobes.c:1144:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1144 | {
         | ^
   kernel/kprobes.c:1149:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1149 | {
         | ^
   kernel/kprobes.c:1155:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1155 | {
         | ^
   kernel/kprobes.c:1164:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1164 | {
         | ^
   kernel/kprobes.c:1178:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1178 | {
         | ^
   kernel/kprobes.c:1196:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1196 | {
         | ^
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
>> include/asm-generic/kprobes.h:14:9: error: storage class specified for parameter '_kbl_addr_aggr_pre_handler'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:1209:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1209 | NOKPROBE_SYMBOL(aggr_pre_handler);
         | ^~~~~~~~~~~~~~~
>> kernel/kprobes.c:1209:1: error: parameter '_kbl_addr_aggr_pre_handler' is initialized
   kernel/kprobes.c:1209:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
   include/asm-generic/kprobes.h:14:9: error: section attribute not allowed for '_kbl_addr_aggr_pre_handler'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:1209:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1209 | NOKPROBE_SYMBOL(aggr_pre_handler);
         | ^~~~~~~~~~~~~~~
   kernel/kprobes.c:1209:34: error: expected declaration specifiers before ';' token
    1209 | NOKPROBE_SYMBOL(aggr_pre_handler);
         |                                  ^
   kernel/kprobes.c:1213:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1213 | {
         | ^
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
   include/asm-generic/kprobes.h:14:9: error: storage class specified for parameter '_kbl_addr_aggr_post_handler'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:1224:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1224 | NOKPROBE_SYMBOL(aggr_post_handler);
         | ^~~~~~~~~~~~~~~
   kernel/kprobes.c:1224:1: error: parameter '_kbl_addr_aggr_post_handler' is initialized
   kernel/kprobes.c:1224:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
   include/asm-generic/kprobes.h:14:9: error: section attribute not allowed for '_kbl_addr_aggr_post_handler'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:1224:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1224 | NOKPROBE_SYMBOL(aggr_post_handler);
         | ^~~~~~~~~~~~~~~
   kernel/kprobes.c:1224:17: error: 'aggr_post_handler' undeclared (first use in this function); did you mean 'aggr_pre_handler'?
    1224 | NOKPROBE_SYMBOL(aggr_post_handler);
         |                 ^~~~~~~~~~~~~~~~~
   include/asm-generic/kprobes.h:14:44: note: in definition of macro '__NOKPROBE_SYMBOL'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |                                            ^~~~~
   kernel/kprobes.c:1224:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1224 | NOKPROBE_SYMBOL(aggr_post_handler);
         | ^~~~~~~~~~~~~~~
   kernel/kprobes.c:1224:17: note: each undeclared identifier is reported only once for each function it appears in
    1224 | NOKPROBE_SYMBOL(aggr_post_handler);
         |                 ^~~~~~~~~~~~~~~~~
   include/asm-generic/kprobes.h:14:44: note: in definition of macro '__NOKPROBE_SYMBOL'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |                                            ^~~~~
   kernel/kprobes.c:1224:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1224 | NOKPROBE_SYMBOL(aggr_post_handler);
         | ^~~~~~~~~~~~~~~
   kernel/kprobes.c:1224:35: error: expected declaration specifiers before ';' token
    1224 | NOKPROBE_SYMBOL(aggr_post_handler);
         |                                   ^
   kernel/kprobes.c:1228:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1228 | {
         | ^
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
   include/asm-generic/kprobes.h:14:9: error: storage class specified for parameter '_kbl_addr_kprobes_inc_nmissed_count'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:1238:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1238 | NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
         | ^~~~~~~~~~~~~~~
   kernel/kprobes.c:1238:1: error: parameter '_kbl_addr_kprobes_inc_nmissed_count' is initialized
   kernel/kprobes.c:1238:1: warning: 'used' attribute ignored [-Wattributes]
   In file included from arch/sparc/include/asm/kprobes.h:5,
                    from include/linux/kprobes.h:31,
                    from kernel/kprobes.c:23:
   include/asm-generic/kprobes.h:14:9: error: section attribute not allowed for '_kbl_addr_kprobes_inc_nmissed_count'
      14 |         _kbl_addr_##fname = (unsigned long)fname;
         |         ^~~~~~~~~~
   include/asm-generic/kprobes.h:15:33: note: in expansion of macro '__NOKPROBE_SYMBOL'
      15 | # define NOKPROBE_SYMBOL(fname) __NOKPROBE_SYMBOL(fname)
         |                                 ^~~~~~~~~~~~~~~~~
   kernel/kprobes.c:1238:1: note: in expansion of macro 'NOKPROBE_SYMBOL'
    1238 | NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
         | ^~~~~~~~~~~~~~~
   kernel/kprobes.c:1238:43: error: expected declaration specifiers before ';' token
    1238 | NOKPROBE_SYMBOL(kprobes_inc_nmissed_count);
         |                                           ^
   kernel/kprobes.c:1241:1: error: expected '=', ',', ';', 'asm' or '__attribute__' before '{' token
    1241 | {


vim +52 kernel/kprobes.c

    50	
    51	#ifndef CONFIG_SYSCTL
  > 52	kprobe_sysctls_init() do { } while (0)
    53	#endif
    54	
    55	static int kprobes_initialized;
    56	/* kprobe_table can be accessed by
    57	 * - Normal hlist traversal and RCU add/del under 'kprobe_mutex' is held.
    58	 * Or
    59	 * - RCU hlist traversal under disabling preempt (breakpoint handlers)
    60	 */
  > 61	static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
    62	
    63	/* NOTE: change this value only with 'kprobe_mutex' held */
  > 64	static bool kprobes_all_disarmed;
    65	
    66	/* This protects 'kprobe_table' and 'optimizing_list' */
  > 67	static DEFINE_MUTEX(kprobe_mutex);
  > 68	static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
    69	
    70	kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
    71						unsigned int __unused)
  > 72	{
    73		return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
    74	}
    75	
    76	/*
    77	 * Blacklist -- list of 'struct kprobe_blacklist_entry' to store info where
    78	 * kprobes can not probe.
    79	 */
  > 80	static LIST_HEAD(kprobe_blacklist);
    81	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
