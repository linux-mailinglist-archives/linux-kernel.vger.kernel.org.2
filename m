Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6B337A99
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhCKRRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:17:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:27457 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhCKRRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:17:03 -0500
IronPort-SDR: L7ODGj1XuUD8yVmE9rNDIxNOB7TJKGFddnWjrYEMB1/7tJcNqCRb/voidjuNgwABwuW34L7pvb
 LTAAhbIsV41Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="185346383"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="185346383"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 09:17:03 -0800
IronPort-SDR: BpgrJKQZfNfTJVfcYHfGs8xnMDyVP/2xJJ1lrAJck4T9PRtfSzSQdTA7VKxeqApd+IW+zzk/1d
 qab61Oqq3RxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="600284986"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 11 Mar 2021 09:17:01 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKOvl-0000s7-71; Thu, 11 Mar 2021 17:17:01 +0000
Date:   Fri, 12 Mar 2021 01:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/xfs] BUILD SUCCESS
 964fe7ec8048c96191288a828dd5211734e5106c
Message-ID: <604a506b.zk30YMK7mYtRFsuG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/xfs
branch HEAD: 964fe7ec8048c96191288a828dd5211734e5106c  xfs: Replace one-element arrays with flexible-array members

elapsed time: 724m

configs tested: 92
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc836x_rdk_defconfig
sh                           se7724_defconfig
mips                        omega2p_defconfig
arm                        oxnas_v6_defconfig
parisc                           alldefconfig
mips                     cu1000-neo_defconfig
riscv                             allnoconfig
mips                       lemote2f_defconfig
mips                        workpad_defconfig
sh                           se7206_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                         apollo_defconfig
sh                           se7780_defconfig
arm                         s3c6400_defconfig
mips                       capcella_defconfig
arm                     am200epdkit_defconfig
arm                          iop32x_defconfig
arm                          lpd270_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
