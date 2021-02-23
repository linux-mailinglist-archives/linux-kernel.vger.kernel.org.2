Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF223230C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhBWS3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:29:38 -0500
Received: from mga14.intel.com ([192.55.52.115]:19911 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhBWS3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:29:31 -0500
IronPort-SDR: 83/88wiE+vzZfpOzljeOxD4arlB1WBO3sSmYBvxGdw1K50bg2LB8e601QSUc+X61FQ0BnHnuio
 4rDi2KjnbArA==
X-IronPort-AV: E=McAfee;i="6000,8403,9904"; a="184200622"
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="184200622"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2021 10:28:49 -0800
IronPort-SDR: W/xNUxWvWPhcqKfi/wdaw2bX+SbMboVw53nq7Dx0hdLPouhwFI10AAIbp3HrjlDidIzG6dROB+
 tzOoZKUd/f7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,200,1610438400"; 
   d="scan'208";a="391089711"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2021 10:28:48 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lEcQR-0001Sg-Tn; Tue, 23 Feb 2021 18:28:47 +0000
Date:   Wed, 24 Feb 2021 02:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/testing] BUILD SUCCESS WITH WARNING
 16c90ac027a98f2bb63534c625befee648350153
Message-ID: <60354932.pM4U/Jlyla07w8om%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/testing
branch HEAD: 16c90ac027a98f2bb63534c625befee648350153  xfs: Replace one-element arrays with flexible-array members

possible Warning in current branch:

drivers/media/radio/wl128x/fmdrv_common.c:435:21: warning: array subscript 2 is outside array bounds of 'u16[1]' {aka 'short unsigned int[1]'} [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [3, 8] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]
include/linux/fortify-string.h:20:29: warning: '__builtin_memcpy' offset [33, 48] from the object at 'flow_keys' is out of the bounds of referenced subobject 'ipv6_src' with type '__u32[4]' {aka 'unsigned int[4]'} at offset 16 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r025-20210222
|   `-- drivers-media-radio-wl128x-fmdrv_common.c:warning:array-subscript-is-outside-array-bounds-of-u16-aka-short-unsigned-int
|-- i386-allyesconfig
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- i386-randconfig-r011-20210222
|   |-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
`-- i386-randconfig-s002-20210223
    `-- include-linux-fortify-string.h:warning:__builtin_memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset

elapsed time: 1120m

configs tested: 95
configs skipped: 3

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         at91_dt_defconfig
mips                     decstation_defconfig
m68k                       bvme6000_defconfig
arm                       versatile_defconfig
arm                        multi_v7_defconfig
alpha                            alldefconfig
powerpc                      ppc64e_defconfig
arm                           tegra_defconfig
powerpc                     ksi8560_defconfig
openrisc                    or1ksim_defconfig
powerpc                  mpc885_ads_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5307c3_defconfig
mips                        omega2p_defconfig
powerpc                     sbc8548_defconfig
powerpc                        warp_defconfig
openrisc                            defconfig
arm                        mini2440_defconfig
arm                       spear13xx_defconfig
sh                        sh7785lcr_defconfig
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
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
parisc                              defconfig
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
i386                 randconfig-a005-20210222
i386                 randconfig-a006-20210222
i386                 randconfig-a004-20210222
i386                 randconfig-a003-20210222
i386                 randconfig-a001-20210222
i386                 randconfig-a002-20210222
x86_64               randconfig-a001-20210222
x86_64               randconfig-a002-20210222
x86_64               randconfig-a003-20210222
x86_64               randconfig-a005-20210222
x86_64               randconfig-a006-20210222
x86_64               randconfig-a004-20210222
i386                 randconfig-a013-20210222
i386                 randconfig-a012-20210222
i386                 randconfig-a011-20210222
i386                 randconfig-a014-20210222
i386                 randconfig-a015-20210222
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
x86_64               randconfig-a015-20210222
x86_64               randconfig-a011-20210222
x86_64               randconfig-a012-20210222
x86_64               randconfig-a016-20210222
x86_64               randconfig-a014-20210222
x86_64               randconfig-a013-20210222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
