Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 987B63E9BCA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 03:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhHLBCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 21:02:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:40112 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229724AbhHLBCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 21:02:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="237280297"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="237280297"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 18:01:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="673264698"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 11 Aug 2021 18:01:52 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mDz6V-000MFe-JV; Thu, 12 Aug 2021 01:01:51 +0000
Date:   Thu, 12 Aug 2021 09:00:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:smp/core] BUILD SUCCESS
 49b3bd213a9f3d685784913c255c6a2cb3d1fcce
Message-ID: <611472c8.2YBEHOnEHTTZ0Fi5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp/core
branch HEAD: 49b3bd213a9f3d685784913c255c6a2cb3d1fcce  smp: Fix all kernel-doc warnings

elapsed time: 724m

configs tested: 142
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210810
s390                       zfcpdump_defconfig
sh                                  defconfig
xtensa                generic_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                              ul2_defconfig
sh                               j2_defconfig
mips                          rb532_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      acadia_defconfig
arm                  colibri_pxa270_defconfig
powerpc                      makalu_defconfig
arm                          imote2_defconfig
arm                       omap2plus_defconfig
sh                          landisk_defconfig
m68k                        m5307c3_defconfig
alpha                            allyesconfig
m68k                             alldefconfig
powerpc                    adder875_defconfig
mips                      bmips_stb_defconfig
sh                           se7712_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
m68k                       m5208evb_defconfig
powerpc                     tqm5200_defconfig
powerpc                   lite5200b_defconfig
arm                   milbeaut_m10v_defconfig
mips                         cobalt_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                             defconfig
x86_64                            allnoconfig
powerpc                   currituck_defconfig
arm                       aspeed_g4_defconfig
mips                         bigsur_defconfig
sh                          sdk7786_defconfig
sh                        dreamcast_defconfig
sh                            hp6xx_defconfig
arc                     nsimosci_hs_defconfig
xtensa                           allyesconfig
powerpc                      walnut_defconfig
arm                           h3600_defconfig
arm                          lpd270_defconfig
mips                        nlm_xlp_defconfig
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
i386                 randconfig-a004-20210810
i386                 randconfig-a002-20210810
i386                 randconfig-a001-20210810
i386                 randconfig-a003-20210810
i386                 randconfig-a006-20210810
i386                 randconfig-a005-20210810
i386                 randconfig-a004-20210811
i386                 randconfig-a001-20210811
i386                 randconfig-a002-20210811
i386                 randconfig-a003-20210811
i386                 randconfig-a006-20210811
i386                 randconfig-a005-20210811
x86_64               randconfig-a004-20210810
x86_64               randconfig-a006-20210810
x86_64               randconfig-a003-20210810
x86_64               randconfig-a005-20210810
x86_64               randconfig-a002-20210810
x86_64               randconfig-a001-20210810
i386                 randconfig-a011-20210811
i386                 randconfig-a015-20210811
i386                 randconfig-a014-20210811
i386                 randconfig-a013-20210811
i386                 randconfig-a016-20210811
i386                 randconfig-a012-20210811
i386                 randconfig-a011-20210810
i386                 randconfig-a015-20210810
i386                 randconfig-a013-20210810
i386                 randconfig-a014-20210810
i386                 randconfig-a016-20210810
i386                 randconfig-a012-20210810
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210811
x86_64               randconfig-c001-20210810
x86_64               randconfig-a013-20210810
x86_64               randconfig-a011-20210810
x86_64               randconfig-a012-20210810
x86_64               randconfig-a016-20210810
x86_64               randconfig-a014-20210810
x86_64               randconfig-a015-20210810
x86_64               randconfig-a016-20210809
x86_64               randconfig-a012-20210809
x86_64               randconfig-a013-20210809
x86_64               randconfig-a011-20210809
x86_64               randconfig-a014-20210809
x86_64               randconfig-a015-20210809
x86_64               randconfig-a004-20210811
x86_64               randconfig-a006-20210811
x86_64               randconfig-a003-20210811
x86_64               randconfig-a002-20210811
x86_64               randconfig-a005-20210811
x86_64               randconfig-a001-20210811

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
