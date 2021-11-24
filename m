Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78CDD45B310
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 05:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240914AbhKXEXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 23:23:46 -0500
Received: from mga17.intel.com ([192.55.52.151]:42047 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236160AbhKXEXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 23:23:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="215908876"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="215908876"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 20:20:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="497532862"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2021 20:20:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpjll-0004IQ-Ay; Wed, 24 Nov 2021 04:20:29 +0000
Date:   Wed, 24 Nov 2021 12:19:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20211123-sysctl-cleanups 20/41]
 include/linux/sysctl.h:228:30: error: 'register_sysctl_mount_point' defined
 but not used
Message-ID: <202111241256.mDFmnx1e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211123-sysctl-cleanups
head:   c18add41d859b4feec081eab6cfd624a5642973d
commit: 06d33569add5d71725a727d8da80ce480b06fdec [20/41] sysctl: add helper to register a sysctl mount point
config: nds32-randconfig-r006-20211123 (https://download.01.org/0day-ci/archive/20211124/202111241256.mDFmnx1e-lkp@intel.com/config.gz)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=06d33569add5d71725a727d8da80ce480b06fdec
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211123-sysctl-cleanups
        git checkout 06d33569add5d71725a727d8da80ce480b06fdec
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/umh.h:9,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from lib/test_bitops.c:9:
   include/linux/sysctl.h: In function 'register_sysctl_mount_point':
   include/linux/sysctl.h:231:1: error: expected ';' before '}' token
     231 | }
         | ^
   At top level:
>> include/linux/sysctl.h:228:30: error: 'register_sysctl_mount_point' defined but not used [-Werror=unused-function]
     228 | static struct sysctl_header *register_sysctl_mount_point(const char *path)
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/register_sysctl_mount_point +228 include/linux/sysctl.h

   227	
 > 228	static struct sysctl_header *register_sysctl_mount_point(const char *path)
   229	{
   230		return NULL
 > 231	}
   232	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
