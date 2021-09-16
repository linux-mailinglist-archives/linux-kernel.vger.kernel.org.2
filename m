Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390F240D11D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 03:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbhIPBOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 21:14:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:19350 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233429AbhIPBOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 21:14:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202618538"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="202618538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2021 18:13:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; 
   d="scan'208";a="583486084"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 15 Sep 2021 18:13:26 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mQfxt-0000by-NV; Thu, 16 Sep 2021 01:13:25 +0000
Date:   Thu, 16 Sep 2021 09:12:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:auto-latest] BUILD SUCCESS
 019a926fcae5bdab8d90d7884f73066649c2cff5
Message-ID: <61429a03.dFWOekO8JCmb6Jj4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git auto-latest
branch HEAD: 019a926fcae5bdab8d90d7884f73066649c2cff5  Merge branch 'perf/core'

elapsed time: 2374m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210914
nds32                            alldefconfig
parisc                generic-64bit_defconfig
powerpc                          g5_defconfig
mips                         mpc30x_defconfig
powerpc                      acadia_defconfig
sh                        sh7785lcr_defconfig
sh                   sh7724_generic_defconfig
sh                          kfr2r09_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
arm                           corgi_defconfig
m68k                        m5307c3_defconfig
m68k                            mac_defconfig
xtensa                          iss_defconfig
arm                     eseries_pxa_defconfig
powerpc                     redwood_defconfig
powerpc                      obs600_defconfig
powerpc                      bamboo_defconfig
m68k                       bvme6000_defconfig
arm                           sunxi_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
arm                          ixp4xx_defconfig
arm                          lpd270_defconfig
powerpc                 mpc836x_rdk_defconfig
mips                  cavium_octeon_defconfig
arm                         s5pv210_defconfig
arm                         assabet_defconfig
ia64                                defconfig
nios2                            allyesconfig
powerpc                    mvme5100_defconfig
arm                       cns3420vb_defconfig
mips                        nlm_xlr_defconfig
ia64                         bigsur_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                        icon_defconfig
x86_64               randconfig-c001-20210914
arm                  randconfig-c002-20210914
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
parisc                              defconfig
s390                                defconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a002-20210915
x86_64               randconfig-a003-20210915
x86_64               randconfig-a004-20210915
x86_64               randconfig-a006-20210915
x86_64               randconfig-a005-20210915
x86_64               randconfig-a001-20210915
i386                 randconfig-a004-20210915
i386                 randconfig-a005-20210915
i386                 randconfig-a006-20210915
i386                 randconfig-a002-20210915
i386                 randconfig-a001-20210915
i386                 randconfig-a003-20210915
x86_64               randconfig-a013-20210914
x86_64               randconfig-a016-20210914
x86_64               randconfig-a012-20210914
x86_64               randconfig-a011-20210914
x86_64               randconfig-a014-20210914
x86_64               randconfig-a015-20210914
i386                 randconfig-a016-20210914
i386                 randconfig-a015-20210914
i386                 randconfig-a011-20210914
i386                 randconfig-a012-20210914
i386                 randconfig-a013-20210914
i386                 randconfig-a014-20210914
arc                  randconfig-r043-20210915
riscv                randconfig-r042-20210914
s390                 randconfig-r044-20210914
arc                  randconfig-r043-20210914
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
riscv                randconfig-c006-20210914
x86_64               randconfig-c007-20210914
powerpc              randconfig-c003-20210914
arm                  randconfig-c002-20210914
i386                 randconfig-c001-20210914
s390                 randconfig-c005-20210914
i386                 randconfig-a004-20210914
i386                 randconfig-a005-20210914
i386                 randconfig-a006-20210914
i386                 randconfig-a002-20210914
i386                 randconfig-a001-20210914
i386                 randconfig-a003-20210914
x86_64               randconfig-a013-20210915
x86_64               randconfig-a016-20210915
x86_64               randconfig-a012-20210915
x86_64               randconfig-a011-20210915
x86_64               randconfig-a014-20210915
x86_64               randconfig-a015-20210915
i386                 randconfig-a016-20210915
i386                 randconfig-a015-20210915
i386                 randconfig-a011-20210915
i386                 randconfig-a012-20210915
i386                 randconfig-a013-20210915
i386                 randconfig-a014-20210915
hexagon              randconfig-r045-20210914
hexagon              randconfig-r041-20210914
riscv                randconfig-r042-20210915
hexagon              randconfig-r045-20210915
s390                 randconfig-r044-20210915
hexagon              randconfig-r041-20210915

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
