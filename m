Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1D132A015
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575263AbhCBDyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 22:54:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:50844 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245244AbhCAWTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 17:19:21 -0500
IronPort-SDR: LbcQel8Zu713J3L5WVGEP5AAW26bc9mXgYB5vjAsFWKif9q0J7hkc8LlLqZbDnyxExEQbA7BuJ
 TNKZTtcrhmqQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="271613185"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="271613185"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 14:07:59 -0800
IronPort-SDR: +VqIbho73DD9wvY8DKtin/jI8XsB7J6SItrB/6iY+YzPUB7cUEyEl39Q48F9KLvKyuKVcPHar8
 S5OUuyp6OsQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="444464688"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2021 14:07:57 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGqhp-0004kr-7n; Mon, 01 Mar 2021 22:07:57 +0000
Date:   Tue, 02 Mar 2021 06:07:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 05f7fcc675f50001a30b8938c05d11ca9f599f8c
Message-ID: <603d6591.KJHceP0c5ag0IXQf%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 05f7fcc675f50001a30b8938c05d11ca9f599f8c  hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()

elapsed time: 731m

configs tested: 124
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm                          moxart_defconfig
m68k                            q40_defconfig
powerpc                      katmai_defconfig
alpha                               defconfig
ia64                             alldefconfig
powerpc                      makalu_defconfig
sh                           se7724_defconfig
mips                           xway_defconfig
arm                        realview_defconfig
mips                        vocore2_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                      walnut_defconfig
m68k                        mvme16x_defconfig
arm                        vexpress_defconfig
powerpc                      chrp32_defconfig
i386                             allyesconfig
mips                        jmr3927_defconfig
arc                        nsim_700_defconfig
arm                         nhk8815_defconfig
arm                           sama5_defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
sh                          kfr2r09_defconfig
powerpc               mpc834x_itxgp_defconfig
riscv                            alldefconfig
arm                           spitz_defconfig
powerpc                        warp_defconfig
xtensa                       common_defconfig
arm                        neponset_defconfig
sh                     magicpanelr2_defconfig
arm                            zeus_defconfig
mips                     cu1830-neo_defconfig
sh                          rsk7269_defconfig
mips                         mpc30x_defconfig
arm                       versatile_defconfig
nios2                            alldefconfig
powerpc                       ebony_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                    nommu_virt_defconfig
powerpc                 mpc834x_mds_defconfig
sparc                               defconfig
sparc64                             defconfig
sh                        apsh4ad0a_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210228
i386                 randconfig-a005-20210228
i386                 randconfig-a004-20210228
i386                 randconfig-a003-20210228
i386                 randconfig-a001-20210228
i386                 randconfig-a002-20210228
i386                 randconfig-a005-20210301
i386                 randconfig-a003-20210301
i386                 randconfig-a002-20210301
i386                 randconfig-a004-20210301
i386                 randconfig-a006-20210301
i386                 randconfig-a001-20210301
x86_64               randconfig-a013-20210301
x86_64               randconfig-a016-20210301
x86_64               randconfig-a015-20210301
x86_64               randconfig-a014-20210301
x86_64               randconfig-a012-20210301
x86_64               randconfig-a011-20210301
i386                 randconfig-a016-20210301
i386                 randconfig-a012-20210301
i386                 randconfig-a014-20210301
i386                 randconfig-a013-20210301
i386                 randconfig-a011-20210301
i386                 randconfig-a015-20210301
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
x86_64               randconfig-a006-20210301
x86_64               randconfig-a001-20210301
x86_64               randconfig-a004-20210301
x86_64               randconfig-a002-20210301
x86_64               randconfig-a005-20210301
x86_64               randconfig-a003-20210301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
