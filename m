Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764023CC8E4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jul 2021 13:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhGRLpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jul 2021 07:45:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:24695 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232851AbhGRLpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jul 2021 07:45:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10048"; a="191222998"
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; 
   d="scan'208";a="191222998"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2021 04:42:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,249,1620716400"; 
   d="scan'208";a="430144900"
Received: from lkp-server01.sh.intel.com (HELO a467b34d8c10) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jul 2021 04:42:41 -0700
Received: from kbuild by a467b34d8c10 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m55Bw-0000ED-RI; Sun, 18 Jul 2021 11:42:40 +0000
Date:   Sun, 18 Jul 2021 19:42:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:for-next/Warray-bounds] BUILD REGRESSION
 0d6455c92b82b36e29e5206a46329058d75fbc33
Message-ID: <60f4138b.6j0tYIOJm9mNiMYY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git for-next/Warray-bounds
branch HEAD: 0d6455c92b82b36e29e5206a46329058d75fbc33  Makefile: Enable -Warray-bounds

Error/Warning in current branch:

arch/arm/kernel/atags_compat.c:200:2: warning: 'strcpy' offset 364 from the object at 'tags' is out of the bounds of referenced subobject 'cmdline' with type 'char[1]' at offset 364 [-Warray-bounds]
arch/sparc/kernel/irq_32.c:258:7: error: array subscript [16, 79] is outside array bounds of 'struct tt_entry[1]' [-Werror=array-bounds]

possible Error/Warning in current branch:

arch/arm/mm/dma-mapping.c:395:15: warning: array subscript <unknown> is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Warray-bounds]
arch/arm/mm/dma-mapping.c:404:36: warning: array subscript i is outside array bounds of 'struct dma_contig_early_reserve[0]' [-Warray-bounds]
arch/xtensa/kernel/process.c:255:24: warning: array subscript 53 is above array bounds of 'long unsigned int[16]' [-Warray-bounds]
drivers/net/ethernet/i825xx/sun3_82586.c:993:108: warning: array subscript 1 is above array bounds of 'volatile struct transmit_cmd_struct *[1]' [-Warray-bounds]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-alldefconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-am200epdkit_defconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-collie_defconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-lpc32xx_defconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-neponset_defconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-pxa3xx_defconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-randconfig-r003-20210715
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-randconfig-r035-20210715
|   `-- arch-arm-kernel-atags_compat.c:warning:strcpy-offset-from-the-object-at-tags-is-out-of-the-bounds-of-referenced-subobject-cmdline-with-type-char-at-offset
|-- arm-spear13xx_defconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- arm-tct_hammer_defconfig
|   |-- arch-arm-mm-dma-mapping.c:warning:array-subscript-i-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|   `-- arch-arm-mm-dma-mapping.c:warning:array-subscript-unknown-is-outside-array-bounds-of-struct-dma_contig_early_reserve
|-- m68k-sun3_defconfig
|   `-- drivers-net-ethernet-i825xx-sun3_82586.c:warning:array-subscript-is-above-array-bounds-of-volatile-struct-transmit_cmd_struct
|-- sparc-randconfig-p002-20210715
|   `-- arch-sparc-kernel-irq_32.c:error:array-subscript-is-outside-array-bounds-of-struct-tt_entry
`-- xtensa-allyesconfig
    `-- arch-xtensa-kernel-process.c:warning:array-subscript-is-above-array-bounds-of-long-unsigned-int

elapsed time: 5099m

configs tested: 176
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                              allmodconfig
powerpc                       ebony_defconfig
mips                             allyesconfig
arm                     am200epdkit_defconfig
sh                           se7619_defconfig
openrisc                  or1klitex_defconfig
mips                         db1xxx_defconfig
mips                      malta_kvm_defconfig
s390                             allyesconfig
sh                          sdk7786_defconfig
powerpc                   currituck_defconfig
sh                   secureedge5410_defconfig
sparc                            alldefconfig
m68k                           sun3_defconfig
powerpc                 mpc832x_mds_defconfig
ia64                          tiger_defconfig
m68k                            mac_defconfig
powerpc                     stx_gp3_defconfig
arm                            mps2_defconfig
arm                      tct_hammer_defconfig
mips                     decstation_defconfig
arc                            hsdk_defconfig
arm                             ezx_defconfig
openrisc                 simple_smp_defconfig
sh                        sh7757lcr_defconfig
arm                  colibri_pxa300_defconfig
sh                           se7705_defconfig
powerpc                     sequoia_defconfig
mips                  decstation_64_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7264_defconfig
arc                      axs103_smp_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                         wii_defconfig
arm                       versatile_defconfig
sh                          rsk7201_defconfig
arc                          axs101_defconfig
powerpc                      chrp32_defconfig
mips                            ar7_defconfig
powerpc                     tqm8555_defconfig
powerpc               mpc834x_itxgp_defconfig
sh                         apsh4a3a_defconfig
m68k                       m5249evb_defconfig
powerpc                      pmac32_defconfig
sh                          sdk7780_defconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
mips                         rt305x_defconfig
xtensa                generic_kc705_defconfig
sh                ecovec24-romimage_defconfig
arm                         lpc32xx_defconfig
mips                         tb0226_defconfig
powerpc                 mpc837x_mds_defconfig
arm                           stm32_defconfig
arc                           tb10x_defconfig
sh                     magicpanelr2_defconfig
powerpc                   bluestone_defconfig
mips                         tb0219_defconfig
sh                        sh7763rdp_defconfig
h8300                               defconfig
sh                                  defconfig
arc                     haps_hs_smp_defconfig
arm                          collie_defconfig
arm                           sunxi_defconfig
arc                        nsimosci_defconfig
mips                           ip28_defconfig
arm                         s3c6400_defconfig
powerpc                       holly_defconfig
arm                          pxa3xx_defconfig
arm                        realview_defconfig
arm                        keystone_defconfig
sh                         ecovec24_defconfig
xtensa                  nommu_kc705_defconfig
arm                              alldefconfig
arm                        shmobile_defconfig
arm                        neponset_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
ia64                             allmodconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20210714
x86_64               randconfig-a004-20210714
x86_64               randconfig-a002-20210714
x86_64               randconfig-a003-20210714
x86_64               randconfig-a006-20210714
x86_64               randconfig-a001-20210714
i386                 randconfig-a005-20210715
i386                 randconfig-a006-20210715
i386                 randconfig-a004-20210715
i386                 randconfig-a001-20210715
i386                 randconfig-a002-20210715
i386                 randconfig-a003-20210715
i386                 randconfig-a005-20210714
i386                 randconfig-a006-20210714
i386                 randconfig-a004-20210714
i386                 randconfig-a001-20210714
i386                 randconfig-a003-20210714
i386                 randconfig-a002-20210714
x86_64               randconfig-a013-20210715
x86_64               randconfig-a012-20210715
x86_64               randconfig-a015-20210715
x86_64               randconfig-a014-20210715
x86_64               randconfig-a016-20210715
x86_64               randconfig-a011-20210715
i386                 randconfig-a014-20210715
i386                 randconfig-a015-20210715
i386                 randconfig-a011-20210715
i386                 randconfig-a013-20210715
i386                 randconfig-a012-20210715
i386                 randconfig-a016-20210715
i386                 randconfig-a014-20210714
i386                 randconfig-a015-20210714
i386                 randconfig-a011-20210714
i386                 randconfig-a013-20210714
i386                 randconfig-a012-20210714
i386                 randconfig-a016-20210714
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210715
x86_64               randconfig-b001-20210716
x86_64               randconfig-a005-20210715
x86_64               randconfig-a004-20210715
x86_64               randconfig-a002-20210715
x86_64               randconfig-a003-20210715
x86_64               randconfig-a006-20210715
x86_64               randconfig-a001-20210715
x86_64               randconfig-a013-20210714
x86_64               randconfig-a015-20210714
x86_64               randconfig-a012-20210714
x86_64               randconfig-a014-20210714
x86_64               randconfig-a016-20210714
x86_64               randconfig-a011-20210714

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
