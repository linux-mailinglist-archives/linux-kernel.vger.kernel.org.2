Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B803B52CE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhF0KXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 06:23:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:30013 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229761AbhF0KXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 06:23:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10027"; a="293469958"
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="293469958"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2021 03:21:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,302,1616482800"; 
   d="scan'208";a="407403364"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2021 03:21:27 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lxRuo-00088I-SP; Sun, 27 Jun 2021 10:21:26 +0000
Date:   Sun, 27 Jun 2021 18:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 34f22feeb4d82535ad51a46fc4aac97c020e134f
Message-ID: <60d85107.n1gzh8LAVov/9VuV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 34f22feeb4d82535ad51a46fc4aac97c020e134f  Merge branch 'timers/core'

elapsed time: 721m

configs tested: 97
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                             espt_defconfig
csky                                defconfig
mips                           ip32_defconfig
riscv                               defconfig
mips                           ci20_defconfig
h8300                       h8s-sim_defconfig
powerpc                      ep88xc_defconfig
powerpc                      pmac32_defconfig
sh                         ecovec24_defconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    socrates_defconfig
mips                        omega2p_defconfig
arm                         s5pv210_defconfig
arm                        mvebu_v7_defconfig
arm                             pxa_defconfig
powerpc                    amigaone_defconfig
powerpc                     asp8347_defconfig
powerpc                   currituck_defconfig
sh                            shmin_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210627
i386                 randconfig-a001-20210627
i386                 randconfig-a003-20210627
i386                 randconfig-a006-20210627
i386                 randconfig-a005-20210627
i386                 randconfig-a004-20210627
i386                 randconfig-a011-20210627
i386                 randconfig-a014-20210627
i386                 randconfig-a013-20210627
i386                 randconfig-a015-20210627
i386                 randconfig-a012-20210627
i386                 randconfig-a016-20210627
x86_64               randconfig-a002-20210627
x86_64               randconfig-a001-20210627
x86_64               randconfig-a005-20210627
x86_64               randconfig-a003-20210627
x86_64               randconfig-a004-20210627
x86_64               randconfig-a006-20210627
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210627
x86_64               randconfig-a012-20210627
x86_64               randconfig-a016-20210627
x86_64               randconfig-a015-20210627
x86_64               randconfig-a014-20210627
x86_64               randconfig-a013-20210627
x86_64               randconfig-a011-20210627

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
