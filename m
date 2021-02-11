Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E16A3188C6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 11:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhBKKzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 05:55:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:24868 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230396AbhBKKr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 05:47:59 -0500
IronPort-SDR: J/gqxEClPyE+vXadLzIu9k9UACEej9vn09T2PYpkdg4gST4I+rQYhho+HKfy/AhK96Rk6Ziyxv
 6dXA5yqCPeGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="246286717"
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="246286717"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 02:47:12 -0800
IronPort-SDR: SGV996ANz+wgeSdNFIwrtAxj/LaWK5KVA7lnlhyVorpTL8+oYlkcKS9WS6Hm68HRTRBWg7obyZ
 CH9THF7Iio8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,170,1610438400"; 
   d="scan'208";a="422183617"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 11 Feb 2021 02:47:11 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lA9V8-0003ie-CL; Thu, 11 Feb 2021 10:47:10 +0000
Date:   Thu, 11 Feb 2021 18:46:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:perf/core] BUILD SUCCESS
 838342a6d6b7ecc475dc052d4a405c4ffb3ad1b5
Message-ID: <60250b02.6WPTs160YnqT6DTA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
branch HEAD: 838342a6d6b7ecc475dc052d4a405c4ffb3ad1b5  perf/x86/rapl: Fix psys-energy event on Intel SPR platform

elapsed time: 726m

configs tested: 148
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
sh                          rsk7203_defconfig
mips                      bmips_stb_defconfig
arm                              alldefconfig
arm                           sama5_defconfig
m68k                        mvme147_defconfig
arm                          badge4_defconfig
sh                        dreamcast_defconfig
riscv                    nommu_virt_defconfig
openrisc                         alldefconfig
arm                         bcm2835_defconfig
powerpc                    klondike_defconfig
c6x                         dsk6455_defconfig
mips                          malta_defconfig
powerpc                        cell_defconfig
ia64                             allmodconfig
powerpc                      pasemi_defconfig
sh                         apsh4a3a_defconfig
sh                          rsk7201_defconfig
mips                         tb0219_defconfig
m68k                            q40_defconfig
mips                        qi_lb60_defconfig
arm                           sunxi_defconfig
xtensa                         virt_defconfig
arm                        magician_defconfig
mips                           ip32_defconfig
powerpc                     tqm8540_defconfig
sh                          kfr2r09_defconfig
nios2                         10m50_defconfig
mips                 decstation_r4k_defconfig
arc                        nsimosci_defconfig
powerpc                  mpc885_ads_defconfig
arc                         haps_hs_defconfig
arm                          prima2_defconfig
powerpc                          g5_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                    vt8500_v6_v7_defconfig
arm                        realview_defconfig
mips                         tb0287_defconfig
powerpc                    socrates_defconfig
mips                            ar7_defconfig
powerpc                     sbc8548_defconfig
powerpc                     tqm8555_defconfig
powerpc                          allmodconfig
powerpc                 xes_mpc85xx_defconfig
m68k                        m5407c3_defconfig
powerpc                     ep8248e_defconfig
mips                        omega2p_defconfig
nios2                            alldefconfig
mips                           ip27_defconfig
powerpc                      katmai_defconfig
arm                           tegra_defconfig
xtensa                       common_defconfig
riscv                            alldefconfig
arm                        vexpress_defconfig
m68k                            mac_defconfig
arm                             pxa_defconfig
powerpc                 mpc832x_rdb_defconfig
sh                           se7751_defconfig
powerpc                     sequoia_defconfig
ia64                         bigsur_defconfig
ia64                      gensparse_defconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a016-20210211
x86_64               randconfig-a013-20210211
x86_64               randconfig-a012-20210211
x86_64               randconfig-a015-20210211
x86_64               randconfig-a014-20210211
x86_64               randconfig-a011-20210211
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
i386                 randconfig-a016-20210211
i386                 randconfig-a014-20210211
i386                 randconfig-a012-20210211
i386                 randconfig-a013-20210211
i386                 randconfig-a011-20210211
i386                 randconfig-a015-20210211
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
