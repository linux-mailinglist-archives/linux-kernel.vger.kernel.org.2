Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4205C45FCA8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 06:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbhK0FLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 00:11:54 -0500
Received: from mga11.intel.com ([192.55.52.93]:43748 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229452AbhK0FJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 00:09:52 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="233236154"
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="233236154"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 21:06:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,268,1631602800"; 
   d="scan'208";a="593662770"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Nov 2021 21:06:37 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqpv2-00095R-Rk; Sat, 27 Nov 2021 05:06:36 +0000
Date:   Sat, 27 Nov 2021 13:05:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tero Kristo <tero.kristo@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [t-kristo-pm:usi-5.16-rfc-v2-bpf 27/30] syscall.c:undefined
 reference to `hid_prog_detach'
Message-ID: <202111271317.2WIt2rDW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/t-kristo/linux-pm usi-5.16-rfc-v2-bpf
head:   241207b4769fca049dfcc4dbde0bda92e4f67027
commit: a6e125d8c63a6fd1214ecadcce4b317e57475f81 [27/30] DEBUG: bpf: syscall: add some debug traces
config: m68k-defconfig (https://download.01.org/0day-ci/archive/20211127/202111271317.2WIt2rDW-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/t-kristo/linux-pm/commit/a6e125d8c63a6fd1214ecadcce4b317e57475f81
        git remote add t-kristo-pm https://github.com/t-kristo/linux-pm
        git fetch --no-tags t-kristo-pm usi-5.16-rfc-v2-bpf
        git checkout a6e125d8c63a6fd1214ecadcce4b317e57475f81
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: kernel/bpf/syscall.o: in function `bpf_prog_attach':
   syscall.c:(.text+0x3888): undefined reference to `hid_prog_attach'
   m68k-linux-ld: kernel/bpf/syscall.o: in function `__sys_bpf':
>> syscall.c:(.text+0x4ae2): undefined reference to `hid_prog_detach'
   m68k-linux-ld: syscall.c:(.text+0x4b64): undefined reference to `hid_prog_query'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
