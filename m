Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81E6A3AD7F1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 07:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbhFSFCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 01:02:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:1848 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233146AbhFSFCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 01:02:06 -0400
IronPort-SDR: VdjgXxDZw4/+vmKYq1+Nhpyb9NJj2pHuDhiWqzeSi8DcfbrF8zya2ERULKhPUxX53Ah+94eSQN
 eEAP7tPq+LcA==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="204824859"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="204824859"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 21:59:54 -0700
IronPort-SDR: mpj3OEH2UV/FxCB84+Ce2ybGkl5zeypEs4gF3q1huN5Q5TrQFRhJUtQ7WlYaRu0vhiMaYPPt/p
 jcSPrta4PV3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="555764593"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2021 21:59:53 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luT5E-0003L1-Oe; Sat, 19 Jun 2021 04:59:52 +0000
Date:   Sat, 19 Jun 2021 12:59:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 f6b6a80360995ad175e43d220af979f119e52cd3
Message-ID: <60cd79ab.QYhmlOqmiTdNlDR0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: f6b6a80360995ad175e43d220af979f119e52cd3  Merge tag 'timers-v5.14' of https://git.linaro.org/people/daniel.lezcano/linux into timers/core

elapsed time: 727m

configs tested: 152
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          rsk7269_defconfig
powerpc                     asp8347_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     skiroot_defconfig
powerpc                 mpc834x_itx_defconfig
sh                          polaris_defconfig
x86_64                            allnoconfig
xtensa                       common_defconfig
arm                          pxa168_defconfig
nios2                         3c120_defconfig
arm                           sama5_defconfig
arm                       imx_v6_v7_defconfig
mips                     loongson1c_defconfig
m68k                            mac_defconfig
nds32                             allnoconfig
powerpc64                           defconfig
arm                      pxa255-idp_defconfig
powerpc                     taishan_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                   currituck_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                     tqm8555_defconfig
arm                     am200epdkit_defconfig
arm                         orion5x_defconfig
sh                        edosk7705_defconfig
powerpc                    sam440ep_defconfig
powerpc                       ebony_defconfig
mips                           mtx1_defconfig
mips                        jmr3927_defconfig
powerpc                    gamecube_defconfig
mips                   sb1250_swarm_defconfig
powerpc                        fsp2_defconfig
arm                          badge4_defconfig
sh                           se7619_defconfig
powerpc                      pmac32_defconfig
um                           x86_64_defconfig
arm                         axm55xx_defconfig
arc                        vdk_hs38_defconfig
m68k                        mvme16x_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
s390                                defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          pxa3xx_defconfig
powerpc                      cm5200_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
sh                   sh7724_generic_defconfig
arm                          exynos_defconfig
mips                           ip32_defconfig
microblaze                      mmu_defconfig
arm                     davinci_all_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                          iop32x_defconfig
arm                          lpd270_defconfig
arm                          collie_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                  storcenter_defconfig
s390                             alldefconfig
sh                     magicpanelr2_defconfig
s390                          debug_defconfig
powerpc                     tqm5200_defconfig
arm                       netwinder_defconfig
arc                           tb10x_defconfig
arm                             ezx_defconfig
powerpc                     kmeter1_defconfig
arm                        realview_defconfig
ia64                             alldefconfig
arm                        clps711x_defconfig
sh                             espt_defconfig
mips                  decstation_64_defconfig
arm                       mainstone_defconfig
m68k                       m5475evb_defconfig
powerpc                         wii_defconfig
xtensa                              defconfig
sh                            migor_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210618
i386                 randconfig-a006-20210618
i386                 randconfig-a004-20210618
i386                 randconfig-a001-20210618
i386                 randconfig-a005-20210618
i386                 randconfig-a003-20210618
x86_64               randconfig-a015-20210618
x86_64               randconfig-a011-20210618
x86_64               randconfig-a012-20210618
x86_64               randconfig-a014-20210618
x86_64               randconfig-a016-20210618
x86_64               randconfig-a013-20210618
i386                 randconfig-a015-20210618
i386                 randconfig-a016-20210618
i386                 randconfig-a013-20210618
i386                 randconfig-a014-20210618
i386                 randconfig-a012-20210618
i386                 randconfig-a011-20210618
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210618
x86_64               randconfig-a002-20210618
x86_64               randconfig-a001-20210618
x86_64               randconfig-a004-20210618
x86_64               randconfig-a003-20210618
x86_64               randconfig-a006-20210618
x86_64               randconfig-a005-20210618

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
