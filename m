Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0705C3229AA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 12:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbhBWLtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 06:49:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:46191 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232372AbhBWLtH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 06:49:07 -0500
IronPort-SDR: VM9/Ep2sgryqy4V364hwFuUHs9GWl2dBFPU5pJkklyOmPsFsfEdfNFJBB+mNb79MJwTpAoQiKz
 KwjUo+I+b6vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="246194208"
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="246194208"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 03:48:15 -0800
IronPort-SDR: s1tSrIO3ygvUDQNVCr9UF7V/XcP3+Q986dX42sDfYBVKXkIa+ls7el/TY6OJgfx6vGFlZR57iv
 iPW1yj1AV2cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,199,1610438400"; 
   d="scan'208";a="364467111"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 23 Feb 2021 03:48:14 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEWAn-00019l-Gq; Tue, 23 Feb 2021 11:48:13 +0000
Date:   Tue, 23 Feb 2021 19:47:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.02.17a] BUILD SUCCESS
 893966962a445a0b739c4a786ecc81edc95fd216
Message-ID: <6034eb51.vdJ7UUCcKB5VFTVN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.02.17a
branch HEAD: 893966962a445a0b739c4a786ecc81edc95fd216  rcu: deprecate "all" option to rcu_nocbs=

elapsed time: 721m

configs tested: 109
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                             sh03_defconfig
powerpc                        warp_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                malta_qemu_32r6_defconfig
mips                            gpr_defconfig
m68k                          multi_defconfig
arm                         shannon_defconfig
arm                         cm_x300_defconfig
arm                             pxa_defconfig
arm                        mini2440_defconfig
mips                     decstation_defconfig
powerpc                       eiger_defconfig
m68k                        mvme147_defconfig
arm                          pxa910_defconfig
arm                        clps711x_defconfig
powerpc                      ep88xc_defconfig
powerpc                 mpc8315_rdb_defconfig
xtensa                           allyesconfig
mips                        workpad_defconfig
h8300                     edosk2674_defconfig
powerpc                    klondike_defconfig
sh                   sh7770_generic_defconfig
arm                           sunxi_defconfig
powerpc                  mpc885_ads_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5307c3_defconfig
mips                        omega2p_defconfig
powerpc                     sbc8548_defconfig
xtensa                         virt_defconfig
powerpc                      pasemi_defconfig
mips                        qi_lb60_defconfig
m68k                        stmark2_defconfig
sh                          lboxre2_defconfig
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
x86_64               randconfig-a001-20210222
x86_64               randconfig-a002-20210222
x86_64               randconfig-a003-20210222
x86_64               randconfig-a005-20210222
x86_64               randconfig-a006-20210222
x86_64               randconfig-a004-20210222
i386                 randconfig-a005-20210222
i386                 randconfig-a006-20210222
i386                 randconfig-a004-20210222
i386                 randconfig-a003-20210222
i386                 randconfig-a001-20210222
i386                 randconfig-a002-20210222
i386                 randconfig-a013-20210222
i386                 randconfig-a012-20210222
i386                 randconfig-a011-20210222
i386                 randconfig-a014-20210222
i386                 randconfig-a016-20210222
i386                 randconfig-a015-20210222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210222
x86_64               randconfig-a011-20210222
x86_64               randconfig-a012-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222
x86_64               randconfig-a016-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
