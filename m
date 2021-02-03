Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2B530D344
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 07:03:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhBCGAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 01:00:37 -0500
Received: from mga06.intel.com ([134.134.136.31]:37606 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231499AbhBCGAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 01:00:36 -0500
IronPort-SDR: xCo5T8TTNHpHXS/IjxhN3GT3gemKd1mp8S9GWVT1gLV3cv5lm1SnO5f/plAsaq43zFhd8jtsdg
 rMRdnRxEYeQA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="242502634"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="242502634"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 21:59:53 -0800
IronPort-SDR: sKfQt+Ag06GkERtt8ufGNq5azSinF9eFugaRuLoFPcSPx1Q9ewk01qZZLFShRDjMc3Lnji+cLR
 9T11v23SRf0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="359321539"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 02 Feb 2021 21:59:52 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7BCi-000043-3h; Wed, 03 Feb 2021 05:59:52 +0000
Date:   Wed, 03 Feb 2021 13:59:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/seves] BUILD SUCCESS
 62a08a7193dc9107904aaa51a04ba3ba2959f745
Message-ID: <601a3bac.ZN1B7JdEz8Sg3I/v%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/seves
branch HEAD: 62a08a7193dc9107904aaa51a04ba3ba2959f745  x86/sev-es: Do not unroll string I/O for SEV-ES guests

elapsed time: 723m

configs tested: 137
configs skipped: 77

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
arm                          ep93xx_defconfig
h8300                               defconfig
arm                           viper_defconfig
c6x                        evmc6457_defconfig
powerpc                      mgcoge_defconfig
mips                        qi_lb60_defconfig
mips                        nlm_xlr_defconfig
powerpc                     kilauea_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
powerpc                    klondike_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-32bit_defconfig
powerpc                     mpc5200_defconfig
arm                             pxa_defconfig
powerpc                      acadia_defconfig
m68k                        m5272c3_defconfig
arm                        neponset_defconfig
mips                malta_kvm_guest_defconfig
arm                          moxart_defconfig
sh                         apsh4a3a_defconfig
sh                            titan_defconfig
mips                            gpr_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
arm                          collie_defconfig
sh                          landisk_defconfig
m68k                            q40_defconfig
arc                    vdk_hs38_smp_defconfig
arc                           tb10x_defconfig
c6x                        evmc6474_defconfig
m68k                       m5208evb_defconfig
powerpc                        warp_defconfig
xtensa                  audio_kc705_defconfig
sh                     magicpanelr2_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
powerpc                      katmai_defconfig
arm                           h5000_defconfig
powerpc                     tqm8560_defconfig
arm                        multi_v7_defconfig
nios2                         3c120_defconfig
arm                            pleb_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
m68k                          hp300_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
arm                          pcm027_defconfig
sh                   secureedge5410_defconfig
um                             i386_defconfig
powerpc                  storcenter_defconfig
mips                    maltaup_xpa_defconfig
mips                       lemote2f_defconfig
mips                      bmips_stb_defconfig
powerpc                      cm5200_defconfig
powerpc                     skiroot_defconfig
microblaze                          defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
