Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E9E308328
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 02:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhA2BUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 20:20:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:10699 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231796AbhA2BUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 20:20:25 -0500
IronPort-SDR: 6QedntRXxZyp332fFjdiYh234xxV2xJZhPyxYadAnwNX1Peh3HsPcwDQtcYGmeJB7CpQ0I4jfx
 yXlxwDSCfLZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9878"; a="265176110"
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="265176110"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 17:19:44 -0800
IronPort-SDR: 6Ag+m2lLd1ee8MeqQ8u48iKMnsZ/PMuYVlKqajzs9cZJ7woupl3oMjj9O6ecqhhIw9BgOOvtLl
 56fkOPBfunhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,384,1602572400"; 
   d="scan'208";a="364076620"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jan 2021 17:19:43 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5IRq-0003Fe-Ec; Fri, 29 Jan 2021 01:19:42 +0000
Date:   Fri, 29 Jan 2021 09:18:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/urgent] BUILD SUCCESS
 41c1a06d1d1544bed9692ba72a5692454eee1945
Message-ID: <60136280.JD1r27CQJ72FlhgR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
branch HEAD: 41c1a06d1d1544bed9692ba72a5692454eee1945  entry: Unbreak single step reporting behaviour

elapsed time: 720m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
powerpc                   bluestone_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
sh                           se7724_defconfig
mips                malta_qemu_32r6_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
mips                         mpc30x_defconfig
riscv                               defconfig
arc                     nsimosci_hs_defconfig
c6x                        evmc6474_defconfig
sh                         apsh4a3a_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
arm                        clps711x_defconfig
arm                            qcom_defconfig
mips                      malta_kvm_defconfig
arm                        vexpress_defconfig
sh                          kfr2r09_defconfig
ia64                                defconfig
powerpc                 mpc837x_mds_defconfig
mips                      maltasmvp_defconfig
arm                          simpad_defconfig
sh                          sdk7780_defconfig
sh                   secureedge5410_defconfig
arc                              alldefconfig
mips                   sb1250_swarm_defconfig
mips                  cavium_octeon_defconfig
sparc                            allyesconfig
powerpc                  storcenter_defconfig
x86_64                              defconfig
m68k                                defconfig
arm                         socfpga_defconfig
nios2                            allyesconfig
arm                        keystone_defconfig
arm                        magician_defconfig
mips                       bmips_be_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
