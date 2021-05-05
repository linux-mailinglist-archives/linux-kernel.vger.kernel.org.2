Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9122A3749F4
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbhEEVNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhEEVNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A399613E9;
        Wed,  5 May 2021 21:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620249157;
        bh=SF8pLDg6mYM+cJX4qJTl0j8gBQM0zTAaYqvvgCdxSJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iGOt52jou3JNMUFzfsraNFx5vB+i0IzT2Ne1R9EJG8vf3j5Oc7TCgwUDGvMC/5J5H
         l4EWXTFuVPX87oH8dKUPPOYobkExA2nEDDNX1FuV9riiddVwiuGIAJ4OD979A3yhSE
         lXC4FznjwnnVQOfrqjkg1K/bStsvqmBK5qMCaMH4LDdyMa81cmQcjahoZ44xaxtIOC
         RMo3XKipVcf7HDARv2vwtcs5c/c1t4k4ulw279h1bOdj7ckbJYWc6S4z1cpV1XFljT
         zJ/Ou59PnWVBIBRv5FdtOEMjI3SuT6QpKrqZzZ5EWthjT92cMdpS3pQ173AGZXhzIT
         jClDdU3cUUBOw==
Date:   Wed, 5 May 2021 14:12:32 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stack: replace "o" output with "r" input constraint
Message-ID: <YJMKQFscszFcf5fE@archlinux-ax161>
References: <20210419231741.4084415-1-keescook@chromium.org>
 <YIIcoz4fHjVjWHTI@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIIcoz4fHjVjWHTI@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 06:02:27PM -0700, Nathan Chancellor wrote:
> On Mon, Apr 19, 2021 at 04:17:41PM -0700, Kees Cook wrote:
> > From: Nick Desaulniers <ndesaulniers@google.com>
> > 
> > "o" isn't a common asm() constraint to use; it triggers an assertion in
> > assert-enabled builds of LLVM that it's not recognized when targeting
> > aarch64 (though it appears to fall back to "m"). I've fixed this in LLVM
> > 13 now, but there isn't really a good reason to be using "o" in particular
> > here. To avoid causing build issues for those using assert-enabled builds
> > of earlier LLVM versions, the constraint needs changing.
> > 
> > Instead, if the point is to retain the __builtin_alloca(), we can make ptr
> > appear to "escape" via being an input to an empty inline asm block. This
> > is preferable anyways, since otherwise this looks like a dead store.
> > 
> > While the use of "r" was considered in
> > https://lore.kernel.org/lkml/202104011447.2E7F543@keescook/
> > it was only tested as an output (which looks like a dead store, and
> > wasn't sufficient). Use "r" as an input constraint instead, which
> > behaves correctly across compilers and architectures:
> > https://godbolt.org/z/E9cd411ob
> > 
> > Link: https://reviews.llvm.org/D100412
> > Link: https://bugs.llvm.org/show_bug.cgi?id=49956
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > Tested-by: Kees Cook <keescook@chromium.org>
> > Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")

Kees, were you planning on taking this to Linus or someone else? It
would be nice to have this in for -rc1 (although I understand it might
be too late), if not, by -rc2.

Cheers,
Nathan

> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> I built arm64 defconfig with and without
> CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT with LLVM 12 (which does not have
> Nick's LLVM fix) without any issues and did a quick boot test in QEMU,
> nothing exploded.
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> > ---
> >  include/linux/randomize_kstack.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> > index fd80fab663a9..bebc911161b6 100644
> > --- a/include/linux/randomize_kstack.h
> > +++ b/include/linux/randomize_kstack.h
> > @@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
> >  		u32 offset = raw_cpu_read(kstack_offset);		\
> >  		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
> >  		/* Keep allocation even after "ptr" loses scope. */	\
> > -		asm volatile("" : "=o"(*ptr) :: "memory");		\
> > +		asm volatile("" :: "r"(ptr) : "memory");		\
> >  	}								\
> >  } while (0)
> >  
> > -- 
> > 2.25.1
> > 
