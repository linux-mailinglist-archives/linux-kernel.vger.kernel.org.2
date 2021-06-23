Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D973B1361
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhFWFvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:51:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:26520 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbhFWFvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:51:09 -0400
IronPort-SDR: ILxlsEsqzu7kswkuE9JG3lLal4vLuxWd4SLtHubdiVBfB0YXT6wuxicey98DK6e+89+RP8bmN9
 brFaQfr2g8RA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228761755"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="228761755"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 22:48:50 -0700
IronPort-SDR: dKloNLcWy02EK3EHX0B7V0/ziyU1b8O+s9RvVKEAlgwd8LU/oYL84IihqPZ85Fzs5KRYp+SYsM
 BpR1fB43Ksaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="481041702"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Jun 2021 22:48:48 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvvkm-0005kL-6L; Wed, 23 Jun 2021 05:48:48 +0000
Date:   Wed, 23 Jun 2021 13:48:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.06.18a] BUILD SUCCESS
 a288792a3fd9056c638a9ca8376dfa1de1f9d76b
Message-ID: <60d2cb30.lLec5fP8+jTkGYcf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.06.18a
branch HEAD: a288792a3fd9056c638a9ca8376dfa1de1f9d76b  EXP clocksource: Forgive repeated long-latency watchdog clocksource reads

elapsed time: 720m

configs tested: 142
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            lart_defconfig
powerpc                        fsp2_defconfig
sparc64                             defconfig
mips                         mpc30x_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   motionpro_defconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                    gamecube_defconfig
sh                           se7705_defconfig
powerpc                  mpc866_ads_defconfig
mips                     cu1830-neo_defconfig
powerpc                      acadia_defconfig
arc                     nsimosci_hs_defconfig
arm                         cm_x300_defconfig
sh                   secureedge5410_defconfig
mips                  decstation_64_defconfig
powerpc                     stx_gp3_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         hackkit_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
arm                       netwinder_defconfig
sh                          polaris_defconfig
m68k                         apollo_defconfig
powerpc                      katmai_defconfig
h8300                            alldefconfig
um                           x86_64_defconfig
sh                          r7785rp_defconfig
mips                      bmips_stb_defconfig
sh                        edosk7705_defconfig
mips                   sb1250_swarm_defconfig
sh                          kfr2r09_defconfig
powerpc                      pcm030_defconfig
arm                           sama5_defconfig
arm                       cns3420vb_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                 kfr2r09-romimage_defconfig
sh                           se7724_defconfig
m68k                          atari_defconfig
powerpc                     tqm8555_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         axm55xx_defconfig
arm                         lpc18xx_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     tqm8560_defconfig
openrisc                 simple_smp_defconfig
m68k                        mvme16x_defconfig
arm                        realview_defconfig
s390                             allmodconfig
riscv                               defconfig
um                            kunit_defconfig
sh                                  defconfig
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
powerpc                     kmeter1_defconfig
microblaze                          defconfig
arm                         orion5x_defconfig
powerpc                    sam440ep_defconfig
arm                        shmobile_defconfig
sh                            titan_defconfig
mips                            gpr_defconfig
h8300                               defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
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
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210623
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
