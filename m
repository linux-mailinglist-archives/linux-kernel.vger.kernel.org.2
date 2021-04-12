Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756C535B84C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 03:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhDLBuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 21:50:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:26869 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236080AbhDLBuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 21:50:16 -0400
IronPort-SDR: ZBE9BlJN/Wug0sY+xvCW902HINYJ72sIYxTfCkguIQXiB/F24aszxBTacZFSkrW0J8NBHXsPmZ
 GW/AvTHbbY5A==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="193652146"
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="193652146"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2021 18:49:59 -0700
IronPort-SDR: vBWHDbc25lxqfjIwxhYt7bd5fUqwgR7Giimjs/XEObvO0JKtyRi00c2Q/fnAr+ZJlEbGQ9QQCt
 ehZRme4cLObA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,214,1613462400"; 
   d="scan'208";a="442883349"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Apr 2021 18:49:58 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVli9-00005b-QF; Mon, 12 Apr 2021 01:49:57 +0000
Date:   Mon, 12 Apr 2021 09:49:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:core/rcu] BUILD SUCCESS
 120b566d1df22a0a4543ac0e8aef875c49dd2c21
Message-ID: <6073a70d.t46yqtnAgFDiJp5n%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/rcu
branch HEAD: 120b566d1df22a0a4543ac0e8aef875c49dd2c21  Merge branch 'for-mingo-rcu' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into core/rcu

elapsed time: 723m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
nios2                               defconfig
sh                   sh7724_generic_defconfig
sparc                            alldefconfig
arm                            xcep_defconfig
um                            kunit_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      ppc64e_defconfig
arm                            hisi_defconfig
xtensa                          iss_defconfig
arm                           spitz_defconfig
m68k                        mvme147_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
xtensa                generic_kc705_defconfig
mips                         db1xxx_defconfig
arm                       netwinder_defconfig
openrisc                 simple_smp_defconfig
sh                         ecovec24_defconfig
s390                       zfcpdump_defconfig
m68k                       m5208evb_defconfig
parisc                              defconfig
parisc                generic-64bit_defconfig
s390                             allmodconfig
xtensa                       common_defconfig
sh                                  defconfig
nds32                               defconfig
sh                           se7619_defconfig
arm                          pxa910_defconfig
m68k                             allyesconfig
mips                  cavium_octeon_defconfig
m68k                        m5307c3_defconfig
mips                        omega2p_defconfig
powerpc                      katmai_defconfig
mips                          ath79_defconfig
h8300                       h8s-sim_defconfig
arm                         hackkit_defconfig
sh                          urquell_defconfig
mips                  maltasmvp_eva_defconfig
x86_64                           alldefconfig
powerpc                 canyonlands_defconfig
sh                          landisk_defconfig
h8300                    h8300h-sim_defconfig
mips                  decstation_64_defconfig
arm                         cm_x300_defconfig
sh                        edosk7760_defconfig
sparc                       sparc64_defconfig
csky                                defconfig
sh                           se7343_defconfig
powerpc                    sam440ep_defconfig
mips                     cu1830-neo_defconfig
s390                             alldefconfig
powerpc                      ppc40x_defconfig
powerpc                         ps3_defconfig
powerpc                     redwood_defconfig
arm                             rpc_defconfig
m68k                          sun3x_defconfig
arm                          ep93xx_defconfig
riscv                          rv32_defconfig
mips                           ip22_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                      mgcoge_defconfig
mips                            ar7_defconfig
parisc                           allyesconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
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
i386                 randconfig-a015-20210411
i386                 randconfig-a014-20210411
i386                 randconfig-a013-20210411
i386                 randconfig-a012-20210411
i386                 randconfig-a016-20210411
i386                 randconfig-a011-20210411
x86_64               randconfig-a003-20210411
x86_64               randconfig-a002-20210411
x86_64               randconfig-a001-20210411
x86_64               randconfig-a005-20210411
x86_64               randconfig-a006-20210411
x86_64               randconfig-a004-20210411
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
x86_64               randconfig-a014-20210411
x86_64               randconfig-a015-20210411
x86_64               randconfig-a011-20210411
x86_64               randconfig-a013-20210411
x86_64               randconfig-a012-20210411
x86_64               randconfig-a016-20210411

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
