Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CB634BFB6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 01:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhC1XKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 19:10:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:19300 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229656AbhC1XJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 19:09:42 -0400
IronPort-SDR: uf84yrjkIWZSAolfMXNJbkOu16hyB0JeI47f5/Rn/Jy9Mmpn/QJSkdZu5yQFHBqo6DQZR/zEiQ
 HfmlCg49gjxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9937"; a="171456337"
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="171456337"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2021 16:09:42 -0700
IronPort-SDR: vadZ5GlpxAE+j2C7jiiUwr1S79weWm5TFllASVKmvygpiLyI1PU63MlqldVBHZwcQdaKEAhgAc
 upMAH9sMuOEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,285,1610438400"; 
   d="scan'208";a="515776728"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2021 16:09:41 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lQeXM-0004DY-FZ; Sun, 28 Mar 2021 23:09:40 +0000
Date:   Mon, 29 Mar 2021 07:09:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 4b3ff7dd4b69698c08ca1d51741fe773a7b30b0a
Message-ID: <60610c94.C1GDtK4Zoa3c9Rfe%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 4b3ff7dd4b69698c08ca1d51741fe773a7b30b0a  Merge branch 'core/entry'

elapsed time: 722m

configs tested: 100
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
sh                            titan_defconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                        icon_defconfig
mips                      maltaaprp_defconfig
sh                                  defconfig
powerpc                   bluestone_defconfig
arm                       aspeed_g5_defconfig
sh                           se7712_defconfig
mips                           ip22_defconfig
powerpc                      chrp32_defconfig
arm                         lpc18xx_defconfig
powerpc                      pasemi_defconfig
powerpc                     rainier_defconfig
powerpc                        cell_defconfig
sh                        sh7757lcr_defconfig
sh                          urquell_defconfig
powerpc                     powernv_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
xtensa                          iss_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
i386                 randconfig-a004-20210328
i386                 randconfig-a003-20210328
i386                 randconfig-a001-20210328
i386                 randconfig-a002-20210328
i386                 randconfig-a006-20210328
i386                 randconfig-a005-20210328
x86_64               randconfig-a015-20210328
x86_64               randconfig-a012-20210328
x86_64               randconfig-a013-20210328
x86_64               randconfig-a014-20210328
x86_64               randconfig-a016-20210328
x86_64               randconfig-a011-20210328
i386                 randconfig-a014-20210328
i386                 randconfig-a011-20210328
i386                 randconfig-a015-20210328
i386                 randconfig-a016-20210328
i386                 randconfig-a013-20210328
i386                 randconfig-a012-20210328
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
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210328
x86_64               randconfig-a003-20210328
x86_64               randconfig-a001-20210328
x86_64               randconfig-a006-20210328
x86_64               randconfig-a005-20210328
x86_64               randconfig-a004-20210328

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
