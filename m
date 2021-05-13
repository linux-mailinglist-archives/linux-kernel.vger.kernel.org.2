Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FF237F438
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 10:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhEMIgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 04:36:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:36780 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231939AbhEMIgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 04:36:22 -0400
IronPort-SDR: vl/G8WVSiMhaaO7V9mKhgypj2oIcXJbzsJSss+JLqmHyb2yueHaUGLfDMOihlw+RUfiKtWwx+a
 mBiWd0yHpkZg==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="199582134"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="199582134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 01:35:12 -0700
IronPort-SDR: IlXJcZXPJBvKTc2D7fwLM8tMiEVwpDvu4Z8Ivwe7y/BMWy3laMroCZ1N9hQHyvw1doHI3ab7vd
 AvIdXE7I7oSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="437577360"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 13 May 2021 01:35:11 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lh6oI-00009W-Th; Thu, 13 May 2021 08:35:10 +0000
Date:   Thu, 13 May 2021 16:34:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 a554e740b66a83c7560b30e6b50bece37555ced3
Message-ID: <609ce4a7.qt1hEUgCoUguNJi1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: a554e740b66a83c7560b30e6b50bece37555ced3  x86/boot/compressed: Enable -Wundef

elapsed time: 726m

configs tested: 109
configs skipped: 93

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v6_v7_defconfig
mips                          rm200_defconfig
riscv                             allnoconfig
mips                         tb0226_defconfig
m68k                          multi_defconfig
arm                         nhk8815_defconfig
powerpc                     tqm8541_defconfig
powerpc                    socrates_defconfig
mips                       rbtx49xx_defconfig
xtensa                generic_kc705_defconfig
arc                     haps_hs_smp_defconfig
arm                            lart_defconfig
mips                             allyesconfig
parisc                generic-64bit_defconfig
arm                          simpad_defconfig
powerpc                       maple_defconfig
powerpc                 linkstation_defconfig
powerpc                  storcenter_defconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
powerpc                 mpc834x_itx_defconfig
arc                              allyesconfig
arm                      tct_hammer_defconfig
sh                         apsh4a3a_defconfig
mips                       bmips_be_defconfig
m68k                        mvme147_defconfig
mips                  decstation_64_defconfig
m68k                          hp300_defconfig
arm                      footbridge_defconfig
sh                         ecovec24_defconfig
i386                             alldefconfig
sh                         ap325rxa_defconfig
sh                          sdk7780_defconfig
mips                           xway_defconfig
x86_64                            allnoconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210513
i386                 randconfig-a001-20210513
i386                 randconfig-a005-20210513
i386                 randconfig-a004-20210513
i386                 randconfig-a002-20210513
i386                 randconfig-a006-20210513
x86_64               randconfig-a012-20210513
x86_64               randconfig-a015-20210513
x86_64               randconfig-a011-20210513
x86_64               randconfig-a013-20210513
x86_64               randconfig-a016-20210513
x86_64               randconfig-a014-20210513
i386                 randconfig-a016-20210513
i386                 randconfig-a014-20210513
i386                 randconfig-a011-20210513
i386                 randconfig-a015-20210513
i386                 randconfig-a012-20210513
i386                 randconfig-a013-20210513
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
x86_64               randconfig-a003-20210513
x86_64               randconfig-a004-20210513
x86_64               randconfig-a001-20210513
x86_64               randconfig-a005-20210513
x86_64               randconfig-a002-20210513
x86_64               randconfig-a006-20210513

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
