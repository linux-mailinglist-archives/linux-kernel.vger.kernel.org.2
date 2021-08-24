Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EA93F69EF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbhHXThV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:37:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:31076 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229907AbhHXThU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:37:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="281104651"
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="281104651"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2021 12:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,348,1620716400"; 
   d="scan'208";a="515581658"
Received: from lkp-server02.sh.intel.com (HELO 181e7be6f509) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2021 12:36:09 -0700
Received: from kbuild by 181e7be6f509 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mIcDQ-0000ni-Ea; Tue, 24 Aug 2021 19:36:08 +0000
Date:   Wed, 25 Aug 2021 03:35:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 00ed1401a0058e8cca4cc1b6ba14b893e5df746e
Message-ID: <61254a03.2w2KUVF0gI/i7Rwo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 00ed1401a0058e8cca4cc1b6ba14b893e5df746e  platform-msi: Add ABI to show msi_irqs of platform devices

elapsed time: 732m

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
i386                 randconfig-c001-20210824
mips                        omega2p_defconfig
arm                       cns3420vb_defconfig
m68k                       bvme6000_defconfig
arm                        magician_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7722_defconfig
powerpc                    mvme5100_defconfig
powerpc                     ep8248e_defconfig
sh                          sdk7786_defconfig
arm                           viper_defconfig
xtensa                  nommu_kc705_defconfig
riscv                    nommu_k210_defconfig
h8300                     edosk2674_defconfig
m68k                       m5208evb_defconfig
arm                         s3c6400_defconfig
arm                           h5000_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
arm                            xcep_defconfig
riscv                          rv32_defconfig
sh                          rsk7201_defconfig
openrisc                  or1klitex_defconfig
powerpc                        fsp2_defconfig
arm                          iop32x_defconfig
arm                            dove_defconfig
h8300                               defconfig
powerpc                     ksi8560_defconfig
arm                          simpad_defconfig
arm                          imote2_defconfig
arm                              alldefconfig
s390                       zfcpdump_defconfig
arm                       aspeed_g4_defconfig
arm                         s5pv210_defconfig
powerpc                      acadia_defconfig
arc                          axs101_defconfig
sh                         microdev_defconfig
mips                          rb532_defconfig
powerpc                 mpc836x_mds_defconfig
arm                         nhk8815_defconfig
powerpc                     pq2fads_defconfig
mips                      malta_kvm_defconfig
powerpc                     pseries_defconfig
arc                              alldefconfig
arm                           tegra_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
powerpc                      mgcoge_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc64                        alldefconfig
sh                        edosk7760_defconfig
powerpc                    klondike_defconfig
arm                          pxa168_defconfig
mips                      maltasmvp_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8272_ads_defconfig
mips                malta_qemu_32r6_defconfig
arm                        cerfcube_defconfig
powerpc                     akebono_defconfig
mips                           ip28_defconfig
sh                             espt_defconfig
mips                        jmr3927_defconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
arm                           stm32_defconfig
mips                 decstation_r4k_defconfig
nds32                               defconfig
s390                             allyesconfig
arm                        realview_defconfig
powerpc                      pmac32_defconfig
arm                          moxart_defconfig
mips                           ip22_defconfig
arm                         cm_x300_defconfig
powerpc                       maple_defconfig
sh                               j2_defconfig
sh                        sh7763rdp_defconfig
i386                                defconfig
arm                          ixp4xx_defconfig
arc                     haps_hs_smp_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
powerpc                     mpc5200_defconfig
nds32                            alldefconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8313_rdb_defconfig
x86_64                              defconfig
m68k                          hp300_defconfig
sh                   sh7770_generic_defconfig
powerpc                     stx_gp3_defconfig
arm                         hackkit_defconfig
sh                           se7206_defconfig
arm                      tct_hammer_defconfig
sh                            titan_defconfig
xtensa                  audio_kc705_defconfig
arm                       imx_v4_v5_defconfig
powerpc                   bluestone_defconfig
sh                         ap325rxa_defconfig
powerpc                     sequoia_defconfig
h8300                    h8300h-sim_defconfig
mips                        nlm_xlp_defconfig
m68k                         apollo_defconfig
sh                           se7721_defconfig
mips                        workpad_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
arm                           h3600_defconfig
powerpc                 canyonlands_defconfig
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
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210824
x86_64               randconfig-a006-20210824
x86_64               randconfig-a001-20210824
x86_64               randconfig-a003-20210824
x86_64               randconfig-a004-20210824
x86_64               randconfig-a002-20210824
i386                 randconfig-a006-20210824
i386                 randconfig-a001-20210824
i386                 randconfig-a002-20210824
i386                 randconfig-a005-20210824
i386                 randconfig-a003-20210824
i386                 randconfig-a004-20210824
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
i386                 randconfig-c001-20210824
s390                 randconfig-c005-20210824
arm                  randconfig-c002-20210824
riscv                randconfig-c006-20210824
x86_64               randconfig-c007-20210824
mips                 randconfig-c004-20210824
x86_64               randconfig-a014-20210824
x86_64               randconfig-a015-20210824
x86_64               randconfig-a016-20210824
x86_64               randconfig-a013-20210824
x86_64               randconfig-a012-20210824
x86_64               randconfig-a011-20210824
i386                 randconfig-a011-20210824
i386                 randconfig-a016-20210824
i386                 randconfig-a012-20210824
i386                 randconfig-a014-20210824
i386                 randconfig-a013-20210824
i386                 randconfig-a015-20210824
hexagon              randconfig-r041-20210824
hexagon              randconfig-r045-20210824
riscv                randconfig-r042-20210824
s390                 randconfig-r044-20210824

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
