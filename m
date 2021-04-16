Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE5D3629F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 23:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344142AbhDPVMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 17:12:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:56174 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235809AbhDPVMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:12:32 -0400
IronPort-SDR: WEHqqIz9B0n5JKoU8xlKTaw/LTbeGYH5wo+bBQOkFvJuVy7xk6yW+LI6tUvnZDTcZ3V+ns0l6J
 W53FOw+FtBWg==
X-IronPort-AV: E=McAfee;i="6200,9189,9956"; a="194671038"
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="194671038"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 14:12:00 -0700
IronPort-SDR: J3lYlTAWMnwDYYC4mSXYwE0iO1+sHk4Zz4qEGD7GhSu51FJQGhSEjST9JCJBSHngYAaJkble4O
 82obPT3s84Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,228,1613462400"; 
   d="scan'208";a="383166513"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2021 14:11:58 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXVkr-0000XZ-MQ; Fri, 16 Apr 2021 21:11:57 +0000
Date:   Sat, 17 Apr 2021 05:11:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 345774c3f039a2d1d4844bfc3deb6ba9a05c6c65
Message-ID: <6079fd98.nkvG+15WrcS7hPHz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 345774c3f039a2d1d4844bfc3deb6ba9a05c6c65  Merge branch 'linus'

elapsed time: 720m

configs tested: 120
configs skipped: 2

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
powerpc                      ep88xc_defconfig
mips                      pic32mzda_defconfig
i386                                defconfig
arm                        multi_v5_defconfig
m68k                           sun3_defconfig
sh                           se7750_defconfig
arm                            qcom_defconfig
powerpc                 xes_mpc85xx_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 mpc8560_ads_defconfig
arm                         lpc18xx_defconfig
mips                           ip27_defconfig
powerpc                 mpc8272_ads_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
sh                     magicpanelr2_defconfig
powerpc                         ps3_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                            xcep_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                           ip28_defconfig
m68k                       m5475evb_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                   sb1250_swarm_defconfig
arm                           sama5_defconfig
ia64                        generic_defconfig
csky                                defconfig
mips                           ip32_defconfig
sh                             shx3_defconfig
powerpc                     mpc512x_defconfig
nios2                            alldefconfig
powerpc                     powernv_defconfig
arm                             mxs_defconfig
powerpc                        warp_defconfig
powerpc                     kmeter1_defconfig
riscv                    nommu_k210_defconfig
arm                          gemini_defconfig
arm                      integrator_defconfig
sh                             sh03_defconfig
m68k                        mvme16x_defconfig
parisc                generic-64bit_defconfig
mips                      loongson3_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210416
i386                 randconfig-a006-20210416
i386                 randconfig-a001-20210416
i386                 randconfig-a005-20210416
i386                 randconfig-a004-20210416
i386                 randconfig-a002-20210416
x86_64               randconfig-a014-20210416
x86_64               randconfig-a015-20210416
x86_64               randconfig-a011-20210416
x86_64               randconfig-a013-20210416
x86_64               randconfig-a012-20210416
x86_64               randconfig-a016-20210416
i386                 randconfig-a015-20210416
i386                 randconfig-a014-20210416
i386                 randconfig-a013-20210416
i386                 randconfig-a012-20210416
i386                 randconfig-a016-20210416
i386                 randconfig-a011-20210416
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
x86_64               randconfig-a003-20210416
x86_64               randconfig-a002-20210416
x86_64               randconfig-a005-20210416
x86_64               randconfig-a001-20210416
x86_64               randconfig-a006-20210416
x86_64               randconfig-a004-20210416

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
