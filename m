Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755A831ABE4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Feb 2021 14:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhBMNfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Feb 2021 08:35:39 -0500
Received: from mga11.intel.com ([192.55.52.93]:40154 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhBMNfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Feb 2021 08:35:21 -0500
IronPort-SDR: 9J/IreI9w4MX4UTfh+0n8bDablFS67QVHVPu8oDpTbP/I/KTbWSrfBMmMN+XU9OLjLSCSo2ds7
 bWJHBeZ/IQLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="179021727"
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="179021727"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2021 05:34:38 -0800
IronPort-SDR: Ok6U65l3yz2TVZ60t18HLFOUi+ZhNIqJbLi7jUq7m1vuE+/kMqW1O4O90WLkDADLUmaK+a69HD
 jlJ+0qWDeTLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,176,1610438400"; 
   d="scan'208";a="423568076"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Feb 2021 05:34:37 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAv4G-0005T7-OR; Sat, 13 Feb 2021 13:34:36 +0000
Date:   Sat, 13 Feb 2021 21:33:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/mm] BUILD SUCCESS
 40c1fa52cdb7c13ef88232e374b4b8ac8d820c4f
Message-ID: <6027d531.W+n9t7Lx7T6/OAIM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
branch HEAD: 40c1fa52cdb7c13ef88232e374b4b8ac8d820c4f  Merge branch 'x86/cleanups' into x86/mm

elapsed time: 736m

configs tested: 129
configs skipped: 53

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                      rts7751r2d1_defconfig
m68k                            q40_defconfig
arm                            lart_defconfig
arm                            pleb_defconfig
arm                   milbeaut_m10v_defconfig
h8300                            alldefconfig
openrisc                         alldefconfig
sh                           se7712_defconfig
h8300                               defconfig
sh                            hp6xx_defconfig
arm                          simpad_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     akebono_defconfig
arm                       mainstone_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                     ksi8560_defconfig
powerpc                           allnoconfig
powerpc                 linkstation_defconfig
mips                           jazz_defconfig
powerpc                 mpc832x_mds_defconfig
mips                       capcella_defconfig
arm                       netwinder_defconfig
powerpc                   bluestone_defconfig
sh                          rsk7203_defconfig
powerpc                    gamecube_defconfig
mips                          ath79_defconfig
powerpc64                        alldefconfig
nds32                               defconfig
arm                             rpc_defconfig
arm                         lpc32xx_defconfig
arm                          badge4_defconfig
mips                      maltaaprp_defconfig
openrisc                            defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc83xx_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
x86_64               randconfig-a003-20210212
x86_64               randconfig-a002-20210212
x86_64               randconfig-a004-20210212
x86_64               randconfig-a001-20210212
x86_64               randconfig-a005-20210212
x86_64               randconfig-a006-20210212
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a003-20210212
i386                 randconfig-a005-20210212
i386                 randconfig-a002-20210212
i386                 randconfig-a001-20210212
i386                 randconfig-a004-20210212
i386                 randconfig-a006-20210212
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
