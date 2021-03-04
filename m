Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED83B32CCCC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhCDGYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:24:01 -0500
Received: from mga06.intel.com ([134.134.136.31]:7746 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235148AbhCDGXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:23:46 -0500
IronPort-SDR: FiRnWB+1BvQa5yt69i/Iiy4unKcwRrNYTuB/Dt09H/53+ZFDKigsPoLrrHt3vUkhnZp1Mm+pc8
 L+/nEBx7qmCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="248750351"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="248750351"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 22:23:05 -0800
IronPort-SDR: q4dO7eG/ozSMZdvigmiqvcVR6wXxn/ook95LGOEL3un8xxi13uLXFKB6nuCt4nB1wMygfbWKJV
 BO8Pyo0RLzQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="518545252"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 03 Mar 2021 22:23:04 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHhO3-00023i-TA; Thu, 04 Mar 2021 06:23:03 +0000
Date:   Thu, 04 Mar 2021 14:22:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:tglx-pc.2021.03.03a] BUILD SUCCESS
 614745c470c1cc6c2becaec5d0b4435f83dc3c99
Message-ID: <60407c95.7KjXxapd44S3uh71%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tglx-pc.2021.03.03a
branch HEAD: 614745c470c1cc6c2becaec5d0b4435f83dc3c99  rcu/tree: Allocate a page when caller is preemptible

elapsed time: 725m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                  colibri_pxa300_defconfig
mips                          malta_defconfig
h8300                               defconfig
ia64                      gensparse_defconfig
powerpc                      pmac32_defconfig
arc                          axs103_defconfig
arm                        clps711x_defconfig
m68k                       m5249evb_defconfig
powerpc                       holly_defconfig
arm                        mini2440_defconfig
arm                        vexpress_defconfig
mips                     cu1830-neo_defconfig
powerpc                     tqm5200_defconfig
mips                          rm200_defconfig
arm64                            alldefconfig
arm                        oxnas_v6_defconfig
mips                  cavium_octeon_defconfig
mips                            ar7_defconfig
arm                        realview_defconfig
powerpc                      ppc64e_defconfig
powerpc                      ppc44x_defconfig
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
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
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
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
