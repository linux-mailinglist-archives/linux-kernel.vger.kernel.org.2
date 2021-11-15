Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567F545275B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 03:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbhKPCWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 21:22:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:21310 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238074AbhKORjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 12:39:17 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10169"; a="232211176"
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="232211176"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2021 09:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,237,1631602800"; 
   d="scan'208";a="603916913"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2021 09:35:44 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mmftP-000Moq-CO; Mon, 15 Nov 2021 17:35:43 +0000
Date:   Tue, 16 Nov 2021 01:35:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:test-clang-ft] BUILD SUCCESS
 4ceb6d04c2cdcff2c6bd0cfcc1aad57915eaac2b
Message-ID: <61929a55.wmXwgj2RvCaBdx+2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git test-clang-ft
branch HEAD: 4ceb6d04c2cdcff2c6bd0cfcc1aad57915eaac2b  kconfig: Fix -Wimplicit-fallthrough=5 error for GCC 5.x and 6.x

elapsed time: 859m

configs tested: 186
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211115
arm                            zeus_defconfig
nios2                         10m50_defconfig
arm                          pcm027_defconfig
arm                         assabet_defconfig
arm                           tegra_defconfig
h8300                            alldefconfig
arc                                 defconfig
sh                           se7751_defconfig
arm                        mini2440_defconfig
mips                        bcm63xx_defconfig
sh                           se7721_defconfig
powerpc                      pasemi_defconfig
powerpc                      walnut_defconfig
powerpc                     sequoia_defconfig
arm                        mvebu_v7_defconfig
sh                     sh7710voipgw_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                  audio_kc705_defconfig
arm                          ixp4xx_defconfig
m68k                          multi_defconfig
arm                      jornada720_defconfig
powerpc                    sam440ep_defconfig
nios2                               defconfig
mips                         bigsur_defconfig
sh                        edosk7760_defconfig
um                                  defconfig
riscv                               defconfig
arm                    vt8500_v6_v7_defconfig
mips                           rs90_defconfig
sh                      rts7751r2d1_defconfig
nios2                            alldefconfig
mips                         db1xxx_defconfig
ia64                          tiger_defconfig
mips                         cobalt_defconfig
h8300                     edosk2674_defconfig
m68k                          amiga_defconfig
alpha                            allyesconfig
openrisc                 simple_smp_defconfig
sh                          r7780mp_defconfig
ia64                                defconfig
arm                            xcep_defconfig
sh                        apsh4ad0a_defconfig
arc                        nsim_700_defconfig
mips                       capcella_defconfig
arm                       netwinder_defconfig
arm                        cerfcube_defconfig
powerpc                      katmai_defconfig
arm                         hackkit_defconfig
arm                        clps711x_defconfig
powerpc                     tqm5200_defconfig
mips                        vocore2_defconfig
powerpc                           allnoconfig
arm                       aspeed_g4_defconfig
powerpc                     tqm8541_defconfig
m68k                            mac_defconfig
arm                       omap2plus_defconfig
powerpc                     ep8248e_defconfig
arm                          pxa3xx_defconfig
mips                             allyesconfig
arm                           sama7_defconfig
riscv                    nommu_virt_defconfig
arm                          pxa168_defconfig
xtensa                generic_kc705_defconfig
arm                            qcom_defconfig
m68k                        mvme16x_defconfig
sh                        sh7757lcr_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
mips                            e55_defconfig
arm                          pxa910_defconfig
xtensa                  nommu_kc705_defconfig
alpha                            alldefconfig
arm                            dove_defconfig
parisc                           alldefconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc832x_mds_defconfig
mips                     loongson1c_defconfig
arm                        trizeps4_defconfig
sh                          urquell_defconfig
mips                           ip28_defconfig
arm                         socfpga_defconfig
arm                        shmobile_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                      ppc64e_defconfig
powerpc                         wii_defconfig
mips                           ip32_defconfig
mips                      malta_kvm_defconfig
arm                      pxa255-idp_defconfig
arm                        multi_v5_defconfig
powerpc                  mpc866_ads_defconfig
arc                      axs103_smp_defconfig
mips                malta_qemu_32r6_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc837x_mds_defconfig
m68k                        m5272c3_defconfig
arm                          lpd270_defconfig
sh                           se7206_defconfig
powerpc                      pcm030_defconfig
sparc                            allyesconfig
arm                        multi_v7_defconfig
powerpc                   bluestone_defconfig
sh                           se7343_defconfig
sh                          r7785rp_defconfig
m68k                        stmark2_defconfig
arm                           sunxi_defconfig
arm                  randconfig-c002-20211115
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allmodconfig
s390                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
i386                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a005-20211115
x86_64               randconfig-a003-20211115
x86_64               randconfig-a002-20211115
x86_64               randconfig-a001-20211115
x86_64               randconfig-a006-20211115
x86_64               randconfig-a004-20211115
i386                 randconfig-a006-20211115
i386                 randconfig-a003-20211115
i386                 randconfig-a005-20211115
i386                 randconfig-a001-20211115
i386                 randconfig-a004-20211115
i386                 randconfig-a002-20211115
riscv                            allmodconfig
riscv                            allyesconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211115
i386                 randconfig-c001-20211115
arm                  randconfig-c002-20211115
riscv                randconfig-c006-20211115
powerpc              randconfig-c003-20211115
s390                 randconfig-c005-20211115
mips                 randconfig-c004-20211115
x86_64               randconfig-a015-20211115
x86_64               randconfig-a013-20211115
x86_64               randconfig-a011-20211115
x86_64               randconfig-a012-20211115
x86_64               randconfig-a016-20211115
x86_64               randconfig-a014-20211115
i386                 randconfig-a014-20211115
i386                 randconfig-a016-20211115
i386                 randconfig-a012-20211115
i386                 randconfig-a013-20211115
i386                 randconfig-a011-20211115
i386                 randconfig-a015-20211115
hexagon              randconfig-r045-20211115
hexagon              randconfig-r041-20211115
s390                 randconfig-r044-20211115
riscv                randconfig-r042-20211115

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
