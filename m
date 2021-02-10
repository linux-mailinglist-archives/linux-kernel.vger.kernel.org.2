Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF8315C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 02:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbhBJBxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 20:53:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:49280 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234702AbhBJAFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 19:05:30 -0500
IronPort-SDR: /STA15N8vxrmZ6qhsc/bDxcv4Qa6ueijEOg15z0tSWcAZSLEK73stlxo9kz7tWHL8qsm+7thBS
 H93HNywtPF6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="179425255"
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="179425255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2021 16:02:29 -0800
IronPort-SDR: 3PdYA0dFjk1IKT2tTLmJUKBei5ZWpHlbxKGqqeMEmnM4JxOpS602U6wsQ/6WG/eNQScidAB8VW
 /ygR+YSIlEAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,166,1610438400"; 
   d="scan'208";a="361991218"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Feb 2021 16:02:25 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9cxc-0002RA-KE; Wed, 10 Feb 2021 00:02:24 +0000
Date:   Wed, 10 Feb 2021 08:01:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 3228e1dc80983ee1f5d2e533d010b3bd8b50f0e2
Message-ID: <6023225e.OHRZdrqMQGFVTYwE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 3228e1dc80983ee1f5d2e533d010b3bd8b50f0e2  x86/Kconfig: Remove HPET_EMULATE_RTC depends on RTC

elapsed time: 721m

configs tested: 181
configs skipped: 62

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
x86_64                           alldefconfig
mips                          rb532_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
c6x                        evmc6472_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
xtensa                         virt_defconfig
microblaze                          defconfig
powerpc                     ksi8560_defconfig
powerpc                     pseries_defconfig
arm                       spear13xx_defconfig
powerpc                     kmeter1_defconfig
mips                       lemote2f_defconfig
mips                      pic32mzda_defconfig
mips                        maltaup_defconfig
mips                       rbtx49xx_defconfig
ia64                      gensparse_defconfig
sh                          lboxre2_defconfig
openrisc                  or1klitex_defconfig
powerpc                 linkstation_defconfig
arm                            xcep_defconfig
powerpc                mpc7448_hpc2_defconfig
ia64                             alldefconfig
mips                     cu1830-neo_defconfig
arm                        mini2440_defconfig
arm                          ep93xx_defconfig
arm                           sunxi_defconfig
powerpc                      makalu_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
arm                         s5pv210_defconfig
powerpc                    amigaone_defconfig
powerpc                          allmodconfig
mips                  decstation_64_defconfig
powerpc                        cell_defconfig
m68k                          multi_defconfig
arc                          axs103_defconfig
arc                              allyesconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
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
arc                        vdk_hs38_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
mips                      maltaaprp_defconfig
powerpc                     rainier_defconfig
arc                    vdk_hs38_smp_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
powerpc                     kilauea_defconfig
sh                           se7780_defconfig
arc                            hsdk_defconfig
arm                           omap1_defconfig
m68k                       m5475evb_defconfig
arm                           stm32_defconfig
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
