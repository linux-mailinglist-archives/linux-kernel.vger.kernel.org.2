Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023B83A34D5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFJUb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:31:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:45541 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhFJUbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:31:23 -0400
IronPort-SDR: IHN2ieIdUGlccUlMokQj7bmfzzP1aSOY0FvSc8Q5VXPIxA04fyCqkVk5iK4Fq10Qb63GneZCMT
 6pufKy2wbBTA==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="202367090"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="202367090"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 13:29:24 -0700
IronPort-SDR: U4klweG0E5XkFAdup5qQ7VH0LNiBYbH2Jbtb44RBDi8o2+v4PLyWdJZbr6MU6RFBQBcOm6BrIL
 F1+LzPvJ7fmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; 
   d="scan'208";a="620177269"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Jun 2021 13:29:23 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrRIo-0000GG-V5; Thu, 10 Jun 2021 20:29:22 +0000
Date:   Fri, 11 Jun 2021 04:28:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 538780ecf7a6742c06eb708ce64018a1d015e90d
Message-ID: <60c27604.SvBtDh/ovPJvkNG8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 538780ecf7a6742c06eb708ce64018a1d015e90d  Merge branch 'perf/urgent'

elapsed time: 724m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
arm                         lpc18xx_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          pxa910_defconfig
xtensa                  cadence_csp_defconfig
arm                        shmobile_defconfig
arc                         haps_hs_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
arm                          badge4_defconfig
arm                  colibri_pxa270_defconfig
xtensa                       common_defconfig
sh                          kfr2r09_defconfig
sh                             espt_defconfig
mips                     loongson1c_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
sh                           se7721_defconfig
powerpc                     tqm8541_defconfig
x86_64                           allyesconfig
arc                            hsdk_defconfig
powerpc                       ppc64_defconfig
arm                        neponset_defconfig
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
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210610
x86_64               randconfig-a001-20210610
x86_64               randconfig-a004-20210610
x86_64               randconfig-a003-20210610
x86_64               randconfig-a006-20210610
x86_64               randconfig-a005-20210610

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
