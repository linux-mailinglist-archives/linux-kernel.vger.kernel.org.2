Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B1B413F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 04:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhIVCad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 22:30:33 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:52889 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhIVCac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 22:30:32 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UpB2F3U_1632277730;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UpB2F3U_1632277730)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 22 Sep 2021 10:28:51 +0800
Subject: Re: [linux-next:master 3857/7963]
 arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool:
 sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with
 modified stack frame
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <202108160330.T1EbbpCi-lkp@intel.com>
 <CAK8P3a3qhfxUC-7y-_q35-tNrs2L93htjuVzSukqZO0hDhOAuw@mail.gmail.com>
 <20210920175656.cjvrr4wn7a3k6tnx@treble>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <6d49d3ba-ae5d-cd57-d1fb-d9df5b859cbe@linux.alibaba.com>
Date:   Wed, 22 Sep 2021 10:28:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210920175656.cjvrr4wn7a3k6tnx@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/21/21 1:56 AM, Josh Poimboeuf wrote:
> From: Josh Poimboeuf <jpoimboe@redhat.com>
> Subject: [PATCH] x86/crypto/sm4: Fix frame pointer stack corruption
> 
> sm4_aesni_avx_crypt8() sets up the frame pointer (which includes pushing
> RBP) before doing a conditional sibling call to sm4_aesni_avx_crypt4(),
> which sets up an additional frame pointer.  Things will not go well when
> sm4_aesni_avx_crypt4() pops only the innermost single frame pointer and
> then tries to return to the outermost frame pointer.
> 
> Sibling calls need to occur with an empty stack frame.  Do the
> conditional sibling call *before* setting up the stack pointer.
> 
> This fixes the following warning:
> 
>    arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool: sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with modified stack frame
> 
> Fixes: a7ee22ee1445 ("crypto: x86/sm4 - add AES-NI/AVX/x86_64 implementation")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks for your fix.

Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Thanks.

> ---
>   arch/x86/crypto/sm4-aesni-avx-asm_64.S | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> index fa2c3f50aecb..a50df13de222 100644
> --- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> +++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> @@ -367,10 +367,12 @@ SYM_FUNC_START(sm4_aesni_avx_crypt8)
>   	 *	%rdx: src (1..8 blocks)
>   	 *	%rcx: num blocks (1..8)
>   	 */
> -	FRAME_BEGIN
>   
>   	cmpq $5, %rcx;
>   	jb sm4_aesni_avx_crypt4;
> +
> +	FRAME_BEGIN
> +
>   	vmovdqu (0 * 16)(%rdx), RA0;
>   	vmovdqu (1 * 16)(%rdx), RA1;
>   	vmovdqu (2 * 16)(%rdx), RA2;
> 
