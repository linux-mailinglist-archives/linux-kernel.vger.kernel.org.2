Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A30245CB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243398AbhKXR7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:59:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:16925 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242750AbhKXR7P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:59:15 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="234063893"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="234063893"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 09:56:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="497765540"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Nov 2021 09:55:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpwUv-00058w-MO; Wed, 24 Nov 2021 17:55:57 +0000
Date:   Thu, 25 Nov 2021 01:55:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: [mark:arm64/stacktrace/arch-stack-walk 9/11]
 arch/arm64/kernel/time.c:49:2: error: implicit declaration of function
 'arch_stack_walk'
Message-ID: <202111250118.AIirXhgK-lkp@intel.com>
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
config: arm64-randconfig-r031-20211124 (https://download.01.org/0day-ci/archive/20211125/202111250118.AIirXhgK-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 67a1c45def8a75061203461ab0060c75c864df1c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=36fa81ac0d771ba0080197745a39dbe94562c615
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/stacktrace/arch-stack-walk
        git checkout 36fa81ac0d771ba0080197745a39dbe94562c615
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/time.c:49:2: error: implicit declaration of function 'arch_stack_walk' [-Werror,-Wimplicit-function-declaration]
           arch_stack_walk(profile_pc_cb, &prof_pc, current, regs);
           ^
   arch/arm64/kernel/time.c:55:13: warning: no previous prototype for function 'time_init' [-Wmissing-prototypes]
   void __init time_init(void)
               ^
   arch/arm64/kernel/time.c:55:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init time_init(void)
   ^
   static 
   1 warning and 1 error generated.


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
