Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F70338650
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhCLHBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:01:36 -0500
Received: from mga03.intel.com ([134.134.136.65]:12276 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231130AbhCLHBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:01:10 -0500
IronPort-SDR: wlD14YoE2/+rXRtEPnY2zvel+azwb5V5PEGkAxJNi2cQqet6WOOMm2d0TpLsjkCGPnAM0xvdZD
 kLjStSg8IcWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="188834846"
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="188834846"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 23:00:52 -0800
IronPort-SDR: fSkGb4ME4mZYjdd1gj8V3UtFmaY/PVAF8WPCmc5+hI3FlCZm8qxbEIXG+8Hh71maVymAW/XQLo
 bGUf0/xZhdDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="scan'208";a="438953467"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Mar 2021 23:00:50 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKbn0-0001DS-8G; Fri, 12 Mar 2021 07:00:50 +0000
Date:   Fri, 12 Mar 2021 15:00:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.03.08a] BUILD SUCCESS
 a7933665e0e3fad60118e141db9709d2cc1f42ed
Message-ID: <604b1175.ZBIwwk/xgcv+CnbS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.03.08a
branch HEAD: a7933665e0e3fad60118e141db9709d2cc1f42ed  refscale: Add locking, both irqsave and otherwise

elapsed time: 722m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                                 defconfig
arm                             mxs_defconfig
sh                   secureedge5410_defconfig
ia64                          tiger_defconfig
arm                           spitz_defconfig
ia64                             alldefconfig
mips                         rt305x_defconfig
arm                         mv78xx0_defconfig
arm                          exynos_defconfig
m68k                        m5272c3_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                        qi_lb60_defconfig
powerpc                     tqm8555_defconfig
openrisc                 simple_smp_defconfig
nds32                            alldefconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
riscv                               defconfig
arm                          collie_defconfig
arm                       mainstone_defconfig
powerpc                       eiger_defconfig
mips                      pistachio_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                      ep88xc_defconfig
sh                        sh7763rdp_defconfig
arm                        neponset_defconfig
arm                         s3c6400_defconfig
sh                               allmodconfig
mips                        nlm_xlr_defconfig
powerpc                    ge_imp3a_defconfig
arm                          iop32x_defconfig
sparc                       sparc32_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            qcom_defconfig
riscv                            alldefconfig
powerpc                     taishan_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                           corgi_defconfig
arm                     eseries_pxa_defconfig
mips                           rs90_defconfig
arm                        mini2440_defconfig
powerpc                     tqm8560_defconfig
powerpc                  iss476-smp_defconfig
arm                       aspeed_g4_defconfig
powerpc                     redwood_defconfig
mips                malta_qemu_32r6_defconfig
mips                           ci20_defconfig
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
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
