Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3593652F6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 09:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhDTHNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 03:13:12 -0400
Received: from mga06.intel.com ([134.134.136.31]:54470 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhDTHNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 03:13:10 -0400
IronPort-SDR: 5cd6EnKQJCS1Hwh1LE+w7NgB/H5t3XwbjiTAINkkhW7r+p1I2Uh2nZSL/E/0t4k1HRJW+QGaG3
 kWUVWJ4Gg5fg==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="256769166"
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="256769166"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 00:12:20 -0700
IronPort-SDR: eAI8uNPMR8KYvWnE4rWo6p/N34HKarrh7obNBamTGygsTSZpiO8pl2f7XFo/f1oAhMUKwpL1d0
 IOH5jzwQ5Rjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,236,1613462400"; 
   d="scan'208";a="400903475"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2021 00:12:19 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYkYU-0002DW-BD; Tue, 20 Apr 2021 07:12:18 +0000
Date:   Tue, 20 Apr 2021 15:11:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.18a] BUILD SUCCESS
 17f853c36ee2041e962c75dc96cca3baeb87c1aa
Message-ID: <607e7e9a.yE9WAICIeTrwSm5C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.18a
branch HEAD: 17f853c36ee2041e962c75dc96cca3baeb87c1aa  srcu: Early test SRCU polling start

elapsed time: 722m

configs tested: 133
configs skipped: 4

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
riscv                            allyesconfig
i386                             allyesconfig
powerpc                     mpc5200_defconfig
m68k                          atari_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     kmeter1_defconfig
openrisc                 simple_smp_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           xway_defconfig
sh                             espt_defconfig
sparc64                          alldefconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
nds32                             allnoconfig
mips                      pic32mzda_defconfig
sh                          rsk7203_defconfig
powerpc                 mpc8272_ads_defconfig
mips                          rb532_defconfig
sh                        edosk7705_defconfig
sh                           se7750_defconfig
sh                         apsh4a3a_defconfig
sparc                       sparc32_defconfig
um                               alldefconfig
m68k                        m5272c3_defconfig
m68k                          hp300_defconfig
m68k                       m5275evb_defconfig
mips                          ath79_defconfig
mips                   sb1250_swarm_defconfig
um                                allnoconfig
powerpc                      ep88xc_defconfig
powerpc                    socrates_defconfig
sparc                       sparc64_defconfig
arm                        magician_defconfig
m68k                            mac_defconfig
alpha                            alldefconfig
arm                            lart_defconfig
powerpc                          g5_defconfig
powerpc                      bamboo_defconfig
mips                        nlm_xlr_defconfig
arm                         hackkit_defconfig
powerpc                     ep8248e_defconfig
xtensa                       common_defconfig
h8300                               defconfig
arm                       multi_v4t_defconfig
ia64                      gensparse_defconfig
arm                        multi_v7_defconfig
arm                          imote2_defconfig
ia64                             allmodconfig
powerpc                 xes_mpc85xx_defconfig
ia64                                defconfig
powerpc                      katmai_defconfig
sh                         ecovec24_defconfig
sh                          rsk7201_defconfig
parisc                           alldefconfig
powerpc                       holly_defconfig
sh                        sh7785lcr_defconfig
m68k                          multi_defconfig
i386                                defconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
arm                          pcm027_defconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210419
x86_64               randconfig-a001-20210419
x86_64               randconfig-a005-20210419
x86_64               randconfig-a002-20210419
x86_64               randconfig-a006-20210419
x86_64               randconfig-a004-20210419
i386                 randconfig-a003-20210419
i386                 randconfig-a001-20210419
i386                 randconfig-a006-20210419
i386                 randconfig-a005-20210419
i386                 randconfig-a004-20210419
i386                 randconfig-a002-20210419
i386                 randconfig-a015-20210419
i386                 randconfig-a013-20210419
i386                 randconfig-a014-20210419
i386                 randconfig-a016-20210419
i386                 randconfig-a012-20210419
i386                 randconfig-a011-20210419
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
x86_64               randconfig-a014-20210419
x86_64               randconfig-a015-20210419
x86_64               randconfig-a013-20210419
x86_64               randconfig-a011-20210419
x86_64               randconfig-a012-20210419
x86_64               randconfig-a016-20210419

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
