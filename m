Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5596B3A2283
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 05:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFJDDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 23:03:25 -0400
Received: from mga03.intel.com ([134.134.136.65]:10307 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFJDDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 23:03:24 -0400
IronPort-SDR: fcwQ1quEer382ISnKu+rOAoQWwp+pBpd/l0pFFbBQ5doGHeg5aQDuD9u8YGBbRizYxon1bs8iw
 jC7BfiLQffYQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205248275"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="205248275"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 20:01:27 -0700
IronPort-SDR: kaXbToQT06zT4fAFgHRK/kvodaMgYG0ajoHcNvtZpUIHORXfQu+mJSkU2ZpIJsDsTEFuPFu5c3
 TGiw7e79HG0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="450170509"
Received: from lkp-server01.sh.intel.com (HELO 0cc315f1666b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jun 2021 20:01:26 -0700
Received: from kbuild by 0cc315f1666b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrAwf-00001b-A9; Thu, 10 Jun 2021 03:01:25 +0000
Date:   Thu, 10 Jun 2021 11:00:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 510b80a6a0f1a0d114c6e33bcea64747d127973c
Message-ID: <60c18067.WvRR8MCzESX6ZY3U%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 510b80a6a0f1a0d114c6e33bcea64747d127973c  x86/pkru: Write hardware init value to PKRU when xstate is init

possible Warning in current branch:

Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h':   59< #ifdef CONFIG_IOMMU_SUPPORT
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h':   59> /* Force disable because it's broken beyond repair */
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h':   60< # define DISABLE_ENQCMD	0
Warning: Kernel ABI header at 'tools/arch/x86/include/asm/disabled-features.h' differs from latest version at 'arch/x86/include/asm/disabled-features.h':   62< # define DISABLE_ENQCMD (1 << (X86_FEATURE_ENQCMD & 31))

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- x86_64-allnoconfig
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:Force-disable-because-it-s-broken-beyond-repair
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:define-DISABLE_ENQCMD
    |-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:define-DISABLE_ENQCMD-(-(X86_FEATURE_ENQCMD-))
    `-- Warning:Kernel-ABI-header-at-tools-arch-x86-include-asm-disabled-features.h-differs-from-latest-version-at-arch-x86-include-asm-disabled-features.h:ifdef-CONFIG_IOMMU_SUPPORT

elapsed time: 726m

configs tested: 170
configs skipped: 71

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
sparc                            alldefconfig
arm                             rpc_defconfig
arm                             ezx_defconfig
arm                          pxa3xx_defconfig
sh                          r7780mp_defconfig
arm                       cns3420vb_defconfig
arm                          ep93xx_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pasemi_defconfig
sh                          r7785rp_defconfig
s390                                defconfig
arm                              alldefconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
sparc                       sparc64_defconfig
powerpc                    mvme5100_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
ia64                        generic_defconfig
arm                          badge4_defconfig
arm                  colibri_pxa270_defconfig
xtensa                       common_defconfig
sh                             sh03_defconfig
sh                        sh7763rdp_defconfig
mips                     cu1000-neo_defconfig
sh                        dreamcast_defconfig
m68k                             allyesconfig
mips                        workpad_defconfig
powerpc                      mgcoge_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
microblaze                          defconfig
mips                         tb0287_defconfig
powerpc                 mpc8560_ads_defconfig
sh                           se7721_defconfig
mips                      fuloong2e_defconfig
um                           x86_64_defconfig
arc                         haps_hs_defconfig
ia64                         bigsur_defconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc8540_ads_defconfig
arm                         s3c6400_defconfig
mips                      bmips_stb_defconfig
mips                      pistachio_defconfig
powerpc                     mpc5200_defconfig
parisc                           alldefconfig
arm                         assabet_defconfig
mips                           ip32_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
sh                             espt_defconfig
mips                     loongson1c_defconfig
m68k                          multi_defconfig
sh                 kfr2r09-romimage_defconfig
sparc64                             defconfig
arc                                 defconfig
powerpc                          allyesconfig
riscv                               defconfig
openrisc                         alldefconfig
sh                            titan_defconfig
m68k                       bvme6000_defconfig
m68k                        m5307c3_defconfig
nios2                         10m50_defconfig
powerpc                     sbc8548_defconfig
arm                          pxa168_defconfig
arm                         orion5x_defconfig
arm                       aspeed_g4_defconfig
m68k                             alldefconfig
sh                           se7343_defconfig
powerpc                     mpc83xx_defconfig
sh                               alldefconfig
powerpc                     tqm8555_defconfig
mips                      maltasmvp_defconfig
arm                           sunxi_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
sh                               allmodconfig
h8300                            allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607
x86_64               randconfig-a015-20210608
x86_64               randconfig-a012-20210608
x86_64               randconfig-a014-20210608
x86_64               randconfig-a011-20210608
x86_64               randconfig-a016-20210608
x86_64               randconfig-a013-20210608
x86_64               randconfig-a004-20210609
x86_64               randconfig-a002-20210609
x86_64               randconfig-a003-20210609
x86_64               randconfig-a006-20210609
x86_64               randconfig-a005-20210609
x86_64               randconfig-a001-20210609

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
