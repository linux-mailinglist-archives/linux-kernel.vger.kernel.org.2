Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F797319897
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 04:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBLDH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 22:07:28 -0500
Received: from mga18.intel.com ([134.134.136.126]:35996 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229918AbhBLDH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 22:07:26 -0500
IronPort-SDR: 8DlsgyVyD6b5LF46hvSTtwNyeSQ+6m/FQ6Fu5AcRYvgRKJG++Oefj7XE6xrgmL0LdfiJ0ka8vQ
 MqKEzdXMUbtg==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="170030385"
X-IronPort-AV: E=Sophos;i="5.81,172,1610438400"; 
   d="scan'208";a="170030385"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 19:06:42 -0800
IronPort-SDR: pmkBH30JwWnYjLj3nYcTUQX0ozZbhkdtukY67I1H+n2W+DK771asz0D+v70qdeXKcv7zs1FPKl
 YPWP3GoJqQJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,172,1610438400"; 
   d="scan'208";a="362479345"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 11 Feb 2021 19:06:41 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lAOn2-0004Jf-NU; Fri, 12 Feb 2021 03:06:40 +0000
Date:   Fri, 12 Feb 2021 11:05:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 77eb5bf00195e53ece8296076811629a959a9e0c
Message-ID: <6025f084.pYu0u2h9ucyb/iLL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
branch HEAD: 77eb5bf00195e53ece8296076811629a959a9e0c  Merge remote-tracking branch 'tip/x86/urgent' into tip-master

elapsed time: 729m

configs tested: 114
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
alpha                            alldefconfig
arc                     haps_hs_smp_defconfig
sh                               j2_defconfig
powerpc                      ppc64e_defconfig
powerpc                         ps3_defconfig
h8300                     edosk2674_defconfig
arm                          moxart_defconfig
arm                             rpc_defconfig
mips                         mpc30x_defconfig
mips                     cu1830-neo_defconfig
mips                         tb0219_defconfig
sh                          rsk7264_defconfig
arm                            u300_defconfig
arm                       netwinder_defconfig
nds32                            alldefconfig
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
sh                        sh7763rdp_defconfig
sh                            migor_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
mips                      malta_kvm_defconfig
sh                                  defconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
arm                          pxa910_defconfig
powerpc                    sam440ep_defconfig
powerpc                  mpc885_ads_defconfig
c6x                        evmc6457_defconfig
openrisc                            defconfig
arm                           omap1_defconfig
powerpc                      pcm030_defconfig
powerpc                 linkstation_defconfig
mips                    maltaup_xpa_defconfig
arm                         palmz72_defconfig
powerpc                     tqm8548_defconfig
microblaze                          defconfig
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
x86_64               randconfig-a003-20210211
x86_64               randconfig-a002-20210211
x86_64               randconfig-a001-20210211
x86_64               randconfig-a004-20210211
x86_64               randconfig-a005-20210211
x86_64               randconfig-a006-20210211
x86_64               randconfig-a013-20210209
x86_64               randconfig-a014-20210209
x86_64               randconfig-a015-20210209
x86_64               randconfig-a012-20210209
x86_64               randconfig-a016-20210209
x86_64               randconfig-a011-20210209

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
