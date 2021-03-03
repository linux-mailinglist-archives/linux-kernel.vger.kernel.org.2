Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF9732C044
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243947AbhCCSkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:40:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:18781 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385521AbhCCRUU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 12:20:20 -0500
IronPort-SDR: XzfesiFFW+CqktbLFwDEFcGLDotJVKGNhwYvk+YqXn9EreGHG4oM30FrWfK0kn59cimsiyXqWb
 fGb6SQt4pbcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="166495206"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="166495206"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 09:17:08 -0800
IronPort-SDR: ZFDHg6O0KYh5y6SoDyM04upcLZUSHL+S8CfjGDDCiUejEYzXWg9yAyg2gZ1ZZNFqS/7VlXwbuF
 aahoMrnZeoNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="367681737"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2021 09:17:07 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHV7S-0001dF-IB; Wed, 03 Mar 2021 17:17:06 +0000
Date:   Thu, 04 Mar 2021 01:16:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 08804dc76ea287974d3640c52423d95cee3979e5
Message-ID: <603fc46b.CugEHDPbEMdHLAvf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 08804dc76ea287974d3640c52423d95cee3979e5  rcu/tree: Add a trace event for RCU CPU stall warnings

elapsed time: 722m

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
powerpc64                           defconfig
sh                             espt_defconfig
arm                            mmp2_defconfig
mips                           rs90_defconfig
h8300                            alldefconfig
powerpc                   motionpro_defconfig
powerpc                   bluestone_defconfig
arm                         bcm2835_defconfig
parisc                generic-32bit_defconfig
arm                             ezx_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip27_defconfig
arm                            pleb_defconfig
ia64                        generic_defconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
sh                              ul2_defconfig
mips                malta_kvm_guest_defconfig
sh                           se7750_defconfig
powerpc                      mgcoge_defconfig
arm                       imx_v6_v7_defconfig
csky                                defconfig
arc                          axs101_defconfig
arm                          pxa3xx_defconfig
mips                     cu1830-neo_defconfig
arc                        vdk_hs38_defconfig
nds32                               defconfig
c6x                              allyesconfig
um                           x86_64_defconfig
x86_64                           alldefconfig
mips                            gpr_defconfig
arm                        multi_v7_defconfig
xtensa                           allyesconfig
sh                         ap325rxa_defconfig
powerpc                     ep8248e_defconfig
arm                        multi_v5_defconfig
arm                        trizeps4_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
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
i386                 randconfig-a016-20210303
i386                 randconfig-a012-20210303
i386                 randconfig-a014-20210303
i386                 randconfig-a013-20210303
i386                 randconfig-a011-20210303
i386                 randconfig-a015-20210303
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
