Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AC245E9B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 09:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353442AbhKZI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 03:59:42 -0500
Received: from mga14.intel.com ([192.55.52.115]:32988 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245041AbhKZI5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 03:57:38 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="235874180"
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="235874180"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 00:54:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,265,1631602800"; 
   d="scan'208";a="592230247"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Nov 2021 00:54:21 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqWzs-0007rf-WC; Fri, 26 Nov 2021 08:54:21 +0000
Date:   Fri, 26 Nov 2021 16:54:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: drivers/block/zram/zram_drv.c:1824:45: warning: unused variable
 'zram_wb_devops'
Message-ID: <202111261614.gCJMqcyh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: a8b456d01cd6b37191f14248f3e2bdbe5ce3a89e bdi: remove BDI_CAP_SYNCHRONOUS_IO
date:   1 year, 2 months ago
config: x86_64-buildonly-randconfig-r003-20211116 (https://download.01.org/0day-ci/archive/20211126/202111261614.gCJMqcyh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project fbe72e41b99dc7994daac300d208a955be3e4a0a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8b456d01cd6b37191f14248f3e2bdbe5ce3a89e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a8b456d01cd6b37191f14248f3e2bdbe5ce3a89e
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/block/zram/zram_drv.c:1824:45: warning: unused variable 'zram_wb_devops' [-Wunused-const-variable]
   static const struct block_device_operations zram_wb_devops = {
                                               ^
   1 warning generated.


vim +/zram_wb_devops +1824 drivers/block/zram/zram_drv.c

  1823	
> 1824	static const struct block_device_operations zram_wb_devops = {
  1825		.open = zram_open,
  1826		.submit_bio = zram_submit_bio,
  1827		.swap_slot_free_notify = zram_slot_free_notify,
  1828		.owner = THIS_MODULE
  1829	};
  1830	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
