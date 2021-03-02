Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB3A32A0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576732AbhCBEcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:32:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:35861 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1444058AbhCBCjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 21:39:16 -0500
IronPort-SDR: xAeGMoSTEqR7n8evzWFfP8hy3JdzMSxilVx8f7iB5Ps9z+RdV04qkPMS8hVbhz2aUQliczHoAd
 L9MsUEuU2xoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="174293825"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="174293825"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 18:38:33 -0800
IronPort-SDR: Ptjc8HD1iRg/bcFl8eHaopZLL4KASFnoz96GAu49im360uN76DgUvo4R01MxwT+0WGuzfguxiO
 DzYH4+88bJuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="506150023"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2021 18:38:32 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGuvf-0004x0-Vi; Tue, 02 Mar 2021 02:38:31 +0000
Date:   Tue, 02 Mar 2021 10:37:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD SUCCESS
 6bf3195fdbab92b57f3167101a0b651b93dbeae7
Message-ID: <603da4f7.T/bv9KxEbbocgFMs%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 6bf3195fdbab92b57f3167101a0b651b93dbeae7  locking/csd_lock: Add more data to CSD lock debugging

elapsed time: 723m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7724_defconfig
mips                           xway_defconfig
arm                        realview_defconfig
mips                        vocore2_defconfig
s390                       zfcpdump_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      katmai_defconfig
sparc                       sparc32_defconfig
mips                         rt305x_defconfig
arm                         axm55xx_defconfig
sparc                            alldefconfig
arm                            hisi_defconfig
m68k                        stmark2_defconfig
sh                           se7750_defconfig
ia64                                defconfig
sh                   sh7770_generic_defconfig
arm                              alldefconfig
nios2                            alldefconfig
powerpc                       ebony_defconfig
powerpc                 mpc8313_rdb_defconfig
riscv                    nommu_virt_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a005-20210301
i386                 randconfig-a003-20210301
i386                 randconfig-a002-20210301
i386                 randconfig-a004-20210301
i386                 randconfig-a006-20210301
i386                 randconfig-a001-20210301
x86_64               randconfig-a013-20210301
x86_64               randconfig-a016-20210301
x86_64               randconfig-a015-20210301
x86_64               randconfig-a014-20210301
x86_64               randconfig-a012-20210301
x86_64               randconfig-a011-20210301
i386                 randconfig-a016-20210301
i386                 randconfig-a012-20210301
i386                 randconfig-a014-20210301
i386                 randconfig-a013-20210301
i386                 randconfig-a011-20210301
i386                 randconfig-a015-20210301
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
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
x86_64               randconfig-a006-20210301
x86_64               randconfig-a001-20210301
x86_64               randconfig-a004-20210301
x86_64               randconfig-a002-20210301
x86_64               randconfig-a005-20210301
x86_64               randconfig-a003-20210301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
