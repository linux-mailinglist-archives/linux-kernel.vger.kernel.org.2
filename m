Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5499B33FE2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 05:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhCREaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 00:30:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:7022 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhCRE3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 00:29:43 -0400
IronPort-SDR: 9bT6otCCt2LaMm7ZDvIJLxR2t7tnNi1Pdm6YZySVP62QdGpQcYKO5Uri6XtL1IN/BPTfoKsPYO
 G4NFlklZcigw==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="188970190"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="188970190"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2021 21:29:43 -0700
IronPort-SDR: yPUJWyUc5CMJumdOXq18QNvBB6i+qDBtTzjA77DOAHY/0oKhlcDHiXbNQz/PrjVslIUhg4rD0N
 DxAdA6fUv3YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="450338184"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Mar 2021 21:29:41 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMkI1-00011Q-73; Thu, 18 Mar 2021 04:29:41 +0000
Date:   Thu, 18 Mar 2021 12:29:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 90f093fa8ea48e5d991332cee160b761423d55c1
Message-ID: <6052d712.qkhGSNVIyXcEpdsf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: 90f093fa8ea48e5d991332cee160b761423d55c1  rseq, ptrace: Add PTRACE_GET_RSEQ_CONFIGURATION request

elapsed time: 723m

configs tested: 145
configs skipped: 2

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
i386                             allyesconfig
riscv                            allyesconfig
powerpc                 mpc8540_ads_defconfig
arm                         at91_dt_defconfig
arc                            hsdk_defconfig
mips                        nlm_xlr_defconfig
sh                              ul2_defconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
powerpc                     taishan_defconfig
mips                            gpr_defconfig
m68k                       bvme6000_defconfig
powerpc                      acadia_defconfig
arm                          pxa910_defconfig
sh                         ecovec24_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                            mmp2_defconfig
arm                         palmz72_defconfig
arm                          iop32x_defconfig
arm                        neponset_defconfig
powerpc                     kilauea_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
m68k                       m5249evb_defconfig
sh                            titan_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
m68k                        stmark2_defconfig
mips                           ip28_defconfig
powerpc                    adder875_defconfig
arm                         assabet_defconfig
arc                              alldefconfig
arm                       multi_v4t_defconfig
sh                           se7619_defconfig
arm                          moxart_defconfig
powerpc                          allyesconfig
mips                           ip32_defconfig
ia64                         bigsur_defconfig
arm                        multi_v7_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                        sh7757lcr_defconfig
arm                     eseries_pxa_defconfig
arm                            lart_defconfig
mips                      bmips_stb_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     skiroot_defconfig
sh                     sh7710voipgw_defconfig
powerpc                       ebony_defconfig
arm                      footbridge_defconfig
mips                        bcm47xx_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                         lpc18xx_defconfig
arm                         lpc32xx_defconfig
sh                          lboxre2_defconfig
sh                             espt_defconfig
sh                   secureedge5410_defconfig
parisc                           allyesconfig
arc                        nsimosci_defconfig
riscv                             allnoconfig
powerpc                    sam440ep_defconfig
arm                         bcm2835_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          ixp4xx_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
arm                     am200epdkit_defconfig
microblaze                          defconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
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
