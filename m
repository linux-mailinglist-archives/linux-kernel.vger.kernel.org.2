Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129453471BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhCXGjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:39:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:23329 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235579AbhCXGjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:39:17 -0400
IronPort-SDR: ABeMJQdM3Ja8PprFSYqcG3hkAqWxDVCFvvQRAaxeuHBLjqFpxcLXw2DvDp2wjLnHTmIV47Fhev
 ibsfcaO+V/eQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="210739235"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="210739235"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2021 23:39:17 -0700
IronPort-SDR: CLeUV5rMUkJWlx0JEn1vGr95RJk4CZ5vvF6++xBhGvZFqe+tjsUNkplUKC9sKpUSxJeDes+9f1
 GxvHrOrnEX9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="381648742"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Mar 2021 23:39:16 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOxAh-00014b-S6; Wed, 24 Mar 2021 06:39:15 +0000
Date:   Wed, 24 Mar 2021 14:38:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/boot] BUILD SUCCESS
 4c674481dcf9974834b96622fa4b079c176f36f9
Message-ID: <605ade7a.aZMaWoG4G1xvF15I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/boot
branch HEAD: 4c674481dcf9974834b96622fa4b079c176f36f9  x86/setup: Merge several reservations of start of memory

elapsed time: 724m

configs tested: 113
configs skipped: 62

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
riscv                            allyesconfig
powerpc                     redwood_defconfig
mips                            ar7_defconfig
m68k                            mac_defconfig
arm                          imote2_defconfig
mips                     cu1000-neo_defconfig
mips                      bmips_stb_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
arm                           h5000_defconfig
arm                        spear3xx_defconfig
h8300                       h8s-sim_defconfig
ia64                                defconfig
mips                      pic32mzda_defconfig
arm                       versatile_defconfig
sh                        sh7785lcr_defconfig
arm                          collie_defconfig
powerpc                    socrates_defconfig
arm                       imx_v6_v7_defconfig
arm                        neponset_defconfig
sh                            hp6xx_defconfig
arm                         orion5x_defconfig
nds32                             allnoconfig
openrisc                            defconfig
parisc                generic-32bit_defconfig
arm                        multi_v5_defconfig
mips                            e55_defconfig
arm                          pxa910_defconfig
arm                      tct_hammer_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc834x_mds_defconfig
arm                             pxa_defconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
i386                               tinyconfig
i386                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210323
i386                 randconfig-a004-20210323
i386                 randconfig-a001-20210323
i386                 randconfig-a002-20210323
i386                 randconfig-a006-20210323
i386                 randconfig-a005-20210323
i386                 randconfig-a004-20210324
i386                 randconfig-a003-20210324
i386                 randconfig-a001-20210324
i386                 randconfig-a002-20210324
i386                 randconfig-a006-20210324
i386                 randconfig-a005-20210324
x86_64               randconfig-a002-20210323
x86_64               randconfig-a003-20210323
x86_64               randconfig-a006-20210323
x86_64               randconfig-a001-20210323
x86_64               randconfig-a004-20210323
x86_64               randconfig-a005-20210323
i386                 randconfig-a014-20210323
i386                 randconfig-a011-20210323
i386                 randconfig-a015-20210323
i386                 randconfig-a016-20210323
i386                 randconfig-a012-20210323
i386                 randconfig-a013-20210323
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210323
x86_64               randconfig-a015-20210323
x86_64               randconfig-a013-20210323
x86_64               randconfig-a014-20210323
x86_64               randconfig-a011-20210323
x86_64               randconfig-a016-20210323

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
