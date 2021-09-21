Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A4E412EE4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 08:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhIUG7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbhIUG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 02:59:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0BBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 23:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p0YkjdTTA6iER5m9azQvivqmBm9b0xcRpaf9uMBcLQI=; b=mQY84ctDtKQ6Vz7/pmkUEcIwVO
        sLfCNnMGVZ9ORJAT27FXfL/Uu4WcSWbscoF5ZCoXzfWVn4omyXkbSKVwOHLZJXBzzgu0g4q/Bu2+s
        4JU7UY3piyFafcoVHdTsMNZiJfNwtuMsbS5m6fU6Jo/FmFltWYlFV6ymFU84YEaGUD2c3am6BX7u1
        OAsz4e/4uwpSh29LZpcz0muEcW6sjGMMtAf8XbkkEY/RWzQ/4/tsE8MDd0xkpiTye0l69MJVFgKrT
        pKNC17rm7lj13QUOOBi7vsreW7OPBk6fwp/0Qk4dLAZhzpRWsjfg88GczmkkIoLIV+9WwZ7Lrs29r
        G+VrUcbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSZi7-003a0w-2i; Tue, 21 Sep 2021 06:57:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 311D5300274;
        Tue, 21 Sep 2021 08:56:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 541072C3EE3EA; Tue, 21 Sep 2021 08:56:56 +0200 (CEST)
Date:   Tue, 21 Sep 2021 08:56:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [linux-next:master 3857/7963]
 arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool:
 sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with
 modified stack frame
Message-ID: <YUmCOCg0nN5qhoGR@hirez.programming.kicks-ass.net>
References: <202108160330.T1EbbpCi-lkp@intel.com>
 <CAK8P3a3qhfxUC-7y-_q35-tNrs2L93htjuVzSukqZO0hDhOAuw@mail.gmail.com>
 <20210920175656.cjvrr4wn7a3k6tnx@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920175656.cjvrr4wn7a3k6tnx@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:56:56AM -0700, Josh Poimboeuf wrote:
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
>   arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool: sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with modified stack frame
> 
> Fixes: a7ee22ee1445 ("crypto: x86/sm4 - add AES-NI/AVX/x86_64 implementation")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> ---
>  arch/x86/crypto/sm4-aesni-avx-asm_64.S | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> index fa2c3f50aecb..a50df13de222 100644
> --- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> +++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
> @@ -367,10 +367,12 @@ SYM_FUNC_START(sm4_aesni_avx_crypt8)
>  	 *	%rdx: src (1..8 blocks)
>  	 *	%rcx: num blocks (1..8)
>  	 */
> -	FRAME_BEGIN
>  
>  	cmpq $5, %rcx;
>  	jb sm4_aesni_avx_crypt4;
> +
> +	FRAME_BEGIN
> +
>  	vmovdqu (0 * 16)(%rdx), RA0;
>  	vmovdqu (1 * 16)(%rdx), RA1;
>  	vmovdqu (2 * 16)(%rdx), RA2;
> -- 
> 2.31.1
> 
