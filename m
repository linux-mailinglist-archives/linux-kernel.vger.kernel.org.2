Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B962E30D33B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 06:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbhBCFzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 00:55:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:31928 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhBCFzl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 00:55:41 -0500
IronPort-SDR: NkHwW4wzJLDeynEoO9GKiYL7aBdIxWr/5ptl8Ty24VuAXs+IfTtB7NvLhyDfz6ryXbtMekzGJV
 LuH1f3axL0xA==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="177482118"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="gz'50?scan'50,208,50";a="177482118"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 21:54:55 -0800
IronPort-SDR: +Ebd0nkUFDuNFYqQz+Fn3nfse3OQ2YqqDoO+ZSdo6AMW0FXaSer6RT0JxwSkZM9hiRzD7O1sld
 kKLtf0ZhJd1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="gz'50?scan'50,208,50";a="413539878"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Feb 2021 21:54:52 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7B7r-00003W-C2; Wed, 03 Feb 2021 05:54:51 +0000
Date:   Wed, 3 Feb 2021 13:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: arch/sh/kernel/cpu/sh3/clock-sh7710.c:26:31: sparse: sparse:
 incorrect type in argument 1 (different base types)
Message-ID: <202102031351.ONA8bYs8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luc,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3aaf0a27ffc29b19a62314edd684b9bc6346f9a8
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   5 months ago
config: sh-randconfig-s031-20210203 (attached as .config)
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
   fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:47:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:47:21: sparse:     got int [noderef] __user *
>> fs/ext2/ioctl.c:47:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:47:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:47:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:92:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:92:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:92:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:92:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:92:21: sparse:     got int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ext2/ioctl.c:123:21: sparse:     expected int const *__gu_addr
   fs/ext2/ioctl.c:123:21: sparse:     got int [noderef] __user *
   fs/ext2/ioctl.c:123:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/ext2/ioctl.c:123:21: sparse:     expected void const volatile [noderef] __user *ptr
   fs/ext2/ioctl.c:123:21: sparse:     got int const *__gu_addr
--
   fs/f2fs/file.c:48:54: sparse: sparse: cast from restricted vm_fault_t
   fs/f2fs/file.c:1975:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/f2fs/file.c:1975:13: sparse:     expected int const *__gu_addr
   fs/f2fs/file.c:1975:13: sparse:     got int [noderef] __user *
>> fs/f2fs/file.c:1975:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   fs/f2fs/file.c:1975:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:1975:13: sparse:     got int const *__gu_addr
   fs/f2fs/file.c:2229:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2229:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:2229:13: sparse:     got unsigned int [noderef] [usertype] __user *
>> fs/f2fs/file.c:2229:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:2229:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2229:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:2466:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:2466:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:2466:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:2466:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:2466:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:2466:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:3226:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   fs/f2fs/file.c:3226:13: sparse:     expected unsigned int const *__gu_addr
   fs/f2fs/file.c:3226:13: sparse:     got unsigned int [noderef] [usertype] __user *
   fs/f2fs/file.c:3226:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned int const *__gu_addr @@
   fs/f2fs/file.c:3226:13: sparse:     expected void const volatile [noderef] __user *ptr
   fs/f2fs/file.c:3226:13: sparse:     got unsigned int const *__gu_addr
   fs/f2fs/file.c:3379:36: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3379:36: sparse:     expected unsigned short const [usertype] *pwcs
   fs/f2fs/file.c:3379:36: sparse:     got restricted __le16 *
   fs/f2fs/file.c:3415:28: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] *pwcs @@     got restricted __le16 * @@
   fs/f2fs/file.c:3415:28: sparse:     expected unsigned short [usertype] *pwcs
   fs/f2fs/file.c:3415:28: sparse:     got restricted __le16 *
--
   security/tomoyo/common.c:915:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:915:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:915:9: sparse:    struct list_head *
   security/tomoyo/common.c:915:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:915:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:915:9: sparse:    struct list_head *
   security/tomoyo/common.c:1600:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1600:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1600:9: sparse:    struct list_head *
   security/tomoyo/common.c:1600:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1600:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1600:9: sparse:    struct list_head *
   security/tomoyo/common.c:1622:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1622:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1622:9: sparse:    struct list_head *
   security/tomoyo/common.c:1622:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1622:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1622:9: sparse:    struct list_head *
   security/tomoyo/common.c:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1803:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1803:9: sparse:    struct list_head *
   security/tomoyo/common.c:1807:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1807:17: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1807:17: sparse:    struct list_head *
   security/tomoyo/common.c:1807:17: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1807:17: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1807:17: sparse:    struct list_head *
   security/tomoyo/common.c:1803:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1803:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1803:9: sparse:    struct list_head *
   security/tomoyo/common.c:1862:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1862:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1862:9: sparse:    struct list_head *
   security/tomoyo/common.c:1862:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   security/tomoyo/common.c:1862:9: sparse:    struct list_head [noderef] __rcu *
   security/tomoyo/common.c:1862:9: sparse:    struct list_head *
   security/tomoyo/common.c:2687:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   security/tomoyo/common.c:2687:21: sparse:     expected char const *__gu_addr
   security/tomoyo/common.c:2687:21: sparse:     got char const [noderef] __user *buffer
>> security/tomoyo/common.c:2687:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   security/tomoyo/common.c:2687:21: sparse:     expected void const volatile [noderef] __user *ptr
   security/tomoyo/common.c:2687:21: sparse:     got char const *__gu_addr
   security/tomoyo/common.c:948:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:948:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:949:26: sparse: sparse: dereference of noderef expression
   security/tomoyo/common.c:949:26: sparse: sparse: dereference of noderef expression
--
   block/bsg.c:336:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *uarg @@
   block/bsg.c:336:13: sparse:     expected int const *__gu_addr
   block/bsg.c:336:13: sparse:     got int [noderef] __user *uarg
>> block/bsg.c:336:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   block/bsg.c:336:13: sparse:     expected void const volatile [noderef] __user *ptr
   block/bsg.c:336:13: sparse:     got int const *__gu_addr
--
   drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:415:21: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:415:21: sparse:     got int [noderef] __user *
>> drivers/scsi/sg.c:415:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:415:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:415:21: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:419:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:419:32: sparse:     got int [noderef] __user *
   drivers/scsi/sg.c:419:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:419:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:419:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] __user * @@
   drivers/scsi/sg.c:425:32: sparse:     expected signed int const *__gu_addr
   drivers/scsi/sg.c:425:32: sparse:     got signed int [noderef] __user *
>> drivers/scsi/sg.c:425:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got signed int const *__gu_addr @@
   drivers/scsi/sg.c:425:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:425:32: sparse:     got signed int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/scsi/sg.c:431:32: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:431:32: sparse:     got int [noderef] __user *
   drivers/scsi/sg.c:431:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:431:32: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:431:32: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *[assigned] buf @@
   drivers/scsi/sg.c:638:13: sparse:     expected char const *__gu_addr
   drivers/scsi/sg.c:638:13: sparse:     got char const [noderef] __user *[assigned] buf
>> drivers/scsi/sg.c:638:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/scsi/sg.c:638:13: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:638:13: sparse:     got char const *__gu_addr
   drivers/scsi/sg.c:955:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:955:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:955:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:955:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:955:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:955:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:998:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:998:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:998:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:998:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:998:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:998:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1026:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1026:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1026:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1026:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1026:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1026:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1051:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1051:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1051:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1051:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1051:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1051:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1059:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1059:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1059:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1059:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1059:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1059:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1067:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1067:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1067:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1067:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1067:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1067:26: sparse:     got int const *__gu_addr
   drivers/scsi/sg.c:1111:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *ip @@
   drivers/scsi/sg.c:1111:26: sparse:     expected int const *__gu_addr
   drivers/scsi/sg.c:1111:26: sparse:     got int [noderef] __user *ip
   drivers/scsi/sg.c:1111:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   drivers/scsi/sg.c:1111:26: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/scsi/sg.c:1111:26: sparse:     got int const *__gu_addr
--
   drivers/tty/sysrq.c:1110:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buf @@
   drivers/tty/sysrq.c:1110:21: sparse:     expected char const *__gu_addr
   drivers/tty/sysrq.c:1110:21: sparse:     got char const [noderef] __user *buf
>> drivers/tty/sysrq.c:1110:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/tty/sysrq.c:1110:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/sysrq.c:1110:21: sparse:     got char const *__gu_addr
   drivers/tty/sysrq.c:148:13: sparse: sparse: context imbalance in 'sysrq_handle_crash' - unexpected unlock
--
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:1004:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1004:21: sparse:     got unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got unsigned short const *__gu_addr @@
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/tty/vt/vt_ioctl.c:1005:21: sparse:     got unsigned short const *__gu_addr
--
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/netrom/af_netrom.c:359:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/netrom/af_netrom.c:359:13: sparse:     got int const *__gu_addr
--
   net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/xdp/xsk.c:835:13: sparse:     expected int const *__gu_addr
   net/xdp/xsk.c:835:13: sparse:     got int [noderef] __user *optlen
>> net/xdp/xsk.c:835:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got int const *__gu_addr @@
   net/xdp/xsk.c:835:13: sparse:     expected void const volatile [noderef] __user *ptr
   net/xdp/xsk.c:835:13: sparse:     got int const *__gu_addr
--
   drivers/usb/gadget/function/rndis.c:1126:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char const [noderef] __user *buffer @@
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     expected char const *__gu_addr
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     got char const [noderef] __user *buffer
>> drivers/usb/gadget/function/rndis.c:1126:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user *ptr @@     got char const *__gu_addr @@
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     expected void const volatile [noderef] __user *ptr
   drivers/usb/gadget/function/rndis.c:1126:21: sparse:     got char const *__gu_addr

vim +26 arch/sh/kernel/cpu/sh3/clock-sh7710.c

36ddf31b689a8c arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  23  
36ddf31b689a8c arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  24  static void master_clk_init(struct clk *clk)
36ddf31b689a8c arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  25  {
9d56dd3b083a3b arch/sh/kernel/cpu/sh3/clock-sh7710.c Paul Mundt 2010-01-26 @26  	clk->rate *= md_table[__raw_readw(FRQCR) & 0x0007];
36ddf31b689a8c arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  27  }
36ddf31b689a8c arch/sh/kernel/cpu/sh3/clock-sh7300.c Paul Mundt 2006-01-16  28  

:::::: The code at line 26 was first introduced by commit
:::::: 9d56dd3b083a3bec56e9da35ce07baca81030b03 sh: Mass ctrl_in/outX to __raw_read/writeX conversion.

:::::: TO: Paul Mundt <lethal@linux-sh.org>
:::::: CC: Paul Mundt <lethal@linux-sh.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--nFreZHaLTZJo0R7j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
da5zQexeZ5iGOnzXHWseJQH/D1TJ+X1eVQEA

--nFreZHaLTZJo0R7j--
