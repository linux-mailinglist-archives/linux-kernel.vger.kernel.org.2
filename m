Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7629A3B7B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbhF3BnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 21:43:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:40254 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhF3BnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 21:43:10 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="187956786"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="gz'50?scan'50,208,50";a="187956786"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 18:40:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="gz'50?scan'50,208,50";a="457020985"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jun 2021 18:40:38 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyPDS-0009Tp-8e; Wed, 30 Jun 2021 01:40:38 +0000
Date:   Wed, 30 Jun 2021 09:11:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/adc.c:22:15: sparse: sparse: incorrect type in
 argument 1 (different base types)
Message-ID: <202106300928.NLgG3DZM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   349a2d52ffe59b7a0c5876fa7ee9f3eaf188b830
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   10 months ago
config: sh-randconfig-s032-20210630 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/cpu/adc.c:22:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:22:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:22:15: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:24:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:24:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:24:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:27:23: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:27:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:27:23: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:31:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:31:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:31:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:33:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:33:19: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:33:19: sparse:     got unsigned int
   arch/sh/kernel/cpu/adc.c:34:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/adc.c:34:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/adc.c:34:17: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/serial-sh770x.c:15:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:15:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:15:16: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:17:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:17:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:17:9: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:21:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:21:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:21:24: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:24:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:24:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:24:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:26:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:26:24: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:26:24: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:28:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:28:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh770x.c:28:17: sparse:     got unsigned int
--
   drivers/infiniband/core/uverbs_main.c:629:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned long long const *__gu_addr @@     got unsigned long long const [noderef] [usertype] __user * @@
   drivers/infiniband/core/uverbs_main.c:629:31: sparse:     expected unsigned long long const *__gu_addr
   drivers/infiniband/core/uverbs_main.c:629:31: sparse:     got unsigned long long const [noderef] [usertype] __user *
>> drivers/infiniband/core/uverbs_main.c:629:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned long long const *__gu_addr @@
   drivers/infiniband/core/uverbs_main.c:629:31: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/infiniband/core/uverbs_main.c:629:31: sparse:     got unsigned long long const *__gu_addr
--
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/mv_udc_core.c:66:33: sparse:     got int
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr0 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse:     expected unsigned int [usertype] buff_ptr0
   drivers/usb/gadget/udc/mv_udc_core.c:366:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr1 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse:     expected unsigned int [usertype] buff_ptr1
   drivers/usb/gadget/udc/mv_udc_core.c:368:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr2 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     expected unsigned int [usertype] buff_ptr2
   drivers/usb/gadget/udc/mv_udc_core.c:369:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr3 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     expected unsigned int [usertype] buff_ptr3
   drivers/usb/gadget/udc/mv_udc_core.c:370:24: sparse:     got restricted __le32 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] buff_ptr4 @@     got restricted __le32 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     expected unsigned int [usertype] buff_ptr4
   drivers/usb/gadget/udc/mv_udc_core.c:371:24: sparse:     got restricted __le32 [usertype]
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     got unsigned int *
>> drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/usb/gadget/udc/mv_udc_core.c:832:17: sparse:     got unsigned int *
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1455:41: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/mv_udc_core.c:1515:26: sparse: sparse: cast from restricted __le16
   drivers/usb/gadget/udc/mv_udc_core.c:1545:31: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1546:35: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1567:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1578:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1579:43: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1615:34: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1624:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1610:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1610:30: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1633:39: sparse: sparse: restricted __le16 degrades to integer
   drivers/usb/gadget/udc/mv_udc_core.c:1634:43: sparse: sparse: restricted __le16 degrades to integer

vim +22 arch/sh/kernel/cpu/adc.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  11  
^1da177e4c3f41 Linus Torvalds 2005-04-16  12  
^1da177e4c3f41 Linus Torvalds 2005-04-16  13  int adc_single(unsigned int channel)
^1da177e4c3f41 Linus Torvalds 2005-04-16  14  {
^1da177e4c3f41 Linus Torvalds 2005-04-16  15  	int off;
^1da177e4c3f41 Linus Torvalds 2005-04-16  16  	unsigned char csr;
^1da177e4c3f41 Linus Torvalds 2005-04-16  17  
^1da177e4c3f41 Linus Torvalds 2005-04-16  18  	if (channel >= 8) return -1;
^1da177e4c3f41 Linus Torvalds 2005-04-16  19  
^1da177e4c3f41 Linus Torvalds 2005-04-16  20  	off = (channel & 0x03) << 2;
^1da177e4c3f41 Linus Torvalds 2005-04-16  21  
9d56dd3b083a3b Paul Mundt     2010-01-26 @22  	csr = __raw_readb(ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  23  	csr = channel | ADCSR_ADST | ADCSR_CKS;
9d56dd3b083a3b Paul Mundt     2010-01-26  24  	__raw_writeb(csr, ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  25  
^1da177e4c3f41 Linus Torvalds 2005-04-16  26  	do {
9d56dd3b083a3b Paul Mundt     2010-01-26  27  		csr = __raw_readb(ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  28  	} while ((csr & ADCSR_ADF) == 0);
^1da177e4c3f41 Linus Torvalds 2005-04-16  29  
^1da177e4c3f41 Linus Torvalds 2005-04-16  30  	csr &= ~(ADCSR_ADF | ADCSR_ADST);
9d56dd3b083a3b Paul Mundt     2010-01-26  31  	__raw_writeb(csr, ADCSR);
^1da177e4c3f41 Linus Torvalds 2005-04-16  32  
9d56dd3b083a3b Paul Mundt     2010-01-26  33  	return (((__raw_readb(ADDRAH + off) << 8) |
9d56dd3b083a3b Paul Mundt     2010-01-26  34  		__raw_readb(ADDRAL + off)) >> 6);
^1da177e4c3f41 Linus Torvalds 2005-04-16  35  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  36  

:::::: The code at line 22 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--cWoXeonUoKmBZSoM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
eHaWAHCzR4EWpXRwhEEHtv8HGGIh2DZAAQA=

--cWoXeonUoKmBZSoM--
