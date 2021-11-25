Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7340E45D238
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 01:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245107AbhKYAtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 19:49:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:61525 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244470AbhKYArX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 19:47:23 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10178"; a="232904911"
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="232904911"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 16:44:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,261,1631602800"; 
   d="scan'208";a="457211819"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 24 Nov 2021 16:44:11 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mq2ry-0005Wy-MZ; Thu, 25 Nov 2021 00:44:10 +0000
Date:   Thu, 25 Nov 2021 08:43:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mcgrof-next:20211123-sysctl-cleanups 21/41] ERROR: modpost:
 "register_sysctl_mount_point" [fs/binfmt_misc.ko] undefined!
Message-ID: <202111250803.RotVySMo-lkp@intel.com>
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211125/202111250803.RotVySMo-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git/commit/?id=aa450826c557300623f8e3f1ff398b306a7551e9
        git remote add mcgrof-next https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux-next.git
        git fetch --no-tags mcgrof-next 20211123-sysctl-cleanups
        git checkout aa450826c557300623f8e3f1ff398b306a7551e9
        # save the config file to linux build tree
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "register_sysctl_mount_point" [fs/binfmt_misc.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
