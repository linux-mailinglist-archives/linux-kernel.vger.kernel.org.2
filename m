Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB9C438CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 02:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231786AbhJYAT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 20:19:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:53892 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229837AbhJYAT5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 20:19:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10147"; a="226995674"
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="226995674"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2021 17:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,179,1631602800"; 
   d="scan'208";a="485446014"
Received: from lkp-server02.sh.intel.com (HELO 74392981b700) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Oct 2021 17:17:31 -0700
Received: from kbuild by 74392981b700 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mengA-0001Aj-L4; Mon, 25 Oct 2021 00:17:30 +0000
Date:   Mon, 25 Oct 2021 08:16:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sev] BUILD SUCCESS
 ce47d0c00ff5621ae5825c9d81722b23b0df395e
Message-ID: <6175f770.CIpdlbnMDCYtaUKj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/sev
branch HEAD: ce47d0c00ff5621ae5825c9d81722b23b0df395e  x86/sev: Allow #VC exceptions on the VC2 stack

elapsed time: 4746m

configs tested: 126
configs skipped: 93

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             pxa_defconfig
powerpc                   bluestone_defconfig
powerpc                     ep8248e_defconfig
arm                      footbridge_defconfig
sh                     magicpanelr2_defconfig
powerpc                      tqm8xx_defconfig
sh                         ap325rxa_defconfig
powerpc                          allyesconfig
arm                            mps2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                              allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20211024
x86_64               randconfig-a004-20211024
x86_64               randconfig-a005-20211024
x86_64               randconfig-a006-20211024
x86_64               randconfig-a003-20211024
x86_64               randconfig-a001-20211024
i386                 randconfig-a004-20211022
i386                 randconfig-a003-20211022
i386                 randconfig-a002-20211022
i386                 randconfig-a005-20211022
i386                 randconfig-a006-20211022
i386                 randconfig-a001-20211022
i386                 randconfig-a003-20211024
i386                 randconfig-a004-20211024
i386                 randconfig-a002-20211024
i386                 randconfig-a005-20211024
i386                 randconfig-a006-20211024
i386                 randconfig-a001-20211024
x86_64               randconfig-a013-20211021
x86_64               randconfig-a015-20211021
x86_64               randconfig-a011-20211021
x86_64               randconfig-a014-20211021
x86_64               randconfig-a016-20211021
x86_64               randconfig-a012-20211021
i386                 randconfig-a012-20211021
i386                 randconfig-a013-20211021
i386                 randconfig-a011-20211021
i386                 randconfig-a016-20211021
i386                 randconfig-a015-20211021
i386                 randconfig-a014-20211021
x86_64               randconfig-a002-20211022
x86_64               randconfig-a004-20211022
x86_64               randconfig-a005-20211022
x86_64               randconfig-a001-20211022
x86_64               randconfig-a006-20211022
x86_64               randconfig-a003-20211022
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a002-20211021
x86_64               randconfig-a004-20211021
x86_64               randconfig-a005-20211021
x86_64               randconfig-a001-20211021
x86_64               randconfig-a006-20211021
x86_64               randconfig-a003-20211021
i386                 randconfig-a004-20211021
i386                 randconfig-a003-20211021
i386                 randconfig-a002-20211021
i386                 randconfig-a005-20211021
i386                 randconfig-a001-20211021
i386                 randconfig-a006-20211021
x86_64               randconfig-a013-20211022
x86_64               randconfig-a015-20211022
x86_64               randconfig-a011-20211022
x86_64               randconfig-a014-20211022
x86_64               randconfig-a016-20211022
x86_64               randconfig-a012-20211022
i386                 randconfig-a012-20211022
i386                 randconfig-a013-20211022
i386                 randconfig-a011-20211022
i386                 randconfig-a016-20211022
i386                 randconfig-a015-20211022
i386                 randconfig-a014-20211022
hexagon              randconfig-r045-20211021
hexagon              randconfig-r041-20211021
riscv                randconfig-r042-20211022
s390                 randconfig-r044-20211022
hexagon              randconfig-r045-20211022
hexagon              randconfig-r041-20211022

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
