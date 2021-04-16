Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFB0362C26
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 02:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhDQAAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 20:00:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:21566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234856AbhDQAAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 20:00:51 -0400
IronPort-SDR: W5h1vb0IlM1YnRq0mCzuOmJEbI43ywcsvicWb5GmrVLSCSgAlDMCeyLuz3n3ATTciXNepj4/EA
 CJ48gBU4McxA==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="182258483"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="182258483"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 17:00:05 -0700
IronPort-SDR: AnKgUAsWkGI61EGN6AcJqU1RjuNyCcEStVRtlqcXE0+M/DJSaXedsnNs8L6nO4Y/0VuvaQKDCt
 fvEw/dWwKrSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="451606816"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2021 17:00:03 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXYNW-0000al-Gt; Sat, 17 Apr 2021 00:00:02 +0000
Date:   Sat, 17 Apr 2021 07:59:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 df448cdfc01ffc117702a494ef302e7fb76df78a
Message-ID: <607a24fc.4h23GR7CqfOoecFV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: df448cdfc01ffc117702a494ef302e7fb76df78a  MAINTAINERS: Remove me from IDE/ATAPI section

elapsed time: 722m

configs tested: 221
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
powerpc                       ebony_defconfig
powerpc                     ksi8560_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        clps711x_defconfig
arm                         at91_dt_defconfig
arc                      axs103_smp_defconfig
mips                      maltaaprp_defconfig
arm                          imote2_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
powerpc                        icon_defconfig
powerpc                      pcm030_defconfig
mips                       capcella_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        mvme16x_defconfig
mips                          rm200_defconfig
sh                          r7785rp_defconfig
powerpc                 canyonlands_defconfig
sh                        dreamcast_defconfig
powerpc                      chrp32_defconfig
mips                           gcw0_defconfig
mips                         bigsur_defconfig
h8300                    h8300h-sim_defconfig
arm                          lpd270_defconfig
arc                        nsimosci_defconfig
sh                          landisk_defconfig
openrisc                  or1klitex_defconfig
powerpc                          allyesconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
arc                          axs103_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
mips                      pistachio_defconfig
ia64                             allmodconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
sh                     magicpanelr2_defconfig
powerpc                         ps3_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
openrisc                         alldefconfig
arc                            hsdk_defconfig
mips                    maltaup_xpa_defconfig
powerpc                        warp_defconfig
arm                          pxa910_defconfig
powerpc                      arches_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
arm                     davinci_all_defconfig
sh                           se7750_defconfig
arm                       aspeed_g5_defconfig
powerpc                 mpc834x_mds_defconfig
arm                       imx_v4_v5_defconfig
sh                          sdk7780_defconfig
m68k                        mvme147_defconfig
arc                              allyesconfig
sh                           se7751_defconfig
arm                            pleb_defconfig
arm                        mini2440_defconfig
sparc                       sparc32_defconfig
mips                           ip22_defconfig
mips                         tb0287_defconfig
mips                      bmips_stb_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
csky                                defconfig
mips                           ip32_defconfig
sh                             shx3_defconfig
powerpc                     mpc512x_defconfig
powerpc                       holly_defconfig
um                               alldefconfig
arm                            mps2_defconfig
arc                     nsimosci_hs_defconfig
arm                        multi_v7_defconfig
nios2                            alldefconfig
powerpc                     powernv_defconfig
arm                             mxs_defconfig
powerpc                     kmeter1_defconfig
arm                         socfpga_defconfig
sh                ecovec24-romimage_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     sbc8548_defconfig
powerpc                      ppc44x_defconfig
xtensa                    xip_kc705_defconfig
arm                        spear6xx_defconfig
mips                            e55_defconfig
m68k                          multi_defconfig
um                               allyesconfig
m68k                            q40_defconfig
arc                         haps_hs_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                 mpc8315_rdb_defconfig
sparc                       sparc64_defconfig
sh                        sh7757lcr_defconfig
arm                              alldefconfig
m68k                         apollo_defconfig
arm                            lart_defconfig
ia64                             alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
powerpc                     sequoia_defconfig
powerpc                     mpc83xx_defconfig
powerpc                    ge_imp3a_defconfig
sh                             espt_defconfig
powerpc                     taishan_defconfig
arm                          iop32x_defconfig
powerpc                        cell_defconfig
sh                             sh03_defconfig
parisc                generic-64bit_defconfig
mips                      loongson3_defconfig
sh                        sh7785lcr_defconfig
mips                malta_kvm_guest_defconfig
ia64                         bigsur_defconfig
h8300                               defconfig
h8300                            alldefconfig
s390                       zfcpdump_defconfig
sh                           se7724_defconfig
sh                   sh7770_generic_defconfig
xtensa                              defconfig
i386                             alldefconfig
arm                        shmobile_defconfig
mips                      pic32mzda_defconfig
m68k                          atari_defconfig
openrisc                            defconfig
arm                         s3c2410_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
arm                             rpc_defconfig
arm                        neponset_defconfig
powerpc                  mpc866_ads_defconfig
sparc                               defconfig
powerpc                      ppc64e_defconfig
powerpc                     tqm8555_defconfig
riscv                             allnoconfig
sh                            titan_defconfig
xtensa                  audio_kc705_defconfig
ia64                            zx1_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
