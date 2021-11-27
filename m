Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2472E460009
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 17:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355599AbhK0QGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 11:06:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:60995 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232068AbhK0QEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 11:04:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="233261908"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="233261908"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 08:01:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="457965337"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 27 Nov 2021 08:00:59 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr08J-0009j4-21; Sat, 27 Nov 2021 16:00:59 +0000
Date:   Sun, 28 Nov 2021 00:00:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [drm-misc:for-linux-next 4/6] make[4]: *** No rule to make target
 'drivers/gpu/drm/drm_nomodeset.o', needed by 'drivers/gpu/drm/built-in.a'.
Message-ID: <202111272319.8Ls3ezpr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://anongit.freedesktop.org/drm/drm-misc for-linux-next
head:   db08490fc4b6695ada6c21e40343307f08d9620e
commit: e9aeeba26a8de1f553305722d017022ae7e79280 [4/6] drm: Decouple nomodeset from CONFIG_VGA_CONSOLE
config: i386-randconfig-m021-20211127 (https://download.01.org/0day-ci/archive/20211127/202111272319.8Ls3ezpr-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        git remote add drm-misc git://anongit.freedesktop.org/drm/drm-misc
        git fetch --no-tags drm-misc for-linux-next
        git checkout e9aeeba26a8de1f553305722d017022ae7e79280
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[4]: *** No rule to make target 'drivers/gpu/drm/drm_nomodeset.o', needed by 'drivers/gpu/drm/built-in.a'.
   make[4]: Target '__build' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
