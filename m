Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F143D03FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhGTVDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:03:01 -0400
Received: from mga03.intel.com ([134.134.136.65]:43148 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231395AbhGTVCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:02:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="211390909"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="gz'50?scan'50,208,50";a="211390909"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 14:43:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="gz'50?scan'50,208,50";a="495047056"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2021 14:43:19 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5xWI-0000Pn-Rp; Tue, 20 Jul 2021 21:43:18 +0000
Date:   Wed, 21 Jul 2021 05:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [arnd-playground:asm-generic-uaccess-4 5/7] csky-linux-ld:
 reboot.c:undefined reference to `strncpy_from_user'
Message-ID: <202107210548.RanhZwG2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git asm-generic-uaccess-4
head:   d7d80410412f516869e09904cffd817acaeec742
commit: 198667ecde061778d6236eb5f8fa4233929f4805 [5/7] asm-generic: uaccess: remove inline strncpy_from_user/strnlen_user
config: csky-defconfig (attached as .config)
compiler: csky-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git/commit/?id=198667ecde061778d6236eb5f8fa4233929f4805
        git remote add arnd-playground https://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
        git fetch --no-tags arnd-playground asm-generic-uaccess-4
        git checkout 198667ecde061778d6236eb5f8fa4233929f4805
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: kernel/reboot.o: in function `__do_sys_reboot':
   reboot.c:(.text+0x54e): undefined reference to `strncpy_from_user'
>> csky-linux-ld: reboot.c:(.text+0x610): undefined reference to `strncpy_from_user'
   csky-linux-ld: kernel/module.o: in function `__do_sys_delete_module.constprop.0':
>> module.c:(.text+0x24b0): undefined reference to `strncpy_from_user'
>> csky-linux-ld: module.c:(.text+0x255c): undefined reference to `strncpy_from_user'
   csky-linux-ld: fs/binfmt_elf.o: in function `$t':
>> binfmt_elf.c:(.text+0x13dc): undefined reference to `strnlen_user'
   csky-linux-ld: fs/binfmt_elf.o: in function `$d':
   binfmt_elf.c:(.text+0x1424): undefined reference to `strnlen_user'
   csky-linux-ld: fs/binfmt_elf.o: in function `$t':
   binfmt_elf.c:(.text+0x1484): undefined reference to `strnlen_user'
   csky-linux-ld: fs/binfmt_elf.o: in function `$d':
   binfmt_elf.c:(.text+0x1540): undefined reference to `strnlen_user'
   csky-linux-ld: drivers/tty/vt/vt.o: in function `con_font_op':
>> vt.c:(.text+0x55d8): undefined reference to `strncpy_from_user'
>> csky-linux-ld: vt.c:(.text+0x5640): undefined reference to `strncpy_from_user'
   csky-linux-ld: net/ipv4/tcp.o: in function `$t':
>> tcp.c:(.text+0x5732): undefined reference to `strncpy_from_user'
>> csky-linux-ld: tcp.c:(.text+0x5774): undefined reference to `strncpy_from_user'
   csky-linux-ld: net/ipv4/tcp.o: in function `$d':
   tcp.c:(.text+0x57e4): undefined reference to `strncpy_from_user'
   csky-linux-ld: kernel/sys.o:sys.c:(.text+0x1f6e): more undefined references to `strncpy_from_user' follow
   csky-linux-ld: kernel/auditsc.o: in function `audit_log_execve_info':
>> auditsc.c:(.text+0x536): undefined reference to `strnlen_user'
>> csky-linux-ld: auditsc.c:(.text+0x630): undefined reference to `strncpy_from_user'
>> csky-linux-ld: auditsc.c:(.text+0x638): undefined reference to `strnlen_user'
   csky-linux-ld: mm/maccess.o: in function `strncpy_from_user_nofault':
>> maccess.c:(.text+0x2cc): undefined reference to `strncpy_from_user'
   csky-linux-ld: mm/maccess.o: in function `strnlen_user_nofault':
>> maccess.c:(.text+0x332): undefined reference to `strnlen_user'
   csky-linux-ld: mm/maccess.o: in function `$d':
   maccess.c:(.text+0x354): undefined reference to `strncpy_from_user'
>> csky-linux-ld: maccess.c:(.text+0x358): undefined reference to `strnlen_user'
   csky-linux-ld: mm/util.o: in function `strndup_user':
>> util.c:(.text+0x4f6): undefined reference to `strnlen_user'
>> csky-linux-ld: util.c:(.text+0x558): undefined reference to `strnlen_user'
   csky-linux-ld: mm/memfd.o: in function `__do_sys_memfd_create':
>> memfd.c:(.text+0x1a): undefined reference to `strnlen_user'
>> csky-linux-ld: memfd.c:(.text+0x118): undefined reference to `strnlen_user'
   csky-linux-ld: fs/exec.o:exec.c:(.text+0x12c8): more undefined references to `strnlen_user' follow
   csky-linux-ld: fs/namei.o: in function `getname_flags.part.0':
>> namei.c:(.text+0x4604): undefined reference to `strncpy_from_user'
>> csky-linux-ld: namei.c:(.text+0x467a): undefined reference to `strncpy_from_user'
   csky-linux-ld: namei.c:(.text+0x46c0): undefined reference to `strncpy_from_user'
   csky-linux-ld: fs/xattr.o: in function `removexattr':
   xattr.c:(.text+0x5ce): undefined reference to `strncpy_from_user'
   csky-linux-ld: fs/xattr.o: in function `$d':
   xattr.c:(.text+0x700): undefined reference to `strncpy_from_user'
   csky-linux-ld: fs/xattr.o:xattr.c:(.text+0x928): more undefined references to `strncpy_from_user' follow

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--n8g4imXOkfNTN/H1
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nwAA

--n8g4imXOkfNTN/H1--
