Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32AC44087A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Oct 2021 13:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbhJ3LRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Oct 2021 07:17:03 -0400
Received: from mga17.intel.com ([192.55.52.151]:45470 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231792AbhJ3LRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Oct 2021 07:17:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10152"; a="211582901"
X-IronPort-AV: E=Sophos;i="5.87,195,1631602800"; 
   d="scan'208";a="211582901"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2021 04:14:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,195,1631602800"; 
   d="scan'208";a="448411037"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 30 Oct 2021 04:14:29 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mgmJg-0001JG-RE; Sat, 30 Oct 2021 11:14:28 +0000
Date:   Sat, 30 Oct 2021 19:14:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/fpu] BUILD SUCCESS
 d7a9590f608dbedd917eb0857a074accdf0d3919
Message-ID: <617d2907.3sin0roOPVbBw243%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/fpu
branch HEAD: d7a9590f608dbedd917eb0857a074accdf0d3919  Documentation/x86: Add documentation for using dynamic XSTATE features

elapsed time: 2763m

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
powerpc              randconfig-c003-20211028
i386                 randconfig-c001-20211028
arm                    vt8500_v6_v7_defconfig
mips                           xway_defconfig
parisc                generic-64bit_defconfig
powerpc                     pseries_defconfig
arm                          ixp4xx_defconfig
arm                        trizeps4_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
arm                            pleb_defconfig
openrisc                    or1ksim_defconfig
arm                     davinci_all_defconfig
arm                       aspeed_g5_defconfig
arm                           omap1_defconfig
arm                          lpd270_defconfig
mips                         rt305x_defconfig
mips                         tb0219_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                  randconfig-c002-20211028
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
arc                              allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20211028
i386                 randconfig-a003-20211028
i386                 randconfig-a002-20211028
i386                 randconfig-a006-20211028
i386                 randconfig-a001-20211028
i386                 randconfig-a005-20211028
i386                 randconfig-a012-20211029
i386                 randconfig-a013-20211029
i386                 randconfig-a011-20211029
i386                 randconfig-a015-20211029
i386                 randconfig-a016-20211029
i386                 randconfig-a014-20211029
x86_64               randconfig-a002-20211028
x86_64               randconfig-a004-20211028
x86_64               randconfig-a005-20211028
x86_64               randconfig-a001-20211028
x86_64               randconfig-a006-20211028
x86_64               randconfig-a003-20211028
arc                  randconfig-r043-20211028
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20211028
powerpc              randconfig-c003-20211028
riscv                randconfig-c006-20211028
x86_64               randconfig-c007-20211028
mips                 randconfig-c004-20211028
s390                 randconfig-c005-20211028
i386                 randconfig-c001-20211028
x86_64               randconfig-a015-20211028
x86_64               randconfig-a013-20211028
x86_64               randconfig-a011-20211028
x86_64               randconfig-a014-20211028
x86_64               randconfig-a012-20211028
x86_64               randconfig-a016-20211028
i386                 randconfig-a012-20211028
i386                 randconfig-a013-20211028
i386                 randconfig-a011-20211028
i386                 randconfig-a015-20211028
i386                 randconfig-a016-20211028
i386                 randconfig-a014-20211028
hexagon              randconfig-r045-20211028
riscv                randconfig-r042-20211028
s390                 randconfig-r044-20211028
hexagon              randconfig-r041-20211028
hexagon              randconfig-r045-20211029
hexagon              randconfig-r041-20211029

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
