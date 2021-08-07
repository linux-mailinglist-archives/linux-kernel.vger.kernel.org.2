Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCB63E3268
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 02:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhHGAnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 20:43:09 -0400
Received: from mga17.intel.com ([192.55.52.151]:1599 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhHGAnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 20:43:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="194733865"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="194733865"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 17:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="481975240"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Aug 2021 17:42:48 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mCAQK-000HNq-7x; Sat, 07 Aug 2021 00:42:48 +0000
Date:   Sat, 07 Aug 2021 08:42:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 f4dddf90d58d77b48492b775868af4041a217f4c
Message-ID: <610dd704.La4m4rFRc7CiDAIJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
branch HEAD: f4dddf90d58d77b48492b775868af4041a217f4c  sched: Skip priority checks with SCHED_FLAG_KEEP_PARAMS

elapsed time: 722m

configs tested: 171
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210804
i386                 randconfig-c001-20210805
h8300                       h8s-sim_defconfig
arm                            pleb_defconfig
powerpc                 mpc832x_mds_defconfig
sh                            titan_defconfig
arc                     haps_hs_smp_defconfig
m68k                        m5307c3_defconfig
arm                          pcm027_defconfig
arm                         lpc32xx_defconfig
sh                           sh2007_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
arc                                 defconfig
mips                     loongson1b_defconfig
arm                           sama5_defconfig
sh                     sh7710voipgw_defconfig
arm                     eseries_pxa_defconfig
sh                   sh7724_generic_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                         wii_defconfig
arm                        cerfcube_defconfig
mips                      loongson3_defconfig
mips                         tb0219_defconfig
arm                       mainstone_defconfig
powerpc                     mpc512x_defconfig
um                                  defconfig
sh                ecovec24-romimage_defconfig
powerpc                   microwatt_defconfig
sh                        dreamcast_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     mpc5200_defconfig
mips                           mtx1_defconfig
mips                          rb532_defconfig
m68k                            mac_defconfig
powerpc                 mpc836x_mds_defconfig
parisc                generic-32bit_defconfig
arm                        mvebu_v7_defconfig
sh                           se7343_defconfig
arm                        multi_v7_defconfig
powerpc                    sam440ep_defconfig
powerpc                      mgcoge_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
mips                        jmr3927_defconfig
powerpc                        fsp2_defconfig
arm                      footbridge_defconfig
arm                           spitz_defconfig
powerpc                     stx_gp3_defconfig
openrisc                  or1klitex_defconfig
powerpc                    adder875_defconfig
m68k                          amiga_defconfig
powerpc                     taishan_defconfig
arm                        oxnas_v6_defconfig
sh                          sdk7786_defconfig
sh                            hp6xx_defconfig
xtensa                         virt_defconfig
arm                         axm55xx_defconfig
sh                        apsh4ad0a_defconfig
h8300                               defconfig
parisc                           alldefconfig
m68k                         apollo_defconfig
arm                         palmz72_defconfig
mips                            gpr_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
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
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210805
x86_64               randconfig-a006-20210805
x86_64               randconfig-a004-20210805
x86_64               randconfig-a003-20210805
x86_64               randconfig-a001-20210805
x86_64               randconfig-a005-20210805
i386                 randconfig-a005-20210804
i386                 randconfig-a004-20210804
i386                 randconfig-a002-20210804
i386                 randconfig-a006-20210804
i386                 randconfig-a003-20210804
i386                 randconfig-a001-20210804
i386                 randconfig-a005-20210806
i386                 randconfig-a004-20210806
i386                 randconfig-a002-20210806
i386                 randconfig-a006-20210806
i386                 randconfig-a003-20210806
i386                 randconfig-a001-20210806
x86_64               randconfig-a012-20210804
x86_64               randconfig-a016-20210804
x86_64               randconfig-a011-20210804
x86_64               randconfig-a013-20210804
x86_64               randconfig-a014-20210804
x86_64               randconfig-a015-20210804
i386                 randconfig-a012-20210806
i386                 randconfig-a011-20210806
i386                 randconfig-a015-20210806
i386                 randconfig-a013-20210806
i386                 randconfig-a014-20210806
i386                 randconfig-a016-20210806
i386                 randconfig-a012-20210805
i386                 randconfig-a011-20210805
i386                 randconfig-a015-20210805
i386                 randconfig-a013-20210805
i386                 randconfig-a014-20210805
i386                 randconfig-a016-20210805
i386                 randconfig-a012-20210804
i386                 randconfig-a011-20210804
i386                 randconfig-a015-20210804
i386                 randconfig-a013-20210804
i386                 randconfig-a014-20210804
i386                 randconfig-a016-20210804
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210804
x86_64               randconfig-c001-20210805
x86_64               randconfig-a002-20210804
x86_64               randconfig-a006-20210804
x86_64               randconfig-a004-20210804
x86_64               randconfig-a003-20210804
x86_64               randconfig-a001-20210804
x86_64               randconfig-a005-20210804
x86_64               randconfig-a012-20210805
x86_64               randconfig-a016-20210805
x86_64               randconfig-a011-20210805
x86_64               randconfig-a013-20210805
x86_64               randconfig-a014-20210805
x86_64               randconfig-a015-20210805

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
