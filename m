Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C149F3400B4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCRIPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:15:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:14770 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhCRIO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:14:59 -0400
IronPort-SDR: czoQbdzClovz2Jd8vSiFbwi78hWBm3mXTtZfERvTIw5gLIxpkYtPpkeB5ZDguwbF5ti0Mw2BK+
 ZEnT0G8W6PUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="169549276"
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="169549276"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 01:14:58 -0700
IronPort-SDR: UToShn/wNZSOcz7BGEusmrmPuJUjDbZfsY/zNHUutkvbg1of/qEqitTTVbdvCHkthD0mxClMPz
 SdtX8yLVIZJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,257,1610438400"; 
   d="scan'208";a="372629915"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Mar 2021 01:14:57 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMno0-000186-Nu; Thu, 18 Mar 2021 08:14:56 +0000
Date:   Thu, 18 Mar 2021 16:14:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 0705ef64d1ff52b817e278ca6e28095585ff31e1
Message-ID: <60530bea./GC84APkCeVcVyCO%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 0705ef64d1ff52b817e278ca6e28095585ff31e1  tools/insn: Restore the relative include paths for cross building

elapsed time: 725m

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
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
powerpc                     taishan_defconfig
powerpc                          allmodconfig
mips                            gpr_defconfig
sh                          landisk_defconfig
powerpc                    mvme5100_defconfig
m68k                       m5249evb_defconfig
sh                            titan_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
m68k                        stmark2_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                        sh7757lcr_defconfig
sh                             espt_defconfig
sh                   secureedge5410_defconfig
riscv                             allnoconfig
xtensa                              defconfig
arc                        nsimosci_defconfig
arm                            mmp2_defconfig
xtensa                       common_defconfig
m68k                                defconfig
mips                      malta_kvm_defconfig
arm                            lart_defconfig
arm                           spitz_defconfig
sh                  sh7785lcr_32bit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
