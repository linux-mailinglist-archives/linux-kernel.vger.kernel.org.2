Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D6D45E0EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 20:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240856AbhKYTYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 14:24:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:10249 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243264AbhKYTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 14:22:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="234289058"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="234289058"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 11:18:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="498169256"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Nov 2021 11:18:48 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqKGd-0006pF-Rv; Thu, 25 Nov 2021 19:18:47 +0000
Date:   Fri, 26 Nov 2021 03:17:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [norov:bitmap-tmp 7/8] arch/powerpc/xmon/xmon.c:472:64: error:
 expected ')' before 'return'
Message-ID: <202111260340.kCOW9xsR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-tmp
head:   75ee333c81c999b29a49810611fb160cec32217d
commit: 29f49f10b3fbef5a88db0a7e370984297616f0fa [7/8] lib/cpumask: replace cpumask_weight with cpumask_{empty,gt,le,eq}
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20211126/202111260340.kCOW9xsR-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/29f49f10b3fbef5a88db0a7e370984297616f0fa
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-tmp
        git checkout 29f49f10b3fbef5a88db0a7e370984297616f0fa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/powerpc/xmon/xmon.c: In function 'wait_for_other_cpus':
>> arch/powerpc/xmon/xmon.c:472:64: error: expected ')' before 'return'
     472 |                 if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
         |                    ~                                           ^
         |                                                                )
     473 |                         return true;
         |                         ~~~~~~                                  
>> arch/powerpc/xmon/xmon.c:476:9: error: expected expression before '}' token
     476 |         }
         |         ^


vim +472 arch/powerpc/xmon/xmon.c

   465	
   466	static bool wait_for_other_cpus(int ncpus)
   467	{
   468		unsigned long timeout;
   469	
   470		/* We wait for 2s, which is a metric "little while" */
   471		for (timeout = 20000; timeout != 0; --timeout) {
 > 472			if (cpumask_weight_gt(&cpus_in_xmon, ncpus - 1)
   473				return true;
   474			udelay(100);
   475			barrier();
 > 476		}
   477	
   478		return false;
   479	}
   480	#else /* CONFIG_SMP */
   481	static inline void get_output_lock(void) {}
   482	static inline void release_output_lock(void) {}
   483	#endif
   484	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
