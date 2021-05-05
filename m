Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4843374A0A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 23:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhEEVUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 17:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEEVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 17:20:50 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E391C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 14:19:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id m190so2775029pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9nGzi5CNcRf8P6ukHnfVe+RHJcl1mNr7kPIzbkyiUvo=;
        b=kGB0dncyYeVHRpUkcrYEHlkEIimb9n7+xXk3nbtiao2P7nh5CRQFoMNBJ8cXfISMd/
         TNuA3kLMMbEwSIBqsoc1/9LLphiuSF8DEA7pBivLK886PQSQWEPXCYkhhgBPaFzQjiHI
         p7i+daEzOIhlDu7x69oiLJBKsjeoFEu028z/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nGzi5CNcRf8P6ukHnfVe+RHJcl1mNr7kPIzbkyiUvo=;
        b=bEzh5HES4uKKHyiQvSYuiieSpK1jahepyr4rokFyQXuaqnKDR9t/law1yQIfDOcZBo
         a9AVVFMR3Pd9gmycFp9FtXJyCDkhKHbFjamppJCs7CBCyRvgCntcXeNO0fzoEnPLEkWv
         Av4u8LqwImFp2txkHLwtBS5LF7h+jqHdA6sH9+QL9oH8/iaNnnLqli9vvoBx23IQH65g
         fQZVK2v7MR+djvkoYYW50wY4oysIpSRr9bm7vCcJMSfJL0h9uVvIOwDe5pTC8nnUvYVJ
         2IRdvwdtYwhG0eCJCv8+x9QCYMU1ibJxKHKE3jBLVytu3VZ2DBZX0eoCtHbQO8ZVfzMW
         AYgQ==
X-Gm-Message-State: AOAM533yfgXTXldx9b/LwvSJwibKfzmMfG0avPgax6asoK6hKBb7hl1J
        zC3CwLOdoisoPALbidqa5LIM/w==
X-Google-Smtp-Source: ABdhPJzthqPqKuFaBRhpJRcpiMvGIDqyQLZX/WyV5COGCXLyMJRbZVZrelLfpID/ATaYTNrASM6OYQ==
X-Received: by 2002:a62:8c05:0:b029:290:81ab:a936 with SMTP id m5-20020a628c050000b029029081aba936mr844363pfd.69.1620249592995;
        Wed, 05 May 2021 14:19:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a65sm149447pfb.116.2021.05.05.14.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:19:52 -0700 (PDT)
Date:   Wed, 5 May 2021 14:19:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Laight <David.Laight@aculab.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] stack: replace "o" output with "r" input constraint
Message-ID: <202105051419.8F3C8EE58D@keescook>
References: <20210419231741.4084415-1-keescook@chromium.org>
 <YIIcoz4fHjVjWHTI@archlinux-ax161>
 <YJMKQFscszFcf5fE@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJMKQFscszFcf5fE@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2021 at 02:12:32PM -0700, Nathan Chancellor wrote:
> On Thu, Apr 22, 2021 at 06:02:27PM -0700, Nathan Chancellor wrote:
> > On Mon, Apr 19, 2021 at 04:17:41PM -0700, Kees Cook wrote:
> > > From: Nick Desaulniers <ndesaulniers@google.com>
> > > 
> > > "o" isn't a common asm() constraint to use; it triggers an assertion in
> > > assert-enabled builds of LLVM that it's not recognized when targeting
> > > aarch64 (though it appears to fall back to "m"). I've fixed this in LLVM
> > > 13 now, but there isn't really a good reason to be using "o" in particular
> > > here. To avoid causing build issues for those using assert-enabled builds
> > > of earlier LLVM versions, the constraint needs changing.
> > > 
> > > Instead, if the point is to retain the __builtin_alloca(), we can make ptr
> > > appear to "escape" via being an input to an empty inline asm block. This
> > > is preferable anyways, since otherwise this looks like a dead store.
> > > 
> > > While the use of "r" was considered in
> > > https://lore.kernel.org/lkml/202104011447.2E7F543@keescook/
> > > it was only tested as an output (which looks like a dead store, and
> > > wasn't sufficient). Use "r" as an input constraint instead, which
> > > behaves correctly across compilers and architectures:
> > > https://godbolt.org/z/E9cd411ob
> > > 
> > > Link: https://reviews.llvm.org/D100412
> > > Link: https://bugs.llvm.org/show_bug.cgi?id=49956
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > > Tested-by: Kees Cook <keescook@chromium.org>
> > > Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
> 
> Kees, were you planning on taking this to Linus or someone else? It
> would be nice to have this in for -rc1 (although I understand it might
> be too late), if not, by -rc2.

I assumed Thomas would pick this up. Thomas, shall I send this directly
to Linus?

Thanks!

-Kees

> 
> Cheers,
> Nathan
> 
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > I built arm64 defconfig with and without
> > CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT with LLVM 12 (which does not have
> > Nick's LLVM fix) without any issues and did a quick boot test in QEMU,
> > nothing exploded.
> > 
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > > ---
> > >  include/linux/randomize_kstack.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
> > > index fd80fab663a9..bebc911161b6 100644
> > > --- a/include/linux/randomize_kstack.h
> > > +++ b/include/linux/randomize_kstack.h
> > > @@ -38,7 +38,7 @@ void *__builtin_alloca(size_t size);
> > >  		u32 offset = raw_cpu_read(kstack_offset);		\
> > >  		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
> > >  		/* Keep allocation even after "ptr" loses scope. */	\
> > > -		asm volatile("" : "=o"(*ptr) :: "memory");		\
> > > +		asm volatile("" :: "r"(ptr) : "memory");		\
> > >  	}								\
> > >  } while (0)
> > >  
> > > -- 
> > > 2.25.1
> > > 

-- 
Kees Cook
