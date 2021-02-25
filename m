Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7BA32508C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 14:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhBYNcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 08:32:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32184 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232804AbhBYNbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 08:31:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614259789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7jn5Amsy9xajDPP8CtJSHk8QDGEDNn4uy9XFsJJ8gS0=;
        b=jCsiAt3/GuqrBhFV7iFCBcu8+FgaHk4RO2NRQgpM1BxaNHIpazog2Pp8S0v0mg7bAQySo1
        uP7/J5eF9lGaaNO+UVN+/DiX+i3PfPwlaFuNmp4VglgDS2/qaWDEufyvN7vJK617ykeS/7
        yhsJ71nKfmTPeKiv3Eu+Kv+XitI0TVM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-z4rg568tNPGg-_hd800Gcg-1; Thu, 25 Feb 2021 08:29:45 -0500
X-MC-Unique: z4rg568tNPGg-_hd800Gcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AC0F100CCC6;
        Thu, 25 Feb 2021 13:29:43 +0000 (UTC)
Received: from treble (ovpn-118-134.rdu2.redhat.com [10.10.118.134])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 164205D9DD;
        Thu, 25 Feb 2021 13:29:41 +0000 (UTC)
Date:   Thu, 25 Feb 2021 07:29:40 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 00/13] x86/crypto/asm: objtool support
Message-ID: <20210225132940.6pfztfephoptoh7y@treble>
References: <cover.1614182415.git.jpoimboe@redhat.com>
 <YDdyEKqDEKmdg9yW@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YDdyEKqDEKmdg9yW@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 10:46:56AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 24, 2021 at 10:29:13AM -0600, Josh Poimboeuf wrote:
> > Standardize the crypto asm to make it resemble compiler-generated code,
> > so that objtool can understand it.
> > 
> > This magically enables ORC unwinding from crypto code.  It also fixes
> > the last known remaining objtool warnings on vmlinux.o, for LTO and
> > more.
> > 
> > Josh Poimboeuf (13):
> >   objtool: Support asm jump tables
> >   x86/crypto/aesni-intel_avx: Remove unused macros
> >   x86/crypto/aesni-intel_avx: Fix register usage comments
> >   x86/crypto/aesni-intel_avx: Standardize stack alignment prologue
> >   x86/crypto/camellia-aesni-avx2: Unconditionally allocate stack buffer
> >   x86/crypto/crc32c-pcl-intel: Standardize jump table
> >   x86/crypto/sha_ni: Standardize stack alignment prologue
> >   x86/crypto/sha1_avx2: Standardize stack alignment prologue
> >   x86/crypto/sha256-avx2: Standardize stack alignment prologue
> >   x86/crypto/sha512-avx: Standardize stack alignment prologue
> >   x86/crypto/sha512-avx2: Standardize stack alignment prologue
> >   x86/crypto/sha512-ssse3: Standardize stack alignment prologue
> >   x86/crypto: Enable objtool in crypto code
> > 
> >  arch/x86/crypto/Makefile                     |  2 -
> >  arch/x86/crypto/aesni-intel_avx-x86_64.S     | 28 +++++--------
> >  arch/x86/crypto/camellia-aesni-avx2-asm_64.S |  5 +--
> >  arch/x86/crypto/crc32c-pcl-intel-asm_64.S    |  7 +---
> >  arch/x86/crypto/sha1_avx2_x86_64_asm.S       |  8 ++--
> >  arch/x86/crypto/sha1_ni_asm.S                |  8 ++--
> >  arch/x86/crypto/sha256-avx2-asm.S            | 13 +++---
> >  arch/x86/crypto/sha512-avx-asm.S             | 41 +++++++++----------
> >  arch/x86/crypto/sha512-avx2-asm.S            | 42 ++++++++++----------
> >  arch/x86/crypto/sha512-ssse3-asm.S           | 41 +++++++++----------
> >  tools/objtool/check.c                        | 14 ++++++-
> >  11 files changed, 98 insertions(+), 111 deletions(-)
> 
> One nit, there's lots and lots of:
> 
> 	mov %rbp, %rsp
> 	pop %rbp
> 
> and we have this 'leave' instruction that does exactly that, should we
> be using it?

I'd considered that, but LEAVE is more cryptic (no pun intended).  This
code often has "surprises", so I prefer the readability of the more
explicit instructions.

> Otherwise:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks.

-- 
Josh

