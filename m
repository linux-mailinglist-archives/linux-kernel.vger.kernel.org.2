Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108453AFCCD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 08:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFVGGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 02:06:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:24357 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229854AbhFVGGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 02:06:09 -0400
IronPort-SDR: MTr2mojN2TseC2foGnFkJ4FthQeeS1e8xPu4WsVDR6AgQy4Sxgu+mochP1jzf/oSQbiJcvzBZg
 vnbnqrPoocMQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="187372271"
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="187372271"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 23:03:54 -0700
IronPort-SDR: mMGmaU1IbaQArURx0gCgyH+XR94cKYrwwF4VFOy6MW0xfdLxHcWmT132Qh5sWf8nm0waIEpOl6
 EVJ8O+fNaTsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,291,1616482800"; 
   d="scan'208";a="486779690"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jun 2021 23:03:51 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lvZVn-0004yk-59; Tue, 22 Jun 2021 06:03:51 +0000
Date:   Tue, 22 Jun 2021 14:03:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 1b5550506d574800f78ccef1d7c6f082b3514cf0
Message-ID: <60d17d33.3gG1v7wdlVdLnaeZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 1b5550506d574800f78ccef1d7c6f082b3514cf0  Merge branch 'objtool/urgent'

elapsed time: 726m

configs tested: 143
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    sam440ep_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                    socrates_defconfig
m68k                            mac_defconfig
um                               alldefconfig
nios2                         10m50_defconfig
arm                             mxs_defconfig
powerpc                     sequoia_defconfig
mips                          ath79_defconfig
arc                              allyesconfig
arm                          badge4_defconfig
mips                         tb0219_defconfig
sh                          r7785rp_defconfig
arm                       spear13xx_defconfig
powerpc                   motionpro_defconfig
mips                malta_qemu_32r6_defconfig
parisc                generic-64bit_defconfig
powerpc                      acadia_defconfig
sh                            shmin_defconfig
sh                          landisk_defconfig
powerpc                      ep88xc_defconfig
mips                  maltasmvp_eva_defconfig
s390                             alldefconfig
m68k                          multi_defconfig
arm                       aspeed_g5_defconfig
arc                        nsim_700_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
sh                          lboxre2_defconfig
arm                            qcom_defconfig
powerpc                 mpc832x_rdb_defconfig
mips                        jmr3927_defconfig
mips                       bmips_be_defconfig
mips                            e55_defconfig
m68k                          hp300_defconfig
m68k                         apollo_defconfig
mips                      pic32mzda_defconfig
arm                       cns3420vb_defconfig
mips                      loongson3_defconfig
powerpc                     pq2fads_defconfig
powerpc                    amigaone_defconfig
sh                          rsk7269_defconfig
powerpc                          g5_defconfig
arm                            hisi_defconfig
powerpc                  mpc866_ads_defconfig
h8300                     edosk2674_defconfig
powerpc                   lite5200b_defconfig
powerpc                       eiger_defconfig
mips                        vocore2_defconfig
sh                           se7722_defconfig
powerpc                      pasemi_defconfig
m68k                       m5208evb_defconfig
ia64                         bigsur_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210621
x86_64               randconfig-a001-20210621
x86_64               randconfig-a005-20210621
x86_64               randconfig-a003-20210621
x86_64               randconfig-a004-20210621
x86_64               randconfig-a006-20210621
i386                 randconfig-a002-20210621
i386                 randconfig-a001-20210621
i386                 randconfig-a003-20210621
i386                 randconfig-a006-20210621
i386                 randconfig-a005-20210621
i386                 randconfig-a004-20210621
x86_64               randconfig-a012-20210622
x86_64               randconfig-a016-20210622
x86_64               randconfig-a015-20210622
x86_64               randconfig-a014-20210622
x86_64               randconfig-a013-20210622
x86_64               randconfig-a011-20210622
i386                 randconfig-a011-20210621
i386                 randconfig-a014-20210621
i386                 randconfig-a013-20210621
i386                 randconfig-a015-20210621
i386                 randconfig-a012-20210621
i386                 randconfig-a016-20210621
i386                 randconfig-a011-20210622
i386                 randconfig-a014-20210622
i386                 randconfig-a013-20210622
i386                 randconfig-a015-20210622
i386                 randconfig-a012-20210622
i386                 randconfig-a016-20210622
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-b001-20210622
x86_64               randconfig-a012-20210621
x86_64               randconfig-a016-20210621
x86_64               randconfig-a015-20210621
x86_64               randconfig-a014-20210621
x86_64               randconfig-a013-20210621
x86_64               randconfig-a011-20210621

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
