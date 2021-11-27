Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9545FC95
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 05:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbhK0Evx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 23:51:53 -0500
Received: from mga02.intel.com ([134.134.136.20]:26699 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233665AbhK0Etw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 23:49:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="222969032"
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="222969032"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 20:46:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="593660545"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Nov 2021 20:46:37 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqpbg-00094P-Dy; Sat, 27 Nov 2021 04:46:36 +0000
Date:   Sat, 27 Nov 2021 12:45:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huang Rui <ray.huang@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rui:amd-pstate-dev-v4 7/22] drivers/cpufreq/amd-pstate.c:193:6:
 warning: variable 'des_perf' is used uninitialized whenever 'if' condition
 is false
Message-ID: <202111271256.9GZ2i3ea-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git amd-pstate-dev-v4
head:   17a6d8cd0f5821b7a5ebd40fe1491a0c77a9c306
commit: 2adf4a47fba000e94b1976144af27a51d2ddcd4e [7/22] cpufreq: amd: add fast switch function for amd-pstate
config: x86_64-randconfig-r036-20211126 (https://download.01.org/0day-ci/archive/20211127/202111271256.9GZ2i3ea-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git/commit/?id=2adf4a47fba000e94b1976144af27a51d2ddcd4e
        git remote add rui https://git.kernel.org/pub/scm/linux/kernel/git/rui/linux.git
        git fetch --no-tags rui amd-pstate-dev-v4
        git checkout 2adf4a47fba000e94b1976144af27a51d2ddcd4e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cpufreq/ drivers/gpio/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:193:6: warning: variable 'des_perf' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
           if (target_perf < capacity)
               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:207:36: note: uninitialized use occurs here
           des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
                                             ^~~~~~~~
   include/linux/minmax.h:124:60: note: expanded from macro 'clamp_t'
   #define clamp_t(type, val, lo, hi) min_t(type, max_t(type, val, lo), hi)
                                                              ^~~
   include/linux/minmax.h:112:48: note: expanded from macro 'max_t'
   #define max_t(type, x, y)       __careful_cmp((type)(x), (type)(y), >)
                                                        ^
   include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                              ^
   note: (skipping 1 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/minmax.h:104:48: note: expanded from macro 'min_t'
   #define min_t(type, x, y)       __careful_cmp((type)(x), (type)(y), <)
                                                        ^
   include/linux/minmax.h:38:14: note: expanded from macro '__careful_cmp'
                   __cmp_once(x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y), op))
                              ^
   include/linux/minmax.h:31:25: note: expanded from macro '__cmp_once'
                   typeof(x) unique_x = (x);               \
                                         ^
   drivers/cpufreq/amd-pstate.c:193:2: note: remove the 'if' if its condition is always true
           if (target_perf < capacity)
           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/cpufreq/amd-pstate.c:185:44: note: initialize the variable 'des_perf' to silence this warning
           unsigned long max_perf, min_perf, des_perf,
                                                     ^
                                                      = 0
   1 warning generated.


vim +193 drivers/cpufreq/amd-pstate.c

   179	
   180	static void amd_pstate_adjust_perf(unsigned int cpu,
   181					   unsigned long _min_perf,
   182					   unsigned long target_perf,
   183					   unsigned long capacity)
   184	{
   185		unsigned long max_perf, min_perf, des_perf,
   186			      cap_perf, lowest_nonlinear_perf;
   187		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
   188		struct amd_cpudata *cpudata = policy->driver_data;
   189	
   190		cap_perf = READ_ONCE(cpudata->highest_perf);
   191		lowest_nonlinear_perf = READ_ONCE(cpudata->lowest_nonlinear_perf);
   192	
 > 193		if (target_perf < capacity)
   194			des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);
   195	
   196		min_perf = READ_ONCE(cpudata->highest_perf);
   197		if (_min_perf < capacity)
   198			min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);
   199	
   200		if (min_perf < lowest_nonlinear_perf)
   201			min_perf = lowest_nonlinear_perf;
   202	
   203		max_perf = cap_perf;
   204		if (max_perf < min_perf)
   205			max_perf = min_perf;
   206	
   207		des_perf = clamp_t(unsigned long, des_perf, min_perf, max_perf);
   208	
   209		amd_pstate_update(cpudata, min_perf, des_perf, max_perf, true);
   210	}
   211	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
