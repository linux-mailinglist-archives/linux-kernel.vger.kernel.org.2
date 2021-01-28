Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0824730754F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhA1L5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:57:51 -0500
Received: from mga11.intel.com ([192.55.52.93]:27000 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhA1L5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:57:49 -0500
IronPort-SDR: 4BR/Qn3Wtsg4z57dC2eW46uPXZbmG+6dLe0taaHaPKrA74jxZC+uNT6z79Zbdl3et/e6qhcTx3
 RTixwkmry15Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="176713266"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="176713266"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 03:57:06 -0800
IronPort-SDR: x8ow65TN2TKjlw+KfWE0aslhtLWG4WoQOw1EgOZ3HNwh8+sog/d2ZBTIPZQZCwiMzmfl0K4j9v
 jGQ+s+7dAMYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="408965869"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2021 03:57:04 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l55v6-0002rO-Cq; Thu, 28 Jan 2021 11:57:04 +0000
Date:   Thu, 28 Jan 2021 19:56:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 59ea5f1508e15cecddd8e2ca828f7962ea37adab
Message-ID: <6012a655.B/0fns54MZQclCv7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
branch HEAD: 59ea5f1508e15cecddd8e2ca828f7962ea37adab  locking/rtmutex: Add missing kernel-doc markup

Error/Warning reports:

https://lore.kernel.org/lkml/202101281034.2yevf7Rg-lkp@intel.com

Error/Warning in current branch:

include/linux/syscalls.h:238:18: error: conflicting types for 'sys_futex'
include/linux/syscalls.h:238:18: error: conflicting types for 'sys_futex_time32'

possible Error/Warning in current branch:

kernel/futex.c:3792:1: error: conflicting types for 'sys_futex'
kernel/futex.c:3988:1: error: conflicting types for 'sys_futex_time32'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- alpha-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- alpha-defconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- alpha-randconfig-r003-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- alpha-randconfig-r013-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- alpha-randconfig-r021-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arc-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arc-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arc-hsdk_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arc-randconfig-p001-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arc-randconfig-r016-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- arc-randconfig-r033-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- arc-randconfig-r034-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- arc-randconfig-s031-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- arc-tb10x_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-aspeed_g5_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-ep93xx_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-eseries_pxa_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-mvebu_v5_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-pxa910_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-tegra_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-u8500_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- arm-vexpress_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- c6x-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- c6x-randconfig-r002-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- c6x-randconfig-r003-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- c6x-randconfig-r023-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- c6x-randconfig-r033-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- c6x-randconfig-r034-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- c6x-randconfig-r035-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- csky-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- h8300-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- h8300-randconfig-m031-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- h8300-randconfig-r001-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- h8300-randconfig-r004-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- h8300-randconfig-s031-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- ia64-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- ia64-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- ia64-defconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- ia64-randconfig-r023-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- ia64-randconfig-r033-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-mac_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-mvme147_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-mvme16x_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-randconfig-r002-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-randconfig-r013-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-randconfig-r014-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-randconfig-r025-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- m68k-randconfig-r032-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- m68k-randconfig-s032-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- microblaze-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- microblaze-mmu_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- microblaze-randconfig-c003-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- microblaze-randconfig-r033-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- microblaze-randconfig-r036-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-ath79_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-bmips_be_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-capcella_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-decstation_r4k_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-gpr_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-lemote2f_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-loongson3_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-maltaup_xpa_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-pic32mzda_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-randconfig-c004-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- mips-rb532_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- mips-rt305x_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nds32-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nds32-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nds32-randconfig-r001-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- nds32-randconfig-r034-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nios2-3c120_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nios2-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nios2-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nios2-randconfig-c004-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- nios2-randconfig-m031-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- nios2-randconfig-r006-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- nios2-randconfig-r025-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- openrisc-or1ksim_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- openrisc-randconfig-r022-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- parisc-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- parisc-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- parisc-generic-32bit_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- parisc-randconfig-c003-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- parisc-randconfig-r021-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- parisc-randconfig-r035-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-g5_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-lite5200b_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-mgcoge_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-mpc8313_rdb_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-mpc83xx_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-ppa8548_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-ppc44x_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-pseries_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-randconfig-c003-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- powerpc-randconfig-c004-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- powerpc-randconfig-r016-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-randconfig-r026-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- powerpc-sam440ep_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-stx_gp3_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc-xes_mpc85xx_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc64-randconfig-r012-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- powerpc64-randconfig-s031-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- riscv-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- riscv-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- riscv-defconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- riscv-nommu_k210_defconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- riscv-nommu_virt_defconfig
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- riscv-rv32_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- sh-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- sh-randconfig-c003-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- sh-randconfig-r036-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- sparc-alldefconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- sparc-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- sparc-defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- sparc-randconfig-r004-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- sparc-randconfig-r022-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- sparc64-allmodconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- sparc64-randconfig-p002-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- sparc64-randconfig-r034-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- um-i386_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- xtensa-allyesconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- xtensa-randconfig-c004-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- xtensa-randconfig-r013-20210128
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
|-- xtensa-randconfig-r031-20210128
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|-- xtensa-virt_defconfig
|   |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
|   `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32
`-- xtensa-xip_kc705_defconfig
    |-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex
    `-- include-linux-syscalls.h:error:conflicting-types-for-sys_futex_time32

clang_recent_errors
|-- arm-randconfig-r024-20210128
|   `-- kernel-futex.c:error:conflicting-types-for-sys_futex
`-- mips-randconfig-r023-20210128
    `-- kernel-futex.c:error:conflicting-types-for-sys_futex_time32

elapsed time: 721m

configs tested: 136
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
sh                           se7724_defconfig
arm                           u8500_defconfig
h8300                    h8300h-sim_defconfig
mips                      loongson3_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      mgcoge_defconfig
powerpc                          g5_defconfig
arm                     eseries_pxa_defconfig
xtensa                    xip_kc705_defconfig
mips                            gpr_defconfig
arm                          pxa910_defconfig
m68k                        mvme16x_defconfig
sparc                            alldefconfig
arm                        vexpress_defconfig
mips                          rb532_defconfig
um                             i386_defconfig
mips                    maltaup_xpa_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
sh                            migor_defconfig
powerpc                     ppa8548_defconfig
xtensa                           allyesconfig
mips                      pic32mzda_defconfig
powerpc                     pseries_defconfig
arm                          ep93xx_defconfig
openrisc                    or1ksim_defconfig
sh                         apsh4a3a_defconfig
arm                       aspeed_g5_defconfig
arm                        mvebu_v5_defconfig
m68k                       m5275evb_defconfig
powerpc                      ppc44x_defconfig
sh                            titan_defconfig
arc                           tb10x_defconfig
m68k                        mvme147_defconfig
m68k                        m5272c3_defconfig
powerpc                   lite5200b_defconfig
m68k                            mac_defconfig
xtensa                         virt_defconfig
mips                       capcella_defconfig
parisc                generic-32bit_defconfig
microblaze                      mmu_defconfig
c6x                        evmc6474_defconfig
powerpc                      tqm8xx_defconfig
arm                          moxart_defconfig
mips                         bigsur_defconfig
arc                        nsim_700_defconfig
ia64                         bigsur_defconfig
powerpc                 canyonlands_defconfig
powerpc                  mpc885_ads_defconfig
nios2                         3c120_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                 mpc8313_rdb_defconfig
arc                            hsdk_defconfig
mips                        bcm63xx_defconfig
powerpc                    sam440ep_defconfig
arm                           tegra_defconfig
mips                          ath79_defconfig
sh                          r7780mp_defconfig
mips                       lemote2f_defconfig
mips                 decstation_r4k_defconfig
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
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                             allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210128
i386                 randconfig-a006-20210128
i386                 randconfig-a001-20210128
i386                 randconfig-a002-20210128
i386                 randconfig-a004-20210128
i386                 randconfig-a005-20210128
x86_64               randconfig-a012-20210128
x86_64               randconfig-a015-20210128
x86_64               randconfig-a016-20210128
x86_64               randconfig-a011-20210128
x86_64               randconfig-a013-20210128
x86_64               randconfig-a014-20210128
i386                 randconfig-a013-20210128
i386                 randconfig-a011-20210128
i386                 randconfig-a012-20210128
i386                 randconfig-a016-20210128
i386                 randconfig-a014-20210128
i386                 randconfig-a015-20210128
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
x86_64               randconfig-a002-20210128
x86_64               randconfig-a003-20210128
x86_64               randconfig-a001-20210128
x86_64               randconfig-a005-20210128
x86_64               randconfig-a006-20210128
x86_64               randconfig-a004-20210128

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
