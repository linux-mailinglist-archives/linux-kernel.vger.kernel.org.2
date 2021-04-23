Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69965369B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 22:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243922AbhDWUHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 16:07:31 -0400
Received: from mga06.intel.com ([134.134.136.31]:26481 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229691AbhDWUH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 16:07:27 -0400
IronPort-SDR: fEXJueB/vC00nosE6F1+VpBOXSCqFZcYrrZmSFhQQaIjH52S2sZlYPZ8hoCBBSGSvUk76TH1Yh
 575feTjN0iWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="257432468"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="257432468"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 13:06:49 -0700
IronPort-SDR: wk/5XvhQKdt7g6AucIWoOATP7K0KLYNBcNl/CZISFgOOTwASwNSI97bR6Qe7x/tx0SAGcICht2
 W2A1k7tstrpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="386478202"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Apr 2021 13:06:47 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1la24d-0004p3-54; Fri, 23 Apr 2021 20:06:47 +0000
Date:   Sat, 24 Apr 2021 04:06:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 ed8e50800bf4c2d904db9c75408a67085e6cca3d
Message-ID: <608328b1.vJQyLNUHQraVgqxZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: ed8e50800bf4c2d904db9c75408a67085e6cca3d  signal, perf: Add missing TRAP_PERF case in siginfo_layout()

elapsed time: 723m

configs tested: 144
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8540_ads_defconfig
mips                  maltasmvp_eva_defconfig
arm64                            alldefconfig
um                                allnoconfig
nios2                         3c120_defconfig
m68k                             alldefconfig
powerpc64                           defconfig
mips                            e55_defconfig
mips                         cobalt_defconfig
powerpc                     tqm8541_defconfig
arc                        vdk_hs38_defconfig
powerpc                    mvme5100_defconfig
ia64                            zx1_defconfig
mips                        workpad_defconfig
arm                         socfpga_defconfig
powerpc                     asp8347_defconfig
powerpc                       holly_defconfig
m68k                            mac_defconfig
powerpc                     tqm8540_defconfig
mips                      fuloong2e_defconfig
mips                      pic32mzda_defconfig
sh                   sh7770_generic_defconfig
arm                         s3c2410_defconfig
sh                        sh7757lcr_defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
mips                            ar7_defconfig
m68k                          sun3x_defconfig
powerpc                 canyonlands_defconfig
m68k                        mvme16x_defconfig
mips                  decstation_64_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                malta_kvm_guest_defconfig
arm                       imx_v4_v5_defconfig
sh                          r7780mp_defconfig
mips                     decstation_defconfig
powerpc                           allnoconfig
arm                          moxart_defconfig
powerpc                     tqm8555_defconfig
arm                         vf610m4_defconfig
powerpc                        cell_defconfig
mips                        nlm_xlp_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc832x_mds_defconfig
sparc64                             defconfig
arm                        mini2440_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
openrisc                 simple_smp_defconfig
arm                            lart_defconfig
powerpc                  storcenter_defconfig
powerpc                     taishan_defconfig
sh                          urquell_defconfig
powerpc                 linkstation_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
arm                         s5pv210_defconfig
arm                             ezx_defconfig
mips                           ip22_defconfig
powerpc                     mpc5200_defconfig
arm                         lpc18xx_defconfig
powerpc                     tqm8548_defconfig
m68k                        stmark2_defconfig
powerpc                      pcm030_defconfig
arm                         palmz72_defconfig
mips                        nlm_xlr_defconfig
arc                        nsimosci_defconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210423
x86_64               randconfig-a004-20210423
x86_64               randconfig-a001-20210423
x86_64               randconfig-a005-20210423
x86_64               randconfig-a006-20210423
x86_64               randconfig-a003-20210423
i386                 randconfig-a005-20210423
i386                 randconfig-a002-20210423
i386                 randconfig-a001-20210423
i386                 randconfig-a006-20210423
i386                 randconfig-a004-20210423
i386                 randconfig-a003-20210423
i386                 randconfig-a014-20210423
i386                 randconfig-a012-20210423
i386                 randconfig-a011-20210423
i386                 randconfig-a013-20210423
i386                 randconfig-a015-20210423
i386                 randconfig-a016-20210423
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210423
x86_64               randconfig-a016-20210423
x86_64               randconfig-a011-20210423
x86_64               randconfig-a014-20210423
x86_64               randconfig-a012-20210423
x86_64               randconfig-a013-20210423

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
