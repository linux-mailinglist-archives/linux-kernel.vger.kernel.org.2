Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC845FE39
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 12:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbhK0LRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 06:17:05 -0500
Received: from mga14.intel.com ([192.55.52.115]:13507 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhK0LPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 06:15:03 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="235993290"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="235993290"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 03:11:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="476124573"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 27 Nov 2021 03:11:47 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqvcR-0009PG-1Z; Sat, 27 Nov 2021 11:11:47 +0000
Date:   Sat, 27 Nov 2021 19:10:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:for-next/kspp-misc-fixes] BUILD REGRESSION
 004a9cea9666ecd470e442ef776a22d24870bba9
Message-ID: <61a2123c.n6SXgGuWh677wnnm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/kspp-misc-fixes
branch HEAD: 004a9cea9666ecd470e442ef776a22d24870bba9  treewide: Replace zero-length arrays with flexible-array members

Error/Warning reports:

https://lore.kernel.org/lkml/202111260100.ucJw3jNQ-lkp@intel.com

Error/Warning in current branch:

sound/soc/sof/topology.c:2230:26: error: invalid use of flexible array member
sound/soc/sof/topology.c:2230:47: error: invalid use of flexible array member

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r012-20211126
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- arc-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- arm-allmodconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- arm-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- arm64-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- i386-randconfig-a015-20211126
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- ia64-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- mips-allmodconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- mips-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- parisc-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- powerpc-allmodconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- powerpc-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- s390-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- sh-allmodconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
|-- sparc-allyesconfig
|   `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member
`-- x86_64-allyesconfig
    `-- sound-soc-sof-topology.c:error:invalid-use-of-flexible-array-member

elapsed time: 3616m

configs tested: 72
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211126
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20211126
x86_64               randconfig-a011-20211126
x86_64               randconfig-a012-20211126
x86_64               randconfig-a013-20211126
x86_64               randconfig-a015-20211126
x86_64               randconfig-a016-20211126
i386                 randconfig-a012-20211126
i386                 randconfig-a013-20211126
i386                 randconfig-a014-20211126
i386                 randconfig-a011-20211126
i386                 randconfig-a015-20211126
i386                 randconfig-a016-20211126
arc                  randconfig-r043-20211126
s390                 randconfig-r044-20211126
riscv                randconfig-r042-20211126
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
hexagon              randconfig-r045-20211126
hexagon              randconfig-r041-20211126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
