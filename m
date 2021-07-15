Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616CA3C9E0F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhGOMAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:00:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:12234 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhGOMAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:00:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="296172031"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="296172031"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 04:57:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; 
   d="scan'208";a="630714585"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Jul 2021 04:57:44 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m3zzs-000JeA-0z; Thu, 15 Jul 2021 11:57:44 +0000
Date:   Thu, 15 Jul 2021 19:57:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 e107ca1a35b6fd9ec92fe4432bcb77e9284d821e
Message-ID: <60f02296.ORpAy5KoTqtl3XjY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: e107ca1a35b6fd9ec92fe4432bcb77e9284d821e  doc: Update stallwarn.rst with recent changes

elapsed time: 729m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                        m5407c3_defconfig
mips                      malta_kvm_defconfig
arm                           sama5_defconfig
powerpc                      ppc64e_defconfig
arm                          badge4_defconfig
sh                            hp6xx_defconfig
arm                       omap2plus_defconfig
arm                            pleb_defconfig
xtensa                          iss_defconfig
arm                        oxnas_v6_defconfig
arc                          axs103_defconfig
arm                      tct_hammer_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
openrisc                 simple_smp_defconfig
sh                        sh7757lcr_defconfig
powerpc                  storcenter_defconfig
powerpc                      pmac32_defconfig
openrisc                    or1ksim_defconfig
m68k                          amiga_defconfig
powerpc                          g5_defconfig
sparc                            alldefconfig
arm                           h5000_defconfig
powerpc                        cell_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
x86_64                            allnoconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
s390                             allyesconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210715
i386                 randconfig-a006-20210715
i386                 randconfig-a004-20210715
i386                 randconfig-a001-20210715
i386                 randconfig-a002-20210715
x86_64               randconfig-a013-20210715
x86_64               randconfig-a012-20210715
x86_64               randconfig-a015-20210715
x86_64               randconfig-a014-20210715
x86_64               randconfig-a016-20210715
x86_64               randconfig-a011-20210715
i386                 randconfig-a014-20210715
i386                 randconfig-a015-20210715
i386                 randconfig-a011-20210715
i386                 randconfig-a013-20210715
i386                 randconfig-a012-20210715
i386                 randconfig-a016-20210715
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
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210715
x86_64               randconfig-a005-20210715
x86_64               randconfig-a004-20210715
x86_64               randconfig-a002-20210715
x86_64               randconfig-a003-20210715
x86_64               randconfig-a006-20210715
x86_64               randconfig-a001-20210715

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
