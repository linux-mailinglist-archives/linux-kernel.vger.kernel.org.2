Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0213607D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 12:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhDOK4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 06:56:54 -0400
Received: from mga17.intel.com ([192.55.52.151]:47150 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231771AbhDOK4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 06:56:52 -0400
IronPort-SDR: 2zo0YfJH7uLiPTd7UPiFhBGJ/iv6X1HdmEoAW65U3LUjhbBVclgCLDfIsXgX51Vpr20yCEB61/
 Mgp1hT2nZSyw==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="174937422"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="174937422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 03:56:28 -0700
IronPort-SDR: a+YiYi3zpH7BQMlvSBMLdkkAQtGn2ZQ97hAmXS+4W0JpkDKgUaHbbheCnIayxDLy0AJVkbj2ue
 u4shxIhb3CMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="452868345"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2021 03:56:25 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWzfd-0000tS-8s; Thu, 15 Apr 2021 10:56:25 +0000
Date:   Thu, 15 Apr 2021 18:55:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars-linux:testing/warray-bounds] BUILD SUCCESS WITH
 WARNING 4695107c157dd670a5fc1b1d3ccbfdc440caca24
Message-ID: <60781bae.YnX1Ijq/hyZ9Ji4d%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/warray-bounds
branch HEAD: 4695107c157dd670a5fc1b1d3ccbfdc440caca24  iommu/vt-d: Fix out-bounds-warning in intel_svm_page_response()

Warning reports:

https://lore.kernel.org/lkml/202104150800.c2oqp0YW-lkp@intel.com
https://lore.kernel.org/lkml/202104150913.hupgUSHL-lkp@intel.com

Warning in current branch:

arch/alpha/include/asm/string.h:22:16: warning: '__builtin_memcpy' offset [3, 64] from the object at 'report' is out of the bounds of referenced subobject 'report' with type 'unsigned char' at offset 1 [-Warray-bounds]
net/core/flow_dissector.c:835:3: warning: 'memcpy' offset [33, 48] from the object at 'flow_keys' is out of the bounds of referenced subobject 'ipv6_src' with type '__u32[4]' {aka 'unsigned int[4]'} at offset 16 [-Warray-bounds]
net/ethtool/ioctl.c:492:2: warning: 'memcpy' offset [49, 84] from the object at 'link_usettings' is out of the bounds of referenced subobject 'base' with type 'struct ethtool_link_settings' at offset 0 [-Warray-bounds]

possible Warning in current branch:

arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [12, 16] from the object at 'com' is out of the bounds of referenced subobject 'config' with type 'unsigned char' at offset 10 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [17, 20] from the object at 'settings' is out of the bounds of referenced subobject 'advertising' with type 'long long unsigned int' at offset 8 [-Warray-bounds]
arch/x86/include/asm/string_32.h:182:25: warning: '__builtin_memcpy' offset [9, 12] from the object at 'settings' is out of the bounds of referenced subobject 'supported' with type 'long long unsigned int' at offset 0 [-Warray-bounds]
drivers/ide/ide-ioctls.c:213:2: warning: 'memcpy' offset [3, 7] from the object at 'cmd' is out of the bounds of referenced subobject 'feature' with type 'unsigned char' at offset 1 [-Warray-bounds]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-randconfig-r032-20210414
|   `-- arch-alpha-include-asm-string.h:warning:__builtin_memcpy-offset-from-the-object-at-report-is-out-of-the-bounds-of-referenced-subobject-report-with-type-unsigned-char-at-offset
|-- arm-exynos_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-imote2_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-integrator_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-keystone_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-lpd270_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-omap2plus_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-pleb_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-realview_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm-shannon_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- arm64-defconfig
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- i386-randconfig-a004-20210414
|   |-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-advertising-with-type-long-long-unsigned-int-at-offset
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-settings-is-out-of-the-bounds-of-referenced-subobject-supported-with-type-long-long-unsigned-int-at-offset
|-- i386-randconfig-a012-20210414
|   `-- arch-x86-include-asm-string_32.h:warning:__builtin_memcpy-offset-from-the-object-at-com-is-out-of-the-bounds-of-referenced-subobject-config-with-type-unsigned-char-at-offset
|-- ia64-allmodconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- ia64-allyesconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- ia64-defconfig
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- ia64-gensparse_defconfig
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- ia64-randconfig-r006-20210414
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- nds32-allyesconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- parisc-allyesconfig
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- parisc-defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- parisc-randconfig-p002-20210414
|   `-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|-- parisc-randconfig-r014-20210415
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-acadia_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-ksi8560_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-makalu_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-motionpro_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-mpc8272_ads_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-mpc834x_itx_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-mpc836x_mds_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-mpc885_ads_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-ppa8548_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-ppc64_defconfig
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- powerpc-taishan_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- powerpc-tqm8555_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- riscv-defconfig
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- riscv-rv32_defconfig
|   `-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|-- s390-defconfig
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- x86_64-defconfig
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- x86_64-kexec
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- x86_64-randconfig-a013-20210414
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- x86_64-randconfig-a015-20210414
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- x86_64-randconfig-a016-20210414
|   |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- x86_64-randconfig-m001-20210415
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
|-- x86_64-randconfig-r026-20210414
|   |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
|   `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset
`-- x86_64-randconfig-s022-20210414
    |-- drivers-ide-ide-ioctls.c:warning:memcpy-offset-from-the-object-at-cmd-is-out-of-the-bounds-of-referenced-subobject-feature-with-type-unsigned-char-at-offset
    |-- net-core-flow_dissector.c:warning:memcpy-offset-from-the-object-at-flow_keys-is-out-of-the-bounds-of-referenced-subobject-ipv6_src-with-type-__u32-aka-unsigned-int-at-offset
    `-- net-ethtool-ioctl.c:warning:memcpy-offset-from-the-object-at-link_usettings-is-out-of-the-bounds-of-referenced-subobject-base-with-type-struct-ethtool_link_settings-at-offset

elapsed time: 726m

configs tested: 127
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
xtensa                    xip_kc705_defconfig
sparc64                          alldefconfig
ia64                      gensparse_defconfig
arc                          axs103_defconfig
sh                          urquell_defconfig
arm                            mmp2_defconfig
arm                       cns3420vb_defconfig
powerpc                          g5_defconfig
arm                         palmz72_defconfig
arm                       aspeed_g4_defconfig
sh                          rsk7269_defconfig
arm                        realview_defconfig
mips                      maltaaprp_defconfig
sh                         ap325rxa_defconfig
mips                      fuloong2e_defconfig
powerpc                 mpc8272_ads_defconfig
riscv                            alldefconfig
arm                          exynos_defconfig
xtensa                          iss_defconfig
powerpc                     ksi8560_defconfig
powerpc                     ppa8548_defconfig
m68k                        m5407c3_defconfig
powerpc                    klondike_defconfig
sh                        apsh4ad0a_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
mips                   sb1250_swarm_defconfig
arm                         shannon_defconfig
powerpc                  mpc885_ads_defconfig
nds32                            alldefconfig
powerpc                      acadia_defconfig
arm                          imote2_defconfig
alpha                            alldefconfig
arm                            pleb_defconfig
arm                           stm32_defconfig
powerpc                     taishan_defconfig
arm                        keystone_defconfig
mips                        nlm_xlr_defconfig
arm                       omap2plus_defconfig
xtensa                generic_kc705_defconfig
arm                      integrator_defconfig
powerpc                       ppc64_defconfig
powerpc                     tqm8555_defconfig
arm                          lpd270_defconfig
powerpc                   motionpro_defconfig
powerpc                 mpc834x_itx_defconfig
mips                         db1xxx_defconfig
sh                   rts7751r2dplus_defconfig
powerpc                      makalu_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210414
i386                 randconfig-a006-20210414
i386                 randconfig-a001-20210414
i386                 randconfig-a005-20210414
i386                 randconfig-a004-20210414
i386                 randconfig-a002-20210414
x86_64               randconfig-a014-20210414
x86_64               randconfig-a015-20210414
x86_64               randconfig-a011-20210414
x86_64               randconfig-a013-20210414
x86_64               randconfig-a012-20210414
x86_64               randconfig-a016-20210414
i386                 randconfig-a015-20210414
i386                 randconfig-a014-20210414
i386                 randconfig-a013-20210414
i386                 randconfig-a012-20210414
i386                 randconfig-a016-20210414
i386                 randconfig-a011-20210414
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210414
x86_64               randconfig-a002-20210414
x86_64               randconfig-a005-20210414
x86_64               randconfig-a001-20210414
x86_64               randconfig-a006-20210414
x86_64               randconfig-a004-20210414

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
