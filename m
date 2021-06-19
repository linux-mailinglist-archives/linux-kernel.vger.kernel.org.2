Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A983AD7FE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 08:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhFSFuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 01:50:14 -0400
Received: from mga11.intel.com ([192.55.52.93]:17660 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233574AbhFSFuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 01:50:11 -0400
IronPort-SDR: aQlgQuphUy8ESK9WUNstoTCFOLeKZ3Qa8w5yFt7xVNv0bJnFhNHVpaDvzH+OCNkdFSB6qQ6hpU
 Y4VSbrlzmj8Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="203631470"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="203631470"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 22:48:00 -0700
IronPort-SDR: 4ma+DsNibY9/hx6KxIqWnKwAGvEpRS98ipg8y+UfF8Fd01/z+CX3r9xRXK56acP8HXbD8AtOXL
 9SxLghclAR7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="405166394"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 18 Jun 2021 22:47:58 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luTpm-0003N7-9r; Sat, 19 Jun 2021 05:47:58 +0000
Date:   Sat, 19 Jun 2021 13:47:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 28e5e44aa3f4e0e0370864ed008fb5e2d85f4dc8
Message-ID: <60cd84e2.VuWU/siMW3kMA/j/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 28e5e44aa3f4e0e0370864ed008fb5e2d85f4dc8  x86/mm: Avoid truncating memblocks for SGX memory

elapsed time: 724m

configs tested: 120
configs skipped: 87

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                     asp8347_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          polaris_defconfig
x86_64                            allnoconfig
xtensa                       common_defconfig
arm                          pxa168_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
arm                         orion5x_defconfig
sh                        edosk7705_defconfig
powerpc                    sam440ep_defconfig
powerpc                       ebony_defconfig
mips                           mtx1_defconfig
mips                        jmr3927_defconfig
powerpc                    gamecube_defconfig
mips                   sb1250_swarm_defconfig
arm                         axm55xx_defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
s390                                defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          pxa3xx_defconfig
powerpc                      cm5200_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
sh                   sh7724_generic_defconfig
arm                          exynos_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
s390                          debug_defconfig
powerpc                     tqm5200_defconfig
arm                       netwinder_defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
powerpc                     kmeter1_defconfig
powerpc                       maple_defconfig
powerpc                      ep88xc_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210618
i386                 randconfig-a006-20210618
i386                 randconfig-a004-20210618
i386                 randconfig-a001-20210618
i386                 randconfig-a005-20210618
i386                 randconfig-a003-20210618
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210618
i386                 randconfig-a016-20210618
i386                 randconfig-a013-20210618
i386                 randconfig-a014-20210618
i386                 randconfig-a012-20210618
i386                 randconfig-a011-20210618
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210618
x86_64               randconfig-a002-20210618
x86_64               randconfig-a001-20210618
x86_64               randconfig-a004-20210618
x86_64               randconfig-a003-20210618
x86_64               randconfig-a006-20210618
x86_64               randconfig-a005-20210618

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
