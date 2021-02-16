Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE5FC31C5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 04:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBPD0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 22:26:10 -0500
Received: from mga03.intel.com ([134.134.136.65]:54509 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBPD0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 22:26:08 -0500
IronPort-SDR: oc5Zb1PiWJUvGdTGnyfYTju/zJUt3ab+SNK3VEw4OraZkdYqyhH31D2BrvlrpoSHV5wUmkfoQp
 zNs2HxzbWK1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9896"; a="182872310"
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400"; 
   d="scan'208";a="182872310"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2021 19:25:23 -0800
IronPort-SDR: 5hw5SE5dRL0pVGUnQPQKiqn8rb1QKCQbfNFgR3CiIfPemGADTDjuPfGm8TuFVPSJuzy4D8IafK
 Z5O289L3LomQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,182,1610438400"; 
   d="scan'208";a="438770554"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2021 19:25:22 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lBqzJ-0007p5-Eg; Tue, 16 Feb 2021 03:25:21 +0000
Date:   Tue, 16 Feb 2021 11:24:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 0b6d70e571a1c764ab079e5c31d4156feee4b06b
Message-ID: <602b3ae5.BU2Fa3HfBUsv62sQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 0b6d70e571a1c764ab079e5c31d4156feee4b06b  Merge tag 'irqchip-5.12' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 722m

configs tested: 120
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     eseries_pxa_defconfig
sparc                            alldefconfig
powerpc                      ppc6xx_defconfig
sh                      rts7751r2d1_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                       capcella_defconfig
mips                             allmodconfig
sh                           se7619_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                       holly_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc836x_mds_defconfig
arm                    vt8500_v6_v7_defconfig
nios2                         3c120_defconfig
arm                         bcm2835_defconfig
m68k                            q40_defconfig
nds32                             allnoconfig
mips                    maltaup_xpa_defconfig
sh                        sh7763rdp_defconfig
arm                           stm32_defconfig
riscv                    nommu_virt_defconfig
m68k                       m5275evb_defconfig
xtensa                       common_defconfig
powerpc                     powernv_defconfig
ia64                          tiger_defconfig
powerpc                 mpc837x_rdb_defconfig
openrisc                  or1klitex_defconfig
c6x                                 defconfig
sh                          rsk7264_defconfig
arm                      pxa255-idp_defconfig
arc                        vdk_hs38_defconfig
sh                          r7780mp_defconfig
arm                          badge4_defconfig
powerpc                     ksi8560_defconfig
riscv                    nommu_k210_defconfig
mips                           ip27_defconfig
arm                            pleb_defconfig
arm                      jornada720_defconfig
sh                           se7722_defconfig
mips                     cu1000-neo_defconfig
sh                             espt_defconfig
arm                            xcep_defconfig
powerpc                  iss476-smp_defconfig
h8300                    h8300h-sim_defconfig
arm                          lpd270_defconfig
mips                        nlm_xlp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210215
i386                 randconfig-a005-20210215
i386                 randconfig-a002-20210215
i386                 randconfig-a006-20210215
i386                 randconfig-a004-20210215
i386                 randconfig-a001-20210215
x86_64               randconfig-a016-20210215
x86_64               randconfig-a013-20210215
x86_64               randconfig-a012-20210215
x86_64               randconfig-a015-20210215
x86_64               randconfig-a014-20210215
x86_64               randconfig-a011-20210215
i386                 randconfig-a016-20210215
i386                 randconfig-a014-20210215
i386                 randconfig-a012-20210215
i386                 randconfig-a013-20210215
i386                 randconfig-a011-20210215
i386                 randconfig-a015-20210215
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210215
x86_64               randconfig-a002-20210215
x86_64               randconfig-a001-20210215
x86_64               randconfig-a004-20210215
x86_64               randconfig-a005-20210215
x86_64               randconfig-a006-20210215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
