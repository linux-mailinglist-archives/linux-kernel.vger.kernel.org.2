Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949213164B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhBJLLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:11:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:10527 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhBJLIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:08:31 -0500
IronPort-SDR: 0MHhTu7/DCJV1XcNNyQCvW/9oOa3j6rpKavkm4L/bwEFm4QiB6A0kXyFrvKYckQ4bhlbwzrJYZ
 4xl3YKQb54VA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="179496855"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="179496855"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 03:07:47 -0800
IronPort-SDR: U/5acyUp0YElXKCfRaEHnd6am0aF0QjkRWVamKBjkR+gajFjD2j6Ee9hoRD+9mUS5C0IfBBmeR
 YeiLFiPoKIfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="375312788"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Feb 2021 03:07:45 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l9nLV-0002wI-7G; Wed, 10 Feb 2021 11:07:45 +0000
Date:   Wed, 10 Feb 2021 19:07:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/drm/amd/pm/powerplay/si_dpm] BUILD
 SUCCESS 42f20d2957c113e614042064333716eb5d6fe3d3
Message-ID: <6023be58.sk66L/V4vuSJI5mI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/drm/amd/pm/powerplay/si_dpm
branch HEAD: 42f20d2957c113e614042064333716eb5d6fe3d3  drm/amd/pm: Replace one-element array with flexible-array in struct SISLANDS_SMC_SWSTATE

elapsed time: 871m

configs tested: 94
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
nios2                         3c120_defconfig
arm                         s3c6400_defconfig
arm                         vf610m4_defconfig
arc                              alldefconfig
s390                       zfcpdump_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                  colibri_pxa270_defconfig
sh                            migor_defconfig
arc                        vdk_hs38_defconfig
mips                           rs90_defconfig
powerpc                     sequoia_defconfig
powerpc                     taishan_defconfig
alpha                               defconfig
mips                      maltaaprp_defconfig
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
x86_64               randconfig-a006-20210209
x86_64               randconfig-a001-20210209
x86_64               randconfig-a005-20210209
x86_64               randconfig-a004-20210209
x86_64               randconfig-a002-20210209
x86_64               randconfig-a003-20210209
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
