Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4743582EA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 14:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbhDHMLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 08:11:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:63932 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhDHMLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 08:11:16 -0400
IronPort-SDR: zJqRr3CjavVYewMnifF4XHlykBN/pFmK6/m/uJTeWdJkK1roZZDKfUWBPWStwCAL3jU2GrIaWy
 mEDFLuPvOoIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="213930186"
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="213930186"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 05:11:04 -0700
IronPort-SDR: hQZDLu0mfYJgWTGtTeB3y1yEaj5uFkOMmckMovuX4RFg9JQk/AzObWmKSH0I7PxgS+wfkS3bRb
 zboRll6SpEWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,206,1613462400"; 
   d="scan'208";a="381703662"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Apr 2021 05:11:02 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUTUz-000Exs-Q3; Thu, 08 Apr 2021 12:11:01 +0000
Date:   Thu, 08 Apr 2021 20:10:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.04.02a] BUILD REGRESSION
 4bc4fd6b7e87ff0bdb1aa2493af85be2784717c0
Message-ID: <606ef2a8.ZUQbsxuaVoNvXNas%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.04.02a
branch HEAD: 4bc4fd6b7e87ff0bdb1aa2493af85be2784717c0  rcu: Fix RCU priority boosting and add more debug output

Error/Warning reports:

https://lore.kernel.org/lkml/202104081002.GeatLTuT-lkp@intel.com
https://lore.kernel.org/lkml/202104081118.JbLGAuB9-lkp@intel.com

Error/Warning in current branch:

ia64-linux-ld: (.text+0xf9a2): undefined reference to `rcu_spawn_one_boost_kthread'
kernel/rcu/tree.h:420:13: warning: 'rcu_spawn_one_boost_kthread' used but never defined

possible Error/Warning in current branch:

arc-elf-ld: tree.c:(.text+0x60fe): undefined reference to `rcu_spawn_one_boost_kthread'
arc-elf-ld: tree.c:(.text+0x6ad6): undefined reference to `rcu_spawn_one_boost_kthread'
kernel/rcu/tree.c:4205: undefined reference to `rcu_spawn_one_boost_kthread'
kernel/rcu/tree.h:420:13: warning: function 'rcu_spawn_one_boost_kthread' has internal linkage but is not defined [-Wundefined-internal]
nds32le-linux-ld: tree.c:(.text+0x6afa): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x1b190): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x1b1b0): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x200c): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x24d6): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x3571): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x4756): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x492a): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x67c0): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0x8110): undefined reference to `rcu_spawn_one_boost_kthread'
tree.c:(.text+0xb1fc): undefined reference to `rcu_spawn_one_boost_kthread'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- alpha-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- alpha-randconfig-r026-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arc-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arc-axs101_defconfig
|   |-- arc-elf-ld:tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arc-defconfig
|   |-- arc-elf-ld:tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arc-randconfig-r012-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-defconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- arm-keystone_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-mvebu_v7_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-omap2plus_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-oxnas_v6_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-randconfig-r033-20210407
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- arm-shmobile_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-trizeps4_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm-u8500_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-defconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- arm64-randconfig-c024-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-randconfig-r011-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-randconfig-r014-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-randconfig-r021-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-randconfig-r023-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-randconfig-r024-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- arm64-randconfig-r026-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- h8300-randconfig-c004-20210407
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- h8300-randconfig-r016-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-defconfig
|   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-a002-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-a004-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-a006-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-a011-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-a014-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-a016-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-c001-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-r006-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- i386-randconfig-s002-20210407
|   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- ia64-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- ia64-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- ia64-defconfig
|   |-- ia64-linux-ld:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- ia64-randconfig-r014-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- ia64-randconfig-r015-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- ia64-randconfig-r033-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- ia64-randconfig-r035-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- microblaze-randconfig-r004-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-bmips_be_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-ci20_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-loongson3_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-maltaup_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-nlm_xlr_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- mips-pistachio_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- nds32-defconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- nds32le-linux-ld:tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- openrisc-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- openrisc-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- parisc-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- parisc-defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- parisc-randconfig-r022-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- parisc-randconfig-r032-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- powerpc-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- powerpc-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- powerpc-randconfig-r016-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- riscv-allmodconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- riscv-allyesconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- riscv-defconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- riscv-nommu_k210_defconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- riscv-nommu_k210_sdcard_defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- riscv-nommu_virt_defconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- riscv-randconfig-s031-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- riscv-rv32_defconfig
|   |-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|   `-- tree.c:(.text):undefined-reference-to-rcu_spawn_one_boost_kthread
|-- s390-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- s390-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- s390-defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- s390-randconfig-r014-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- s390-randconfig-r016-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- s390-randconfig-r023-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- sh-randconfig-c004-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- sh-randconfig-r013-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- sparc-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- sparc-randconfig-p001-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- sparc-randconfig-r011-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- sparc64-randconfig-r021-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- sparc64-randconfig-r025-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-allmodconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-allyesconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-defconfig
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-kexec
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-randconfig-a011-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-randconfig-a013-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-randconfig-a014-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-randconfig-a016-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-randconfig-c022-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-randconfig-c023-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-randconfig-s021-20210407
|   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-rhel-8.3
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-rhel-8.3-kbuiltin
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- x86_64-rhel-8.3-kselftests
|   |-- kernel-rcu-tree.c:undefined-reference-to-rcu_spawn_one_boost_kthread
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
|-- xtensa-randconfig-r011-20210407
|   `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined
`-- xtensa-randconfig-r035-20210407
    `-- kernel-rcu-tree.h:warning:rcu_spawn_one_boost_kthread-used-but-never-defined

clang_recent_errors
`-- s390-randconfig-r034-20210407
    `-- kernel-rcu-tree.h:warning:function-rcu_spawn_one_boost_kthread-has-internal-linkage-but-is-not-defined

elapsed time: 720m

configs tested: 112
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
riscv                            allyesconfig
arm                         hackkit_defconfig
arm                           u8500_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
ia64                             allyesconfig
arc                          axs101_defconfig
powerpc                      chrp32_defconfig
arm                        keystone_defconfig
alpha                            allyesconfig
sh                            shmin_defconfig
mips                           ci20_defconfig
arm                        oxnas_v6_defconfig
powerpc                      ppc44x_defconfig
powerpc                     mpc5200_defconfig
arm                       omap2plus_defconfig
csky                                defconfig
arm                        mvebu_v7_defconfig
arm                        neponset_defconfig
m68k                        stmark2_defconfig
arm                        spear3xx_defconfig
arm                  colibri_pxa300_defconfig
sh                          kfr2r09_defconfig
arm                      footbridge_defconfig
xtensa                           alldefconfig
powerpc                       maple_defconfig
arm                        shmobile_defconfig
mips                        maltaup_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                malta_kvm_guest_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8541_defconfig
mips                            ar7_defconfig
powerpc                        fsp2_defconfig
um                               allyesconfig
nios2                         3c120_defconfig
powerpc                      ppc40x_defconfig
mips                        nlm_xlr_defconfig
sh                         ap325rxa_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      bamboo_defconfig
arm                          iop32x_defconfig
mips                      pistachio_defconfig
arm                        trizeps4_defconfig
ia64                             allmodconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a004-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
