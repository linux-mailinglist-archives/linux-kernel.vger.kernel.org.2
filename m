Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CCD37AE9E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 20:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbhEKSrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 14:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:36390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhEKSrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 14:47:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 572136188B;
        Tue, 11 May 2021 18:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620758765;
        bh=0kDZg3pMl4uAXVouuJulo1Eg0XxZ4zf9gnP04J17qLo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AuRbkncbINf705rPsUdo4iynjGi9Wn5Kl7Qkf369fqGBTpGJsk0ono8WVJ1lAWDiz
         7/tvDhJJg2wIPhb9d7tgryyB/vc88cHshiHUZ34bb6DNCZSA6jgRwcCMFSWexU4ZvO
         KWlIyLWYgRbMYxoMi95o9uc+OS19T+Vpy0DPbC0VYEiEh6s2+alde3w3gJxTmWOoHM
         DbQ9vV1N8eEpvzlVxPbBDCrWjsiBLoqCZg19exE2ELe8YG3RQiAlobOupoGl/z6GqH
         n2TZcf9W8ViJH6i1qA9saQ91zc5K4xtERo1vKuWBdPNg2tgZHdqvnOyBSrWNNF+QYS
         30/r8a4c3tI3Q==
Subject: Re: arch/powerpc/kernel/optprobes.c:34:1: error: unused function
 'is_kprobe_ppc_optinsn_slot'
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
References: <202105120059.uTLH58Lm-lkp@intel.com>
 <48747467-cb93-c66d-4cf9-097be0568488@csgroup.eu>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <208186f3-aab0-d94e-bcf4-8347983cc1a6@kernel.org>
Date:   Tue, 11 May 2021 11:46:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <48747467-cb93-c66d-4cf9-097be0568488@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2021 9:47 AM, Christophe Leroy wrote:
> Hi All,
> 
> Le 11/05/2021 à 18:30, kernel test robot a écrit :
>> Hi Christophe,
>>
>> First bad commit (maybe != root cause):
>>
>> tree:   
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   1140ab592e2ebf8153d2b322604031a8868ce7a5
>> commit: eacf4c0202654adfa94bbb17b5c5c77c0be14af8 powerpc: Enable 
>> OPTPROBES on PPC32
>> date:   3 weeks ago
>> config: powerpc-randconfig-r033-20210511 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 
>> a0fed635fe1701470062495a6ffee1c608f3f1bc)
> 
> A clang issue ?
> 
> 
>> reproduce (this is a W=1 build):
>>          wget 
>> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross 
>> -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install powerpc cross compiling tool for clang build
>>          # apt-get install binutils-powerpc-linux-gnu
>>          # 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eacf4c0202654adfa94bbb17b5c5c77c0be14af8 
>>
>>          git remote add linus 
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout eacf4c0202654adfa94bbb17b5c5c77c0be14af8
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
>> W=1 ARCH=powerpc
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> arch/powerpc/kernel/optprobes.c:34:1: error: unused function 
>>>> 'is_kprobe_ppc_optinsn_slot' [-Werror,-Wunused-function]
>>     DEFINE_INSN_CACHE_OPS(ppc_optinsn);
>>     ^
>>     include/linux/kprobes.h:306:20: note: expanded from macro 
>> 'DEFINE_INSN_CACHE_OPS'
>>     static inline bool is_kprobe_##__name##_slot(unsigned long 
>> addr)        \
> 
> That's a 'static inline', shouldn't generate an 'unused function' warning.
This is a W=1 build, which means that "inline" does not silence unused 
function warnings with clang because of commit 6863f5643dd7 ("kbuild: 
allow Clang to find unused static inline functions for W=1 build").

Cheers,
Nathan

>>                        ^
>>     <scratch space>:16:1: note: expanded from here
>>     is_kprobe_ppc_optinsn_slot
>>     ^
>>     1 error generated.
>>
>>
>> vim +/is_kprobe_ppc_optinsn_slot +34 arch/powerpc/kernel/optprobes.c
>>
>> 51c9c084399352 Anju T 2017-02-08  20
>> 51c9c084399352 Anju T 2017-02-08  21  #define TMPL_CALL_HDLR_IDX    \
>> 51c9c084399352 Anju T 2017-02-08  22      
>> (optprobe_template_call_handler - optprobe_template_entry)
>> 51c9c084399352 Anju T 2017-02-08  23  #define TMPL_EMULATE_IDX    \
>> 51c9c084399352 Anju T 2017-02-08  24      
>> (optprobe_template_call_emulate - optprobe_template_entry)
>> 51c9c084399352 Anju T 2017-02-08  25  #define TMPL_RET_IDX        \
>> 51c9c084399352 Anju T 2017-02-08  26      (optprobe_template_ret - 
>> optprobe_template_entry)
>> 51c9c084399352 Anju T 2017-02-08  27  #define TMPL_OP_IDX        \
>> 51c9c084399352 Anju T 2017-02-08  28      
>> (optprobe_template_op_address - optprobe_template_entry)
>> 51c9c084399352 Anju T 2017-02-08  29  #define TMPL_INSN_IDX        \
>> 51c9c084399352 Anju T 2017-02-08  30      (optprobe_template_insn - 
>> optprobe_template_entry)
>> 51c9c084399352 Anju T 2017-02-08  31  #define TMPL_END_IDX        \
>> 51c9c084399352 Anju T 2017-02-08  32      (optprobe_template_end - 
>> optprobe_template_entry)
>> 51c9c084399352 Anju T 2017-02-08  33
>> 51c9c084399352 Anju T 2017-02-08 @34  DEFINE_INSN_CACHE_OPS(ppc_optinsn);
>> 51c9c084399352 Anju T 2017-02-08  35
>>
>> :::::: The code at line 34 was first introduced by commit
>> :::::: 51c9c0843993528bffc920c54c2121d9e6f8b090 powerpc/kprobes: 
>> Implement Optprobes
>>
>> :::::: TO: Anju T <anju@linux.vnet.ibm.com>
>> :::::: CC: Michael Ellerman <mpe@ellerman.id.au>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>>
> 

