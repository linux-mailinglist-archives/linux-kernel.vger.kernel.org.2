Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08926383CD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhEQTBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:01:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:14435 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhEQTB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:01:29 -0400
IronPort-SDR: f0FB7KHhGePugqOZim6Njx6FpdUeHcJtI4w8nw5XV8S5ltEsMiHv5mL+kaaiWGkhaCcq73fAZG
 zt+qGJg4HBTA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="180140982"
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="180140982"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2021 12:00:11 -0700
IronPort-SDR: cF1llZwX9vTp9IBVR6LU6t4er5gydZWzjX0/8rW6dc40ghs1OlEMKg64jLvtcknypcypNvu2WT
 DCUGDXJlyu9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,307,1613462400"; 
   d="scan'208";a="438262362"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 17 May 2021 12:00:10 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1liiTJ-0001rA-Fx; Mon, 17 May 2021 19:00:09 +0000
Date:   Tue, 18 May 2021 02:59:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4976a50e118e863f613d4a0f984dead71210f230
Message-ID: <60a2bd28.dv8bjTv266QnSJf8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4976a50e118e863f613d4a0f984dead71210f230  Merge branch 'locking/core'

elapsed time: 721m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      mgcoge_defconfig
arm                        magician_defconfig
m68k                        mvme147_defconfig
arm                        neponset_defconfig
arm                          collie_defconfig
xtensa                           allyesconfig
arm                     davinci_all_defconfig
mips                  cavium_octeon_defconfig
s390                          debug_defconfig
mips                          ath25_defconfig
sh                          lboxre2_defconfig
s390                       zfcpdump_defconfig
arm                            zeus_defconfig
ia64                          tiger_defconfig
csky                             alldefconfig
xtensa                       common_defconfig
powerpc                     powernv_defconfig
powerpc                     ep8248e_defconfig
sh                           se7712_defconfig
arm                           u8500_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210517
i386                 randconfig-a001-20210517
i386                 randconfig-a004-20210517
i386                 randconfig-a005-20210517
i386                 randconfig-a002-20210517
i386                 randconfig-a006-20210517
x86_64               randconfig-a012-20210517
x86_64               randconfig-a015-20210517
x86_64               randconfig-a011-20210517
x86_64               randconfig-a013-20210517
x86_64               randconfig-a016-20210517
x86_64               randconfig-a014-20210517
i386                 randconfig-a016-20210517
i386                 randconfig-a014-20210517
i386                 randconfig-a011-20210517
i386                 randconfig-a012-20210517
i386                 randconfig-a015-20210517
i386                 randconfig-a013-20210517
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
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210517
x86_64               randconfig-a003-20210517
x86_64               randconfig-a001-20210517
x86_64               randconfig-a005-20210517
x86_64               randconfig-a002-20210517
x86_64               randconfig-a006-20210517

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
