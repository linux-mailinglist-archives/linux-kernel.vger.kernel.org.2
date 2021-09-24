Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7EC416D6F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 10:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbhIXIJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 04:09:09 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55464 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244515AbhIXIJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 04:09:08 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mTgF1-000836-6U; Fri, 24 Sep 2021 16:07:31 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mTgEv-0003Rj-1S; Fri, 24 Sep 2021 16:07:25 +0800
Date:   Fri, 24 Sep 2021 16:07:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH] x86/crypto/sm4: Fix frame pointer stack corruption
Message-ID: <20210924080724.GA13213@gondor.apana.org.au>
References: <2010f60571abe6fe53d89189ab6da7e641cb027b.1632289099.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2010f60571abe6fe53d89189ab6da7e641cb027b.1632289099.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:40:26PM -0700, Josh Poimboeuf wrote:
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
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  arch/x86/crypto/sm4-aesni-avx-asm_64.S | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
