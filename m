Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C784350FFA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 09:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbhDAHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 03:19:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:6466 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233379AbhDAHTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:19:33 -0400
IronPort-SDR: zbQ4wmF6dO+EqTMc9kXYihJkuLKREcEx5yZgSeY1frDzGvRpQoVsXNaM3/SMq+mifPhW+goQZ3
 OkR2JJqjEdNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="277359584"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="277359584"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 00:19:31 -0700
IronPort-SDR: Zyhil3ngr23GJ5+isQmqI+bu3NP7P2tLt0eF+HL2b6j2Dd9HFnDVjK/SYNYvx/LirmEMMlNG0e
 l1X5DYcLuhMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="379201391"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Apr 2021 00:19:29 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRrc0-0006LB-9u; Thu, 01 Apr 2021 07:19:28 +0000
Date:   Thu, 01 Apr 2021 15:18:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:for-mingo-rcu] BUILD SUCCESS
 ab6ad3dbddaf09f7df2d830766a2fb68d6ad669f
Message-ID: <606573d9.+Se3MArgNduKly7/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git for-mingo-rcu
branch HEAD: ab6ad3dbddaf09f7df2d830766a2fb68d6ad669f  Merge branches 'bitmaprange.2021.03.08a', 'fixes.2021.03.15a', 'kvfree_rcu.2021.03.08a', 'mmdumpobj.2021.03.08a', 'nocb.2021.03.15a', 'poll.2021.03.24a', 'rt.2021.03.08a', 'tasks.2021.03.08a', 'torture.2021.03.08a' and 'torturescript.2021.03.22a' into HEAD

elapsed time: 730m

configs tested: 227
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
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
nios2                         3c120_defconfig
arm                        spear6xx_defconfig
arm                           stm32_defconfig
arm                          collie_defconfig
sh                           se7705_defconfig
mips                         tb0219_defconfig
arm                     am200epdkit_defconfig
mips                           ip32_defconfig
sh                        sh7785lcr_defconfig
m68k                        stmark2_defconfig
sh                          rsk7264_defconfig
sh                             espt_defconfig
powerpc                      ppc6xx_defconfig
arm                          simpad_defconfig
m68k                        m5307c3_defconfig
mips                            gpr_defconfig
mips                        nlm_xlp_defconfig
powerpc                      tqm8xx_defconfig
arm                           corgi_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        fsp2_defconfig
arm                             ezx_defconfig
powerpc                 mpc837x_mds_defconfig
h8300                            allyesconfig
powerpc                   bluestone_defconfig
sh                         microdev_defconfig
sh                          rsk7269_defconfig
powerpc64                           defconfig
arm                   milbeaut_m10v_defconfig
sh                              ul2_defconfig
arm                         orion5x_defconfig
powerpc                    mvme5100_defconfig
arc                            hsdk_defconfig
sparc                       sparc64_defconfig
powerpc                     ksi8560_defconfig
sh                          rsk7201_defconfig
sh                          rsk7203_defconfig
arc                         haps_hs_defconfig
mips                          ath79_defconfig
mips                         cobalt_defconfig
arm                  colibri_pxa300_defconfig
x86_64                           alldefconfig
sh                           se7619_defconfig
powerpc                       ebony_defconfig
powerpc                  mpc885_ads_defconfig
mips                           mtx1_defconfig
powerpc                      cm5200_defconfig
ia64                            zx1_defconfig
riscv                          rv32_defconfig
sh                          r7780mp_defconfig
m68k                          sun3x_defconfig
ia64                         bigsur_defconfig
h8300                            alldefconfig
arm                        multi_v7_defconfig
arm                         nhk8815_defconfig
openrisc                 simple_smp_defconfig
powerpc                        icon_defconfig
powerpc                 mpc85xx_cds_defconfig
s390                       zfcpdump_defconfig
mips                        qi_lb60_defconfig
arm                        keystone_defconfig
sh                            migor_defconfig
arm                       mainstone_defconfig
sh                         apsh4a3a_defconfig
mips                     loongson1c_defconfig
riscv             nommu_k210_sdcard_defconfig
powerpc                     kilauea_defconfig
h8300                     edosk2674_defconfig
arc                      axs103_smp_defconfig
mips                      pic32mzda_defconfig
mips                        omega2p_defconfig
arm                         palmz72_defconfig
powerpc                 mpc834x_mds_defconfig
arc                              allyesconfig
powerpc                     redwood_defconfig
sh                           se7751_defconfig
mips                        workpad_defconfig
sh                           se7722_defconfig
arm                         lpc32xx_defconfig
xtensa                       common_defconfig
sh                        sh7757lcr_defconfig
sh                          sdk7786_defconfig
arc                        nsim_700_defconfig
powerpc                     sequoia_defconfig
arm                          exynos_defconfig
m68k                          hp300_defconfig
sh                           se7750_defconfig
powerpc                     tqm5200_defconfig
m68k                        mvme16x_defconfig
s390                             alldefconfig
sh                ecovec24-romimage_defconfig
arm                          pcm027_defconfig
sh                            shmin_defconfig
riscv                             allnoconfig
mips                          ath25_defconfig
powerpc                     ppa8548_defconfig
mips                           gcw0_defconfig
h8300                       h8s-sim_defconfig
arm                         cm_x300_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                  storcenter_defconfig
mips                    maltaup_xpa_defconfig
alpha                            allyesconfig
powerpc                  mpc866_ads_defconfig
mips                     loongson1b_defconfig
arm                            dove_defconfig
powerpc                      chrp32_defconfig
alpha                            alldefconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8555_defconfig
sh                           sh2007_defconfig
um                               allmodconfig
arc                                 defconfig
powerpc                     powernv_defconfig
powerpc                 mpc8315_rdb_defconfig
arm                     eseries_pxa_defconfig
mips                        jmr3927_defconfig
powerpc                        cell_defconfig
powerpc                   currituck_defconfig
arm                            zeus_defconfig
powerpc                      walnut_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
mips                      malta_kvm_defconfig
arc                           tb10x_defconfig
powerpc                mpc7448_hpc2_defconfig
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
xtensa                           allyesconfig
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
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
i386                 randconfig-a015-20210331
i386                 randconfig-a011-20210331
i386                 randconfig-a014-20210331
i386                 randconfig-a013-20210331
i386                 randconfig-a016-20210331
i386                 randconfig-a012-20210331
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
