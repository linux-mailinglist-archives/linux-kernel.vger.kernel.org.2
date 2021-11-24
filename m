Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58D45B803
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 11:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbhKXKJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 05:09:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:38388 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241070AbhKXKJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 05:09:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="222123204"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="222123204"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 02:06:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="674809780"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 24 Nov 2021 02:06:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mppAn-0004dK-1i; Wed, 24 Nov 2021 10:06:41 +0000
Date:   Wed, 24 Nov 2021 18:06:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/ethernet/brocade/bna/bna_enet.c:412:38: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202111241741.DFG7ib1q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d9f4cf36721aba199975a9be7863a3ff5cd4b59
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   7 months ago
config: x86_64-randconfig-s022-20211124 (https://download.01.org/0day-ci/archive/20211124/202111241741.DFG7ib1q-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/brocade/bna/bna_enet.c:167:40: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:168:40: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:169:42: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:171:45: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:184:28: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:185:28: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:189:9: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/brocade/bna/bna_enet.c:190:9: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/brocade/bna/bna_enet.c:191:9: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/brocade/bna/bna_enet.c:192:9: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/brocade/bna/bna_enet.c:193:9: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/brocade/bna/bna_enet.c:194:9: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/brocade/bna/bna_enet.c:207:48: sparse: sparse: cast to restricted __be64
   drivers/net/ethernet/brocade/bna/bna_enet.c:222:48: sparse: sparse: cast to restricted __be64
>> drivers/net/ethernet/brocade/bna/bna_enet.c:412:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_entries @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:412:38: sparse:     expected unsigned short [usertype] num_entries
   drivers/net/ethernet/brocade/bna/bna_enet.c:412:38: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bna_enet.c:429:40: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_entries @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:429:40: sparse:     expected unsigned short [usertype] num_entries
   drivers/net/ethernet/brocade/bna/bna_enet.c:429:40: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bna_enet.c:446:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_entries @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:446:37: sparse:     expected unsigned short [usertype] num_entries
   drivers/net/ethernet/brocade/bna/bna_enet.c:446:37: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bna_enet.c:467:39: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_entries @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:467:39: sparse:     expected unsigned short [usertype] num_entries
   drivers/net/ethernet/brocade/bna/bna_enet.c:467:39: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bna_enet.c:1164:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_entries @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:1164:35: sparse:     expected unsigned short [usertype] num_entries
   drivers/net/ethernet/brocade/bna/bna_enet.c:1164:35: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bna_enet.c:1626:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_entries @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:1626:34: sparse:     expected unsigned short [usertype] num_entries
   drivers/net/ethernet/brocade/bna/bna_enet.c:1626:34: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bna_enet.c:1704:9: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:1704:9: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:1716:9: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:1716:9: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bna_enet.c:1848:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] num_entries @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:1848:35: sparse:     expected unsigned short [usertype] num_entries
   drivers/net/ethernet/brocade/bna/bna_enet.c:1848:35: sparse:     got restricted __be16 [usertype]
>> drivers/net/ethernet/brocade/bna/bna_enet.c:1850:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] stats_mask @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:1850:31: sparse:     expected unsigned short [usertype] stats_mask
   drivers/net/ethernet/brocade/bna/bna_enet.c:1850:31: sparse:     got restricted __be16 [usertype]
>> drivers/net/ethernet/brocade/bna/bna_enet.c:1851:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] tx_enet_mask @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:1851:33: sparse:     expected unsigned int [usertype] tx_enet_mask
   drivers/net/ethernet/brocade/bna/bna_enet.c:1851:33: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/brocade/bna/bna_enet.c:1852:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] rx_enet_mask @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bna_enet.c:1852:33: sparse:     expected unsigned int [usertype] rx_enet_mask
   drivers/net/ethernet/brocade/bna/bna_enet.c:1852:33: sparse:     got restricted __be32 [usertype]
--
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1924:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] clscode @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1924:28: sparse:     expected unsigned short [assigned] [usertype] clscode
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1924:28: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1925:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] rsvd @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1925:25: sparse:     expected unsigned short [assigned] [usertype] rsvd
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1925:25: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1927:29: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1938:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] clscode @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1938:29: sparse:     expected unsigned short [assigned] [usertype] clscode
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1938:29: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1939:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [assigned] [usertype] rsvd @@     got restricted __be16 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1939:26: sparse:     expected unsigned short [assigned] [usertype] rsvd
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1939:26: sparse:     got restricted __be16 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1941:30: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1904:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int val @@     got restricted __le32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1904:24: sparse:     expected unsigned int val
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:1904:24: sparse:     got restricted __le32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2106:31: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2107:31: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2108:31: sparse: sparse: cast to restricted __be16
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2210:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2423:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2423:25: sparse:     expected unsigned int [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:2423:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3069:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3071:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3074:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3102:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3104:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3107:23: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3141:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3148:40: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3149:39: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3152:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3154:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3156:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3158:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3160:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3162:41: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3169:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3177:26: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c:3182:35: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.c: note: in included file:
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     expected unsigned int [usertype] al_len
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     expected unsigned int [usertype] al_len
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32
>> drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] al_len @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     expected unsigned int [usertype] al_len
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:65:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:55:34: sparse: sparse: cast from restricted __be32
   drivers/net/ethernet/brocade/bna/bfa_ioc.h:56:34: sparse: sparse: cast from restricted __be32

vim +412 drivers/net/ethernet/brocade/bna/bna_enet.c

45979c1e424f6a Rasesh Mody 2011-08-08  403  
45979c1e424f6a Rasesh Mody 2011-08-08  404  static void
45979c1e424f6a Rasesh Mody 2011-08-08  405  bna_bfi_ethport_admin_up(struct bna_ethport *ethport)
45979c1e424f6a Rasesh Mody 2011-08-08  406  {
45979c1e424f6a Rasesh Mody 2011-08-08  407  	struct bfi_enet_enable_req *admin_up_req =
45979c1e424f6a Rasesh Mody 2011-08-08  408  		&ethport->bfi_enet_cmd.admin_req;
45979c1e424f6a Rasesh Mody 2011-08-08  409  
45979c1e424f6a Rasesh Mody 2011-08-08  410  	bfi_msgq_mhdr_set(admin_up_req->mh, BFI_MC_ENET,
45979c1e424f6a Rasesh Mody 2011-08-08  411  		BFI_ENET_H2I_PORT_ADMIN_UP_REQ, 0, 0);
45979c1e424f6a Rasesh Mody 2011-08-08 @412  	admin_up_req->mh.num_entries = htons(
45979c1e424f6a Rasesh Mody 2011-08-08  413  		bfi_msgq_num_cmd_entries(sizeof(struct bfi_enet_enable_req)));
45979c1e424f6a Rasesh Mody 2011-08-08  414  	admin_up_req->enable = BNA_STATUS_T_ENABLED;
45979c1e424f6a Rasesh Mody 2011-08-08  415  
45979c1e424f6a Rasesh Mody 2011-08-08  416  	bfa_msgq_cmd_set(&ethport->msgq_cmd, NULL, NULL,
45979c1e424f6a Rasesh Mody 2011-08-08  417  		sizeof(struct bfi_enet_enable_req), &admin_up_req->mh);
45979c1e424f6a Rasesh Mody 2011-08-08  418  	bfa_msgq_cmd_post(&ethport->bna->msgq, &ethport->msgq_cmd);
45979c1e424f6a Rasesh Mody 2011-08-08  419  }
45979c1e424f6a Rasesh Mody 2011-08-08  420  

:::::: The code at line 412 was first introduced by commit
:::::: 45979c1e424f6a14495a4988343df176cb745f84 bna: Introduce ENET as New Driver and FW Interface

:::::: TO: Rasesh Mody <rmody@brocade.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
