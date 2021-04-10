Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA835B09E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 23:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbhDJVke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 17:40:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:35758 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232659AbhDJVkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 17:40:32 -0400
IronPort-SDR: YfBP6tNV2orTxLTF7fsthCmeCFY+pIrKIJZoEbCw0yY9Ggk4YRM3vlgvAb2XjWTO7O4kNIUZhm
 NQ9UC2qFgIuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9950"; a="194068007"
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="194068007"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2021 14:40:16 -0700
IronPort-SDR: Z0ohTO+qOGZ0TruI0KNUB2XMa+0YDKlVps9o5Z1+koXQVBbOSdolUB8wFULpjmd2rCsIwaKnzR
 /fAHBirFQs1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,213,1613462400"; 
   d="scan'208";a="397882001"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 10 Apr 2021 14:40:15 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVLKw-000If4-DG; Sat, 10 Apr 2021 21:40:14 +0000
Date:   Sun, 11 Apr 2021 05:39:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/core] BUILD SUCCESS
 99cb64de36d5c9397a664808b92943e35bdce25e
Message-ID: <60721b1a.mVW32iYsoRZq9WKr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/core
branch HEAD: 99cb64de36d5c9397a664808b92943e35bdce25e  x86/cpu: Comment Skylake server stepping too

elapsed time: 720m

configs tested: 153
configs skipped: 29

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
powerpc                    klondike_defconfig
mips                           rs90_defconfig
powerpc                     taishan_defconfig
arm                            hisi_defconfig
arm                     am200epdkit_defconfig
arm                          gemini_defconfig
powerpc                     ep8248e_defconfig
powerpc                      tqm8xx_defconfig
openrisc                         alldefconfig
arm                            mmp2_defconfig
um                             i386_defconfig
mips                            ar7_defconfig
arm                           spitz_defconfig
m68k                        mvme147_defconfig
xtensa                          iss_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
powerpc64                           defconfig
sh                             espt_defconfig
arm                         vf610m4_defconfig
mips                          rb532_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
xtensa                  nommu_kc705_defconfig
s390                          debug_defconfig
powerpc                       ebony_defconfig
sh                   secureedge5410_defconfig
mips                         tb0287_defconfig
mips                         tb0219_defconfig
sh                          urquell_defconfig
sh                            titan_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                   bluestone_defconfig
arc                                 defconfig
mips                      loongson3_defconfig
m68k                          multi_defconfig
nios2                               defconfig
sh                          kfr2r09_defconfig
m68k                          sun3x_defconfig
arc                          axs101_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
arm                          badge4_defconfig
openrisc                 simple_smp_defconfig
m68k                          atari_defconfig
arm                             mxs_defconfig
mips                           jazz_defconfig
openrisc                            defconfig
powerpc                      mgcoge_defconfig
m68k                        m5407c3_defconfig
csky                                defconfig
i386                                defconfig
arm                        vexpress_defconfig
sh                        dreamcast_defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210411
i386                 randconfig-a001-20210411
i386                 randconfig-a006-20210411
i386                 randconfig-a005-20210411
i386                 randconfig-a004-20210411
i386                 randconfig-a002-20210411
i386                 randconfig-a006-20210409
i386                 randconfig-a003-20210409
i386                 randconfig-a001-20210409
i386                 randconfig-a004-20210409
i386                 randconfig-a002-20210409
i386                 randconfig-a005-20210409
x86_64               randconfig-a014-20210409
x86_64               randconfig-a015-20210409
x86_64               randconfig-a012-20210409
x86_64               randconfig-a011-20210409
x86_64               randconfig-a013-20210409
x86_64               randconfig-a016-20210409
i386                 randconfig-a015-20210411
i386                 randconfig-a014-20210411
i386                 randconfig-a013-20210411
i386                 randconfig-a012-20210411
i386                 randconfig-a016-20210411
i386                 randconfig-a011-20210411
i386                 randconfig-a015-20210410
i386                 randconfig-a014-20210410
i386                 randconfig-a012-20210410
i386                 randconfig-a016-20210410
x86_64               randconfig-a003-20210411
x86_64               randconfig-a002-20210411
x86_64               randconfig-a001-20210411
x86_64               randconfig-a005-20210411
x86_64               randconfig-a006-20210411
x86_64               randconfig-a004-20210411
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
x86_64               randconfig-a003-20210410
x86_64               randconfig-a002-20210410
x86_64               randconfig-a001-20210410
x86_64               randconfig-a005-20210410
x86_64               randconfig-a006-20210410
x86_64               randconfig-a004-20210410
x86_64               randconfig-a014-20210411
x86_64               randconfig-a015-20210411
x86_64               randconfig-a011-20210411
x86_64               randconfig-a013-20210411
x86_64               randconfig-a012-20210411
x86_64               randconfig-a016-20210411
x86_64               randconfig-a004-20210409
x86_64               randconfig-a005-20210409
x86_64               randconfig-a003-20210409
x86_64               randconfig-a001-20210409
x86_64               randconfig-a002-20210409
x86_64               randconfig-a006-20210409

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
