Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFA5E35B0FD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 02:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhDKAnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 20:43:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:48478 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhDKAnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 20:43:02 -0400
IronPort-SDR: 1FdiwtPS6ftV4etANOg9oqdu89ZRe0qQEL799X5En+gSClVBkrtlyn2rukpbZuQtJesCR7APbt
 6XFrPxAMnlfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="255295931"
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="255295931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 17:42:47 -0700
IronPort-SDR: jrsmXO0Ybwe2svdScgu7AumGsA6FD5gFkeCjeBSObMi5BBlxlqIb7DRXLQepI6GGRIUFwTBM8D
 isqjx2r7Nqgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="423264015"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 10 Apr 2021 17:42:45 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVOBZ-000IkK-1R; Sun, 11 Apr 2021 00:42:45 +0000
Date:   Sun, 11 Apr 2021 08:42:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 0d6c8e1e246586b81cb4e6ab1a93a6d4a08a0cf9
Message-ID: <607245ee.XT6AZ54wXCumTwQC%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 0d6c8e1e246586b81cb4e6ab1a93a6d4a08a0cf9  x86/platform/intel/quark: Fix incorrect kernel-doc comment syntax in files

elapsed time: 724m

configs tested: 143
configs skipped: 50

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
powerpc                    klondike_defconfig
mips                           rs90_defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
arm                     am200epdkit_defconfig
mips                            ar7_defconfig
arm                           spitz_defconfig
m68k                        mvme147_defconfig
xtensa                          iss_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      tqm8xx_defconfig
s390                          debug_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
nios2                               defconfig
sh                          kfr2r09_defconfig
m68k                          sun3x_defconfig
arm                             pxa_defconfig
arc                                 defconfig
powerpc                      walnut_defconfig
mips                      loongson3_defconfig
mips                       lemote2f_defconfig
mips                         tb0219_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
mips                           jazz_defconfig
openrisc                            defconfig
sh                               alldefconfig
mips                     loongson1b_defconfig
arm                            pleb_defconfig
arm                          collie_defconfig
powerpc                 mpc837x_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210411
x86_64               randconfig-a002-20210411
x86_64               randconfig-a001-20210411
x86_64               randconfig-a005-20210411
x86_64               randconfig-a006-20210411
x86_64               randconfig-a004-20210411
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
i386                 randconfig-a003-20210411
i386                 randconfig-a001-20210411
i386                 randconfig-a006-20210411
i386                 randconfig-a005-20210411
i386                 randconfig-a004-20210411
i386                 randconfig-a002-20210411
x86_64               randconfig-a014-20210410
x86_64               randconfig-a015-20210410
x86_64               randconfig-a011-20210410
x86_64               randconfig-a013-20210410
x86_64               randconfig-a012-20210410
x86_64               randconfig-a016-20210410
i386                 randconfig-a015-20210411
i386                 randconfig-a014-20210411
i386                 randconfig-a013-20210411
i386                 randconfig-a012-20210411
i386                 randconfig-a016-20210411
i386                 randconfig-a011-20210411
i386                 randconfig-a015-20210410
i386                 randconfig-a014-20210410
i386                 randconfig-a013-20210410
i386                 randconfig-a012-20210410
i386                 randconfig-a016-20210410
i386                 randconfig-a011-20210410
i386                 randconfig-a014-20210409
i386                 randconfig-a011-20210409
i386                 randconfig-a016-20210409
i386                 randconfig-a012-20210409
i386                 randconfig-a013-20210409
i386                 randconfig-a015-20210409
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210410
x86_64               randconfig-a002-20210410
x86_64               randconfig-a001-20210410
x86_64               randconfig-a005-20210410
x86_64               randconfig-a006-20210410
x86_64               randconfig-a004-20210410
x86_64               randconfig-a014-20210411
x86_64               randconfig-a015-20210411
x86_64               randconfig-a011-20210411
x86_64               randconfig-a013-20210411
x86_64               randconfig-a012-20210411
x86_64               randconfig-a016-20210411

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
