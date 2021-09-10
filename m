Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA51C406721
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 08:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhIJGRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 02:17:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:31026 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230417AbhIJGRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 02:17:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10102"; a="282021832"
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="282021832"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2021 23:16:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,282,1624345200"; 
   d="scan'208";a="466951230"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Sep 2021 23:16:31 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mOZpv-0003vt-4S; Fri, 10 Sep 2021 06:16:31 +0000
Date:   Fri, 10 Sep 2021 14:15:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 5448a9e9f16a1b95790df7ef58686331aa3935a6
Message-ID: <613af80a.9oU2Y+CuuhnNIG4e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 5448a9e9f16a1b95790df7ef58686331aa3935a6  Merge branch 'x86/urgent'

elapsed time: 1132m

configs tested: 187
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210908
powerpc                 xes_mpc85xx_defconfig
parisc                generic-64bit_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
mips                     cu1830-neo_defconfig
sh                          kfr2r09_defconfig
sh                        apsh4ad0a_defconfig
arm                       aspeed_g4_defconfig
sh                   sh7724_generic_defconfig
arm                            hisi_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
mips                        omega2p_defconfig
powerpc                     asp8347_defconfig
arm                         lpc32xx_defconfig
powerpc                       eiger_defconfig
h8300                            alldefconfig
um                           x86_64_defconfig
powerpc                 mpc834x_itx_defconfig
sh                        sh7763rdp_defconfig
xtensa                    smp_lx200_defconfig
arm                          collie_defconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
powerpc                  storcenter_defconfig
arm                          ep93xx_defconfig
sparc                       sparc32_defconfig
arm                         axm55xx_defconfig
mips                     loongson2k_defconfig
mips                      fuloong2e_defconfig
ia64                            zx1_defconfig
openrisc                 simple_smp_defconfig
arm                         lpc18xx_defconfig
sh                             sh03_defconfig
sh                            titan_defconfig
sh                            shmin_defconfig
arm                      integrator_defconfig
mips                      maltaaprp_defconfig
mips                      pic32mzda_defconfig
powerpc                    mvme5100_defconfig
powerpc                       ppc64_defconfig
xtensa                           alldefconfig
sh                           se7206_defconfig
um                             i386_defconfig
arm                        oxnas_v6_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
mips                          ath79_defconfig
arc                          axs101_defconfig
parisc                generic-32bit_defconfig
arm                       versatile_defconfig
sh                               j2_defconfig
sh                             espt_defconfig
ia64                        generic_defconfig
arm                         vf610m4_defconfig
mips                           ip32_defconfig
powerpc                    sam440ep_defconfig
mips                        workpad_defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
arm                  colibri_pxa300_defconfig
m68k                        m5307c3_defconfig
powerpc                      obs600_defconfig
powerpc                     sequoia_defconfig
powerpc                     redwood_defconfig
sh                          r7785rp_defconfig
x86_64                           alldefconfig
mips                         tb0219_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         palmz72_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                          multi_defconfig
powerpc                  iss476-smp_defconfig
arm                      tct_hammer_defconfig
sh                           se7712_defconfig
arm                         assabet_defconfig
arm                          ixp4xx_defconfig
ia64                             allyesconfig
powerpc                      pmac32_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                      ppc6xx_defconfig
mips                       rbtx49xx_defconfig
mips                        vocore2_defconfig
powerpc                      makalu_defconfig
m68k                        m5407c3_defconfig
microblaze                      mmu_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7724_defconfig
csky                             alldefconfig
sh                            hp6xx_defconfig
xtensa                    xip_kc705_defconfig
sh                        edosk7760_defconfig
mips                        qi_lb60_defconfig
m68k                       bvme6000_defconfig
powerpc                     ppa8548_defconfig
x86_64               randconfig-c001-20210908
x86_64               randconfig-c001-20210910
i386                 randconfig-c001-20210910
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a004-20210908
x86_64               randconfig-a006-20210908
x86_64               randconfig-a003-20210908
x86_64               randconfig-a001-20210908
x86_64               randconfig-a005-20210908
x86_64               randconfig-a002-20210908
i386                 randconfig-a005-20210908
i386                 randconfig-a004-20210908
i386                 randconfig-a006-20210908
i386                 randconfig-a002-20210908
i386                 randconfig-a001-20210908
i386                 randconfig-a003-20210908
i386                 randconfig-a016-20210910
i386                 randconfig-a011-20210910
i386                 randconfig-a012-20210910
i386                 randconfig-a013-20210910
i386                 randconfig-a014-20210910
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
s390                 randconfig-c005-20210908
powerpc              randconfig-c003-20210908
mips                 randconfig-c004-20210908
i386                 randconfig-c001-20210908
x86_64               randconfig-a002-20210910
x86_64               randconfig-a003-20210910
x86_64               randconfig-a004-20210910
x86_64               randconfig-a006-20210910
x86_64               randconfig-a001-20210910
x86_64               randconfig-a016-20210908
x86_64               randconfig-a011-20210908
x86_64               randconfig-a012-20210908
x86_64               randconfig-a015-20210908
x86_64               randconfig-a014-20210908
x86_64               randconfig-a013-20210908
i386                 randconfig-a012-20210908
i386                 randconfig-a015-20210908
i386                 randconfig-a011-20210908
i386                 randconfig-a013-20210908
i386                 randconfig-a014-20210908
i386                 randconfig-a016-20210908
s390                 randconfig-r044-20210908

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
