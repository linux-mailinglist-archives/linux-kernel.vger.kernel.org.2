Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740D636ABDA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 07:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhDZFmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 01:42:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:29378 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhDZFmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:42:51 -0400
IronPort-SDR: 0pxT7pxUXoRvKNLHCQb2G1twLL+bfhyf/V24B2yH6G4hh5oOXOmo63LDhkIKWMpB+wmPvDGSiU
 MRzSByUaEzYw==
X-IronPort-AV: E=McAfee;i="6200,9189,9965"; a="216979434"
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="216979434"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 22:42:10 -0700
IronPort-SDR: gBOqDw7/2Chzy7gwqQILvBiEHAKl1JMijeY+PVoXv0NbYYTg0U0T5r2b88E21VaVwOCKtbnN8H
 o89/d/if5lWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="604074913"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Apr 2021 22:42:09 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lau0W-0005pG-Bf; Mon, 26 Apr 2021 05:42:08 +0000
Date:   Mon, 26 Apr 2021 13:42:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.22a] BUILD SUCCESS
 d7f746e89658d446157f3dc14d3a889457ed0bf8
Message-ID: <608652a9.stPqMgUTookIPvuJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.22a
branch HEAD: d7f746e89658d446157f3dc14d3a889457ed0bf8  fixup! clocksource: Limit number of CPUs checked for clock synchronization

elapsed time: 724m

configs tested: 124
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
m68k                          hp300_defconfig
mips                           gcw0_defconfig
powerpc                      pcm030_defconfig
sparc64                          alldefconfig
arm                         vf610m4_defconfig
sh                           se7619_defconfig
sh                          r7780mp_defconfig
arm                        mvebu_v5_defconfig
powerpc                     tqm8555_defconfig
microblaze                          defconfig
mips                           ci20_defconfig
arm                          moxart_defconfig
arm                           spitz_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                    amigaone_defconfig
xtensa                          iss_defconfig
sh                             shx3_defconfig
m68k                        m5307c3_defconfig
arm                            pleb_defconfig
m68k                             allmodconfig
mips                           rs90_defconfig
sh                            shmin_defconfig
arm                          gemini_defconfig
arm                           h5000_defconfig
h8300                    h8300h-sim_defconfig
powerpc                      pasemi_defconfig
sh                   secureedge5410_defconfig
arm                          simpad_defconfig
m68k                            q40_defconfig
powerpc                     powernv_defconfig
powerpc                      katmai_defconfig
mips                            gpr_defconfig
powerpc                     tqm8560_defconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210425
x86_64               randconfig-a002-20210425
x86_64               randconfig-a001-20210425
x86_64               randconfig-a006-20210425
x86_64               randconfig-a005-20210425
x86_64               randconfig-a003-20210425
i386                 randconfig-a005-20210425
i386                 randconfig-a002-20210425
i386                 randconfig-a001-20210425
i386                 randconfig-a006-20210425
i386                 randconfig-a004-20210425
i386                 randconfig-a003-20210425
x86_64               randconfig-a015-20210426
x86_64               randconfig-a016-20210426
x86_64               randconfig-a011-20210426
x86_64               randconfig-a014-20210426
x86_64               randconfig-a012-20210426
x86_64               randconfig-a013-20210426
i386                 randconfig-a014-20210426
i386                 randconfig-a012-20210426
i386                 randconfig-a011-20210426
i386                 randconfig-a013-20210426
i386                 randconfig-a015-20210426
i386                 randconfig-a016-20210426
i386                 randconfig-a012-20210425
i386                 randconfig-a014-20210425
i386                 randconfig-a011-20210425
i386                 randconfig-a013-20210425
i386                 randconfig-a015-20210425
i386                 randconfig-a016-20210425
riscv                    nommu_k210_defconfig
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
x86_64               randconfig-a015-20210425
x86_64               randconfig-a016-20210425
x86_64               randconfig-a011-20210425
x86_64               randconfig-a014-20210425
x86_64               randconfig-a013-20210425
x86_64               randconfig-a012-20210425

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
