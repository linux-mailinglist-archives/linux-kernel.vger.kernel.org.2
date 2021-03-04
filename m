Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85232DC7D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 22:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbhCDVpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 16:45:46 -0500
Received: from mga04.intel.com ([192.55.52.120]:50837 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241218AbhCDVp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 16:45:29 -0500
IronPort-SDR: ll+nHVlZeLAN3s4VIw7lYvZZ81kWrTRSKI/PnBvA746hiQR+6dulqEO6ciDS6MpfTV7hP/TSTG
 K5f6WL8xx0wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="185105083"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="185105083"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 13:44:51 -0800
IronPort-SDR: pDk7Qwk0zFoT0rXCiaFa+8AjMcrtnIiPgU15soQdDy6jGVllUVRiQN4Hxjfs5+ELlULxRo0wIQ
 sQfqNR+jKfLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="445897311"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Mar 2021 13:44:49 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHvm5-0002QE-3n; Thu, 04 Mar 2021 21:44:49 +0000
Date:   Fri, 05 Mar 2021 05:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 e6560d58334ca463061ade733674abc8dd0df9bd
Message-ID: <604154a0.M1x7ebD+6G/NhdiE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: e6560d58334ca463061ade733674abc8dd0df9bd  psi: Optimize task switch inside shared cgroups

elapsed time: 721m

configs tested: 116
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             pxa_defconfig
xtensa                         virt_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                        icon_defconfig
mips                malta_kvm_guest_defconfig
arm                          badge4_defconfig
arm                            mps2_defconfig
arm                        multi_v7_defconfig
mips                      maltaaprp_defconfig
arc                          axs103_defconfig
powerpc                     ep8248e_defconfig
mips                      bmips_stb_defconfig
alpha                               defconfig
arm                        multi_v5_defconfig
mips                        vocore2_defconfig
sh                           se7780_defconfig
arm                         hackkit_defconfig
um                             i386_defconfig
mips                        maltaup_defconfig
powerpc                     sequoia_defconfig
arm                             ezx_defconfig
arm                         s3c2410_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                      malta_kvm_defconfig
m68k                         amcore_defconfig
arm                          ep93xx_defconfig
powerpc                      pmac32_defconfig
microblaze                          defconfig
mips                      fuloong2e_defconfig
m68k                       m5208evb_defconfig
powerpc                       ebony_defconfig
sh                            titan_defconfig
mips                     loongson1c_defconfig
riscv                            allmodconfig
powerpc                     akebono_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      pasemi_defconfig
powerpc64                           defconfig
powerpc                      bamboo_defconfig
powerpc                     mpc83xx_defconfig
ia64                                defconfig
powerpc                      chrp32_defconfig
xtensa                generic_kc705_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
