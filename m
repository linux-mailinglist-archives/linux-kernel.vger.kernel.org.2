Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3BF30951A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jan 2021 13:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbhA3Mb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 07:31:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:13635 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230472AbhA3Mb6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 07:31:58 -0500
IronPort-SDR: EkprbKvISGqR8OoLLtlC/poYXs9SWh4bdSZmnZsKwKF5ycD5Q8yehTHCO2Fl2t0C0piLN/6sEa
 LJHeoLqI0niQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="180602533"
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="180602533"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2021 04:31:17 -0800
IronPort-SDR: LmvTDQbINXHGNRRVUEAt5nkG3kAQNTyd8hPrzhMuJcRq8LIK4bljd6VngxmZadK1PVCQE6qMqg
 tmgmaaqCWUEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,388,1602572400"; 
   d="scan'208";a="389850914"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Jan 2021 04:31:16 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5pPH-0004r7-Di; Sat, 30 Jan 2021 12:31:15 +0000
Date:   Sat, 30 Jan 2021 20:30:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 4c457e8cb75eda91906a4f89fc39bde3f9a43922
Message-ID: <6015517e.mRvKZ3ulOQHS44/z%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: 4c457e8cb75eda91906a4f89fc39bde3f9a43922  genirq/msi: Activate Multi-MSI early when MSI_FLAG_ACTIVATE_EARLY is set

elapsed time: 725m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
sh                          sdk7786_defconfig
mips                          malta_defconfig
mips                           ip22_defconfig
powerpc                      chrp32_defconfig
sh                           se7206_defconfig
sh                         ap325rxa_defconfig
arm64                            alldefconfig
openrisc                 simple_smp_defconfig
sh                           se7721_defconfig
arm                         shannon_defconfig
mips                      pistachio_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
xtensa                         virt_defconfig
powerpc                    amigaone_defconfig
mips                      pic32mzda_defconfig
powerpc                     asp8347_defconfig
sh                   sh7770_generic_defconfig
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
i386                 randconfig-a005-20210130
i386                 randconfig-a003-20210130
i386                 randconfig-a002-20210130
i386                 randconfig-a001-20210130
i386                 randconfig-a004-20210130
i386                 randconfig-a006-20210130
i386                 randconfig-a013-20210130
i386                 randconfig-a011-20210130
i386                 randconfig-a015-20210130
i386                 randconfig-a012-20210130
i386                 randconfig-a014-20210130
i386                 randconfig-a016-20210130
x86_64               randconfig-a004-20210130
x86_64               randconfig-a002-20210130
x86_64               randconfig-a001-20210130
x86_64               randconfig-a005-20210130
x86_64               randconfig-a006-20210130
x86_64               randconfig-a003-20210130
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210130
x86_64               randconfig-a011-20210130
x86_64               randconfig-a014-20210130
x86_64               randconfig-a016-20210130
x86_64               randconfig-a012-20210130
x86_64               randconfig-a013-20210130

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
