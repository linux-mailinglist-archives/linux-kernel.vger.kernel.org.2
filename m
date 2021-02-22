Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12B6321F20
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbhBVS05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:26:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:62827 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232518AbhBVS0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:26:52 -0500
IronPort-SDR: YE7qOfgqzVJ03jEFOYfvxL3p3rzbzKhgvjBbGF1NguSjFz2tvWLmUNneK7G86p1iN4ZKem8cIP
 scRPwmuaJemw==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="203949371"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="203949371"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 10:26:12 -0800
IronPort-SDR: 0qqxTj2v9ZB7ahCiyCkaDmxYP0H4fZ4g9DdqQO4yXaO+65NS6Xys8gCi9m7EvCSj3ITCdOqCIj
 6aUnCoWrsZLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="498667190"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Feb 2021 10:26:10 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEFuM-0000au-18; Mon, 22 Feb 2021 18:26:10 +0000
Date:   Tue, 23 Feb 2021 02:25:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 2126d722fe93be10880b3ee5c1593137ea801d06
Message-ID: <6033f720.tEeV9ZaH0d5gJf10%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 2126d722fe93be10880b3ee5c1593137ea801d06  Merge branch 'sched/smp'

elapsed time: 729m

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
mips                           mtx1_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                        fsp2_defconfig
h8300                            alldefconfig
powerpc                        icon_defconfig
powerpc                     redwood_defconfig
powerpc                    adder875_defconfig
arm                     am200epdkit_defconfig
powerpc                 canyonlands_defconfig
sh                            hp6xx_defconfig
sh                     sh7710voipgw_defconfig
sh                         apsh4a3a_defconfig
powerpc                      ppc44x_defconfig
sh                          polaris_defconfig
powerpc                          g5_defconfig
mips                          malta_defconfig
arc                        nsim_700_defconfig
alpha                            allyesconfig
sh                           se7705_defconfig
powerpc                      chrp32_defconfig
ia64                        generic_defconfig
powerpc                      bamboo_defconfig
arm                          simpad_defconfig
arc                     nsimosci_hs_defconfig
arm                       netwinder_defconfig
arm                           spitz_defconfig
m68k                           sun3_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                     mpc5200_defconfig
arm                     davinci_all_defconfig
mips                         tb0219_defconfig
arm                        keystone_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                      makalu_defconfig
powerpc                      walnut_defconfig
arm                         s3c6400_defconfig
powerpc                     ep8248e_defconfig
arm                           u8500_defconfig
sh                             shx3_defconfig
arm                            qcom_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                   lite5200b_defconfig
powerpc                      ppc6xx_defconfig
ia64                             alldefconfig
arm                            mps2_defconfig
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
x86_64               randconfig-a016-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
