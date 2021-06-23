Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3245A3B16BC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 11:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhFWJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 05:24:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:31901 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229833AbhFWJYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 05:24:04 -0400
IronPort-SDR: OvSjcO7WzU5qu4TL2/gHkIaptB6K+X2cApuRhOKQUJIIAOWgFhjMFDrY/Gy8INKai8WvV3Q72s
 H6kVMxtMOh5A==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="207044154"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="207044154"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 02:21:47 -0700
IronPort-SDR: X92DU3hmIyuZ8Yh00ddYHcgKLgPy8fB0+XtBSzSUPlRmKzUzjW2AFby0ZcAlLOaNHHhPbkfoih
 OHpGe7Cj3feA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="487237206"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Jun 2021 02:21:45 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvz4q-0005qk-Vj; Wed, 23 Jun 2021 09:21:44 +0000
Date:   Wed, 23 Jun 2021 17:20:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e53fbd0a25093c4db4ca8b84c185c280e4b4ce05
Message-ID: <60d2fce8.nLzVtb2M0eVTHUOK%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e53fbd0a25093c4db4ca8b84c185c280e4b4ce05  Merge branch 'core/urgent'

elapsed time: 1109m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            lart_defconfig
powerpc                        fsp2_defconfig
sparc64                             defconfig
mips                         mpc30x_defconfig
arm                        multi_v7_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                         hackkit_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
arm                       netwinder_defconfig
h8300                     edosk2674_defconfig
sh                           se7724_defconfig
mips                       rbtx49xx_defconfig
sh                           se7343_defconfig
mips                     cu1830-neo_defconfig
powerpc                      pcm030_defconfig
arm                           sama5_defconfig
arm                       cns3420vb_defconfig
mips                   sb1250_swarm_defconfig
mips                         bigsur_defconfig
powerpc                      katmai_defconfig
mips                        nlm_xlr_defconfig
xtensa                           alldefconfig
powerpc                     ppa8548_defconfig
powerpc                    sam440ep_defconfig
arm                             rpc_defconfig
powerpc                     sequoia_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
arc                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                 randconfig-a001-20210622
i386                 randconfig-a002-20210622
i386                 randconfig-a003-20210622
i386                 randconfig-a006-20210622
i386                 randconfig-a005-20210622
i386                 randconfig-a004-20210622
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
