Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89AA321152
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 08:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhBVHV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 02:21:26 -0500
Received: from mga06.intel.com ([134.134.136.31]:37023 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229549AbhBVHVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 02:21:22 -0500
IronPort-SDR: 0abjcththlAVU7MH32SSnVdtp0afARpeIMT+a9KoPUSo/iosWnVSJD2XMkk5U8+buBYOms+yF3
 gkgXpn4L5bHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9902"; a="245785256"
X-IronPort-AV: E=Sophos;i="5.81,196,1610438400"; 
   d="gz'50?scan'50,208,50";a="245785256"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2021 23:20:41 -0800
IronPort-SDR: lFdK4yqJ9VdHeIixLuxoPPdejtVKLuXvQRpEtgEr6V7eSGR2tz96t5gtKvbV69WzPh+WdtAkQH
 1SWlDsWOHnHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,196,1610438400"; 
   d="gz'50?scan'50,208,50";a="498388186"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Feb 2021 23:20:38 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lE5WH-0000CI-CX; Mon, 22 Feb 2021 07:20:37 +0000
Date:   Mon, 22 Feb 2021 15:19:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: arch/x86/um/shared/sysdep/stub_32.h:80:1: warning: 'inline' is not
 at beginning of declaration
Message-ID: <202102221535.cIzMH0pU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   31caf8b2a847214be856f843e251fc2ed2cd1075
commit: 9f0b4807a44ff81cf59421c8a86641efec586610 um: rework userspace stubs to not hard-code stub location
date:   9 days ago
config: um-i386_defconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f0b4807a44ff81cf59421c8a86641efec586610
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9f0b4807a44ff81cf59421c8a86641efec586610
        # save the attached .config to linux build tree
        make W=1 ARCH=um SUBARCH=i386

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/um/shared/sysdep/stub.h:9,
                    from arch/um/kernel/skas/clone.c:14:
>> arch/x86/um/shared/sysdep/stub_32.h:80:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
      80 | static void inline remap_stack_and_trap(void)
         | ^~~~~~
--
   In file included from arch/x86/um/shared/sysdep/stub.h:9,
                    from arch/um/os-Linux/skas/process.c:23:
>> arch/x86/um/shared/sysdep/stub_32.h:80:1: warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
      80 | static void inline remap_stack_and_trap(void)
         | ^~~~~~
   arch/um/os-Linux/skas/process.c:106:6: warning: no previous prototype for 'wait_stub_done' [-Wmissing-prototypes]
     106 | void wait_stub_done(int pid)
         |      ^~~~~~~~~~~~~~
   arch/um/os-Linux/skas/process.c:720:6: warning: no previous prototype for '__switch_mm' [-Wmissing-prototypes]
     720 | void __switch_mm(struct mm_id *mm_idp)
         |      ^~~~~~~~~~~


vim +/inline +80 arch/x86/um/shared/sysdep/stub_32.h

    79	
  > 80	static void inline remap_stack_and_trap(void)
    81	{
    82		__asm__ volatile (
    83			"movl %%esp,%%ebx ;"
    84			"andl %0,%%ebx ;"
    85			"movl %1,%%eax ;"
    86			"movl %%ebx,%%edi ; addl %2,%%edi ; movl (%%edi),%%edi ;"
    87			"movl %%ebx,%%ebp ; addl %3,%%ebp ; movl (%%ebp),%%ebp ;"
    88			"int $0x80 ;"
    89			"addl %4,%%ebx ; movl %%eax, (%%ebx) ;"
    90			"int $3"
    91			: :
    92			"g" (~(UM_KERN_PAGE_SIZE - 1)),
    93			"g" (STUB_MMAP_NR),
    94			"g" (UML_STUB_FIELD_FD),
    95			"g" (UML_STUB_FIELD_OFFSET),
    96			"g" (UML_STUB_FIELD_CHILD_ERR),
    97			"c" (UM_KERN_PAGE_SIZE),
    98			"d" (PROT_READ | PROT_WRITE),
    99			"S" (MAP_FIXED | MAP_SHARED)
   100			:
   101			"memory");
   102	}
   103	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
bf8HSUhrjQyIAAA=

--PNTmBPCT7hxwcZjr--
