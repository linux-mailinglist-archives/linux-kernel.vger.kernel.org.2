Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AED3816F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 10:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEOIfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 04:35:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:27356 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhEOIfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 04:35:51 -0400
IronPort-SDR: ok7mwr6sMscvJDgUpQMwf3ykZXNbzywB7IwgRs/P1S8wETaokE8vXgP+nItCs/R4+VSPdD6ixE
 tvf36vYqxHvw==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="197185565"
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="197185565"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2021 01:34:39 -0700
IronPort-SDR: t+LLQEexQAjztAYwrp9UkklU1jBDjgXHJnAa8Cw7x/pl2iHeoqqUpR9Mpv8tiAzaBMuOcQzLiW
 jpZnKSoNzT0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="471204358"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 May 2021 01:34:37 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhpkr-000155-A4; Sat, 15 May 2021 08:34:37 +0000
Date:   Sat, 15 May 2021 16:33:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.05.13a] BUILD SUCCESS
 fe1f4e1b099797d06bd8c66681eed4024c3cad67
Message-ID: <609f8776.V1ZaNyW1JeVhS09N%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.05.13a
branch HEAD: fe1f4e1b099797d06bd8c66681eed4024c3cad67  kcsan: Fix debugfs initcall return type

elapsed time: 721m

configs tested: 130
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ppc64_defconfig
arm                   milbeaut_m10v_defconfig
mips                          rb532_defconfig
arm                          ixp4xx_defconfig
um                                  defconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           se7206_defconfig
m68k                        mvme16x_defconfig
mips                      pistachio_defconfig
arm                        oxnas_v6_defconfig
arm                      jornada720_defconfig
nios2                         3c120_defconfig
openrisc                         alldefconfig
ia64                                defconfig
mips                          rm200_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc5200_defconfig
parisc                generic-64bit_defconfig
arm                         lpc32xx_defconfig
arm                            mps2_defconfig
arm                       mainstone_defconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
arc                           tb10x_defconfig
sparc64                          alldefconfig
openrisc                    or1ksim_defconfig
xtensa                generic_kc705_defconfig
arm                        mvebu_v7_defconfig
arm                        cerfcube_defconfig
arm                           tegra_defconfig
parisc                           allyesconfig
sh                         ecovec24_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
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
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210514
i386                 randconfig-a001-20210514
i386                 randconfig-a004-20210514
i386                 randconfig-a005-20210514
i386                 randconfig-a002-20210514
i386                 randconfig-a006-20210514
i386                 randconfig-a003-20210515
i386                 randconfig-a001-20210515
i386                 randconfig-a004-20210515
i386                 randconfig-a005-20210515
i386                 randconfig-a002-20210515
i386                 randconfig-a006-20210515
x86_64               randconfig-a012-20210515
x86_64               randconfig-a015-20210515
x86_64               randconfig-a011-20210515
x86_64               randconfig-a013-20210515
x86_64               randconfig-a016-20210515
x86_64               randconfig-a014-20210515
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
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
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210515
x86_64               randconfig-a003-20210515
x86_64               randconfig-a001-20210515
x86_64               randconfig-a005-20210515
x86_64               randconfig-a002-20210515
x86_64               randconfig-a006-20210515
x86_64               randconfig-a015-20210514
x86_64               randconfig-a012-20210514
x86_64               randconfig-a011-20210514
x86_64               randconfig-a013-20210514
x86_64               randconfig-a016-20210514
x86_64               randconfig-a014-20210514

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
