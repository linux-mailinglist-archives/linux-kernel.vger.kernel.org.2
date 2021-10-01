Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3637F41EBE6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353877AbhJALat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:30:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:7901 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353852AbhJALas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:30:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="204889922"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="204889922"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 04:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="708570886"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Oct 2021 04:29:01 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mWGiq-00017a-Fb; Fri, 01 Oct 2021 11:29:00 +0000
Date:   Fri, 01 Oct 2021 19:28:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 718ecc280a842d5fcf9a855a665f7a6945519ce2
Message-ID: <6156f0d7.VYN+OrEE37QWpPEa%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 718ecc280a842d5fcf9a855a665f7a6945519ce2  rcu: Make idle entry report expedited quiescent states

elapsed time: 1378m

configs tested: 229
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
powerpc              randconfig-c003-20210930
i386                 randconfig-c001-20210930
i386                 randconfig-c001-20211001
arm                         s3c6400_defconfig
mips                malta_qemu_32r6_defconfig
sh                   secureedge5410_defconfig
m68k                         amcore_defconfig
sh                            shmin_defconfig
sh                           se7722_defconfig
alpha                            alldefconfig
arm                           h3600_defconfig
arm                          ep93xx_defconfig
powerpc                    ge_imp3a_defconfig
m68k                       m5275evb_defconfig
arm                           tegra_defconfig
arm                       aspeed_g4_defconfig
powerpc                     tqm8541_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                        warp_defconfig
sh                     sh7710voipgw_defconfig
sh                                  defconfig
riscv                            alldefconfig
powerpc                      cm5200_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                     kilauea_defconfig
sh                          rsk7264_defconfig
ia64                                defconfig
mips                           xway_defconfig
mips                      bmips_stb_defconfig
arm                          exynos_defconfig
powerpc                 linkstation_defconfig
i386                                defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                              defconfig
mips                          ath79_defconfig
microblaze                          defconfig
arm                       mainstone_defconfig
mips                     loongson1b_defconfig
powerpc                      ppc64e_defconfig
sh                           se7780_defconfig
arm                           stm32_defconfig
m68k                          sun3x_defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
mips                          rb532_defconfig
arm                        oxnas_v6_defconfig
arm                        spear6xx_defconfig
sh                            titan_defconfig
sh                             espt_defconfig
arm                            mmp2_defconfig
powerpc                        icon_defconfig
arm                            zeus_defconfig
sh                           se7724_defconfig
sparc                            allyesconfig
arm                   milbeaut_m10v_defconfig
arm                          iop32x_defconfig
mips                         cobalt_defconfig
h8300                       h8s-sim_defconfig
arm                         bcm2835_defconfig
arm                            lart_defconfig
sparc64                             defconfig
s390                       zfcpdump_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
arm                  colibri_pxa270_defconfig
sh                        edosk7705_defconfig
m68k                       m5475evb_defconfig
mips                       rbtx49xx_defconfig
powerpc                     skiroot_defconfig
ia64                             allmodconfig
m68k                        m5272c3_defconfig
sh                              ul2_defconfig
powerpc                     ksi8560_defconfig
sh                     magicpanelr2_defconfig
arm                       imx_v6_v7_defconfig
openrisc                            defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                     tqm8540_defconfig
arm                        multi_v7_defconfig
arm                           u8500_defconfig
xtensa                       common_defconfig
arc                        nsimosci_defconfig
arm                              alldefconfig
arm                        mvebu_v5_defconfig
arm                        mvebu_v7_defconfig
s390                          debug_defconfig
powerpc                      pcm030_defconfig
csky                                defconfig
ia64                             alldefconfig
mips                        workpad_defconfig
ia64                             allyesconfig
powerpc                 mpc836x_mds_defconfig
powerpc                    socrates_defconfig
um                             i386_defconfig
sh                        apsh4ad0a_defconfig
arm                        magician_defconfig
mips                       bmips_be_defconfig
mips                       lemote2f_defconfig
powerpc                   motionpro_defconfig
powerpc                     tqm5200_defconfig
powerpc64                           defconfig
x86_64                           alldefconfig
mips                            e55_defconfig
arm                            pleb_defconfig
xtensa                  audio_kc705_defconfig
arm                        trizeps4_defconfig
powerpc                      obs600_defconfig
ia64                        generic_defconfig
sh                            hp6xx_defconfig
arm                       omap2plus_defconfig
sh                          r7780mp_defconfig
mips                        vocore2_defconfig
xtensa                    xip_kc705_defconfig
arc                         haps_hs_defconfig
arc                           tb10x_defconfig
arm                  randconfig-c002-20210930
x86_64               randconfig-c001-20210930
x86_64               randconfig-c001-20211001
arm                  randconfig-c002-20211001
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
sparc                               defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210930
x86_64               randconfig-a001-20210930
x86_64               randconfig-a002-20210930
x86_64               randconfig-a005-20210930
x86_64               randconfig-a006-20210930
x86_64               randconfig-a003-20210930
i386                 randconfig-a003-20210930
i386                 randconfig-a001-20210930
i386                 randconfig-a004-20210930
i386                 randconfig-a002-20210930
i386                 randconfig-a006-20210930
i386                 randconfig-a005-20210930
i386                 randconfig-a001-20211001
i386                 randconfig-a003-20211001
i386                 randconfig-a005-20211001
i386                 randconfig-a002-20211001
i386                 randconfig-a004-20211001
i386                 randconfig-a006-20211001
x86_64               randconfig-a003-20211001
x86_64               randconfig-a005-20211001
x86_64               randconfig-a001-20211001
x86_64               randconfig-a002-20211001
x86_64               randconfig-a004-20211001
x86_64               randconfig-a006-20211001
arc                  randconfig-r043-20210930
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-c007-20211001
i386                 randconfig-c001-20211001
arm                  randconfig-c002-20211001
s390                 randconfig-c005-20211001
powerpc              randconfig-c003-20211001
riscv                randconfig-c006-20211001
mips                 randconfig-c004-20211001
i386                 randconfig-c001-20210930
arm                  randconfig-c002-20210930
powerpc              randconfig-c003-20210930
mips                 randconfig-c004-20210930
s390                 randconfig-c005-20210930
riscv                randconfig-c006-20210930
x86_64               randconfig-c007-20210930
x86_64               randconfig-a015-20210930
x86_64               randconfig-a011-20210930
x86_64               randconfig-a012-20210930
x86_64               randconfig-a013-20210930
x86_64               randconfig-a016-20210930
x86_64               randconfig-a014-20210930
x86_64               randconfig-a015-20211001
x86_64               randconfig-a012-20211001
x86_64               randconfig-a016-20211001
x86_64               randconfig-a014-20211001
x86_64               randconfig-a013-20211001
x86_64               randconfig-a011-20211001
i386                 randconfig-a014-20210930
i386                 randconfig-a013-20210930
i386                 randconfig-a011-20210930
i386                 randconfig-a015-20210930
i386                 randconfig-a016-20210930
i386                 randconfig-a012-20210930
i386                 randconfig-a013-20211001
i386                 randconfig-a016-20211001
i386                 randconfig-a014-20211001
i386                 randconfig-a012-20211001
i386                 randconfig-a011-20211001
i386                 randconfig-a015-20211001
riscv                randconfig-r042-20210930
hexagon              randconfig-r041-20210930
s390                 randconfig-r044-20210930
hexagon              randconfig-r045-20210930
hexagon              randconfig-r045-20211001
hexagon              randconfig-r041-20211001
s390                 randconfig-r044-20211001
riscv                randconfig-r042-20211001

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
