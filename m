Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F873724D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhEDEMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:12:53 -0400
Received: from mga11.intel.com ([192.55.52.93]:26542 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhEDEMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:12:52 -0400
IronPort-SDR: oreN+hNdMUrwww0IQVyZlhlZnrNZzDOwnnnqIPHQr6HRjVOxAcWQ6cbwFX4LcH+WIqqoy+D7Sy
 Fr+VKNss5umg==
X-IronPort-AV: E=McAfee;i="6200,9189,9973"; a="194751721"
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="194751721"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2021 21:11:57 -0700
IronPort-SDR: N0y1HiWwaAVZLq+hCEIa+6Yu442L7QC+8NlraFSYKk0vt4nql0+MS5S/bwtInKi1rPu3Evg1Rn
 vRSAnTA3Vn7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,271,1613462400"; 
   d="scan'208";a="433086493"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 03 May 2021 21:11:56 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ldmPb-0009Sj-Qw; Tue, 04 May 2021 04:11:55 +0000
Date:   Tue, 04 May 2021 12:11:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 35c0c1d51208c59fa4527ec67aa6374d28e1d83d
Message-ID: <6090c970.RDXs3ckEc+NnekA/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 35c0c1d51208c59fa4527ec67aa6374d28e1d83d  Merge branch 'clocksource.2021.05.02a' into HEAD

elapsed time: 721m

configs tested: 124
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           ip27_defconfig
arm                        neponset_defconfig
powerpc                     akebono_defconfig
mips                        workpad_defconfig
powerpc                     pseries_defconfig
arm                          exynos_defconfig
arm                  colibri_pxa270_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         hackkit_defconfig
arm                       imx_v6_v7_defconfig
m68k                       m5249evb_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     powernv_defconfig
sh                          r7785rp_defconfig
sh                             espt_defconfig
arm                         bcm2835_defconfig
arm                         palmz72_defconfig
s390                             alldefconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
powerpc                    adder875_defconfig
powerpc                      ppc64e_defconfig
arm                          ixp4xx_defconfig
sh                        sh7757lcr_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                               alldefconfig
arm                      pxa255-idp_defconfig
sh                        apsh4ad0a_defconfig
sh                     sh7710voipgw_defconfig
arm                    vt8500_v6_v7_defconfig
mips                         tb0219_defconfig
parisc                           alldefconfig
nios2                         10m50_defconfig
arm                        spear3xx_defconfig
m68k                       m5475evb_defconfig
sh                              ul2_defconfig
openrisc                            defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
sh                          rsk7201_defconfig
arm                         shannon_defconfig
openrisc                         alldefconfig
powerpc                          g5_defconfig
xtensa                          iss_defconfig
powerpc                     tqm8548_defconfig
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
x86_64               randconfig-a001-20210503
x86_64               randconfig-a005-20210503
x86_64               randconfig-a003-20210503
x86_64               randconfig-a002-20210503
x86_64               randconfig-a006-20210503
x86_64               randconfig-a004-20210503
i386                 randconfig-a003-20210503
i386                 randconfig-a006-20210503
i386                 randconfig-a001-20210503
i386                 randconfig-a005-20210503
i386                 randconfig-a004-20210503
i386                 randconfig-a002-20210503
i386                 randconfig-a013-20210503
i386                 randconfig-a015-20210503
i386                 randconfig-a016-20210503
i386                 randconfig-a014-20210503
i386                 randconfig-a011-20210503
i386                 randconfig-a012-20210503
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
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
x86_64               randconfig-a014-20210503
x86_64               randconfig-a015-20210503
x86_64               randconfig-a012-20210503
x86_64               randconfig-a011-20210503
x86_64               randconfig-a013-20210503
x86_64               randconfig-a016-20210503

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
