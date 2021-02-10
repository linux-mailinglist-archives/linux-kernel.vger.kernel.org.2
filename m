Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CA6315C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbhBJBrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:47:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:43645 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234692AbhBJACH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:02:07 -0500
IronPort-SDR: Hp0Sw/AIoaWdCLxbUhGebKb4beTjzNGbbHsonm79sY3NGUE4Qr6bUsyhmb8dKEPB1mwvUu5ZQB
 oRoL8E13ubKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="243477496"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="243477496"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:01:27 -0800
IronPort-SDR: ecqOWoXMUQ1QYAGkoyYMerSxMFmjNHdp3ANY6/HbMXGeVBmXtUOwq9bg+upMfst/GLZ3xn186N
 97kkVciOAxxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="398978939"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 09 Feb 2021 16:01:24 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9cwe-0002QY-0o; Wed, 10 Feb 2021 00:01:24 +0000
Date:   Wed, 10 Feb 2021 08:01:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/sgx] BUILD SUCCESS
 848477782bfa2b6aec738045246abd6cd104006c
Message-ID: <6023224d.5ciNkIP/HNV7b/DC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/sgx
branch HEAD: 848477782bfa2b6aec738045246abd6cd104006c  MAINTAINERS: Add Dave Hansen as reviewer for INTEL SGX

elapsed time: 720m

configs tested: 197
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                     davinci_all_defconfig
s390                          debug_defconfig
arm                         hackkit_defconfig
powerpc                    socrates_defconfig
sh                           se7721_defconfig
powerpc                      ep88xc_defconfig
arm                              zx_defconfig
x86_64                           alldefconfig
mips                          rb532_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
c6x                        evmc6472_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
powerpc                   motionpro_defconfig
mips                     cu1000-neo_defconfig
csky                             alldefconfig
xtensa                         virt_defconfig
microblaze                          defconfig
powerpc                     ksi8560_defconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
sh                          rsk7264_defconfig
powerpc                          g5_defconfig
powerpc                       eiger_defconfig
arm                        spear3xx_defconfig
powerpc                         ps3_defconfig
sh                        apsh4ad0a_defconfig
sh                        sh7785lcr_defconfig
mips                        vocore2_defconfig
mips                      pic32mzda_defconfig
mips                        maltaup_defconfig
mips                       rbtx49xx_defconfig
ia64                      gensparse_defconfig
sh                          lboxre2_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         at91_dt_defconfig
arm                       cns3420vb_defconfig
powerpc                        warp_defconfig
openrisc                 simple_smp_defconfig
mips                     cu1830-neo_defconfig
arm                        mini2440_defconfig
arm                          ep93xx_defconfig
arm                           sunxi_defconfig
powerpc                      makalu_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
arm                         s5pv210_defconfig
sh                      rts7751r2d1_defconfig
arm                           stm32_defconfig
mips                       bmips_be_defconfig
um                            kunit_defconfig
powerpc                     ppa8548_defconfig
powerpc                    amigaone_defconfig
powerpc                          allmodconfig
mips                  decstation_64_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arc                          axs103_defconfig
arc                              allyesconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
powerpc                     ep8248e_defconfig
sh                          sdk7786_defconfig
arm                         palmz72_defconfig
m68k                            mac_defconfig
arm                        neponset_defconfig
arm                           sama5_defconfig
sh                        sh7763rdp_defconfig
mips                        bcm47xx_defconfig
openrisc                    or1ksim_defconfig
m68k                            q40_defconfig
um                             i386_defconfig
alpha                               defconfig
arm                          pxa3xx_defconfig
xtensa                    smp_lx200_defconfig
mips                        jmr3927_defconfig
powerpc                       ppc64_defconfig
riscv                    nommu_k210_defconfig
mips                          rm200_defconfig
arm                       aspeed_g5_defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                  audio_kc705_defconfig
arm                            zeus_defconfig
powerpc                     pq2fads_defconfig
mips                            e55_defconfig
powerpc                 mpc837x_rdb_defconfig
m68k                       m5475evb_defconfig
sh                         microdev_defconfig
arm                          badge4_defconfig
arc                        vdk_hs38_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
mips                      maltaaprp_defconfig
powerpc                     rainier_defconfig
arc                    vdk_hs38_smp_defconfig
sh                           se7343_defconfig
powerpc                     kilauea_defconfig
sh                           se7780_defconfig
arc                            hsdk_defconfig
arm                           omap1_defconfig
sh                          rsk7201_defconfig
nds32                               defconfig
m68k                             allyesconfig
powerpc                 mpc8540_ads_defconfig
sh                        dreamcast_defconfig
mips                 decstation_r4k_defconfig
arm                       imx_v4_v5_defconfig
arm                     am200epdkit_defconfig
microblaze                      mmu_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                         orion5x_defconfig
m68k                        stmark2_defconfig
h8300                     edosk2674_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                      ppc40x_defconfig
arm                         socfpga_defconfig
um                           x86_64_defconfig
arm                            lart_defconfig
arm                        keystone_defconfig
riscv                            allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
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
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
