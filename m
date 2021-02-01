Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCC530AD86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbhBARNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:13:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:29326 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231326AbhBARN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:13:26 -0500
IronPort-SDR: yaul7EO38qeKv8EO8V5gE2xLJdGHMlickeBdt1Hgle9yseBbF3O3PyTICPdsOW1tQlU3Hn5Pjs
 vSpE4HMJBfbg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="265550883"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="gz'50?scan'50,208,50";a="265550883"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 09:12:42 -0800
IronPort-SDR: Ig1yUvYgUp558XYGf6d3TgTts0qd4Fo+62yW7NBCUvYgQYaB8ovFahcNrtQjsu+XAlw2zQMcf6
 g0EgMcGRBkXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="gz'50?scan'50,208,50";a="371627256"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Feb 2021 09:12:40 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l6cki-0008JH-3o; Mon, 01 Feb 2021 17:12:40 +0000
Date:   Tue, 2 Feb 2021 01:11:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/ftrace.c:50:9: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202102020147.1I9a3gME-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1048ba83fb1c00cd24172e23e8263972f6b5d9ac
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s031-20210201 (attached as .config)
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
>> arch/sh/kernel/ftrace.c:50:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned char * @@
   arch/sh/kernel/ftrace.c:50:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/ftrace.c:50:9: sparse:     got unsigned char *
   arch/sh/kernel/ftrace.c:57:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned char * @@
   arch/sh/kernel/ftrace.c:57:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/ftrace.c:57:9: sparse:     got unsigned char *
--
>> arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:23:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:35:21: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/clock-sh7712.c:47:21: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     got unsigned int
>> arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:13:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:14:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     got unsigned int
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/sh3/serial-sh7710.c:16:17: sparse:     got unsigned int
--
>> arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     got unsigned long addr
>> arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:35:9: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:36:15: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     got unsigned long addr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned long addr @@
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/kernel/cpu/irq/ipr.c:44:9: sparse:     got unsigned long addr
--
>> arch/sh/boards/mach-se/770x/irq.c:100:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:100:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:100:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:101:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:102:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:103:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:104:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:105:9: sparse:     got unsigned int
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int @@
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   arch/sh/boards/mach-se/770x/irq.c:106:9: sparse:     got unsigned int
--
>> drivers/gpu/drm/tve200/tve200_display.c:33:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:33:16: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:33:16: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:50:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:50:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:50:23: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:60:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:60:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:60:17: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:65:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:65:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:65:9: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:220:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:220:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:220:9: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:234:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:234:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:234:9: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:252:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:252:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:252:17: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:257:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:257:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:257:25: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:259:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:259:25: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:259:25: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:282:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:282:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:282:9: sparse:     got void *
   drivers/gpu/drm/tve200/tve200_display.c:292:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_display.c:292:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_display.c:292:9: sparse:     got void *
--
   drivers/gpu/drm/tve200/tve200_drv.c:195:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *regs @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/tve200/tve200_drv.c:195:20: sparse:     expected void *regs
   drivers/gpu/drm/tve200/tve200_drv.c:195:20: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/tve200/tve200_drv.c:209:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got void * @@
   drivers/gpu/drm/tve200/tve200_drv.c:209:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/gpu/drm/tve200/tve200_drv.c:209:9: sparse:     got void *
--
   drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected restricted __virtio16 const *__gu_addr @@     got restricted __virtio16 [noderef] [usertype] __user * @@
   drivers/vhost/vringh.c:567:18: sparse:     expected restricted __virtio16 const *__gu_addr
   drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 [noderef] [usertype] __user *
>> drivers/vhost/vringh.c:567:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got restricted __virtio16 const *__gu_addr @@
   drivers/vhost/vringh.c:567:18: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/vhost/vringh.c:567:18: sparse:     got restricted __virtio16 const *__gu_addr
--
   drivers/video/fbdev/tmiofb.c:528:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *argp @@
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     got unsigned int [noderef] [usertype] __user *argp
>> drivers/video/fbdev/tmiofb.c:528:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/tmiofb.c:528:21: sparse:     got unsigned int const *__gu_addr
--
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:719:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:719:21: sparse:     expected int const *__gu_addr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:719:21: sparse:     got int [noderef] __user *
>> drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:719:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:719:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:719:21: sparse:     got int const *__gu_addr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:755:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:755:21: sparse:     expected unsigned int const *__gu_addr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:755:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:755:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:755:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:755:21: sparse:     got unsigned int const *__gu_addr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:796:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:796:21: sparse:     expected int const *__gu_addr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:796:21: sparse:     got int [noderef] __user *
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:796:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:796:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:796:21: sparse:     got int const *__gu_addr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:811:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:811:21: sparse:     expected int const *__gu_addr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:811:21: sparse:     got int [noderef] __user *
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:811:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:811:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/video/fbdev/omap2/omapfb/omapfb-ioctl.c:811:21: sparse:     got int const *__gu_addr

vim +50 arch/sh/kernel/ftrace.c

fad57feba77d2e Matt Fleming 2008-11-12  28  
9e28c46b7dd116 Matt Fleming 2009-06-10  29  static unsigned char ftrace_nop[4];
9e28c46b7dd116 Matt Fleming 2009-06-10  30  /*
9e28c46b7dd116 Matt Fleming 2009-06-10  31   * If we're trying to nop out a call to a function, we instead
9e28c46b7dd116 Matt Fleming 2009-06-10  32   * place a call to the address after the memory table.
9e28c46b7dd116 Matt Fleming 2009-06-10  33   *
9e28c46b7dd116 Matt Fleming 2009-06-10  34   * 8c011060 <a>:
9e28c46b7dd116 Matt Fleming 2009-06-10  35   * 8c011060:       02 d1           mov.l   8c01106c <a+0xc>,r1
9e28c46b7dd116 Matt Fleming 2009-06-10  36   * 8c011062:       22 4f           sts.l   pr,@-r15
9e28c46b7dd116 Matt Fleming 2009-06-10  37   * 8c011064:       02 c7           mova    8c011070 <a+0x10>,r0
9e28c46b7dd116 Matt Fleming 2009-06-10  38   * 8c011066:       2b 41           jmp     @r1
9e28c46b7dd116 Matt Fleming 2009-06-10  39   * 8c011068:       2a 40           lds     r0,pr
9e28c46b7dd116 Matt Fleming 2009-06-10  40   * 8c01106a:       09 00           nop
9e28c46b7dd116 Matt Fleming 2009-06-10  41   * 8c01106c:       68 24           .word 0x2468     <--- ip
9e28c46b7dd116 Matt Fleming 2009-06-10  42   * 8c01106e:       1d 8c           .word 0x8c1d
9e28c46b7dd116 Matt Fleming 2009-06-10  43   * 8c011070:       26 4f           lds.l   @r15+,pr <--- ip + MCOUNT_INSN_SIZE
9e28c46b7dd116 Matt Fleming 2009-06-10  44   *
9e28c46b7dd116 Matt Fleming 2009-06-10  45   * We write 0x8c011070 to 0x8c01106c so that on entry to a() we branch
9e28c46b7dd116 Matt Fleming 2009-06-10  46   * past the _mcount call and continue executing code like normal.
9e28c46b7dd116 Matt Fleming 2009-06-10  47   */
9e28c46b7dd116 Matt Fleming 2009-06-10  48  static unsigned char *ftrace_nop_replace(unsigned long ip)
fad57feba77d2e Matt Fleming 2008-11-12  49  {
9e28c46b7dd116 Matt Fleming 2009-06-10 @50  	__raw_writel(ip + MCOUNT_INSN_SIZE, ftrace_nop);
fad57feba77d2e Matt Fleming 2008-11-12  51  	return ftrace_nop;
fad57feba77d2e Matt Fleming 2008-11-12  52  }
fad57feba77d2e Matt Fleming 2008-11-12  53  

:::::: The code at line 50 was first introduced by commit
:::::: 9e28c46b7dd116a607ffb054c5545c468c77d779 sh: Fix dynamic ftrace's NOP action.

:::::: TO: Matt Fleming <matt@console-pimps.org>
:::::: CC: Matt Fleming <matt@console-pimps.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICDAvGGAAAy5jb25maWcAjDxbc9s2s+/9FZr0pX1IK9mOk8wZP4AkKKIiCRoA5csLxrGV
1lPbyifbbfPvzy7ACwCBjjrTibm7XACLxd6w1M8//Twjry/bx5uX+9ubh4fvsz83T5vdzcvm
bvb1/mHzf7OMz2quZjRj6jcgLu+fXv/7/fmv2YffPv82f7+7PZqtNrunzcMs3T59vf/zFd69
3z799PNPKa9zttRpqtdUSMZrreilOnv3/NfJ+wfk8v7P29vZL8s0/XX2+bfj3+bvnFeY1IA4
+96DliObs8/z4/m8R5TZAD86Ppmb/wY+JamXA3rusC+I1ERWeskVHwdxEKwuWU1HFBPn+oKL
FUBgaT/PlkZKD7Pnzcvrt3GxieArWmtYq6wa5+2aKU3rtSYCZswqps6Oj4ZRedWwkoJ0pBpf
KXlKyn7q7wbRJC2DFUtSKgdYkDXVKypqWurlNXMGdjEJYI7iqPK6InHM5fXUGyi3n2cdyhl8
dv88e9q+oGT28GYKbxHgRN7CX1672PBdZyszmpO2VEbyjqR6cMGlqklFz9798rR92vz6bhxJ
XpAmMoi8kmvWOBrZAfDfVJWuMBou2aWuzlva0ginC6LSQhus+1YquJS6ohUXV5ooRdIi8nIr
ackS9z3SwsmMUJrdIgKGMhQ4TVKWvf6CPs+eX788f39+2TyO+luRK/uibIiQFNXeOYO0poKl
5izIgl/EMaz+g6YKtTaKTgtXPxGS8YqwOgbTBaMCl3DlY3MiFeVsRMOc66yEwxLQcZHSTKtC
UJKxeuls3g+Wl9GkXebSyHnzdDfbfg0kFr6Uwnld0TWtlexFrO4fN7vnmJQVS1dgIygI0Tnx
NdfFNVqDyshu2GAANjAGz1ga2Wb7FoPVB5w8FmxZaEEljFyBlPwT1q1vb7o9t0ZQWjUKuNae
wvbwNS/bWhFxFT24HVVk5v37KYfXe6GlTfu7unn+e/YC05ndwNSeX25enmc3t7fb16eX+6c/
AzHCC5qkhoe3w41k3sNw9DMmSVLSzN3bA0YdrDWMxyQvSafiZtYibWcyts/1lQacKzV41PQS
NjQmEmmJ3dcDEJEraXh0ihdB7YHajMbgSpCUDtPrJOGvZJw2W9k/onvMVgUcsECxBj+GTisH
g8Fydbb4OO4+q9UKPFlOQ5rj8HDJtIBjbI5YL3F5+9fm7vVhs5t93dy8vO42zwbcrSKCdQzt
UvC2kdGVwEDpquEwNTwuigsaJbMTIq3ihlfcXeQSdA6UPCXKaNsERq8dpyxoSa5cdUnKFdCu
jR8TWXQyCed4iMLdGWMa3sCxZ9cU7SGaEvinInXqe5+ATMIf8WVZZ+c6mZZli9MRljT5+GBV
3R2pgkPIwI2JGPslVRUopx69lSe1PXBuDb9z0o3vtWbOgRplC591XTFP1m1cvRMCriJvyzIy
47yFoNaZDz7qhgUSsuC0ai7TYukOSRvusx1VjC1rUubxLTfr83E9Q3RBuatuBYQU4yNhXtzG
uG5BFjHFIdmawbo7kUtvC2mVECFYdA9XSH1VOdLvIdrbugFqxIuKr9iaemrk7PcwNmqOMeTx
5VcJzTL3uBn5o9LrwTv3SoBAYKfXFYzBHVPapIv5SW9puuym2ey+bnePN0+3mxn9Z/ME3oGA
sUnRP4DfHI1+dCwTT8RGHEzWgcOMglhXdhTrP+PGF1MLoiArcXRflsSLH2XZJnENLPkUgiSg
A2JJe6caO8pIlIOLL5kEYwrHlFf+sC6+ICIDYx/Xdlm0eQ4JUkNgRCM4ApZ5ItrgOSvjCm38
nbHtXlznZ3LD9FvYrGI/OCwuKMRSTtRmIuyCJZCDmJAALZBkiWuTJMTyK+ttgW3DhZ/mrcAX
7COyimDElfKCClo7iGapMH7RJew+HMujzh8ahz17+f5t46TeEKvI4tiz8whqE3XVwGSKj6eL
z3E/6JD9Ec/YAk5H88VhZMeHkZ0eRHZ6GLfTk8PIfiyM6jLuIwJWH+cfDiM7aJkf5x8PI/t0
GNmPl4lki3nMooRER29oF2zjQSMdHaQ6Hz8cxG3++VBucROyTzcRKoZ0Bw67OGzY00MWe6KP
5gedzo9HBx2Uj0cHHZSPx4eRfThMbQ87xKC3B5F9OpDssAP66ZADennQAo5PDtyDg3b0+NSb
mXEC1eZxu/s+g+jh5s/NIwQPs+03LMY60UlVOXmgcag8zyVVZ/P/Ps396qmpnuiKXOpryPw5
OGhxtlgMjGyhCnybwJfnn/yXezSkEYgNCrNHnxPmJQXrLtKLxaHoYHOIDoGlpjXxXKtB2mLO
AeguWgnxtKSp6mdc8Yw6UWpbp8QkexVpGr/AgMLD9emTVeIGFNO7YCscN5Cczm6DYvm4zTic
vhBM0QTChrgqjDSqgAR0GasUWiLYXa/QERncjN7streb5+etl087mlcypSDooHXGSB2a/AQj
b4OZiN90DlS0amNxYqEz6VQE4ZlkTiyO/LEoD2EbXasIvBF+Ga9HSKFFsg+2gw0CiazbyCPZ
3uzuZs+v375tdy+jKCQvWxPl0Xrp3Q/AtNNWKl7ptFx54P1XhsH9QcaioalA3T5sb//e05OR
bwMDYQB9fvYhOLg4lxIrY0t/fhYGgeOSpFfuPN4etK/LzfLd5n+vm6fb77Pn25sHW4p7E+kp
CU41WnicePtttOEOMXJkiwqMnb2VYyxN3KS8FhpC64I1BpUWpK4xlj4dR3VZ25VsH7/dPIE8
Zulf99+8alOIMjhyd3eP4oPMQr5+2+yKWbb55x6yumx3/4+XMBYUTGhCiRvjt6g4F0ylhbtP
P+Y5FMCcdMDNYr1iWT/+tV7M404TUEcfYmEgII7n86BKDVzitGfOfd2KXtLUv/cguEVtFSuj
NcWVZOAYJv2MpCkmuU6i1kriP1kzYLMkK7XfZ7J4X22/3D/0opvx0FHCnMDkpMN9Cabfu9dv
L3g4XnbbBywujt51LKjAO6ZGwbCOFVmRIeiciS0LuDt8wASDgkFotrYRp39NBQ+cPcpw4cjR
FBEhcV65JJ88UUMWCv5xn4NjzraBr0tenz0h9YQO2Hqf7b+wxH2POfvF1A9ZBWOT8ldX0E21
F/6gpWB3D0EC7F+N9BC95GtdkgyDmjgSxmxDRzcgFeWTtsxOYXAwBy7Nu1W+2d3+df+yucWd
fX+3+Qa8otGcPTspF84KzQELYKYIxm1xxCUFSELdSp2gKoSZdxmwA6XF+ooKUHtMLHSKk625
uhAThJnySMG54zuH6n/VWMHbe7zIhR0isZAK1kC1ji0wnI+PINZEtdXhzAVdSk3qzBZo8BaJ
Suk7CkNXXOgERrb3AgGuYpcQHI5oabiG5aFu4fa2YywDuzQXpFYa75PtzWR/8x8RVWfyNOyl
crV3Cm7vc3GJuHsQ6nLhFeI8TMRiQUTcllSawiUtc1OqHblzbEdgS9nKBkLAPTjpr4LHc2Rr
knZbsJA9UWWouaZ5zlKGNc489wrQWDVzq59yzxYsU75+/+XmeXM3+9saym+77df7MDBBsq5/
YCr1wKDRkHXHR/cF6b5++NZIYZHxBwd7uAaCdASvDNzTY8rkEgvHZ4tga0YiC+hSt5KTzCvb
W2RbIyK+0Z3aychrUqR9Hw+ZuLPoKSeuCTs0KoCAkzapaqbGewFHS0p0ktinATkcLIhVWCN1
ltvWoJSgZ1dVwss9MeAVJ0Ux8JVrFZLuHnF4XGmZSgZ6fd56LTj93Vsil1GgbcQI4JinLCEz
u3oDpdVivo/GLDvzwWmVYRuStQnCx10kXgbdgXR1HpGrHQKvIHIZDmyhsdFRtLwhpQ+1nVEQ
DaTiqgkPd5RA57ChYTJr/f7N7sVEtDMFkap7iQLRHjPvkmyNd5XO1Aj4tnqkcIcPUJCSVaSO
NxSFpJRKfhmzAQEdS+XkVGCy+RvYhl9QofzoN6QRTKYsOg92GV8zl/mIiC+1Ajscp+kpILpm
cfYVSd98tZIZl/FXE5lht8WqJAmdMBishmXJNnl7AdhuAYLRl59O35xLC9wuiKDjqM5FS1Z5
s3TAfRTej7ZkMcq2VGJqD2Rb/2APVkRUE3swXgbn7AcU2HN2+ulNGTgmw5lnH4wG580919W5
XjN4h/vHHcDC5tM2D+Jjc4VbVjyHENF2RWQQo/m9kw5ydZW4dqwHJ/n52eM4TX+QQUllvXBN
f2dnJGRSxqeNzSH0v83t68vNF8iesId1Zm5UX7w8LWF1XimMZ2Lm0iJlKlijYGI+GPxSamY7
BDSChunrsJSpqbj12uqNeu2bxcm+KgpGriXeLflY87S4WOeCfdnnBlFXRrV9zy3KDewgWlRu
15FtbyBSQartvNDN122UGliVEPc1yoRwEOfJs5PgpQTdv/tKB7CRY9BaGIOZTFdQjBW8ii2Y
QUHC12uFquXf/1cVhp+K5Yx6ofJKVhFB9o1lFSZIYNHAC2Ti7GT++XQoN1HQcUj2TFy7ckSe
lpTYArMDc4tX8OAUCUJgHr3zx2IX5CPybOi1um44d9TmOmkdd3p9nEOs7ir0tbTtCbHqRdbf
w2PCtrLiHXNyKswtBehI/M4MdEQnEBgUFRGx4sgQcDcKDzZNGfFi7ekDM4raCeDkKtH0UtG6
j2nNqas3L/9ud39DfL5/3ECXVi4H+wz+hCxdCaGjiTfmlLEtucyFs+n4hPloF567UFIuvfYc
A5zolTI4DClFDrGxOzuDAaeKOTFLr6betceBBlMwB1wqL8wxCIjBR1NoB29M6e3RkT3kUk7g
2wH2R5JVOr4GD3sCvswa8Poo+5g8mbfLrLE9ZSmRXkQM8D541IJDOhW/eAWypo53reP8WTPR
0m6RS4w2aNXGQjZLoVWL1WV/vmY+Y69viPFADatkpdeLYG0d+CgysLxCY8lXjHqJnJ3PWrGJ
ubbZ/mQRnvN2DzAuzBsCd0aT2HWUwXg61EOGs/AY8KHo2lUaFz+zq0ENnBptT/B1f5R9EAwR
A6M4ImBBLvbUdeAMuiCV4PFWaBwH/lwOahlrUupp0jZx/WzvZHr82bvb1y/3t+987lX2QUa7
QGHbT339WZ92hwL7sPOJkwFEtisUDYLOSLw/C1d/Or3rp922B/TOzr/BNaYDHkFohMykK9ac
+op2ak1WpxIBalAUf+nxk2JQknkGyEL0qcgCaA2ZSGqCKry3D5D7hgGA3mHrIXFSY/UaLIzi
rbfcmz92CwjIa6c311qbabyky1NdXtjRf0AGPj2dJhFNGWXUR1wN7HFw0AysP4FjymigyHOK
jV61+LkVfk4lXbUDnvgFF9ZJJ8IPHLVRDX43JiXLrwLjad5uiitTtQQ/WTVBo6FLbKuw8X7i
Zh852vUs3ZMEgnpB2ItPAMzSlGXPU1/ddYw0Eh3th5AuOuhK6S9Ap4YYJ9DdQBU3t38HZdWe
vRl3mn3AwJm7TJWbfsCTzpKl5skfae05eYvqjKP1eUYT0RTGPOMUuSzI4iC++BXMFONg/GAB
keHcTbYjev5GZNJ7sJm4o9IIm3KQiNuTf+8rvC/Z8AmSLxhbuxVNBwyu0BWOwZjqHp9gHiwE
Ms3R5sIDnDDmuYQehlV/lkZdOpKUpKbha1XDyQR5Io5OP534I1sY6Fh4TVIeKW9K+BxLs3yC
9XFMGVzlTQTLljR81mxZgZrXnPtdRR12DSvtLnJi6EqE33gaM+HefPeAxwAAzmKpP82PFudx
FBGfj48XcVwi0qoPWicJ3ngVIg1zSRSlWMoL1sRRk+ugk5hKreKIlbyOI4QqTzQJHMaA5Skt
eazP3SU6TydmA7v5+Xh+HEfKP8hiMf8QR0KazUpQ0wFpNKPfv7F/boDq5VrEDYJDUwU0Q5CZ
Ymbl8LWQSPrUn4HSsSPw4HUDE0XKmJu9PHIWW5ImGZ+agtsZdM+nJb9oiJMidQDnA80AURde
cc4Bm9g8Mh2XJBdkiTfyezMw2II3cYQJr6OYiiesxNugKBbliud7YsJgdqM72dMsgYZeKl1k
Auf2Q9qAX4QCbW9sKe5IKMbYjF0alOPBU98LQnu3SClFff1w4mUPA1TXZfeH20rxJqOuqOAk
ACOq1zVnLHDVFjlZATD169hRSh1PmtXYFiA5fs/vljVVRcwFl1NiHmD9n+vYCzoxV/BjRDli
MqLiQedIUscqew6+CispLvvJumNINMHAfMj39utYWgwqixz8xto2xMVt23SxCHbJ9DXtJxLR
Wh1uai2LcUsKKXzTbKeR0bXvbMtjUBeJCbWHOhdKuCqFz1pWMZ0xKEiRxuEMpCqYP4E6db9t
xifNaYU3P3qJeRNJ/ZmJS5208sq0yDjadD78GEBXEZ29bJ79L6xNQrRSS1oHgYXgDZg2SLO4
cC9u9hgFCLfmOoqkIJUgGePRnU1J7JYr8SxQgp+40SzmoABVeh+6AqA76FPUbtCNF+oyN79b
4sL2vA/AJC1z/yc8HKCmaVYE0xhwMrw7GmlySlRrSoxBIG/b6x5eNy/b7ctfszvbB3oX9pYC
Cy8ogeciZYmSIO4QmqlysU95nO7BypamRGTBDgBmDf/HpVqJdRnQI0jLqW1HArX6Abol0a/o
zaJ5BYfM1c1JYTkBSw5nRTQx8wiolRvbSiUoqfYaM3KWaNEGxZgLJmgZNLw4yIrEisciXzH3
uNrnQD074LLxv+rFI/o55upTwvJxDfgUuV1CKHAAKzbBQbfSCdlS2hTaa4XpIRjvK3W1P0KP
x44y1zfGzHHu6B88gBlfMvDyPrBOmQ8oQoAssjId7d3Nbpbfbx7ww9rHx9en+1tT25j9AqS/
dvrhnCLDgFVebgCgfCI8Q1xTfziBLPMo+pMdFn987E/RgPCVffCRRlX34RVLBTcNkXHwPiep
jhbwL4lDY/T7grWwfdr6stkn7oARzsf5hag/RIEdteM6DtqsIYOQBDy7VyUwNwV5vMz5Rk0y
g7UGd7NLwUF7S7fVzLhDusYQw9XxHNI2HldpqgrFedkHJkNNb+LzgCY1xna8kkyrlDl7aJ9N
s59O2XDL2aTvb/Hrki+7+7s/jTKPHcb3t5Nt763tqixo2bh2zQOD1VOF96NKa1U1fodmD4Mo
oa2j34crUmek5G6jCNgLM0zORGX6eMyvXfUryu93j//e7Dazh+3N3WY3zjm/MKv37HAPMpfV
Gf66yIgEby7IMIizkPEtvHPdE0IUPTS3ebs/UMaaHQfVDlfUD2R6gbElsG8tcSpppjUyjpuC
YodfJpiXfHRQuhZ072cKTFBiXwDTXPG1/7M/lT7n0imyx++6kAeRV3XaczLd4BFFsIx6ovBn
0CCux+DVcXl06bWm2GdN0s8fxzPRAT2708FkySpkGMIvFnugqnKboXqe7rdm+PWQLECJjIbl
noABldM6tZ0S3mdfE2dw+GJi9D9jZNLd9eM9Ohe6jPWhJGqhsZjy3QNcut3sTLKSwYMuG68L
EcMlTRMWu0yG9KPbAe/7jcHuOn1QYEgnesiXtXT2EJ80fiPj9pYaYIU/CRRDSCbyETM2lCCu
TS47VLzJUMWSLZ57+WWOPR1qUp0BDydPZyqJ5YyAXfHk/zl7kiVHblx/RacXdsT4ORflooMP
uUmiK7dKpqSsvijK3TXTFdPV3VFVHnv+/hFkLlzAVMc7uF0CwDVJEAAB8PelywyQP9RJJd/g
QhV5DrxAgSnrqdmrDizsdyUkdbkncK6UCebXwf1nKkhQMeY94b6bamKJCSDVOYKuqOQ7IZMh
jqNdiJVzvXi7UrJuoGpF+xEuz4ZCU5+rAmKg1Ig+gE4BLcuhDkBxA8pOI0zKAoLjRXGw4LB9
knaKewuHjlcrCmFmNNgnHVOxUWau9F249z2/fTSFSVrUtOkoE4CpX54dT9GjkjzwguGat6it
mTH26kFdMWwgO9+jW8fV7kUKplxR/EKWcaWyoaBWsl1zJlmBrWnOErKG1CDvSBYJAIO/H1OT
pIuVNqe72PGSUmKshJbezuFW78V4x2EeFiY4zUvPSILAkVStEZEe3ShC4LzxnTPI7RyrLPQD
PJA+p24Yo24zXaKkqBkgkwxjLfm+wCeyPbdJTXBc5sHaN1Z4UbBzsJKiVpevwjHs03nYXhqx
Y+zuiwZmKmQYR4E8AyNm52cDnsJgJGBq/zXeHduCYlroSFQUruNsZalcG4eIXX76+/FtQ76+
vb/++cJTF719ZtLNp8376+PXN6DbfHn+yhRvti+ev8OfclDg/6M0tqXGQ1/E4H55f3p93Ozb
Q7L55yRrffr211eQtzYv38DBePMTxBY/vz6xtr3s52WfJnD5loCc2pZThRAF+mXD2Prmfzav
T194llzkU56bFo5MlE2sVSF9nOyIBxgqPGU+13mIXq7wR/bTWHwQ5jJZP8y4abAjVo2kaXQJ
ySETaSdtaqrYHnkZNdoaIItmI0PZgslE/MnSmbEXPFB58xP7tP/+x+b98fvTPzZZ/gtbYNL3
mMJkqNTD7NgJWI/AlGuVGWoxIPMesr9BLbE4r3KSsjkc8PRSHE0zsGGD2KsMs5+W8Js237Ql
4wyrc8XU4Qmstk/4vxxn7QOkMEYLA6YkKfuftWzXzl98CUrWhmBMyYXnorJPWn5E1zK2HJUl
zU725NqWSQ8ZC7WbRUxS1eKX4HvLsEqkbMwLCHVUwBBIkCiu3gwIyx87qEaUq9TAIY5ydySA
2wB1VMoX2UWphzucSAy+gryXJ6p4KqSaVUL8Rm5dBHw87O3eICOd0NaYmkPY6Z5gkV0woTmm
egixSAs67jN2umjBdgCDIEpZsQJYy/mK7H3RNC1o1YjENYsSsLQEWuJPaTvBpoiVoig2rr/b
bn5i+vbThf33s8n99qQrwE6raPEjDCrF5IUZL2T2hcWvtSjZjdh0gvClW24zW9ZRJt3X6FSA
X4tQoOXoMwCCwKj6v4CfnWYBnkuqNmDgTbRk+9BmBj5SolU1BhCNp2X+zM7y5z/+hCOO/vX8
/vHzJpHiX5HbikAyibIfXPmZTBcqAlTxGbEsUoZiUlw6orC1DhRFlxfSmTb5W6RsIdK9ZyJg
MSJQdlKQe5vfStVHge8g8HMcF6ETYigw3fKsJHf0g9XPRqHabaPoB0g0CyxGxnQ7xAVF9HYY
FOHaQF4PZZMmJS5uT9TCsWjFg+Y+S+I7rJ2uAFns7korm+c6UNGKZnZHGxmLz4ZCUSn3YxPJ
mfRMfS+uZ5pFPp+TdYLl7JJO0x/dFZIw2B8hQh3b+WKDcD4inxkMqNi4JrKu0IEJbYsi18sC
5wZxDYGfagIXzBqC9GnC/Vi0LrBTbsCh9kZGPL/UwlFgmGPnlHrayvjRMXpAWQAnzZIzOVVa
/UiTYDK77gtzyNMthQJr75kijmdXnAhiJ8T0O46umiFRLTMCTDO41yHYycsJmqwvZFbBgfRU
b4kGGyBlhlH/0GaYQNgeH7gU/6IApJs/emmPio90Ccn2O3I4gCX3+GDoH2wMG4DbbqvpXmKk
kLEfapEgTBhSAfcn4MHJCF0OSmGqSvVOzPJOFfLdKdfFgNEwAyUZqoojAcZrumYPh5qtO70y
4TuhzVjaNUkOFhSdOti6WwdrexvHrqXxjGRJnqhVZTzmUQPmbK0bjeZt7MeeZwL7LHZdhHYb
6/3j4DCydE9gd2pNe54uRQGRrC31+QNTd3kdLsmDCi/ZZix613HdTO9MOfSWjlRJx7STUi8w
gV3nYCtY0Ka+HgazKDs4i9JWaj5Vla4v4N5FMLSoiN6MSCic2BqC29UefEf1pZz0seMbK/l+
agJzNhhPWKWajvEK0BhVIBPnpcEteh6cnlrlC7IvXGfAHBLAxMI2Csm0ZqaDVGtltMgdGCPx
OvgXY1ulLI61rfoDkhKMAUOLGa/lrv7srMZEXcDOvuJKmaptcUGdI+EMAv6JV9koLvEAKNSf
ozv6NIPlcbZqHb+9vf/y9vzpaXOi6WxBgVaenj7Bs03fXjlmcsZKPj1+f396xQxVl1J1gxIm
yq88XP3yDI4pP5meWz9v3r8x6qfN++eJyuDkF9lnl7tevMi/IIjOhICgo0EzpuU1GmzfaQDl
G3OI4mG8p+X1BE87iW4s7KtEvZXAIZlLXIrdenETHdUlXBJlMhY4imga3YozAKG5HADKfjHR
RM5AVakU/OecxFIBlm6jhqryr/kCuM3nx9dPwvqpf6n6rHb3zM6JtDRTtZCv3/98txoPSd2e
ZK9a+Cl8lTTYfg9h/uANpUwvx4F/Iu51JPAiC8EdXP9qtVYJ5OYYMby7p7en1y+Q0fIZEvf9
81G5ghkLNZA8qDgblY1wcCU5SW87aFjKzoCivg6/uY63Xad5+C0KY5Xk9+ZBNK3NQXFem4Hi
DCaeF/mLGG4jWoV3xUPaJJanQ6TuWttkPYXoT8mIM0GuCTucGknqXxC+cqu1wHNsx83orEm7
BC142HsYI13wncz0FfBVZfYL7kTKsqjQi7aZiMfXJ1mP1E1JXlxIncumiRnZV3mGgAlPzIV2
R6Cuno9ZmmaqCzy70WAtVsmBSTNJjfUUkmc1XWpDQX4NtE8UghMsQYzLUC8k/90S8TwTfTgW
9fGEGW1nkjzd4d8pqYoMTXWzdOHUpc2hS/YDthZpwORFBAFb8FRhy2ZPSRKm5ubkcbaoLVKg
m1N2FFtesm4uQLgBgddwiKyFy/gkj5jeIrdrYnWfQgspdpOvUHSMbbmqJUTB8xvkauitvTk1
15YMGcFONZkwPXlMYPdt9XC0t7tRCYicTV0wZaGOfTfG+5w9xFlfJUyTWsMfXNeK73vaCiu2
pbcjCe7XaRJup8pWKKyfADxI2IrBkcekaumR2CovmExtwRySMhls4xNYxJsGox0y33EcW1X7
0++kp1jKb5nq0DQ5GSxjZBy2aHEcE63ZurEU1MxKMoqG9CEKXVunD6caffdKGfddv/dcL7LM
r8KDVUxja/aSgH5+iR0HM5CalNY1w4Rx140d14LNaCC+GIasqOtuLbii3DNNsCKtjYD/sA2P
VEN4Kq89vbVrSF0MxLLiqzt4bARFtUXN3Uwt854zsbMPBie09a8iB9RrTabhf3f87R+0Ff43
kwcsWHJNKt8PBpgEnOSUpYxzWT6O4LTW5ZP33Eh1my1dql00WHc/YC0P1+hkLm7sN8iw8Ghl
6gd6Lbskt61nRZNT17LrR7H1WOF/k9672YGebmPbrLNvxVmhZUUytOc4wwqPFxSWPSOQFjYy
Iq9EjeyQSSCdCaaGKuyOlEqEgIqjuhVbQfeuJoxayKq9xWFCIQNr9G2qIQ4twZbK5LQ0DJwI
c1iSyT4Ufeh51iXygUvcN+rommM1yijWisg9DQY8H9ioYBGU83UV2RrSBgfiG5mjaCXJ8Ryy
d3zJZ2eE6OuWw718dJXS6V3XgHg6xFfS/Y8w/FsJZKBwEmG6mswQ5Ndmo/vDqB3mP8GF9C7N
dWhJ0pZ6ivmRw7vkgtsfOXZ06GIlV4gYtrI8aCcq6bKraFsFt3iPmrLNGJKiT4RyCr4xsCrh
MkqFn7QpAs1odOXVINeaBkGMwEvFiQ/7HIufGmLvEeaFz4+vjx/Boog4qvc9Zl8W8qTIm3xS
PA34S5yoZaxtdQNJW5HpoWdMBwP0XUavaaXwNHHDyTGchKEx213L738UMsmiLupIewTHIOl4
Bauk4xvRxwvy+OEMFC95kqYqKnRRLoRpsvXxF8YWGuF+gYxuIWGi2LWrD8oMLVjGzC0sf6Hh
tyKrbSi5NxZwMTzUDcUwMPn49NwVTCXHM+4sRFnWd/WcG0nEQ20+Iqt0LAnxVBBrvlVk4QUq
64+MxXvbQd401vqnImwtiLyqi6W5ON9pX3jilJBMTgvNgRe3OLw409+8YM4i2mfsv1ZKJCmt
IhnM6djZrntjcahJxs4aoe0rx5uEJAxSF+g3l8nq07np5VtoQKIVn1l3wRYy2NLkiUpp7/sf
Ws84DeXboPLB5mdrcqllzsWcdSfa83dP5uAxYVZlrZn2bVnhgtFymyqbGfU1XS8bnzfA+BMg
+TunZ7Uq4SIhLsj//PL+/P3L09+s29APeE8I7Qw7h1JxQrAqy7KoD4VRqebOsEAVn4wJXPbZ
1ndCE9FmyS7YujbE3wiC1GxHKp99QnUFmp3Qy0QSTamoVrAqh6wtlYDu1clSmx5D9cD709I8
HYPC5iWQfPnXt9fn988vb9rEl4cGHq970YFttseAidxlreK5sfkghsgq9HsfyRAcc0/uoXij
ffMHBGMJ6//mp5dvb+9f/rt5evnj6RPcBf46Uv3y7esvH9n8KE/oiE6CUGSZlNk5SC3SW17Y
5MhhILbqEI+fCXzX1IneDqSMon1q20rg7GOucPB1UOKQxdqC17R5RKmqq2lI7u0oXfioWMmZ
SyYgB5I1pWyTB3CxZyepBqqKsw7iR2KgAsdBKXPBt7pIRkfq340oO3Wxk8OxTOBiwjJ1pDqo
LYJQULYGjyNN66vGAoD+/mGrvbEpIZm4690ZG78PrfoRR0ehh9m9OPIcbodB51cDVQGj9KYC
G/jWGmGjXh4C5KJxG7ZlLZ+6rdiC1Iq3tdZqOyQGAFtYIr5KX6kceihqDdwRon0b6mfeVjZk
c+BR5JvSVjglFbw6oX0ViKi0McPeIAbBcI85ri3YSGu1P/mO3sFTHTJlx7to46MP9f2Jic2d
3i6PeLW0ynHXtK20T3KqSXskRYdDrxqXhrv8pDfm7FJpLF64nuj9G0r7PhzKdjdgNgr+RZm4
OTHz4m8mpsCjfgzxKzuIGEN/HH02jOt6vqLmCE5evHn/LE7Asax0IKjlkDPUevjon/9k48PT
0lbpATgGj1nnRwSb697uBsGYE92AazHJstgmtePjoiNtcWMUbVEf46Mc9MR+KOKfsGxQIr0M
OKdb4OAvzxDOJj34CKFGx0RaoG2rKsUtEqwhlJuWTvVh/jxQMCv5i1l3XLNE9eqZZllIJm7M
KTO3+i/+gtX7t1e5YYHt2/HdUENygWS6bhDHEIMiexCo8GsuZzzXcPdNR+6njoyuScKtkj9Y
ak3LK/koPS7PZvJ+vv2vrYeM+SuXGBqW5H3stT7+jLNJm1WoZmLO19yZUfpdQt/HF+5GBOQf
ObWSDsfgleyiItGD0Lw/1fxpDLUE/IU3oSDELjO6NHUlGVrPUe6qZwyTD9niQSPCJxI5LGsC
ppUbx44Jz5M4cK7tqUXK5MnOCSWhaoIzOcSNh8EsUGWt51MnVjU6HYsNq/uQ4GKvRID5bizo
WskwPMHhjbPS4kc4kfTVHpefJgrw09AikfXm72I5x+gEFnlNsX4xwWi1ydEmdsBNwDoVfquk
U+GRyvMCySovdi2SpELkrzfHlRDO4VbJRs9u/HGHiUjfXALWTvzTwHhXZcfKRVBEWnRM8ED2
H/UjB/tuosA1PWwzzAwxNziKzEbFIMBiQC8YsG0BGPQmZt5TtEJ6LwIhzPXIETGCGGMrUARe
FUdEW6zTDBU6brz69Vm/4zDEFB2ZYhc6WANVXu1CF8tALhce8N7xet31vcBpIiy0VKHYIfMi
EKENgTK/+4xunTWOzhUXSlMm3YusJyYTyyI3xp+ZnknySptxjCTeru9uNgo3uFFLFePvWs8E
ScV0lQM2DqGzr1cPyhkq+ksUoNeaGwMedt9nNriFqzAkHPUWLJQTtgcU1cVJ5CdbbKgTOtqu
T+dCt3YALlS+vSfR9kZP1vbUQhUhcsSClXPvm9h0FZuhTHfBF+tCwkwYrXOfhQ4PJzPodmvL
eaFaG9tuZYVEO3913Lt1MWChu7EzJULMJGSShevfg3HhH6smWBs7ftIu+Bt8bSHc/TDhrXVO
j5HnWL8JYNE4Q4Noh4+b4fzEOmqGjbzbQ+Fk+H2iQWZRqnSy28sMyCx+CTpZEP0QWbx+3sxk
6ye2IBvWx0nbLmcn5S5eFTy4vQ09Y4WZzlvnGSNV+CNU0XZ9VCPVj9R1ZIz/1qCq1g0ic0X2
5Erg6cvkwcTN5j5kPmajX5mvr4iZkGkGP0hJy3ydhct1ru3mhW6gCAeWxhCmNwbprh8+EuWN
3Sv3Sflo47uln54f+6d/b74/f/34/vrFNDcWpOYZmhEF3AK8YvIJwKtGuceWUS28CoxK0L0X
oa60C0EUeij35Jj11Vz1sXtDwwQSb527QB/dNXmp6sMoDPDhhbfkAiDZRbdmAJ3y2I0sMxO7
8Tr7YiSBu6qU9KG/i2S7rXUt6UWL+xMpSdpB2P6S5EQ8GHourtmJ9nB3AhdlUkod+K0kpx4B
PIcdZN+5lqQi/W+B600UzV4TpKcipLuHOATVswOMZFZLAu+N7cUDjhzNb2pj4AIS+c7iFiCe
PX15/P796dOGt2bsOF4uYjqFSFv6onXCvOfV8NwCcwt/pfpQFZr+GEkKOod1rGBadN1DS+CV
DnnuOH66/LXVCfjhQMd7Y3WWxgtircUsySHtqg4tWxq57mBMTH5JWuxugyMLkvEjWWu4qLTa
9z38z3EdY3yzeXW8UbSug85cc9djecmNGkmDORNyVNkcSHbOjCKjNdT+dRmB76EKq1iOaRzS
aNAXaVF/EGEQamVVm7HG7JXx6169rsHYAgM1xgGmhfmb2EfTDisLHS7eVrC5dSXSpEqC3GP8
qElPxqAp2RM0U9KIbQZtydAa7logi4k+yvXBMa7FEyNYm3qgmZzylAP5VanREIe6McavBV64
xqtVYeIWR1yyfOdvVxYZTz5ypekKBb9jtXVnKFtj2j9YqSFZyH68zVFfj8bY6OxUw6FPf39/
/PrJZK9J3gZBHGtfMsnrVgMdLldx0WoydQeDevrq4L5VvsmtRjgcRbaBc5JIb6bN9nEQ6c30
Lcm82NWJ2YffjYFd0u2qNjXiZNrn61OW5qwzbnU5a02Urb/b+gYwjgJV5JnniIlCmEo0DgPi
AeLQKMgRO1TKEvj7aohDrRdGII5Y3pM1dVlO5tjVdXE4sO2dTE/kKANqsrsTxsYv7nTV6f7y
1/N4J189vr1rsd0Xd35siHrbGNexFyLGXm9Q5NS9YIfTQqG7JS0YetAu08cJQoYgD41+efzP
kz4q4TkA6RcsvREEtJLP4BkMk+FIlhwVEcs8S0NBCpQcEg6utQqkrm9rN9RmZ0FZjBsyTWyJ
u1Lq8bEdoFK41k74mPKtUsT4zAXOYJu5yGL5UmlwrVQZfuHgardK5EZrC21cUJJa0lzA6/OM
ZrfiuK6ghXr7uYC5fGmRTXUyEEP/iyEPRUVqIkDNfm8h0t7v0XHwZ6+9dYQSQ74ZRgl3/jdp
xc2v+HFjhGWfebvAs3URlDqb/U4iQwaBUE0e//hMzdIN2oLAzpN9o6VO95WTkR8kabcrwEsc
ciNLxGNbKE7pU+YpnomQJr5aK0ZPbVs+mEMUcOxJZYyMJ77HySBnGJBih+KorSR5Bg/yMeYu
Gdz4kx68pNw5cGSCfG8gGzmosX2s6JpkfbzbBtLt8oTJLp7jKsf+hAH2YbkRlEksXEghWesa
J/CwDpTFgel76Cu/E8noe2EOi6aS9+k0TwqwSurEAE7F03tYOYNZ74hQXVh05DG/tyPz/npi
64B90TH/jz4fyc6VU/DPHxmcfgZsngQGmSWBGNfNiwyN4+v+VJTXQ3KSoxemGiGUPRKxOEZr
Iw6T6xQST1X4p2EwYZitVfRAnEhY8Xinvl0woUBK9TDT2kSgavJLjfxbm5Na9n4YuCYcRrAN
ogjrg8hh3YxEYYAb6aWaDPnZQrRbmxRxyV+lKdYltra2boAtAYVihywrQHhBhCMiP7A0F2jN
oTSx5cpt3o9V6m/XvibXITw3MlcoX7jicJTjY2Z0U+Z7Ij8lOlXZ/R9lV7IkN45kfyVPc5sx
7mSMWR0QXCJYyU0EI5KpCy1bldUlG0lZJqmsu/5+3EEyiMXByD5oCbxH7IsDcLgPMA+GxNwA
a4UvHY1sw8NYRtZPLil3Hccjayg7HA4hdQmoeUURP6drqZw1zYGLju6ZMCzWvPyEvbN0EHn7
9OaYI4sDlxbrFAp9jbJRajRVQxRDZUj1qQKRDThYANn9uQy4sq1lCTh4yovBGzDEo2sBAjtA
Jg5A5FmAWJkiVYi6d7oxdA2yDUj1FxkmZyyngjXoMmHoW8pUzBabeET0txE+jB1RVnRa1V0H
k78AE6tYX3Mq3yn8xcp+SruePo5fiRmPLPdfG8Ol36SsBLRFN4ZmLgtUcgoLs1wIJF5xoj4J
/TjkVCMuRi4s9pxW1qkK3YTXZpoAeA6vqZhPIFZRGxsJJ/rb8gypoWr/XJ4jl9yhrowSj7TV
qecGDUlshv6aBh6VeRAmetfb9SIkPDqccurrecKmt9sqJ7YYYlBYB2Ik42NKN3QtqQeeezf1
wPNIF0UyIyCmPAFElix5ETHgUIKInIiISyAuMUsKIEpo4EA0JIT7buyTExX6Lro32wiOTxkJ
UxgB0WUFQLmTEsCBmNHnzFLNWqedD0sRWYpq7HN0+0k9k765tkqjMCCizZvCc491uowOqtfU
ESWYbXDsE01ex1QPqallDEKJ9qzqhOpKdUKmlpCpJTFdIFJhTYKJtoRQ3xJZ6PmUpKMwAqL3
zwCR8S5NYj8ieyxCAbkDWBnNkM5nmCUfZGsrNzwdYPwQlYhArDrykiDY5+5NCsYryBvAme8R
Ddmm6dRpTyEkjKqUIgkPUjV2y7Nps45q42E+IVF58f5EeEQr2wV1rXZbOI71lBZFx83Mlg3v
Lv1UdpxEez/06LEMkMVK/8boeKj53LthvIoSWLb3Z/jagx0odfOmrC3kmJwBfEp/qdjcvagV
xE9I/XNt2g/IyUzM76QCjUTxnNin51VA6MVvnlqTO/nyg4ASqHFLHiVEjXRjDusU8QVs3QIH
VlIqK4CFfmTRollJlzQ7OM6+qIgcz9mbzMasy106Fx8ryPh+/N1TfWdZkXUsrCsIPw93pA5g
7Iu858H/t1nJEJySjZ3VOaz5++MgBwk3cOizY4njufc5ER4i7mW/5mkQ12RWV+ywN73OpOOq
v6Sjw8BjUmd5+76OKDELhHvXS7LEJbo2y3iceAmVZwZFTnYbrGzY/ESPCKeWCQj35ynRkFti
QmwZznUakgvkUHeuY7OyJVH2RBpBIAsOSODsy4tI2a0aIIQusf5eB9eTjaGt4U+JH8f+yfwA
gcTNaOBgBTwbQORJhJMiwYzg7IAacrs1AtQKJl7SYKDKiZqTJa3Ii8/UpYpKyc+KZ2UhBlk8
Mz+xIT1nLelNkR9hm8d5eayU1+WcU8pax7RmMl0Kls7lkHRu+YBOxeU4BbA4IK9BXLAlwIuK
8bPty1PN0imtqYlaoSmHwzOyOO7bTAD9/te3T/hi2eoppy4yzb4ThtxuWL7KobOFuVM3G9m8
5V18MBzc6cLpW7mZgGagiyof07bWEhPQuUqzVAXQnc3BkScYEWoqgohY1hsFI8zwsARIjYaa
SNePAOpvgW9hvhGmXG5g2Pyoa6o6pjomQOzEhhzfmPPpRJpxFBlLXX/Ui7wEkgXpvIg0ei3A
m03Uv9VgL5wGrthKxfBzCRtfd313pwJhOGoArNYTlLJMtVopP/DIG/V8PuZ1V1Hu0xFMkq5O
VAPQWzAl481NeLvVUEPFDQUVKivobKEH3whNDo4e7RD5kR7prIKshq07cL0sfT5QFqwRWi+R
5E/WMP3AziRY9GgX3SPNTJFIrk40N3wif0PokPdYAnxMnESNpW/CIXK1QF4GcTQalkgFVIeW
pVagj88JNCYlNLHjGK7l+Fv7ajYC06ekPzMkaCqMGKYYUDaGgK5NtnxR1ZctDO9xXEd9xDwr
jrm0AL5jZVbEvymd6aHzbZFSaMxNl8S+NbaS0n6TYkz2snFwPSIbEKru7RF5qmDX7ZONXdV+
aO1Mi6qc1pasLz+2DbOck4r0tFfIooGHpyBxjc4sXgBBNdgsl2wcweB6pHWhTcCLSqoxqZ1Z
htbM0wvZ7r1QMOsIP6yy4TnbEr2mT27Pb4FWX7wbY3aVdm2rgcnX4xsBrX1eWCW8Vl9q2YLk
xkGTscLHx8b6SmUH5uxTElGdU+HUiqnsDULBI5H3NiqkyiQSloW++t5cwhr4p6MbaCMZWgcE
aZVHdgtHiCdSY2mShYb4FsRTHUJrGLU9kVqfNaEfhiEdgUAT0grbRlKN423hs7xA9ZYZuYa+
Y0FDdfrcsJJXB9+iwqiwYIPg0tr5Gw3moYicKCUKTPixS5VOIGRbCb2N0YbYqnqZlfdzM6R+
mBzIqAGK4oiOe5WFdiNHUigvMwq0Sk107EkU0AdcGot8bapyZtnKEsGBlAH0jO4V4kAOIoEl
qnqDjnq07otEmy9R38FKyPMfmdO5UN1k76q7MHDpAnZJEh4sRQDszrRbdx/ig0dOuyjKuuQo
mFUybYhsGlxFZMF4Q7pjyThdAHxtEJCa+TLnJimbWHH5mLv0qtJdYYqLLL1bgHdmQME50HE/
1VSw0HDqu/pMr9qLAlSGlDv9aabS5uQ01oUfp6t2j7JRhBS/G4kh1G/QolFEIdUpdB264mch
69i2fKDFiplw7fPieCnoqpop3RP92ErmCVlwutakXXaJCHsNJ2J0JQGYeJbHRxorptViNxbe
DLiRxQ66QhP7id1MI8lTtqAqFjr0KF33HnRp163HO3IYuu8qCG5Z7hZE3WZIQuZmcJOI/qqf
TRoMfYugDY+KHUtV5bBPbWYj0zzV9s4Y0rRDWWhv1uo8K5lAUWO6tSjXzyyCIc7qTt9f/vzj
8yfKZHM9TmV3ufpabjLZpiz8wPPGcsqEeclbohiedRO7jKvBcKKkgiS083heFaibrUb8WPPF
7LUZXhxX6G8zOki55ujMrmur9vQMrVFwlVcc0ZFDXmMjlfJGfQPR2ymrqjb9BeYYtWQzocqZ
MNrIxVMeS/nQMPsELZDBZqiv0QgzUU3QhJbPT3k9iTNfoqxYDTZM1ojG3zw9CyvYt0eCr98+
vf32+v3h7fvDH69f/oT/oW1tRQcSv5stvseOQ93zrgReVq5svWwNF96dYaNwSMYdMDRe6dny
JjLH+lpx2rF8JwerRbieLI4pBAiVaAV3zGQhjM9wp+xpOmc1bYn1RqqumT2a2eMFbHWoUzok
dKzJq/VsPfv8488vL38/dC/fXr8YzSWoE8NYV5vAe5FOjF/49NFxYKzUYRdOzQAbNtmu2kY9
tjlsn1BS9uJDZmMMV9dxny711FRkLFgT8jS4Ibysuzu5zasyY9Nj5oeDK4tiG6PIy7FspkfI
BMxf3pHJgq5Ce2bNaSqendjxgqz0IuY7ZKHKqkSv4vDPIUnclKQ0TVuh4X8nPnxMGUX5NSth
GwWJ1bkTag4HN9Zj2ZyykncVe4ZSOoc4s7wok+ozZxnmrxoeIeKz7wbR024dSh9ARs6Zm8g6
xBuvaa8MeaJHuJYMt1VZ5+NUpRn+t7lA3VMnwtIHfclR7f88tQMexBzI2mp5hn+gEQcvTOIp
9AdLp4G/GW+bMp2u19F1CscPGlKPYftE1jSQvZ0S+ejZc1ZCX+7rKHYPLp0FiZR4Fj0Iid02
x3bqj9AVMlLRVBoQs/2+iUeZG2UOlcGNkvtnRnZ1iRL5vzqj+h6E5CUJcyb4GYReXliOzukP
GbtTpLx8bKfAf7oW7smSD5AWuqn6AI3fu3wk1SEMNnf8+BpnT7LTSIIU+INb5RZSOUDblCMI
83H8Hgo5/0BfxEdiY+AF7LGjSzj0l+p5mWnj6enDeKIPk7YvriUHGaUdsY8dvAN9HLLRYRR2
ObTI2HVOGMLuSZOelxVTW0nkwhz7MjvlqgSxzPEroixG5eqg/OH4/fNv/5QdFeGnadZwISBq
9ZGeoT4HiBUlDPLUXshHy4wIQY14MKRWPK4ogGWqdwAhl+Ynhs8+ULEl60a8xjzl0zEJHZBp
C9s0iXJJNzR+EBlDrmdZPnU8iVRFKA0MbGMAxCT4U8LnWswQeHC80Qz0/EAPxEVybQUFGs5l
g6/O08iHKkGH7hre8nN5ZJM454tVpTkCp7ZSBC3REoE5teiUlyFLMG+iELqAauBg/aTLXI87
pK4fUmYf7TDwWDNGfhDqUch4nJCn5Aot634xxFGWXePQNeZ4CYLNTGaxkaQzNXneGHLmeFGy
U+viMuzEsINVFYyVZTiYjCo7GrmvR0M6leHl1edXIhC3fuoEkA8Nu5ZXPY0lmFKSkeu+T7vT
ResV19xztJ6yWtEuRmM0p5lNOhzKjHNtVsCx/6wVYBT+Aws8CoC9JqfmNxBQ8mZ+fT59uJT9
ox5vedx84Yk5sPj+8vX14R9//f477FMy3U8bbFPTOsOXHNKTuOO8m3+Wg+TirjtFsW8kyoyR
wp+irKoeZsQthwuQtt0zfM4MAMT3U36sSvUTDjtYMi4EyLgQoOOCys3LUzPlTVayRinzsR3O
W/hWWEDgnxkgRxcwIJkB5j2TpJWildWkC/RpWICoBx1KVljCFFn6WKmOkCEUn7Ivu2muZRF3
UljYAf0y6GcoShf4Y3VFQrwqxGZYjHjRhVCGPvyGYaN0jOPUXXv6MAywFpZ94TDIUkNupmn4
YAq6dztMY2RuRJ3XAvakHHRjrKvDnkmoUcnQUMu3d0sAiEdpXlVa/XKfOgHBGjnW02kcglBL
VnqZKseTMXr+B2i5a1ZbPEeRrq1zJfTYtyzj5zzXhgNsSXxZPQervGadZ4asx1rzoZvS9Wa8
ueApEv/FN7/kqMVaUh8ps5zywap+Z8UKvUNveNrCupIOaI9pQsMb9EmFGmVHLSkK5QpdkUgy
EKD1xGRhhe9izQnx7G5eMtn1jYLUZTMV6DNFvKh//MWxJVLleTexAk0FYclMkyOzGyP4oDjO
ErVw7ZIvJ1mZrvx4ix1HbAaxth3zI6onrYSbXGXm8EbZkaNu5JsYPWXXkoxuY9xvgY07S1ew
qO8lPi+y0H2Igi4YOhaq5RPBu5W6xlTXnZCOJK2rJWR94lspPkoBXNbdJSVyKRcNe3z59H9f
Pv/zj58P//UA05zuU/jWrHgSklZMjLprmSrqSYjtmFC8LUl6BAY+a60uSqubHu8N70grWBsu
biSeqjwjI8/wOtexQupLbSlRuz2KjSS0IhxGRS6gA4l0yayzYSCUWYMVUzVHpNiuoefEVUdh
xyxyVRUBqfB9OqYNLaBIsev2R5eedaf/rFm5llnealLIAuFQ3H7BSFOsLeHvSZzAwWJMnsFJ
jOsJlnc1rgVJq8vgeYERM6xjeX/ejXqhrHGT3y/RkzVk3EOtsfP20sgvDbQfsx6dGtSltREw
5ZX8gH8JLPP0ECZqeFazvDnhZtqI5/yU5Z0axPMPxlDF8J491WVWqoHoWBdWDj61RYEXQyr6
K5P9i60hIAx0lwHTUN4QNHhEyvECi3p5sBRvrhu1dM8NQxOksPK1cv9CDL02owtpEEs8NalF
kJlA6JoYufiLJNElkSppYPA1748tzwVMWhFWSWUzaNWwSjdKrLOEtXxmiTQdqunK8NZAveQT
Cc6W/9RAaM0LWt7tiUa+1PWzGYyNPOUgEww0poay9BCbh1WiOOJpBTdEinP23+yv3z6/bWuM
6IgZ03pmxm6Wr2ASMtoAcdF7yQlsZcAOUARYqhMpc288gjik1pyKzVbBXDOFDp/LTLO36p1U
RBWhPcNqyB/Nks7wLHHYUF6eajbklQ2/lkQVzpCYay1YWva99lxYxdsmH1lDPUbRiMxxlQef
Bup7O8kIHKSl/QZdyEIF4B1EXvoOaW1H62Ky0HTroGZB+twsXj4OFqTD5q5azMXH/JcoUGaW
EZ/74emLNsrEwqL2xKLs86dSflckhy5xqGMPZm9r7bQjeVSMUMnVI4RbOu18bqTEc8yPLW03
WMke+mJ2SCtkCm1gPGW1nsYNrtuBVgxfWQXbKTIsHSnpAVtUuez7egmY57XZm6mGrJOSuqoa
tHVlNJFVicNEmD67LoHCsE/pGS0gw7zLSvId4MqrcbLuyCgASj9OGYs991CPh8QPY1g607O1
PqWv+iGMgtCgy0uEkO6NWr4Fz9uDTM/Zhncwe1k8xio8qKGdCqjLx74Va/bQqjmp03O3RgA/
tHwuvgtXgtlAs0dCY3SkdeSLd2Z8ejqXfKis60PeHZBp1JDk5pxofNkJuvpqRyyz/C19ENPY
w+9v32Ej+Pr649PLl9eHtLvcHOGmb1+/vn2TqG9/4uuJH8Qn/6su11zIRahu0RODBxHOSqqv
IVR/2GsnEe0Fmny0RMytEd8bA8jJ54xR2SrToqxscedY1J24xZUGSKhZzczoEcQyXbQyYfjc
7FqbLXsGrSE+/089Pvzj7eX7b6I9jHxidDlPfI866pRJ/DRUutaGgr+jIpno+yBc2yKZG5Hc
G+12TqWCPLRhFXmuY4499HkfONK4VHLxWPaPT20rsrNbGydzHoZAkXLZ0GWb0fZik4lW1u2K
C6hUpzjNFT2nY0WtH3cwq+B9cAsRgOAPwiPM4cRwLMWVNJ/1BysQ7Sti6Um7ciHWKNHaYsF5
XhfFNxRfNk0F3jhl1TMIxc1pgs0ZeXx/m5aHx+k4pFd+U+Zj2DvkAcC+fnn75+dPD39+efkJ
v7/+0Ps+pNA2EyvtEsLCGE+Quyyj1Z9V3tC+kwednD5EMXhah7EQxfGAGFjvIWMPeWe8SH1X
VmG9vcM6je/P5sn1GNQmEwL5+7i4XRlovfFbtxH84eDo9lNW7cn7nYgQx+e52EgMzxd3c/MB
ti204vctv7N/111O36aPpFVPel3oX7+9/nj5gagxIjA6fg5goqa9ALwjRn2g8rIvqMrBcFOT
gCJduH7UhEhb7ExLiOLURH/XFnT44iW9b4+5cW6wcSDBtluMc7eksQWJTyeEy9x+5pFh/VrM
mXe+Fxx7Fcz4GUY2iJFT2RHTvxQNOuNauHs86O6zwSKCcWTPQ89Q8Ue/CqRYZIdBHC8kn/Kq
el/tT+OQN5wQrIQfKDIU1SuIdZMP5U3aGurPn76/vX55/fTz+9s3PKoV72MeUGJ4kQcHObrE
Uxpty2Fhiam3t22BN15W8Ey5KfoPsjgvnV++/Ovzt2+v380BbpRBGCDZn5SBk/wHnOX8ao8a
OnaukTlqxysAQzzdpv2dCphryJj0htd/w5RXfvvx8/tfX1+//bxNqPq2HUZNhhZt9DP0BeQb
KFIy481YKadMbKkydi2btESlIWrkrHCdsp1jMpl5TfWK0oh4Fznt7q9vrDo9qqnSpC67VYFZ
2fPm5eFfn3/+8e6KF/EuJ5hGzn6NPTef8mtNd4f3trYZ8fp+ardeZt9Yd2eBhSYWSVQoqoUx
8p2qXD4Q/dzsbONQdCdGH0YIpT38f3eb5+bxa1grukn+VTUPSfJ4SdgXiKzHd0h5gjXlciTy
AgDLqDWfocqqc7s2oI7eyCuF+bzLTXzSRuNGOKhOulQEq+bu55r5TQlLHCo89pU3vxvALtNl
KCuidhBzfcVErIwoKtsqMlqRaAfRLR4Z+L16QVpiTSC5k0DyrgQOqmcFHXtnFLbWY5fYkd/P
KIjrJrakEZvOtkNzhWVL+Zo4lj6JEGkVT2GQ3YS7bkzH+hi4ju3aYyUopg238CCkw0M/pMPD
wJKFyCVtCUqEgOpOGE41EoTHLp1U6JMOEyVCGNKtW6Vh5O1mExnmxRVCx8xL9j8+oquh1ixL
+sFxDv6VHC5p3/JJ3Ltl5CPKG4/7YeUTFTUDRIeZgcAGEM07AxEFBF5FtZIAQqJZF4AeIDNo
jc6WgdgnKxCgyGJVVaLEpHVYmWApRWyd6RZUm6RI2jgmNjv2G8t3ffKIFqHAYmxTpvw/ZdfS
3DaurP+K6qxmFqeGD5GSFncBkZTEmCBpgpLlbFQ+jiZRjWPl2krV5Pz62w2QFAA25LlVUxmr
uwHi2Wg0gK9JbParwKww4zsZrOCW+pAS9IABxtzFWBBrp2KQ8ysRUViEDiDeXmYfeFMy5pAu
MQtINdl5kD+aaSgWREuXvYLsmdOaKYiJKE/aiLaQdJc8oZXViR1JN6KXXukLLyI6B+3/MRVN
bletMjHzKU0C9IBS6ngq4cdUH6jzCnsuuMRur//rlseU2bRJGXUHQmNRZzZyClEKFp/HHpq7
0KM0Yy7YMiuKjBgJfLqAVZRqhKJKNiVbM8QGueUrl0ib45w524NdOidGiOJQ867jEKNBcsJo
5vpQSK/Ckhc53vcaQuRTLENiEbjKtQjIUdTxHLjWZunDDwfbICjSh38gSAdNMJvFUZ2YYqCr
2I8RKI+8EWTL4AWLlhVjoTrhfkxZ7MiYzQnF0THoRVoyF4Ra6RiuVbFn3567KDWPHbkD41bu
yP4w99DziAkiGVQvdIwbn5Xsj9Z6lINOGIExugU/rEjkewExNyUn+NvJuFETyb79XVB3YUC0
X1OABUwMMaCHU0qFNG0wIxYOIM8JbQrkBfXV1veo/bakE6oD6KHnopMbA8WxFcBIKIp8sjJR
7JO1ga0EWewonhJjUN2toemUjS3pxLRGOjXGJZ2wNyTd8d2Y7I4onjnyN+LaaPQ5sbAqumug
dtyPdHLTwib/n0j5/j+Sij4YBNpdCpsjIXwp+prTjrGeQyvggdtk8AeZXD6mZvCvglYiJPrD
Opdl5/A5CsEDcgohI6JdJ8iKveBDHdnL3d4PgdQUhhNRgpaFtH2PHBIGTxOIAmLC4L2KxSwm
prBATz8j3HktE0FEbWElI3YwZtS0AYaJYawzZj5ZVcmig69dJeJpQPpqWtgwTP1bu8V2xRbz
GdFSbbELA4/lSUDoEY3pmtS6yEfj5Cp7+xx9kAv9/e1bBFfJYD/9cIk2pW+vl1dZQgEoJuw8
QnI30KVNk70/vb37bUXIgmDmei2gRJS7gSgFcmjnXftQTL0Pdt4gE3skNEQvsU2ZH1K7RMmY
EkWSDMrDLkGjQ9Jb0eFJ3zqgkOjaZFruWUDjIwE/iLxDtiNW2wcekGof6AFNj3z6yp3kOEKz
aCIOSPSryDx0hBPWRKauyEZXkejjD0U33Z5SgBxYyHHEBddEZiQOsy4QEOuApBPWCdJDcssq
Obc2oyhAuTOQHjm6EjiOsEiayE3noxQg1D/S56SnDDhz72MF1ond1lwI/EgP3y72NkUnJjnS
KaMW6RE9k4FDgh4bAq6eXMS3vIAoQPstJOeWs1MK0ONqMXeoFeCQ8dR0AUeWlLNG0ulxuFg4
+mTh6BPK5SPppGNFcm67VaTIrRvHD3zhUW4IpNO1XcwoUxPpPmFISTrdEYLN5/5tG+BzgYEF
bw27z/LofhHXAfHxgk/nEaGN0L0zozZjkkHtoqRDiNoudVjZBKMIYj8g+lniSRMtbuNMa/Q4
JvVZybbz6AMrBGXmN5dRKUG1nmIQNVAMYhC0NcOIxkzpwe6eh3nFwUiitkR4T5U8iL+yTYba
I60bVm8s7vAyqLtescnT8bN5IOqtCT+HCPSibbJy3dKPa0CwYfSedLvJ6au2mHn3KGl8c/TH
8fn09CILOboBggnZFMEL7bKypNlSFpXk1XWRjRJs8a2bI8UyK+70K+5ISzaIWGjTcvhlE6vt
mjUmjbOEFcWjXYi6qdL8LnukrpvLrOSrQSv7R/VKyyBCH6yrEpEd9U9cqYcV9TgCU2YI5Luy
C5YVmXWDWGd+hiKb319nfJk3oxG0XjX0NWTJLKomr7auusM3JDak+aG7x1FPPrDCFeID2bs8
e5D4lO6CPDbycbJTIE9YSj/Vk9yW2s0g5xNbNswubvuQlxsHzJKqdylymG4VBbKEAkVSVw+Z
NcAMKAlFKKtdZdGqdU5Nnp6OP2rqwtwgsFoZoAV5s+XLIqtZGijWkC0y12BNWQPP4D9ssqwQ
7qHJ2TpPOIyQzJ5MBUIG2bXg7FFG1nPk1mRqOlh55Xh7oVq1FrnC9yn2KOfbos37QWl8u2xp
RwDyqqbN7hyFqlmJoG0wE4y5o5FdDShTZy0rHkuX3qtBORWJNS46IsKu/LJy6zgDlIb7u50k
wmjc/PToHbzkFayUKJ6Ja+rXDYIcm+UWLFfv0I28OuRTRz4SyK7IyzsrqzZjfESCoQgLUmYp
Vsi9LrYWsdHPZaUGQfhaJnJjsg/EW10oOGvaT9UjfsRRiza35zGoO5HZEx7BJ9fcpjVb0XYo
CwNHp1rTFhNtcUE/1ILeE0qNm+e8cmq9fV5yq8Cfs6Yym7GnEN///JjCau5UfypMKF7gtHpK
0ROoGobMkL9MCVbUQrfBKFNjAGc3jaShgHhbdWTWaLjpRrLhfb5G7AuE0TqqTZKbuHp6W6CE
+60B51o0xvqhQbCLjJuhBzvyGNZ7kIAEh2VRJZR+Qp4MCNCHFOXJHyKF//Jqsjm/XybJ+fXy
dn55McC1jKxd4cmQJ1KovRFKoSeChmhXZFQ/3t+t1oO2AVFDotMLz+WhgRU6UH2F8icgawhC
YSUhD1RkXhv8X66tizIb/ETcVIVnZ5TcQw0deW3EvZlN95Jb71Mk89bVX9WD9iqHg23X5jqg
TU+xYsUev5/ffonL6fkvIkRsn2RbCrbKEHVty80WFWDGukeRUKx+86F/zD2KusRl9tAvIb3d
kCHUcMF0A/hKO6jQuhRHrt2wKOlKQbKXDa51JUICbR4wUka5ztK+aRBMatQkMhljrR8sjB2o
opehF0QLCrpB8WGNKcapRBhPIxofRAlgWHLKg6nqgE/3zfjeV3pEeToku902sDmAKVWaK5dk
yjCO1Bb5yg2oRDF5t23gLvRrXgPVM8+IJF0Fn3LlhRGjIv2uk061wiNLlolGpr6M8T6nBDGy
8y3qKNrvR8/MBl7gj5sCyc7iIzcef2Ue6bfBeqJx6eZaz2jcZh3dFRd2kIlDIu0DvVeTzCGY
jlsELxd77r5vw2gRjjt5HFXNGKEJwwBGVu3bIokW/t4eSFQcO42xcHcGDObo71Gyqg3IQAYq
TyrWr+TctWkQL+jDESmQi9BfFaG/oAx3XUIdglmKSL1Kejm9/vWb//sEjIRJs15OOtS7n6+I
ykgYNpPfrjbi75YqW6KJzO0RhsGXxxqFF3sYCu664Xt6Z2fKULrXSTRWHQvqaGPgGtdwVI7X
YLw6Wax56EtP/tB27dvp69exFm9B+a8NkD+dbAPbGbwKloxN1TpSbjKw65cZa41NsS5xe5tl
iCY1jRNgCLEENgp5++hs/U6O0IM9K81WDJbJg8Rpk013+nF5+s/L8X1yUe13HWPl8fLn6eWC
gYHOr3+evk5+w2a+PL19PV7sATY0Z8NKkRs4bWY9Gcfboq4Wg11xTt23MITKrEWcPvoDtfRo
lo4+kx5U3W2agFGQLzH8zGPfIDC1nv76+QMr/X5+OU7efxyPz9/0KEgOiT7XHP4t8yXTMRSv
NIVHwdkNpirWjcSZhu2kMasS+pfjXzVbgxoghViadt30AfugmHpMrwafk4r8gSxaXlc6cJjN
OSR0oRVzBD5ISxxS1lJ2lyYtGuOZqsmhZ6L+LVq5WRItWc2mbehOQwbYqOa0sPmQ7U7XRE2b
SBQ1PWZi2+FSkbVI8SY2QmSO4Q2BtdyueiQl7bnlY5kgKL2O4vYgqVfCViXWYPzl7wOvdtkI
Yb/j9YHmDMdQxwO1WVsV6OM2mKUcJul230dj0HBap9PZ3Nh5IfgME0meu3xWrR/f6S+QatZI
tM1aBv7SyCrkkWT+j2eRm0o2V2SS1ZYC8T8E0yO61F3ErqodeP/6V8/EiH3SGVcgUKleFZ1D
e5E1CZdD1KpWl8LwPjjibCCEO4WUqbF107uLrAbW0nZEXCLWoI4J2tElhqU+TftMuKtMaU3N
+92mEu0hr9pC0zyK2KAC1L8gqVjK0fSQeAbv5z8vk82vH8e3f+8mX38eYd+qO4f6iO4fiPZl
WDfZo0Lqu55MtlIpk9XrvRu0B2eV9g/wHIOhqXg2oF5TfcazomAY26gX0hwG0tw7gJ1TF1vt
Vn9H15fLqqiTw77yZ5E2ExmogaTQPBDwQ8ZtrKq7bW0JqoAhnfzVJfgg6ry0vQvK0/Ryfv5r
Is4/356P4226NN4QyuSXSZEoK0aJRJPIwXUl9hB6FnovkA93VckG+lV/dfAFkkG0MT55kN4H
IunDgdVLZ8pV2/LG871xwnxfT2FT6kooAYficbLqoXCmaVKibgrCYpRk4LfZumE3+LtWPp53
fbOsEz7r63Ftayb4IoiJancdli73mGvdJJy2jvswHzdKxlrQjzN3C+7F+PPycCJw1wZGK4KD
mpVBlBpoJAnSXzurNMCjEfl2IrCHCoM7Im1ZU1O7YyqwlqIej/paBHpmTH6C07qdNR2c9UHU
c2+qdVXDdzOO4V9Md6MCuqz1QBod9mU7Kkkfww4jausxKwQsYi2/0YfVvmTi0NTihgxCtrk6
TELv2CjdGFBWud4FenhbviWa/BP6lrF69F2TTddYCf9AgLdbV3Bl2GNC5WBtcqB59Vm0jjmQ
DT3mOKDsqkKGKh0Nzz21ym7mIU5u3mgY7gPNBKLvyGSUVVVMCeWIIY9aan4IjERA7QBZm0A3
+B6hLeQBL2KUYUfFUwv+t7+NQy0kgxZgebGs9qY5uT9woJGt1a+iB76hOwWmCwM9G6LSax5g
cDuz6vHVRhJ9TgVsZ5nkmqdoYQya05EI0SkDxdUWdFXJ/sBnyEoGqmB1IhCpi8gMV8Q6Tezc
YL4lPL0flQymeJwfuFjTRVMwWCqNXgD4thFoI6843zrjaTfH7+fL8cfb+XlsFDQZnlwiDL62
cR1oh8TC+O8jse3qLaiYpqJjyhEfVAX58f39K1GGGhpAtz4lQRrh9CiQbNkQa3TVIYFau6VY
Z4Brx5xmKbS+QDxEhKoe38GCev4mfr1fjt8n1esk+Xb68Tv6MZ5Pf56etVMaBZnUwRQifBVx
eoSghwkrd0zzFHTU4g7+YmKr44RraI0JbIKNCBuKxwce2RdUcVQ50RHzhS4mXtNTYe+MxVAF
wkO71hF8XpMQZVXVuvUiOXXAZFqZbV/CcUF0i2Thy+I4rs4NfLFqRv22fDs/fXk+f6cr2du0
6vbQL73uSzCiRLvUS0nmJb9S7us/rgC49+e3/J7+4P02T5KDghzXXAZAWzHdAtgm2mS8zxB4
1LCPa8ZklCNR2etTV9aPSqRcmQhFbJZTmwoSAHhOY3KNUqpLAmB9//23K8fONr/na9JjpLhl
nelNTuTYHZl+OT21x79c3+q1LWXBthi8ZNWwZGU40JBeYwySh4ZRF76QL5IalmJtagKNc0W6
bnmpssnC3f98eoHx4xiMSpuBbj3ot7sUVSzz0RJUFAm1/EhenTZDsB4zq3ueaxwzR1CX9I66
59aUo0gyBU9RwPrYQ1IKoWa7yWB1o+tjsmHMsdgZfpSS7y2CdbMy53BnQOstl+0fywoPl3e0
cajYmJ1D23QSNT+kFVgIJVWiTmY4IMT7r3Vh7SDxGjRugMDu2FVFy9ZZL0ZZAb10OJIeZUpb
tVu5NRyrUTkw96eX06s9cbuEHYzdLtnqPUak0Mv6uTWm8T9bPQdPHEdg11WT3fdHDN3PyfoM
gq9nvXgd67Cudv1F8KpUXv3rmNOFYORL9L4yMa5sGCK4HAi2IyO7anJ4uCBqpgdZMrJhQuS7
zK4EcTGIyTiwctAst6LPxLHfREtbkzJuNw0tp4L/kGOzTa6HWdnfl+fzaxdVbnzZRAkfGFiz
MgzUd4uxEmwx1Z/6dXTzrkFH5GzvTyP9bcSVEYZRRCWQZ9R6DTtW3ZaRT74K7gSUUgJ9Drsd
kZgaQAo07XwxC6ndWycgeBTpOHMdGa+gmeeFHGzlRvO1L1v/UAQY5elKQ3ihuXcoM26URTkh
VjwJDtnS8W62cwJwStfnejPn6D/erlaGk2WgHRL9rOlKxgs+YEdsuZ3sbpWvpJRJ7k4GwZCj
vqX+1I/AtDQjUflVIcNc9iJahC8UEg9dGDO68si/Zq5s2ufn48vx7fz9eLEnWbovwmnkfGAn
+TPXC/YlZ74+0uH31PO0Xpe/7RfSS57AMFXBZSllwgI9z5QZAJQpZ03qxTZhYRF0ECrt1qf8
5iFMzV4Xbc9g+1w4eHij0+Lf7UW6sH6aAAd3++TTne/p0Fc8CYNQKx3nbDbVsas6gpkREq2H
TECaTyPqIg1wFlHk98Gb9BRId6bQS7lPoOcigxAHBsRWezcPffPRJpCWzH6p229nzDGoxuXr
E+zCJpfz5Mvp6+ny9IKn4aBtL4bCZenMW/iN9m2gBPqrQfgd62NC/T7kGDppiFVhsBcL42JT
H2sIlDrpNoLNFNMjJqvtFeMsSgOLs68Db9/RrvkDdT63s7/OCIxvKB0LdAGSxPc8z7dzTdkC
J9K6duWblQoKHvRFK0O/uu0yZoYoRZd20eAaR5dIhpXZB5FZ+c1+BnNV82bL2AOGSO8psb4H
6/csdXwLts3+3M4HiOE18+tFkDYJpjNqiEuODuAnCQtt5cW1ONRRY/DdYuwbV/Z4UofTgJx0
+ASrze7wPiIs6HjibJWNZ+Xhsz8eBh27ZFtYDo0JhUcezkGj9jQcWmZ/2Fd0nk3CGny3VJmN
15RRG/tzkyiSYDZuUFFnkIWrDEL2GYYQHN/6M5ZzlLJiyfV0mySx4vv72ATHTCLPnOQM0Evd
yqnszX2qUSRTmHhKSONgcI3qv1vFvuesf7cP2I/4vdK7peB0Fbh6O79eJtnrF03v4fLTZCJh
hbFvGKfo/Gs/XmDnYL6D5Mk0iIzEVyllBnw7fj89Q7nE8fX9bNkGeOp1qDfd4kkqRpTIPlej
dxRLnsWmZYC/bUsgScScRETI2b29eNVczDyPBGdI0tCzB4yk2dAskojPd8gXnViHvMnRzF3X
+hItaqH/3H2ed6tHfyxgN6J6Pnv60hEm0JNdSDLzjWpnlSjLz7wybLF7g077Kp2/Pni46LIQ
XUsor62o+3RDma6b0hHTMobMDGle13Vqg9eNe5gCT2rg0kt85MXarU34baClwO/p1Fjgo2gR
4OVI3S0kqWFjEOK5mSxexGbZ07pqZXSp6/0jMZ3qL7f79ccIQcXjINSvlcNaEfkGxDdS5gFp
bSU14q6OFB8b60Jmq01QVECMIhPyQWkpYNB3om71gXJSwgD68vP791+d40IfEiOeZK7ejv/7
8/j6/Gsifr1evh3fT//F68NpKv6oi2KIwycPzNbH1+Pb0+X89kd6er+8nf7zEy9n6d+4KScF
629P78d/FyB2/DIpzucfk9/gO79P/hzK8a6VQ8/7/5vyGmL+Zg2N0f3119v5/fn84wgN3+vR
QfOtfSNIu/xtq6bVnokAjDxym6XpArmWh8YjUF5vQy/yHFu0bmqqdOT2RrKI3U3ersOgg/Wx
BtK4ukrjHZ9eLt+0paSnvl0mzdPlOOHn19PFXmVW2XTqAFdFJ4jnO3B9OmZADnnyoxpTL6cq
5c/vpy+ny69xBzIehCacdLppfRqkepOipe56aDs8ScRo063+aLgVQeDbv+0xsmm3pDoR+Uxt
1a4LHVACehs2qqea/zDxLvgU4Pvx6f3n2xEDiEx+QrsZAzm3BnJODuRKzGfeaDgOAnd8H5NL
frk75AmfBrGO0aNTrTUHODD0Yzn0ddeTwTAL1434QvA4FXQAxxstoR4JnL5+uxCDJP0E/Wt4
Kli63cPw1FexAgessS8sQgREo10vdSoWoWPwS6aFKXTdTm78GekHRIa+rCawxvg6gA0S9FUN
foc6/l2Cb7Ai48oFUGLSp7CuA1YbUSkUBerreRoQY34vYhjszEAw6a0MUQQLz0AINzg6Kpak
+Pqyqjt+CvvBtqLDpttwBHwSzA98an/X1I0X6ZO0aBv1Cuu6+dxB907J5+qgrEDLmSBpHY1C
JywrZuK6VnULQ0H7eg3lDDyTJnLfN8IjwO+p6bIJQwOevT1sd7kwTZGOZM62NhHhVEeElYRZ
MO6YFrohig3/tCTN6XfiyJvN6HtNwJtGITW2tiLy54HmxtslZTE1QOsURYfy32W8iD0z8ICi
kaBluyI2nJufoQ+gyX19QTS1gTqFffr6erwoNxehJ+7+r7Ina24b6fF9f4Vrnnarkhnr8PWQ
B4qkJEa8TFKy7BeWYyuJauKjLLu+mf31C6DZJLobrZmtmkwiAOy70UA3DozJxVgC/uY3W6vT
qyvzyqG7Ls2CRe454wE1GXluPPGzuCmyGJ34+cVnloWTszGPY9ZxR6pIFhV0G2y0nnvQN88u
pxMvwor+2iGrbDIy4rIZ8J6H65dkaXzVyH/8et+//tr9ZagWpAitt8ZjNCfszr+HX/tn36Rx
XSwPQeMXhpPRqMv5tioaChfDGy/Wo5KqdY5nJ59PDu/3z48gpj/vzF4sq86Ir9cFGZIS5Vbr
spHR2rLTLOFvl+QIQYNeaGlRlIY2yku4ree9m5R4usq97A7WZ5DZQEF5hD8/Pn7Bv19fDnvU
ANwZoTNj2pZFbe7Gfy7CENtfX97heN8P7yKDnji+MG7iohp4gXT5gFqekUsBlTvjxELAGQ+O
3ZQpyq2SYG01SGwsDBwXy9KsvBqdynK6+YnSo952B5RrBNY0K0/PTzNmvT/LyrF5iYO/LfU5
XQID5c/KZT3x8CI7IFV5ahwTSViObGm/13HSEb+uU7+tJ5IynYxMQT2rz87F+yVETC6c9duo
Jkp3hmdTHiJyWY5Pz1ndd2UActO5A7CZlzP6g0z5vH/+wSbFPGIMZDePL3/tn1CQx+X+uMft
9LAzCuBy0ZmYiStNoqDCyCJxu+FLeDYypMDScAOs5tHFxdS8qK6ruZyVa3tlChxbaAn/Dd8Z
zsN4ak9OxXDPm/Rskp5u3SE9OhCdpefh5Rf6RPtempiJ5lHKLv/l0yveU5i7aBhv5E2nATDi
OPOHG+u2hJcmS7dXp+cjaVAVik9Qk4GgfW79NpZ3A7xZXAKEGEd8RKX+9Uvhhnn9wA/F802Q
dsNkIDLnF0DtMg2j0DbmR7R2oZFNpxUBmikKXSJsXKVmknuCKvtFzzfaEcRsZ1xeTbZbu3md
v4GnpGUy2zAvTQQl2XZkNwdgY8mTvcPBQZFZhailZTeG4lNIh5NCqtvLOmzs+rs3NM+HaMeH
PpNmE/QzlzlI2ba2G9XlX/W5UyAJRZi4PLObZfkPGDh80PIjOz+IxuMHTzRCKnKDwB8qjLD4
HGaOCGVqtjpvuVEYGJCyrC00eN0YhZBtm7edTRKHok1mh1xWwq5SLlaej+76KBJJdX3y8HP/
6ob/BAyOnmH+DDshkdSSr+T3EiSGCb2aIZBWQywLThbDN1mjoRZJBe/Q1V0wIhrmsldPL1FX
qK4ls/wmXCNKtprvCl1eqmbJD+l3eVm3C7GbUHAfDgp6G8XMZBl3MeAxbFxlQfNGaSW6BvUM
j4WFRTZLcv4Bur8u0Ki9DJcYM8+wBrbnqq+lDMJVq/xH+77WcYNGRk1VpJaZpMIFzfJCupDo
sNt6dLp1v1Lc1vsZNxuXEN0rp/f7ZR2t3I/RZMAzo4SmhO8LOeSsIsEAg4lvVRCB4p3ehpGn
gdsy5YCgAu0G1exIBfjAfwR9zNFPUSjD4YKL1QxRRqE9+XXIgxJ2MDIRdftBjCkrR2fSIdWR
FCGmbBa+XedbiQcqLOYaua1DM7yLQknpqUWCdpGuhUbf3ebylKoXVr2kyPVJMrUxqdAFSlvR
lcvbk/rj24FMdgeW2EUobgE9DDYDtllSJqAWcTSC9cFMEf6ahYncYgEmqEsyD+QTE9H5wozG
ASINudxFT4CHJLL73kAcbBf/low6h7RC3nvjE4oxprorRhoAkvB2ka9rKo0dsepbUBXwU8HH
GvvcOqOL6LzWAyIiJiYir8e6aqPhCMc5iirZ+J0KrbCFcliRHq+abw8KduzoWGNQ4TyM26ao
Kst8WaTDleYb4I6khu1jBtAxsEG6kTgO0qDcSx4w19Qde6klW+C5/Xr3NrVzLcSgVHI1nWei
MeEKjscFHpBqwq1S60SlsMRZ91auuH67qbZj9Au3ht4lrEB4MJeRcsycXJwhPEzXFCBVaJA6
Fo+uC0Xh9DPbgA7VQhXQwnXDOTbHXlKkOazYmgeQoNvxZQ6KSC2KLAaNu0UQ5TYpKycCFD2m
hRYgfD2XY8xo/Lb2r9QijNMCLUqqiIfaRRSJKN3qY+DOAfR6ejq6ctup3Hwk9kgYiqGKIt48
zpqi3UgPQAbxsqbBs2d8KEy6ROLNvDw930pbqArIddO/NZRJX5xPNAszP9d+P7QPojo5wg16
Wpfh9qjmtuS51BDXSapR2W5A2C3sIejQxASIwFO79hnCus1zrjPuh+Vj965HHdvfvXzwr6lE
1ZnTCI1slCo4moxOsa/28TPgpxr/ZOKT5fT0wl2oShkEMPwI7f6TRji6mrbl2KPhAlEUdFKF
0CtSyjv5v7W2LchkZVLG8jMdFqwkamS+cnidgQYDDHtJOptJlNPsuy99pWcIWuxrdEGSld4s
NHYS/LRDACgRbvf2/eXtiW4In5RdiBSg5xhZL4ySp3Jnw/n49rJ/NKxa8qgqPPGfNXl/Yx4Y
KlW+yeLMafny5uT97f6B7oHdcNO+wA9qOuyUHNoUxC1SN4lk+if+q80WVS/tezFtMDLsHSjs
QFkBw7PM2BwUhUPgU9gXjQuFfok9JLJZlUQLWYIifDSXlEujhqzUnR4+rSUFBlR5fU0C/zT8
bPX9KQP36xPDCoOStR2cctgrpOAQv0ZL5MXFFU+Ii0DTiwwhXUQi6XXTaUaZtUXJ3M/rhMdQ
wF/kRWf6ctVpks14UHYEqIPM9GKlN0j4dx6HRnAIDkfpUbT+YSRUdFFnKsU8U+DWSCVflxd1
Iy5yy4tP2S7uMd4icRc25JsAn0OaGOYdfUZqfgEDoAR5p+UzN27nsqtrM2nnbMA6AL5XJjCv
IbsK16g6DteVCiA5YKZ2KVN0r2znRUW1O7SeCqZHKrAu6wm2goOvaVXsvb72r7OIVYi/7G+h
kmwWBuHSUKGqGIMdAk4cqq+EYOVanRgMc1gXxBWABL448vQxvsZj4CHjpnrra9hiXo+NlnUA
zGi/SnJ8+GQvIcD9NHlftIa1xTgUz2KN7z1m206XcMul1tc2XEWzzIJ6hanURSTvwaxR02AY
l3SwYdBlizJNBpMbrrowVXIQ2Z60WqPqAyvpttVhHA0Sa/UoYFBTZEynzbCM5hh9yAgUmSep
PUvzsdNFAuH4yRPdfdFug8YMJqQRx0dGUx1dm0Skhs7fBrLyD8LY7gyF2k3yr8AZEx4FUdeM
KiC+WovI9K6QgFMXeFc3kfh9xSN73hV5rEd42PZKghl+i2wIY/CYO0TDVOR/OJnEsUnSWG86
dvCBgIUOR7c2np3ebZyH1W3pTdkEFLiixFU8r52opDYgUQDavqz3gU13vS6awPqJ4YdJz6Nz
b27MelkBsCO7Carc6LcCW1tHAZsqNq5Dr+dZ026kN1+FGVsFKN/sQYJdN8W8nsoLViEthjen
s0kiL2Cc0+DWWDYDDFMuJRUe/PAXY2MCQZDeBLdQb5GmxY3BbAfiJI9iOUwWI8pi6HBR3jpy
dnj/8HNnvOfPazrTROmio1bk0eeqyP6INhEJGI58kdTFFV5qmdzpa5EmsXypdwdfiMO5juZ6
6HU75LqV/VBR/zEPmj/iLf4/b+TWzYk/sg1Ww3cGZGOT4G8dChzzFJYYmnY6uZDwSYFhq+q4
+fLb/vByeXl29Xn0m0S4buaXnGt0lT6ZEKHYj/fvl78xLapxTvZBJjw2IkpPPOw+Hl9Ovksj
RX66hs0DAlam/xnB8InD3FQExnHCzGGJ7DCpAowtkzSqYsbRV3GV81otw4smK52fEh9WCH3Y
6cmOVXjYOGhYH4IKU70F+O65wKtQ1fIBr/4a2IBWnt2xY3J6Uqtg0RgEMs7kC0JgjjdFtfLR
aaqU9Rd+6EVhrLChzLTuF2k7FXMjGyQXkwuz9AHDI9camMszI5i0hZPuFC0SZuFmYXyNuTRj
Alg4iflbJGNvwRNfY7ijnoXxjsz5uX9kzkULeE5yNTn3FHx1durDcAMpEzO98jXzYmo3E3gw
rqVWSo5jfIvp1D3FAmpkoijGuNk8XdHI1wL5LpNTyFd3nEIyJ+P4M7lNzuRphG8bafyVp48T
D3xqL+YeIxl6IcGqSC7byhxdgq3tNmdB2MIh6UmpqSnCGPM/eSpTBCCyravC7AFhqgJUTDM5
W4+7rZI0PVrwIohTbivTw0GuW9njgogE2gpi8JEik3zNg+oao4ANdbrQrKsV5kezeoCHslCN
oQLDDzcBwzpPcBeIp7BxC6M8k3cPH29oyenkGMDct/wovEWZ8HoNamWrLhyGgxd0aVDzYZKQ
DOO3c8XTKarBFIdxZEE7xUHD2djD7zZagqoSq1yw8gGGVKQGJKFLpc/vTmFsoyyuyXihqZKQ
zZYm4Mc6xT8HiSeK81jl8UAhtsUA+SGqQ5zSIuLT4pYwhyIw04zYHZcc2VpdBpLJD92zhESa
wdSrsHqsVxIaE64sv/z2x+Hb/vmPj8Pu7enlcff55+7X6+6tlxK1zDcMHHfaTuvsy2/oRfz4
8p/nT3/fP91/+vVy//i6f/50uP++gwbuHz/tn993P3CFffr2+v03tehWu7fn3a+Tn/dvjzsy
sx4W338NiehO9s97dAvc/+9957vca4EJGsqgqVVecJMNQqCRBM6NmTKHXYwqmjlscUYibhdP
OzTa343etd/eXbql26JSGjgTs2n9F/qqOnz7+/X95eTh5W138vJ2oiZmGANFDD1dBGXC5EMO
HrvwOIhEoEtar8KkXPJlZCHcT5YBsTEX6JJWXMEeYCJhL2Q+2Q33tiTwNX5Vli41AN2y8YrH
JQUmHiyEcju4+4F5U2FSo6lvMEtj+66uo1rMR+PLbJ06iHydykC3evpLmPJ1s4x5spgOTiGm
u5eW8uPbr/3D5z93f5880Fr88Xb/+vNvZwlWdeCMXrR0QHHoVheHImEV1YHbk3W1icdnZ6Mr
3cDg4/0nuto83L/vHk/iZ2ol+h39Z//+8yQ4HF4e9oSK7t/vnWaHPK2RHnEBBsou/Dc+LYv0
tvMPHV5H9AZaJDXMlWTa1u2Z+DrZCD1dBsCONrpDM4rIgHz44DZ3ZsRu0tC5dMutkY278kJh
ncXhzIGl1Y1QXXGsuhKbaHdx29TCgMFZ7Qluqxfzsh9uZ+liLt5mnQnNwwtZI5yqesW9P/z0
DWoWuE1eZoG7Urfy+G+ywH3wjvY/dod3t7IqnIzdkgnsjttWZKazNFjFY3e6FNydWii8GZ1G
PAWuXupi+UcWeRZJikyPdCcqS2B5k2maNHJVFlk7RqKQzUV7/PjsXC56Inoz6c24DEZOawEo
lwaIM9E5fcBP3NIyAYaXxbNiIdTRLKqRJytlR3FTWo1QMsL+9afxhN0zpFqoBaC+oLyaIl/P
Elm81hRVeGQZgERzY+Z6thBCgkm9UgNMdZRIRns9BWoe6nuBEwJW0lcZWprdKBZTsyjknP6W
+NcyuAskJVBPdZDWwfjUe5ZIyyyOjxUYVyUmoXPX2VRoXhMfGcbmppgnwtbv4MMIqxX28vSK
/pOG/N2P3TzFy0t7so33rw52OR0LnU7v5Bg0A3ophmZU6O71THkb3j8/vjyd5B9P33ZvOqiR
1GjMctmGpSR/RtVsobKhOeIMYsRzQWEkVkoY6QhGhFPD1wSzX8ZoJFbeOliVXFKQ8zVCN8Ee
wR6vhXb/aPak0tD0SFIg7OZZD+VM8G+7PBFco/m1//Z2D1rV28vH+/5ZOJXTZNZxMBfeHXTa
1v8YjYhTO/Do54pERvUyaF+Cu/tMQv+AI50+b0GITu7iL6NjJMfa7JWWhg4xCVYi8p5/S9mb
J6hvsyzG6xO6eUGbVfd4wrA+30k+P1Bq5MP+x7PycX34uXv4E1Rmw6COnh1w+jD7bt1fJsmv
gP+i7OEKKg+qW/XIO9erMfUuwypIovO2NAKaa1g7A7UJOEG1EiY2TXIM3FlhTkn+VhVYD+mz
BEQBTOvEri608wpICXmIl0MVWTVz5ZGTpHHuwebortMkqSkBFFUkXoRixrQYdMdsZmRoqJus
7GJq8NUSgtYEjIozgHB0blK48mbYJs26NQ6vcDK2fvapR80dRZgUmjG79QmLjEQWTYggqG6C
JjbXNyJmiRScHnDnU6OF1jkbitmwk5kr5IcsLIUt1cNKiYqMd75HwYHZW5mY0Ch24Xe4hYHX
mucxQZ1TGo5noWSESiXDGSxST+V2wJEskBNYot/eIZgNEP1ut5cGJ+qgZIosZrrqCJLgfCp8
F1SSz/iAbJaw/IXv6hKkXf+Xs/Cr3RF9f2JtSeGqmGxQNkGqLUh6ror5k4Im2cTQssrInBuQ
PSTPIK1AlAtX2UkyeJSxIwyzPxclf7rFBEi1QgArWTRLkxj6kgYVpvZYklTCWqgfqCkFMdLO
+/A7AhUSwJyXQkmIooy1RssQmhe5Jsco6aWJ7VFlUaQmqood6s6IRWP6OUYcCjQ+88V6kap5
Y8Vds+oWaTEzfwmbOE/NN/9+QTQFaMUGh0nv2iZgJaJTMhzYrMasTFKepztKMpVmuvtdJBFm
eoGDkyeBqBfWONG9eRSXBX/2AC5ojFyJ7laGmlbMvgYLcaAaPKN551kYFeuINS//tQBA0Ne3
/fP7nyqeyNPu8MN9j6LjW+WK5BPZgUOMNy+Ktyo5VZsWixQO3bS/Tb7wUlyvk7j5Mu0HXmWA
dkuYsuV0mweYs8m3nAy8jpvMJJ9sVsAR1sZVBXTy2513hHpFbf9r9/l9/9RJQAcifVDwN3c8
45zunrM1qtVoJzlM/7yCRpAh3JfR6Zh1Eye7xPSv2GT5oqACDYEKBiphIJaAxlwbSQ4LkS9v
NTK1srhEm5UsaELGlmwMNa8t8vTWLgMYUhi383WuPgjSBIOr8Vsz1b+yIC5scAVWwE0crCgl
SGiHttAi6L8dcpog0kn3D3r5R7tvHz9+4KNR8nx4f/vAmJdm5rBgkZA5UyXl32GWxnbja+Jb
N/j/Ix/S2wPRZWjif6QcfGKTJjKgMwomYrWIjOMTf0sWdLPafKcnANrfyoFBFHqGmRBFgzxC
d0l1DBhNeBabnULepPDiXP6r2THHEI3D4tQdOGySowp1L4l9uYytIWuJtw0GQjdvtlRxiKeD
SJLe8dvixohbQTBY2nWRW9a5JgbmtTMVl73GTOK7uJId0IZGorn4ERI4QGAHyzyj2/tpIK0b
WmjdkIP4k8K2tHf8P8HR2I6OwVap2eenp6ceSlsFsdD9g/H8WF97crTZbetQfLTvOk3P2Ota
WfkNjBY4ctQh4zxSDPpIjRvZF61bkZQYil6+pQMyJEltFeDecS8ZFBZtA9WioTUDo9gGUdQJ
8/Z7+bDKrb4uVawY9UqCRCfFy+vh0wkGCv94Vdxzef/8g5/6AQaTATZeGGKiAUY3ojW7PVFI
FBSKdfOln2l8bl+XfV4WdrQU88ZFDo4YRdFgQpuME1IdkiuGl7hr5SmfHaysXaJ7bRPU0pXC
zTWcc3DaRdzZhHiZKprHEDs+osraB46pxw88mzgnsladVyQmbHejx2H6/m8wexCqsRclTs8q
jkvrgkfdzeA76MCD//vwun/Gt1Ho2NPH++6vHfxj9/7w+++//w8Lyoj+DFT2ggRSlYHYFBWL
Te+3IOnvWAJ2xuYjqGCtm3jLb3W6JQ3tx89suIf85kZhgNcVN2SA4/D76qaWbW8VmtpoKSYI
A4neLatDeAtTegg0JvZ9jSNJ98edeC81jJoEe6ZZV7GlAQ/95bc7Wj34f8yyob1ol52+vSQK
wqC06xzfUWCVqpsVb8dX6jTiKnN/yMCfTVzNijo2WdWfSjR4vH+/P0GZ4AEvG40EkDRoSe0s
n7ID2uedHLhFIZUpG0jKsm8YHqh5GwUN6sMUg9bxuDG4gqfxdq1hBaOXN0mQ1s6mrMK1JL8Y
E88jA4VrSnFJCFlTAAr+tTBbSIJeaJSQR6yC1oK3+PhacFAcAk8aPbLHAlivUgQqRwUw6JQj
FUhweAtitA/v3fLwtimkHZhTTF9ofGWtwl5xOY5dgNy8lGm0sjm3fNtUAQRsM/LshcHFq2GL
BH0ocDcRJWlJhvUm1ogxeG3XOVVwaLJDuhywMzRSTlCiN+7F4a8Gx7G+SVDBs/vm0OvrFA8h
OwK03udwDjyu8STS30huac58MO8rYTKOaP/2hPTfw8mEjhdmDl0S/twyB0vG6hpkjPkxEnVk
HyFY3qRBc4ygWy7dkhDD9KoFUedBWS8LU+kyUVqbhgkWjX9mwLUx2J4aDG3byY9vggd5jmG+
MfMnfRB7Qt5ocljJEqGuNEWpYSO4gq6ghFmsFis3aC7nDkxPsA2XSzi+BfXqNS7k6tu8WToF
YWgmHfvb3qLdJlNOrBaO9vTwlCXuVoZ+sgsOUmwd+QoZ26FbK00ATL308nRWByfloxbHGZxo
1TXMDDoPmkIFGwtkARaWz9qA5obYfND8wm6A8fm47xcB+Njy9zKOVDeSHqS61edhnBW2k0i8
Len6VUufVnGjkDIPUFTLG9gFoJPS3B+pBrPtOm2vyqzGS+oEb1VspPo1d4djM8c8ALi5sgif
NI1wMcr0HreeFHrl8FOUNWgIYV3M02BRu/y9XuKKyqOgAt6QFHz2iJlaPrzTFYHNS7R1Vrau
/4TGgqQ5BynzBh1ePSx3iTcrs7r26dtq23N1yegsvyNvdod3FI1Riwsx5fj9D5afgEJGGBdv
FEOCOukJAzZEmRAappDxtluu1rZRWBILPHqAFlnxFpvSNmj3ef6MMCd+56eXyo0bXEMiuRF0
wPTa91911HAYFBu9W3m4TpgYEgagh8SC0RhoULNWUcOCQystHJlJjYvQhGdJjlfdhlZFCKSV
p0ZtYR6+QTqttPpDGpVzW1XN8D3xiMhN735FWmC8TS+V8Tjpawmc5XiUm8xXP2xxfY/3fhlv
cYNZVxndE5LyS6mtTwBZh6UZNQvhsHerppDi2hC6N/bgwP6ZyywKwLCwUjnUpLo4XttxpTh2
S0zd1xL0gJ+j67zZrwpNARp8KbHHyDARIFASBRbEfaBTy3El3wPqbsrhHgi7ydStgtkYMvwK
C2H8QQzyFUUWPEt8UoN9a+xQYJvYjKNWNFTEPKky4LX22Lje3QriYWyDJkbmRP9Ew6x3vPsv
aWpLWlHjRIKKs3TJ78r2Z1MMIs5CkLwlMVh/i7cvifuIAV/6TpY4s59gjx4kjh+TaTZFtypZ
UtcUeqcI11knff4fJKGYtFLmAQA=

--X1bOJ3K7DJ5YkBrT--
