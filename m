Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459813FD063
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 02:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241459AbhIAAph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 20:45:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:36835 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241020AbhIAApg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 20:45:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="205819852"
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="205819852"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 17:44:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,368,1620716400"; 
   d="scan'208";a="601417794"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Aug 2021 17:44:38 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLEMo-0007G8-0Q; Wed, 01 Sep 2021 00:44:38 +0000
Date:   Wed, 01 Sep 2021 08:44:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 4034fb207e302cc0b1f304084d379640c1fb1436
Message-ID: <612ecce4.XHypnTPNcFutDhlx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
branch HEAD: 4034fb207e302cc0b1f304084d379640c1fb1436  perf/x86/intel/uncore: Fix Intel SPR M3UPI event constraints

elapsed time: 731m

configs tested: 148
configs skipped: 75

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
arm                         s3c2410_defconfig
sh                          rsk7201_defconfig
parisc                           alldefconfig
arm                           u8500_defconfig
arm                          lpd270_defconfig
arm                        oxnas_v6_defconfig
arm                        spear3xx_defconfig
powerpc                     redwood_defconfig
sparc                            alldefconfig
arc                           tb10x_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                     nsimosci_hs_defconfig
arm                        trizeps4_defconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
powerpc                      katmai_defconfig
arm                      jornada720_defconfig
sh                           se7750_defconfig
powerpc                   lite5200b_defconfig
arm                            mmp2_defconfig
csky                             alldefconfig
arc                                 defconfig
arm                         lpc32xx_defconfig
powerpc                       eiger_defconfig
mips                        nlm_xlp_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
s390                       zfcpdump_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
mips                        qi_lb60_defconfig
mips                            gpr_defconfig
powerpc                     mpc512x_defconfig
arm                         hackkit_defconfig
sh                                  defconfig
xtensa                       common_defconfig
xtensa                  nommu_kc705_defconfig
sh                          lboxre2_defconfig
sh                           se7722_defconfig
arc                         haps_hs_defconfig
sh                             espt_defconfig
sh                        edosk7705_defconfig
arm                          imote2_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                        spear6xx_defconfig
mips                         mpc30x_defconfig
xtensa                           alldefconfig
arm                       spear13xx_defconfig
ia64                             allmodconfig
arm                             mxs_defconfig
arm                             rpc_defconfig
riscv                             allnoconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
sh                               j2_defconfig
arm                       versatile_defconfig
sh                            shmin_defconfig
powerpc                  mpc866_ads_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
s390                                defconfig
x86_64                            allnoconfig
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
x86_64               randconfig-a005-20210831
x86_64               randconfig-a001-20210831
x86_64               randconfig-a003-20210831
x86_64               randconfig-a002-20210831
x86_64               randconfig-a004-20210831
x86_64               randconfig-a006-20210831
i386                 randconfig-a005-20210831
i386                 randconfig-a002-20210831
i386                 randconfig-a003-20210831
i386                 randconfig-a006-20210831
i386                 randconfig-a004-20210831
i386                 randconfig-a001-20210831
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210831
s390                 randconfig-c005-20210831
riscv                randconfig-c006-20210831
powerpc              randconfig-c003-20210831
mips                 randconfig-c004-20210831
arm                  randconfig-c002-20210831
x86_64               randconfig-c007-20210831
x86_64               randconfig-a014-20210831
x86_64               randconfig-a015-20210831
x86_64               randconfig-a013-20210831
x86_64               randconfig-a016-20210831
x86_64               randconfig-a012-20210831
x86_64               randconfig-a011-20210831
i386                 randconfig-a016-20210831
i386                 randconfig-a011-20210831
i386                 randconfig-a015-20210831
i386                 randconfig-a014-20210831
i386                 randconfig-a012-20210831
i386                 randconfig-a013-20210831
s390                 randconfig-r044-20210831
hexagon              randconfig-r041-20210831
hexagon              randconfig-r045-20210831
riscv                randconfig-r042-20210831

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
