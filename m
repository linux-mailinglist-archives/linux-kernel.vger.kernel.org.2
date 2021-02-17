Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487A131D551
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 07:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhBQGP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 01:15:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:11963 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230221AbhBQGPX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 01:15:23 -0500
IronPort-SDR: pDRU8SmvQCTOeENr2oyHIPezvxIvyZ26aDWHsdgsWYf4Csb+B+UO8wJ0DcHs4NrHbazLnmAu9d
 4558n7+HByAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="182335694"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="gz'50?scan'50,208,50";a="182335694"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2021 22:14:40 -0800
IronPort-SDR: 5gt1/A7WqC4wCuH56NzKjE0ZBqXlfqT11t5dFCDBe6pXunEumZhXbg4xukXHDkToj9+pMW+D/X
 sIxTLxqpc7gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; 
   d="gz'50?scan'50,208,50";a="377862809"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 16 Feb 2021 22:14:38 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lCG6f-0008qo-Bj; Wed, 17 Feb 2021 06:14:37 +0000
Date:   Wed, 17 Feb 2021 14:14:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/ftrace.c:368:17: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202102171430.IVLGNLMR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f40ddce88593482919761f74910f42f4b84c004b
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   6 months ago
config: sh-randconfig-s032-20210217 (attached as .config)
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
>> arch/sh/kernel/ftrace.c:368:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long *parent @@
   arch/sh/kernel/ftrace.c:368:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/ftrace.c:368:17: sparse:     got unsigned long *parent
--
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
--
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
>> drivers/mmc/host/dw_mmc.c:602:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int * @@
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:602:29: sparse:     got unsigned int *
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
   drivers/mmc/host/dw_mmc.c:615:25: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
>> drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got restricted __le32 * @@
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/mmc/host/dw_mmc.c:674:29: sparse:     got restricted __le32 *
   drivers/mmc/host/dw_mmc.c:674:29: sparse: sparse: restricted __le32 degrades to integer
--
   drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __virtio16 const *__gu_addr @@     got restricted __virtio16 [noderef] [usertype] __user * @@
   drivers/vhost/vringh.c:567:18: sparse:     expected restricted __virtio16 const *__gu_addr
   drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 [noderef] [usertype] __user *
>> drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __virtio16 const *__gu_addr @@
   drivers/vhost/vringh.c:567:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 const *__gu_addr
--
>> drivers/soc/qcom/smp2p.c:218:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *value @@
   drivers/soc/qcom/smp2p.c:218:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smp2p.c:218:23: sparse:     got unsigned int [usertype] *value
   drivers/soc/qcom/smp2p.c:325:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *value @@
   drivers/soc/qcom/smp2p.c:325:22: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smp2p.c:325:22: sparse:     got unsigned int [usertype] *value
   drivers/soc/qcom/smp2p.c:328:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *value @@
   drivers/soc/qcom/smp2p.c:328:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smp2p.c:328:9: sparse:     got unsigned int [usertype] *value
--
   drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/pcwd_usb.c:375:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:375:37: sparse:     got char const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int [noderef] __user *p
>> drivers/watchdog/pcwd_usb.c:423:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:423:21: sparse:     got int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int [noderef] __user *p
   drivers/watchdog/pcwd_usb.c:447:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/pcwd_usb.c:447:21: sparse:     got int const *__gu_addr
--
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     expected char const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     got char const [noderef] __user *
>> drivers/watchdog/mv64x60_wdt.c:163:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:163:37: sparse:     got char const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     got int [noderef] __user *
>> drivers/watchdog/mv64x60_wdt.c:206:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:206:21: sparse:     got int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     expected int const *__gu_addr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     got int [noderef] __user *
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/watchdog/mv64x60_wdt.c:222:21: sparse:     got int const *__gu_addr

vim +368 arch/sh/kernel/ftrace.c

327933f5d6cdf0 Matt Fleming             2009-07-11  303  
327933f5d6cdf0 Matt Fleming             2009-07-11  304  /*
327933f5d6cdf0 Matt Fleming             2009-07-11  305   * Hook the return address and push it in the stack of return addrs
327933f5d6cdf0 Matt Fleming             2009-07-11  306   * in the current thread info.
327933f5d6cdf0 Matt Fleming             2009-07-11  307   *
327933f5d6cdf0 Matt Fleming             2009-07-11  308   * This is the main routine for the function graph tracer. The function
327933f5d6cdf0 Matt Fleming             2009-07-11  309   * graph tracer essentially works like this:
327933f5d6cdf0 Matt Fleming             2009-07-11  310   *
327933f5d6cdf0 Matt Fleming             2009-07-11  311   * parent is the stack address containing self_addr's return address.
327933f5d6cdf0 Matt Fleming             2009-07-11  312   * We pull the real return address out of parent and store it in
327933f5d6cdf0 Matt Fleming             2009-07-11  313   * current's ret_stack. Then, we replace the return address on the stack
327933f5d6cdf0 Matt Fleming             2009-07-11  314   * with the address of return_to_handler. self_addr is the function that
327933f5d6cdf0 Matt Fleming             2009-07-11  315   * called mcount.
327933f5d6cdf0 Matt Fleming             2009-07-11  316   *
327933f5d6cdf0 Matt Fleming             2009-07-11  317   * When self_addr returns, it will jump to return_to_handler which calls
327933f5d6cdf0 Matt Fleming             2009-07-11  318   * ftrace_return_to_handler. ftrace_return_to_handler will pull the real
327933f5d6cdf0 Matt Fleming             2009-07-11  319   * return address off of current's ret_stack and jump to it.
327933f5d6cdf0 Matt Fleming             2009-07-11  320   */
327933f5d6cdf0 Matt Fleming             2009-07-11  321  void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr)
327933f5d6cdf0 Matt Fleming             2009-07-11  322  {
327933f5d6cdf0 Matt Fleming             2009-07-11  323  	unsigned long old;
bc715ee4dbc5db Steven Rostedt (VMware   2018-11-18  324) 	int faulted;
327933f5d6cdf0 Matt Fleming             2009-07-11  325  	unsigned long return_hooker = (unsigned long)&return_to_handler;
327933f5d6cdf0 Matt Fleming             2009-07-11  326  
7fa322dba30ced Steven Rostedt (Red Hat  2014-06-25  327) 	if (unlikely(ftrace_graph_is_dead()))
7fa322dba30ced Steven Rostedt (Red Hat  2014-06-25  328) 		return;
7fa322dba30ced Steven Rostedt (Red Hat  2014-06-25  329) 
327933f5d6cdf0 Matt Fleming             2009-07-11  330  	if (unlikely(atomic_read(&current->tracing_graph_pause)))
327933f5d6cdf0 Matt Fleming             2009-07-11  331  		return;
327933f5d6cdf0 Matt Fleming             2009-07-11  332  
327933f5d6cdf0 Matt Fleming             2009-07-11  333  	/*
327933f5d6cdf0 Matt Fleming             2009-07-11  334  	 * Protect against fault, even if it shouldn't
327933f5d6cdf0 Matt Fleming             2009-07-11  335  	 * happen. This tool is too much intrusive to
327933f5d6cdf0 Matt Fleming             2009-07-11  336  	 * ignore such a protection.
327933f5d6cdf0 Matt Fleming             2009-07-11  337  	 */
327933f5d6cdf0 Matt Fleming             2009-07-11  338  	__asm__ __volatile__(
327933f5d6cdf0 Matt Fleming             2009-07-11  339  		"1:						\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  340  		"mov.l		@%2, %0				\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  341  		"2:						\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  342  		"mov.l		%3, @%2				\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  343  		"mov		#0, %1				\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  344  		"3:						\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  345  		".section .fixup, \"ax\"			\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  346  		"4:						\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  347  		"mov.l		5f, %0				\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  348  		"jmp		@%0				\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  349  		" mov		#1, %1				\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  350  		".balign 4					\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  351  		"5:	.long 3b				\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  352  		".previous					\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  353  		".section __ex_table,\"a\"			\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  354  		".long 1b, 4b					\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  355  		".long 2b, 4b					\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  356  		".previous					\n\t"
327933f5d6cdf0 Matt Fleming             2009-07-11  357  		: "=&r" (old), "=r" (faulted)
327933f5d6cdf0 Matt Fleming             2009-07-11  358  		: "r" (parent), "r" (return_hooker)
327933f5d6cdf0 Matt Fleming             2009-07-11  359  	);
327933f5d6cdf0 Matt Fleming             2009-07-11  360  
327933f5d6cdf0 Matt Fleming             2009-07-11  361  	if (unlikely(faulted)) {
327933f5d6cdf0 Matt Fleming             2009-07-11  362  		ftrace_graph_stop();
327933f5d6cdf0 Matt Fleming             2009-07-11  363  		WARN_ON(1);
327933f5d6cdf0 Matt Fleming             2009-07-11  364  		return;
327933f5d6cdf0 Matt Fleming             2009-07-11  365  	}
327933f5d6cdf0 Matt Fleming             2009-07-11  366  
bc715ee4dbc5db Steven Rostedt (VMware   2018-11-18  367) 	if (function_graph_enter(old, self_addr, 0, NULL))
327933f5d6cdf0 Matt Fleming             2009-07-11 @368  		__raw_writel(old, parent);

:::::: The code at line 368 was first introduced by commit
:::::: 327933f5d6cdf083284d3c06e0370d1de464aef4 sh: Function graph tracer support

:::::: TO: Matt Fleming <matt@console-pimps.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
NsrDBgOGkPX9//lcXd9FfAEA

--45Z9DzgjV8m4Oswq--
