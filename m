Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3328349CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 00:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbhCYXcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 19:32:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:33005 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhCYXbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 19:31:52 -0400
IronPort-SDR: qEysfkUUaddguOOKdrkRSDWcyaj12n6YCADuNMM0epVaBeVwUpoFN0lXDKZivYdkw51polouUl
 gGyKjDbKDqUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="276167177"
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="276167177"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 16:31:52 -0700
IronPort-SDR: uLDa2+hYrc1cK2XisuP44LTCU/mkdhyUggrh2Jj1wntrCPwA3YDZkMToRnO6uwfxqpeqQXsven
 n2F6MCpGRIVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,278,1610438400"; 
   d="scan'208";a="443589251"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Mar 2021 16:31:50 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPZS9-0002KU-SE; Thu, 25 Mar 2021 23:31:49 +0000
Date:   Fri, 26 Mar 2021 07:31:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 0a2b65c03e9b47493e1442bf9c84badc60d9bffb
Message-ID: <605d1d50.et2J4pHKxlOfbUeY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 0a2b65c03e9b47493e1442bf9c84badc60d9bffb  sched/topology: Remove redundant cpumask_and() in init_overlap_sched_group()

elapsed time: 724m

configs tested: 197
configs skipped: 2

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
powerpc                  mpc885_ads_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
powerpc64                           defconfig
sh                            titan_defconfig
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
s390                          debug_defconfig
arc                      axs103_smp_defconfig
arm                        keystone_defconfig
sh                           se7619_defconfig
arm                        spear3xx_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                           gcw0_defconfig
arc                         haps_hs_defconfig
um                             i386_defconfig
arm                          badge4_defconfig
sh                           se7780_defconfig
mips                         db1xxx_defconfig
powerpc                      cm5200_defconfig
arm                       cns3420vb_defconfig
parisc                           alldefconfig
arm                        shmobile_defconfig
arm                            pleb_defconfig
sh                   sh7770_generic_defconfig
mips                         tb0287_defconfig
um                                allnoconfig
m68k                          atari_defconfig
arm                          pcm027_defconfig
microblaze                      mmu_defconfig
powerpc                       ppc64_defconfig
arm                           spitz_defconfig
arm                          lpd270_defconfig
mips                      maltaaprp_defconfig
mips                           ip27_defconfig
mips                       rbtx49xx_defconfig
ia64                      gensparse_defconfig
arm                      jornada720_defconfig
mips                     loongson1c_defconfig
powerpc                     sequoia_defconfig
powerpc                      katmai_defconfig
arm                        multi_v7_defconfig
arm                       imx_v6_v7_defconfig
mips                  cavium_octeon_defconfig
m68k                           sun3_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                          sdk7780_defconfig
powerpc                      acadia_defconfig
ia64                             allyesconfig
powerpc                      makalu_defconfig
powerpc                 mpc834x_mds_defconfig
arc                          axs103_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                 linkstation_defconfig
mips                          malta_defconfig
csky                             alldefconfig
powerpc                        fsp2_defconfig
arm                            xcep_defconfig
m68k                        mvme147_defconfig
ia64                             allmodconfig
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
sh                          lboxre2_defconfig
arm                         axm55xx_defconfig
ia64                        generic_defconfig
m68k                            mac_defconfig
nds32                            alldefconfig
powerpc                     tqm8548_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                            dove_defconfig
arm                          gemini_defconfig
sh                           se7751_defconfig
powerpc                    klondike_defconfig
sh                           se7343_defconfig
openrisc                    or1ksim_defconfig
m68k                                defconfig
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
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
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
