Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 358364600D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355860AbhK0SKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 13:10:20 -0500
Received: from mga05.intel.com ([192.55.52.43]:11255 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235498AbhK0SIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 13:08:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="322006868"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="322006868"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 10:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="458570673"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 27 Nov 2021 10:05:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr24M-0009qM-PW; Sat, 27 Nov 2021 18:05:02 +0000
Date:   Sun, 28 Nov 2021 02:04:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [drm-misc:for-linux-next 4/6] make[4]: *** No rule to make target
 'drivers/gpu/drm/drm_nomodeset.o', needed by 'drivers/gpu/drm/built-in.a'.
Message-ID: <202111280200.ZO66VwpH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

First bad commit (maybe != root cause):

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   db08490fc4b6695ada6c21e40343307f08d9620e
commit: e9aeeba26a8de1f553305722d017022ae7e79280 [4/6] drm: Decouple nomodeset from CONFIG_VGA_CONSOLE
config: hexagon-randconfig-r041-20211127 (https://download.01.org/0day-ci/archive/20211128/202111280200.ZO66VwpH-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout e9aeeba26a8de1f553305722d017022ae7e79280
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/gpu/drm/drm_nomodeset.o', needed by 'drivers/gpu/drm/built-in.a'.
   make[4]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
