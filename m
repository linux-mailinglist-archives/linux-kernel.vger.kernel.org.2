Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F041639BF29
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFDR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 13:59:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:13009 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229791AbhFDR7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 13:59:17 -0400
IronPort-SDR: +U5ak7K3DdtkSO9y2KlU+nPHBm7QDeKmsRbeQYzpVg0LNQCq+K2p3ZSKteaeZSPSogLBDpux3K
 P6SZSMxPXbZA==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="184710741"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="184710741"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 10:57:28 -0700
IronPort-SDR: XU47CUriQYZV0esEBvDLL8HQu3Efr9oytM+bbRPgNp4+97MNh/KfCGC3a0sXaw54x2VnbkOCm5
 tp5TIRXA8tPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="446773312"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 04 Jun 2021 10:57:25 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lpE4S-00072z-QK; Fri, 04 Jun 2021 17:57:24 +0000
Date:   Sat, 05 Jun 2021 01:56:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/kspp] BUILD SUCCESS
 0850bf2e5ce411f7c1e2879d72d80253cd8db261
Message-ID: <60ba694d.hNaHwVgqv1w6E8n0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp
branch HEAD: 0850bf2e5ce411f7c1e2879d72d80253cd8db261  drm/nouveau/clk: Fix fall-through warnings for Clang

elapsed time: 721m

configs tested: 204
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
mips                         tb0219_defconfig
arm                          moxart_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
sh                   rts7751r2dplus_defconfig
mips                         rt305x_defconfig
mips                           mtx1_defconfig
arm                          ep93xx_defconfig
powerpc                     kilauea_defconfig
sh                           se7780_defconfig
sh                         ap325rxa_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                         ps3_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
mips                        maltaup_defconfig
m68k                            q40_defconfig
powerpc                          g5_defconfig
alpha                            allyesconfig
powerpc                     tqm8540_defconfig
xtensa                           allyesconfig
powerpc                       maple_defconfig
powerpc                   lite5200b_defconfig
arm                      pxa255-idp_defconfig
powerpc                        cell_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    sam440ep_defconfig
sh                            titan_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                      ep88xc_defconfig
sh                               alldefconfig
powerpc64                           defconfig
powerpc                 mpc8313_rdb_defconfig
openrisc                            defconfig
mips                  decstation_64_defconfig
riscv                    nommu_virt_defconfig
powerpc                        warp_defconfig
arm                           tegra_defconfig
um                               alldefconfig
sh                           sh2007_defconfig
powerpc                      pcm030_defconfig
arm                           u8500_defconfig
um                                  defconfig
m68k                          hp300_defconfig
m68k                          amiga_defconfig
powerpc                    gamecube_defconfig
ia64                             allyesconfig
sh                        sh7785lcr_defconfig
powerpc                     tqm8541_defconfig
m68k                       m5208evb_defconfig
arm                           stm32_defconfig
arm                         cm_x300_defconfig
powerpc                    adder875_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
microblaze                          defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                      ppc40x_defconfig
h8300                    h8300h-sim_defconfig
powerpc                 canyonlands_defconfig
arm                          pxa168_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
arm                         orion5x_defconfig
xtensa                    xip_kc705_defconfig
nios2                         10m50_defconfig
mips                         db1xxx_defconfig
openrisc                 simple_smp_defconfig
arm                              alldefconfig
arm                         nhk8815_defconfig
mips                      pic32mzda_defconfig
arm                            mmp2_defconfig
sh                            hp6xx_defconfig
sh                      rts7751r2d1_defconfig
sh                             sh03_defconfig
ia64                             alldefconfig
arc                     nsimosci_hs_defconfig
mips                      maltaaprp_defconfig
arm                       omap2plus_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                     sequoia_defconfig
sparc64                          alldefconfig
m68k                        mvme147_defconfig
arm                       spear13xx_defconfig
powerpc                 mpc834x_itx_defconfig
ia64                          tiger_defconfig
arm                         lubbock_defconfig
powerpc                     mpc512x_defconfig
mips                       lemote2f_defconfig
powerpc                           allnoconfig
mips                           ip28_defconfig
sh                          sdk7786_defconfig
arm                       cns3420vb_defconfig
arm                        trizeps4_defconfig
sh                          lboxre2_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc837x_mds_defconfig
mips                      loongson3_defconfig
powerpc                     sbc8548_defconfig
powerpc                     mpc83xx_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        jmr3927_defconfig
sh                   sh7770_generic_defconfig
mips                         mpc30x_defconfig
arm                           corgi_defconfig
arm                           omap1_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
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
h8300                            allyesconfig
arc                                 defconfig
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
x86_64               randconfig-a002-20210604
x86_64               randconfig-a004-20210604
x86_64               randconfig-a003-20210604
x86_64               randconfig-a006-20210604
x86_64               randconfig-a005-20210604
x86_64               randconfig-a001-20210604
i386                 randconfig-a003-20210604
i386                 randconfig-a006-20210604
i386                 randconfig-a004-20210604
i386                 randconfig-a001-20210604
i386                 randconfig-a005-20210604
i386                 randconfig-a002-20210604
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
i386                 randconfig-a015-20210604
i386                 randconfig-a013-20210604
i386                 randconfig-a016-20210604
i386                 randconfig-a011-20210604
i386                 randconfig-a014-20210604
i386                 randconfig-a012-20210604
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210604
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603
x86_64               randconfig-a015-20210604
x86_64               randconfig-a011-20210604
x86_64               randconfig-a014-20210604
x86_64               randconfig-a012-20210604
x86_64               randconfig-a016-20210604
x86_64               randconfig-a013-20210604

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
