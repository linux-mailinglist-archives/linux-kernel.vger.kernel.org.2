Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED1349DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 01:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCZA3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 20:29:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:24737 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229664AbhCZA27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 20:28:59 -0400
IronPort-SDR: 1Ti/sN2zV2BxA1VBVX9VszK69r/W0jyws4rQa6GjINOa0OX6lIjdGU/H8Whhex36lwwyMszrqX
 dDXR9vZK87LA==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="171027350"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="171027350"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 17:28:59 -0700
IronPort-SDR: 4eV6xFPdx/YebYrcst8PWCqK9QSCHjJsyd62tCXxUCnNsjjpLcG7RuhF192NAdlBnWHl6PSx3o
 SC662S0nS7DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="453293726"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 Mar 2021 17:28:57 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPaLQ-0002ML-Kl; Fri, 26 Mar 2021 00:28:56 +0000
Date:   Fri, 26 Mar 2021 08:28:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 2304d14db6595bea5292bece06c4c625b12d8f89
Message-ID: <605d2ab8.T1FsdMQlfkhwzjQf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 2304d14db6595bea5292bece06c4c625b12d8f89  x86/kprobes: Move 'inline' to the beginning of the kprobe_is_ss() declaration

elapsed time: 734m

configs tested: 192
configs skipped: 87

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
mips                           ip28_defconfig
powerpc                   lite5200b_defconfig
arm                         s5pv210_defconfig
powerpc                   currituck_defconfig
h8300                            alldefconfig
powerpc                     ksi8560_defconfig
powerpc                       maple_defconfig
powerpc                      obs600_defconfig
sparc64                             defconfig
arm                         assabet_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
m68k                        m5407c3_defconfig
mips                        qi_lb60_defconfig
mips                         tb0226_defconfig
arm                              alldefconfig
sh                               alldefconfig
m68k                       m5475evb_defconfig
sh                   secureedge5410_defconfig
arm                        cerfcube_defconfig
powerpc                     mpc5200_defconfig
arm                          pxa3xx_defconfig
sh                          rsk7264_defconfig
csky                                defconfig
sh                     sh7710voipgw_defconfig
m68k                        stmark2_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                          rb532_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           gcw0_defconfig
arc                         haps_hs_defconfig
um                             i386_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
arm                       aspeed_g5_defconfig
arm                            pleb_defconfig
arm                            mmp2_defconfig
s390                             alldefconfig
xtensa                  cadence_csp_defconfig
parisc                           alldefconfig
arm                        shmobile_defconfig
sh                   sh7770_generic_defconfig
mips                     loongson1c_defconfig
powerpc                     sequoia_defconfig
powerpc                      katmai_defconfig
arm                        multi_v7_defconfig
arm                       imx_v6_v7_defconfig
sh                ecovec24-romimage_defconfig
arm                      pxa255-idp_defconfig
arm                            mps2_defconfig
powerpc                      makalu_defconfig
nds32                             allnoconfig
powerpc                   motionpro_defconfig
arm                         lpc18xx_defconfig
mips                     decstation_defconfig
sh                             espt_defconfig
mips                        bcm63xx_defconfig
m68k                                defconfig
mips                  cavium_octeon_defconfig
powerpc                       ppc64_defconfig
m68k                           sun3_defconfig
sh                          sdk7780_defconfig
powerpc                      acadia_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
powerpc64                           defconfig
mips                          malta_defconfig
csky                             alldefconfig
nds32                            alldefconfig
riscv                    nommu_k210_defconfig
powerpc                      ep88xc_defconfig
xtensa                    xip_kc705_defconfig
mips                        omega2p_defconfig
sh                     magicpanelr2_defconfig
ia64                             allmodconfig
mips                       capcella_defconfig
powerpc                      ppc6xx_defconfig
arm                       versatile_defconfig
arm                           tegra_defconfig
m68k                          amiga_defconfig
arc                            hsdk_defconfig
arm                          imote2_defconfig
sh                           se7712_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        multi_v5_defconfig
mips                         cobalt_defconfig
powerpc                        icon_defconfig
mips                          rm200_defconfig
arm                         lpc32xx_defconfig
mips                      maltaaprp_defconfig
sh                          lboxre2_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
m68k                            mac_defconfig
nios2                               defconfig
arm                           spitz_defconfig
powerpc                     tqm8548_defconfig
arm                           u8500_defconfig
arm                       netwinder_defconfig
powerpc                       eiger_defconfig
arm                          lpd270_defconfig
arm                          gemini_defconfig
sh                           se7751_defconfig
powerpc                    klondike_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
powerpc                      pasemi_defconfig
arm64                            alldefconfig
arm                       multi_v4t_defconfig
arm                          ixp4xx_defconfig
arc                        nsimosci_defconfig
sh                          polaris_defconfig
mips                       lemote2f_defconfig
powerpc                     powernv_defconfig
mips                 decstation_r4k_defconfig
arm                       aspeed_g4_defconfig
sh                          kfr2r09_defconfig
mips                             allmodconfig
mips                           ip32_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
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
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210325
x86_64               randconfig-a003-20210325
x86_64               randconfig-a006-20210325
x86_64               randconfig-a001-20210325
x86_64               randconfig-a005-20210325
x86_64               randconfig-a004-20210325
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a014-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210325
x86_64               randconfig-a015-20210325
x86_64               randconfig-a014-20210325
x86_64               randconfig-a013-20210325
x86_64               randconfig-a011-20210325
x86_64               randconfig-a016-20210325

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
