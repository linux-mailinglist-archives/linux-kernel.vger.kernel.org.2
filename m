Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2D03661B8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 23:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbhDTVsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 17:48:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:31095 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233769AbhDTVsv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 17:48:51 -0400
IronPort-SDR: xCv4Kgeut9jPNMfpz0MrIIpOlOba6b2s6T76Wv3EOXVas3ZHuQerwT/Oih3UHF4Db8oeHwMRjf
 lZXXvdFhk0Mw==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="192409752"
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="192409752"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 14:48:19 -0700
IronPort-SDR: Tb7qG2NZxJP7k6NCHG/nZKKP+2ckQNEalTOVacjHdvax/zJJQl+MqnmE99+Lb9vdIJkTvehCu3
 xmsnsCA7j9iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,238,1613462400"; 
   d="scan'208";a="463321906"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Apr 2021 14:48:18 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYyED-000316-OA; Tue, 20 Apr 2021 21:48:17 +0000
Date:   Wed, 21 Apr 2021 05:47:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 bc9940eb3a4c7a8e4cbaa3fafcaa356b13cb6ba3
Message-ID: <607f4c05.3OuIBNXMi2ZlmMF2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: bc9940eb3a4c7a8e4cbaa3fafcaa356b13cb6ba3  Merge branch 'core/entry'

elapsed time: 726m

configs tested: 131
configs skipped: 3

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
sh                        edosk7760_defconfig
arm                        mvebu_v5_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      bamboo_defconfig
arm                        magician_defconfig
xtensa                       common_defconfig
um                            kunit_defconfig
powerpc                       maple_defconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
powerpc                    ge_imp3a_defconfig
sh                                  defconfig
m68k                            mac_defconfig
powerpc                      makalu_defconfig
arm                        shmobile_defconfig
sparc                       sparc64_defconfig
arm                         assabet_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      tqm8xx_defconfig
arm                          moxart_defconfig
m68k                       m5208evb_defconfig
powerpc                   motionpro_defconfig
um                                allnoconfig
sh                          rsk7203_defconfig
powerpc64                           defconfig
mips                      pic32mzda_defconfig
sh                           se7780_defconfig
openrisc                  or1klitex_defconfig
mips                     decstation_defconfig
riscv                          rv32_defconfig
mips                  cavium_octeon_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
powerpc                      ppc6xx_defconfig
powerpc                      acadia_defconfig
arm                           corgi_defconfig
arm                             mxs_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                       ppc64_defconfig
arm                       multi_v4t_defconfig
sh                        sh7763rdp_defconfig
powerpc                      pmac32_defconfig
mips                           ip22_defconfig
powerpc                      pcm030_defconfig
powerpc                     ep8248e_defconfig
ia64                          tiger_defconfig
arm                             rpc_defconfig
ia64                         bigsur_defconfig
powerpc                  mpc885_ads_defconfig
arm                       aspeed_g4_defconfig
arm                         s3c2410_defconfig
sh                            hp6xx_defconfig
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
i386                 randconfig-a005-20210420
i386                 randconfig-a002-20210420
i386                 randconfig-a001-20210420
i386                 randconfig-a006-20210420
i386                 randconfig-a004-20210420
i386                 randconfig-a003-20210420
x86_64               randconfig-a015-20210420
x86_64               randconfig-a016-20210420
x86_64               randconfig-a011-20210420
x86_64               randconfig-a014-20210420
x86_64               randconfig-a013-20210420
x86_64               randconfig-a012-20210420
i386                 randconfig-a012-20210420
i386                 randconfig-a014-20210420
i386                 randconfig-a011-20210420
i386                 randconfig-a013-20210420
i386                 randconfig-a015-20210420
i386                 randconfig-a016-20210420
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
um                               allmodconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210420
x86_64               randconfig-a002-20210420
x86_64               randconfig-a001-20210420
x86_64               randconfig-a005-20210420
x86_64               randconfig-a006-20210420
x86_64               randconfig-a003-20210420

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
