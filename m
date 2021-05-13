Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C233800C0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 01:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhEMXSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 19:18:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:47305 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhEMXSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 19:18:43 -0400
IronPort-SDR: q+L72RpXV4/1GT25S0Na0iTMIrLpePUJzeLbhqtWmToA85FLXQp3pEHQEHsgiXB9zoK14iWF1j
 rS3c9tVISJQA==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="263999593"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="263999593"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 16:17:32 -0700
IronPort-SDR: NQWOK1HRewFY5SfYhPO4QG4zZvbRjsEI3LdMSHnelbn65aAnQIAq4BvDGeC1p74sNoXqAn9x8m
 Iby0D5KCnG0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="409801500"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 May 2021 16:17:30 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhKa9-0000SU-RE; Thu, 13 May 2021 23:17:29 +0000
Date:   Fri, 14 May 2021 07:17:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/urgent] BUILD SUCCESS
 3743d55b289c203d8f77b7cd47c24926b9d186ae
Message-ID: <609db381.F4t1gB3w8NhaMlFs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/urgent
branch HEAD: 3743d55b289c203d8f77b7cd47c24926b9d186ae  x86, sched: Fix the AMD CPPC maximum performance value on certain AMD Ryzen generations

i386-tinyconfig vmlinux size:

================================================================================================================
 TOTAL  TEXT  amd_get_highest_perf()                                                                            
================================================================================================================
     0     0                          02dbb7246c5b sched/fair: Fix clearing of has_idle_cores flag in select_id 
   +74   +74                     +74  3743d55b289c x86, sched: Fix the AMD CPPC maximum performance value on ce 
   +74   +74                     +74  88b06399c9c7..3743d55b289c (ALL COMMITS)                                  
================================================================================================================

elapsed time: 725m

configs tested: 190
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         tb0219_defconfig
ia64                          tiger_defconfig
powerpc                      acadia_defconfig
powerpc                 mpc836x_mds_defconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                           mtx1_defconfig
arm                           u8500_defconfig
powerpc                     taishan_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                         apollo_defconfig
sh                          r7785rp_defconfig
arm                        mini2440_defconfig
powerpc                   currituck_defconfig
xtensa                              defconfig
mips                        workpad_defconfig
powerpc                 linkstation_defconfig
mips                malta_qemu_32r6_defconfig
um                             i386_defconfig
arm                         lpc32xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                              alldefconfig
riscv                    nommu_virt_defconfig
m68k                                defconfig
mips                            ar7_defconfig
mips                             allyesconfig
sh                        sh7763rdp_defconfig
arm                            pleb_defconfig
arc                            hsdk_defconfig
arm                   milbeaut_m10v_defconfig
sh                        edosk7760_defconfig
mips                       capcella_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8540_defconfig
mips                          ath79_defconfig
powerpc                       maple_defconfig
powerpc                  storcenter_defconfig
ia64                             alldefconfig
arm                       mainstone_defconfig
arc                              allyesconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
sh                     magicpanelr2_defconfig
arm                        clps711x_defconfig
sh                         microdev_defconfig
arm                  colibri_pxa270_defconfig
xtensa                  cadence_csp_defconfig
arc                     haps_hs_smp_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
sh                   sh7770_generic_defconfig
riscv                    nommu_k210_defconfig
powerpc                   lite5200b_defconfig
powerpc                    gamecube_defconfig
arm                          simpad_defconfig
powerpc                      ppc44x_defconfig
powerpc                         ps3_defconfig
m68k                        m5307c3_defconfig
m68k                       m5275evb_defconfig
arm                          iop32x_defconfig
powerpc                 mpc8315_rdb_defconfig
sh                          landisk_defconfig
m68k                         amcore_defconfig
sh                        apsh4ad0a_defconfig
arm                        keystone_defconfig
um                               alldefconfig
sh                        edosk7705_defconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
mips                      maltaaprp_defconfig
xtensa                  nommu_kc705_defconfig
xtensa                           allyesconfig
nios2                            alldefconfig
powerpc                      pcm030_defconfig
arm                        spear6xx_defconfig
m68k                       m5249evb_defconfig
arm                           h5000_defconfig
powerpc                       ebony_defconfig
arm                            lart_defconfig
m68k                           sun3_defconfig
um                            kunit_defconfig
riscv                          rv32_defconfig
mips                         tb0287_defconfig
xtensa                generic_kc705_defconfig
arm                        cerfcube_defconfig
mips                 decstation_r4k_defconfig
powerpc                     sequoia_defconfig
powerpc                      makalu_defconfig
powerpc                        icon_defconfig
arc                                 defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                           ip22_defconfig
powerpc                      tqm8xx_defconfig
arm                       imx_v4_v5_defconfig
h8300                     edosk2674_defconfig
sh                          rsk7264_defconfig
arc                          axs101_defconfig
m68k                          hp300_defconfig
powerpc                         wii_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                          rb532_defconfig
h8300                               defconfig
ia64                             allyesconfig
arm                          moxart_defconfig
sh                          urquell_defconfig
mips                        jmr3927_defconfig
mips                       rbtx49xx_defconfig
sh                            migor_defconfig
h8300                       h8s-sim_defconfig
riscv                            alldefconfig
powerpc                     ksi8560_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
