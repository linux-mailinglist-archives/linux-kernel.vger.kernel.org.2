Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0687131EA49
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 14:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhBRNJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 08:09:26 -0500
Received: from mga17.intel.com ([192.55.52.151]:10974 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231831AbhBRLjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 06:39:39 -0500
IronPort-SDR: ep0+CC3+ZY+XdOmLG5U97wTtNNzDVGmHzy1v5JwykDHAo392bCkdJYfuwLdKGNd73PpIewf1CR
 qaOVpRiWqaqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="163251585"
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="163251585"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 03:26:42 -0800
IronPort-SDR: WJ7slL6t4dXBhMwntQYhlz3JiF72zatHOV0svJYir7B4rYrHLU83JlpPcmd8OILKWtVEmNTHjl
 KF2YWpmO/WSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,187,1610438400"; 
   d="scan'208";a="581247084"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 18 Feb 2021 03:26:40 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lChSB-0009dE-QT; Thu, 18 Feb 2021 11:26:39 +0000
Date:   Thu, 18 Feb 2021 19:26:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4
Message-ID: <602e4ec9.tN4UDwUJxG/Z0Gj8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4  sched,x86: Allow !PREEMPT_DYNAMIC

elapsed time: 724m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        multi_v5_defconfig
arm                            u300_defconfig
powerpc                        icon_defconfig
mips                         db1xxx_defconfig
arm                          prima2_defconfig
arm                       cns3420vb_defconfig
ia64                         bigsur_defconfig
arm                  colibri_pxa270_defconfig
mips                           ip28_defconfig
arm                         axm55xx_defconfig
arm                            lart_defconfig
mips                       capcella_defconfig
arm                      footbridge_defconfig
powerpc                     mpc83xx_defconfig
powerpc64                           defconfig
arm                       netwinder_defconfig
sparc                       sparc64_defconfig
xtensa                  cadence_csp_defconfig
arm                       imx_v4_v5_defconfig
arm                     eseries_pxa_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
arm                           omap1_defconfig
powerpc                     sbc8548_defconfig
powerpc                        warp_defconfig
x86_64                              defconfig
m68k                           sun3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210216
i386                 randconfig-a005-20210216
i386                 randconfig-a002-20210216
i386                 randconfig-a006-20210216
i386                 randconfig-a001-20210216
i386                 randconfig-a004-20210216
x86_64               randconfig-a016-20210215
x86_64               randconfig-a013-20210215
x86_64               randconfig-a012-20210215
x86_64               randconfig-a015-20210215
x86_64               randconfig-a014-20210215
x86_64               randconfig-a011-20210215
i386                 randconfig-a016-20210217
i386                 randconfig-a014-20210217
i386                 randconfig-a012-20210217
i386                 randconfig-a013-20210217
i386                 randconfig-a011-20210217
i386                 randconfig-a015-20210217
i386                 randconfig-a016-20210216
i386                 randconfig-a014-20210216
i386                 randconfig-a012-20210216
i386                 randconfig-a013-20210216
i386                 randconfig-a011-20210216
i386                 randconfig-a015-20210216
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210216
x86_64               randconfig-a016-20210216
x86_64               randconfig-a012-20210216
x86_64               randconfig-a015-20210216
x86_64               randconfig-a014-20210216
x86_64               randconfig-a011-20210216
x86_64               randconfig-a003-20210217
x86_64               randconfig-a002-20210217
x86_64               randconfig-a004-20210217
x86_64               randconfig-a001-20210217
x86_64               randconfig-a005-20210217
x86_64               randconfig-a006-20210217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
