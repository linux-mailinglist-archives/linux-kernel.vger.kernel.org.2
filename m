Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A52630C4AB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 17:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbhBBP6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:58:49 -0500
Received: from mga05.intel.com ([192.55.52.43]:64870 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235861AbhBBPzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:55:54 -0500
IronPort-SDR: NpZm8qdJiO8Xf9p4W2ZVLBAw+ONONXmSNkDkVk6rOGu5/ZDaikidkUminTEICRiqZpJZVQ9Cuj
 2iBwU1Lzb4Iw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265707121"
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="265707121"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 07:55:03 -0800
IronPort-SDR: b3eBWuffKa4o5/G0qu+1y70jwrFxXe9o9O9534FtyDlAX2iMrzZTRhO/AWB52tBPsEwZsOyAEt
 RXBa2JCaEQrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,395,1602572400"; 
   d="scan'208";a="432977984"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Feb 2021 07:55:02 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6y17-0009Tf-EW; Tue, 02 Feb 2021 15:55:01 +0000
Date:   Tue, 02 Feb 2021 23:54:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.01.26a] BUILD SUCCESS WITH WARNING
 142d159f544763140e0f498936bca8f71563e0e0
Message-ID: <6019759f.+IddST7enmVGeTiB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.01.26a
branch HEAD: 142d159f544763140e0f498936bca8f71563e0e0  rcu/nocb: Rename nocb_gp_update_state to nocb_gp_update_state_deoffloading

possible Warning in current branch:

kernel/rcu/tree_plugin.h:2430:9: sparse: sparse: context imbalance in 'rcu_nocb_rdp_deoffload' - wrong count at exit

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- sparc64-randconfig-s031-20210202
    `-- kernel-rcu-tree_plugin.h:sparse:sparse:context-imbalance-in-rcu_nocb_rdp_deoffload-wrong-count-at-exit

elapsed time: 729m

configs tested: 95
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                     eseries_pxa_defconfig
um                           x86_64_defconfig
powerpc               mpc834x_itxgp_defconfig
ia64                        generic_defconfig
arm                          lpd270_defconfig
powerpc                        icon_defconfig
mips                malta_kvm_guest_defconfig
powerpc                        fsp2_defconfig
m68k                          sun3x_defconfig
sh                             shx3_defconfig
m68k                        m5272c3_defconfig
arm                        vexpress_defconfig
powerpc                 mpc837x_mds_defconfig
arm                            u300_defconfig
powerpc                     ksi8560_defconfig
arm                        clps711x_defconfig
powerpc                     tqm8555_defconfig
arm                       multi_v4t_defconfig
powerpc                     skiroot_defconfig
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
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
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
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
