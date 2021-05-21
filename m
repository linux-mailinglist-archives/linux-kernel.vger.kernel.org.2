Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C390D38BAC2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 02:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbhEUAUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 20:20:54 -0400
Received: from mga06.intel.com ([134.134.136.31]:53515 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234612AbhEUAUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 20:20:53 -0400
IronPort-SDR: QqV+58HlbPc6BNDKDAjO3NTLrWSV1Zn3cVWVOMn3I7QrsLSS9tdCo6ktVRQPDQmErNTsPPuHl3
 pM9n/AjtnVoQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262590889"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="262590889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 17:19:30 -0700
IronPort-SDR: C905/yuGUlD1R0k+mBjEsSzRmVTbyHcoGp4pjW3IoJgxO19ompNzRbTKdpFxdDbdaM2jLYQDoE
 J3irdkqdTasQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="543826126"
Received: from lkp-server02.sh.intel.com (HELO 1b329be5b008) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 20 May 2021 17:19:29 -0700
Received: from kbuild by 1b329be5b008 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ljssy-0000rr-QX; Fri, 21 May 2021 00:19:28 +0000
Date:   Fri, 21 May 2021 08:19:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 76fe8dec9bca0a1144de28d70e6a6c1a0dcd892e
Message-ID: <60a6fc89.ISuNnUcYoLNIga5J%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 76fe8dec9bca0a1144de28d70e6a6c1a0dcd892e  Merge branch 'x86/urgent'

elapsed time: 722m

configs tested: 176
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     mpc5200_defconfig
openrisc                         alldefconfig
powerpc                      walnut_defconfig
mips                      malta_kvm_defconfig
mips                           mtx1_defconfig
sh                         microdev_defconfig
powerpc                  mpc885_ads_defconfig
mips                           gcw0_defconfig
powerpc                 mpc834x_itx_defconfig
arm                           sunxi_defconfig
mips                         tb0219_defconfig
powerpc                       ebony_defconfig
mips                      pistachio_defconfig
microblaze                      mmu_defconfig
mips                      maltasmvp_defconfig
openrisc                    or1ksim_defconfig
mips                malta_qemu_32r6_defconfig
mips                           ci20_defconfig
arc                        nsimosci_defconfig
arm                         shannon_defconfig
sh                      rts7751r2d1_defconfig
powerpc                      pasemi_defconfig
powerpc                     powernv_defconfig
mips                        qi_lb60_defconfig
arm                          badge4_defconfig
openrisc                  or1klitex_defconfig
arc                     haps_hs_smp_defconfig
arm                        mvebu_v5_defconfig
arm                     am200epdkit_defconfig
mips                          rb532_defconfig
sh                           se7343_defconfig
sh                         ap325rxa_defconfig
arm                         socfpga_defconfig
powerpc                 mpc8272_ads_defconfig
arm                           sama5_defconfig
m68k                       bvme6000_defconfig
xtensa                    xip_kc705_defconfig
mips                           jazz_defconfig
h8300                            alldefconfig
mips                   sb1250_swarm_defconfig
mips                         tb0287_defconfig
arm                         hackkit_defconfig
powerpc                     ep8248e_defconfig
arm                    vt8500_v6_v7_defconfig
arm                       aspeed_g4_defconfig
m68k                         amcore_defconfig
arc                          axs103_defconfig
powerpc                     tqm8541_defconfig
powerpc                      pcm030_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                    mvme5100_defconfig
xtensa                         virt_defconfig
m68k                       m5275evb_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                     pq2fads_defconfig
sparc                       sparc64_defconfig
powerpc                      ppc6xx_defconfig
arm                         s5pv210_defconfig
powerpc                 mpc8315_rdb_defconfig
arc                                 defconfig
sh                            hp6xx_defconfig
sh                           se7721_defconfig
sh                           se7206_defconfig
sh                          r7780mp_defconfig
mips                  cavium_octeon_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8548_defconfig
um                            kunit_defconfig
arm                            zeus_defconfig
arm                       aspeed_g5_defconfig
parisc                generic-64bit_defconfig
arm                           viper_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
xtensa                  audio_kc705_defconfig
arm                       omap2plus_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                         palmz72_defconfig
arm                             ezx_defconfig
arm                  colibri_pxa270_defconfig
ia64                                defconfig
um                             i386_defconfig
x86_64                              defconfig
nios2                         3c120_defconfig
arm                         lubbock_defconfig
arm                          iop32x_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig
arm                        keystone_defconfig
s390                       zfcpdump_defconfig
powerpc                        warp_defconfig
mips                            gpr_defconfig
um                                  defconfig
arc                          axs101_defconfig
sh                          kfr2r09_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                        mvebu_v7_defconfig
powerpc                     stx_gp3_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210520
x86_64               randconfig-a006-20210520
x86_64               randconfig-a005-20210520
x86_64               randconfig-a003-20210520
x86_64               randconfig-a004-20210520
x86_64               randconfig-a002-20210520
i386                 randconfig-a001-20210520
i386                 randconfig-a005-20210520
i386                 randconfig-a002-20210520
i386                 randconfig-a006-20210520
i386                 randconfig-a004-20210520
i386                 randconfig-a003-20210520
i386                 randconfig-a016-20210520
i386                 randconfig-a011-20210520
i386                 randconfig-a015-20210520
i386                 randconfig-a012-20210520
i386                 randconfig-a014-20210520
i386                 randconfig-a013-20210520
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210520
x86_64               randconfig-a013-20210520
x86_64               randconfig-a014-20210520
x86_64               randconfig-a012-20210520
x86_64               randconfig-a016-20210520
x86_64               randconfig-a015-20210520
x86_64               randconfig-a011-20210520

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
