Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5E83ACA68
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 13:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhFRLwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 07:52:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:63850 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232258AbhFRLwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 07:52:11 -0400
IronPort-SDR: ktwE89KqzhkULHKFCJyxQqikpmIZLOJKZL1+H52v1cxWOPWk01TAA7eWkuu9tjosMTivaVv6Sx
 LTYeIon9vNyQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206580086"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="gz'50?scan'50,208,50";a="206580086"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 04:50:01 -0700
IronPort-SDR: LWjS39Ar4KaJTgfFgtM2pHCdW6pEKAfonr3uhEwQTFOC4hb5Fote63C28G3L2YA++W9cRkOoZU
 ndVPkPMtVlgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="gz'50?scan'50,208,50";a="638132382"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 18 Jun 2021 04:49:57 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1luD0X-0002rU-2i; Fri, 18 Jun 2021 11:49:57 +0000
Date:   Fri, 18 Jun 2021 19:48:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <202106181930.0rU3pZgm-lkp@intel.com>
References: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chris,

I love your patch! Yet something to improve:

[auto build test ERROR on jeyu/modules-next]
[also build test ERROR on linux/master soc/for-next openrisc/for-next powerpc/next uml/linux-next asm-generic/master driver-core/driver-core-testing linus/master v5.13-rc6 next-20210617]
[cannot apply to tip/x86/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chris-Down/printk-Userspace-format-indexing-support/20210617-101450
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux.git modules-next
config: ia64-randconfig-s031-20210618 (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://github.com/0day-ci/linux/commit/819166a91ddffdbf04d0b4e6905a5ab3b568194f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chris-Down/printk-Userspace-format-indexing-support/20210617-101450
        git checkout 819166a91ddffdbf04d0b4e6905a5ab3b568194f
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:17,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/printk.h:219:5: error: static declaration of '_printk' follows non-static declaration
     219 | int _printk(const char *s, ...)
         |     ^~~~~~~
   In file included from arch/ia64/include/uapi/asm/intrinsics.h:22,
                    from arch/ia64/include/asm/intrinsics.h:11,
                    from arch/ia64/include/asm/bitops.h:19,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:12,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of '_printk' was here
     142 |   extern int _printk(const char *fmt, ...);  \
         |              ^~~~~~~
   arch/ia64/include/asm/bitops.h:309:3: note: in expansion of macro 'CMPXCHG_BUGCHECK'
     309 |   CMPXCHG_BUGCHECK(m);
         |   ^~~~~~~~~~~~~~~~
--
   In file included from include/linux/kernel.h:17,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
>> include/linux/printk.h:219:5: error: static declaration of '_printk' follows non-static declaration
     219 | int _printk(const char *s, ...)
         |     ^~~~~~~
   In file included from arch/ia64/include/uapi/asm/intrinsics.h:22,
                    from arch/ia64/include/asm/intrinsics.h:11,
                    from arch/ia64/include/asm/bitops.h:19,
                    from include/linux/bitops.h:32,
                    from include/linux/kernel.h:12,
                    from include/asm-generic/bug.h:20,
                    from arch/ia64/include/asm/bug.h:17,
                    from include/linux/bug.h:5,
                    from include/linux/page-flags.h:10,
                    from kernel/bounds.c:10:
   arch/ia64/include/uapi/asm/cmpxchg.h:142:14: note: previous declaration of '_printk' was here
     142 |   extern int _printk(const char *fmt, ...);  \
         |              ^~~~~~~
   arch/ia64/include/asm/bitops.h:309:3: note: in expansion of macro 'CMPXCHG_BUGCHECK'
     309 |   CMPXCHG_BUGCHECK(m);
         |   ^~~~~~~~~~~~~~~~
   make[2]: *** [scripts/Makefile.build:117: kernel/bounds.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1227: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +/_printk +219 include/linux/printk.h

   201	
   202	char *log_buf_addr_get(void);
   203	u32 log_buf_len_get(void);
   204	void log_buf_vmcoreinfo_setup(void);
   205	void __init setup_log_buf(int early);
   206	__printf(1, 2) void dump_stack_set_arch_desc(const char *fmt, ...);
   207	void dump_stack_print_info(const char *log_lvl);
   208	void show_regs_print_info(const char *log_lvl);
   209	extern asmlinkage void dump_stack(void) __cold;
   210	extern void printk_safe_flush(void);
   211	extern void printk_safe_flush_on_panic(void);
   212	#else
   213	static inline __printf(1, 0)
   214	int vprintk(const char *s, va_list args)
   215	{
   216		return 0;
   217	}
   218	static inline __printf(1, 2) __cold
 > 219	int _printk(const char *s, ...)
   220	{
   221		return 0;
   222	}
   223	static inline __printf(1, 2) __cold
   224	int _printk_deferred(const char *s, ...)
   225	{
   226		return 0;
   227	}
   228	static inline int printk_ratelimit(void)
   229	{
   230		return 0;
   231	}
   232	static inline bool printk_timed_ratelimit(unsigned long *caller_jiffies,
   233						  unsigned int interval_msec)
   234	{
   235		return false;
   236	}
   237	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fdj2RfSjLxBAspz7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9Ow7IXbaUfJ/lEMUkTaqAQA=

--fdj2RfSjLxBAspz7--
