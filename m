Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C86E45D524
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 08:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352913AbhKYHLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 02:11:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:45762 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352957AbhKYHJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 02:09:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="235277320"
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="235277320"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 23:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,262,1631602800"; 
   d="scan'208";a="741087493"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 24 Nov 2021 23:06:25 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq8ps-0005wF-OT; Thu, 25 Nov 2021 07:06:24 +0000
Date:   Thu, 25 Nov 2021 15:05:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     LUU HOAI <hoai.luu.ub@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [kbingham-rcar:kbingham/vsp/v3u-5.16 6/50]
 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:100:9: warning: this decimal
 constant is unsigned only in ISO C90
Message-ID: <202111251504.Ogup5r16-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git kbingham/vsp/v3u-5.16
head:   ccac14c690227590a29f6d85289101f00de58ec6
commit: d4b0edb743a8a351c882f97b636f11f671e4f029 [6/50] drm: rcar-du: Add R-Car DSI driver
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211125/202111251504.Ogup5r16-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git/commit/?id=d4b0edb743a8a351c882f97b636f11f671e4f029
        git remote add kbingham-rcar https://git.kernel.org/pub/scm/linux/kernel/git/kbingham/rcar.git
        git fetch --no-tags kbingham-rcar kbingham/vsp/v3u-5.16
        git checkout d4b0edb743a8a351c882f97b636f11f671e4f029
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/gpu/drm/rcar-du/ drivers/net/ethernet/mellanox/mlx5/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:100:9: warning: this decimal constant is unsigned only in ISO C90
     100 |         { 2100000000, 0x41 }, { 2150000000, 0x42 }, { 2200000000, 0x43 },
         |         ^
>> drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:100:9: warning: this decimal constant is unsigned only in ISO C90
   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:101:9: warning: this decimal constant is unsigned only in ISO C90
     101 |         { 2250000000, 0x44 }, { 2300000000, 0x45 }, { 2350000000, 0x46 },
         |         ^
   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:101:9: warning: this decimal constant is unsigned only in ISO C90
   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:101:9: warning: this decimal constant is unsigned only in ISO C90
   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:102:9: warning: this decimal constant is unsigned only in ISO C90
     102 |         { 2400000000, 0x47 }, { 2450000000, 0x48 }, { 2500000000, 0x49 },
         |         ^
   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:102:9: warning: this decimal constant is unsigned only in ISO C90
   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c:102:9: warning: this decimal constant is unsigned only in ISO C90


vim +100 drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c

    80	
    81	static const u32 hsfreqrange_table[][2] = {
    82		{ 80000000,   0x00 }, { 90000000,   0x10 }, { 100000000,  0x20 },
    83		{ 110000000,  0x30 }, { 120000000,  0x01 }, { 130000000,  0x11 },
    84		{ 140000000,  0x21 }, { 150000000,  0x31 }, { 160000000,  0x02 },
    85		{ 170000000,  0x12 }, { 180000000,  0x22 }, { 190000000,  0x32 },
    86		{ 205000000,  0x03 }, { 220000000,  0x13 }, { 235000000,  0x23 },
    87		{ 250000000,  0x33 }, { 275000000,  0x04 }, { 300000000,  0x14 },
    88		{ 325000000,  0x25 }, { 350000000,  0x35 }, { 400000000,  0x05 },
    89		{ 450000000,  0x16 }, { 500000000,  0x26 }, { 550000000,  0x37 },
    90		{ 600000000,  0x07 }, { 650000000,  0x18 }, { 700000000,  0x28 },
    91		{ 750000000,  0x39 }, { 800000000,  0x09 }, { 850000000,  0x19 },
    92		{ 900000000,  0x29 }, { 950000000,  0x3a }, { 1000000000, 0x0a },
    93		{ 1050000000, 0x1a }, { 1100000000, 0x2a }, { 1150000000, 0x3b },
    94		{ 1200000000, 0x0b }, { 1250000000, 0x1b }, { 1300000000, 0x2b },
    95		{ 1350000000, 0x3c }, { 1400000000, 0x0c }, { 1450000000, 0x1c },
    96		{ 1500000000, 0x2c }, { 1550000000, 0x3d }, { 1600000000, 0x0d },
    97		{ 1650000000, 0x1d }, { 1700000000, 0x2e }, { 1750000000, 0x3e },
    98		{ 1800000000, 0x0e }, { 1850000000, 0x1e }, { 1900000000, 0x2f },
    99		{ 1950000000, 0x3f }, { 2000000000, 0x0f }, { 2050000000, 0x40 },
 > 100		{ 2100000000, 0x41 }, { 2150000000, 0x42 }, { 2200000000, 0x43 },
   101		{ 2250000000, 0x44 }, { 2300000000, 0x45 }, { 2350000000, 0x46 },
   102		{ 2400000000, 0x47 }, { 2450000000, 0x48 }, { 2500000000, 0x49 },
   103		{ /* sentinel */ },
   104	};
   105	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
