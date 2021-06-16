Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35283A90BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbhFPEqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:46:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:28123 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhFPEqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:46:14 -0400
IronPort-SDR: vVZ/Ldlz324WaNfHyPr/JmarSd6IThJR0VfMDUc9XLa1/dSjShcodfvqDQkJ1r3X0oM0T1YCGJ
 r33gWF4uIkcw==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="204283778"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="204283778"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 21:44:08 -0700
IronPort-SDR: I721+5FHoocoeMNpn+a8b+mT/WYb0KZYvB8bH4O4pplav1eakN2cuq44IV85HTtU9z/jiBkvqE
 Z1DKpjdrbNCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="421357663"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Jun 2021 21:44:07 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltNPK-0000rS-RH; Wed, 16 Jun 2021 04:44:06 +0000
Date:   Wed, 16 Jun 2021 12:44:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 4692bc775d2180a937335ccba0edce557103d44a
Message-ID: <60c98192.XkZUQE6jO+Aoycls%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 4692bc775d2180a937335ccba0edce557103d44a  x86/sgx: Add missing xa_destroy() when virtual EPC is destroyed

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-allnoconfig
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:Force-disable-because-it-s-broken-beyond-repair
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:define-DISABLE_ENQCMD
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:define-DISABLE_ENQCMD-(-(X86_FEATURE_ENQCMD-))
    `-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:ifdef-CONFIG_IOMMU_SUPPORT

elapsed time: 725m

configs tested: 132
configs skipped: 65

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath79_defconfig
powerpc                  iss476-smp_defconfig
h8300                            allyesconfig
mips                  cavium_octeon_defconfig
um                           x86_64_defconfig
arm                          pcm027_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
xtensa                generic_kc705_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        oxnas_v6_defconfig
s390                                defconfig
arm                        multi_v7_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
m68k                         apollo_defconfig
mips                          rm200_defconfig
sh                          sdk7786_defconfig
powerpc                      arches_defconfig
alpha                               defconfig
arm                         s3c2410_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
mips                      bmips_stb_defconfig
um                            kunit_defconfig
arm                            zeus_defconfig
m68k                          atari_defconfig
arm                        mvebu_v5_defconfig
ia64                            zx1_defconfig
powerpc                     ksi8560_defconfig
ia64                             alldefconfig
h8300                       h8s-sim_defconfig
x86_64                           allyesconfig
arm                           u8500_defconfig
powerpc                       holly_defconfig
sh                        sh7785lcr_defconfig
mips                     cu1000-neo_defconfig
m68k                       m5275evb_defconfig
arm                        keystone_defconfig
arm                         palmz72_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                        fsp2_defconfig
powerpc                     sbc8548_defconfig
s390                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
m68k                          sun3x_defconfig
i386                                defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                              alldefconfig
arm                         hackkit_defconfig
arm                       imx_v6_v7_defconfig
m68k                             allmodconfig
powerpc                      katmai_defconfig
arm                           viper_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_mds_defconfig
sparc                       sparc64_defconfig
riscv                          rv32_defconfig
powerpc                 mpc85xx_cds_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20210615
x86_64               randconfig-a004-20210615
x86_64               randconfig-a002-20210615
x86_64               randconfig-a003-20210615
x86_64               randconfig-a006-20210615
x86_64               randconfig-a005-20210615
i386                 randconfig-a002-20210615
i386                 randconfig-a006-20210615
i386                 randconfig-a004-20210615
i386                 randconfig-a001-20210615
i386                 randconfig-a005-20210615
i386                 randconfig-a003-20210615
i386                 randconfig-a015-20210615
i386                 randconfig-a013-20210615
i386                 randconfig-a016-20210615
i386                 randconfig-a012-20210615
i386                 randconfig-a014-20210615
i386                 randconfig-a011-20210615
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210615
x86_64               randconfig-a015-20210615
x86_64               randconfig-a011-20210615
x86_64               randconfig-a012-20210615
x86_64               randconfig-a014-20210615
x86_64               randconfig-a016-20210615
x86_64               randconfig-a013-20210615

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
