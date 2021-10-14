Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEB142D727
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhJNKcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:32:05 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:55056 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhJNKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:32:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0Urohuq8_1634207395;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Urohuq8_1634207395)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 14 Oct 2021 18:29:56 +0800
Subject: Re: [RFC] crypto/sm4: Fix objtool/libelf warning
To:     Peter Zijlstra <peterz@infradead.org>, herbert@gondor.apana.org.au,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org
References: <20211007202204.GT174703@worktop.programming.kicks-ass.net>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <8e35ba6d-f876-4726-a8e7-a0d80b0186f2@linux.alibaba.com>
Date:   Thu, 14 Oct 2021 18:29:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211007202204.GT174703@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/8/21 4:22 AM, Peter Zijlstra wrote:
> Hi,
> 
> objtool is yielding the obscure libelf warning:
> 
>    vmlinux.o: warning: objtool: elf_update: invalid section entry size
> 
> Which I tracked down to section:
> 
>    [3023] .rodata.cst164    PROGBITS        0000000000000000 1ab501e0 000154 a4  AM  0   0 16
> 
> Which has a section size of 0x154 (340) and an entry size of 0xa4 (164).
> An obvious mis-match.
> 
>  From there, git-grep quickly yields:
> 
>    arch/x86/crypto/sm4-aesni-avx-asm_64.S:.section .rodata.cst164, "aM", @progbits, 164
>    arch/x86/crypto/sm4-aesni-avx2-asm_64.S:.section        .rodata.cst164, "aM", @progbits, 164
> 
> So those files create this .rodata section with an explicit entry size,
> but then don't respect it themselves. Removing the entry size makes the
> warning go away, but I can't tell if that's right or not, given there is
> zero clue as to why that entry size was specified to begin with.
> 
> Please explain...
> 
> ---
> diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> index 18d2f5199194..d089cccf4db7 100644
> --- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> +++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> @@ -78,7 +78,7 @@
>   	vpxor tmp0, x, x;
>   
>   
> -.section	.rodata.cst164, "aM", @progbits, 164
> +.section	.rodata.cst164, "aM", @progbits
>   .align 16
>   
>   /*
> diff --git a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
> index d2ffd7f76ee2..a0f7541c2246 100644
> --- a/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
> +++ b/arch/x86/crypto/sm4-aesni-avx2-asm_64.S
> @@ -93,7 +93,7 @@
>   	vpxor tmp0, x, x;
>   
>   
> -.section	.rodata.cst164, "aM", @progbits, 164
> +.section	.rodata.cst164, "aM", @progbits
>   .align 16
>   
>   /*
> 

Thanks for pointing it out, We have also reproduced this error. If the M 
flag is specified, the entry_size argument is required. We also need to 
consider the clang compiler. This requires a more thorough method to fix 
it. I will post another patch later.

Best regards,
Tianjia
