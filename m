Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25553FCF6F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 00:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhHaWHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 18:07:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:36477 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230085AbhHaWHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 18:07:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10093"; a="304152212"
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="304152212"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2021 15:06:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,367,1620716400"; 
   d="scan'208";a="541229468"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 31 Aug 2021 15:06:24 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLBtf-00077W-Ab; Tue, 31 Aug 2021 22:06:23 +0000
Date:   Wed, 01 Sep 2021 06:05:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/urgent] BUILD SUCCESS
 453624fa68444c9b93addb4325c9db59b6a43e21
Message-ID: <612ea7c4.BXeSd8fuYSiY97H/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/urgent
branch HEAD: 453624fa68444c9b93addb4325c9db59b6a43e21  locking/rwsem: Add missing __init_rwsem() for PREEMPT_RT

elapsed time: 729m

configs tested: 184
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210831
powerpc              randconfig-c003-20210831
arc                 nsimosci_hs_smp_defconfig
m68k                          atari_defconfig
arm                         s3c2410_defconfig
sh                          rsk7201_defconfig
m68k                          hp300_defconfig
sh                          kfr2r09_defconfig
arm                       versatile_defconfig
xtensa                  nommu_kc705_defconfig
parisc                           alldefconfig
arm                           u8500_defconfig
arm                          lpd270_defconfig
arm                        oxnas_v6_defconfig
arm                        spear3xx_defconfig
arm                     eseries_pxa_defconfig
powerpc                     pq2fads_defconfig
m68k                        m5407c3_defconfig
mips                    maltaup_xpa_defconfig
xtensa                       common_defconfig
h8300                               defconfig
mips                        workpad_defconfig
i386                             alldefconfig
powerpc                    mvme5100_defconfig
sh                            titan_defconfig
powerpc                     redwood_defconfig
sparc                            alldefconfig
arc                           tb10x_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                     nsimosci_hs_defconfig
arm                        trizeps4_defconfig
arm                            xcep_defconfig
powerpc                      katmai_defconfig
arm                         s5pv210_defconfig
mips                           mtx1_defconfig
sh                          r7785rp_defconfig
arm                      jornada720_defconfig
arc                                 defconfig
arm                         lpc32xx_defconfig
powerpc                       eiger_defconfig
mips                        nlm_xlp_defconfig
sh                           se7750_defconfig
mips                            gpr_defconfig
um                                  defconfig
s390                       zfcpdump_defconfig
powerpc                 xes_mpc85xx_defconfig
riscv                          rv32_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     tqm8560_defconfig
arm                           viper_defconfig
powerpc                    ge_imp3a_defconfig
um                           x86_64_defconfig
mips                       bmips_be_defconfig
sparc                       sparc32_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7757lcr_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            zeus_defconfig
sh                          rsk7264_defconfig
mips                        qi_lb60_defconfig
m68k                        m5307c3_defconfig
mips                     loongson1c_defconfig
sparc64                          alldefconfig
arm                         palmz72_defconfig
mips                          ath79_defconfig
arc                        nsimosci_defconfig
powerpc                     mpc512x_defconfig
i386                             allyesconfig
arm                         hackkit_defconfig
sh                                  defconfig
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
arm                             mxs_defconfig
arm                             rpc_defconfig
sh                           se7751_defconfig
m68k                          amiga_defconfig
sh                          sdk7786_defconfig
arm                        neponset_defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
sh                               j2_defconfig
sh                            shmin_defconfig
arm                            qcom_defconfig
sh                          urquell_defconfig
arc                      axs103_smp_defconfig
sh                           se7724_defconfig
m68k                             alldefconfig
mips                           ip27_defconfig
sh                          r7780mp_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            hp6xx_defconfig
powerpc                  mpc866_ads_defconfig
arm                        shmobile_defconfig
mips                 decstation_r4k_defconfig
s390                                defconfig
x86_64                            allnoconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
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
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
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
