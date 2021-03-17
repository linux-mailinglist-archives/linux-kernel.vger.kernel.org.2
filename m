Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B67C33E865
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 05:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhCQEWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 00:22:40 -0400
Received: from mga17.intel.com ([192.55.52.151]:61189 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCQEW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 00:22:26 -0400
IronPort-SDR: Fvoj6WKO/WchPb8tCTH4AdVBCqSfgn1G7TD+omiVEfZgyPrAr2EhCziW7sGF7jCepLZGqMd451
 zUUED/awkgEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="169301293"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="169301293"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 21:22:25 -0700
IronPort-SDR: DmEAt5YEQBwTM1iSg40g8F3UN4w0/jBv7GnEyC6OXbYrYoFJuI3nlKB6AKxXHB26sy28LFuce3
 BCzQfiXvxYNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="602084555"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Mar 2021 21:22:24 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMNhQ-0000VB-1A; Wed, 17 Mar 2021 04:22:24 +0000
Date:   Wed, 17 Mar 2021 12:22:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/urgent] BUILD SUCCESS
 ef4cb70a4c22bf301cd757dcc838dc8ca9526477
Message-ID: <605183fa.+nf7LZm/gQxwcycj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/urgent
branch HEAD: ef4cb70a4c22bf301cd757dcc838dc8ca9526477  genirq/irq_sim: Fix typos in kernel doc (fnode -> fwnode)

elapsed time: 722m

configs tested: 155
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
arm                         bcm2835_defconfig
m68k                       m5475evb_defconfig
sh                          kfr2r09_defconfig
powerpc                      ppc64e_defconfig
arm                       netwinder_defconfig
mips                      maltaaprp_defconfig
powerpc                     akebono_defconfig
mips                     loongson1b_defconfig
arc                         haps_hs_defconfig
arm                           u8500_defconfig
sh                           se7705_defconfig
sh                         apsh4a3a_defconfig
powerpc                    klondike_defconfig
powerpc                       ppc64_defconfig
arm                        cerfcube_defconfig
nios2                         10m50_defconfig
xtensa                generic_kc705_defconfig
powerpc                      pasemi_defconfig
arm                            pleb_defconfig
um                             i386_defconfig
mips                       capcella_defconfig
alpha                            allyesconfig
nios2                         3c120_defconfig
parisc                generic-32bit_defconfig
powerpc                      ppc6xx_defconfig
microblaze                      mmu_defconfig
arm                          gemini_defconfig
csky                             alldefconfig
powerpc                  storcenter_defconfig
mips                           ip27_defconfig
sh                          r7785rp_defconfig
arm                         lubbock_defconfig
mips                    maltaup_xpa_defconfig
arm                       spear13xx_defconfig
mips                     loongson1c_defconfig
powerpc                     tqm8555_defconfig
powerpc                      ppc40x_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
sh                        edosk7760_defconfig
openrisc                            defconfig
powerpc                      bamboo_defconfig
powerpc                 mpc85xx_cds_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
arm                         assabet_defconfig
mips                      pistachio_defconfig
mips                  decstation_64_defconfig
powerpc                    sam440ep_defconfig
powerpc                      walnut_defconfig
arm                        vexpress_defconfig
mips                       bmips_be_defconfig
arm                          imote2_defconfig
mips                         tb0287_defconfig
arm                        clps711x_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                          ep93xx_defconfig
powerpc                     mpc512x_defconfig
arm                         orion5x_defconfig
powerpc                    amigaone_defconfig
m68k                        m5307c3_defconfig
xtensa                  audio_kc705_defconfig
mips                          rb532_defconfig
mips                         bigsur_defconfig
powerpc                     ep8248e_defconfig
powerpc                      cm5200_defconfig
sparc64                             defconfig
arm                            mps2_defconfig
mips                        workpad_defconfig
powerpc                     tqm8541_defconfig
arm                           h3600_defconfig
arm64                            alldefconfig
powerpc                      makalu_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
arm                        trizeps4_defconfig
sh                        edosk7705_defconfig
powerpc               mpc834x_itxgp_defconfig
um                            kunit_defconfig
powerpc                 mpc837x_rdb_defconfig
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
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210316
i386                 randconfig-a005-20210316
i386                 randconfig-a002-20210316
i386                 randconfig-a003-20210316
i386                 randconfig-a004-20210316
i386                 randconfig-a006-20210316
x86_64               randconfig-a011-20210316
x86_64               randconfig-a016-20210316
x86_64               randconfig-a013-20210316
x86_64               randconfig-a014-20210316
x86_64               randconfig-a015-20210316
x86_64               randconfig-a012-20210316
i386                 randconfig-a013-20210316
i386                 randconfig-a016-20210316
i386                 randconfig-a011-20210316
i386                 randconfig-a012-20210316
i386                 randconfig-a015-20210316
i386                 randconfig-a014-20210316
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
x86_64               randconfig-a006-20210316
x86_64               randconfig-a001-20210316
x86_64               randconfig-a005-20210316
x86_64               randconfig-a004-20210316
x86_64               randconfig-a003-20210316
x86_64               randconfig-a002-20210316

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
