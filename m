Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4384832A0A5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 14:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1576264AbhCBE0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 23:26:44 -0500
Received: from mga14.intel.com ([192.55.52.115]:11555 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1378820AbhCBBJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 20:09:59 -0500
IronPort-SDR: Zz+re3+A4h8J5KkLX59+6rdRux5MBoOsFmMIcfGMmjPQKpZ4O53P6fu4TwgoF51ZlvZLSVdJkM
 PFARuFdnAq4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="185972379"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="185972379"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 17:09:18 -0800
IronPort-SDR: 4+LmqI5/G7UTJ/h4qDrxFazQFJJCiBF/LwNXmk0/XaPBaTFg3HWZTbgkmo+t2ODXOJ7GijUhHT
 /zgkVpcQKiwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; 
   d="scan'208";a="517635111"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Mar 2021 17:09:16 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lGtXH-0004qO-N0; Tue, 02 Mar 2021 01:09:15 +0000
Date:   Tue, 02 Mar 2021 09:08:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/seves] BUILD SUCCESS
 bb8dc26937d51b3421b26d9d91cdad3484c34b7e
Message-ID: <603d902b.KpqxTZ1q+eKanaSD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/seves
branch HEAD: bb8dc26937d51b3421b26d9d91cdad3484c34b7e  x86/sev-es: Remove subtraction of res variable

elapsed time: 722m

configs tested: 76
configs skipped: 64

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
powerpc                    ge_imp3a_defconfig
mips                      bmips_stb_defconfig
mips                          malta_defconfig
powerpc                      katmai_defconfig
arm                      pxa255-idp_defconfig
mips                        nlm_xlr_defconfig
powerpc                       maple_defconfig
sh                               alldefconfig
sh                          kfr2r09_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                            titan_defconfig
m68k                          sun3x_defconfig
sparc                       sparc64_defconfig
powerpc                   currituck_defconfig
powerpc                  iss476-smp_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
x86_64               randconfig-a006-20210301
x86_64               randconfig-a001-20210301
x86_64               randconfig-a004-20210301
x86_64               randconfig-a002-20210301
x86_64               randconfig-a005-20210301
x86_64               randconfig-a003-20210301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
