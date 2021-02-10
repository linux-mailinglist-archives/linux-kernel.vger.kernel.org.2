Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B7A3171DC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:04:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbhBJVDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:03:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:7167 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232587AbhBJVDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:03:15 -0500
IronPort-SDR: gMD1ELRpDvgVHpSUCRxU4BvzSVecFS4VyIla4FVRtgRwrC1f6M7/4vxmdzFTg5ZZ4hSz3+1gmZ
 6KnNUYL61Mqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="179594302"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="179594302"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 13:02:26 -0800
IronPort-SDR: SueCRu1FenX2eN83v35iAzoXIueNtn2dXHaFQT0zuYa+5GYs9YLnBzKJ2mqpvb57KrrGn5hsWw
 wXY1OqiZAwWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="414018250"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 10 Feb 2021 13:02:25 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9wcy-0003Go-Qd; Wed, 10 Feb 2021 21:02:24 +0000
Date:   Thu, 11 Feb 2021 05:01:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:timers/urgent] BUILD SUCCESS
 0fcc7c20d2e2a65fb5b80d42841084e8509d085d
Message-ID: <602449a6.UMpXKQJQf7SBoLFQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/urgent
branch HEAD: 0fcc7c20d2e2a65fb5b80d42841084e8509d085d  hrtimer: Update softirq_expires_next correctly in hrtimer_force_reprogram()

elapsed time: 730m

configs tested: 116
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
microblaze                          defconfig
powerpc                     ksi8560_defconfig
xtensa                         virt_defconfig
nios2                         3c120_defconfig
arc                        vdk_hs38_defconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
arc                              alldefconfig
c6x                        evmc6474_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 mpc8560_ads_defconfig
mips                           rs90_defconfig
arm                         s5pv210_defconfig
arc                              allyesconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
m68k                          amiga_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     tqm8555_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                        bcm63xx_defconfig
sh                           se7721_defconfig
sh                           se7751_defconfig
mips                     decstation_defconfig
arm                        magician_defconfig
m68k                        m5272c3_defconfig
sh                               allmodconfig
xtensa                  audio_kc705_defconfig
arm                         hackkit_defconfig
nds32                               defconfig
m68k                       m5475evb_defconfig
arm                           stm32_defconfig
sh                          rsk7201_defconfig
arm                           sama5_defconfig
powerpc                       ppc64_defconfig
arm                         orion5x_defconfig
m68k                        stmark2_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
c6x                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
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
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
