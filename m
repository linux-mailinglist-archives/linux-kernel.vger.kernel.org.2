Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815373DE99B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 11:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhHCJRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 05:17:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:55761 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234506AbhHCJRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 05:17:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="200804927"
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="gz'50?scan'50,208,50";a="200804927"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2021 02:17:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,291,1620716400"; 
   d="gz'50?scan'50,208,50";a="510958467"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2021 02:17:24 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mAqY7-000Dlo-CL; Tue, 03 Aug 2021 09:17:23 +0000
Date:   Tue, 3 Aug 2021 17:17:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh3/serial-sh7720.c:16:32: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202108031701.92AgIzap-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c500bee1c5b2f1d59b1081ac879d73268ab0ff17
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   11 months ago
config: sh-randconfig-s032-20210803 (attached as .config)
compiler: sh4-linux-gcc (GCC) 10.3.0
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/sh/kernel/cpu/sh3/serial-sh7720.c:16:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:16:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:16:32: sparse:     got unsigned long
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:17:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:17:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:17:25: sparse:     got unsigned long
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:20:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:20:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:20:32: sparse:     got unsigned long
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:21:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:21:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:21:25: sparse:     got unsigned long
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:26:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:26:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:26:32: sparse:     got unsigned long
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:27:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:27:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:27:25: sparse:     got unsigned long
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:30:32: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:30:32: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:30:32: sparse:     got unsigned long
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:31:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:31:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7720.c:31:25: sparse:     got unsigned long
--
>> arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:35:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:35:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:35:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:45:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:45:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:45:20: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:55:20: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:55:20: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7710.c:55:20: sparse:     got unsigned int
--
>> arch/sh/boards/board-magicpanelr2.c:39:13: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:39:13: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:39:13: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:44:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:44:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:44:21: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:54:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:54:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:54:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:54:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:54:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:54:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:59:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:59:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:59:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:59:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:59:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:59:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:66:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:66:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:66:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:68:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:68:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:68:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:72:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:72:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:72:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:74:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:74:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:74:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:78:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:78:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:78:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:80:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:80:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:80:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:84:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:84:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:84:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:86:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:86:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:86:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:90:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:90:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:90:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:92:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:92:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:92:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:100:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:100:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:100:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:105:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:105:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:105:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:110:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:110:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:110:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:115:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:115:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:115:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:120:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:120:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:120:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:125:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:125:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:125:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:130:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:130:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:130:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:135:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:135:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:135:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:140:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:140:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:140:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:145:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:145:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:145:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:150:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:150:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:150:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:156:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:156:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:156:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:164:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:164:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:164:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:173:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:173:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:173:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:174:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:174:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:174:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:191:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:191:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:191:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:196:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:196:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/board-magicpanelr2.c:196:9: sparse:     got unsigned long
   arch/sh/boards/board-magicpanelr2.c:201:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long @@
   arch/sh/boards/board-magicpanelr2.c:201:9: sparse:     expected void const volatile [noderef] __iomem *ptr

vim +16 arch/sh/kernel/cpu/sh3/serial-sh7720.c

61a6976bf19a6c Paul Mundt 2011-06-14   7  
61a6976bf19a6c Paul Mundt 2011-06-14   8  static void sh7720_sci_init_pins(struct uart_port *port, unsigned int cflag)
61a6976bf19a6c Paul Mundt 2011-06-14   9  {
61a6976bf19a6c Paul Mundt 2011-06-14  10  	unsigned short data;
61a6976bf19a6c Paul Mundt 2011-06-14  11  
61a6976bf19a6c Paul Mundt 2011-06-14  12  	if (cflag & CRTSCTS) {
61a6976bf19a6c Paul Mundt 2011-06-14  13  		/* enable RTS/CTS */
61a6976bf19a6c Paul Mundt 2011-06-14  14  		if (port->mapbase == 0xa4430000) { /* SCIF0 */
61a6976bf19a6c Paul Mundt 2011-06-14  15  			/* Clear PTCR bit 9-2; enable all scif pins but sck */
61a6976bf19a6c Paul Mundt 2011-06-14 @16  			data = __raw_readw(PORT_PTCR);
61a6976bf19a6c Paul Mundt 2011-06-14  17  			__raw_writew((data & 0xfc03), PORT_PTCR);
61a6976bf19a6c Paul Mundt 2011-06-14  18  		} else if (port->mapbase == 0xa4438000) { /* SCIF1 */
61a6976bf19a6c Paul Mundt 2011-06-14  19  			/* Clear PVCR bit 9-2 */
61a6976bf19a6c Paul Mundt 2011-06-14  20  			data = __raw_readw(PORT_PVCR);
61a6976bf19a6c Paul Mundt 2011-06-14  21  			__raw_writew((data & 0xfc03), PORT_PVCR);
61a6976bf19a6c Paul Mundt 2011-06-14  22  		}
61a6976bf19a6c Paul Mundt 2011-06-14  23  	} else {
61a6976bf19a6c Paul Mundt 2011-06-14  24  		if (port->mapbase == 0xa4430000) { /* SCIF0 */
61a6976bf19a6c Paul Mundt 2011-06-14  25  			/* Clear PTCR bit 5-2; enable only tx and rx  */
61a6976bf19a6c Paul Mundt 2011-06-14  26  			data = __raw_readw(PORT_PTCR);
61a6976bf19a6c Paul Mundt 2011-06-14  27  			__raw_writew((data & 0xffc3), PORT_PTCR);
61a6976bf19a6c Paul Mundt 2011-06-14  28  		} else if (port->mapbase == 0xa4438000) { /* SCIF1 */
61a6976bf19a6c Paul Mundt 2011-06-14  29  			/* Clear PVCR bit 5-2 */
61a6976bf19a6c Paul Mundt 2011-06-14  30  			data = __raw_readw(PORT_PVCR);
61a6976bf19a6c Paul Mundt 2011-06-14  31  			__raw_writew((data & 0xffc3), PORT_PVCR);
61a6976bf19a6c Paul Mundt 2011-06-14  32  		}
61a6976bf19a6c Paul Mundt 2011-06-14  33  	}
61a6976bf19a6c Paul Mundt 2011-06-14  34  }
61a6976bf19a6c Paul Mundt 2011-06-14  35  

:::::: The code at line 16 was first introduced by commit
:::::: 61a6976bf19a6cf5dfcf37c3536665b316f22d49 serial: sh-sci: Abstract register maps.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nUN90S+9AgCVwQesBIkBAA==

--dDRMvlgZJXvWKvBx--
