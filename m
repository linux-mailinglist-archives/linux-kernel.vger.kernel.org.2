Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986CD45CC6E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbhKXSuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:50:44 -0500
Received: from mga09.intel.com ([134.134.136.24]:48060 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244688AbhKXSuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:50:25 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235166351"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="235166351"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 10:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="497782988"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2021 10:46:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpxII-0005DN-PJ; Wed, 24 Nov 2021 18:46:58 +0000
Date:   Thu, 25 Nov 2021 02:46:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof-next:20211123-sysctl-cleanups 41/41]
 kernel/kprobes.c:2605:9: error: implicit declaration of function
 'kprobe_sysctls_init'
Message-ID: <202111250249.S7EcX00x-lkp@intel.com>
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
config: arc-randconfig-r025-20211123 (https://download.01.org/0day-ci/archive/20211125/202111250249.S7EcX00x-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=c18add41d859b4feec081eab6cfd624a5642973d
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211123-sysctl-cleanups
        git checkout c18add41d859b4feec081eab6cfd624a5642973d
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/kprobes.c: In function 'init_kprobes':
>> kernel/kprobes.c:2605:9: error: implicit declaration of function 'kprobe_sysctls_init' [-Werror=implicit-function-declaration]
    2605 |         kprobe_sysctls_init();
         |         ^~~~~~~~~~~~~~~~~~~
   In file included from include/linux/perf_event.h:25,
                    from kernel/kprobes.c:41:
   At top level:
   arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                           ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/kprobe_sysctls_init +2605 kernel/kprobes.c

  2597	
  2598		err = arch_init_kprobes();
  2599		if (!err)
  2600			err = register_die_notifier(&kprobe_exceptions_nb);
  2601		if (!err)
  2602			err = register_module_notifier(&kprobe_module_nb);
  2603	
  2604		kprobes_initialized = (err == 0);
> 2605		kprobe_sysctls_init();
  2606		return err;
  2607	}
  2608	early_initcall(init_kprobes);
  2609	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
