Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7368339D2A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 10:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhCMJNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 04:13:31 -0500
Received: from mga05.intel.com ([192.55.52.43]:36569 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230114AbhCMJM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 04:12:58 -0500
IronPort-SDR: BthGq5HEdJBXb3+xQrRxExb76DJXHKJrTHf5Bu3n4N4TYPUEd5sLkygkCnuaGZr09+scrPJNI0
 5CrGAur+Nq3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="273971718"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="273971718"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2021 01:12:58 -0800
IronPort-SDR: Jlv9SNzKcsuRJUS5zqNF2deYVPaYRDkrxlh22ghsEMYNMdNn3E+RbG5LUe02754PNBGDdWap8k
 TQLTfc7tw5cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="387592561"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Mar 2021 01:12:56 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lL0KN-0001wr-VK; Sat, 13 Mar 2021 09:12:55 +0000
Date:   Sat, 13 Mar 2021 17:12:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 013b16d0327a637f130c6697117f5bf78cc1d3dc
Message-ID: <604c8212.MGxNdZripYpaIMoO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 013b16d0327a637f130c6697117f5bf78cc1d3dc  Merge branch 'x86/alternatives'

elapsed time: 723m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                             pxa_defconfig
arc                 nsimosci_hs_smp_defconfig
powerpc                     pseries_defconfig
arm                        mini2440_defconfig
arm                        keystone_defconfig
sh                           se7780_defconfig
sh                   sh7724_generic_defconfig
sh                         microdev_defconfig
parisc                generic-64bit_defconfig
arm                       cns3420vb_defconfig
powerpc                      bamboo_defconfig
sh                          lboxre2_defconfig
sh                                  defconfig
powerpc64                           defconfig
arm                             mxs_defconfig
xtensa                          iss_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
sh                          kfr2r09_defconfig
arm                      tct_hammer_defconfig
powerpc                  storcenter_defconfig
microblaze                      mmu_defconfig
sh                        sh7757lcr_defconfig
parisc                              defconfig
arm                         s3c6400_defconfig
m68k                             allmodconfig
arm                      footbridge_defconfig
h8300                    h8300h-sim_defconfig
mips                           gcw0_defconfig
m68k                             alldefconfig
sh                             espt_defconfig
powerpc                       eiger_defconfig
arm                          simpad_defconfig
xtensa                  cadence_csp_defconfig
mips                        omega2p_defconfig
powerpc                       ppc64_defconfig
alpha                               defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            shmin_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
i386                 randconfig-a001-20210312
i386                 randconfig-a005-20210312
i386                 randconfig-a002-20210312
i386                 randconfig-a003-20210312
i386                 randconfig-a004-20210312
i386                 randconfig-a006-20210312
x86_64               randconfig-a011-20210312
x86_64               randconfig-a016-20210312
x86_64               randconfig-a013-20210312
x86_64               randconfig-a014-20210312
x86_64               randconfig-a015-20210312
x86_64               randconfig-a012-20210312
i386                 randconfig-a013-20210312
i386                 randconfig-a016-20210312
i386                 randconfig-a011-20210312
i386                 randconfig-a015-20210312
i386                 randconfig-a014-20210312
i386                 randconfig-a012-20210312
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
x86_64               randconfig-a006-20210312
x86_64               randconfig-a001-20210312
x86_64               randconfig-a005-20210312
x86_64               randconfig-a003-20210312
x86_64               randconfig-a002-20210312
x86_64               randconfig-a004-20210312

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
