Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76DEF35FA5C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhDNSJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:09:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:26616 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233369AbhDNSJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:09:46 -0400
IronPort-SDR: gyscbz4fmpJjLqFpuNlT8+yMpRJxe+tpDAWplGaa7WWcesWr+2C+yOheAfP6ma8BSkslIKISyE
 4WP/yH9uTKmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="258664667"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="gz'50?scan'50,208,50";a="258664667"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 11:09:24 -0700
IronPort-SDR: vXStWUH5JJA4kpNK+O+++aII+2aml+fLnhqayT5jehRvNWhhyZAtDNaJEUpAFwpYjH3jANDIIi
 yLORA7IMTwnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="gz'50?scan'50,208,50";a="522078822"
Received: from lkp-server02.sh.intel.com (HELO fa9c8fcc3464) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 14 Apr 2021 11:09:22 -0700
Received: from kbuild by fa9c8fcc3464 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lWjx3-00008v-By; Wed, 14 Apr 2021 18:09:21 +0000
Date:   Thu, 15 Apr 2021 02:08:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202104150246.UF5UACzP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e70b911acc1687100c31e550251715dbdac96a12
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   8 months ago
config: sh-randconfig-s031-20210414 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-280-g2cd6d34e-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int [noderef] __user *
>> drivers/fpga/dfl-fme-main.c:143:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:143:13: sparse:     got int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected int const *__gu_addr
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int [noderef] __user *
   drivers/fpga/dfl-fme-main.c:155:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fpga/dfl-fme-main.c:155:13: sparse:     got int const *__gu_addr
--
   drivers/fsi/fsi-scom.c:497:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/fsi/fsi-scom.c:497:13: sparse:     expected unsigned int const *__gu_addr
   drivers/fsi/fsi-scom.c:497:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/fsi/fsi-scom.c:497:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/fsi/fsi-scom.c:497:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/fsi/fsi-scom.c:497:13: sparse:     got unsigned int const *__gu_addr
--
>> drivers/spi/spi-lp8841-rtc.c:112:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:112:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:112:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:121:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:143:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:147:17: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *iomem @@     got void [noderef] __iomem * @@
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     expected void *iomem
   drivers/spi/spi-lp8841-rtc.c:209:21: sparse:     got void [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:57:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     expected void const [noderef] __iomem *
   drivers/spi/spi-lp8841-rtc.c:63:28: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void *iomem @@
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/spi/spi-lp8841-rtc.c:47:9: sparse:     got void *iomem
--
   drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/vhost/vdpa.c:361:13: sparse:     expected unsigned int const *__gu_addr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/vhost/vdpa.c:361:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/vhost/vdpa.c:361:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vdpa.c:361:13: sparse:     got unsigned int const *__gu_addr
--
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/at91rm9200_wdt.c:174:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/at91rm9200_wdt.c:174:21: sparse:     got int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/at91rm9200_wdt.c:185:21: sparse:     got int const *__gu_addr
   drivers/watchdog/at91rm9200_wdt.c:219:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/at91rm9200_wdt.c:219:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/at91rm9200_wdt.c:219:27: sparse:     got int ( * )( ... )
--
   drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/kempld_wdt.c:349:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/kempld_wdt.c:349:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file (through arch/sh/include/asm/watchdog.h):
>> arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:44:16: sparse:     got unsigned int
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/cpu-sh2/cpu/watchdog.h:62:9: sparse:     got unsigned int
   drivers/watchdog/shwdt.c: note: in included file:
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:144:16: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:144:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:144:16: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:156:9: sparse:     got unsigned int
   arch/sh/include/asm/watchdog.h:134:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/include/asm/watchdog.h:134:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/include/asm/watchdog.h:134:9: sparse:     got unsigned int
--
   drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int [noderef] __user *
>> drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int [noderef] __user *
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int const *__gu_addr
--
   net/atm/mpoa_proc.c:223:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   net/atm/mpoa_proc.c:223:21: sparse:     expected char const *__gu_addr
   net/atm/mpoa_proc.c:223:21: sparse:     got char const [noderef] __user *
>> net/atm/mpoa_proc.c:223:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   net/atm/mpoa_proc.c:223:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/atm/mpoa_proc.c:223:21: sparse:     got char const *__gu_addr
--
   net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected int const *__gu_addr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/hci_sock.c:1941:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/hci_sock.c:1941:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_sock.c:1941:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] [usertype] __user * @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected unsigned short const *__gu_addr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short [noderef] [usertype] __user *
>> net/bluetooth/hci_core.c:2099:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   net/bluetooth/hci_core.c:2099:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/hci_core.c:2099:13: sparse:     got unsigned short const *__gu_addr
--
   net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/l2cap_sock.c:428:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:428:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:428:13: sparse:     got int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected int const *__gu_addr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/l2cap_sock.c:553:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/l2cap_sock.c:553:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/l2cap_sock.c:553:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:892:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:892:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/sco.c:892:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:892:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:892:13: sparse:     got int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:957:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:957:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/sco.c:957:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/sco.c:957:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/sco.c:957:13: sparse:     got int const *__gu_addr
--
   net/bluetooth/rfcomm/sock.c:769:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/rfcomm/sock.c:769:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:769:13: sparse:     got int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:847:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/rfcomm/sock.c:847:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/bluetooth/rfcomm/sock.c:847:13: sparse:     got int const *__gu_addr
--
   net/l2tp/l2tp_ppp.c:1376:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     expected int const *__gu_addr
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     got int [noderef] __user *optlen
>> net/l2tp/l2tp_ppp.c:1376:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/l2tp/l2tp_ppp.c:1376:13: sparse:     got int const *__gu_addr
--
   net/nfc/llcp_sock.c:308:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/nfc/llcp_sock.c:308:13: sparse:     expected int const *__gu_addr
   net/nfc/llcp_sock.c:308:13: sparse:     got int [noderef] __user *optlen
>> net/nfc/llcp_sock.c:308:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/nfc/llcp_sock.c:308:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/nfc/llcp_sock.c:308:13: sparse:     got int const *__gu_addr
--
   net/rds/af_rds.c:245:22: sparse: sparse: invalid assignment: |=
   net/rds/af_rds.c:245:22: sparse:    left side has type restricted __poll_t
   net/rds/af_rds.c:245:22: sparse:    right side has type int
   net/rds/af_rds.c:262:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   net/rds/af_rds.c:262:21: sparse:     expected unsigned char const *__gu_addr
   net/rds/af_rds.c:262:21: sparse:     got unsigned char [noderef] [usertype] __user *
>> net/rds/af_rds.c:262:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned char const *__gu_addr @@
   net/rds/af_rds.c:262:21: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/af_rds.c:262:21: sparse:     got unsigned char const *__gu_addr
   net/rds/af_rds.c:493:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rds/af_rds.c:493:13: sparse:     expected int const *__gu_addr
   net/rds/af_rds.c:493:13: sparse:     got int [noderef] __user *optlen
>> net/rds/af_rds.c:493:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rds/af_rds.c:493:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/af_rds.c:493:13: sparse:     got int const *__gu_addr
--
   net/rds/info.c:171:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/rds/info.c:171:13: sparse:     expected int const *__gu_addr
   net/rds/info.c:171:13: sparse:     got int [noderef] __user *optlen
>> net/rds/info.c:171:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rds/info.c:171:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rds/info.c:171:13: sparse:     got int const *__gu_addr
--
   net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *_optlen @@
   net/rxrpc/af_rxrpc.c:697:13: sparse:     expected int const *__gu_addr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int [noderef] __user *_optlen
>> net/rxrpc/af_rxrpc.c:697:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/rxrpc/af_rxrpc.c:697:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/rxrpc/af_rxrpc.c:697:13: sparse:     got int const *__gu_addr
--
   net/tls/tls_main.c:341:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/tls/tls_main.c:341:13: sparse:     expected int const *__gu_addr
   net/tls/tls_main.c:341:13: sparse:     got int [noderef] __user *optlen
>> net/tls/tls_main.c:341:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/tls/tls_main.c:341:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/tls/tls_main.c:341:13: sparse:     got int const *__gu_addr

vim +143 drivers/fpga/dfl-fme-main.c

0a27ff24d59662 Kang Luwei 2018-06-30  136  
69bb18ddfc4331 Wu Hao     2019-08-04  137  static long fme_hdr_ioctl_release_port(struct dfl_feature_platform_data *pdata,
69bb18ddfc4331 Wu Hao     2019-08-04  138  				       unsigned long arg)
69bb18ddfc4331 Wu Hao     2019-08-04  139  {
69bb18ddfc4331 Wu Hao     2019-08-04  140  	struct dfl_fpga_cdev *cdev = pdata->dfl_cdev;
69bb18ddfc4331 Wu Hao     2019-08-04  141  	int port_id;
69bb18ddfc4331 Wu Hao     2019-08-04  142  
69bb18ddfc4331 Wu Hao     2019-08-04 @143  	if (get_user(port_id, (int __user *)arg))
69bb18ddfc4331 Wu Hao     2019-08-04  144  		return -EFAULT;
69bb18ddfc4331 Wu Hao     2019-08-04  145  
69bb18ddfc4331 Wu Hao     2019-08-04  146  	return dfl_fpga_cdev_release_port(cdev, port_id);
69bb18ddfc4331 Wu Hao     2019-08-04  147  }
69bb18ddfc4331 Wu Hao     2019-08-04  148  

:::::: The code at line 143 was first introduced by commit
:::::: 69bb18ddfc4331ba1dea9db811caf93e95726408 fpga: dfl: fme: add DFL_FPGA_FME_PORT_RELEASE/ASSIGN ioctl support.

:::::: TO: Wu Hao <hao.wu@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
y4zuIBMqS+oa+Sko/DZTm9z/ALQpg/JYHgIA

--J2SCkAp4GZ/dPZZf--
