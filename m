Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FF432AE0A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360415AbhCBWUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:20:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:59603 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1449495AbhCBVJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 16:09:03 -0500
IronPort-SDR: uKceQstTDl7UfcrlZLNyMSewssIm3lVMcoIULDSskGTDtmy30xKAbwBzaSqAcmwTmBahlV03y+
 p7frlepm0jOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9911"; a="186327856"
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="186327856"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2021 13:08:20 -0800
IronPort-SDR: XMdWqCElvd7jxjpCuELx3BjT7w9X7WtNgQIgMgqQu6KlpdLziwEEFzE+LLWmDd8xQjPXv3UdFp
 JPm93uQx24Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,217,1610438400"; 
   d="scan'208";a="373729696"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2021 13:08:19 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHCFe-0000g1-LQ; Tue, 02 Mar 2021 21:08:18 +0000
Date:   Wed, 03 Mar 2021 05:07:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:sched/core] BUILD SUCCESS
 c91b0dcb6482096e7af4adbf39cfe3296af74a78
Message-ID: <603ea912.c5Csc1zmqh1uLd3A%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
branch HEAD: c91b0dcb6482096e7af4adbf39cfe3296af74a78  cpu/hotplug: Add cpuhp_invoke_callback_range()

elapsed time: 722m

configs tested: 106
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
sh                          kfr2r09_defconfig
um                             i386_defconfig
mips                        qi_lb60_defconfig
arm                          exynos_defconfig
arm                          simpad_defconfig
arm                          gemini_defconfig
sh                           se7724_defconfig
sh                        sh7763rdp_defconfig
powerpc                 mpc832x_mds_defconfig
mips                     cu1830-neo_defconfig
c6x                                 defconfig
riscv                    nommu_virt_defconfig
powerpc                     pq2fads_defconfig
arm                        mvebu_v7_defconfig
arm                  colibri_pxa270_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    ge_imp3a_defconfig
arm                        trizeps4_defconfig
powerpc                      obs600_defconfig
mips                           xway_defconfig
powerpc                          g5_defconfig
arm                         palmz72_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
arm                            pleb_defconfig
c6x                              alldefconfig
powerpc                     mpc512x_defconfig
m68k                          multi_defconfig
arm                          imote2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210302
x86_64               randconfig-a001-20210302
x86_64               randconfig-a004-20210302
x86_64               randconfig-a002-20210302
x86_64               randconfig-a005-20210302
x86_64               randconfig-a003-20210302
i386                 randconfig-a005-20210302
i386                 randconfig-a003-20210302
i386                 randconfig-a002-20210302
i386                 randconfig-a004-20210302
i386                 randconfig-a006-20210302
i386                 randconfig-a001-20210302
i386                 randconfig-a016-20210302
i386                 randconfig-a012-20210302
i386                 randconfig-a014-20210302
i386                 randconfig-a013-20210302
i386                 randconfig-a011-20210302
i386                 randconfig-a015-20210302
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a013-20210302
x86_64               randconfig-a016-20210302
x86_64               randconfig-a015-20210302
x86_64               randconfig-a014-20210302
x86_64               randconfig-a012-20210302
x86_64               randconfig-a011-20210302

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
