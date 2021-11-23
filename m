Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA90445AD63
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 21:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhKWUbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 15:31:02 -0500
Received: from mga11.intel.com ([192.55.52.93]:60826 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhKWUbB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 15:31:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="232618871"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="232618871"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 12:27:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="456816721"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 23 Nov 2021 12:27:50 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpcOM-0002G1-0O; Tue, 23 Nov 2021 20:27:50 +0000
Date:   Wed, 24 Nov 2021 04:27:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/net/usb/lan78xx.c:2963:27: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202111240417.62gcvdWw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: d991bb1c8da842a2a0b9dc83b1005e655783f861 include/linux/compiler-gcc.h: sparse can do constant folding of __builtin_bswap*()
date:   7 months ago
config: i386-randconfig-s002-20211123 (https://download.01.org/0day-ci/archive/20211124/202111240417.62gcvdWw-lkp@intel.com/config.gz)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d991bb1c8da842a2a0b9dc83b1005e655783f861
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d991bb1c8da842a2a0b9dc83b1005e655783f861
        # save the config file to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/net/usb/lan78xx.c:2963:29: sparse: sparse: cast to restricted __be16
>> drivers/net/usb/lan78xx.c:2963:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __wsum [usertype] csum @@     got unsigned short [usertype] @@
   drivers/net/usb/lan78xx.c:2963:27: sparse:     expected restricted __wsum [usertype] csum
   drivers/net/usb/lan78xx.c:2963:27: sparse:     got unsigned short [usertype]

vim +2963 drivers/net/usb/lan78xx.c

55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2949  
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2950  static void lan78xx_rx_csum_offload(struct lan78xx_net *dev,
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2951  				    struct sk_buff *skb,
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2952  				    u32 rx_cmd_a, u32 rx_cmd_b)
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2953  {
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2954  	/* HW Checksum offload appears to be flawed if used when not stripping
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2955  	 * VLAN headers. Drop back to S/W checksums under these conditions.
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2956  	 */
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2957  	if (!(dev->net->features & NETIF_F_RXCSUM) ||
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2958  	    unlikely(rx_cmd_a & RX_CMD_A_ICSM_) ||
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2959  	    ((rx_cmd_a & RX_CMD_A_FVTG_) &&
9343ac87f2a4e0 Dave Stevenson            2018-06-25  2960  	     !(dev->net->features & NETIF_F_HW_VLAN_CTAG_RX))) {
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2961  		skb->ip_summed = CHECKSUM_NONE;
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2962  	} else {
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30 @2963  		skb->csum = ntohs((u16)(rx_cmd_b >> RX_CMD_B_CSUM_SHIFT_));
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2964  		skb->ip_summed = CHECKSUM_COMPLETE;
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2965  	}
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2966  }
55d7de9de6c30a Woojung.Huh@microchip.com 2015-07-30  2967  

:::::: The code at line 2963 was first introduced by commit
:::::: 55d7de9de6c30adce8d675c7ce513e283829c2ff Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver

:::::: TO: Woojung.Huh@microchip.com <Woojung.Huh@microchip.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
