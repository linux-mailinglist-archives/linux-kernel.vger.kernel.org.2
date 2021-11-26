Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB7545F399
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 19:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbhKZSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 13:18:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:9857 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237921AbhKZSQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 13:16:02 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235939485"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="235939485"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 10:02:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="675626098"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 26 Nov 2021 10:02:10 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqfY1-0008PL-MD; Fri, 26 Nov 2021 18:02:09 +0000
Date:   Sat, 27 Nov 2021 02:01:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_osnoise.c:131:1: sparse: sparse: symbol
 '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
Message-ID: <202111270153.j3tgBvDJ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: 498627b4ac85780b9962ed9b5c5abbefd884ef8e trace/osnoise: Fix return value on osnoise_init_hotplug_support
date:   5 months ago
config: i386-randconfig-s002-20211118 (https://download.01.org/0day-ci/archive/20211127/202111270153.j3tgBvDJ-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=498627b4ac85780b9962ed9b5c5abbefd884ef8e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 498627b4ac85780b9962ed9b5c5abbefd884ef8e
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace_osnoise.c:108:1: sparse: sparse: symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
>> kernel/trace/trace_osnoise.c:131:1: sparse: sparse: symbol '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:223:14: sparse: sparse: symbol 'interface_lock' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:1766:5: sparse: sparse: symbol 'timerlat_min_period' was not declared. Should it be static?
   kernel/trace/trace_osnoise.c:1767:5: sparse: sparse: symbol 'timerlat_max_period' was not declared. Should it be static?

vim +/__pcpu_scope_per_cpu_timerlat_var +131 kernel/trace/trace_osnoise.c

bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  112   */
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  113  static inline struct osnoise_variables *this_cpu_osn_var(void)
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  114  {
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  115  	return this_cpu_ptr(&per_cpu_osnoise_var);
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  116  }
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  117  
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  118  #ifdef CONFIG_TIMERLAT_TRACER
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  119  /*
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  120   * Runtime information for the timer mode.
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  121   */
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  122  struct timerlat_variables {
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  123  	struct task_struct	*kthread;
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  124  	struct hrtimer		timer;
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  125  	u64			rel_period;
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  126  	u64			abs_period;
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  127  	bool			tracing_thread;
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  128  	u64			count;
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  129  };
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  130  
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22 @131  DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  132  
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  133  /*
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  134   * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  135   */
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  136  static inline struct timerlat_variables *this_cpu_tmr_var(void)
bce29ac9ce0bb0b Daniel Bristot de Oliveira 2021-06-22  137  {
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  138  	return this_cpu_ptr(&per_cpu_timerlat_var);
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  139  }
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  140  
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  141  /*
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  142   * tlat_var_reset - Reset the values of the given timerlat_variables
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  143   */
a955d7eac1779b4 Daniel Bristot de Oliveira 2021-06-22  144  static inline void tlat_var_reset(void)

:::::: The code at line 131 was first introduced by commit
:::::: a955d7eac1779b437ceb24fc352026a2cbcec140 trace: Add timerlat tracer

:::::: TO: Daniel Bristot de Oliveira <bristot@redhat.com>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
