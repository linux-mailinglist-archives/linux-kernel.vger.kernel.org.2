Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0331331E958
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 12:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhBRLxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 06:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbhBRKRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 05:17:46 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998FAC061794
        for <linux-kernel@vger.kernel.org>; Thu, 18 Feb 2021 02:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r9lhhtFyqzbCfI1h8TWv2gufIMGyVSgM/vnX6hzXoEw=; b=mVIVpT3MEZBt6canxO245gxqq
        45s0d9BJd4k1kV4qsOXKibuHlV0H5uN9L+SbibHc1PtsbntmUuiezNM5AEm3lLBXKTadIKPfK816P
        847XNjNeC6ikuOZuho0wdR4lfr/c7+3xPE8G0J10IVO3Q6D81wx36L+POTNGc/hcwPSF4/vL6dwN0
        bLmYoeCshllhHhLV8H3bIVvhsOzEPIcC6fPXAmLGiaLB4yGYbcpmVrfFe+nxsnKd4xhPBbY6JIydh
        OWNHq0ca+fdzO72JOyNcNmPTUkg+t4/uUUZ+QOb3x3JsUxtJ5sZuK+5v9UeOgX6HZLkN+4ZL25oDA
        QvJMzHA3Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44980)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1lCgMe-0003MK-77; Thu, 18 Feb 2021 10:16:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1lCgMa-0006L3-Ap; Thu, 18 Feb 2021 10:16:48 +0000
Date:   Thu, 18 Feb 2021 10:16:48 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: arch/arm/kernel/sys_oabi-compat.c:257:6: error: implicit
 declaration of function 'ep_op_has_event'
Message-ID: <20210218101647.GH1463@shell.armlinux.org.uk>
References: <202102181333.BEPRdHZT-lkp@intel.com>
 <8f742b7a-2d8e-8956-ac89-ca8f32e3359f@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f742b7a-2d8e-8956-ac89-ca8f32e3359f@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:56:08PM -0800, Randy Dunlap wrote:
> On 2/17/21 9:26 PM, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   f40ddce88593482919761f74910f42f4b84c004b
> > commit: c281634c865202e2776b0250678ff93c771947ff ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()
> > date:   10 months ago
> > config: arm-randconfig-m031-20210218 (attached as .config)
> > compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c281634c865202e2776b0250678ff93c771947ff
> >         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> >         git fetch --no-tags linus master
> >         git checkout c281634c865202e2776b0250678ff93c771947ff
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    arch/arm/kernel/sys_oabi-compat.c:142:17: warning: no previous prototype for 'sys_oabi_stat64' [-Wmissing-prototypes]
> >      142 | asmlinkage long sys_oabi_stat64(const char __user * filename,
> >          |                 ^~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:152:17: warning: no previous prototype for 'sys_oabi_lstat64' [-Wmissing-prototypes]
> >      152 | asmlinkage long sys_oabi_lstat64(const char __user * filename,
> >          |                 ^~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:162:17: warning: no previous prototype for 'sys_oabi_fstat64' [-Wmissing-prototypes]
> >      162 | asmlinkage long sys_oabi_fstat64(unsigned long fd,
> >          |                 ^~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:172:17: warning: no previous prototype for 'sys_oabi_fstatat64' [-Wmissing-prototypes]
> >      172 | asmlinkage long sys_oabi_fstatat64(int dfd,
> >          |                 ^~~~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:229:17: warning: no previous prototype for 'sys_oabi_fcntl64' [-Wmissing-prototypes]
> >      229 | asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
> >          |                 ^~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:251:17: warning: no previous prototype for 'sys_oabi_epoll_ctl' [-Wmissing-prototypes]
> >      251 | asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
> >          |                 ^~~~~~~~~~~~~~~~~~
> >    In file included from include/linux/kernel.h:11,
> >                     from include/linux/list.h:9,
> >                     from include/linux/wait.h:7,
> >                     from include/linux/wait_bit.h:8,
> >                     from include/linux/fs.h:6,
> >                     from include/uapi/linux/aio_abi.h:31,
> >                     from include/linux/syscalls.h:74,
> >                     from arch/arm/kernel/sys_oabi-compat.c:73:
> >    arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_ctl':
> >>> arch/arm/kernel/sys_oabi-compat.c:257:6: error: implicit declaration of function 'ep_op_has_event' [-Werror=implicit-function-declaration]
> >      257 |  if (ep_op_has_event(op) &&
> >          |      ^~~~~~~~~~~~~~~
> >    include/linux/compiler.h:58:52: note: in definition of macro '__trace_if_var'
> >       58 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
> >          |                                                    ^~~~
> >    arch/arm/kernel/sys_oabi-compat.c:257:2: note: in expansion of macro 'if'
> >      257 |  if (ep_op_has_event(op) &&
> >          |  ^~
> >>> arch/arm/kernel/sys_oabi-compat.c:264:9: error: implicit declaration of function 'do_epoll_ctl'; did you mean 'sys_epoll_ctl'? [-Werror=implicit-function-declaration]
> >      264 |  return do_epoll_ctl(epfd, op, fd, &kernel, false);
> >          |         ^~~~~~~~~~~~
> >          |         sys_epoll_ctl
> >    arch/arm/kernel/sys_oabi-compat.c: At top level:
> >    arch/arm/kernel/sys_oabi-compat.c:267:17: warning: no previous prototype for 'sys_oabi_epoll_wait' [-Wmissing-prototypes]
> >      267 | asmlinkage long sys_oabi_epoll_wait(int epfd,
> >          |                 ^~~~~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:309:17: warning: no previous prototype for 'sys_oabi_semtimedop' [-Wmissing-prototypes]
> >      309 | asmlinkage long sys_oabi_semtimedop(int semid,
> >          |                 ^~~~~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:352:17: warning: no previous prototype for 'sys_oabi_semop' [-Wmissing-prototypes]
> >      352 | asmlinkage long sys_oabi_semop(int semid, struct oabi_sembuf __user *tsops,
> >          |                 ^~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:358:16: warning: no previous prototype for 'sys_oabi_ipc' [-Wmissing-prototypes]
> >      358 | asmlinkage int sys_oabi_ipc(uint call, int first, int second, int third,
> >          |                ^~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:376:17: warning: no previous prototype for 'sys_oabi_bind' [-Wmissing-prototypes]
> >      376 | asmlinkage long sys_oabi_bind(int fd, struct sockaddr __user *addr, int addrlen)
> >          |                 ^~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:386:17: warning: no previous prototype for 'sys_oabi_connect' [-Wmissing-prototypes]
> >      386 | asmlinkage long sys_oabi_connect(int fd, struct sockaddr __user *addr, int addrlen)
> >          |                 ^~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:396:17: warning: no previous prototype for 'sys_oabi_sendto' [-Wmissing-prototypes]
> >      396 | asmlinkage long sys_oabi_sendto(int fd, void __user *buff,
> >          |                 ^~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:409:17: warning: no previous prototype for 'sys_oabi_sendmsg' [-Wmissing-prototypes]
> >      409 | asmlinkage long sys_oabi_sendmsg(int fd, struct user_msghdr __user *msg, unsigned flags)
> >          |                 ^~~~~~~~~~~~~~~~
> >    arch/arm/kernel/sys_oabi-compat.c:435:17: warning: no previous prototype for 'sys_oabi_socketcall' [-Wmissing-prototypes]
> >      435 | asmlinkage long sys_oabi_socketcall(int call, unsigned long __user *args)
> >          |                 ^~~~~~~~~~~~~~~~~~~
> >    cc1: some warnings being treated as errors
> > 
> > 
> > vim +/ep_op_has_event +257 arch/arm/kernel/sys_oabi-compat.c
> > 
> >   > 73	#include <linux/syscalls.h>
> >     74	#include <linux/errno.h>
> >     75	#include <linux/fs.h>
> >     76	#include <linux/cred.h>
> >     77	#include <linux/fcntl.h>
> >     78	#include <linux/eventpoll.h>
> >     79	#include <linux/sem.h>
> >     80	#include <linux/socket.h>
> >     81	#include <linux/net.h>
> >     82	#include <linux/ipc.h>
> >     83	#include <linux/uaccess.h>
> >     84	#include <linux/slab.h>
> >     85	
> >     86	struct oldabi_stat64 {
> >     87		unsigned long long st_dev;
> >     88		unsigned int	__pad1;
> >     89		unsigned long	__st_ino;
> >     90		unsigned int	st_mode;
> >     91		unsigned int	st_nlink;
> >     92	
> >     93		unsigned long	st_uid;
> >     94		unsigned long	st_gid;
> >     95	
> >     96		unsigned long long st_rdev;
> >     97		unsigned int	__pad2;
> >     98	
> >     99		long long	st_size;
> >    100		unsigned long	st_blksize;
> >    101		unsigned long long st_blocks;
> >    102	
> >    103		unsigned long	st_atime;
> >    104		unsigned long	st_atime_nsec;
> >    105	
> >    106		unsigned long	st_mtime;
> >    107		unsigned long	st_mtime_nsec;
> >    108	
> >    109		unsigned long	st_ctime;
> >    110		unsigned long	st_ctime_nsec;
> >    111	
> >    112		unsigned long long st_ino;
> >    113	} __attribute__ ((packed,aligned(4)));
> >    114	
> >    115	static long cp_oldabi_stat64(struct kstat *stat,
> >    116				     struct oldabi_stat64 __user *statbuf)
> >    117	{
> >    118		struct oldabi_stat64 tmp;
> >    119	
> >    120		tmp.st_dev = huge_encode_dev(stat->dev);
> >    121		tmp.__pad1 = 0;
> >    122		tmp.__st_ino = stat->ino;
> >    123		tmp.st_mode = stat->mode;
> >    124		tmp.st_nlink = stat->nlink;
> >    125		tmp.st_uid = from_kuid_munged(current_user_ns(), stat->uid);
> >    126		tmp.st_gid = from_kgid_munged(current_user_ns(), stat->gid);
> >    127		tmp.st_rdev = huge_encode_dev(stat->rdev);
> >    128		tmp.st_size = stat->size;
> >    129		tmp.st_blocks = stat->blocks;
> >    130		tmp.__pad2 = 0;
> >    131		tmp.st_blksize = stat->blksize;
> >    132		tmp.st_atime = stat->atime.tv_sec;
> >    133		tmp.st_atime_nsec = stat->atime.tv_nsec;
> >    134		tmp.st_mtime = stat->mtime.tv_sec;
> >    135		tmp.st_mtime_nsec = stat->mtime.tv_nsec;
> >    136		tmp.st_ctime = stat->ctime.tv_sec;
> >    137		tmp.st_ctime_nsec = stat->ctime.tv_nsec;
> >    138		tmp.st_ino = stat->ino;
> >    139		return copy_to_user(statbuf,&tmp,sizeof(tmp)) ? -EFAULT : 0;
> >    140	}
> >    141	
> >    142	asmlinkage long sys_oabi_stat64(const char __user * filename,
> >    143					struct oldabi_stat64 __user * statbuf)
> >    144	{
> >    145		struct kstat stat;
> >    146		int error = vfs_stat(filename, &stat);
> >    147		if (!error)
> >    148			error = cp_oldabi_stat64(&stat, statbuf);
> >    149		return error;
> >    150	}
> >    151	
> >    152	asmlinkage long sys_oabi_lstat64(const char __user * filename,
> >    153					 struct oldabi_stat64 __user * statbuf)
> >    154	{
> >    155		struct kstat stat;
> >    156		int error = vfs_lstat(filename, &stat);
> >    157		if (!error)
> >    158			error = cp_oldabi_stat64(&stat, statbuf);
> >    159		return error;
> >    160	}
> >    161	
> >    162	asmlinkage long sys_oabi_fstat64(unsigned long fd,
> >    163					 struct oldabi_stat64 __user * statbuf)
> >    164	{
> >    165		struct kstat stat;
> >    166		int error = vfs_fstat(fd, &stat);
> >    167		if (!error)
> >    168			error = cp_oldabi_stat64(&stat, statbuf);
> >    169		return error;
> >    170	}
> >    171	
> >    172	asmlinkage long sys_oabi_fstatat64(int dfd,
> >    173					   const char __user *filename,
> >    174					   struct oldabi_stat64  __user *statbuf,
> >    175					   int flag)
> >    176	{
> >    177		struct kstat stat;
> >    178		int error;
> >    179	
> >    180		error = vfs_fstatat(dfd, filename, &stat, flag);
> >    181		if (error)
> >    182			return error;
> >    183		return cp_oldabi_stat64(&stat, statbuf);
> >    184	}
> >    185	
> >    186	struct oabi_flock64 {
> >    187		short	l_type;
> >    188		short	l_whence;
> >    189		loff_t	l_start;
> >    190		loff_t	l_len;
> >    191		pid_t	l_pid;
> >    192	} __attribute__ ((packed,aligned(4)));
> >    193	
> >    194	static long do_locks(unsigned int fd, unsigned int cmd,
> >    195					 unsigned long arg)
> >    196	{
> >    197		struct flock64 kernel;
> >    198		struct oabi_flock64 user;
> >    199		mm_segment_t fs;
> >    200		long ret;
> >    201	
> >    202		if (copy_from_user(&user, (struct oabi_flock64 __user *)arg,
> >    203				   sizeof(user)))
> >    204			return -EFAULT;
> >    205		kernel.l_type	= user.l_type;
> >    206		kernel.l_whence	= user.l_whence;
> >    207		kernel.l_start	= user.l_start;
> >    208		kernel.l_len	= user.l_len;
> >    209		kernel.l_pid	= user.l_pid;
> >    210	
> >    211		fs = get_fs();
> >    212		set_fs(KERNEL_DS);
> >    213		ret = sys_fcntl64(fd, cmd, (unsigned long)&kernel);
> >    214		set_fs(fs);
> >    215	
> >    216		if (!ret && (cmd == F_GETLK64 || cmd == F_OFD_GETLK)) {
> >    217			user.l_type	= kernel.l_type;
> >    218			user.l_whence	= kernel.l_whence;
> >    219			user.l_start	= kernel.l_start;
> >    220			user.l_len	= kernel.l_len;
> >    221			user.l_pid	= kernel.l_pid;
> >    222			if (copy_to_user((struct oabi_flock64 __user *)arg,
> >    223					 &user, sizeof(user)))
> >    224				ret = -EFAULT;
> >    225		}
> >    226		return ret;
> >    227	}
> >    228	
> >    229	asmlinkage long sys_oabi_fcntl64(unsigned int fd, unsigned int cmd,
> >    230					 unsigned long arg)
> >    231	{
> >    232		switch (cmd) {
> >    233		case F_OFD_GETLK:
> >    234		case F_OFD_SETLK:
> >    235		case F_OFD_SETLKW:
> >    236		case F_GETLK64:
> >    237		case F_SETLK64:
> >    238		case F_SETLKW64:
> >    239			return do_locks(fd, cmd, arg);
> >    240	
> >    241		default:
> >    242			return sys_fcntl64(fd, cmd, arg);
> >    243		}
> >    244	}
> >    245	
> >    246	struct oabi_epoll_event {
> >    247		__u32 events;
> >    248		__u64 data;
> >    249	} __attribute__ ((packed,aligned(4)));
> >    250	
> >    251	asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
> >    252					   struct oabi_epoll_event __user *event)
> >    253	{
> >    254		struct oabi_epoll_event user;
> >    255		struct epoll_event kernel;
> >    256	
> >  > 257		if (ep_op_has_event(op) &&
> >    258		    copy_from_user(&user, event, sizeof(user)))
> >    259			return -EFAULT;
> >    260	
> >    261		kernel.events = user.events;
> >    262		kernel.data   = user.data;
> >    263	
> >  > 264		return do_epoll_ctl(epfd, op, fd, &kernel, false);
> >    265	}
> >    266	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> I sent a patch for this on 2021-JAN-14.
> 
> Russell?

I probably forgot about it as it was only emailed on the mailing list,
and as it wasn't in my patch system.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
