Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339CB3A3387
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFJSxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:53:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:36998 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhFJSxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:53:22 -0400
IronPort-SDR: 2ONSroT9zBGvDZaVhADQE2y8qK4jfGln1QbaFkDHS4mZW11eKf/A1vvrP6s/z5InEsy80agQQu
 Tcf+xCJgRg5A==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="202345591"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="202345591"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 11:51:24 -0700
IronPort-SDR: 8TqzKEH+/9B+Md6G9jnUQ5067Jz6grq6j7kpposeDAbP08KztjrQZxSmcZZuwoxP1Gh6/IqOXG
 8ZpbdJ+nBL4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="482961483"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Jun 2021 11:51:22 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrPlx-0000Dt-TS; Thu, 10 Jun 2021 18:51:21 +0000
Date:   Fri, 11 Jun 2021 02:50:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS WITH WARNING
 efa165504943f2128d50f63de0c02faf6dcceb0d
Message-ID: <60c25eef.nwlR9DUqvg/BrcwD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: efa165504943f2128d50f63de0c02faf6dcceb0d  x86/fpu: Reset state for all signal restore failures

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

elapsed time: 720m

configs tested: 187
configs skipped: 88

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                                defconfig
arm                       cns3420vb_defconfig
s390                             alldefconfig
sh                            shmin_defconfig
arm                          collie_defconfig
powerpc                  mpc885_ads_defconfig
arm                         lpc18xx_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          pxa910_defconfig
xtensa                  cadence_csp_defconfig
mips                           gcw0_defconfig
sh                 kfr2r09-romimage_defconfig
arm                  colibri_pxa270_defconfig
mips                       lemote2f_defconfig
arm                        clps711x_defconfig
sparc                            alldefconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
sh                        edosk7760_defconfig
ia64                          tiger_defconfig
h8300                    h8300h-sim_defconfig
arm                        oxnas_v6_defconfig
arc                          axs101_defconfig
mips                      pic32mzda_defconfig
sparc                       sparc64_defconfig
riscv                             allnoconfig
powerpc                    mvme5100_defconfig
sh                           se7619_defconfig
mips                 decstation_r4k_defconfig
openrisc                    or1ksim_defconfig
arm                        shmobile_defconfig
arc                         haps_hs_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc8560_ads_defconfig
arm                      pxa255-idp_defconfig
mips                           ip32_defconfig
powerpc                     tqm8560_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
arm                          badge4_defconfig
xtensa                       common_defconfig
xtensa                    xip_kc705_defconfig
mips                         mpc30x_defconfig
h8300                            alldefconfig
sh                           se7721_defconfig
xtensa                           allyesconfig
um                                  defconfig
mips                      maltaaprp_defconfig
mips                        workpad_defconfig
powerpc                      mgcoge_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
microblaze                          defconfig
sh                          rsk7269_defconfig
mips                         bigsur_defconfig
sh                          sdk7780_defconfig
arm                           sama5_defconfig
powerpc                     ep8248e_defconfig
arm                      footbridge_defconfig
mips                         db1xxx_defconfig
sh                               j2_defconfig
powerpc                      pmac32_defconfig
powerpc                          allmodconfig
powerpc                     mpc5200_defconfig
parisc                           alldefconfig
arm                         assabet_defconfig
sh                   rts7751r2dplus_defconfig
mips                           ci20_defconfig
sh                          kfr2r09_defconfig
sh                             espt_defconfig
mips                     loongson1c_defconfig
m68k                          multi_defconfig
arc                                 defconfig
powerpc                          allyesconfig
sparc64                             defconfig
openrisc                         alldefconfig
sh                            titan_defconfig
m68k                       bvme6000_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     tqm8541_defconfig
x86_64                           allyesconfig
arc                            hsdk_defconfig
powerpc                       ppc64_defconfig
arm                        neponset_defconfig
mips                     loongson2k_defconfig
arm                      tct_hammer_defconfig
powerpc64                           defconfig
m68k                        mvme16x_defconfig
mips                       bmips_be_defconfig
arm                            mps2_defconfig
sh                               alldefconfig
sh                          r7780mp_defconfig
arm                          ep93xx_defconfig
mips                      maltasmvp_defconfig
arm                           sunxi_defconfig
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
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210609
i386                 randconfig-a006-20210609
i386                 randconfig-a004-20210609
i386                 randconfig-a001-20210609
i386                 randconfig-a002-20210609
i386                 randconfig-a005-20210609
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210610
x86_64               randconfig-a001-20210610
x86_64               randconfig-a004-20210610
x86_64               randconfig-a003-20210610
x86_64               randconfig-a006-20210610
x86_64               randconfig-a005-20210610
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
