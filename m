Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB06B3FDD47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 15:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbhIANVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 09:21:49 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:57099 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234295AbhIANVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 09:21:45 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4H04SH4Pzxz9sT4;
        Wed,  1 Sep 2021 15:20:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MCcCl9jOCGME; Wed,  1 Sep 2021 15:20:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4H04SH3CfNz9sSq;
        Wed,  1 Sep 2021 15:20:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 549078B83E;
        Wed,  1 Sep 2021 15:20:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5hNxn9rxWebo; Wed,  1 Sep 2021 15:20:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1E3748B83C;
        Wed,  1 Sep 2021 15:20:47 +0200 (CEST)
Subject: Re: [linuxppc:next-test 71/141]
 drivers/net/ethernet/sfc/falcon/farch.c:994:10: warning: shift count is
 negative
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <202109011018.QFMpsm0d-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <f96f87e8-1a9c-a43c-82ef-787de35deef2@csgroup.eu>
Date:   Wed, 1 Sep 2021 15:20:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <202109011018.QFMpsm0d-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 01/09/2021 à 04:54, kernel test robot a écrit :
> tree:   https://github.com/linuxppc/linux next-test
> head:   c7dee506ec3450717e84518ab3a6a3f2ce755cf6
> commit: 1e688dd2a3d6759d416616ff07afc4bb836c4213 [71/141] powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLAGS() with asm goto
> config: powerpc-randconfig-r031-20210901 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b1fde8a2b681dad2ce0c082a5d6422caa06b0bc)

Apparently a clang problem. This doesn't happen with GCC.


> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install powerpc cross compiling tool for clang build
>          # apt-get install binutils-powerpc64-linux-gnu
>          # https://github.com/linuxppc/linux/commit/1e688dd2a3d6759d416616ff07afc4bb836c4213
>          git remote add linuxppc https://github.com/linuxppc/linux
>          git fetch --no-tags linuxppc next-test
>          git checkout 1e688dd2a3d6759d416616ff07afc4bb836c4213
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>>> drivers/net/ethernet/sfc/falcon/farch.c:994:10: warning: shift count is negative [-Wshift-count-negative]
>             WARN_ON(EF4_QWORD_FIELD(*event, FSF_AZ_RX_EV_Q_LABEL) !=
>             ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     drivers/net/ethernet/sfc/falcon/bitfield.h:222:26: note: expanded from macro 'EF4_QWORD_FIELD'
>     #define EF4_QWORD_FIELD         EF4_QWORD_FIELD64
>                                     ^
>     drivers/net/ethernet/sfc/falcon/bitfield.h:173:2: note: expanded from macro 'EF4_QWORD_FIELD64'
>             EF4_EXTRACT_QWORD64(qword, EF4_LOW_BIT(field),          \
>             ^
>     drivers/net/ethernet/sfc/falcon/bitfield.h:149:3: note: expanded from macro 'EF4_EXTRACT_QWORD64'
>             (EF4_EXTRACT64((qword).u64[0], 0, 63, low, high) &              \
>              ^
>     note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
>     arch/powerpc/include/asm/bug.h:122:30: note: expanded from macro 'WARN_ON'
>                                        __label_warn_on, "r" (x));   \
>                                        ~~~~~~~~~~~~~~~~~~~~~~^~~
>     arch/powerpc/include/asm/bug.h:75:7: note: expanded from macro 'WARN_ENTRY'
>                       ##__VA_ARGS__ : : label)
>                       ~~^~~~~~~~~~~~~~~~~~~~~~
>     include/linux/compiler_types.h:254:42: note: expanded from macro 'asm_volatile_goto'
>     #define asm_volatile_goto(x...) asm goto(x)
>                                              ^
>     1 warning generated.


Complete with -fmacro-backtrace-limit=0 :

   CC      drivers/net/ethernet/sfc/falcon/farch.o
drivers/net/ethernet/sfc/falcon/farch.c:994:10: warning: shift count is 
negative [-Wshift-count-negative]
         WARN_ON(EF4_QWORD_FIELD(*event, FSF_AZ_RX_EV_Q_LABEL) !=
         ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/sfc/falcon/bitfield.h:222:26: note: expanded from 
macro 'EF4_QWORD_FIELD'
#define EF4_QWORD_FIELD         EF4_QWORD_FIELD64
                                 ^
drivers/net/ethernet/sfc/falcon/bitfield.h:173:2: note: expanded from 
macro 'EF4_QWORD_FIELD64'
         EF4_EXTRACT_QWORD64(qword, EF4_LOW_BIT(field),          \
         ^
drivers/net/ethernet/sfc/falcon/bitfield.h:149:3: note: expanded from 
macro 'EF4_EXTRACT_QWORD64'
         (EF4_EXTRACT64((qword).u64[0], 0, 63, low, high) &              \
          ^
drivers/net/ethernet/sfc/falcon/bitfield.h:134:2: note: expanded from 
macro 'EF4_EXTRACT64'
         EF4_EXTRACT_NATIVE(le64_to_cpu(element), min, max, low, high)
         ^
drivers/net/ethernet/sfc/falcon/bitfield.h:127:20: note: expanded from 
macro 'EF4_EXTRACT_NATIVE'
          (native_element) << ((min) - (low)))
                           ^
./arch/powerpc/include/asm/bug.h:122:30: note: expanded from macro 'WARN_ON'
                                    __label_warn_on, "r" (x));   \
                                    ~~~~~~~~~~~~~~~~~~~~~~^~~
./arch/powerpc/include/asm/bug.h:75:7: note: expanded from macro 
'WARN_ENTRY'
                   ##__VA_ARGS__ : : label)
                   ~~^~~~~~~~~~~~~~~~~~~~~~
./include/linux/compiler_types.h:254:42: note: expanded from macro 
'asm_volatile_goto'
#define asm_volatile_goto(x...) asm goto(x)
                                          ^
1 warning generated.



The warning makes no sense because this part of the macro is as follows 
so there is no way the shift can be negative.

	 (low) > (min) ?					\
	 (native_element) >> ((low) - (min)) :			\
	 (native_element) << ((min) - (low)))


Christophe
