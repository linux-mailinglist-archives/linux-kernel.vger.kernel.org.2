Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF5349273
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 13:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbhCYMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 08:52:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:32836 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230096AbhCYMwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 08:52:16 -0400
IronPort-SDR: sVWYjMmXyr3CRuqkXpeShErKGFddOXwIAws/W+UyCd9H09bB8P9F8mCNs7q8lEwsx/ueMA5+si
 32KUDzE/CqVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="170899188"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="170899188"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2021 05:52:16 -0700
IronPort-SDR: J/K2SMx6+Udv3Ag6UyfjMIaYB61vsib/38YfjpoWdTO+XWv5sWkdUySnCYFvXveAOzEwHFTEPH
 mSseajq2LAMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="414149973"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 25 Mar 2021 05:52:14 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPPTB-0001wh-Gw; Thu, 25 Mar 2021 12:52:13 +0000
Date:   Thu, 25 Mar 2021 20:52:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/test] BUILD SUCCESS
 b0ac3778ec85fd913954cc986f74b40cd0f8c9da
Message-ID: <605c8771.67q/60srQMr7fgvW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/test
branch HEAD: b0ac3778ec85fd913954cc986f74b40cd0f8c9da  Merge branch 'dev.2021.03.24a' into rcu/test

elapsed time: 726m

configs tested: 105
configs skipped: 3

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
arm                       aspeed_g4_defconfig
mips                        workpad_defconfig
arc                      axs103_smp_defconfig
arm                       cns3420vb_defconfig
arm                             ezx_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                  cavium_octeon_defconfig
sh                           se7750_defconfig
mips                      fuloong2e_defconfig
mips                    maltaup_xpa_defconfig
arc                        nsimosci_defconfig
arm                  colibri_pxa300_defconfig
arm                       mainstone_defconfig
arm                          moxart_defconfig
powerpc                     pq2fads_defconfig
sh                          r7785rp_defconfig
m68k                        m5272c3_defconfig
powerpc                   bluestone_defconfig
powerpc                     sequoia_defconfig
m68k                        mvme147_defconfig
microblaze                      mmu_defconfig
sh                     sh7710voipgw_defconfig
mips                           ci20_defconfig
powerpc                       maple_defconfig
m68k                        mvme16x_defconfig
powerpc                     asp8347_defconfig
sh                        apsh4ad0a_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
powerpc                 mpc834x_itx_defconfig
arc                         haps_hs_defconfig
powerpc                     rainier_defconfig
arm                        mvebu_v7_defconfig
arm                         assabet_defconfig
arm                        clps711x_defconfig
powerpc                      obs600_defconfig
arm                          pxa168_defconfig
mips                      maltasmvp_defconfig
mips                      maltaaprp_defconfig
nios2                            allyesconfig
powerpc                   currituck_defconfig
sh                           se7343_defconfig
sh                          lboxre2_defconfig
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
i386                 randconfig-a003-20210325
i386                 randconfig-a004-20210325
i386                 randconfig-a001-20210325
i386                 randconfig-a002-20210325
i386                 randconfig-a006-20210325
i386                 randconfig-a005-20210325
i386                 randconfig-a011-20210325
i386                 randconfig-a013-20210325
i386                 randconfig-a012-20210325
i386                 randconfig-a014-20210325
i386                 randconfig-a015-20210325
i386                 randconfig-a016-20210325
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
