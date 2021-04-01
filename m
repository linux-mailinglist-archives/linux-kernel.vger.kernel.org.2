Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2237351D96
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhDAS3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:29:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:62924 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236046AbhDASHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:07:19 -0400
IronPort-SDR: ER+LGoulvksKQGCPtS7Gzk72ByFY8DdIMuTp/aKd2XBj2s1TQx6styyYwELNiir6xuAnSN7kKv
 JvOW5yBaOgcg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="253631394"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="253631394"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 10:24:58 -0700
IronPort-SDR: +0wdeX3LTAMoYxwm6C1Z6dbxa8UIhmNql/ahRgg4vDZZ/d7VvNwb9T1sln20vIMXuzd8yhuPIl
 LSh37j/6epgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="456072743"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2021 10:24:57 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lS13w-0006bH-TZ; Thu, 01 Apr 2021 17:24:56 +0000
Date:   Fri, 02 Apr 2021 01:24:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 53c8d676f843d4a8b8a7fb528dd77e79791df28f
Message-ID: <606601b1.TZ0LGj5R18+e6XKP%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 53c8d676f843d4a8b8a7fb528dd77e79791df28f  wl3501_cs: Fix out-of-bounds warning in wl3501_mgmt_join

possible Warning in current branch:

drivers/gpu/drm/mga/mga_ioc32.c:70:2: warning: 'memcpy' offset [21, 80] from the object at 'init' is out of the bounds of referenced subobject 'chipset' with type 'int' at offset 16 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [6, 10] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 4 [-Warray-bounds]
drivers/net/ethernet/i825xx/sun3_82586.c:993:108: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [25, 32] from the object at 'data64' is out of the bounds of referenced subobject 'buf' with type 'void *' at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-footbridge_defconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- arm-randconfig-c024-20210401
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-allmodconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-allyesconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- ia64-randconfig-s031-20210401
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- m68k-sun3_defconfig
|   `-- drivers-net-ethernet-i825xx-sun3_82586.c:warning:array-subscript-is-above-array-bounds-of-volatile-struct-transmit_cmd_struct
|-- parisc-allyesconfig
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- powerpc-randconfig-s032-20210401
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-data64-is-out-of-the-bounds-of-referenced-subobject-buf-with-type-void-at-offset
|-- x86_64-randconfig-a012-20210401
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- x86_64-randconfig-c022-20210401
|   |-- drivers-gpu-drm-mga-mga_ioc32.c:warning:memcpy-offset-from-the-object-at-init-is-out-of-the-bounds-of-referenced-subobject-chipset-with-type-int-at-offset
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
`-- x86_64-randconfig-s021-20210401
    `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset

elapsed time: 732m

configs tested: 120
configs skipped: 3

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
powerpc                     akebono_defconfig
sh                             sh03_defconfig
sh                              ul2_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc836x_mds_defconfig
m68k                             alldefconfig
powerpc                 mpc8560_ads_defconfig
sh                          r7785rp_defconfig
xtensa                  audio_kc705_defconfig
arm                        vexpress_defconfig
um                            kunit_defconfig
sh                        edosk7760_defconfig
alpha                               defconfig
sh                  sh7785lcr_32bit_defconfig
m68k                                defconfig
m68k                         apollo_defconfig
arc                           tb10x_defconfig
arm                            dove_defconfig
arm                        multi_v7_defconfig
sh                          landisk_defconfig
mips                     cu1000-neo_defconfig
xtensa                       common_defconfig
arm                      integrator_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                                  defconfig
arm                           corgi_defconfig
arm                        spear6xx_defconfig
powerpc                    ge_imp3a_defconfig
sh                         ap325rxa_defconfig
powerpc                     ep8248e_defconfig
arm                      footbridge_defconfig
arm                         orion5x_defconfig
xtensa                    xip_kc705_defconfig
powerpc                        fsp2_defconfig
sh                        apsh4ad0a_defconfig
arm                         lpc32xx_defconfig
m68k                        stmark2_defconfig
arm                         socfpga_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
m68k                           sun3_defconfig
ia64                            zx1_defconfig
powerpc                     powernv_defconfig
powerpc                 mpc8315_rdb_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20210401
i386                 randconfig-a003-20210401
i386                 randconfig-a001-20210401
i386                 randconfig-a004-20210401
i386                 randconfig-a002-20210401
i386                 randconfig-a005-20210401
x86_64               randconfig-a014-20210401
x86_64               randconfig-a015-20210401
x86_64               randconfig-a011-20210401
x86_64               randconfig-a013-20210401
x86_64               randconfig-a012-20210401
x86_64               randconfig-a016-20210401
i386                 randconfig-a014-20210401
i386                 randconfig-a011-20210401
i386                 randconfig-a016-20210401
i386                 randconfig-a012-20210401
i386                 randconfig-a013-20210401
i386                 randconfig-a015-20210401
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210401
x86_64               randconfig-a005-20210401
x86_64               randconfig-a003-20210401
x86_64               randconfig-a001-20210401
x86_64               randconfig-a002-20210401
x86_64               randconfig-a006-20210401

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
