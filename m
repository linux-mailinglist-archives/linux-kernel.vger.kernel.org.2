Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316913CAEE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 00:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhGOWHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 18:07:24 -0400
Received: from mga06.intel.com ([134.134.136.31]:7293 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhGOWHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 18:07:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="271751567"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="gz'50?scan'50,208,50";a="271751567"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 15:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="gz'50?scan'50,208,50";a="653100623"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2021 15:04:08 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m49Sh-000K0J-N5; Thu, 15 Jul 2021 22:04:07 +0000
Date:   Fri, 16 Jul 2021 06:04:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Fr=E9d=E9ric_Pierret_=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-4.14.y 9785/9999]
 arch/powerpc/kernel/hw_breakpoint.c:106:6: error: no previous prototype for
 'arch_unregister_hw_breakpoint'
Message-ID: <202107160644.EIHoU9h3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Frédéric,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
head:   4416c389d63e76d897a5788f6145f08522cf58b4
commit: a5ef8f46a2ab471eed32a948185a05eac9613b13 [9785/9999] gcc-common.h: Update for GCC 10
config: powerpc64-randconfig-r023-20210715 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=a5ef8f46a2ab471eed32a948185a05eac9613b13
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-4.14.y
        git checkout a5ef8f46a2ab471eed32a948185a05eac9613b13
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:782,
                    from include/linux/gfp.h:6,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:21,
                    from include/linux/device.h:17,
                    from arch/powerpc/include/asm/perf_event_server.h:14,
                    from arch/powerpc/include/asm/perf_event.h:18,
                    from include/linux/perf_event.h:24,
                    from include/linux/hw_breakpoint.h:5,
                    from arch/powerpc/kernel/hw_breakpoint.c:25:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:179:23: error: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Werror=cast-function-type]
     179 |  __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                       ^
   include/linux/timer.h:144:25: note: in definition of macro '__setup_timer'
     144 |   (_timer)->function = (_fn);    \
         |                         ^~~
   arch/powerpc/kernel/hw_breakpoint.c: At top level:
>> arch/powerpc/kernel/hw_breakpoint.c:106:6: error: no previous prototype for 'arch_unregister_hw_breakpoint' [-Werror=missing-prototypes]
     106 | void arch_unregister_hw_breakpoint(struct perf_event *bp)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/hw_breakpoint.c:209:5: error: no previous prototype for 'hw_breakpoint_handler' [-Werror=missing-prototypes]
     209 | int hw_breakpoint_handler(struct die_args *args)
         |     ^~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:16,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:782,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from include/linux/memblock.h:18,
                    from arch/powerpc/kernel/btext.c:11:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:179:23: error: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Werror=cast-function-type]
     179 |  __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                       ^
   include/linux/timer.h:144:25: note: in definition of macro '__setup_timer'
     144 |   (_timer)->function = (_fn);    \
         |                         ^~~
   arch/powerpc/kernel/btext.c: At top level:
>> arch/powerpc/kernel/btext.c:173:5: error: no previous prototype for 'btext_initialize' [-Werror=missing-prototypes]
     173 | int btext_initialize(struct device_node *np)
         |     ^~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
   In file included from include/linux/workqueue.h:9,
                    from include/linux/srcu.h:34,
                    from include/linux/notifier.h:16,
                    from arch/powerpc/include/asm/uprobes.h:25,
                    from include/linux/uprobes.h:62,
                    from include/linux/mm_types.h:14,
                    from include/linux/fs.h:22,
                    from include/linux/debugfs.h:18,
                    from arch/powerpc/mm/dump_hashpagetable.c:16:
   include/linux/timer.h: In function 'timer_setup':
   include/linux/timer.h:179:23: error: cast between incompatible function types from 'void (*)(struct timer_list *)' to 'void (*)(long unsigned int)' [-Werror=cast-function-type]
     179 |  __setup_timer(timer, (TIMER_FUNC_TYPE)callback,
         |                       ^
   include/linux/timer.h:144:25: note: in definition of macro '__setup_timer'
     144 |   (_timer)->function = (_fn);    \
         |                         ^~~
   In file included from arch/powerpc/mm/dump_hashpagetable.c:27:
   arch/powerpc/include/asm/plpar_wrappers.h: In function 'get_cede_latency_hint':
>> arch/powerpc/include/asm/plpar_wrappers.h:27:9: error: implicit declaration of function 'get_lppaca'; did you mean 'get_page'? [-Werror=implicit-function-declaration]
      27 |  return get_lppaca()->cede_latency_hint;
         |         ^~~~~~~~~~
         |         get_page
>> arch/powerpc/include/asm/plpar_wrappers.h:27:21: error: invalid type argument of '->' (have 'int')
      27 |  return get_lppaca()->cede_latency_hint;
         |                     ^~
   arch/powerpc/include/asm/plpar_wrappers.h: In function 'set_cede_latency_hint':
   arch/powerpc/include/asm/plpar_wrappers.h:32:14: error: invalid type argument of '->' (have 'int')
      32 |  get_lppaca()->cede_latency_hint = latency_hint;
         |              ^~
   arch/powerpc/include/asm/plpar_wrappers.h: In function 'extended_cede_processor':
>> arch/powerpc/include/asm/plpar_wrappers.h:51:4: error: implicit declaration of function '__hard_irq_enable'; did you mean 'may_hard_irq_enable'? [-Werror=implicit-function-declaration]
      51 |    __hard_irq_enable();
         |    ^~~~~~~~~~~~~~~~~
         |    may_hard_irq_enable
   arch/powerpc/include/asm/plpar_wrappers.h: In function 'vpa_call':
>> arch/powerpc/include/asm/plpar_wrappers.h:62:16: error: left shift count >= width of type [-Werror=shift-count-overflow]
      62 |  flags = flags << H_VPA_FUNC_SHIFT;
         |                ^~
   In file included from arch/powerpc/include/asm/plpar_wrappers.h:8,
                    from arch/powerpc/mm/dump_hashpagetable.c:27:
   arch/powerpc/include/asm/plpar_wrappers.h: In function 'plpar_pte_read_4':
>> arch/powerpc/include/asm/hvcall.h:120:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
     120 | #define H_READ_4  (1UL<<(63-26)) /* Return 4 PTEs */
         |                       ^~
   arch/powerpc/include/asm/plpar_wrappers.h:183:44: note: in expansion of macro 'H_READ_4'
     183 |  rc = plpar_hcall9(H_READ, retbuf, flags | H_READ_4, ptex);
         |                                            ^~~~~~~~
   arch/powerpc/include/asm/plpar_wrappers.h: In function 'plpar_pte_read_4_raw':
>> arch/powerpc/include/asm/hvcall.h:120:23: error: left shift count >= width of type [-Werror=shift-count-overflow]
     120 | #define H_READ_4  (1UL<<(63-26)) /* Return 4 PTEs */
         |                       ^~
   arch/powerpc/include/asm/plpar_wrappers.h:201:48: note: in expansion of macro 'H_READ_4'
     201 |  rc = plpar_hcall9_raw(H_READ, retbuf, flags | H_READ_4, ptex);
         |                                                ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c: At top level:
>> arch/powerpc/mm/dump_hashpagetable.c:69:13: error: 'SLB_VSID_B' undeclared here (not in a function)
      69 |   .mask   = SLB_VSID_B,
         |             ^~~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:70:13: error: 'SLB_VSID_B_256M' undeclared here (not in a function)
      70 |   .val    = SLB_VSID_B_256M,
         |             ^~~~~~~~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:74:11: error: 'HPTE_V_SECONDARY' undeclared here (not in a function)
      74 |   .mask = HPTE_V_SECONDARY,
         |           ^~~~~~~~~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:79:11: error: 'HPTE_V_VALID' undeclared here (not in a function)
      79 |   .mask = HPTE_V_VALID,
         |           ^~~~~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:84:11: error: 'HPTE_V_BOLTED' undeclared here (not in a function)
      84 |   .mask = HPTE_V_BOLTED,
         |           ^~~~~~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:93:11: error: 'HPTE_R_PP0' undeclared here (not in a function)
      93 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ^~~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:93:24: error: 'HPTE_R_PP' undeclared here (not in a function)
      93 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |                        ^~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:93:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
      93 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ~~~~~~~~~~ ^
         |           |          |
         |           |          const struct flag_info *
         |           const struct flag_info *
>> arch/powerpc/mm/dump_hashpagetable.c:93:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
      93 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ^~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:93:11: note: (near initialization for 'r_flag_array[0].mask')
>> arch/powerpc/mm/dump_hashpagetable.c:93:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:93:11: note: (near initialization for 'r_flag_array[0].mask')
   arch/powerpc/mm/dump_hashpagetable.c:97:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
      97 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ~~~~~~~~~~ ^
         |           |          |
         |           |          const struct flag_info *
         |           const struct flag_info *
   arch/powerpc/mm/dump_hashpagetable.c:97:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
      97 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ^~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:97:11: note: (near initialization for 'r_flag_array[1].mask')
   arch/powerpc/mm/dump_hashpagetable.c:97:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:97:11: note: (near initialization for 'r_flag_array[1].mask')
   arch/powerpc/mm/dump_hashpagetable.c:101:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
     101 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ~~~~~~~~~~ ^
         |           |          |
         |           |          const struct flag_info *
         |           const struct flag_info *
   arch/powerpc/mm/dump_hashpagetable.c:101:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     101 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ^~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:101:11: note: (near initialization for 'r_flag_array[2].mask')
   arch/powerpc/mm/dump_hashpagetable.c:101:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:101:11: note: (near initialization for 'r_flag_array[2].mask')
   arch/powerpc/mm/dump_hashpagetable.c:105:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
     105 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ~~~~~~~~~~ ^
         |           |          |
         |           |          const struct flag_info *
         |           const struct flag_info *
   arch/powerpc/mm/dump_hashpagetable.c:105:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     105 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ^~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:105:11: note: (near initialization for 'r_flag_array[3].mask')
   arch/powerpc/mm/dump_hashpagetable.c:105:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:105:11: note: (near initialization for 'r_flag_array[3].mask')
   arch/powerpc/mm/dump_hashpagetable.c:109:22: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
     109 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ~~~~~~~~~~ ^
         |           |          |
         |           |          const struct flag_info *
         |           const struct flag_info *
   arch/powerpc/mm/dump_hashpagetable.c:109:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     109 |   .mask = HPTE_R_PP0 | HPTE_R_PP,
         |           ^~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:109:11: note: (near initialization for 'r_flag_array[4].mask')
   arch/powerpc/mm/dump_hashpagetable.c:109:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:109:11: note: (near initialization for 'r_flag_array[4].mask')
>> arch/powerpc/mm/dump_hashpagetable.c:110:10: error: 'PP_RXXX' undeclared here (not in a function); did you mean 'PP_RXRX'?
     110 |   .val = PP_RXXX,
         |          ^~~~~~~
         |          PP_RXRX
   arch/powerpc/mm/dump_hashpagetable.c:110:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:110:10: note: (near initialization for 'r_flag_array[4].val')
   arch/powerpc/mm/dump_hashpagetable.c:110:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:110:10: note: (near initialization for 'r_flag_array[4].val')
>> arch/powerpc/mm/dump_hashpagetable.c:113:11: error: 'HPTE_R_KEY_HI' undeclared here (not in a function)
     113 |   .mask = HPTE_R_KEY_HI | HPTE_R_KEY_LO,
         |           ^~~~~~~~~~~~~
>> arch/powerpc/mm/dump_hashpagetable.c:113:27: error: 'HPTE_R_KEY_LO' undeclared here (not in a function)
     113 |   .mask = HPTE_R_KEY_HI | HPTE_R_KEY_LO,
         |                           ^~~~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:113:25: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
     113 |   .mask = HPTE_R_KEY_HI | HPTE_R_KEY_LO,
         |           ~~~~~~~~~~~~~ ^
         |           |             |
         |           |             const struct flag_info *
         |           const struct flag_info *
   arch/powerpc/mm/dump_hashpagetable.c:113:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     113 |   .mask = HPTE_R_KEY_HI | HPTE_R_KEY_LO,
         |           ^~~~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:113:11: note: (near initialization for 'r_flag_array[5].mask')
   arch/powerpc/mm/dump_hashpagetable.c:113:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:113:11: note: (near initialization for 'r_flag_array[5].mask')
   arch/powerpc/mm/dump_hashpagetable.c:114:24: error: invalid operands to binary | (have 'const struct flag_info *' and 'const struct flag_info *')
     114 |   .val = HPTE_R_KEY_HI | HPTE_R_KEY_LO,
         |          ~~~~~~~~~~~~~ ^
         |          |             |
         |          |             const struct flag_info *
         |          const struct flag_info *
   arch/powerpc/mm/dump_hashpagetable.c:114:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     114 |   .val = HPTE_R_KEY_HI | HPTE_R_KEY_LO,
         |          ^~~~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:114:10: note: (near initialization for 'r_flag_array[5].val')
   arch/powerpc/mm/dump_hashpagetable.c:114:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:114:10: note: (near initialization for 'r_flag_array[5].val')
>> arch/powerpc/mm/dump_hashpagetable.c:119:11: error: 'HPTE_R_R' undeclared here (not in a function)
     119 |   .mask = HPTE_R_R,
         |           ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:119:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:119:11: note: (near initialization for 'r_flag_array[6].mask')
   arch/powerpc/mm/dump_hashpagetable.c:119:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:119:11: note: (near initialization for 'r_flag_array[6].mask')
   arch/powerpc/mm/dump_hashpagetable.c:120:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     120 |   .val = HPTE_R_R,
         |          ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:120:10: note: (near initialization for 'r_flag_array[6].val')
   arch/powerpc/mm/dump_hashpagetable.c:120:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:120:10: note: (near initialization for 'r_flag_array[6].val')
   arch/powerpc/mm/dump_hashpagetable.c:124:11: error: 'HPTE_R_C' undeclared here (not in a function)
     124 |   .mask = HPTE_R_C,
         |           ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:124:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:124:11: note: (near initialization for 'r_flag_array[7].mask')
   arch/powerpc/mm/dump_hashpagetable.c:124:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:124:11: note: (near initialization for 'r_flag_array[7].mask')
   arch/powerpc/mm/dump_hashpagetable.c:125:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     125 |   .val = HPTE_R_C,
         |          ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:125:10: note: (near initialization for 'r_flag_array[7].val')
   arch/powerpc/mm/dump_hashpagetable.c:125:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:125:10: note: (near initialization for 'r_flag_array[7].val')
   arch/powerpc/mm/dump_hashpagetable.c:129:11: error: 'HPTE_R_N' undeclared here (not in a function)
     129 |   .mask = HPTE_R_N,
         |           ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:129:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:129:11: note: (near initialization for 'r_flag_array[8].mask')
   arch/powerpc/mm/dump_hashpagetable.c:129:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:129:11: note: (near initialization for 'r_flag_array[8].mask')
   arch/powerpc/mm/dump_hashpagetable.c:130:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     130 |   .val = HPTE_R_N,
         |          ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:130:10: note: (near initialization for 'r_flag_array[8].val')
   arch/powerpc/mm/dump_hashpagetable.c:130:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:130:10: note: (near initialization for 'r_flag_array[8].val')
   arch/powerpc/mm/dump_hashpagetable.c:133:11: error: 'HPTE_R_WIMG' undeclared here (not in a function)
     133 |   .mask = HPTE_R_WIMG,
         |           ^~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:133:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:133:11: note: (near initialization for 'r_flag_array[9].mask')
   arch/powerpc/mm/dump_hashpagetable.c:133:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:133:11: note: (near initialization for 'r_flag_array[9].mask')
   arch/powerpc/mm/dump_hashpagetable.c:134:10: error: 'HPTE_R_W' undeclared here (not in a function)
     134 |   .val = HPTE_R_W,
         |          ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:134:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:134:10: note: (near initialization for 'r_flag_array[9].val')
   arch/powerpc/mm/dump_hashpagetable.c:134:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:134:10: note: (near initialization for 'r_flag_array[9].val')
   arch/powerpc/mm/dump_hashpagetable.c:137:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     137 |   .mask = HPTE_R_WIMG,
         |           ^~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:137:11: note: (near initialization for 'r_flag_array[10].mask')
   arch/powerpc/mm/dump_hashpagetable.c:137:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:137:11: note: (near initialization for 'r_flag_array[10].mask')
   arch/powerpc/mm/dump_hashpagetable.c:138:10: error: 'HPTE_R_I' undeclared here (not in a function)
     138 |   .val = HPTE_R_I,
         |          ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:138:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:138:10: note: (near initialization for 'r_flag_array[10].val')
   arch/powerpc/mm/dump_hashpagetable.c:138:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:138:10: note: (near initialization for 'r_flag_array[10].val')
   arch/powerpc/mm/dump_hashpagetable.c:141:11: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
     141 |   .mask = HPTE_R_WIMG,
         |           ^~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:141:11: note: (near initialization for 'r_flag_array[11].mask')
   arch/powerpc/mm/dump_hashpagetable.c:141:11: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:141:11: note: (near initialization for 'r_flag_array[11].mask')
   arch/powerpc/mm/dump_hashpagetable.c:142:10: error: 'HPTE_R_G' undeclared here (not in a function)
     142 |   .val = HPTE_R_G,
         |          ^~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:142:10: error: initialization of 'long long unsigned int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:142:10: note: (near initialization for 'r_flag_array[11].val')
   arch/powerpc/mm/dump_hashpagetable.c:142:10: error: initializer element is not constant
   arch/powerpc/mm/dump_hashpagetable.c:142:10: note: (near initialization for 'r_flag_array[11].val')
   arch/powerpc/mm/dump_hashpagetable.c: In function 'dump_hpte_info':
   arch/powerpc/mm/dump_hashpagetable.c:199:37: error: implicit declaration of function 'HPTE_V_AVPN_VAL' [-Werror=implicit-function-declaration]
     199 |  seq_printf(st->seq, "AVPN:%llx\t", HPTE_V_AVPN_VAL(v));
         |                                     ^~~~~~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:199:31: error: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'int' [-Werror=format=]
     199 |  seq_printf(st->seq, "AVPN:%llx\t", HPTE_V_AVPN_VAL(v));
         |                            ~~~^     ~~~~~~~~~~~~~~~~~~
         |                               |     |
         |                               |     int
         |                               long long unsigned int
         |                            %x
   arch/powerpc/mm/dump_hashpagetable.c: In function 'native_find':
   arch/powerpc/mm/dump_hashpagetable.c:217:17: error: 'mmu_kernel_ssize' undeclared (first use in this function)
     217 |  int i, ssize = mmu_kernel_ssize;
         |                 ^~~~~~~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:217:17: note: each undeclared identifier is reported only once for each function it appears in
   arch/powerpc/mm/dump_hashpagetable.c:217:17: error: initialization of 'int' from 'const struct flag_info *' makes integer from pointer without a cast [-Werror=int-conversion]
   arch/powerpc/mm/dump_hashpagetable.c:218:24: error: 'mmu_psize_defs' undeclared (first use in this function)
     218 |  unsigned long shift = mmu_psize_defs[psize].shift;
         |                        ^~~~~~~~~~~~~~
   arch/powerpc/mm/dump_hashpagetable.c:221:9: error: implicit declaration of function 'get_kernel_vsid'; did you mean 'get_kernel_page'? [-Werror=implicit-function-declaration]
     221 |  vsid = get_kernel_vsid(ea, ssize);
..


vim +/arch_unregister_hw_breakpoint +106 arch/powerpc/kernel/hw_breakpoint.c

5aae8a53708025 K.Prasad          2010-06-15  101  
5aae8a53708025 K.Prasad          2010-06-15  102  /*
5aae8a53708025 K.Prasad          2010-06-15  103   * Perform cleanup of arch-specific counters during unregistration
5aae8a53708025 K.Prasad          2010-06-15  104   * of the perf-event
5aae8a53708025 K.Prasad          2010-06-15  105   */
5aae8a53708025 K.Prasad          2010-06-15 @106  void arch_unregister_hw_breakpoint(struct perf_event *bp)
5aae8a53708025 K.Prasad          2010-06-15  107  {
5aae8a53708025 K.Prasad          2010-06-15  108  	/*
5aae8a53708025 K.Prasad          2010-06-15  109  	 * If the breakpoint is unregistered between a hw_breakpoint_handler()
5aae8a53708025 K.Prasad          2010-06-15  110  	 * and the single_step_dabr_instruction(), then cleanup the breakpoint
5aae8a53708025 K.Prasad          2010-06-15  111  	 * restoration variables to prevent dangling pointers.
fb822e6076d972 Ravi Bangoria     2016-03-02  112  	 * FIXME, this should not be using bp->ctx at all! Sayeth peterz.
5aae8a53708025 K.Prasad          2010-06-15  113  	 */
fb822e6076d972 Ravi Bangoria     2016-03-02  114  	if (bp->ctx && bp->ctx->task && bp->ctx->task != ((void *)-1L))
5aae8a53708025 K.Prasad          2010-06-15  115  		bp->ctx->task->thread.last_hit_ubp = NULL;
5aae8a53708025 K.Prasad          2010-06-15  116  }
5aae8a53708025 K.Prasad          2010-06-15  117  
5aae8a53708025 K.Prasad          2010-06-15  118  /*
5aae8a53708025 K.Prasad          2010-06-15  119   * Check for virtual address in kernel space.
5aae8a53708025 K.Prasad          2010-06-15  120   */
5aae8a53708025 K.Prasad          2010-06-15  121  int arch_check_bp_in_kernelspace(struct perf_event *bp)
5aae8a53708025 K.Prasad          2010-06-15  122  {
5aae8a53708025 K.Prasad          2010-06-15  123  	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
5aae8a53708025 K.Prasad          2010-06-15  124  
5aae8a53708025 K.Prasad          2010-06-15  125  	return is_kernel_addr(info->address);
5aae8a53708025 K.Prasad          2010-06-15  126  }
5aae8a53708025 K.Prasad          2010-06-15  127  
5aae8a53708025 K.Prasad          2010-06-15  128  int arch_bp_generic_fields(int type, int *gen_bp_type)
5aae8a53708025 K.Prasad          2010-06-15  129  {
9422de3e953d0e Michael Neuling   2012-12-20  130  	*gen_bp_type = 0;
9422de3e953d0e Michael Neuling   2012-12-20  131  	if (type & HW_BRK_TYPE_READ)
9422de3e953d0e Michael Neuling   2012-12-20  132  		*gen_bp_type |= HW_BREAKPOINT_R;
9422de3e953d0e Michael Neuling   2012-12-20  133  	if (type & HW_BRK_TYPE_WRITE)
9422de3e953d0e Michael Neuling   2012-12-20  134  		*gen_bp_type |= HW_BREAKPOINT_W;
9422de3e953d0e Michael Neuling   2012-12-20  135  	if (*gen_bp_type == 0)
5aae8a53708025 K.Prasad          2010-06-15  136  		return -EINVAL;
5aae8a53708025 K.Prasad          2010-06-15  137  	return 0;
5aae8a53708025 K.Prasad          2010-06-15  138  }
5aae8a53708025 K.Prasad          2010-06-15  139  
5aae8a53708025 K.Prasad          2010-06-15  140  /*
5aae8a53708025 K.Prasad          2010-06-15  141   * Validate the arch-specific HW Breakpoint register settings
5aae8a53708025 K.Prasad          2010-06-15  142   */
5aae8a53708025 K.Prasad          2010-06-15  143  int arch_validate_hwbkpt_settings(struct perf_event *bp)
5aae8a53708025 K.Prasad          2010-06-15  144  {
4ae7ebe9522a9e Michael Neuling   2013-01-24  145  	int ret = -EINVAL, length_max;
5aae8a53708025 K.Prasad          2010-06-15  146  	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
5aae8a53708025 K.Prasad          2010-06-15  147  
5aae8a53708025 K.Prasad          2010-06-15  148  	if (!bp)
5aae8a53708025 K.Prasad          2010-06-15  149  		return ret;
5aae8a53708025 K.Prasad          2010-06-15  150  
9422de3e953d0e Michael Neuling   2012-12-20  151  	info->type = HW_BRK_TYPE_TRANSLATE;
9422de3e953d0e Michael Neuling   2012-12-20  152  	if (bp->attr.bp_type & HW_BREAKPOINT_R)
9422de3e953d0e Michael Neuling   2012-12-20  153  		info->type |= HW_BRK_TYPE_READ;
9422de3e953d0e Michael Neuling   2012-12-20  154  	if (bp->attr.bp_type & HW_BREAKPOINT_W)
9422de3e953d0e Michael Neuling   2012-12-20  155  		info->type |= HW_BRK_TYPE_WRITE;
9422de3e953d0e Michael Neuling   2012-12-20  156  	if (info->type == HW_BRK_TYPE_TRANSLATE)
9422de3e953d0e Michael Neuling   2012-12-20  157  		/* must set alteast read or write */
5aae8a53708025 K.Prasad          2010-06-15  158  		return ret;
9422de3e953d0e Michael Neuling   2012-12-20  159  	if (!(bp->attr.exclude_user))
9422de3e953d0e Michael Neuling   2012-12-20  160  		info->type |= HW_BRK_TYPE_USER;
9422de3e953d0e Michael Neuling   2012-12-20  161  	if (!(bp->attr.exclude_kernel))
9422de3e953d0e Michael Neuling   2012-12-20  162  		info->type |= HW_BRK_TYPE_KERNEL;
9422de3e953d0e Michael Neuling   2012-12-20  163  	if (!(bp->attr.exclude_hv))
9422de3e953d0e Michael Neuling   2012-12-20  164  		info->type |= HW_BRK_TYPE_HYP;
5aae8a53708025 K.Prasad          2010-06-15  165  	info->address = bp->attr.bp_addr;
5aae8a53708025 K.Prasad          2010-06-15  166  	info->len = bp->attr.bp_len;
5aae8a53708025 K.Prasad          2010-06-15  167  
5aae8a53708025 K.Prasad          2010-06-15  168  	/*
5aae8a53708025 K.Prasad          2010-06-15  169  	 * Since breakpoint length can be a maximum of HW_BREAKPOINT_LEN(8)
5aae8a53708025 K.Prasad          2010-06-15  170  	 * and breakpoint addresses are aligned to nearest double-word
5aae8a53708025 K.Prasad          2010-06-15  171  	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
5aae8a53708025 K.Prasad          2010-06-15  172  	 * 'symbolsize' should satisfy the check below.
5aae8a53708025 K.Prasad          2010-06-15  173  	 */
4ae7ebe9522a9e Michael Neuling   2013-01-24  174  	length_max = 8; /* DABR */
4ae7ebe9522a9e Michael Neuling   2013-01-24  175  	if (cpu_has_feature(CPU_FTR_DAWR)) {
4ae7ebe9522a9e Michael Neuling   2013-01-24  176  		length_max = 512 ; /* 64 doublewords */
4ae7ebe9522a9e Michael Neuling   2013-01-24  177  		/* DAWR region can't cross 512 boundary */
919c9b8187bc8a Michael Neuling   2018-05-17  178  		if ((bp->attr.bp_addr >> 9) !=
919c9b8187bc8a Michael Neuling   2018-05-17  179  		    ((bp->attr.bp_addr + bp->attr.bp_len - 1) >> 9))
4ae7ebe9522a9e Michael Neuling   2013-01-24  180  			return -EINVAL;
4ae7ebe9522a9e Michael Neuling   2013-01-24  181  	}
5aae8a53708025 K.Prasad          2010-06-15  182  	if (info->len >
4ae7ebe9522a9e Michael Neuling   2013-01-24  183  	    (length_max - (info->address & HW_BREAKPOINT_ALIGN)))
5aae8a53708025 K.Prasad          2010-06-15  184  		return -EINVAL;
5aae8a53708025 K.Prasad          2010-06-15  185  	return 0;
5aae8a53708025 K.Prasad          2010-06-15  186  }
5aae8a53708025 K.Prasad          2010-06-15  187  
06532a6743d83f K.Prasad          2010-06-15  188  /*
06532a6743d83f K.Prasad          2010-06-15  189   * Restores the breakpoint on the debug registers.
06532a6743d83f K.Prasad          2010-06-15  190   * Invoke this function if it is known that the execution context is
06532a6743d83f K.Prasad          2010-06-15  191   * about to change to cause loss of MSR_SE settings.
06532a6743d83f K.Prasad          2010-06-15  192   */
06532a6743d83f K.Prasad          2010-06-15  193  void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
06532a6743d83f K.Prasad          2010-06-15  194  {
06532a6743d83f K.Prasad          2010-06-15  195  	struct arch_hw_breakpoint *info;
06532a6743d83f K.Prasad          2010-06-15  196  
06532a6743d83f K.Prasad          2010-06-15  197  	if (likely(!tsk->thread.last_hit_ubp))
06532a6743d83f K.Prasad          2010-06-15  198  		return;
06532a6743d83f K.Prasad          2010-06-15  199  
06532a6743d83f K.Prasad          2010-06-15  200  	info = counter_arch_bp(tsk->thread.last_hit_ubp);
06532a6743d83f K.Prasad          2010-06-15  201  	regs->msr &= ~MSR_SE;
21f585073d6347 Paul Gortmaker    2014-04-29  202  	__set_breakpoint(info);
06532a6743d83f K.Prasad          2010-06-15  203  	tsk->thread.last_hit_ubp = NULL;
06532a6743d83f K.Prasad          2010-06-15  204  }
06532a6743d83f K.Prasad          2010-06-15  205  
5aae8a53708025 K.Prasad          2010-06-15  206  /*
5aae8a53708025 K.Prasad          2010-06-15  207   * Handle debug exception notifications.
5aae8a53708025 K.Prasad          2010-06-15  208   */
03465f899bdac7 Nicholas Piggin   2016-09-16 @209  int hw_breakpoint_handler(struct die_args *args)
5aae8a53708025 K.Prasad          2010-06-15  210  {
5aae8a53708025 K.Prasad          2010-06-15  211  	int rc = NOTIFY_STOP;
5aae8a53708025 K.Prasad          2010-06-15  212  	struct perf_event *bp;
5aae8a53708025 K.Prasad          2010-06-15  213  	struct pt_regs *regs = args->regs;
4ad8622dc54895 Christophe Leroy  2016-11-29  214  #ifndef CONFIG_PPC_8xx
5aae8a53708025 K.Prasad          2010-06-15  215  	int stepped = 1;
5aae8a53708025 K.Prasad          2010-06-15  216  	unsigned int instr;
4ad8622dc54895 Christophe Leroy  2016-11-29  217  #endif
4ad8622dc54895 Christophe Leroy  2016-11-29  218  	struct arch_hw_breakpoint *info;
e3e94084adb561 K.Prasad          2010-06-15  219  	unsigned long dar = regs->dar;
5aae8a53708025 K.Prasad          2010-06-15  220  
5aae8a53708025 K.Prasad          2010-06-15  221  	/* Disable breakpoints during exception handling */
9422de3e953d0e Michael Neuling   2012-12-20  222  	hw_breakpoint_disable();
574cb24899d35e Paul Mackerras    2010-06-23  223  
5aae8a53708025 K.Prasad          2010-06-15  224  	/*
5aae8a53708025 K.Prasad          2010-06-15  225  	 * The counter may be concurrently released but that can only
5aae8a53708025 K.Prasad          2010-06-15  226  	 * occur from a call_rcu() path. We can then safely fetch
5aae8a53708025 K.Prasad          2010-06-15  227  	 * the breakpoint, use its callback, touch its counter
5aae8a53708025 K.Prasad          2010-06-15  228  	 * while we are in an rcu_read_lock() path.
5aae8a53708025 K.Prasad          2010-06-15  229  	 */
5aae8a53708025 K.Prasad          2010-06-15  230  	rcu_read_lock();
5aae8a53708025 K.Prasad          2010-06-15  231  
69111bac42f5ce Christoph Lameter 2014-10-21  232  	bp = __this_cpu_read(bp_per_reg);
c21a493a2b4465 Ravi Bangoria     2016-11-22  233  	if (!bp) {
c21a493a2b4465 Ravi Bangoria     2016-11-22  234  		rc = NOTIFY_DONE;
5aae8a53708025 K.Prasad          2010-06-15  235  		goto out;
c21a493a2b4465 Ravi Bangoria     2016-11-22  236  	}
5aae8a53708025 K.Prasad          2010-06-15  237  	info = counter_arch_bp(bp);
5aae8a53708025 K.Prasad          2010-06-15  238  
5aae8a53708025 K.Prasad          2010-06-15  239  	/*
5aae8a53708025 K.Prasad          2010-06-15  240  	 * Return early after invoking user-callback function without restoring
5aae8a53708025 K.Prasad          2010-06-15  241  	 * DABR if the breakpoint is from ptrace which always operates in
5aae8a53708025 K.Prasad          2010-06-15  242  	 * one-shot mode. The ptrace-ed process will receive the SIGTRAP signal
5aae8a53708025 K.Prasad          2010-06-15  243  	 * generated in do_dabr().
5aae8a53708025 K.Prasad          2010-06-15  244  	 */
574cb24899d35e Paul Mackerras    2010-06-23  245  	if (bp->overflow_handler == ptrace_triggered) {
5aae8a53708025 K.Prasad          2010-06-15  246  		perf_bp_event(bp, regs);
5aae8a53708025 K.Prasad          2010-06-15  247  		rc = NOTIFY_DONE;
5aae8a53708025 K.Prasad          2010-06-15  248  		goto out;
5aae8a53708025 K.Prasad          2010-06-15  249  	}
5aae8a53708025 K.Prasad          2010-06-15  250  
e3e94084adb561 K.Prasad          2010-06-15  251  	/*
e3e94084adb561 K.Prasad          2010-06-15  252  	 * Verify if dar lies within the address range occupied by the symbol
574cb24899d35e Paul Mackerras    2010-06-23  253  	 * being watched to filter extraneous exceptions.  If it doesn't,
574cb24899d35e Paul Mackerras    2010-06-23  254  	 * we still need to single-step the instruction, but we don't
574cb24899d35e Paul Mackerras    2010-06-23  255  	 * generate an event.
e3e94084adb561 K.Prasad          2010-06-15  256  	 */
540e07c67efe42 Michael Neuling   2013-06-24  257  	info->type &= ~HW_BRK_TYPE_EXTRANEOUS_IRQ;
9422de3e953d0e Michael Neuling   2012-12-20  258  	if (!((bp->attr.bp_addr <= dar) &&
9422de3e953d0e Michael Neuling   2012-12-20  259  	      (dar - bp->attr.bp_addr < bp->attr.bp_len)))
9422de3e953d0e Michael Neuling   2012-12-20  260  		info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
e3e94084adb561 K.Prasad          2010-06-15  261  

:::::: The code at line 106 was first introduced by commit
:::::: 5aae8a53708025d4e718f0d2e7c2f766779ddc71 powerpc, hw_breakpoints: Implement hw_breakpoints for 64-bit server processors

:::::: TO: K.Prasad <prasad@linux.vnet.ibm.com>
:::::: CC: Paul Mackerras <paulus@samba.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
HC7O8XR1Lrvr6H/SrtA6pn8BAA==

--jRHKVT23PllUwdXP--
