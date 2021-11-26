Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA2645F062
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377925AbhKZPP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:15:28 -0500
Received: from mga07.intel.com ([134.134.136.100]:54427 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353970AbhKZPN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:13:27 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10179"; a="299079762"
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="299079762"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 07:09:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,266,1631602800"; 
   d="scan'208";a="742375845"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 26 Nov 2021 07:09:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mqcqX-0008H5-MB; Fri, 26 Nov 2021 15:09:05 +0000
Date:   Fri, 26 Nov 2021 23:08:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luo bin <luobin9@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse:
 sparse: cast to restricted __be64
Message-ID: <202111262338.GOesGUUr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4849f6000e29235a2707f22e39da6b897bb9543
commit: a425b6e1c69ba907b72b737a4d44f8cfbc43ce3c hinic: add mailbox function support
date:   1 year, 7 months ago
config: x86_64-randconfig-s022-20211124 (https://download.01.org/0day-ci/archive/20211126/202111262338.GOesGUUr-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a425b6e1c69ba907b72b737a4d44f8cfbc43ce3c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a425b6e1c69ba907b72b737a4d44f8cfbc43ce3c
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:543:54: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:543:54: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:543:54: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:566:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned char [usertype] * @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:566:58: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:566:58: sparse:     got unsigned char [usertype] *
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:601:6: sparse: sparse: symbol 'dump_mox_reg' was not declared. Should it be static?
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:1057:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *data @@     got void [noderef] <asn:2> * @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:1057:25: sparse:     expected unsigned char [usertype] *data
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:1057:25: sparse:     got void [noderef] <asn:2> *
   drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c: note: in included file:
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:250:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     expected unsigned int val
   drivers/net/ethernet/huawei/hinic/hinic_hw_if.h:256:16: sparse:     got restricted __be32 [usertype]

vim +618 drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c

   614	
   615	static u16 get_mbox_status(struct hinic_send_mbox *mbox)
   616	{
   617		/* write back is 16B, but only use first 4B */
 > 618		u64 wb_val = be64_to_cpu(*mbox->wb_status);
   619	
   620		rmb(); /* verify reading before check */
   621	
   622		return (u16)(wb_val & MBOX_WB_STATUS_ERRCODE_MASK);
   623	}
   624	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
