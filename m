Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA33D4EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jul 2021 19:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhGYQVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jul 2021 12:21:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:24749 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230449AbhGYQVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jul 2021 12:21:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10056"; a="212158905"
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="gz'50?scan'50,208,50";a="212158905"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2021 10:01:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,266,1620716400"; 
   d="gz'50?scan'50,208,50";a="633827754"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 25 Jul 2021 10:01:45 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m7hVZ-0004i4-2c; Sun, 25 Jul 2021 17:01:45 +0000
Date:   Mon, 26 Jul 2021 01:01:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202107260112.CVFlmIJ6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Stephen,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d8079fac168168b25677dc16c00ffaf9fb7df723
commit: 2f2b4fd674cadd8c6b40eb629e140a14db4068fd MIPS: Disable Loongson MMI instructions for kernel build
date:   1 year, 10 months ago
config: mips-randconfig-s031-20210724 (attached as .config)
compiler: mips64-linux-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f2b4fd674cadd8c6b40eb629e140a14db4068fd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 2f2b4fd674cadd8c6b40eb629e140a14db4068fd
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *timing_base @@     got void [noderef] <asn:2> * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse:     expected void *timing_base
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:458:39: sparse:     got void [noderef] <asn:2> *
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:470:41: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:473:39: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:519:53: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void *timing_base @@     got void [noderef] <asn:2> * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse:     expected void *timing_base
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:945:39: sparse:     got void [noderef] <asn:2> *
>> drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:958:33: sparse:     got void *
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse:     expected void volatile [noderef] <asn:2> *mem
   drivers/gpu/drm/exynos/exynos_drm_fimd.c:960:33: sparse:     got void *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/tty/tty_ioctl.c:385:53: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct ktermios [noderef] <asn:1> *k @@     got struct ktermios * @@
   drivers/tty/tty_ioctl.c:385:53: sparse:     expected struct ktermios [noderef] <asn:1> *k
   drivers/tty/tty_ioctl.c:385:53: sparse:     got struct ktermios *
   drivers/tty/tty_ioctl.c:386:50: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct termios2 *u @@     got struct termios2 [noderef] <asn:1> * @@
   drivers/tty/tty_ioctl.c:386:50: sparse:     expected struct termios2 *u
   drivers/tty/tty_ioctl.c:386:50: sparse:     got struct termios2 [noderef] <asn:1> *
   drivers/tty/tty_ioctl.c: note: in included file (through include/uapi/linux/termios.h):
   arch/mips/include/asm/termios.h:84:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got struct ktermios [noderef] <asn:1> *k @@
   arch/mips/include/asm/termios.h:84:31: sparse:     expected void *to
   arch/mips/include/asm/termios.h:84:31: sparse:     got struct ktermios [noderef] <asn:1> *k
>> arch/mips/include/asm/termios.h:84:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got struct termios2 *u @@
   arch/mips/include/asm/termios.h:84:34: sparse:     expected void const [noderef] <asn:1> *from
   arch/mips/include/asm/termios.h:84:34: sparse:     got struct termios2 *u
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/tty/cyclades.c:3077:68: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct FIRM_ID *firm_id @@     got void [noderef] <asn:2> * @@
   drivers/tty/cyclades.c:3077:68: sparse:     expected struct FIRM_ID *firm_id
   drivers/tty/cyclades.c:3077:68: sparse:     got void [noderef] <asn:2> *
>> drivers/tty/cyclades.c:3084:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned int * @@
   drivers/tty/cyclades.c:3084:41: sparse:     expected void const volatile [noderef] <asn:2> *mem
   drivers/tty/cyclades.c:3084:41: sparse:     got unsigned int *
   drivers/tty/cyclades.c:3083:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ZFW_CTRL *zfw_ctrl @@     got void [noderef] <asn:2> * @@
   drivers/tty/cyclades.c:3083:34: sparse:     expected struct ZFW_CTRL *zfw_ctrl
   drivers/tty/cyclades.c:3083:34: sparse:     got void [noderef] <asn:2> *
   drivers/tty/cyclades.c:3085:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct CH_CTRL [noderef] <asn:2> *ch_ctrl @@     got struct CH_CTRL * @@
   drivers/tty/cyclades.c:3085:45: sparse:     expected struct CH_CTRL [noderef] <asn:2> *ch_ctrl
   drivers/tty/cyclades.c:3085:45: sparse:     got struct CH_CTRL *
   drivers/tty/cyclades.c:3086:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct BUF_CTRL [noderef] <asn:2> *buf_ctrl @@     got struct BUF_CTRL * @@
   drivers/tty/cyclades.c:3086:46: sparse:     expected struct BUF_CTRL [noderef] <asn:2> *buf_ctrl
   drivers/tty/cyclades.c:3086:46: sparse:     got struct BUF_CTRL *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/tty/synclinkmp.c:3562:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] memory_base @@     got void [noderef] <asn:2> * @@
   drivers/tty/synclinkmp.c:3562:27: sparse:     expected unsigned char *[usertype] memory_base
   drivers/tty/synclinkmp.c:3562:27: sparse:     got void [noderef] <asn:2> *
   drivers/tty/synclinkmp.c:3571:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] lcr_base @@     got void [noderef] <asn:2> * @@
   drivers/tty/synclinkmp.c:3571:24: sparse:     expected unsigned char *[usertype] lcr_base
   drivers/tty/synclinkmp.c:3571:24: sparse:     got void [noderef] <asn:2> *
   drivers/tty/synclinkmp.c:3580:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] sca_base @@     got void [noderef] <asn:2> * @@
   drivers/tty/synclinkmp.c:3580:24: sparse:     expected unsigned char *[usertype] sca_base
   drivers/tty/synclinkmp.c:3580:24: sparse:     got void [noderef] <asn:2> *
   drivers/tty/synclinkmp.c:3589:29: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *[usertype] statctrl_base @@     got void [noderef] <asn:2> * @@
   drivers/tty/synclinkmp.c:3589:29: sparse:     expected unsigned char *[usertype] statctrl_base
   drivers/tty/synclinkmp.c:3589:29: sparse:     got void [noderef] <asn:2> *
>> drivers/tty/synclinkmp.c:3642:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned char *[usertype] memory_base @@
   drivers/tty/synclinkmp.c:3642:29: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/synclinkmp.c:3642:29: sparse:     got unsigned char *[usertype] memory_base
>> drivers/tty/synclinkmp.c:3647:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3647:40: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/synclinkmp.c:3647:40: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:3652:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3652:45: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/synclinkmp.c:3652:45: sparse:     got unsigned char *
   drivers/tty/synclinkmp.c:3657:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/synclinkmp.c:3657:40: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/synclinkmp.c:3657:40: sparse:     got unsigned char *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/tty/synclink.c:4057:35: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *memory_base @@     got void [noderef] <asn:2> * @@
   drivers/tty/synclink.c:4057:35: sparse:     expected unsigned char *memory_base
   drivers/tty/synclink.c:4057:35: sparse:     got void [noderef] <asn:2> *
   drivers/tty/synclink.c:4071:32: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char *lcr_base @@     got void [noderef] <asn:2> * @@
   drivers/tty/synclink.c:4071:32: sparse:     expected unsigned char *lcr_base
   drivers/tty/synclink.c:4071:32: sparse:     got void [noderef] <asn:2> *
>> drivers/tty/synclink.c:4140:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned char *memory_base @@
   drivers/tty/synclink.c:4140:29: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/synclink.c:4140:29: sparse:     got unsigned char *memory_base
>> drivers/tty/synclink.c:4144:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned char * @@
   drivers/tty/synclink.c:4144:40: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/tty/synclink.c:4144:40: sparse:     got unsigned char *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/usb/core/devio.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/kernel/traps.c:518:14: sparse: sparse: symbol 'll_bit' was not declared. Should it be static?
   arch/mips/kernel/traps.c:519:20: sparse: sparse: symbol 'll_task' was not declared. Should it be static?
   arch/mips/kernel/traps.c:701:17: sparse: sparse: symbol 'do_ov' was not declared. Should it be static?
   arch/mips/kernel/traps.c:978:17: sparse: sparse: symbol 'do_bp' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1070:17: sparse: sparse: symbol 'do_tr' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1139:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] <asn:1> *fault_addr @@     got unsigned long * @@
   arch/mips/kernel/traps.c:1139:47: sparse:     expected void [noderef] <asn:1> *fault_addr
   arch/mips/kernel/traps.c:1139:47: sparse:     got unsigned long *
   arch/mips/kernel/traps.c:1112:17: sparse: sparse: symbol 'do_ri' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1346:17: sparse: sparse: symbol 'do_cpu' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1452:17: sparse: sparse: symbol 'do_msa_fpe' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1472:17: sparse: sparse: symbol 'do_msa' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1493:17: sparse: sparse: symbol 'do_mdmx' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1505:17: sparse: sparse: symbol 'do_watch' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1532:17: sparse: sparse: symbol 'do_mcheck' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1563:17: sparse: sparse: symbol 'do_mt' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1599:17: sparse: sparse: symbol 'do_dsp' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1607:17: sparse: sparse: symbol 'do_reserved' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1831:17: sparse: sparse: symbol 'do_ftlb' was not declared. Should it be static?
   arch/mips/kernel/traps.c:1928:15: sparse: sparse: symbol 'vi_handlers' was not declared. Should it be static?
   arch/mips/kernel/traps.c: note: in included file (through arch/mips/include/asm/mips-cps.h):
>> arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
>> arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
>> arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
>> arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:151:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:151:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
   arch/mips/include/asm/mips-cm.h:165:1: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void * @@     got void [noderef] <asn:2> * @@
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     expected void *
   arch/mips/include/asm/mips-cm.h:165:1: sparse:     got void [noderef] <asn:2> *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/loongson64/common/reset.c:25:17: sparse: sparse: cast removes address space '<asn:2>' of expression
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/loongson64/common/mem.c:129:31: sparse: sparse: Using plain integer as NULL pointer
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/loongson64/common/early_printk.c:17:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got unsigned char [usertype] * @@
   arch/mips/loongson64/common/early_printk.c:17:22: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/loongson64/common/early_printk.c:17:22: sparse:     got unsigned char [usertype] *
>> arch/mips/loongson64/common/early_printk.c:22:23: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got unsigned char [usertype] * @@
   arch/mips/loongson64/common/early_printk.c:22:23: sparse:     expected void volatile [noderef] <asn:2> *mem
   arch/mips/loongson64/common/early_printk.c:22:23: sparse:     got unsigned char [usertype] *
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/loongson64/common/cs5536/cs5536_isa.c:84:6: sparse: sparse: symbol 'pci_isa_write_bar' was not declared. Should it be static?
>> arch/mips/loongson64/common/cs5536/cs5536_isa.c:110:5: sparse: sparse: symbol 'pci_isa_read_bar' was not declared. Should it be static?
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   fs/compat_ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/irqchip/irq-i8259.c:312:19: sparse: sparse: symbol '__init_i8259_irqs' was not declared. Should it be static?
>> drivers/irqchip/irq-i8259.c:349:12: sparse: sparse: symbol 'i8259_of_init' was not declared. Should it be static?
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> drivers/net/hamradio/dmascc.c:1238:56: sparse: sparse: non size-preserving pointer to integer cast
   drivers/net/hamradio/dmascc.c:978:48: sparse: sparse: non size-preserving pointer to integer cast
   drivers/net/hamradio/dmascc.c:1025:48: sparse: sparse: non size-preserving pointer to integer cast
   drivers/net/hamradio/dmascc.c:1025:48: sparse: sparse: non size-preserving pointer to integer cast
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   arch/mips/pci/ops-loongson2.c:93:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   arch/mips/pci/ops-loongson2.c:93:24: sparse:     expected unsigned int [usertype] val
   arch/mips/pci/ops-loongson2.c:93:24: sparse:     got restricted __le32 [usertype]
>> arch/mips/pci/ops-loongson2.c:93:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *mem @@     got void *[assigned] addrp @@
   arch/mips/pci/ops-loongson2.c:93:44: sparse:     expected void volatile [noderef] <asn:2> *mem
   arch/mips/pci/ops-loongson2.c:93:44: sparse:     got void *[assigned] addrp
>> arch/mips/pci/ops-loongson2.c:95:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *mem @@     got void *[assigned] addrp @@
   arch/mips/pci/ops-loongson2.c:95:25: sparse:     expected void const volatile [noderef] <asn:2> *mem
   arch/mips/pci/ops-loongson2.c:95:25: sparse:     got void *[assigned] addrp
   arch/mips/pci/ops-loongson2.c:95:25: sparse: sparse: cast to restricted __le32
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
>> arch/mips/oprofile/backtrace.c:22:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] <asn:1> *p @@     got unsigned long *address @@
   arch/mips/oprofile/backtrace.c:22:14: sparse:     expected void const [noderef] <asn:1> *p
   arch/mips/oprofile/backtrace.c:22:14: sparse:     got unsigned long *address
>> arch/mips/oprofile/backtrace.c:24:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got unsigned long *address @@
   arch/mips/oprofile/backtrace.c:24:47: sparse:     expected void const [noderef] <asn:1> *from
   arch/mips/oprofile/backtrace.c:24:47: sparse:     got unsigned long *address
>> arch/mips/oprofile/backtrace.c:22:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] <asn:1> *p @@     got unsigned long *address @@
   arch/mips/oprofile/backtrace.c:22:14: sparse:     expected void const [noderef] <asn:1> *p
   arch/mips/oprofile/backtrace.c:22:14: sparse:     got unsigned long *address
>> arch/mips/oprofile/backtrace.c:24:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got unsigned long *address @@
   arch/mips/oprofile/backtrace.c:24:47: sparse:     expected void const [noderef] <asn:1> *from
   arch/mips/oprofile/backtrace.c:24:47: sparse:     got unsigned long *address
>> arch/mips/oprofile/backtrace.c:22:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] <asn:1> *p @@     got unsigned long *address @@
   arch/mips/oprofile/backtrace.c:22:14: sparse:     expected void const [noderef] <asn:1> *p
   arch/mips/oprofile/backtrace.c:22:14: sparse:     got unsigned long *address
>> arch/mips/oprofile/backtrace.c:24:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] <asn:1> *from @@     got unsigned long *address @@
   arch/mips/oprofile/backtrace.c:24:47: sparse:     expected void const [noderef] <asn:1> *from
   arch/mips/oprofile/backtrace.c:24:47: sparse:     got unsigned long *address
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   net/compat.c:59:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *msg_control @@     got void [noderef] <asn:1> * @@
   net/compat.c:59:27: sparse:     expected void *msg_control
   net/compat.c:59:27: sparse:     got void [noderef] <asn:1> *
   net/compat.c:144:22: sparse: sparse: cast removes address space '<asn:1>' of expression
   net/compat.c:171:22: sparse: sparse: cast removes address space '<asn:1>' of expression
   net/compat.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
--
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   net/socket.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to
>> arch/mips/include/asm/uaccess.h:629:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:629:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:629:24: sparse:     got void [noderef] <asn:1> *to
   arch/mips/include/asm/uaccess.h:631:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *register __cu_to_r @@     got void [noderef] <asn:1> *to @@
   arch/mips/include/asm/uaccess.h:631:24: sparse:     expected void *register __cu_to_r
   arch/mips/include/asm/uaccess.h:631:24: sparse:     got void [noderef] <asn:1> *to

vim +470 drivers/gpu/drm/exynos/exynos_drm_fimd.c

1c248b7d2960fa Inki Dae              2011-10-04  460  
e30d4bcf79b6a3 Inki Dae              2011-12-12  461  	if (ctx->suspended)
e30d4bcf79b6a3 Inki Dae              2011-12-12  462  		return;
e30d4bcf79b6a3 Inki Dae              2011-12-12  463  
a968e72771ea19 Sean Paul             2014-01-30  464  	/* nothing to do if we haven't set the mode yet */
a968e72771ea19 Sean Paul             2014-01-30  465  	if (mode->htotal == 0 || mode->vtotal == 0)
a968e72771ea19 Sean Paul             2014-01-30  466  		return;
a968e72771ea19 Sean Paul             2014-01-30  467  
3854fab24e899c YoungJun Cho          2014-07-17  468  	if (ctx->i80_if) {
3854fab24e899c YoungJun Cho          2014-07-17  469  		val = ctx->i80ifcon | I80IFEN_ENABLE;
3854fab24e899c YoungJun Cho          2014-07-17 @470  		writel(val, timing_base + I80IFCONFAx(0));
3854fab24e899c YoungJun Cho          2014-07-17  471  
3854fab24e899c YoungJun Cho          2014-07-17  472  		/* disable auto frame rate */
3854fab24e899c YoungJun Cho          2014-07-17  473  		writel(0, timing_base + I80IFCONFBx(0));
3854fab24e899c YoungJun Cho          2014-07-17  474  
3854fab24e899c YoungJun Cho          2014-07-17  475  		/* set video type selection to I80 interface */
3c3c9c1d904dca Joonyoung Shim        2014-11-14  476  		if (driver_data->has_vtsel && ctx->sysreg &&
3c3c9c1d904dca Joonyoung Shim        2014-11-14  477  				regmap_update_bits(ctx->sysreg,
3854fab24e899c YoungJun Cho          2014-07-17  478  					driver_data->lcdblk_offset,
3854fab24e899c YoungJun Cho          2014-07-17  479  					0x3 << driver_data->lcdblk_vt_shift,
3854fab24e899c YoungJun Cho          2014-07-17  480  					0x1 << driver_data->lcdblk_vt_shift)) {
6f83d20838c099 Inki Dae              2019-04-15  481  			DRM_DEV_ERROR(ctx->dev,
6f83d20838c099 Inki Dae              2019-04-15  482  				      "Failed to update sysreg for I80 i/f.\n");
3854fab24e899c YoungJun Cho          2014-07-17  483  			return;
3854fab24e899c YoungJun Cho          2014-07-17  484  		}
3854fab24e899c YoungJun Cho          2014-07-17  485  	} else {
3854fab24e899c YoungJun Cho          2014-07-17  486  		int vsync_len, vbpd, vfpd, hsync_len, hbpd, hfpd;
3854fab24e899c YoungJun Cho          2014-07-17  487  		u32 vidcon1;
3854fab24e899c YoungJun Cho          2014-07-17  488  
1417f109a82f8a Sean Paul             2014-01-30  489  		/* setup polarity values */
1417f109a82f8a Sean Paul             2014-01-30  490  		vidcon1 = ctx->vidcon1;
1417f109a82f8a Sean Paul             2014-01-30  491  		if (mode->flags & DRM_MODE_FLAG_NVSYNC)
1417f109a82f8a Sean Paul             2014-01-30  492  			vidcon1 |= VIDCON1_INV_VSYNC;
1417f109a82f8a Sean Paul             2014-01-30  493  		if (mode->flags & DRM_MODE_FLAG_NHSYNC)
1417f109a82f8a Sean Paul             2014-01-30  494  			vidcon1 |= VIDCON1_INV_HSYNC;
1417f109a82f8a Sean Paul             2014-01-30  495  		writel(vidcon1, ctx->regs + driver_data->timing_base + VIDCON1);
1c248b7d2960fa Inki Dae              2011-10-04  496  
1c248b7d2960fa Inki Dae              2011-10-04  497  		/* setup vertical timing values. */
a968e72771ea19 Sean Paul             2014-01-30  498  		vsync_len = mode->crtc_vsync_end - mode->crtc_vsync_start;
8b4cad23531da4 Andrzej Hajda         2014-03-17  499  		vbpd = mode->crtc_vtotal - mode->crtc_vsync_end;
8b4cad23531da4 Andrzej Hajda         2014-03-17  500  		vfpd = mode->crtc_vsync_start - mode->crtc_vdisplay;
a968e72771ea19 Sean Paul             2014-01-30  501  
a968e72771ea19 Sean Paul             2014-01-30  502  		val = VIDTCON0_VBPD(vbpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  503  			VIDTCON0_VFPD(vfpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  504  			VIDTCON0_VSPW(vsync_len - 1);
e2e1338900208a Leela Krishna Amudala 2012-09-21  505  		writel(val, ctx->regs + driver_data->timing_base + VIDTCON0);
1c248b7d2960fa Inki Dae              2011-10-04  506  
1c248b7d2960fa Inki Dae              2011-10-04  507  		/* setup horizontal timing values.  */
a968e72771ea19 Sean Paul             2014-01-30  508  		hsync_len = mode->crtc_hsync_end - mode->crtc_hsync_start;
8b4cad23531da4 Andrzej Hajda         2014-03-17  509  		hbpd = mode->crtc_htotal - mode->crtc_hsync_end;
8b4cad23531da4 Andrzej Hajda         2014-03-17  510  		hfpd = mode->crtc_hsync_start - mode->crtc_hdisplay;
a968e72771ea19 Sean Paul             2014-01-30  511  
a968e72771ea19 Sean Paul             2014-01-30  512  		val = VIDTCON1_HBPD(hbpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  513  			VIDTCON1_HFPD(hfpd - 1) |
a968e72771ea19 Sean Paul             2014-01-30  514  			VIDTCON1_HSPW(hsync_len - 1);
e2e1338900208a Leela Krishna Amudala 2012-09-21  515  		writel(val, ctx->regs + driver_data->timing_base + VIDTCON1);
3854fab24e899c YoungJun Cho          2014-07-17  516  	}
3854fab24e899c YoungJun Cho          2014-07-17  517  
3854fab24e899c YoungJun Cho          2014-07-17  518  	if (driver_data->has_vidoutcon)
3854fab24e899c YoungJun Cho          2014-07-17  519  		writel(ctx->vidout_con, timing_base + VIDOUT_CON);
3854fab24e899c YoungJun Cho          2014-07-17  520  
3854fab24e899c YoungJun Cho          2014-07-17  521  	/* set bypass selection */
3854fab24e899c YoungJun Cho          2014-07-17  522  	if (ctx->sysreg && regmap_update_bits(ctx->sysreg,
3854fab24e899c YoungJun Cho          2014-07-17  523  				driver_data->lcdblk_offset,
3854fab24e899c YoungJun Cho          2014-07-17  524  				0x1 << driver_data->lcdblk_bypass_shift,
3854fab24e899c YoungJun Cho          2014-07-17  525  				0x1 << driver_data->lcdblk_bypass_shift)) {
6f83d20838c099 Inki Dae              2019-04-15  526  		DRM_DEV_ERROR(ctx->dev,
6f83d20838c099 Inki Dae              2019-04-15  527  			      "Failed to update sysreg for bypass setting.\n");
3854fab24e899c YoungJun Cho          2014-07-17  528  		return;
3854fab24e899c YoungJun Cho          2014-07-17  529  	}
1c248b7d2960fa Inki Dae              2011-10-04  530  
1feafd3afd294b Chanho Park           2016-02-12  531  	/* TODO: When MIC is enabled for display path, the lcdblk_mic_bypass
1feafd3afd294b Chanho Park           2016-02-12  532  	 * bit should be cleared.
1feafd3afd294b Chanho Park           2016-02-12  533  	 */
1feafd3afd294b Chanho Park           2016-02-12  534  	if (driver_data->has_mic_bypass && ctx->sysreg &&
1feafd3afd294b Chanho Park           2016-02-12  535  	    regmap_update_bits(ctx->sysreg,
1feafd3afd294b Chanho Park           2016-02-12  536  				driver_data->lcdblk_offset,
1feafd3afd294b Chanho Park           2016-02-12  537  				0x1 << driver_data->lcdblk_mic_bypass_shift,
1feafd3afd294b Chanho Park           2016-02-12  538  				0x1 << driver_data->lcdblk_mic_bypass_shift)) {
6f83d20838c099 Inki Dae              2019-04-15  539  		DRM_DEV_ERROR(ctx->dev,
6f83d20838c099 Inki Dae              2019-04-15  540  			      "Failed to update sysreg for bypass mic.\n");
1feafd3afd294b Chanho Park           2016-02-12  541  		return;
1feafd3afd294b Chanho Park           2016-02-12  542  	}
1feafd3afd294b Chanho Park           2016-02-12  543  
1c248b7d2960fa Inki Dae              2011-10-04  544  	/* setup horizontal and vertical display size. */
a968e72771ea19 Sean Paul             2014-01-30  545  	val = VIDTCON2_LINEVAL(mode->vdisplay - 1) |
a968e72771ea19 Sean Paul             2014-01-30  546  	       VIDTCON2_HOZVAL(mode->hdisplay - 1) |
a968e72771ea19 Sean Paul             2014-01-30  547  	       VIDTCON2_LINEVAL_E(mode->vdisplay - 1) |
a968e72771ea19 Sean Paul             2014-01-30  548  	       VIDTCON2_HOZVAL_E(mode->hdisplay - 1);
e2e1338900208a Leela Krishna Amudala 2012-09-21  549  	writel(val, ctx->regs + driver_data->timing_base + VIDTCON2);
1c248b7d2960fa Inki Dae              2011-10-04  550  
a6f75aa161c5a5 Inki Dae              2016-04-18  551  	fimd_setup_trigger(ctx);
a6f75aa161c5a5 Inki Dae              2016-04-18  552  
1d531062cdc5fc Andrzej Hajda         2014-03-20  553  	/*
1d531062cdc5fc Andrzej Hajda         2014-03-20  554  	 * fields of register with prefix '_F' would be updated
1d531062cdc5fc Andrzej Hajda         2014-03-20  555  	 * at vsync(same as dma start)
1d531062cdc5fc Andrzej Hajda         2014-03-20  556  	 */
3854fab24e899c YoungJun Cho          2014-07-17  557  	val = ctx->vidcon0;
3854fab24e899c YoungJun Cho          2014-07-17  558  	val |= VIDCON0_ENVID | VIDCON0_ENVID_F;
1c248b7d2960fa Inki Dae              2011-10-04  559  
1d531062cdc5fc Andrzej Hajda         2014-03-20  560  	if (ctx->driver_data->has_clksel)
411d9ed4486a4e Tomasz Figa           2013-05-01  561  		val |= VIDCON0_CLKSEL_LCD;
411d9ed4486a4e Tomasz Figa           2013-05-01  562  
c96fdfdeca5657 Andrzej Hajda         2016-09-23  563  	if (ctx->clkdiv > 1)
c96fdfdeca5657 Andrzej Hajda         2016-09-23  564  		val |= VIDCON0_CLKVAL_F(ctx->clkdiv - 1) | VIDCON0_CLKDIR;
1c248b7d2960fa Inki Dae              2011-10-04  565  
1c248b7d2960fa Inki Dae              2011-10-04  566  	writel(val, ctx->regs + VIDCON0);
1c248b7d2960fa Inki Dae              2011-10-04  567  }
1c248b7d2960fa Inki Dae              2011-10-04  568  
3b5129b3a7c62f Christoph Manszewski  2018-10-25  569  static void fimd_win_set_bldeq(struct fimd_context *ctx, unsigned int win,
3b5129b3a7c62f Christoph Manszewski  2018-10-25  570  			       unsigned int alpha, unsigned int pixel_alpha)
3b5129b3a7c62f Christoph Manszewski  2018-10-25  571  {
3b5129b3a7c62f Christoph Manszewski  2018-10-25  572  	u32 mask = BLENDEQ_A_FUNC_F(0xf) | BLENDEQ_B_FUNC_F(0xf);
3b5129b3a7c62f Christoph Manszewski  2018-10-25  573  	u32 val = 0;
3b5129b3a7c62f Christoph Manszewski  2018-10-25  574  
3b5129b3a7c62f Christoph Manszewski  2018-10-25  575  	switch (pixel_alpha) {
3b5129b3a7c62f Christoph Manszewski  2018-10-25  576  	case DRM_MODE_BLEND_PIXEL_NONE:

:::::: The code at line 470 was first introduced by commit
:::::: 3854fab24e899c02439657956ab1d2c85001958c drm/exynos: fimd: support LCD I80 interface

:::::: TO: YoungJun Cho <yj44.cho@samsung.com>
:::::: CC: Inki Dae <daeinki@gmail.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--gKMricLos+KVdGMg--
