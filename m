Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8C412158
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 20:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357511AbhITSE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 14:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42001 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355999AbhITR62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:58:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632160621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cuAibYLZasUCXt7JfvCFln2RdO+nXugCTkJrYqMtj0c=;
        b=YciDC4TvZZ2VxCGFavRSQM/LH8q8PTC5ec+DjUYNaPqGbCttg9BKXHoXNF57nj+7bcp5kq
        CE9e6DC605Kwu/yIz74mDIpQnk4LV7I6UrCKiJ9mwL/JLmmBS+Xo2SZPzvhWPjM196gffD
        f9M1dPRZ//jTx6UrYwanJitt8eZ3ZAA=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-oNXW7CMzM2OkCwfy9gLB-A-1; Mon, 20 Sep 2021 13:57:00 -0400
X-MC-Unique: oNXW7CMzM2OkCwfy9gLB-A-1
Received: by mail-ot1-f69.google.com with SMTP id x15-20020a9d458f000000b005452a0e24f8so28388416ote.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cuAibYLZasUCXt7JfvCFln2RdO+nXugCTkJrYqMtj0c=;
        b=AvQXoxhlTSnNSNIoRYkFNVXC+VvuIHA9DpjN6Ma/2NasKmTio/lhrRlX/j5GrzQSk5
         CZzrHwMllQTgpO0oKSFJemRKvHSS1uDHUgE1dwEUlDIE/CS9KIvz56ghkaoUvzWC61Yh
         3rCuwU3F34N1pjg+lQNqCWVSlqAbROoS3Uk+qDnwe4ZV96dT5q1TB1x1DtjBqhgd3nN8
         fHfNFiBhu8yPG8iN8/j8br1kHQc+Oi/x3lvNvABTb92mQDfERYfXX2/E9LtLzAKq4Siq
         qh3zt9V6PAkFHbv3EyS0uBXTzUdPrOUHxxn0gpEd+PHNa1lSv0oYMxOnVJA7Xn8sKeX6
         T9UA==
X-Gm-Message-State: AOAM532vHLG83qncvMWs1zKG4f5i+3eWuwx1I5gWrDC94cSTGw+ZBZgJ
        PiVTCYPfI/nkiTtkcppLgA8sZZMST5S8gCgGIxc2OK7EZ14XMwdQVPRVCK0VGXaF/tA3vN8k73O
        MBVeYoUrtQrhhmswBSCW4kDX9
X-Received: by 2002:a4a:a289:: with SMTP id h9mr5114979ool.86.1632160619215;
        Mon, 20 Sep 2021 10:56:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6Ja3LALF0TlzHaIABYDMyZUh7AElfKrCxx8+IR8P7O+xX1T7OJLlBqkzJJjRrj4bc0ew92A==
X-Received: by 2002:a4a:a289:: with SMTP id h9mr5114961ool.86.1632160618947;
        Mon, 20 Sep 2021 10:56:58 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id j17sm3643290ots.10.2021.09.20.10.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:56:58 -0700 (PDT)
Date:   Mon, 20 Sep 2021 10:56:56 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [linux-next:master 3857/7963]
 arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool:
 sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with
 modified stack frame
Message-ID: <20210920175656.cjvrr4wn7a3k6tnx@treble>
References: <202108160330.T1EbbpCi-lkp@intel.com>
 <CAK8P3a3qhfxUC-7y-_q35-tNrs2L93htjuVzSukqZO0hDhOAuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a3qhfxUC-7y-_q35-tNrs2L93htjuVzSukqZO0hDhOAuw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:02:07PM +0200, Arnd Bergmann wrote:
> On Sun, Aug 15, 2021 at 9:41 PM kernel test robot <lkp@intel.com> wrote:
> >
> > CC: Linux Memory Management List <linux-mm@kvack.org>
> > TO: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > CC: Herbert Xu <herbert@gondor.apana.org.au>
> >
> > Hi Tianjia,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   4b358aabb93a2c654cd1dcab1a25a589f6e2b153
> > commit: a7ee22ee1445c7fdb00ab80116bb9710ca86a860 [3857/7963] crypto: x86/sm4 - add AES-NI/AVX/x86_64 implementation
> > config: x86_64-randconfig-r024-20210816 (attached as .config)
> > compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7776b19eed44906e9973bfb240b6279d6feaab41)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=a7ee22ee1445c7fdb00ab80116bb9710ca86a860
> >         git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> >         git fetch --no-tags linux-next master
> >         git checkout a7ee22ee1445c7fdb00ab80116bb9710ca86a860
> >         # save the attached .config to linux build tree
> >         mkdir build_dir
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool: sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with modified stack frame
> 
> I see the same thing in my randconfig builds using gcc. This is an
> assembler file,
> my interpretation is that objtool has found an actual code bug:
> 
> .macro FRAME_BEGIN
>         push %_ASM_BP
>         _ASM_MOV %_ASM_SP, %_ASM_BP
> .endm
> .macro FRAME_END
>         pop %_ASM_BP
> .endm
> 
> SYM_FUNC_START(sm4_aesni_avx_crypt8)
>         /* input:
>          *      %rdi: round key array, CTX
>          *      %rsi: dst (1..8 blocks)
>          *      %rdx: src (1..8 blocks)
>          *      %rcx: num blocks (1..8)
>          */
>         FRAME_BEGIN
> 
>         cmpq $5, %rcx;
>         jb sm4_aesni_avx_crypt4;
>         ....
> 
> SYM_FUNC_START(sm4_aesni_avx_crypt4)
>         /* input:
>          *      %rdi: round key array, CTX
>          *      %rsi: dst (1..4 blocks)
>          *      %rdx: src (1..4 blocks)
>          *      %rcx: num blocks (1..4)
>          */
>         FRAME_BEGIN
>         ...
>         FRAME_END
>         ret;
> SYM_FUNC_END(sm4_aesni_avx_crypt4)
> 
> 
> sm4_aesni_avx_crypt8() starts a frame and conditionally branches to
> sm4_aesni_avx_crypt4(), which starts another frame and returns from
> that without cleaning up the parent frame.

Indeed!  This looks completely broken with CONFIG_FRAME_POINTER.

Needs something like:

---8<---

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] x86/crypto/sm4: Fix frame pointer stack corruption

sm4_aesni_avx_crypt8() sets up the frame pointer (which includes pushing
RBP) before doing a conditional sibling call to sm4_aesni_avx_crypt4(),
which sets up an additional frame pointer.  Things will not go well when
sm4_aesni_avx_crypt4() pops only the innermost single frame pointer and
then tries to return to the outermost frame pointer.

Sibling calls need to occur with an empty stack frame.  Do the
conditional sibling call *before* setting up the stack pointer.

This fixes the following warning:

  arch/x86/crypto/sm4-aesni-avx-asm_64.o: warning: objtool: sm4_aesni_avx_crypt8()+0x8: sibling call from callable instruction with modified stack frame

Fixes: a7ee22ee1445 ("crypto: x86/sm4 - add AES-NI/AVX/x86_64 implementation")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/crypto/sm4-aesni-avx-asm_64.S | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/crypto/sm4-aesni-avx-asm_64.S b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
index fa2c3f50aecb..a50df13de222 100644
--- a/arch/x86/crypto/sm4-aesni-avx-asm_64.S
+++ b/arch/x86/crypto/sm4-aesni-avx-asm_64.S
@@ -367,10 +367,12 @@ SYM_FUNC_START(sm4_aesni_avx_crypt8)
 	 *	%rdx: src (1..8 blocks)
 	 *	%rcx: num blocks (1..8)
 	 */
-	FRAME_BEGIN
 
 	cmpq $5, %rcx;
 	jb sm4_aesni_avx_crypt4;
+
+	FRAME_BEGIN
+
 	vmovdqu (0 * 16)(%rdx), RA0;
 	vmovdqu (1 * 16)(%rdx), RA1;
 	vmovdqu (2 * 16)(%rdx), RA2;
-- 
2.31.1

