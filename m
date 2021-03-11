Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E1E337D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 19:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbhCKS63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 13:58:29 -0500
Received: from mga17.intel.com ([192.55.52.151]:41677 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhCKS5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 13:57:51 -0500
IronPort-SDR: JGqtdwpq85ocqdoz0h72OeorMzPja5ZS14hGBvU0rc3mwi1hGKVKDz8QfnNEHQYgLRm412uGcg
 WsG0C4i1dUmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="168637998"
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="168637998"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 10:57:11 -0800
IronPort-SDR: b+nnsTHhpNp9THeukL+aJa6abLNv6WKufs/GLxBcFFFAlOE3imiS3rfE91paoJcK8G/NbBDYea
 lSJS+AmYLkmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,241,1610438400"; 
   d="scan'208";a="521176579"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2021 10:57:10 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKQUf-0000uC-Fs; Thu, 11 Mar 2021 18:57:09 +0000
Date:   Fri, 12 Mar 2021 02:56:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 23d8a2699aca9cde82df39749e38ceba0a7d5b73
Message-ID: <604a67e5.9J21wvYWEIPHxVJu%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 23d8a2699aca9cde82df39749e38ceba0a7d5b73  media: siano: Fix out-of-bounds warnings in smscore_load_firmware_family2()

possible Warning in current branch:

include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [21, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- mips-allmodconfig
    `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset

elapsed time: 723m

configs tested: 92
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
m68k                       m5475evb_defconfig
mips                         bigsur_defconfig
powerpc                       ppc64_defconfig
xtensa                           alldefconfig
sh                 kfr2r09-romimage_defconfig
sh                          r7785rp_defconfig
arm                        cerfcube_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                          ath25_defconfig
sh                          sdk7786_defconfig
csky                             alldefconfig
arm                           omap1_defconfig
xtensa                              defconfig
arm                           sunxi_defconfig
powerpc                     redwood_defconfig
mips                            ar7_defconfig
parisc                generic-64bit_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nios2                            allyesconfig
nds32                               defconfig
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
i386                 randconfig-a001-20210311
i386                 randconfig-a005-20210311
i386                 randconfig-a003-20210311
i386                 randconfig-a002-20210311
i386                 randconfig-a004-20210311
i386                 randconfig-a006-20210311
i386                 randconfig-a013-20210311
i386                 randconfig-a016-20210311
i386                 randconfig-a011-20210311
i386                 randconfig-a014-20210311
i386                 randconfig-a015-20210311
i386                 randconfig-a012-20210311
x86_64               randconfig-a006-20210311
x86_64               randconfig-a001-20210311
x86_64               randconfig-a005-20210311
x86_64               randconfig-a002-20210311
x86_64               randconfig-a003-20210311
x86_64               randconfig-a004-20210311
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210311
x86_64               randconfig-a016-20210311
x86_64               randconfig-a013-20210311
x86_64               randconfig-a015-20210311
x86_64               randconfig-a014-20210311
x86_64               randconfig-a012-20210311

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
