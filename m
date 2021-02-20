Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D93F3203BF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 06:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbhBTFLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 00:11:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:48686 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229632AbhBTFLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 00:11:23 -0500
IronPort-SDR: /bCH4DuZKX56ok3bngffGktx3QlHoMM29r7hRI6pzZuvY5C5KVtJ3iKPNYNIh+oV+vKXaPZvtw
 pLdr2RQ3F43g==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="183258366"
X-IronPort-AV: E=Sophos;i="5.81,192,1610438400"; 
   d="gz'50?scan'50,208,50";a="183258366"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 21:10:38 -0800
IronPort-SDR: LrvXswiTYeqsaphV1P+4Q6BogrpJdFE01NMYQVPYVngWVB/z+DDkorWOW2IKyv+/NCnao7B643
 w8a/RQ3OdnnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,192,1610438400"; 
   d="gz'50?scan'50,208,50";a="440551003"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2021 21:10:36 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lDKXL-000ArO-HF; Sat, 20 Feb 2021 05:10:35 +0000
Date:   Sat, 20 Feb 2021 13:09:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russell King <rmk+kernel@armlinux.org.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: arch/arm/kernel/sys_oabi-compat.c:257:6: error: implicit declaration
 of function 'ep_op_has_event'
Message-ID: <202102201334.qjQXHqOY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Russell,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f40ddce88593482919761f74910f42f4b84c004b
commit: c281634c865202e2776b0250678ff93c771947ff ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()
date:   10 months ago
config: arm-randconfig-r024-20210220 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c281634c865202e2776b0250678ff93c771947ff
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c281634c865202e2776b0250678ff93c771947ff
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm/kernel/sys_oabi-compat.c:142:17: warning: no previous prototype for 'sys_oabi_stat64' [-Wmissing-prototypes]
     142 | asmlinkage long sys_oabi_stat64(const char __user * filename,
         |                 ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:152:17: warning: no previous prototype for 'sys_oabi_lstat64' [-Wmissing-prototypes]
     152 | asmlinkage long sys_oabi_lstat64(const char __user * filename,
         |                 ^~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:162:17: warning: no previous prototype for 'sys_oabi_fstat64' [-Wmissing-prototypes]
     162 | asmlinkage long sys_oabi_fstat64(unsigned long fd,
         |                 ^~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:172:17: warning: no previous prototype for 'sys_oabi_fstatat64' [-Wmissing-prototypes]
     172 | asmlinkage long sys_oabi_fstatat64(int dfd,
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:229:17: warning: no previous prototype for 'sys_oabi_fcntl64' [-Wmissing-prototypes]
     229 | asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
         |                 ^~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:251:17: warning: no previous prototype for 'sys_oabi_epoll_ctl' [-Wmissing-prototypes]
     251 | asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
         |                 ^~~~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_ctl':
>> arch/arm/kernel/sys_oabi-compat.c:257:6: error: implicit declaration of function 'ep_op_has_event' [-Werror=implicit-function-declaration]
     257 |  if (ep_op_has_event(op) &&
         |      ^~~~~~~~~~~~~~~
>> arch/arm/kernel/sys_oabi-compat.c:264:9: error: implicit declaration of function 'do_epoll_ctl'; did you mean 'sys_epoll_ctl'? [-Werror=implicit-function-declaration]
     264 |  return do_epoll_ctl(epfd, op, fd, &kernel, false);
         |         ^~~~~~~~~~~~
         |         sys_epoll_ctl
   arch/arm/kernel/sys_oabi-compat.c: At top level:
   arch/arm/kernel/sys_oabi-compat.c:267:17: warning: no previous prototype for 'sys_oabi_epoll_wait' [-Wmissing-prototypes]
     267 | asmlinkage long sys_oabi_epoll_wait(int epfd,
         |                 ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:309:17: warning: no previous prototype for 'sys_oabi_semtimedop' [-Wmissing-prototypes]
     309 | asmlinkage long sys_oabi_semtimedop(int semid,
         |                 ^~~~~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:352:17: warning: no previous prototype for 'sys_oabi_semop' [-Wmissing-prototypes]
     352 | asmlinkage long sys_oabi_semop(int semid, struct oabi_sembuf __user *tsops,
         |                 ^~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:358:16: warning: no previous prototype for 'sys_oabi_ipc' [-Wmissing-prototypes]
     358 | asmlinkage int sys_oabi_ipc(uint call, int first, int second, int third,
         |                ^~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:376:17: warning: no previous prototype for 'sys_oabi_bind' [-Wmissing-prototypes]
     376 | asmlinkage long sys_oabi_bind(int fd, struct sockaddr __user *addr, int addrlen)
         |                 ^~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:386:17: warning: no previous prototype for 'sys_oabi_connect' [-Wmissing-prototypes]
     386 | asmlinkage long sys_oabi_connect(int fd, struct sockaddr __user *addr, int addrlen)
         |                 ^~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:396:17: warning: no previous prototype for 'sys_oabi_sendto' [-Wmissing-prototypes]
     396 | asmlinkage long sys_oabi_sendto(int fd, void __user *buff,
         |                 ^~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:409:17: warning: no previous prototype for 'sys_oabi_sendmsg' [-Wmissing-prototypes]
     409 | asmlinkage long sys_oabi_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags)
         |                 ^~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_oabi-compat.c:435:17: warning: no previous prototype for 'sys_oabi_socketcall' [-Wmissing-prototypes]
     435 | asmlinkage long sys_oabi_socketcall(int call, unsigned long __user *args)
         |                 ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ep_op_has_event +257 arch/arm/kernel/sys_oabi-compat.c

   228	
 > 229	asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
   230					 unsigned long arg)
   231	{
   232		switch (cmd) {
   233		case F_OFD_GETLK:
   234		case F_OFD_SETLK:
   235		case F_OFD_SETLKW:
   236		case F_GETLK64:
   237		case F_SETLK64:
   238		case F_SETLKW64:
   239			return do_locks(fd, cmd, arg);
   240	
   241		default:
   242			return sys_fcntl64(fd, cmd, arg);
   243		}
   244	}
   245	
   246	struct oabi_epoll_event {
   247		__u32 events;
   248		__u64 data;
   249	} __attribute__ ((packed,aligned(4)));
   250	
 > 251	asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
   252					   struct oabi_epoll_event __user *event)
   253	{
   254		struct oabi_epoll_event user;
   255		struct epoll_event kernel;
   256	
 > 257		if (ep_op_has_event(op) &&
   258		    copy_from_user(&user, event, sizeof(user)))
   259			return -EFAULT;
   260	
   261		kernel.events = user.events;
   262		kernel.data   = user.data;
   263	
 > 264		return do_epoll_ctl(epfd, op, fd, &kernel, false);
   265	}
   266	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ObKj8F7xiP0DCIQQXnuHAQA=

--WIyZ46R2i8wDzkSu--
