Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB33316C90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 18:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhBJR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 12:26:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:16540 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232369AbhBJRZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 12:25:51 -0500
IronPort-SDR: j+aKT7uzyUjDZvF0vmSjbdaGl+T3hlTVfQ2gEpeyXihpJ/KX/SbCOZ8coM/nXKR3T/DhZ05Tkb
 A+NPLmtOlTMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="246182656"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="246182656"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 09:25:10 -0800
IronPort-SDR: aAKQ1+QgbwhYBX0O9sVPWjTKw2kCdCnHhi62c3sBH+DCR2dX09yUfRQJocFgBTAwKsst3k8ok4
 MTExIcWw6AUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380219874"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2021 09:25:08 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9tEh-00039t-LQ; Wed, 10 Feb 2021 17:25:07 +0000
Date:   Thu, 11 Feb 2021 01:24:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/media/venus/hfi_cmds] BUILD SUCCESS
 e7d451cef70317bd0267ddd26062dc238f8c6e47
Message-ID: <602416da.iZqae7Dbk7nyl6OY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/media/venus/hfi_cmds
branch HEAD: e7d451cef70317bd0267ddd26062dc238f8c6e47  media: venus: hfi_cmds.h: Replace one-element array with flexible-array member

elapsed time: 1249m

configs tested: 89
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
mips                         cobalt_defconfig
arc                        nsimosci_defconfig
arm                       versatile_defconfig
powerpc                     stx_gp3_defconfig
sh                        sh7785lcr_defconfig
powerpc                      pasemi_defconfig
arm                             mxs_defconfig
arc                              alldefconfig
mips                          ath79_defconfig
xtensa                  audio_kc705_defconfig
ia64                             allmodconfig
ia64                                defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
i386                 randconfig-a001-20210209
i386                 randconfig-a005-20210209
i386                 randconfig-a003-20210209
i386                 randconfig-a002-20210209
i386                 randconfig-a006-20210209
i386                 randconfig-a004-20210209
i386                 randconfig-a016-20210209
i386                 randconfig-a013-20210209
i386                 randconfig-a012-20210209
i386                 randconfig-a014-20210209
i386                 randconfig-a011-20210209
i386                 randconfig-a015-20210209
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
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
