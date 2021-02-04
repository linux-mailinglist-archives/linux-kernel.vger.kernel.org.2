Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2531530EA75
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 03:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhBDCxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 21:53:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:7900 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231284AbhBDCxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 21:53:38 -0500
IronPort-SDR: spXUpysF1At0Gijx+Q458EB2PGOMEAY1OZCLaRpTtxoxRak6X2G18tmF+LjUpcKyklpygKpfaq
 2s3liDyhSMeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="181233488"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="gz'50?scan'50,208,50";a="181233488"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 18:52:56 -0800
IronPort-SDR: ESI2oTMigqyNqLgfRX3TV/M21zGvTOJ6JEhO+qVcfpL0G2rFdt4wiH9MAWtuIikYo0xpWw8IfU
 lfgyvUsgJuJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="gz'50?scan'50,208,50";a="433729889"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Feb 2021 18:52:54 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7UlJ-0000fS-Nu; Thu, 04 Feb 2021 02:52:53 +0000
Date:   Thu, 4 Feb 2021 10:52:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh3/probe.c:96:17: sparse: sparse: incorrect type
 in argument 1 (different base types)
Message-ID: <202102041033.BeUKrXQT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="NzB8fVQJ5HfG6fxh"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NzB8fVQJ5HfG6fxh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   61556703b610a104de324e4f061dc6cf7b218b46
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s032-20210204 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-215-g0fb77bb6-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:30:18: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:31:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:32:18: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:33:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:36:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:38:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:39:17: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:41:9: sparse:     got unsigned long [assigned] addr1
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:42:17: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr0 @@
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:45:9: sparse:     got unsigned long [assigned] addr0
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long [assigned] addr1 @@
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:46:9: sparse:     got unsigned long [assigned] addr1
>> arch/sh/kernel/cpu/sh3/probe.c:96:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/probe.c:96:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/probe.c:96:17: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/clock-sh7705.c:32:35: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:32:35: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:32:35: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:41:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:41:19: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:41:19: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:51:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:51:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:51:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:61:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:61:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7705.c:61:20: sparse:     got unsigned int
--
   drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected int const *__gu_addr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int [noderef] __user *
>> drivers/rtc/rtc-m41t80.c:736:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/rtc/rtc-m41t80.c:736:21: sparse:     got int const *__gu_addr
--
   drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/media/rc/lirc_dev.c:378:23: sparse:     expected unsigned int const *__gu_addr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/media/rc/lirc_dev.c:378:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/media/rc/lirc_dev.c:378:23: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/media/rc/lirc_dev.c:378:23: sparse:     got unsigned int const *__gu_addr

vim +96 arch/sh/kernel/cpu/sh3/probe.c

^1da177e4c3f41 Linus Torvalds    2005-04-16  15  
4603f53a1dc3c7 Paul Gortmaker    2013-06-18  16  void cpu_probe(void)
^1da177e4c3f41 Linus Torvalds    2005-04-16  17  {
^1da177e4c3f41 Linus Torvalds    2005-04-16  18  	unsigned long addr0, addr1, data0, data1, data2, data3;
^1da177e4c3f41 Linus Torvalds    2005-04-16  19  
cbaa118ecfd99f Stuart Menefy     2007-11-30  20  	jump_to_uncached();
^1da177e4c3f41 Linus Torvalds    2005-04-16  21  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  22  	 * Check if the entry shadows or not.
^1da177e4c3f41 Linus Torvalds    2005-04-16  23  	 * When shadowed, it's 128-entry system.
^1da177e4c3f41 Linus Torvalds    2005-04-16  24  	 * Otherwise, it's 256-entry system.
^1da177e4c3f41 Linus Torvalds    2005-04-16  25  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  26  	addr0 = CACHE_OC_ADDRESS_ARRAY + (3 << 12);
^1da177e4c3f41 Linus Torvalds    2005-04-16  27  	addr1 = CACHE_OC_ADDRESS_ARRAY + (1 << 12);
^1da177e4c3f41 Linus Torvalds    2005-04-16  28  
^1da177e4c3f41 Linus Torvalds    2005-04-16  29  	/* First, write back & invalidate */
9d56dd3b083a3b Paul Mundt        2010-01-26  30  	data0  = __raw_readl(addr0);
9d56dd3b083a3b Paul Mundt        2010-01-26  31  	__raw_writel(data0&~(SH_CACHE_VALID|SH_CACHE_UPDATED), addr0);
9d56dd3b083a3b Paul Mundt        2010-01-26  32  	data1  = __raw_readl(addr1);
9d56dd3b083a3b Paul Mundt        2010-01-26  33  	__raw_writel(data1&~(SH_CACHE_VALID|SH_CACHE_UPDATED), addr1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  34  
^1da177e4c3f41 Linus Torvalds    2005-04-16  35  	/* Next, check if there's shadow or not */
9d56dd3b083a3b Paul Mundt        2010-01-26  36  	data0 = __raw_readl(addr0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  37  	data0 ^= SH_CACHE_VALID;
9d56dd3b083a3b Paul Mundt        2010-01-26  38  	__raw_writel(data0, addr0);
9d56dd3b083a3b Paul Mundt        2010-01-26  39  	data1 = __raw_readl(addr1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  40  	data2 = data1 ^ SH_CACHE_VALID;
9d56dd3b083a3b Paul Mundt        2010-01-26  41  	__raw_writel(data2, addr1);
9d56dd3b083a3b Paul Mundt        2010-01-26  42  	data3 = __raw_readl(addr0);
^1da177e4c3f41 Linus Torvalds    2005-04-16  43  
^1da177e4c3f41 Linus Torvalds    2005-04-16  44  	/* Lastly, invaliate them. */
9d56dd3b083a3b Paul Mundt        2010-01-26  45  	__raw_writel(data0&~SH_CACHE_VALID, addr0);
9d56dd3b083a3b Paul Mundt        2010-01-26  46  	__raw_writel(data2&~SH_CACHE_VALID, addr1);
^1da177e4c3f41 Linus Torvalds    2005-04-16  47  
cbaa118ecfd99f Stuart Menefy     2007-11-30  48  	back_to_cached();
^1da177e4c3f41 Linus Torvalds    2005-04-16  49  
cb7af21f7d370e Paul Mundt        2007-09-27  50  	boot_cpu_data.dcache.ways		= 4;
cb7af21f7d370e Paul Mundt        2007-09-27  51  	boot_cpu_data.dcache.entry_shift	= 4;
cb7af21f7d370e Paul Mundt        2007-09-27  52  	boot_cpu_data.dcache.linesz		= L1_CACHE_BYTES;
cb7af21f7d370e Paul Mundt        2007-09-27  53  	boot_cpu_data.dcache.flags		= 0;
^1da177e4c3f41 Linus Torvalds    2005-04-16  54  
^1da177e4c3f41 Linus Torvalds    2005-04-16  55  	/*
^1da177e4c3f41 Linus Torvalds    2005-04-16  56  	 * 7709A/7729 has 16K cache (256-entry), while 7702 has only
^1da177e4c3f41 Linus Torvalds    2005-04-16  57  	 * 2K(direct) 7702 is not supported (yet)
^1da177e4c3f41 Linus Torvalds    2005-04-16  58  	 */
^1da177e4c3f41 Linus Torvalds    2005-04-16  59  	if (data0 == data1 && data2 == data3) {	/* Shadow */
cb7af21f7d370e Paul Mundt        2007-09-27  60  		boot_cpu_data.dcache.way_incr	= (1 << 11);
cb7af21f7d370e Paul Mundt        2007-09-27  61  		boot_cpu_data.dcache.entry_mask	= 0x7f0;
cb7af21f7d370e Paul Mundt        2007-09-27  62  		boot_cpu_data.dcache.sets	= 128;
cb7af21f7d370e Paul Mundt        2007-09-27  63  		boot_cpu_data.type = CPU_SH7708;
^1da177e4c3f41 Linus Torvalds    2005-04-16  64  
cb7af21f7d370e Paul Mundt        2007-09-27  65  		boot_cpu_data.flags |= CPU_HAS_MMU_PAGE_ASSOC;
^1da177e4c3f41 Linus Torvalds    2005-04-16  66  	} else {				/* 7709A or 7729  */
cb7af21f7d370e Paul Mundt        2007-09-27  67  		boot_cpu_data.dcache.way_incr	= (1 << 12);
cb7af21f7d370e Paul Mundt        2007-09-27  68  		boot_cpu_data.dcache.entry_mask	= 0xff0;
cb7af21f7d370e Paul Mundt        2007-09-27  69  		boot_cpu_data.dcache.sets	= 256;
cb7af21f7d370e Paul Mundt        2007-09-27  70  		boot_cpu_data.type = CPU_SH7729;
^1da177e4c3f41 Linus Torvalds    2005-04-16  71  
e5723e0eeb2dc1 Paul Mundt        2006-09-27  72  #if defined(CONFIG_CPU_SUBTYPE_SH7706)
cb7af21f7d370e Paul Mundt        2007-09-27  73  		boot_cpu_data.type = CPU_SH7706;
e5723e0eeb2dc1 Paul Mundt        2006-09-27  74  #endif
e5723e0eeb2dc1 Paul Mundt        2006-09-27  75  #if defined(CONFIG_CPU_SUBTYPE_SH7710)
cb7af21f7d370e Paul Mundt        2007-09-27  76  		boot_cpu_data.type = CPU_SH7710;
e5723e0eeb2dc1 Paul Mundt        2006-09-27  77  #endif
9465a54fa4a9da Nobuhiro Iwamatsu 2007-03-27  78  #if defined(CONFIG_CPU_SUBTYPE_SH7712)
cb7af21f7d370e Paul Mundt        2007-09-27  79  		boot_cpu_data.type = CPU_SH7712;
9465a54fa4a9da Nobuhiro Iwamatsu 2007-03-27  80  #endif
3ea6bc3de4f15f Markus Brunner    2007-08-20  81  #if defined(CONFIG_CPU_SUBTYPE_SH7720)
cb7af21f7d370e Paul Mundt        2007-09-27  82  		boot_cpu_data.type = CPU_SH7720;
3ea6bc3de4f15f Markus Brunner    2007-08-20  83  #endif
31a49c4bf8f964 Yoshihiro Shimoda 2007-12-26  84  #if defined(CONFIG_CPU_SUBTYPE_SH7721)
31a49c4bf8f964 Yoshihiro Shimoda 2007-12-26  85  		boot_cpu_data.type = CPU_SH7721;
31a49c4bf8f964 Yoshihiro Shimoda 2007-12-26  86  #endif
^1da177e4c3f41 Linus Torvalds    2005-04-16  87  #if defined(CONFIG_CPU_SUBTYPE_SH7705)
cb7af21f7d370e Paul Mundt        2007-09-27  88  		boot_cpu_data.type = CPU_SH7705;
^1da177e4c3f41 Linus Torvalds    2005-04-16  89  
^1da177e4c3f41 Linus Torvalds    2005-04-16  90  #if defined(CONFIG_SH7705_CACHE_32KB)
cb7af21f7d370e Paul Mundt        2007-09-27  91  		boot_cpu_data.dcache.way_incr	= (1 << 13);
cb7af21f7d370e Paul Mundt        2007-09-27  92  		boot_cpu_data.dcache.entry_mask	= 0x1ff0;
cb7af21f7d370e Paul Mundt        2007-09-27  93  		boot_cpu_data.dcache.sets	= 512;
9d56dd3b083a3b Paul Mundt        2010-01-26  94  		__raw_writel(CCR_CACHE_32KB, CCR3_REG);
^1da177e4c3f41 Linus Torvalds    2005-04-16  95  #else
9d56dd3b083a3b Paul Mundt        2010-01-26 @96  		__raw_writel(CCR_CACHE_16KB, CCR3_REG);

:::::: The code at line 96 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--NzB8fVQJ5HfG6fxh
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
wv8AoTw/xuPvAAA=

--NzB8fVQJ5HfG6fxh--
