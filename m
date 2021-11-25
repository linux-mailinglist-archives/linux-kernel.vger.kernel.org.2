Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CFF45D903
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 12:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239356AbhKYLUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 06:20:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:44104 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233194AbhKYLSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 06:18:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="296302819"
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="296302819"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2021 03:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,263,1631602800"; 
   d="scan'208";a="675217192"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 25 Nov 2021 03:15:34 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqCiz-0006Gr-En; Thu, 25 Nov 2021 11:15:33 +0000
Date:   Thu, 25 Nov 2021 19:14:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20211123-sysctl-cleanups 21/41] ERROR: modpost:
 "register_sysctl_mount_point" [fs/binfmt_misc.ko] undefined!
Message-ID: <202111251948.0sVcYrOo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git 20211123-sysctl-cleanups
head:   c18add41d859b4feec081eab6cfd624a5642973d
commit: aa450826c557300623f8e3f1ff398b306a7551e9 [21/41] fs: move binfmt_misc sysctl to its own file
config: i386-randconfig-a012-20211123 (https://download.01.org/0day-ci/archive/20211125/202111251948.0sVcYrOo-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 49e3838145dff1ec91c2e67a2cb562775c8d2a08)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=aa450826c557300623f8e3f1ff398b306a7551e9
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211123-sysctl-cleanups
        git checkout aa450826c557300623f8e3f1ff398b306a7551e9
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "register_sysctl_mount_point" [fs/binfmt_misc.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
