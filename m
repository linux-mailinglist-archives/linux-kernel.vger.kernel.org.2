Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F18F45B947
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 12:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbhKXLl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 06:41:57 -0500
Received: from mga05.intel.com ([192.55.52.43]:37783 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232946AbhKXLl4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 06:41:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="321495486"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="321495486"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 03:38:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="538598995"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2021 03:38:45 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpqbs-0004ho-9u; Wed, 24 Nov 2021 11:38:44 +0000
Date:   Wed, 24 Nov 2021 19:37:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [mark:arm64/stacktrace/arch-stack-walk 9/11]
 arch/arm64/kernel/time.c:49:9: error: implicit declaration of function
 'arch_stack_walk'
Message-ID: <202111241909.UDKmhCqg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/stacktrace/arch-stack-walk
head:   e982ef8a4c9b8bc2f92b7cdafbae70aa31b679d1
commit: 36fa81ac0d771ba0080197745a39dbe94562c615 [9/11] arm64: Make profile_pc() use arch_stack_walk()
config: arm64-alldefconfig (https://download.01.org/0day-ci/archive/20211124/202111241909.UDKmhCqg-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=36fa81ac0d771ba0080197745a39dbe94562c615
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/stacktrace/arch-stack-walk
        git checkout 36fa81ac0d771ba0080197745a39dbe94562c615
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/time.c: In function 'profile_pc':
>> arch/arm64/kernel/time.c:49:9: error: implicit declaration of function 'arch_stack_walk' [-Werror=implicit-function-declaration]
      49 |         arch_stack_walk(profile_pc_cb, &prof_pc, current, regs);
         |         ^~~~~~~~~~~~~~~
   arch/arm64/kernel/time.c: At top level:
   arch/arm64/kernel/time.c:55:13: warning: no previous prototype for 'time_init' [-Wmissing-prototypes]
      55 | void __init time_init(void)
         |             ^~~~~~~~~
   cc1: some warnings being treated as errors


vim +/arch_stack_walk +49 arch/arm64/kernel/time.c

    44	
    45	unsigned long profile_pc(struct pt_regs *regs)
    46	{
    47		unsigned long prof_pc = 0;
    48	
  > 49		arch_stack_walk(profile_pc_cb, &prof_pc, current, regs);
    50	
    51		return prof_pc;
    52	}
    53	EXPORT_SYMBOL(profile_pc);
    54	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
