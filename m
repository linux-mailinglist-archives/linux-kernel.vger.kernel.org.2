Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D032392334
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 01:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234871AbhEZX3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 19:29:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:62897 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234832AbhEZX3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 19:29:41 -0400
IronPort-SDR: G1hg+oBi6POGfEfCDRBmnxq8/SQwbtuMsnj8qpoPQhXB7LrglsusJFnBrDFl+06walwbtXfv7z
 NNf+EQyOypXA==
X-IronPort-AV: E=McAfee;i="6200,9189,9996"; a="182940331"
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="182940331"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2021 16:28:08 -0700
IronPort-SDR: 29YLqtLr37wlv6Yu+0P6awRnvn7sRyhhUk/0jgBdVS4Kw2kiDjS2jmQmhM5y6rhyr6XYRDAobX
 aI9/PqfLs9Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,333,1613462400"; 
   d="scan'208";a="480316082"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 26 May 2021 16:28:07 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lm2wY-0002Sk-Eu; Wed, 26 May 2021 23:28:06 +0000
Date:   Thu, 27 May 2021 07:27:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 bccf1ec369ac126b0997d01a6e1deae00e2cf6b3
Message-ID: <60aed959.fybUsElEtFhZlqXV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: bccf1ec369ac126b0997d01a6e1deae00e2cf6b3  locking/atomics: atomic-instrumented: simplify ifdeffery

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
arc                     haps_hs_smp_defconfig
sh                           se7751_defconfig
arm                           sunxi_defconfig
openrisc                         alldefconfig
arm                       imx_v6_v7_defconfig
sh                          sdk7786_defconfig
sh                   rts7751r2dplus_defconfig
m68k                         amcore_defconfig
mips                        jmr3927_defconfig
powerpc                      ppc44x_defconfig
mips                        nlm_xlp_defconfig
powerpc                  iss476-smp_defconfig
s390                          debug_defconfig
xtensa                    xip_kc705_defconfig
arm                       multi_v4t_defconfig
m68k                        m5272c3_defconfig
arm                        oxnas_v6_defconfig
alpha                            allyesconfig
powerpc                  mpc866_ads_defconfig
xtensa                         virt_defconfig
arm                          ep93xx_defconfig
s390                                defconfig
mips                  maltasmvp_eva_defconfig
powerpc                     tqm8548_defconfig
sh                           se7780_defconfig
arm                        spear3xx_defconfig
sh                           se7705_defconfig
powerpc                       maple_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                             ezx_defconfig
arm                              alldefconfig
powerpc                     tqm5200_defconfig
sh                            titan_defconfig
mips                           ip22_defconfig
m68k                             allyesconfig
mips                         rt305x_defconfig
arc                        vdk_hs38_defconfig
arc                      axs103_smp_defconfig
parisc                generic-32bit_defconfig
um                            kunit_defconfig
arm                          imote2_defconfig
powerpc                     tqm8560_defconfig
powerpc                     skiroot_defconfig
powerpc                           allnoconfig
arm                      footbridge_defconfig
um                               allyesconfig
mips                  decstation_64_defconfig
openrisc                 simple_smp_defconfig
sh                          sdk7780_defconfig
arm                          pxa168_defconfig
sh                          lboxre2_defconfig
powerpc                    sam440ep_defconfig
arm                     davinci_all_defconfig
sparc64                          alldefconfig
arm                          pxa910_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                     nsimosci_hs_defconfig
mips                           ip28_defconfig
mips                         db1xxx_defconfig
m68k                        mvme16x_defconfig
arm                            xcep_defconfig
mips                         tb0287_defconfig
arm64                            alldefconfig
mips                        bcm47xx_defconfig
h8300                               defconfig
sh                     sh7710voipgw_defconfig
mips                  cavium_octeon_defconfig
nios2                            alldefconfig
arm                      jornada720_defconfig
powerpc                    amigaone_defconfig
mips                    maltaup_xpa_defconfig
mips                        maltaup_defconfig
arm                        realview_defconfig
mips                         mpc30x_defconfig
um                                  defconfig
arm                          collie_defconfig
m68k                        stmark2_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                       ebony_defconfig
mips                        vocore2_defconfig
arm                         cm_x300_defconfig
mips                          rm200_defconfig
arm                            pleb_defconfig
sparc64                             defconfig
arm                           omap1_defconfig
mips                        workpad_defconfig
arm                          moxart_defconfig
mips                          malta_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
mips                            ar7_defconfig
powerpc                      bamboo_defconfig
arm                           u8500_defconfig
arm                         s3c2410_defconfig
parisc                           allyesconfig
arm                            qcom_defconfig
powerpc                      pasemi_defconfig
arm                            lart_defconfig
x86_64                            allnoconfig
sh                          r7780mp_defconfig
powerpc                    mvme5100_defconfig
mips                          ath79_defconfig
arm                          lpd270_defconfig
sh                           se7750_defconfig
sh                           se7206_defconfig
arm                       cns3420vb_defconfig
powerpc                     sequoia_defconfig
sh                           se7619_defconfig
powerpc                   lite5200b_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
alpha                               defconfig
arm                         lpc18xx_defconfig
mips                      fuloong2e_defconfig
powerpc                      obs600_defconfig
sparc                       sparc64_defconfig
powerpc                      mgcoge_defconfig
openrisc                            defconfig
mips                     loongson1c_defconfig
m68k                             allmodconfig
riscv                    nommu_k210_defconfig
alpha                            alldefconfig
arc                    vdk_hs38_smp_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
arm                         nhk8815_defconfig
nios2                         3c120_defconfig
sh                          kfr2r09_defconfig
arm                        cerfcube_defconfig
mips                           ci20_defconfig
xtensa                  cadence_csp_defconfig
arm                       omap2plus_defconfig
powerpc                     mpc83xx_defconfig
arm                          ixp4xx_defconfig
microblaze                          defconfig
xtensa                           allyesconfig
arc                        nsim_700_defconfig
mips                        nlm_xlr_defconfig
mips                     cu1830-neo_defconfig
arm                           corgi_defconfig
mips                     cu1000-neo_defconfig
parisc                generic-64bit_defconfig
sh                            shmin_defconfig
arm                         hackkit_defconfig
m68k                         apollo_defconfig
um                             i386_defconfig
mips                        qi_lb60_defconfig
m68k                          hp300_defconfig
arm                       aspeed_g5_defconfig
arc                            hsdk_defconfig
mips                          rb532_defconfig
arm                        trizeps4_defconfig
arm                        mvebu_v5_defconfig
mips                      maltaaprp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20210526
x86_64               randconfig-a001-20210526
x86_64               randconfig-a006-20210526
x86_64               randconfig-a003-20210526
x86_64               randconfig-a004-20210526
x86_64               randconfig-a002-20210526
i386                 randconfig-a001-20210526
i386                 randconfig-a002-20210526
i386                 randconfig-a005-20210526
i386                 randconfig-a004-20210526
i386                 randconfig-a003-20210526
i386                 randconfig-a006-20210526
i386                 randconfig-a011-20210526
i386                 randconfig-a016-20210526
i386                 randconfig-a015-20210526
i386                 randconfig-a012-20210526
i386                 randconfig-a014-20210526
i386                 randconfig-a013-20210526
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210526
x86_64               randconfig-a013-20210526
x86_64               randconfig-a012-20210526
x86_64               randconfig-a014-20210526
x86_64               randconfig-a016-20210526
x86_64               randconfig-a015-20210526
x86_64               randconfig-a011-20210526

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
