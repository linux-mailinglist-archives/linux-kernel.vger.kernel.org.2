Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3945F740
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 00:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbhKZXsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 18:48:37 -0500
Received: from mga18.intel.com ([134.134.136.126]:59130 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhKZXqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 18:46:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10180"; a="222597344"
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="222597344"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 15:43:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,267,1631602800"; 
   d="scan'208";a="539388532"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Nov 2021 15:43:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqksC-0008m0-BO; Fri, 26 Nov 2021 23:43:20 +0000
Date:   Sat, 27 Nov 2021 07:42:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>
Subject: panel-edp.c:undefined reference to `drm_panel_dp_aux_backlight'
Message-ID: <202111270725.XsJeMWsh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5c17547b778975b3d83a73c8d84e8fb5ecf3ba5
commit: 9d6366e743f37d36ef69347924ead7bcc596076e drm: fb_helper: improve CONFIG_FB dependency
date:   3 weeks ago
config: arm-qcom_defconfig (https://download.01.org/0day-ci/archive/20211127/202111270725.XsJeMWsh-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9d6366e743f37d36ef69347924ead7bcc596076e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9d6366e743f37d36ef69347924ead7bcc596076e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-edp.o: in function `panel_edp_probe':
>> panel-edp.c:(.text+0xf38): undefined reference to `drm_panel_dp_aux_backlight'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
