Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D159041D38A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348315AbhI3Gkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:40:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:14887 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348079AbhI3Gkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:40:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="310660712"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="310660712"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 23:38:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="539307050"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2021 23:38:48 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVpiR-0003xO-Ve; Thu, 30 Sep 2021 06:38:47 +0000
Date:   Thu, 30 Sep 2021 14:38:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 d4bfebd9ef497ee0afb498f6028a5074a6ccf307
Message-ID: <61555b63.MGXQ5prV6mI3dw+D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: d4bfebd9ef497ee0afb498f6028a5074a6ccf307  Merge remote-tracking branch 'tip/x86/cpu' into tip-master

elapsed time: 726m

configs tested: 108
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20210929
arm                      pxa255-idp_defconfig
arm                         lpc32xx_defconfig
arm                         socfpga_defconfig
arc                         haps_hs_defconfig
powerpc                      arches_defconfig
powerpc                     asp8347_defconfig
arm                      integrator_defconfig
arm                         lpc18xx_defconfig
powerpc                       ebony_defconfig
mips                            ar7_defconfig
mips                        bcm47xx_defconfig
mips                     loongson2k_defconfig
arc                                 defconfig
sh                        sh7763rdp_defconfig
powerpc                     ksi8560_defconfig
parisc                           allyesconfig
arm                         shannon_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                           h5000_defconfig
powerpc                        cell_defconfig
powerpc                      pmac32_defconfig
mips                         cobalt_defconfig
x86_64               randconfig-c001-20210929
arm                  randconfig-c002-20210929
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                              defconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210929
x86_64               randconfig-a005-20210929
x86_64               randconfig-a001-20210929
x86_64               randconfig-a006-20210929
x86_64               randconfig-a003-20210929
x86_64               randconfig-a004-20210929
i386                 randconfig-a001-20210929
i386                 randconfig-a005-20210929
i386                 randconfig-a002-20210929
i386                 randconfig-a006-20210929
i386                 randconfig-a004-20210929
i386                 randconfig-a003-20210929
arc                  randconfig-r043-20210929
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
powerpc              randconfig-c003-20210929
mips                 randconfig-c004-20210929
arm                  randconfig-c002-20210929
x86_64               randconfig-c007-20210929
riscv                randconfig-c006-20210929
s390                 randconfig-c005-20210929
i386                 randconfig-c001-20210929
x86_64               randconfig-a014-20210929
x86_64               randconfig-a011-20210929
x86_64               randconfig-a013-20210929
x86_64               randconfig-a015-20210929
x86_64               randconfig-a012-20210929
x86_64               randconfig-a016-20210929
i386                 randconfig-a014-20210929
i386                 randconfig-a013-20210929
i386                 randconfig-a016-20210929
i386                 randconfig-a011-20210929
i386                 randconfig-a015-20210929
i386                 randconfig-a012-20210929
hexagon              randconfig-r045-20210929
riscv                randconfig-r042-20210929
hexagon              randconfig-r041-20210929
s390                 randconfig-r044-20210929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
