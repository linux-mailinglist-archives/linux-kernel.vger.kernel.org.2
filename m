Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A94E305D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbhA0N0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:26:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:64913 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238395AbhA0NXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:23:46 -0500
IronPort-SDR: ES4kLYYPt/gr1Bnc82DSsFtiseIThcwA/hoamif0QbwJh3k4NFNj8r42p3GkB31+cUmogO7iNV
 9sZ1tNLMgAyQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="159840973"
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="159840973"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 05:21:51 -0800
IronPort-SDR: DhtNdKIUN+KM5LYhH+hrGXOupWuNF2WEwRoqRvWrxoBV73M9Dl/DF0xTHKm4DaB9wkI0+QX7TU
 qcU/nnWb9N7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,379,1602572400"; 
   d="scan'208";a="410534088"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2021 05:21:50 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l4klZ-0001az-Qj; Wed, 27 Jan 2021 13:21:49 +0000
Date:   Wed, 27 Jan 2021 21:21:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 efc0f28cfe21af3aa97190992a573dad108b28a4
Message-ID: <601168cf.w/yM4EqyBprGwGin%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: efc0f28cfe21af3aa97190992a573dad108b28a4  rcu-tasks: Rectify kernel-doc for struct rcu_tasks

elapsed time: 725m

configs tested: 112
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                          landisk_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                        warp_defconfig
powerpc                     tqm8560_defconfig
powerpc                      ppc44x_defconfig
xtensa                         virt_defconfig
arm                          prima2_defconfig
mips                           rs90_defconfig
arm                            xcep_defconfig
xtensa                    xip_kc705_defconfig
arm                       imx_v6_v7_defconfig
arm                        realview_defconfig
arm                         vf610m4_defconfig
mips                           ci20_defconfig
arm                  colibri_pxa300_defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                                 defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
powerpc                    adder875_defconfig
arm                       cns3420vb_defconfig
um                            kunit_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                            lart_defconfig
powerpc                           allnoconfig
arm                        spear3xx_defconfig
arm                        spear6xx_defconfig
arc                         haps_hs_defconfig
mips                        nlm_xlr_defconfig
arm                        neponset_defconfig
arm                        multi_v7_defconfig
nds32                               defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
c6x                              allyesconfig
parisc                              defconfig
s390                             allyesconfig
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
i386                 randconfig-a001-20210126
i386                 randconfig-a002-20210126
i386                 randconfig-a004-20210126
i386                 randconfig-a006-20210126
i386                 randconfig-a003-20210126
i386                 randconfig-a005-20210126
x86_64               randconfig-a012-20210126
x86_64               randconfig-a016-20210126
x86_64               randconfig-a015-20210126
x86_64               randconfig-a011-20210126
x86_64               randconfig-a013-20210126
x86_64               randconfig-a014-20210126
i386                 randconfig-a013-20210127
i386                 randconfig-a011-20210127
i386                 randconfig-a012-20210127
i386                 randconfig-a015-20210127
i386                 randconfig-a014-20210127
i386                 randconfig-a016-20210127
i386                 randconfig-a013-20210126
i386                 randconfig-a011-20210126
i386                 randconfig-a012-20210126
i386                 randconfig-a015-20210126
i386                 randconfig-a014-20210126
i386                 randconfig-a016-20210126
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210126
x86_64               randconfig-a002-20210126
x86_64               randconfig-a001-20210126
x86_64               randconfig-a005-20210126
x86_64               randconfig-a006-20210126
x86_64               randconfig-a004-20210126

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
