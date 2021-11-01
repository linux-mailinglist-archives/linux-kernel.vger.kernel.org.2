Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23234411B4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 01:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbhKAAi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 20:38:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:60952 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhKAAi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 20:38:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="254526265"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="254526265"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2021 17:35:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="449090055"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Oct 2021 17:35:39 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mhLIY-0002tO-NJ; Mon, 01 Nov 2021 00:35:38 +0000
Date:   Mon, 01 Nov 2021 08:34:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 5989725f40fa65ac00fc0f7d884ddcfc3f8d8e99
Message-ID: <617f3621.g5P8qs/yHnEENWVB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 5989725f40fa65ac00fc0f7d884ddcfc3f8d8e99  Merge x86/core into tip/master

elapsed time: 843m

configs tested: 87
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                 kfr2r09-romimage_defconfig
mips                  maltasmvp_eva_defconfig
mips                            ar7_defconfig
mips                           ci20_defconfig
m68k                          multi_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                            allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20211031
x86_64               randconfig-a004-20211031
x86_64               randconfig-a002-20211031
x86_64               randconfig-a003-20211031
x86_64               randconfig-a001-20211031
x86_64               randconfig-a006-20211031
i386                 randconfig-a003-20211031
i386                 randconfig-a006-20211031
i386                 randconfig-a002-20211031
i386                 randconfig-a005-20211031
i386                 randconfig-a001-20211031
i386                 randconfig-a004-20211031
arc                  randconfig-r043-20211031
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20211031
x86_64               randconfig-a015-20211031
x86_64               randconfig-a014-20211031
x86_64               randconfig-a011-20211031
x86_64               randconfig-a016-20211031
x86_64               randconfig-a012-20211031
i386                 randconfig-a013-20211031
i386                 randconfig-a012-20211031
i386                 randconfig-a014-20211031
i386                 randconfig-a015-20211031
i386                 randconfig-a011-20211031
i386                 randconfig-a016-20211031
riscv                randconfig-r042-20211031
s390                 randconfig-r044-20211031
hexagon              randconfig-r045-20211031
hexagon              randconfig-r041-20211031

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
