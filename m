Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948D8340131
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 09:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhCRItb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 04:49:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:16266 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCRItB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 04:49:01 -0400
IronPort-SDR: +FbKf2QBZiXYS5guCqZxkLedhKHUeHC0ie9GDo5tElNXF2IJpcOCoBynd8GMVQS67ZsWJ3GH8h
 aIhgEYfoJTTA==
X-IronPort-AV: E=McAfee;i="6000,8403,9926"; a="177227566"
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="177227566"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 01:49:00 -0700
IronPort-SDR: K+G+zo6d87YxsIC49VDqqz1IhQLHAzoTUaSAZ4riu8iepsHm9s6yGsA5/FDYYCZ2Q3NhbUljqH
 FGJEPdri2MzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,258,1610438400"; 
   d="scan'208";a="389161113"
Received: from lkp-server02.sh.intel.com (HELO 1c294c63cb86) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2021 01:48:59 -0700
Received: from kbuild by 1c294c63cb86 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lMoKw-00018m-NL; Thu, 18 Mar 2021 08:48:58 +0000
Date:   Thu, 18 Mar 2021 16:48:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 2c6b02185cc608c19a22691fadc6ca2cd114c286
Message-ID: <605313e4.Fz65q86UThlmcGI8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/core
branch HEAD: 2c6b02185cc608c19a22691fadc6ca2cd114c286  irq: Simplify condition in irq_matrix_reserve()

elapsed time: 723m

configs tested: 111
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
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
m68k                       m5475evb_defconfig
sparc                            alldefconfig
powerpc                        icon_defconfig
xtensa                  nommu_kc705_defconfig
h8300                     edosk2674_defconfig
powerpc                     redwood_defconfig
mips                        qi_lb60_defconfig
powerpc                     taishan_defconfig
mips                            gpr_defconfig
powerpc                          allmodconfig
powerpc                  mpc885_ads_defconfig
microblaze                          defconfig
m68k                        stmark2_defconfig
mips                           gcw0_defconfig
sh                         apsh4a3a_defconfig
powerpc                         wii_defconfig
powerpc                       eiger_defconfig
mips                       bmips_be_defconfig
arm                       imx_v4_v5_defconfig
powerpc                      chrp32_defconfig
mips                     loongson1b_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                        sh7757lcr_defconfig
sh                          rsk7269_defconfig
mips                          rm200_defconfig
mips                     cu1000-neo_defconfig
powerpc                     tqm8560_defconfig
arm                          pxa910_defconfig
arm                          simpad_defconfig
arm                            mmp2_defconfig
xtensa                       common_defconfig
m68k                                defconfig
powerpc                     tqm8541_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           ip22_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210317
i386                 randconfig-a005-20210317
i386                 randconfig-a002-20210317
i386                 randconfig-a003-20210317
i386                 randconfig-a004-20210317
i386                 randconfig-a006-20210317
x86_64               randconfig-a006-20210317
x86_64               randconfig-a001-20210317
x86_64               randconfig-a005-20210317
x86_64               randconfig-a004-20210317
x86_64               randconfig-a003-20210317
x86_64               randconfig-a002-20210317
i386                 randconfig-a013-20210317
i386                 randconfig-a016-20210317
i386                 randconfig-a011-20210317
i386                 randconfig-a012-20210317
i386                 randconfig-a015-20210317
i386                 randconfig-a014-20210317
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210317
x86_64               randconfig-a016-20210317
x86_64               randconfig-a013-20210317
x86_64               randconfig-a014-20210317
x86_64               randconfig-a015-20210317
x86_64               randconfig-a012-20210317

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
