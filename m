Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A41368DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 09:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbhDWHWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 03:22:30 -0400
Received: from mga14.intel.com ([192.55.52.115]:51637 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241173AbhDWHWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 03:22:19 -0400
IronPort-SDR: wJSEMbKHHuQsboJmcwZ6z+eCUu+6QzRJ15Gl10aKYIQ9q6amSFAb1rSrFe2pQnjFDcuGxKcc2y
 zA05wFlLibhA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="195585453"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="195585453"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 00:21:39 -0700
IronPort-SDR: hMsm7A7PjsI45ehtelYdcUcyVpQBTEoB/DAy/OGPE5+gTwZ2eo07V7QSocO/BIXxOhWXMKJfly
 jKWEXCYcWbWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; 
   d="scan'208";a="402107426"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Apr 2021 00:21:36 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZq88-0004Zv-1x; Fri, 23 Apr 2021 07:21:36 +0000
Date:   Fri, 23 Apr 2021 15:20:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 9b7dd9fc8562d7b82ad0c551ba0d111c29498b45
Message-ID: <60827549.401fu/egjbcCl+fD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 9b7dd9fc8562d7b82ad0c551ba0d111c29498b45  rcu/tree_plugin: Don't handle the case of 'all' CPU range

elapsed time: 724m

configs tested: 170
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
powerpc                       ebony_defconfig
powerpc                      cm5200_defconfig
um                             i386_defconfig
arm                      jornada720_defconfig
arm                              alldefconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     redwood_defconfig
m68k                          atari_defconfig
s390                                defconfig
powerpc                 mpc85xx_cds_defconfig
arm                           spitz_defconfig
xtensa                  audio_kc705_defconfig
powerpc                      acadia_defconfig
um                           x86_64_defconfig
sh                            titan_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ep88xc_defconfig
arc                      axs103_smp_defconfig
powerpc                 linkstation_defconfig
arm                         s5pv210_defconfig
sparc                       sparc32_defconfig
sh                              ul2_defconfig
m68k                         apollo_defconfig
sh                   sh7770_generic_defconfig
um                               allyesconfig
mips                            e55_defconfig
sh                        sh7757lcr_defconfig
sh                          lboxre2_defconfig
nios2                            alldefconfig
mips                         bigsur_defconfig
arm                           h3600_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                       maple_defconfig
nds32                             allnoconfig
arm                       aspeed_g5_defconfig
m68k                       m5275evb_defconfig
arc                     nsimosci_hs_defconfig
arm                     eseries_pxa_defconfig
parisc                           alldefconfig
powerpc                      mgcoge_defconfig
mips                        omega2p_defconfig
arm                          exynos_defconfig
arm                          gemini_defconfig
sh                          rsk7269_defconfig
arc                            hsdk_defconfig
arm                       versatile_defconfig
arm                        cerfcube_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                      chrp32_defconfig
sh                          sdk7786_defconfig
arm                       cns3420vb_defconfig
um                               alldefconfig
arm                          lpd270_defconfig
arm                           sama5_defconfig
mips                malta_qemu_32r6_defconfig
mips                     cu1000-neo_defconfig
arm                           u8500_defconfig
sh                           se7343_defconfig
mips                           ip32_defconfig
sh                          kfr2r09_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
powerpc                     kmeter1_defconfig
powerpc                  iss476-smp_defconfig
arc                          axs101_defconfig
mips                     decstation_defconfig
arm                   milbeaut_m10v_defconfig
arm                         mv78xx0_defconfig
um                            kunit_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc832x_rdb_defconfig
openrisc                    or1ksim_defconfig
mips                         tb0287_defconfig
arm                          pcm027_defconfig
arm                         nhk8815_defconfig
powerpc                      walnut_defconfig
powerpc                     rainier_defconfig
arm                           stm32_defconfig
powerpc                     mpc83xx_defconfig
arm                        trizeps4_defconfig
powerpc                         ps3_defconfig
arm                    vt8500_v6_v7_defconfig
nios2                         3c120_defconfig
arm                            dove_defconfig
arm                        neponset_defconfig
arm                      tct_hammer_defconfig
m68k                        mvme16x_defconfig
ia64                          tiger_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
x86_64               randconfig-a015-20210422
x86_64               randconfig-a016-20210422
x86_64               randconfig-a011-20210422
x86_64               randconfig-a014-20210422
x86_64               randconfig-a012-20210422
x86_64               randconfig-a013-20210422
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
