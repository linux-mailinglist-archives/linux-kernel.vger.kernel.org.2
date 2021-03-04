Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A692F32DB2B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhCDU0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:26:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:52534 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233006AbhCDU02 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:26:28 -0500
IronPort-SDR: LWIV3ZMaoZIykaXxwd58BU/b7pHGFOmy3GjcZQfFZdQrmsSnSsgX6LusATmyCtyKkxlGluROkz
 UB6UCA6uEXuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="187609394"
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="187609394"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 12:25:47 -0800
IronPort-SDR: dOKj1P5EJ3+EGMiOhYKcJG3lrFZrdMkrJcvTPL9AgzEeL1lM0e8h3tQs3I9LlTR+kBzYwOHWhV
 Xl7F1F10ifkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,223,1610438400"; 
   d="scan'208";a="597086316"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Mar 2021 12:25:46 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHuXY-0002NC-Kv; Thu, 04 Mar 2021 20:25:44 +0000
Date:   Fri, 05 Mar 2021 04:25:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.03.02a] BUILD SUCCESS
 00e647ff05e3e3cc31be250b9a762727e3c210c2
Message-ID: <60414246.pvObGH91NLAOKHfZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.03.02a
branch HEAD: 00e647ff05e3e3cc31be250b9a762727e3c210c2  kcsan, debugfs: Move debugfs file creation out of early init

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
arm                         axm55xx_defconfig
arm                        mvebu_v5_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
arm                             pxa_defconfig
xtensa                         virt_defconfig
powerpc                          allyesconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                        icon_defconfig
mips                         tb0287_defconfig
m68k                        m5307c3_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                          imote2_defconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
arc                            hsdk_defconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
powerpc                     akebono_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                        vocore2_defconfig
mips                         mpc30x_defconfig
mips                       lemote2f_defconfig
m68k                             allyesconfig
m68k                        m5407c3_defconfig
arm64                            alldefconfig
mips                          rb532_defconfig
arm                        trizeps4_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
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
x86_64               randconfig-a013-20210304
x86_64               randconfig-a016-20210304
x86_64               randconfig-a015-20210304
x86_64               randconfig-a014-20210304
x86_64               randconfig-a012-20210304
x86_64               randconfig-a011-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
