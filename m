Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 688EA3B8BEE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 04:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbhGACLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 22:11:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:21276 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238610AbhGACLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 22:11:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10031"; a="208497863"
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="208497863"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2021 19:09:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,312,1616482800"; 
   d="scan'208";a="408775909"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 30 Jun 2021 19:09:16 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lym8h-000AD7-P0; Thu, 01 Jul 2021 02:09:15 +0000
Date:   Thu, 01 Jul 2021 10:08:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 60ab3ed18cf19201d65cfb960a4600e4e7b75df6
Message-ID: <60dd23a9.v3wUyAOuRjYKWizn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 60ab3ed18cf19201d65cfb960a4600e4e7b75df6  Merge branch 'core/rcu'

elapsed time: 723m

configs tested: 96
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
arm                         s5pv210_defconfig
m68k                        m5272c3_defconfig
ia64                             alldefconfig
arm                            zeus_defconfig
powerpc                       maple_defconfig
powerpc                 mpc834x_mds_defconfig
arm                          collie_defconfig
sh                           se7721_defconfig
mips                           xway_defconfig
powerpc                     sbc8548_defconfig
arc                          axs103_defconfig
sh                           se7722_defconfig
powerpc                 canyonlands_defconfig
sh                           se7619_defconfig
sh                        sh7785lcr_defconfig
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
x86_64               randconfig-a002-20210630
x86_64               randconfig-a001-20210630
x86_64               randconfig-a004-20210630
x86_64               randconfig-a005-20210630
x86_64               randconfig-a006-20210630
x86_64               randconfig-a003-20210630
i386                 randconfig-a004-20210630
i386                 randconfig-a001-20210630
i386                 randconfig-a003-20210630
i386                 randconfig-a002-20210630
i386                 randconfig-a005-20210630
i386                 randconfig-a006-20210630
i386                 randconfig-a014-20210630
i386                 randconfig-a011-20210630
i386                 randconfig-a016-20210630
i386                 randconfig-a012-20210630
i386                 randconfig-a013-20210630
i386                 randconfig-a015-20210630
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
x86_64               randconfig-b001-20210630
x86_64               randconfig-a012-20210630
x86_64               randconfig-a015-20210630
x86_64               randconfig-a016-20210630
x86_64               randconfig-a013-20210630
x86_64               randconfig-a011-20210630
x86_64               randconfig-a014-20210630

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
