Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001A345D84D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351996AbhKYKgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 05:36:49 -0500
Received: from mga07.intel.com ([134.134.136.100]:53883 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351418AbhKYKep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 05:34:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="298897433"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="298897433"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 02:31:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="607527187"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 25 Nov 2021 02:31:33 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqC2O-0006DM-80; Thu, 25 Nov 2021 10:31:32 +0000
Date:   Thu, 25 Nov 2021 18:30:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.15 119/139]
 arch/arm64/include/asm/mpam.h:110:6: warning: variable 'regval' set but not
 used
Message-ID: <202111251807.ljdrXC4V-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.15
head:   ce3629841262f725a5f3a327403fcaf0e604a85e
commit: ec95ea0172936108af0216efb0e4f28402eaf1c6 [119/139] arm64: mpam: Add helpers to change a tasks and cpu mpam partid/pmg values
config: arm64-randconfig-r012-20211115 (https://download.01.org/0day-ci/archive/20211125/202111251807.ljdrXC4V-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=ec95ea0172936108af0216efb0e4f28402eaf1c6
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.15
        git checkout ec95ea0172936108af0216efb0e4f28402eaf1c6
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm64/kernel/process.c:51:
>> arch/arm64/include/asm/mpam.h:110:6: warning: variable 'regval' set but not used [-Wunused-but-set-variable]
           u64 regval;
               ^
   arch/arm64/include/asm/mpam.h:133:6: warning: variable 'regval' set but not used [-Wunused-but-set-variable]
           u64 regval = mpam_get_regval(tsk);
               ^
   2 warnings generated.


vim +/regval +110 arch/arm64/include/asm/mpam.h

   105	
   106	static inline void mpam_set_task_partid_pmg(struct task_struct *tsk,
   107						    u16 partid_d, u16 partid_i,
   108						    u8 pmg_d, u8 pmg_i)
   109	{
 > 110		u64 regval;
   111	
   112		regval = FIELD_PREP(MPAM_SYSREG_PARTID_D, partid_d);
   113		regval |= FIELD_PREP(MPAM_SYSREG_PARTID_I, partid_i);
   114		regval |= FIELD_PREP(MPAM_SYSREG_PMG_D, pmg_d);
   115		regval |= FIELD_PREP(MPAM_SYSREG_PMG_I, pmg_i);
   116	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
