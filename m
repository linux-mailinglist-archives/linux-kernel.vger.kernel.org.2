Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F23818B9
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhEOMbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 08:31:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:16802 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhEOMa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 08:30:59 -0400
IronPort-SDR: ckZugwPAme7lcWn/f2MwzfQoOn11tUvdBSxN55d78/+Zq5tGob2OVeoVs6ro21NoulHRBjilgL
 JLscTmRBWLQw==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="200331519"
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="200331519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2021 05:29:45 -0700
IronPort-SDR: pGtGIJRgzKS65CS6Mb91KrtGpD69I+S03DdvFiDAjtaCQj3Tfy/cVDMJM2XVmkGSvogcQqCTi/
 uE3664kmSWew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,301,1613462400"; 
   d="scan'208";a="471250891"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 15 May 2021 05:29:44 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhtQN-00018J-Gh; Sat, 15 May 2021 12:29:43 +0000
Date:   Sat, 15 May 2021 20:28:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 a66e1307dbb750e2b0ec410bdee3989b3c22010b
Message-ID: <609fbe87.rtF/1g3PkAV+yLHY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: a66e1307dbb750e2b0ec410bdee3989b3c22010b  tools/memory-model: Heuristics using data_race() must handle all values

i386-tinyconfig vmlinux size:

+-------+-----------------------------------+------------------------------------------+
| DELTA |              SYMBOL               |                  COMMIT                  |
+-------+-----------------------------------+------------------------------------------+
|  +538 | TOTAL                             | 6efb943b8616..a66e1307dbb7 (ALL COMMITS) |
|  +392 | TEXT                              | 6efb943b8616..a66e1307dbb7 (ALL COMMITS) |
|   +90 | DATA                              | 6efb943b8616..a66e1307dbb7 (ALL COMMITS) |
|  +193 | clocksource_watchdog()            | 6efb943b8616..a66e1307dbb7 (ALL COMMITS) |
|   +68 | clocksource_verify_percpu()       | 6efb943b8616..a66e1307dbb7 (ALL COMMITS) |
|   +66 | __clocksource_update_freq_scale() | 6efb943b8616..a66e1307dbb7 (ALL COMMITS) |
+-------+-----------------------------------+------------------------------------------+

elapsed time: 722m

configs tested: 103
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
powerpc                     skiroot_defconfig
arm                        spear3xx_defconfig
mips                           ip28_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                    maltaup_xpa_defconfig
arm                       versatile_defconfig
mips                         tb0226_defconfig
mips                        vocore2_defconfig
powerpc                     mpc5200_defconfig
parisc                generic-64bit_defconfig
arm                         lpc32xx_defconfig
arm                          ixp4xx_defconfig
arm                            mps2_defconfig
ia64                          tiger_defconfig
powerpc                   currituck_defconfig
riscv                               defconfig
mips                         tb0287_defconfig
mips                         bigsur_defconfig
sh                        edosk7760_defconfig
sh                   secureedge5410_defconfig
arm                           sunxi_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                 randconfig-a003-20210515
i386                 randconfig-a001-20210515
i386                 randconfig-a004-20210515
i386                 randconfig-a005-20210515
i386                 randconfig-a002-20210515
i386                 randconfig-a006-20210515
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210514
x86_64               randconfig-a012-20210514
x86_64               randconfig-a011-20210514
x86_64               randconfig-a013-20210514
x86_64               randconfig-a016-20210514
x86_64               randconfig-a014-20210514

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
