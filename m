Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E41E45D5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 09:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349835AbhKYIFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 03:05:11 -0500
Received: from mga17.intel.com ([192.55.52.151]:39901 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352289AbhKYIDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 03:03:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="216174978"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="216174978"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 23:57:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="457312152"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2021 23:57:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq9dG-000600-Pr; Thu, 25 Nov 2021 07:57:26 +0000
Date:   Thu, 25 Nov 2021 15:57:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karol Kolacinski <karol.kolacinski@intel.com>
Cc:     kbuild-all@lists.01.org,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sudhansu Sekhar Mishra <sudhansu.mishra@intel.com>
Subject: [tnguy-next-queue:dev-queue 94/108] ice_gnss.c:undefined reference
 to `tty_buffer_request_room'
Message-ID: <202111251527.xSdxs2Xm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   1bc0d12c31e7e35dcb167e62c8bcde3c7c09d95d
commit: d837bf714865bcefbf83c3f4e7b886a50ecda8b1 [94/108] ice: add TTY for GNSS module for E810T device
config: arm64-buildonly-randconfig-r003-20211125 (https://download.01.org/0day-ci/archive/20211125/202111251527.xSdxs2Xm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=d837bf714865bcefbf83c3f4e7b886a50ecda8b1
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout d837bf714865bcefbf83c3f4e7b886a50ecda8b1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: in function `ice_gnss_read':
>> ice_gnss.c:(.text+0x204): undefined reference to `tty_buffer_request_room'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x270): undefined reference to `tty_insert_flip_string_fixed_flag'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x278): undefined reference to `tty_flip_buffer_push'
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: in function `ice_gnss_create_tty_driver':
>> ice_gnss.c:(.text+0x300): undefined reference to `__tty_alloc_driver'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x3c0): undefined reference to `tty_std_termios'
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `tty_std_termios' which may bind externally can not be used when making a shared object; recompile with -fPIC
   ice_gnss.c:(.text+0x3c0): dangerous relocation: unsupported relocation
   aarch64-linux-ld: ice_gnss.c:(.text+0x3c4): undefined reference to `tty_std_termios'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x488): undefined reference to `tty_termios_encode_baud_rate'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4b4): undefined reference to `tty_port_init'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4c4): undefined reference to `tty_port_link_device'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4cc): undefined reference to `tty_register_driver'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4d8): undefined reference to `tty_port_destroy'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x4f4): undefined reference to `tty_driver_kref_put'
   aarch64-linux-ld: drivers/net/ethernet/intel/ice/ice_gnss.o: in function `ice_gnss_exit':
>> ice_gnss.c:(.text+0x7b4): undefined reference to `tty_port_destroy'
>> aarch64-linux-ld: ice_gnss.c:(.text+0x7f0): undefined reference to `tty_unregister_driver'
   aarch64-linux-ld: ice_gnss.c:(.text+0x81c): undefined reference to `tty_driver_kref_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
