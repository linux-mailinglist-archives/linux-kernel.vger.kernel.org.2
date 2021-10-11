Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341BC42989C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 23:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbhJKVJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 17:09:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:41745 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235137AbhJKVJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 17:09:47 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="250362123"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="gz'50?scan'50,208,50";a="250362123"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 14:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="gz'50?scan'50,208,50";a="591475904"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2021 14:07:44 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ma2WN-0002j1-TE; Mon, 11 Oct 2021 21:07:43 +0000
Date:   Tue, 12 Oct 2021 05:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/uaccess/rework 11/19] arch/arm64/kernel/traps.c:413:7:
 warning: value size does not match register size specified by the constraint
 and modifier
Message-ID: <202110120517.KnczQXSR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/uaccess/rework
head:   692de878f919de31942d0d28571b5e6f32c7135e
commit: c3579cc9e5be2d67027753c6bc44a28168f6377c [11/19] arm64: add fixup handler for uaccess primitives
config: arm64-randconfig-r033-20211011 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f95d9c95bbf4cf662b9a181245fc6dcede39f590)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=c3579cc9e5be2d67027753c6bc44a28168f6377c
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/uaccess/rework
        git checkout c3579cc9e5be2d67027753c6bc44a28168f6377c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=arm64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:267:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "b", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:10:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:270:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "h", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:20:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:273:45: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr, "%w", __gu_val, (ptr), (err));       \
                                                             ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:30:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:276:46: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr, "%x",  __gu_val, (ptr), (err));      \
                                                              ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:40:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:267:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "b", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:10:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:270:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "h", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:20:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:273:45: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr, "%w", __gu_val, (ptr), (err));       \
                                                             ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:30:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:276:46: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr, "%x",  __gu_val, (ptr), (err));      \
                                                              ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:40:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:267:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "b", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:10:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:270:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "h", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:20:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:273:45: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr, "%w", __gu_val, (ptr), (err));       \
                                                             ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:30:2: note: expanded from here
   "%0"
    ^
>> arch/arm64/kernel/traps.c:413:7: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                   if (get_user(instr_le, (__le16 __user *)pc))
                       ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:276:46: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr, "%x",  __gu_val, (ptr), (err));      \
                                                              ^
   arch/arm64/kernel/traps.c:413:7: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:40:2: note: expanded from here
   "%0"
    ^
   arch/arm64/kernel/traps.c:419:8: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                           if (get_user(instr_le, (__le16 __user *)(pc + 2)))
                               ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:267:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "b", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:419:8: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   arch/arm64/include/asm/asm-extable.h:64:10: note: expanded from macro '_ASM_EXTABLE_EFAULT_ZERO'
                             "(" EX_DATA_REG(ERR, err) " | " EX_DATA_REG(ZERO, zero) ")")
                                 ^
   arch/arm64/include/asm/asm-extable.h:59:19: note: expanded from macro 'EX_DATA_REG'
           "((.L__gpr_num_" #gpr ") << " __stringify(EX_DATA_REG_##reg##_SHIFT) ")"
                            ^
   <scratch space>:63:2: note: expanded from here
   "%0"
    ^
   arch/arm64/kernel/traps.c:419:8: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
                           if (get_user(instr_le, (__le16 __user *)(pc + 2)))
                               ^
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
   arch/arm64/include/asm/uaccess.h:298:3: note: expanded from macro '__get_user_error'
                   __raw_get_user((x), __p, (err));                        \
                   ^
   arch/arm64/include/asm/uaccess.h:288:2: note: expanded from macro '__raw_get_user'
           __raw_get_mem("ldtr", x, ptr, err);                             \
           ^
   arch/arm64/include/asm/uaccess.h:270:49: note: expanded from macro '__raw_get_mem'
                   __get_mem_asm(ldr "h", "%w", __gu_val, (ptr), (err));   \
                                                                 ^
   arch/arm64/kernel/traps.c:419:8: note: use constraint modifier "w"
   arch/arm64/include/asm/uaccess.h:311:18: note: expanded from macro 'get_user'
   #define get_user        __get_user
                           ^
   arch/arm64/include/asm/uaccess.h:307:2: note: expanded from macro '__get_user'
           __get_user_error((x), (ptr), __gu_err);                         \
           ^
..


vim +413 arch/arm64/kernel/traps.c

9b79f52d1a702d Punit Agrawal      2014-11-18  396  
9b79f52d1a702d Punit Agrawal      2014-11-18  397  static int call_undef_hook(struct pt_regs *regs)
9b79f52d1a702d Punit Agrawal      2014-11-18  398  {
9b79f52d1a702d Punit Agrawal      2014-11-18  399  	struct undef_hook *hook;
9b79f52d1a702d Punit Agrawal      2014-11-18  400  	unsigned long flags;
9b79f52d1a702d Punit Agrawal      2014-11-18  401  	u32 instr;
9b79f52d1a702d Punit Agrawal      2014-11-18  402  	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
9b79f52d1a702d Punit Agrawal      2014-11-18  403  	void __user *pc = (void __user *)instruction_pointer(regs);
9b79f52d1a702d Punit Agrawal      2014-11-18  404  
0bf0f444b2c492 Will Deacon        2018-08-07  405  	if (!user_mode(regs)) {
0bf0f444b2c492 Will Deacon        2018-08-07  406  		__le32 instr_le;
25f12ae45fc193 Christoph Hellwig  2020-06-17  407  		if (get_kernel_nofault(instr_le, (__force __le32 *)pc))
0bf0f444b2c492 Will Deacon        2018-08-07  408  			goto exit;
0bf0f444b2c492 Will Deacon        2018-08-07  409  		instr = le32_to_cpu(instr_le);
0bf0f444b2c492 Will Deacon        2018-08-07  410  	} else if (compat_thumb_mode(regs)) {
9b79f52d1a702d Punit Agrawal      2014-11-18  411  		/* 16-bit Thumb instruction */
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28  412  		__le16 instr_le;
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28 @413  		if (get_user(instr_le, (__le16 __user *)pc))
9b79f52d1a702d Punit Agrawal      2014-11-18  414  			goto exit;
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28  415  		instr = le16_to_cpu(instr_le);
9b79f52d1a702d Punit Agrawal      2014-11-18  416  		if (aarch32_insn_is_wide(instr)) {
9b79f52d1a702d Punit Agrawal      2014-11-18  417  			u32 instr2;
9b79f52d1a702d Punit Agrawal      2014-11-18  418  
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28  419  			if (get_user(instr_le, (__le16 __user *)(pc + 2)))
9b79f52d1a702d Punit Agrawal      2014-11-18  420  				goto exit;
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28  421  			instr2 = le16_to_cpu(instr_le);
9b79f52d1a702d Punit Agrawal      2014-11-18  422  			instr = (instr << 16) | instr2;
9b79f52d1a702d Punit Agrawal      2014-11-18  423  		}
9b79f52d1a702d Punit Agrawal      2014-11-18  424  	} else {
9b79f52d1a702d Punit Agrawal      2014-11-18  425  		/* 32-bit ARM instruction */
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28  426  		__le32 instr_le;
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28  427  		if (get_user(instr_le, (__le32 __user *)pc))
9b79f52d1a702d Punit Agrawal      2014-11-18  428  			goto exit;
6cf5d4af83e04f Luc Van Oostenryck 2017-06-28  429  		instr = le32_to_cpu(instr_le);
9b79f52d1a702d Punit Agrawal      2014-11-18  430  	}
9b79f52d1a702d Punit Agrawal      2014-11-18  431  
9b79f52d1a702d Punit Agrawal      2014-11-18  432  	raw_spin_lock_irqsave(&undef_lock, flags);
9b79f52d1a702d Punit Agrawal      2014-11-18  433  	list_for_each_entry(hook, &undef_hook, node)
9b79f52d1a702d Punit Agrawal      2014-11-18  434  		if ((instr & hook->instr_mask) == hook->instr_val &&
9b79f52d1a702d Punit Agrawal      2014-11-18  435  			(regs->pstate & hook->pstate_mask) == hook->pstate_val)
9b79f52d1a702d Punit Agrawal      2014-11-18  436  			fn = hook->fn;
9b79f52d1a702d Punit Agrawal      2014-11-18  437  
9b79f52d1a702d Punit Agrawal      2014-11-18  438  	raw_spin_unlock_irqrestore(&undef_lock, flags);
9b79f52d1a702d Punit Agrawal      2014-11-18  439  exit:
9b79f52d1a702d Punit Agrawal      2014-11-18  440  	return fn ? fn(regs, instr) : 1;
9b79f52d1a702d Punit Agrawal      2014-11-18  441  }
9b79f52d1a702d Punit Agrawal      2014-11-18  442  

:::::: The code at line 413 was first introduced by commit
:::::: 6cf5d4af83e04f4cfae91bfdefd9d4d6949c09b2 arm64: fix endianness annotation in call_undef_hook()

:::::: TO: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--82I3+IH0IqGh5yIs
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
r/8HpmCK9Tp1AgA=

--82I3+IH0IqGh5yIs--
