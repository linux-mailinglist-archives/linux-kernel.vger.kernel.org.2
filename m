Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E9836A5A5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 10:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhDYIK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 04:10:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:32738 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhDYIKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 04:10:25 -0400
IronPort-SDR: z0QpIoILqWiZEgCy46j/7XfmeDQ72HdpdE9yDT067AXhiu2SNvmMUXVMhH6VxW4hBjvbbWol48
 tXLE/UOUl3oA==
X-IronPort-AV: E=McAfee;i="6200,9189,9964"; a="183353078"
X-IronPort-AV: E=Sophos;i="5.82,250,1613462400"; 
   d="scan'208";a="183353078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 01:09:45 -0700
IronPort-SDR: JJRw1EW8OL48cl1W71eXIjtcsmS6RvlCYJAMkEc531Vgc9dmC3pRJ8xc04KurcpUOf76oW+xJv
 Odz+xYKis9eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,250,1613462400"; 
   d="scan'208";a="453963285"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Apr 2021 01:09:44 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1laZpn-0005Rw-LI; Sun, 25 Apr 2021 08:09:43 +0000
Date:   Sun, 25 Apr 2021 16:09:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 765822e1569a37aab5e69736c52d4ad4a289eba6
Message-ID: <608523c6.lpCBRGKFvsKF+/m9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 765822e1569a37aab5e69736c52d4ad4a289eba6  Merge tag 'irqchip-5.13' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 721m

configs tested: 90
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
sh                         ap325rxa_defconfig
parisc                generic-32bit_defconfig
csky                                defconfig
m68k                          multi_defconfig
sh                   sh7724_generic_defconfig
ia64                                defconfig
sh                         apsh4a3a_defconfig
mips                       bmips_be_defconfig
mips                        nlm_xlp_defconfig
arc                          axs103_defconfig
powerpc                  mpc885_ads_defconfig
sh                   sh7770_generic_defconfig
powerpc                    gamecube_defconfig
sh                     sh7710voipgw_defconfig
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
x86_64               randconfig-a004-20210425
x86_64               randconfig-a002-20210425
x86_64               randconfig-a001-20210425
x86_64               randconfig-a006-20210425
x86_64               randconfig-a005-20210425
x86_64               randconfig-a003-20210425
i386                 randconfig-a005-20210425
i386                 randconfig-a002-20210425
i386                 randconfig-a001-20210425
i386                 randconfig-a006-20210425
i386                 randconfig-a004-20210425
i386                 randconfig-a003-20210425
i386                 randconfig-a012-20210425
i386                 randconfig-a014-20210425
i386                 randconfig-a011-20210425
i386                 randconfig-a013-20210425
i386                 randconfig-a015-20210425
i386                 randconfig-a016-20210425
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a015-20210425
x86_64               randconfig-a016-20210425
x86_64               randconfig-a011-20210425
x86_64               randconfig-a014-20210425
x86_64               randconfig-a013-20210425
x86_64               randconfig-a012-20210425

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
