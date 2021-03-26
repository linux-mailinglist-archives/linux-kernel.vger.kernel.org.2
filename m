Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE1234A19B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCZGRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:17:04 -0400
Received: from mga09.intel.com ([134.134.136.24]:17004 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhCZGQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:16:42 -0400
IronPort-SDR: l0CZjDebPmeBrTGfCAcPP6U8Bt8oSsydL5m4gfF+VzR6wr/4ZC5xE5Hvz1M5Em6T+nTfL/0oil
 dbSGBTGWPv2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="191182856"
X-IronPort-AV: E=Sophos;i="5.81,279,1610438400"; 
   d="scan'208";a="191182856"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 23:16:41 -0700
IronPort-SDR: mUPPSH22Sa7uULqygShvE9b6JEEpO3eK7Tea6mOBGXVdv4ZJU7y64nz1R2zVAFSCmW7wZhrAkc
 ybyonZkqLgmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,279,1610438400"; 
   d="scan'208";a="525926088"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2021 23:16:40 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPflv-0002Y8-GZ; Fri, 26 Mar 2021 06:16:39 +0000
Date:   Fri, 26 Mar 2021 14:16:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 6e457914935a3161eeb74e319abf9fd511aa1e4d
Message-ID: <605d7c28.RfC+1mCOSGQvKcW9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 6e457914935a3161eeb74e319abf9fd511aa1e4d  drm/i915: Use tasklet_unlock_spin_wait() in __tasklet_disable_sync_once()

elapsed time: 725m

configs tested: 154
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
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
sparc64                             defconfig
arm                         assabet_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
powerpc                     mpc5200_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
csky                                defconfig
sh                     sh7710voipgw_defconfig
m68k                        stmark2_defconfig
arm                       aspeed_g5_defconfig
arm                            pleb_defconfig
arm                            mmp2_defconfig
s390                             alldefconfig
xtensa                  cadence_csp_defconfig
um                                allnoconfig
powerpc64                           defconfig
mips                      bmips_stb_defconfig
mips                        maltaup_defconfig
arm                        mvebu_v7_defconfig
powerpc                         ps3_defconfig
parisc                generic-64bit_defconfig
mips                        qi_lb60_defconfig
sh                   sh7770_generic_defconfig
mips                        vocore2_defconfig
m68k                       m5475evb_defconfig
parisc                           alldefconfig
arm                        shmobile_defconfig
powerpc                       ppc64_defconfig
arm                           spitz_defconfig
arm                        keystone_defconfig
arm                          lpd270_defconfig
mips                      maltaaprp_defconfig
arm                        spear3xx_defconfig
arm                       imx_v6_v7_defconfig
mips                     loongson1c_defconfig
powerpc                     sequoia_defconfig
powerpc                      katmai_defconfig
arm                        multi_v7_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
mips                          malta_defconfig
csky                             alldefconfig
nds32                            alldefconfig
riscv                    nommu_k210_defconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
mips                        omega2p_defconfig
sh                     magicpanelr2_defconfig
sh                           se7712_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v5_defconfig
mips                         cobalt_defconfig
powerpc                        icon_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
m68k                            mac_defconfig
m68k                         amcore_defconfig
arm                         mv78xx0_defconfig
openrisc                 simple_smp_defconfig
arm                         orion5x_defconfig
powerpc                     tqm8548_defconfig
powerpc                      pasemi_defconfig
arm64                            alldefconfig
arm                       multi_v4t_defconfig
arm                          ixp4xx_defconfig
arc                        nsimosci_defconfig
sh                          polaris_defconfig
mips                       lemote2f_defconfig
powerpc                     tqm8541_defconfig
m68k                            q40_defconfig
xtensa                    smp_lx200_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc837x_mds_defconfig
um                            kunit_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
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
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325
x86_64               randconfig-a014-20210325
x86_64               randconfig-a013-20210325
x86_64               randconfig-a011-20210325
x86_64               randconfig-a016-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
