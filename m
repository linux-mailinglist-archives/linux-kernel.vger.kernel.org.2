Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBC32CEC5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 09:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbhCDIuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 03:50:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:38899 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236749AbhCDIt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 03:49:58 -0500
IronPort-SDR: jaTi+g1pYuCyg2T5tr4S1ckPCcbKpOe0eYnUVpuTIBsfALPfzzAc4vcS+iN9IV49TRoCP3Ehen
 LOXAOV6nQAgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="183999187"
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="183999187"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 00:49:18 -0800
IronPort-SDR: YJYWRzoZkkWYKJ//guBJU839q8sAmgTE3uDpcoA85qXeDI6QVSwY+7My++IExE9Ow+6GJQMeWK
 JghC3RqEHjAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,222,1610438400"; 
   d="scan'208";a="586677403"
Received: from lkp-server02.sh.intel.com (HELO 2482ff9f8ac0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Mar 2021 00:49:16 -0800
Received: from kbuild by 2482ff9f8ac0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lHjfX-00026Y-PG; Thu, 04 Mar 2021 08:49:15 +0000
Date:   Thu, 04 Mar 2021 16:48:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 e190f6b118ef75189455a9642bf2e1be2614050e
Message-ID: <60409ed2.+FrPPxkgymFMqU7V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: e190f6b118ef75189455a9642bf2e1be2614050e  Merge branch 'linus'

elapsed time: 722m

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
m68k                            q40_defconfig
mips                     loongson1c_defconfig
arm                          pxa168_defconfig
powerpc                     skiroot_defconfig
arm                         socfpga_defconfig
arm                           sama5_defconfig
sh                   secureedge5410_defconfig
ia64                            zx1_defconfig
mips                      maltaaprp_defconfig
sh                             sh03_defconfig
arc                    vdk_hs38_smp_defconfig
microblaze                          defconfig
sh                        sh7757lcr_defconfig
powerpc                       maple_defconfig
mips                      malta_kvm_defconfig
h8300                    h8300h-sim_defconfig
sh                          lboxre2_defconfig
arm                         bcm2835_defconfig
parisc                           alldefconfig
arm                            lart_defconfig
arm                          lpd270_defconfig
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
i386                 randconfig-a005-20210303
i386                 randconfig-a003-20210303
i386                 randconfig-a002-20210303
i386                 randconfig-a004-20210303
i386                 randconfig-a006-20210303
i386                 randconfig-a001-20210303
x86_64               randconfig-a013-20210303
x86_64               randconfig-a016-20210303
x86_64               randconfig-a015-20210303
x86_64               randconfig-a014-20210303
x86_64               randconfig-a012-20210303
x86_64               randconfig-a011-20210303
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
x86_64               randconfig-a006-20210303
x86_64               randconfig-a001-20210303
x86_64               randconfig-a004-20210303
x86_64               randconfig-a002-20210303
x86_64               randconfig-a005-20210303
x86_64               randconfig-a003-20210303

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
