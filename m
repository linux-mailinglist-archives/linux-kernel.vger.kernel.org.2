Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE38937AC4A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 18:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhEKQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 12:48:30 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:34749 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231377AbhEKQs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 12:48:29 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4FfkNn4x37z9scw;
        Tue, 11 May 2021 18:47:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id FdPnrTcrlk03; Tue, 11 May 2021 18:47:21 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4FfkNn3x2sz9sb1;
        Tue, 11 May 2021 18:47:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 686EB8B7CC;
        Tue, 11 May 2021 18:47:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id m3XhbXdmu7Jo; Tue, 11 May 2021 18:47:21 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D77BD8B7C2;
        Tue, 11 May 2021 18:47:20 +0200 (CEST)
Subject: Re: arch/powerpc/kernel/optprobes.c:34:1: error: unused function
 'is_kprobe_ppc_optinsn_slot'
To:     kernel test robot <lkp@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <202105120059.uTLH58Lm-lkp@intel.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <48747467-cb93-c66d-4cf9-097be0568488@csgroup.eu>
Date:   Tue, 11 May 2021 18:47:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <202105120059.uTLH58Lm-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Le 11/05/2021 à 18:30, kernel test robot a écrit :
> Hi Christophe,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1140ab592e2ebf8153d2b322604031a8868ce7a5
> commit: eacf4c0202654adfa94bbb17b5c5c77c0be14af8 powerpc: Enable OPTPROBES on PPC32
> date:   3 weeks ago
> config: powerpc-randconfig-r033-20210511 (attached as .config)
> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project a0fed635fe1701470062495a6ffee1c608f3f1bc)

A clang issue ?


> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install powerpc cross compiling tool for clang build
>          # apt-get install binutils-powerpc-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eacf4c0202654adfa94bbb17b5c5c77c0be14af8
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout eacf4c0202654adfa94bbb17b5c5c77c0be14af8
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> arch/powerpc/kernel/optprobes.c:34:1: error: unused function 'is_kprobe_ppc_optinsn_slot' [-Werror,-Wunused-function]
>     DEFINE_INSN_CACHE_OPS(ppc_optinsn);
>     ^
>     include/linux/kprobes.h:306:20: note: expanded from macro 'DEFINE_INSN_CACHE_OPS'
>     static inline bool is_kprobe_##__name##_slot(unsigned long addr)        \

That's a 'static inline', shouldn't generate an 'unused function' warning.

>                        ^
>     <scratch space>:16:1: note: expanded from here
>     is_kprobe_ppc_optinsn_slot
>     ^
>     1 error generated.
> 
> 
> vim +/is_kprobe_ppc_optinsn_slot +34 arch/powerpc/kernel/optprobes.c
> 
> 51c9c084399352 Anju T 2017-02-08  20
> 51c9c084399352 Anju T 2017-02-08  21  #define TMPL_CALL_HDLR_IDX	\
> 51c9c084399352 Anju T 2017-02-08  22  	(optprobe_template_call_handler - optprobe_template_entry)
> 51c9c084399352 Anju T 2017-02-08  23  #define TMPL_EMULATE_IDX	\
> 51c9c084399352 Anju T 2017-02-08  24  	(optprobe_template_call_emulate - optprobe_template_entry)
> 51c9c084399352 Anju T 2017-02-08  25  #define TMPL_RET_IDX		\
> 51c9c084399352 Anju T 2017-02-08  26  	(optprobe_template_ret - optprobe_template_entry)
> 51c9c084399352 Anju T 2017-02-08  27  #define TMPL_OP_IDX		\
> 51c9c084399352 Anju T 2017-02-08  28  	(optprobe_template_op_address - optprobe_template_entry)
> 51c9c084399352 Anju T 2017-02-08  29  #define TMPL_INSN_IDX		\
> 51c9c084399352 Anju T 2017-02-08  30  	(optprobe_template_insn - optprobe_template_entry)
> 51c9c084399352 Anju T 2017-02-08  31  #define TMPL_END_IDX		\
> 51c9c084399352 Anju T 2017-02-08  32  	(optprobe_template_end - optprobe_template_entry)
> 51c9c084399352 Anju T 2017-02-08  33
> 51c9c084399352 Anju T 2017-02-08 @34  DEFINE_INSN_CACHE_OPS(ppc_optinsn);
> 51c9c084399352 Anju T 2017-02-08  35
> 
> :::::: The code at line 34 was first introduced by commit
> :::::: 51c9c0843993528bffc920c54c2121d9e6f8b090 powerpc/kprobes: Implement Optprobes
> 
> :::::: TO: Anju T <anju@linux.vnet.ibm.com>
> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
