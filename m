Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7676C45FC60
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 04:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351653AbhK0D3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 22:29:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:2514 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237225AbhK0D1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 22:27:47 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="216444885"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="216444885"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 19:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="476054744"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Nov 2021 19:24:32 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqoKF-0008zx-8q; Sat, 27 Nov 2021 03:24:31 +0000
Date:   Sat, 27 Nov 2021 11:24:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@suse.de>
Subject: [driver-core:driver-core-testing 5/7]
 drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5:
 Error: file not found:
 drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin
Message-ID: <202111271140.XMh9IcBt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
head:   7f67ea9c19735222f7999754f3fee922cd8f4781
commit: 6a4e0b75cfa09e70c0aa39a03b478641cf2a7974 [5/7] test_firmware: add support for testing built-in firmware
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20211127/202111271140.XMh9IcBt-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/commit/?id=6a4e0b75cfa09e70c0aa39a03b478641cf2a7974
        git remote add driver-core https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
        git fetch --no-tags driver-core driver-core-testing
        git checkout 6a4e0b75cfa09e70c0aa39a03b478641cf2a7974
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S: Assembler messages:
>> drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin.gen.S:5: Error: file not found: drivers/base/firmware_loader/test-builtin/test-builtin-firmware.bin

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
