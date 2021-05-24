Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA8838F5D4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhEXWuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:50:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:12372 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhEXWuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:50:01 -0400
IronPort-SDR: SGzNh2YWrmfiXNm32YcoKXMkmGHy9CdBVIseylFjJmr/yEiyHcDHZ0OrfiAptxuHGAgaPTERti
 C5GAPKP2PvPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="265944934"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="265944934"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 15:48:32 -0700
IronPort-SDR: 2YrBruFgwSm3tJ1wpDIaZQgvvD4PJhftekDQo49+vvby6Loyqx4Mxv6Xza4AE7BKjCa4FILs27
 bkWpTAERyNew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="443042034"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 24 May 2021 15:48:30 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llJN8-0001Oi-Az; Mon, 24 May 2021 22:48:30 +0000
Date:   Tue, 25 May 2021 06:48:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 19c0a3af4ad150f313600ab637c9878968935516
Message-ID: <60ac2d39.UKMtQVUHytzA7Trg%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 19c0a3af4ad150f313600ab637c9878968935516  Merge branch 'efi/core'

elapsed time: 724m

configs tested: 223
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      tqm8xx_defconfig
arm                       mainstone_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      mgcoge_defconfig
arm                          imote2_defconfig
arm                          pxa3xx_defconfig
x86_64                              defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
h8300                       h8s-sim_defconfig
mips                     loongson2k_defconfig
m68k                       m5249evb_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          collie_defconfig
powerpc                      pcm030_defconfig
mips                           ip27_defconfig
mips                           mtx1_defconfig
arm                             mxs_defconfig
mips                        bcm47xx_defconfig
arm                         at91_dt_defconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                           spitz_defconfig
powerpc                      makalu_defconfig
arm                       aspeed_g4_defconfig
arm64                            alldefconfig
ia64                          tiger_defconfig
powerpc                     stx_gp3_defconfig
sh                          rsk7264_defconfig
m68k                          amiga_defconfig
arm                          ep93xx_defconfig
sh                        sh7757lcr_defconfig
xtensa                           allyesconfig
m68k                        mvme16x_defconfig
x86_64                           alldefconfig
arm                  colibri_pxa270_defconfig
mips                         cobalt_defconfig
openrisc                  or1klitex_defconfig
xtensa                    xip_kc705_defconfig
powerpc                       holly_defconfig
sh                          lboxre2_defconfig
mips                        omega2p_defconfig
mips                          malta_defconfig
mips                          rb532_defconfig
riscv             nommu_k210_sdcard_defconfig
openrisc                 simple_smp_defconfig
sh                          rsk7201_defconfig
m68k                        m5407c3_defconfig
mips                      pic32mzda_defconfig
powerpc                     mpc83xx_defconfig
ia64                             alldefconfig
sh                           se7724_defconfig
sparc                            allyesconfig
mips                     cu1000-neo_defconfig
sh                         microdev_defconfig
arm                       spear13xx_defconfig
riscv                          rv32_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                     sequoia_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
xtensa                       common_defconfig
sh                               j2_defconfig
powerpc                      katmai_defconfig
arm                        spear3xx_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8555_defconfig
mips                       bmips_be_defconfig
sh                           se7722_defconfig
arm                          badge4_defconfig
s390                                defconfig
mips                         bigsur_defconfig
arm                        mvebu_v7_defconfig
arm                         lpc18xx_defconfig
openrisc                            defconfig
riscv                               defconfig
mips                  cavium_octeon_defconfig
sparc                               defconfig
csky                             alldefconfig
h8300                    h8300h-sim_defconfig
sh                        edosk7705_defconfig
arm                           h3600_defconfig
sh                        sh7785lcr_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                         db1xxx_defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
arm                        vexpress_defconfig
sh                   sh7724_generic_defconfig
powerpc                    adder875_defconfig
riscv                            alldefconfig
um                            kunit_defconfig
powerpc                     powernv_defconfig
powerpc                 linkstation_defconfig
mips                      bmips_stb_defconfig
sh                            titan_defconfig
m68k                         amcore_defconfig
powerpc                   currituck_defconfig
sh                           se7750_defconfig
s390                          debug_defconfig
mips                      malta_kvm_defconfig
powerpc                      cm5200_defconfig
powerpc                 canyonlands_defconfig
m68k                           sun3_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      chrp32_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                            shmin_defconfig
arm                     eseries_pxa_defconfig
xtensa                    smp_lx200_defconfig
powerpc                      acadia_defconfig
sh                           se7619_defconfig
arm                          gemini_defconfig
sh                          sdk7786_defconfig
powerpc                     tqm5200_defconfig
arm                       cns3420vb_defconfig
sparc                            alldefconfig
powerpc                     pseries_defconfig
arm                         palmz72_defconfig
m68k                         apollo_defconfig
powerpc                  mpc885_ads_defconfig
m68k                             alldefconfig
sh                        sh7763rdp_defconfig
sh                   rts7751r2dplus_defconfig
mips                           gcw0_defconfig
sh                          rsk7269_defconfig
m68k                        m5307c3_defconfig
sh                          r7780mp_defconfig
parisc                generic-32bit_defconfig
m68k                            mac_defconfig
arm                            qcom_defconfig
mips                        qi_lb60_defconfig
mips                        workpad_defconfig
arm                           sama5_defconfig
arm                           h5000_defconfig
arc                              alldefconfig
nds32                            alldefconfig
powerpc                        fsp2_defconfig
arm                       netwinder_defconfig
mips                         tb0226_defconfig
powerpc                        cell_defconfig
xtensa                         virt_defconfig
alpha                            alldefconfig
powerpc                        warp_defconfig
arm                        multi_v5_defconfig
arm                          simpad_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
i386                 randconfig-a011-20210524
i386                 randconfig-a016-20210524
i386                 randconfig-a015-20210524
i386                 randconfig-a012-20210524
i386                 randconfig-a014-20210524
i386                 randconfig-a013-20210524
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210524
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
