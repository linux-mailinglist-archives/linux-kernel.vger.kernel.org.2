Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E114B32FE62
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 02:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCGBpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 20:45:15 -0500
Received: from mga07.intel.com ([134.134.136.100]:29700 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229964AbhCGBoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 20:44:44 -0500
IronPort-SDR: 5qCb5z1YgYQRJuh52YGVqQRPKlLRIIc6UlO+3AlPeuOxsXt9qtHUqVw22mRKrpQHrFy89jK3KY
 oWtRdLbP1nDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9915"; a="251882888"
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400"; 
   d="scan'208";a="251882888"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2021 17:44:43 -0800
IronPort-SDR: yTp1Uuc8sh+kjpiaokh2bdxgamWusBeS7Uw6/QPWtO8dK8hGtRlRb3aworCS1VWoX3V+Wbt21t
 e6AV6KLul80Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,229,1610438400"; 
   d="scan'208";a="370691034"
Received: from lkp-server01.sh.intel.com (HELO 3e992a48ca98) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Mar 2021 17:44:42 -0800
Received: from kbuild by 3e992a48ca98 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lIiTK-00004l-2K; Sun, 07 Mar 2021 01:44:42 +0000
Date:   Sun, 07 Mar 2021 09:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 87f839888775b31854553de50d67b1c207dad705
Message-ID: <60442fd2.iK5DTzN6JoSkhqDi%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 87f839888775b31854553de50d67b1c207dad705  Merge branch 'lkmm-dev.2021.03.04a' into HEAD

elapsed time: 3072m

configs tested: 131
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7750_defconfig
arm                          pxa3xx_defconfig
arm                           u8500_defconfig
m68k                          sun3x_defconfig
arm                        mvebu_v7_defconfig
arm                       aspeed_g4_defconfig
sh                           se7724_defconfig
riscv                            alldefconfig
mips                       bmips_be_defconfig
m68k                        m5272c3_defconfig
m68k                        m5307c3_defconfig
sh                ecovec24-romimage_defconfig
sparc64                          alldefconfig
arm                            dove_defconfig
arm                       multi_v4t_defconfig
powerpc                      chrp32_defconfig
powerpc                     tqm8541_defconfig
arm                         s3c6400_defconfig
m68k                        m5407c3_defconfig
powerpc                      bamboo_defconfig
arm                         shannon_defconfig
powerpc                     akebono_defconfig
powerpc                   motionpro_defconfig
arm                       omap2plus_defconfig
arm                            qcom_defconfig
powerpc                    klondike_defconfig
mips                        qi_lb60_defconfig
arm                      pxa255-idp_defconfig
sh                  sh7785lcr_32bit_defconfig
arm                      integrator_defconfig
powerpc                       ppc64_defconfig
mips                      loongson3_defconfig
sh                           se7619_defconfig
mips                         cobalt_defconfig
arm                           sunxi_defconfig
arm                        trizeps4_defconfig
powerpc                     pseries_defconfig
h8300                               defconfig
powerpc                  iss476-smp_defconfig
arm                        shmobile_defconfig
m68k                          atari_defconfig
arm                            mmp2_defconfig
powerpc                 mpc836x_mds_defconfig
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
x86_64               randconfig-a006-20210304
x86_64               randconfig-a001-20210304
x86_64               randconfig-a004-20210304
x86_64               randconfig-a005-20210304
x86_64               randconfig-a002-20210304
x86_64               randconfig-a003-20210304
i386                 randconfig-a005-20210305
i386                 randconfig-a003-20210305
i386                 randconfig-a002-20210305
i386                 randconfig-a004-20210305
i386                 randconfig-a006-20210305
i386                 randconfig-a001-20210305
i386                 randconfig-a005-20210304
i386                 randconfig-a003-20210304
i386                 randconfig-a002-20210304
i386                 randconfig-a004-20210304
i386                 randconfig-a006-20210304
i386                 randconfig-a001-20210304
x86_64               randconfig-a013-20210305
x86_64               randconfig-a016-20210305
x86_64               randconfig-a015-20210305
x86_64               randconfig-a014-20210305
x86_64               randconfig-a012-20210305
x86_64               randconfig-a011-20210305
i386                 randconfig-a016-20210305
i386                 randconfig-a012-20210305
i386                 randconfig-a013-20210305
i386                 randconfig-a014-20210305
i386                 randconfig-a011-20210305
i386                 randconfig-a015-20210305
i386                 randconfig-a016-20210304
i386                 randconfig-a012-20210304
i386                 randconfig-a013-20210304
i386                 randconfig-a014-20210304
i386                 randconfig-a011-20210304
i386                 randconfig-a015-20210304
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a013-20210304

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
