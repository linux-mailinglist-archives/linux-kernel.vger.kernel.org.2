Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A8B3704BA
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 03:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEABtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 21:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbhEABtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 21:49:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EB5C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:48:24 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id x2so6952785lff.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 18:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eBtHrA9yJb6BkyPbvCe4U6uwAdzA/QThsJuomereZNw=;
        b=tF2MeLtOeGN1CstFmVV4GWgQ2IPf2Kz1Syz+1idJe+MlI71IFJvPWpk6kgirsYfgnP
         MmGy6rxVciXgZvdfAO0mbflK25f16F3378MQapANn/NROJ7DZImWZT2Bi0kBB8P9kh+K
         RgDjiJ3FPb6QZNqvFM07TrqvRIL8XsoMfBOvar287KvyPOr0NQIWNELm51QLvFAkHLPl
         wpkHqI4wbmaBzRm8pTdJJSEfstbwi9scOKAB8cycN5mJYg3n0Vu3l98J7niZ19EXz/06
         G4GSGeaSsvldYyyORmbCYrDe3MnLNBAbzcxkoH3LgB7OrDxWI67ofEQBE4Ly6LfqVrMm
         YbDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eBtHrA9yJb6BkyPbvCe4U6uwAdzA/QThsJuomereZNw=;
        b=HZM7J1eoSVidjFfWd1HurAox4vL1y58Goghuqz4ByE0szrEwL79AXoc9nf3jXo3O9c
         8VnOXel5sRIiwmBfUILAqd63dL2aKN9eV1iY+fhRjdkeI+EWRsX2HCnotwX6fX6+bvH8
         tGd19tNJxm2o7Oj/l5MHleJY9LyXfmAjMO5bioJXWETCDdpLRehXSS9xwhXd0SzDLYLg
         3ORjWihJQiJGVzOoiTPb+EvuI9NNo01x+gp96jStljJzVWEg6+uEtbB6knxEHcFXoIUP
         oSwrNqo0YPj02wnDjjfXHgGssZiSYDXj+hg2KIzi/vuvVdkqXPJHCbqFaVExjcWBiVWP
         wdkA==
X-Gm-Message-State: AOAM531A8fG/6zWRY5OAHIqXkDcUg9dTaUt+os/v9wYZSEcWI5YlGnIa
        GaaIfuzLdOkBOIUkx8PDOCFU2LS7Okxuu8Dbrkgxww==
X-Google-Smtp-Source: ABdhPJw2QyTraX+L5v+kEa/RqCGKBwGfY4rexlaa9qVHnW52zGN2KiIaHtzCpc5ktejaZGfSvb6O+24GFy4J5FV/WTs=
X-Received: by 2002:a05:6512:2190:: with SMTP id b16mr5235875lft.122.1619833703046;
 Fri, 30 Apr 2021 18:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com> <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
In-Reply-To: <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 30 Apr 2021 18:48:11 -0700
Message-ID: <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 6:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 30, 2021 at 5:25 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Ah, no, sorry, these are the runtime link editor/loader. So probably
> > spending quite some time resolving symbols in large binaries.
>
> Yeah. Appended is the profile I see when I profile that "make
> oldconfig", so about 45% of all time seems to be spent in just symbol
> lookup and relocation.
>
> And a fair amount of time just creating and tearing down that huge
> executable (with a lot of copy-on-write overhead too), with the kernel
> side of that being another 15%. The cost of that is likely also fairly
> directly linked to all the dynamic linking costs, which brings in all
> that data.
>
> Just to compare, btw, this is the symbol lookup overhead for the gcc case:
>
>    1.43%  ld-2.33.so             do_lookup_x
>    0.96%  ld-2.33.so             _dl_relocate_object
>    0.69%  ld-2.33.so             _dl_lookup_symbol_x
>
> so it really does seem to be something very odd going on with the clang binary.
>
> Maybe the Fedora binary is built some odd way, but it's likely just
> the default clang build.
>
>              Linus
>
> ----
>   23.59%  ld-2.33.so          _dl_lookup_symbol_x
>   11.41%  ld-2.33.so          _dl_relocate_object
>    9.95%  ld-2.33.so          do_lookup_x
>    4.00%  [kernel.vmlinux]    copy_page
>    3.98%  [kernel.vmlinux]    next_uptodate_page
>    3.05%  [kernel.vmlinux]    zap_pte_range
>    1.81%  [kernel.vmlinux]    clear_page_rep
>    1.68%  [kernel.vmlinux]    asm_exc_page_fault
>    1.33%  ld-2.33.so          strcmp
>    1.33%  ld-2.33.so          check_match

47.61% spent in symbol table lookup. Nice. (Not counting probably a
fair amount of the libc calls below).

>    0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor

^ wait a minute; notice how in your profile the `Shared Object` is
attributed to `libLLVM-12.so` while mine is `clang-13`?  Clang can be
built as either having libllvm statically linked or dynamically; see
the cmake variables
LLVM_BUILD_LLVM_DYLIB:BOOL
LLVM_LINK_LLVM_DYLIB:BOOL
BUILD_SHARED_LIBS:BOOL
https://llvm.org/docs/CMake.html

I think those are frowned upon; useful for cutting down on developers
iteration speed due to not having to relink llvm when developing
clang. But shipping that in production? I just checked and it doesn't
look like we do that for AOSP's build of LLVM.

Tom, is one of the above intentionally set for clang builds on Fedora?
I'm guessing it's intentional that there are packages for
libLLVM-12.so and libclang-cpp.so.12, perhaps they have other
dependents?

>    0.83%  [kernel.vmlinux]    rmqueue_bulk
>    0.77%  conf                yylex
>    0.75%  libc-2.33.so        __gconv_transform_utf8_internal
>    0.74%  libc-2.33.so        _int_malloc
>    0.69%  libc-2.33.so        __strlen_avx2
>    0.62%  [kernel.vmlinux]    pagecache_get_page
>    0.58%  [kernel.vmlinux]    page_remove_rmap
>    0.56%  [kernel.vmlinux]    __handle_mm_fault
>    0.54%  [kernel.vmlinux]    filemap_map_pages
>    0.54%  libc-2.33.so        __strcmp_avx2
>    0.54%  [kernel.vmlinux]    __free_one_page
>    0.52%  [kernel.vmlinux]    release_pages
-- 
Thanks,
~Nick Desaulniers
