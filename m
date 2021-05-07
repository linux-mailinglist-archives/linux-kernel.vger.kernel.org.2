Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A56375DD6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 02:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhEGASf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 20:18:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:5088 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233434AbhEGAS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 20:18:29 -0400
IronPort-SDR: w36HUhuNdqgB+g90VIX57qTzs0+/BIWNQtTNhLJdH5U5PaKgi2KNQnsm2Fcr7284+9NPdrg6mT
 lyfM6JIZv/5g==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="198664257"
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="198664257"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2021 17:17:29 -0700
IronPort-SDR: ZffrWFgAxorwApVwU33UEufS15gv1agqlbgSIOrdFQGh+uOjOJkPkBP+sVHtcUK7c2awvGNSPq
 IbLNrGK9tAuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,279,1613462400"; 
   d="scan'208";a="540145443"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 May 2021 17:17:26 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1leoBK-000Aw1-7i; Fri, 07 May 2021 00:17:26 +0000
Date:   Fri, 07 May 2021 08:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 bc908e091b3264672889162733020048901021fb
Message-ID: <60948706.jSkAlAKDZsKMJsKi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: bc908e091b3264672889162733020048901021fb  KVM: x86: Consolidate guest enter/exit logic to common helpers

elapsed time: 723m

configs tested: 189
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                       mainstone_defconfig
powerpc                     pq2fads_defconfig
sparc                       sparc64_defconfig
arm                        keystone_defconfig
um                               alldefconfig
s390                                defconfig
ia64                             allmodconfig
mips                          rb532_defconfig
arm                             ezx_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                      maltasmvp_defconfig
arm                         cm_x300_defconfig
arm                         hackkit_defconfig
arm                     eseries_pxa_defconfig
sparc                               defconfig
powerpc                        fsp2_defconfig
arm                            zeus_defconfig
openrisc                  or1klitex_defconfig
arm                        spear6xx_defconfig
powerpc                     ep8248e_defconfig
arm                         orion5x_defconfig
arm                        multi_v7_defconfig
h8300                            allyesconfig
xtensa                    xip_kc705_defconfig
arm                        realview_defconfig
arm                        neponset_defconfig
powerpc                    ge_imp3a_defconfig
sh                          rsk7203_defconfig
sh                          polaris_defconfig
arm                        shmobile_defconfig
mips                        nlm_xlr_defconfig
arm                          lpd270_defconfig
mips                         bigsur_defconfig
arm                           sama5_defconfig
m68k                       m5249evb_defconfig
arm                      integrator_defconfig
s390                          debug_defconfig
mips                      malta_kvm_defconfig
h8300                    h8300h-sim_defconfig
powerpc                        cell_defconfig
powerpc                     tqm8560_defconfig
openrisc                         alldefconfig
powerpc                     powernv_defconfig
sh                          r7780mp_defconfig
ia64                          tiger_defconfig
mips                        omega2p_defconfig
sh                     sh7710voipgw_defconfig
m68k                          multi_defconfig
sh                          lboxre2_defconfig
mips                           gcw0_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                      mgcoge_defconfig
mips                           mtx1_defconfig
m68k                            mac_defconfig
s390                       zfcpdump_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     sbc8548_defconfig
sh                           se7343_defconfig
sh                      rts7751r2d1_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                           jazz_defconfig
m68k                             allyesconfig
powerpc                     redwood_defconfig
arm                       cns3420vb_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
sparc                       sparc32_defconfig
powerpc                       ebony_defconfig
mips                     decstation_defconfig
arm                           u8500_defconfig
arm                           tegra_defconfig
arm                        trizeps4_defconfig
powerpc                          allyesconfig
arc                         haps_hs_defconfig
sh                           se7712_defconfig
m68k                         amcore_defconfig
sh                              ul2_defconfig
mips                         cobalt_defconfig
powerpc                     tqm8541_defconfig
powerpc                     taishan_defconfig
powerpc                     ksi8560_defconfig
x86_64                              defconfig
mips                       bmips_be_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
arc                        nsimosci_defconfig
powerpc                     asp8347_defconfig
mips                        jmr3927_defconfig
mips                      loongson3_defconfig
mips                     cu1830-neo_defconfig
arc                            hsdk_defconfig
m68k                       m5275evb_defconfig
arm                       multi_v4t_defconfig
um                               allmodconfig
powerpc                     akebono_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v7_defconfig
arm                          simpad_defconfig
arm                      jornada720_defconfig
mips                         tb0219_defconfig
mips                malta_qemu_32r6_defconfig
mips                        bcm47xx_defconfig
mips                       lemote2f_defconfig
sh                   rts7751r2dplus_defconfig
sh                           se7751_defconfig
mips                        nlm_xlp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                    sam440ep_defconfig
sh                 kfr2r09-romimage_defconfig
mips                           ip22_defconfig
arm                              alldefconfig
sh                           sh2007_defconfig
arm                       spear13xx_defconfig
xtensa                generic_kc705_defconfig
powerpc                   currituck_defconfig
powerpc                     stx_gp3_defconfig
um                            kunit_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210506
i386                 randconfig-a006-20210506
i386                 randconfig-a001-20210506
i386                 randconfig-a005-20210506
i386                 randconfig-a004-20210506
i386                 randconfig-a002-20210506
x86_64               randconfig-a014-20210506
x86_64               randconfig-a015-20210506
x86_64               randconfig-a012-20210506
x86_64               randconfig-a013-20210506
x86_64               randconfig-a011-20210506
x86_64               randconfig-a016-20210506
i386                 randconfig-a015-20210506
i386                 randconfig-a013-20210506
i386                 randconfig-a016-20210506
i386                 randconfig-a014-20210506
i386                 randconfig-a012-20210506
i386                 randconfig-a011-20210506
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210506
x86_64               randconfig-a003-20210506
x86_64               randconfig-a005-20210506
x86_64               randconfig-a002-20210506
x86_64               randconfig-a006-20210506
x86_64               randconfig-a004-20210506

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
