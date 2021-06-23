Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE9D3B1360
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFWFvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:51:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:26520 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbhFWFvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:51:08 -0400
IronPort-SDR: YH5LjlofLYdPu1lh01pTuctfcUvme2P39/f6sDR6oRzuPhc0ufbNdLQLYC1hImnB65SHUWkmRY
 35S6b7s0TScQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228761760"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="228761760"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 22:48:50 -0700
IronPort-SDR: ANeQFx38YnA+hvlVm8rRX3UYfF04LAqog39S8YeP4i9t/9b2GxFtrU/hjjRsUr2XJgkuf6LZzt
 Q9f20I0uBxYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="623727678"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2021 22:48:48 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvvkm-0005kN-78; Wed, 23 Jun 2021 05:48:48 +0000
Date:   Wed, 23 Jun 2021 13:48:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 00b1a0341c16253f614d045ed84942971463b0e9
Message-ID: <60d2cb32.swKYyJWQKfS1rq1X%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 00b1a0341c16253f614d045ed84942971463b0e9  torture: Protect kvm-remote.sh directory trees from /tmp reaping

elapsed time: 720m

configs tested: 105
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
powerpc                   motionpro_defconfig
arc                        vdk_hs38_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm5200_defconfig
powerpc                    gamecube_defconfig
sh                          polaris_defconfig
m68k                         apollo_defconfig
powerpc                      katmai_defconfig
h8300                            alldefconfig
sh                          kfr2r09_defconfig
m68k                        mvme16x_defconfig
arm                        realview_defconfig
s390                             allmodconfig
riscv                               defconfig
um                            kunit_defconfig
sh                                  defconfig
arm                        mvebu_v5_defconfig
sh                   sh7770_generic_defconfig
powerpc                     kmeter1_defconfig
microblaze                          defconfig
arm                         orion5x_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allmodconfig
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
arc                                 defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
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
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin

clang tested configs:
x86_64               randconfig-b001-20210622
x86_64               randconfig-b001-20210623
x86_64               randconfig-a002-20210622
x86_64               randconfig-a001-20210622
x86_64               randconfig-a005-20210622
x86_64               randconfig-a003-20210622
x86_64               randconfig-a004-20210622
x86_64               randconfig-a006-20210622

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
