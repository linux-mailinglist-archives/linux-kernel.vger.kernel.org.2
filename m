Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28E53400B3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhCRIPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:15:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:20833 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229725AbhCRIO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:14:59 -0400
IronPort-SDR: ReOlrVBdbWkiKzWAKGQPyd24AHvTuvIRFDLoIsnO9anWD+7tSQGssSyBBmOsTJ2/texeVh8UXX
 p6SlGbvay/2g==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="189719101"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="189719101"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 01:14:58 -0700
IronPort-SDR: qmGG/f3aD28ErMB+3WiRuAuzb/S275ueo9kf28oKcS3fHkOLV3VZ9AbbMONra3x3ysW+q5tT69
 DvVGECyqHRdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="450389631"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2021 01:14:57 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMno0-000189-T0; Thu, 18 Mar 2021 08:14:56 +0000
Date:   Thu, 18 Mar 2021 16:14:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 77c781e43bc2f110ce8f73c4f81ca3d9f349ef72
Message-ID: <60530bee.dkh6iOSc3s89fa7V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 77c781e43bc2f110ce8f73c4f81ca3d9f349ef72  Merge branch 'irq/core'

elapsed time: 726m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                 mpc8540_ads_defconfig
arm                         at91_dt_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlr_defconfig
sh                              ul2_defconfig
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
m68k                       m5475evb_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
xtensa                  nommu_kc705_defconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
powerpc                     taishan_defconfig
powerpc                          allmodconfig
mips                            gpr_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
m68k                       m5249evb_defconfig
sh                            titan_defconfig
powerpc                  mpc885_ads_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa910_defconfig
arm                          simpad_defconfig
sh                             espt_defconfig
sh                   secureedge5410_defconfig
riscv                             allnoconfig
xtensa                              defconfig
arc                        nsimosci_defconfig
arm                            mmp2_defconfig
xtensa                       common_defconfig
m68k                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
