Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAF003632E9
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 03:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbhDRBDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 21:03:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:47732 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230216AbhDRBDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 21:03:00 -0400
IronPort-SDR: hkdVANC8rmPIAx1UMeyrT4hRK5VC1LYR+uzz0lh8AWxVM8aWrcPxKjjs8+C7dl5fh7Wab7WYeR
 VCPz1Ks1l4hg==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="259152146"
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="259152146"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 18:02:32 -0700
IronPort-SDR: Dt9/ge/2n8HErFKzbufnuKNWiTV8agI8fumL3REZUdN8O6YRD7a3sDYxVKPdBzYubnY7Z+Jzqq
 UdEGaGzZI72Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,230,1613462400"; 
   d="scan'208";a="523055201"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 17 Apr 2021 18:02:30 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lXvpV-000161-Sj; Sun, 18 Apr 2021 01:02:29 +0000
Date:   Sun, 18 Apr 2021 09:02:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/core] BUILD SUCCESS
 2d036dfa5f10df9782f5278fc591d79d283c1fad
Message-ID: <607b851f.EcenwPbNGWdG2ysx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
branch HEAD: 2d036dfa5f10df9782f5278fc591d79d283c1fad  posix-timers: Preserve return value in clock_adjtime32()

elapsed time: 724m

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
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
powerpc                      pcm030_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
ia64                          tiger_defconfig
mips                  decstation_64_defconfig
powerpc                        icon_defconfig
powerpc                      arches_defconfig
arm                        vexpress_defconfig
powerpc                       eiger_defconfig
sh                            hp6xx_defconfig
arm                        trizeps4_defconfig
mips                           gcw0_defconfig
arm                       aspeed_g5_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     sbc8548_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      ppc44x_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
arm                             rpc_defconfig
arm                      footbridge_defconfig
arm                        neponset_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210417
x86_64               randconfig-a002-20210417
x86_64               randconfig-a005-20210417
x86_64               randconfig-a001-20210417
x86_64               randconfig-a006-20210417
x86_64               randconfig-a004-20210417
i386                 randconfig-a003-20210417
i386                 randconfig-a006-20210417
i386                 randconfig-a001-20210417
i386                 randconfig-a005-20210417
i386                 randconfig-a004-20210417
i386                 randconfig-a002-20210417
i386                 randconfig-a015-20210417
i386                 randconfig-a014-20210417
i386                 randconfig-a013-20210417
i386                 randconfig-a012-20210417
i386                 randconfig-a016-20210417
i386                 randconfig-a011-20210417
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
x86_64               randconfig-a014-20210417
x86_64               randconfig-a015-20210417
x86_64               randconfig-a011-20210417
x86_64               randconfig-a013-20210417
x86_64               randconfig-a012-20210417
x86_64               randconfig-a016-20210417

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
