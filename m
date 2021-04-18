Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02C1363643
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 17:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhDRPEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 11:04:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:54332 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhDRPEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 11:04:48 -0400
IronPort-SDR: +yj6g9B5utALL/lVr29i36Db2K8126dVVRDBo7hude25PaDlx8yos6K7HccjcSQemgqDiCjY3P
 WhgMKAax3huA==
X-IronPort-AV: E=McAfee;i="6200,9189,9958"; a="174714228"
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="174714228"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2021 08:04:20 -0700
IronPort-SDR: 2WpCI9flVhLvVd22CB12UQ9rD4B6DBEexh8/8NdmFr1uClASHxMNcF4dokfOPZDGc9pTK/J/r+
 sdRuIgGSHGcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,232,1613462400"; 
   d="scan'208";a="419709887"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Apr 2021 08:04:18 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lY8yA-0001IZ-6Y; Sun, 18 Apr 2021 15:04:18 +0000
Date:   Sun, 18 Apr 2021 23:03:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.13a] BUILD SUCCESS
 431ded55d9d86084c398c33d900356a7d1587f78
Message-ID: <607c4a4a.TD+YHEi4bmWxd606%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.13a
branch HEAD: 431ded55d9d86084c398c33d900356a7d1587f78  rcu: Point to documentation of ordering guarantees

elapsed time: 723m

configs tested: 105
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
mips                         bigsur_defconfig
powerpc                    klondike_defconfig
ia64                        generic_defconfig
arc                            hsdk_defconfig
sparc64                             defconfig
powerpc                      pmac32_defconfig
powerpc                      obs600_defconfig
mips                           xway_defconfig
mips                        qi_lb60_defconfig
arm                       netwinder_defconfig
m68k                        mvme147_defconfig
mips                           ci20_defconfig
sh                           se7750_defconfig
sh                         microdev_defconfig
powerpc                 mpc832x_mds_defconfig
xtensa                  audio_kc705_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                          pxa3xx_defconfig
nios2                            alldefconfig
sh                  sh7785lcr_32bit_defconfig
arm                        trizeps4_defconfig
powerpc                  iss476-smp_defconfig
powerpc                      ep88xc_defconfig
sh                          rsk7264_defconfig
sh                          sdk7786_defconfig
mips                          rb532_defconfig
sh                           se7619_defconfig
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
i386                 randconfig-a003-20210418
i386                 randconfig-a001-20210418
i386                 randconfig-a006-20210418
i386                 randconfig-a005-20210418
i386                 randconfig-a004-20210418
i386                 randconfig-a002-20210418
x86_64               randconfig-a014-20210418
x86_64               randconfig-a015-20210418
x86_64               randconfig-a013-20210418
x86_64               randconfig-a011-20210418
x86_64               randconfig-a012-20210418
x86_64               randconfig-a016-20210418
i386                 randconfig-a015-20210418
i386                 randconfig-a013-20210418
i386                 randconfig-a014-20210418
i386                 randconfig-a016-20210418
i386                 randconfig-a012-20210418
i386                 randconfig-a011-20210418
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
x86_64               randconfig-a003-20210418
x86_64               randconfig-a001-20210418
x86_64               randconfig-a005-20210418
x86_64               randconfig-a002-20210418
x86_64               randconfig-a006-20210418
x86_64               randconfig-a004-20210418

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
