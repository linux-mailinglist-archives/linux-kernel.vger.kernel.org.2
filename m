Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7445233E710
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 03:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhCQCkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 22:40:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:28306 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhCQCkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 22:40:20 -0400
IronPort-SDR: vBaMwz4nSgmb57WVcHfiRvY5tngT2D6tr3gVSqRdArXkrbYiSIQjJl1x+LDH3o+NnTA+4jSxiD
 eLjb4War/bKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="187000916"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="187000916"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:40:19 -0700
IronPort-SDR: EJMnQ6Oj9ZVintytYkesgxt4RpYsMfoSHJaSW65PLUUBc2BzeO/9f/Prttk0PtZBSPgOrxVgnW
 er+sbm3dA1bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="388672107"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Mar 2021 19:40:18 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMM6b-0000Sf-HB; Wed, 17 Mar 2021 02:40:17 +0000
Date:   Wed, 17 Mar 2021 10:39:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 5c982c58752118b6c1f295024d3fda5ff22d3c52
Message-ID: <60516bd4.lNe+j83tfjfa/G4F%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 5c982c58752118b6c1f295024d3fda5ff22d3c52  genirq: Fix typos and misspellings in comments

elapsed time: 722m

configs tested: 163
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
arm                         hackkit_defconfig
arc                              allyesconfig
arm                          gemini_defconfig
sh                               j2_defconfig
arm                         vf610m4_defconfig
powerpc                      pmac32_defconfig
powerpc                       maple_defconfig
arc                                 defconfig
sh                           se7724_defconfig
arm                           omap1_defconfig
sh                   sh7770_generic_defconfig
arm                        multi_v7_defconfig
powerpc                     akebono_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
arm                           u8500_defconfig
xtensa                    xip_kc705_defconfig
mips                     cu1000-neo_defconfig
um                             i386_defconfig
arm                     am200epdkit_defconfig
sh                           se7721_defconfig
sh                           se7705_defconfig
nios2                         10m50_defconfig
sh                         apsh4a3a_defconfig
powerpc                    klondike_defconfig
powerpc                       ppc64_defconfig
arm                        cerfcube_defconfig
nios2                         3c120_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
csky                             alldefconfig
powerpc                  storcenter_defconfig
mips                           ip27_defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
mips                    maltaup_xpa_defconfig
arm                       spear13xx_defconfig
mips                     loongson1c_defconfig
powerpc                     tqm8555_defconfig
powerpc                      ppc40x_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
xtensa                generic_kc705_defconfig
sh                        edosk7760_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
arm                         assabet_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
powerpc                    sam440ep_defconfig
powerpc                      walnut_defconfig
arm                        vexpress_defconfig
mips                       bmips_be_defconfig
arm                          imote2_defconfig
mips                         tb0287_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
powerpc                    amigaone_defconfig
powerpc                      pasemi_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
mips                          rb532_defconfig
arm                       aspeed_g4_defconfig
i386                             alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                         bigsur_defconfig
powerpc                     ep8248e_defconfig
powerpc                      cm5200_defconfig
sparc64                             defconfig
arm                            mps2_defconfig
mips                        workpad_defconfig
powerpc                     tqm8541_defconfig
arm                           h3600_defconfig
arm64                            alldefconfig
powerpc                      makalu_defconfig
s390                       zfcpdump_defconfig
arc                      axs103_smp_defconfig
powerpc                          g5_defconfig
mips                 decstation_r4k_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
