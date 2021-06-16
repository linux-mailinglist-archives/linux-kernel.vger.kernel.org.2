Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3AF23A92B0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhFPGfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:35:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:33120 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhFPGfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:35:23 -0400
IronPort-SDR: 3SbCLC0733QN5hxkTTfAEMFqgw1+Y62cfz30oOUGwsybCYRQDhb05fU1kGV0L2xfMWom+eeeT+
 7r19oc7piZ5g==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="267272365"
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="267272365"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 23:33:16 -0700
IronPort-SDR: AjPw0ASPgIJEXBMY4nkmf9lVUWks6kdXQPV0/BeLL2JboxSFJBMsVjlANss5YNewaIySFhMH3A
 cLVycHMtsi4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,277,1616482800"; 
   d="scan'208";a="488039799"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 Jun 2021 23:33:15 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ltP6w-0000wF-II; Wed, 16 Jun 2021 06:33:14 +0000
Date:   Wed, 16 Jun 2021 14:32:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS WITH WARNING
 293649307ef9abcd4f83f6dac4d4400dfd97c936
Message-ID: <60c99b15.WyPErEJoF/6cElsx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: 293649307ef9abcd4f83f6dac4d4400dfd97c936  x86/tsx: Clear CPUID bits when TSX always force aborts

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-allnoconfig
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-cpufeatures.h-differs-from-latest-version-at-arch-x86-include-asm-cpufeatures.h:define-X86_FEATURE_RTM_ALWAYS_ABORT-(-)-RTM-transaction-always-a
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-msr-index.h-differs-from-latest-version-at-arch-x86-include-asm-msr-index.h:define-MSR_TFA_SDV_ENABLE_RTM-BIT_ULL(MSR_TFA_SDV_ENABLE_RTM_BIT)
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-msr-index.h-differs-from-latest-version-at-arch-x86-include-asm-msr-index.h:define-MSR_TFA_SDV_ENABLE_RTM_BIT
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-msr-index.h-differs-from-latest-version-at-arch-x86-include-asm-msr-index.h:define-MSR_TFA_TSX_CPUID_CLEAR-BIT_ULL(MSR_TFA_TSX_CPUID_CLEAR_BIT)
    `-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-msr-index.h-differs-from-latest-version-at-arch-x86-include-asm-msr-index.h:define-MSR_TFA_TSX_CPUID_CLEAR_BIT

elapsed time: 721m

configs tested: 115
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
powerpc                  mpc866_ads_defconfig
ia64                        generic_defconfig
arm                       versatile_defconfig
arm                         lpc32xx_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                   bluestone_defconfig
sh                          r7785rp_defconfig
sh                        sh7785lcr_defconfig
xtensa                    smp_lx200_defconfig
mips                          ath79_defconfig
powerpc                  iss476-smp_defconfig
h8300                            allyesconfig
mips                  cavium_octeon_defconfig
um                           x86_64_defconfig
arm                          pcm027_defconfig
powerpc                      ppc64e_defconfig
xtensa                  audio_kc705_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
openrisc                            defconfig
sh                        sh7763rdp_defconfig
mips                      bmips_stb_defconfig
um                            kunit_defconfig
mips                     cu1000-neo_defconfig
m68k                       m5275evb_defconfig
arm                        keystone_defconfig
arm                         palmz72_defconfig
powerpc                mpc7448_hpc2_defconfig
m68k                          atari_defconfig
powerpc                        fsp2_defconfig
powerpc                     sbc8548_defconfig
s390                             alldefconfig
riscv             nommu_k210_sdcard_defconfig
arm                            zeus_defconfig
m68k                          sun3x_defconfig
i386                                defconfig
arm                          exynos_defconfig
sh                           se7343_defconfig
arm                              alldefconfig
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
xtensa                           allyesconfig
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
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
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
