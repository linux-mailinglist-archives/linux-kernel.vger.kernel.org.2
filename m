Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB0F325778
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhBYUU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233958AbhBYUUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:20:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E0B5D60235;
        Thu, 25 Feb 2021 20:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614284286;
        bh=v5oVTZBZwuQMLnpywUM1fAUATe03QvCjA1kY3odwcGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HK0vtCW3kBuIvp1H3XHNfG5tIR/K3dB+ICpVBWkg85qtBoONVXw8BD6jHd4bmxvVQ
         5MAaTrgdo3/UYwL5aiZtqcc/mCObhNztvtuzYKMoD+CXXnP8faul0+cNZ7Loq9kePx
         uo7isOwcGNziFamNjQmEcgjddlrXvUO3q20ZkLQP6h9RlN+VxfkkxdDgqt/JqOwELC
         PRTc/n9UTBOS78PMmL2wv6fthZq5ljDIaHku7ObQqrYnPHFGQRdkC/pIzIcF+2ji/u
         yfJ5ufXLhiASISZdRIssAAjYbIlgm2gR8921RvlT/8CNx4CuyA4k2XvfHe348ptqmv
         tFrk2NK3wrAiA==
Date:   Thu, 25 Feb 2021 13:18:01 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Message-ID: <20210225201801.GA3119@MSI.localdomain>
References: <20210225164513.3667778-1-arnd@kernel.org>
 <202102251203.03762F77@keescook>
 <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org>
 <202102251213.5815C9B33@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202102251213.5815C9B33@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 12:14:17PM -0800, Kees Cook wrote:
> On Thu, Feb 25, 2021 at 12:06:37PM -0800, Andrew Morton wrote:
> > On Thu, 25 Feb 2021 12:03:48 -0800 Kees Cook <keescook@chromium.org> wrote:
> > 
> > > On Thu, Feb 25, 2021 at 05:45:09PM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > > 
> > > > Separating compiler-clang.h from compiler-gcc.h inadventently dropped the
> > > > definitions of the three HAVE_BUILTIN_BSWAP macros, which requires falling
> > > > back to the open-coded version and hoping that the compiler detects it.
> > > > 
> > > > Since all versions of clang support the __builtin_bswap interfaces,
> > > > add back the flags and have the headers pick these up automatically.
> > > > 
> > > > This results in a 4% improvement of compilation speed for arm defconfig.
> > > > 
> > > > Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > Cc: stable@vger.kernel.org
> > 
> > I figured 4% better compile time isn't significant enough to justify a
> > backport.  Thoughts?
> 
> It's a trivial change, so I think it's worth it?

Indeed. Any wins that we can get with compile time, we should take.
Clang is being widely used in production systems now so I feel like with
a trivial change plus user visible impact, it should be backported.

Not to mention that the generated code in theory should be better
because it is the compiler's builtin, rather than a hand rolled one, AND
this is technically a regression, given that it worked before compiler.h
was split.

Cheers,
Nathan

> > 
> > > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> -- 
> Kees Cook
