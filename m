Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C5E4113B5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237191AbhITLqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:46:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:61971 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhITLqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:46:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="245518746"
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="245518746"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2021 04:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,308,1624345200"; 
   d="scan'208";a="556202328"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 20 Sep 2021 04:44:34 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mSHir-0005ts-IP; Mon, 20 Sep 2021 11:44:33 +0000
Date:   Mon, 20 Sep 2021 19:44:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 02770d1d456ea7c50a266862101aa6086cc4dd47
Message-ID: <6148740b.I+Bl9ThI3Aoqgar7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 02770d1d456ea7c50a266862101aa6086cc4dd47  Merge branch 'linus'

elapsed time: 3025m

configs tested: 138
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20210918
arm                     davinci_all_defconfig
arm                       aspeed_g5_defconfig
arm                           spitz_defconfig
arm                          ixp4xx_defconfig
microblaze                          defconfig
arm                       aspeed_g4_defconfig
m68k                             alldefconfig
arm                          gemini_defconfig
powerpc                   lite5200b_defconfig
arc                            hsdk_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                      malta_kvm_defconfig
powerpc                     taishan_defconfig
mips                           ip32_defconfig
arm                        neponset_defconfig
powerpc                      pmac32_defconfig
powerpc                  mpc885_ads_defconfig
mips                          rm200_defconfig
arm                         s5pv210_defconfig
sh                           sh2007_defconfig
mips                        nlm_xlp_defconfig
mips                   sb1250_swarm_defconfig
arc                                 defconfig
sh                          kfr2r09_defconfig
arm                       cns3420vb_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     mpc83xx_defconfig
sh                          landisk_defconfig
arm                        realview_defconfig
powerpc                      makalu_defconfig
sh                        edosk7705_defconfig
arc                          axs103_defconfig
powerpc                    ge_imp3a_defconfig
sh                               alldefconfig
powerpc                   microwatt_defconfig
x86_64                              defconfig
riscv             nommu_k210_sdcard_defconfig
sh                                  defconfig
ia64                                defconfig
sh                        edosk7760_defconfig
sparc64                             defconfig
csky                                defconfig
mips                  maltasmvp_eva_defconfig
arc                           tb10x_defconfig
xtensa                           alldefconfig
powerpc                     skiroot_defconfig
arm                         hackkit_defconfig
sh                          rsk7203_defconfig
sh                          rsk7269_defconfig
powerpc                     powernv_defconfig
sh                          rsk7201_defconfig
x86_64               randconfig-c001-20210919
i386                 randconfig-c001-20210919
arm                  randconfig-c002-20210919
ia64                             allmodconfig
ia64                             allyesconfig
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
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210919
x86_64               randconfig-a004-20210919
x86_64               randconfig-a006-20210919
x86_64               randconfig-a003-20210919
x86_64               randconfig-a001-20210919
x86_64               randconfig-a005-20210919
i386                 randconfig-a004-20210919
i386                 randconfig-a005-20210919
i386                 randconfig-a002-20210919
i386                 randconfig-a006-20210919
i386                 randconfig-a001-20210919
i386                 randconfig-a003-20210919
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
riscv                randconfig-c006-20210919
x86_64               randconfig-c007-20210919
powerpc              randconfig-c003-20210919
mips                 randconfig-c004-20210919
i386                 randconfig-c001-20210919
arm                  randconfig-c002-20210919
s390                 randconfig-c005-20210919
x86_64               randconfig-a013-20210919
x86_64               randconfig-a016-20210919
x86_64               randconfig-a012-20210919
x86_64               randconfig-a011-20210919
x86_64               randconfig-a014-20210919
x86_64               randconfig-a015-20210919
i386                 randconfig-a016-20210919
i386                 randconfig-a012-20210919
i386                 randconfig-a011-20210919
i386                 randconfig-a015-20210919
i386                 randconfig-a013-20210919
i386                 randconfig-a014-20210919
hexagon              randconfig-r045-20210918
hexagon              randconfig-r041-20210918
riscv                randconfig-r042-20210919
hexagon              randconfig-r045-20210919
s390                 randconfig-r044-20210919
hexagon              randconfig-r041-20210919

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
