Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABB132229B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 00:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhBVXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 18:23:05 -0500
Received: from mga07.intel.com ([134.134.136.100]:25817 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230088AbhBVXXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 18:23:02 -0500
IronPort-SDR: pK1rxDb3BFTbH+nZzZfi6YtpROxTCREv1+4GDReOVCz8bK9fA0sTgyGNQXgrxO9nyse4ZZptjo
 Akdxdo03Ddcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="248685483"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="248685483"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 15:22:21 -0800
IronPort-SDR: mcwdq6bspd+njOJ7ALjETDr2mXSczKXOZuX3JVSJfTGd4Urj0qhyCysj5wJBj3zNJ/ZzkBCziL
 WT/nONNFIGGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="596170233"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Feb 2021 15:22:19 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEKWx-0000id-1K; Mon, 22 Feb 2021 23:22:19 +0000
Date:   Tue, 23 Feb 2021 07:22:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 8acb54abc1db4e1e3913359e4108e04e88ce4d92
Message-ID: <60343c98.w5UON2EbFXW2Z6t1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 8acb54abc1db4e1e3913359e4108e04e88ce4d92  Merge tag 'timers-v5.11-rc5' of https://git.linaro.org/people/daniel.lezcano/linux into timers/urgent

elapsed time: 725m

configs tested: 118
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      chrp32_defconfig
arm                            qcom_defconfig
arm                       netwinder_defconfig
powerpc                     mpc83xx_defconfig
sh                  sh7785lcr_32bit_defconfig
ia64                             alldefconfig
mips                           mtx1_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                        fsp2_defconfig
h8300                            alldefconfig
powerpc                        icon_defconfig
sh                           se7343_defconfig
ia64                            zx1_defconfig
arm                         shannon_defconfig
arm                        mvebu_v5_defconfig
powerpc                     kmeter1_defconfig
sh                         ecovec24_defconfig
powerpc                     redwood_defconfig
sh                         apsh4a3a_defconfig
powerpc                      ppc44x_defconfig
sh                          polaris_defconfig
powerpc                          g5_defconfig
mips                          malta_defconfig
arc                        nsim_700_defconfig
arm                           spitz_defconfig
m68k                           sun3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     akebono_defconfig
mips                            ar7_defconfig
sparc                       sparc32_defconfig
ia64                      gensparse_defconfig
powerpc                     ppa8548_defconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
mips                         tb0219_defconfig
arm                        keystone_defconfig
powerpc                      makalu_defconfig
arm                        realview_defconfig
powerpc                     taishan_defconfig
arm                          pxa168_defconfig
arm                          simpad_defconfig
mips                           ci20_defconfig
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
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a016-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
