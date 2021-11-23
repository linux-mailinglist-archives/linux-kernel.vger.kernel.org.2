Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64F8F45AEEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbhKWWXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:23:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:51014 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhKWWXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:23:04 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="222368402"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="222368402"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2021 14:19:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; 
   d="scan'208";a="497444452"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2021 14:19:54 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mpe8n-0002MS-DF; Tue, 23 Nov 2021 22:19:53 +0000
Date:   Wed, 24 Nov 2021 06:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates
 bits from constant value (deadbeef becomes ef)
Message-ID: <202111240654.4qXNBmtC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   136057256686de39cc3a07c2e39ef6bc43003ff6
commit: c7178cdecdbef8321f418fac55f3afaca3bb4c96 locking/atomic: h8300: use asm-generic exclusively
date:   6 months ago
config: h8300-randconfig-s031-20211117 (https://download.01.org/0day-ci/archive/20211124/202111240654.4qXNBmtC-lkp@intel.com/config.gz)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c7178cdecdbef8321f418fac55f3afaca3bb4c96
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout c7178cdecdbef8321f418fac55f3afaca3bb4c96
        # save the config file to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   lib/atomic64_test.c: note: in included file (through arch/h8300/include/generated/asm/cmpxchg.h, include/asm-generic/atomic.h, arch/h8300/include/generated/asm/atomic.h, ...):
>> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg.h:37:39: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg.h:48:40: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
   lib/atomic64_test.c: note: in included file (through include/asm-generic/cmpxchg.h, arch/h8300/include/generated/asm/cmpxchg.h, include/asm-generic/atomic.h, ...):
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)
>> include/asm-generic/cmpxchg-local.h:30:42: sparse: sparse: cast truncates bits from constant value (deadbeef becomes ef)
>> include/asm-generic/cmpxchg-local.h:34:44: sparse: sparse: cast truncates bits from constant value (deadbeef becomes beef)

vim +37 include/asm-generic/cmpxchg.h

b4816afa398670 David Howells 2012-03-28  24  
b4816afa398670 David Howells 2012-03-28  25  static inline
b4816afa398670 David Howells 2012-03-28  26  unsigned long __xchg(unsigned long x, volatile void *ptr, int size)
b4816afa398670 David Howells 2012-03-28  27  {
b4816afa398670 David Howells 2012-03-28  28  	unsigned long ret, flags;
b4816afa398670 David Howells 2012-03-28  29  
b4816afa398670 David Howells 2012-03-28  30  	switch (size) {
b4816afa398670 David Howells 2012-03-28  31  	case 1:
b4816afa398670 David Howells 2012-03-28  32  #ifdef __xchg_u8
b4816afa398670 David Howells 2012-03-28  33  		return __xchg_u8(x, ptr);
b4816afa398670 David Howells 2012-03-28  34  #else
b4816afa398670 David Howells 2012-03-28  35  		local_irq_save(flags);
b4816afa398670 David Howells 2012-03-28  36  		ret = *(volatile u8 *)ptr;
b4816afa398670 David Howells 2012-03-28 @37  		*(volatile u8 *)ptr = x;
b4816afa398670 David Howells 2012-03-28  38  		local_irq_restore(flags);
b4816afa398670 David Howells 2012-03-28  39  		return ret;
b4816afa398670 David Howells 2012-03-28  40  #endif /* __xchg_u8 */
b4816afa398670 David Howells 2012-03-28  41  
b4816afa398670 David Howells 2012-03-28  42  	case 2:
b4816afa398670 David Howells 2012-03-28  43  #ifdef __xchg_u16
b4816afa398670 David Howells 2012-03-28  44  		return __xchg_u16(x, ptr);
b4816afa398670 David Howells 2012-03-28  45  #else
b4816afa398670 David Howells 2012-03-28  46  		local_irq_save(flags);
b4816afa398670 David Howells 2012-03-28  47  		ret = *(volatile u16 *)ptr;
b4816afa398670 David Howells 2012-03-28 @48  		*(volatile u16 *)ptr = x;
b4816afa398670 David Howells 2012-03-28  49  		local_irq_restore(flags);
b4816afa398670 David Howells 2012-03-28  50  		return ret;
b4816afa398670 David Howells 2012-03-28  51  #endif /* __xchg_u16 */
b4816afa398670 David Howells 2012-03-28  52  
b4816afa398670 David Howells 2012-03-28  53  	case 4:
b4816afa398670 David Howells 2012-03-28  54  #ifdef __xchg_u32
b4816afa398670 David Howells 2012-03-28  55  		return __xchg_u32(x, ptr);
b4816afa398670 David Howells 2012-03-28  56  #else
b4816afa398670 David Howells 2012-03-28  57  		local_irq_save(flags);
b4816afa398670 David Howells 2012-03-28  58  		ret = *(volatile u32 *)ptr;
b4816afa398670 David Howells 2012-03-28  59  		*(volatile u32 *)ptr = x;
b4816afa398670 David Howells 2012-03-28  60  		local_irq_restore(flags);
b4816afa398670 David Howells 2012-03-28  61  		return ret;
b4816afa398670 David Howells 2012-03-28  62  #endif /* __xchg_u32 */
b4816afa398670 David Howells 2012-03-28  63  

:::::: The code at line 37 was first introduced by commit
:::::: b4816afa3986704d1404fc48e931da5135820472 Move the asm-generic/system.h xchg() implementation to asm-generic/cmpxchg.h

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
