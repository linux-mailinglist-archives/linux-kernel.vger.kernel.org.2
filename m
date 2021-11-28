Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD437460581
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357060AbhK1Jvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 04:51:37 -0500
Received: from mga02.intel.com ([134.134.136.20]:48792 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243822AbhK1Jtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 04:49:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="223049536"
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="223049536"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 01:46:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,270,1631602800"; 
   d="scan'208";a="511271267"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2021 01:46:19 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrGlG-000AY7-NU; Sun, 28 Nov 2021 09:46:18 +0000
Date:   Sun, 28 Nov 2021 17:45:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luo bin <luobin9@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c:618:22: sparse:
 sparse: cast to restricted __be64
Message-ID: <202111281707.Z1jcCuXf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3498e7f2bb415e447354a3debef6738d9655768c
commit: a425b6e1c69ba907b72b737a4d44f8cfbc43ce3c hinic: add mailbox function support
date:   1 year, 7 months ago
config: x86_64-randconfig-s022-20211124 (https://download.01.org/0day-ci/archive/20211128/202111281707.Z1jcCuXf-lkp@intel.com/config)
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
