Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54A3718F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbhECQL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:11:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:53858 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231219AbhECQLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:11:24 -0400
IronPort-SDR: eNy0nRYiFK35XvxwxaxNtGDwYVqoyDSU0MxZnvrJnap6HHBUJCjj0MdyZf63s5hK9lC1Z+UcnR
 5dU+bstA3UmA==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194633520"
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="194633520"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 09:10:30 -0700
IronPort-SDR: 99oSt393+cu6Pj5tJ8FFNtfhBJsDQWeoY05r9eWQ84ecMun30NzwSQLqzns5tmIguro9eDuUyI
 GMpr5abvXppg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,270,1613462400"; 
   d="scan'208";a="432812163"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 May 2021 09:10:28 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ldb9Q-0009HS-5g; Mon, 03 May 2021 16:10:28 +0000
Date:   Tue, 04 May 2021 00:09:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.30b] BUILD SUCCESS
 0567e4c5c89daa50062599b0d8e91c4df4af734e
Message-ID: <60902041.9zwm1UozovT+Q/Ka%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.30b
branch HEAD: 0567e4c5c89daa50062599b0d8e91c4df4af734e  squash! rcu: Improve comments describing RCU read-side critical sections

elapsed time: 721m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arc                        vdk_hs38_defconfig
mips                         db1xxx_defconfig
arm                           spitz_defconfig
mips                        vocore2_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                      gensparse_defconfig
m68k                                defconfig
m68k                          amiga_defconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
sparc64                          alldefconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                      pasemi_defconfig
sh                               j2_defconfig
mips                           ip32_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         nhk8815_defconfig
sh                          r7785rp_defconfig
powerpc                         wii_defconfig
powerpc                 canyonlands_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       aspeed_g4_defconfig
s390                          debug_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     asp8347_defconfig
powerpc                     ksi8560_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210503
i386                 randconfig-a006-20210503
i386                 randconfig-a001-20210503
i386                 randconfig-a005-20210503
i386                 randconfig-a004-20210503
i386                 randconfig-a002-20210503
x86_64               randconfig-a001-20210503
x86_64               randconfig-a005-20210503
x86_64               randconfig-a003-20210503
x86_64               randconfig-a002-20210503
x86_64               randconfig-a006-20210503
x86_64               randconfig-a004-20210503
i386                 randconfig-a013-20210503
i386                 randconfig-a015-20210503
i386                 randconfig-a016-20210503
i386                 randconfig-a014-20210503
i386                 randconfig-a011-20210503
i386                 randconfig-a012-20210503
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210503
x86_64               randconfig-a015-20210503
x86_64               randconfig-a012-20210503
x86_64               randconfig-a011-20210503
x86_64               randconfig-a013-20210503
x86_64               randconfig-a016-20210503

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
