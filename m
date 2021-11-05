Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB24462D3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 12:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbhKELj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 07:39:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:25173 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232296AbhKELj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 07:39:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="231728245"
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; 
   d="gz'50?scan'50,208,50";a="231728245"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 04:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,211,1631602800"; 
   d="gz'50?scan'50,208,50";a="501907884"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 05 Nov 2021 04:36:44 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mixWV-0007bS-9Y; Fri, 05 Nov 2021 11:36:43 +0000
Date:   Fri, 5 Nov 2021 19:36:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: arch/mips/include/asm/uaccess.h:82:10: error: use of undeclared
 identifier '__UA_LIMIT'
Message-ID: <202111051920.dcCUQ0QN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d4439a1189f93d0ac1eaf0197db8e6b3e197d5c7
commit: 04324f44cb69a03fdc8f2ee52386a4fdf6a0043b MIPS: Remove get_fs/set_fs
date:   7 months ago
config: mips-randconfig-r014-20211103 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 264d3b6d4e08401c5b50a85bd76e80b3461d77e6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=04324f44cb69a03fdc8f2ee52386a4fdf6a0043b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 04324f44cb69a03fdc8f2ee52386a4fdf6a0043b
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:61:
   In file included from arch/mips/include/asm/mmiowb.h:5:
   In file included from arch/mips/include/asm/io.h:29:
   arch/mips/include/asm/page.h:196:13: error: use of undeclared identifier 'CAC_BASE'
           return x - PAGE_OFFSET + PHYS_OFFSET;
                      ^
   arch/mips/include/asm/mach-generic/spaces.h:91:23: note: expanded from macro 'PAGE_OFFSET'
   #define PAGE_OFFSET             (CAC_BASE + PHYS_OFFSET)
                                    ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:14:
   In file included from include/linux/sem.h:5:
   In file included from include/uapi/linux/sem.h:5:
   In file included from include/linux/ipc.h:5:
   In file included from include/linux/spinlock.h:61:
   In file included from arch/mips/include/asm/mmiowb.h:5:
   arch/mips/include/asm/io.h:134:28: error: use of undeclared identifier 'CAC_BASE'
           return (void *)(address + PAGE_OFFSET - PHYS_OFFSET);
                                     ^
   arch/mips/include/asm/mach-generic/spaces.h:91:23: note: expanded from macro 'PAGE_OFFSET'
   #define PAGE_OFFSET             (CAC_BASE + PHYS_OFFSET)
                                    ^
   In file included from arch/mips/kernel/asm-offsets.c:12:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:9:
   In file included from include/linux/sched/task.h:11:
   In file included from include/linux/uaccess.h:11:
>> arch/mips/include/asm/uaccess.h:82:10: error: use of undeclared identifier '__UA_LIMIT'
           return (__UA_LIMIT & (addr | (addr + size) | __ua_size(size))) == 0;
                   ^
   arch/mips/include/asm/uaccess.h:464:3: error: expected ')'
                   __UA_ADDU "\t$1, %1, %2\n\t"
                   ^
   arch/mips/include/asm/uaccess.h:514:3: error: expected ')'
                   __UA_ADDU "\t$1, %1, %2\n\t"
                   ^
   arch/mips/include/asm/uaccess.h:558:5: error: expected string literal in 'asm'
                   : bzero_clobbers);
                     ^
   arch/mips/include/asm/uaccess.h:546:42: note: expanded from macro 'bzero_clobbers'
   #define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$31"
                                            ^
   arch/mips/include/asm/uaccess.h:558:5: error: expected ')'
   arch/mips/include/asm/uaccess.h:546:42: note: expanded from macro 'bzero_clobbers'
   #define bzero_clobbers "$4", "$5", "$6", __UA_t0, __UA_t1, "$31"
                                            ^
   arch/mips/include/asm/uaccess.h:609:35: error: expected string literal in 'asm'
                   : "$2", "$3", "$4", "$5", "$6", __UA_t0, "$31", "memory");
                                                   ^
   arch/mips/include/asm/uaccess.h:609:35: error: expected ')'
   arch/mips/include/asm/uaccess.h:644:23: error: expected string literal in 'asm'
                   : "$2", "$4", "$5", __UA_t0, "$31");
                                       ^
   arch/mips/include/asm/uaccess.h:644:23: error: expected ')'
   In file included from arch/mips/kernel/asm-offsets.c:15:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:6:
>> arch/mips/include/asm/pgtable.h:232:29: error: implicit declaration of function 'pte_pfn' [-Werror,-Wimplicit-function-declaration]
           if (pte_present(*ptep) && (pte_pfn(*ptep) == pte_pfn(pteval)))
                                      ^
>> arch/mips/include/asm/pgtable.h:550:25: error: unknown type name 'pmd_t'
           unsigned long address, pmd_t *pmdp)
                                  ^
   In file included from arch/mips/kernel/asm-offsets.c:15:
   In file included from include/linux/mm.h:33:
   In file included from include/linux/pgtable.h:14:
>> include/asm-generic/pgtable_uffd.h:10:40: error: unknown type name 'pmd_t'
   static __always_inline int pmd_uffd_wp(pmd_t pmd)
                                          ^
   include/asm-generic/pgtable_uffd.h:20:24: error: unknown type name 'pmd_t'
   static __always_inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
                          ^
   include/asm-generic/pgtable_uffd.h:20:44: error: unknown type name 'pmd_t'
   static __always_inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
                                              ^
   include/asm-generic/pgtable_uffd.h:30:24: error: unknown type name 'pmd_t'
   static __always_inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
                          ^
   include/asm-generic/pgtable_uffd.h:30:48: error: unknown type name 'pmd_t'
   static __always_inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
                                                  ^
   include/asm-generic/pgtable_uffd.h:50:15: error: unknown type name 'pmd_t'
   static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
                 ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
   make[2]: *** [scripts/Makefile.build:116: arch/mips/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1233: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/__UA_LIMIT +82 arch/mips/include/asm/uaccess.h

    44	
    45	/*
    46	 * Is a address valid? This does a straightforward calculation rather
    47	 * than tests.
    48	 *
    49	 * Address valid if:
    50	 *  - "addr" doesn't have any high-bits set
    51	 *  - AND "size" doesn't have any high-bits set
    52	 *  - AND "addr+size" doesn't have any high-bits set
    53	 *  - OR we are in kernel mode.
    54	 *
    55	 * __ua_size() is a trick to avoid runtime checking of positive constant
    56	 * sizes; for those we already know at compile time that the size is ok.
    57	 */
    58	#define __ua_size(size)							\
    59		((__builtin_constant_p(size) && (signed long) (size) > 0) ? 0 : (size))
    60	
    61	/*
    62	 * access_ok: - Checks if a user space pointer is valid
    63	 * @addr: User space pointer to start of block to check
    64	 * @size: Size of block to check
    65	 *
    66	 * Context: User context only. This function may sleep if pagefaults are
    67	 *          enabled.
    68	 *
    69	 * Checks if a pointer to a block of memory in user space is valid.
    70	 *
    71	 * Returns true (nonzero) if the memory block may be valid, false (zero)
    72	 * if it is definitely invalid.
    73	 *
    74	 * Note that, depending on architecture, this function probably just
    75	 * checks that the pointer is in the user space range - after calling
    76	 * this function, memory access functions may still return -EFAULT.
    77	 */
    78	
    79	static inline int __access_ok(const void __user *p, unsigned long size)
    80	{
    81		unsigned long addr = (unsigned long)p;
  > 82		return (__UA_LIMIT & (addr | (addr + size) | __ua_size(size))) == 0;
    83	}
    84	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--0OAP2g/MAC+5xKAE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--0OAP2g/MAC+5xKAE--
