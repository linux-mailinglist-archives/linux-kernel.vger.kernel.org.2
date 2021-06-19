Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAE13AD9FB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbhFSMe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:34:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:14714 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234059AbhFSMeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:34:25 -0400
IronPort-SDR: dUbTDOgFk5hTNwIrPuYuWy18VesuqK2rDRKqJ6AyryhXFLN9G4vCI+OVjUvr3Nyqtu9fROMwOG
 B9uMQ59y6G5g==
X-IronPort-AV: E=McAfee;i="6200,9189,10019"; a="267810475"
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="267810475"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2021 05:32:13 -0700
IronPort-SDR: Ob6blIaOpVQeWSdcIG+6RS0wCYbj2KjmazCdwc2D7JzKIDqpc6ZP1/r0M+he4qI3Gx4/sre2Gv
 DQWSs+9JcHiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,285,1616482800"; 
   d="scan'208";a="451692508"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Jun 2021 05:32:07 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lua8t-0003Yw-2l; Sat, 19 Jun 2021 12:32:07 +0000
Date:   Sat, 19 Jun 2021 20:31:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 185c87ee7510e3cc162dccb7cb9820cedcec27e3
Message-ID: <60cde38c.00oLfz6+WnKm4DaZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 185c87ee7510e3cc162dccb7cb9820cedcec27e3  Merge branch 'irq/urgent'

elapsed time: 1589m

configs tested: 109
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
arm                         bcm2835_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
mips                          rb532_defconfig
powerpc                     tqm8540_defconfig
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
powerpc                 mpc836x_rdk_defconfig
arm                          pxa3xx_defconfig
powerpc                      cm5200_defconfig
powerpc                        icon_defconfig
powerpc                       maple_defconfig
powerpc                      ep88xc_defconfig
sparc                            alldefconfig
sh                           sh2007_defconfig
m68k                         apollo_defconfig
sh                               j2_defconfig
riscv                            alldefconfig
arc                           tb10x_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
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
um                           x86_64_defconfig
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
