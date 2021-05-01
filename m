Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2013704F1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 04:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhEACRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 22:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbhEACRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 22:17:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91015C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 19:16:47 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id s15so9142146plg.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 19:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tQtdPbaQcCHSATMeh3s5HzCozhEyZ/3PouIEknCwd+I=;
        b=suGDJg9AwAuQ4omYK/8EsK63RqcB6tk+BiM47bSz5efW/tMeh7tEFpDFBygEelfUbI
         qGhnI+u9qySOC1AyaniEljuXPPthqt/aIyel1VmJ5DsF/jcC4lhoYng6fCIjik98q+Ro
         u5GsoHigzu9Wy34ilD/QJaHlvUw1NBZDat/DYj1wgztvWS7xoTq585NkSypUy9GcrVVh
         JKmYw4E6Sf04ed4zoN4U0VtfAYpdBD+WyhN9npbVeE8K7rh9Z7VEP9/H1uD+C8VdBs1w
         dMjembF3Pvi1I2XWICrR3J9QTFoUSaWj9Rjl9qwj6WFOjL4Osg7kbQ1Aey0zI/dZFELl
         dPxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQtdPbaQcCHSATMeh3s5HzCozhEyZ/3PouIEknCwd+I=;
        b=NUhBKy3ON0BaUdukLInNIdi7T9Ba1Wz6BILhzOjzvfrgNTv6oWIc7rJ/b8zVfqnOR0
         m5YZGQNFv2KbL9JSy4ckd014qKuVUpU0C8Zqi6aeD/e6SSXNIRladcQvXPfTtv5vnfms
         /kOg5ydlUgNfk6CWeY4Iqw1Zh+JlDJeNA5Ao9wH9nGJ4FmHaTK8iaigAga60CwUP/e2M
         OpIZUhbrP8ukHX+AOUZWaiysA0Low9XzsgG+ZXypPLQHVgRFgcHTsWf0qESYb4xaNVJv
         vsmQ8yWPeyDNwhM6RTWO9gocD1MVUt2z7VC9GXplPh8+uQPVvbdXrE0OE4jW+WL4upBl
         aHgA==
X-Gm-Message-State: AOAM533yOqUAez6P9GkJ5RFa3pMGjk7Cp33QMWD6HdK8oh1qWUTEm2pN
        1ZFOmNJZwhUjiR2kxRk3gSYRaA==
X-Google-Smtp-Source: ABdhPJyJ988EyG2+wWd90pTtNeUkOhBl3So96DkWHcnfw6zHvOtA+oYh+R82eYu9+e9IGV4Nb1JG5A==
X-Received: by 2002:a17:90a:8c86:: with SMTP id b6mr18114177pjo.73.1619835406794;
        Fri, 30 Apr 2021 19:16:46 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:c8ff:cd89:d408:7b46])
        by smtp.gmail.com with ESMTPSA id a6sm3377544pfc.61.2021.04.30.19.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 19:16:46 -0700 (PDT)
Date:   Fri, 30 Apr 2021 19:16:42 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>, felixonmars@archlinux.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210501021642.yertoclugdbqq6m4@google.com>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-30, Nick Desaulniers wrote:
>On Fri, Apr 30, 2021 at 6:22 PM Linus Torvalds
><torvalds@linux-foundation.org> wrote:
>>
>> On Fri, Apr 30, 2021 at 5:25 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>> >
>> > Ah, no, sorry, these are the runtime link editor/loader. So probably
>> > spending quite some time resolving symbols in large binaries.
>>
>> Yeah. Appended is the profile I see when I profile that "make
>> oldconfig", so about 45% of all time seems to be spent in just symbol
>> lookup and relocation.
>>
>> And a fair amount of time just creating and tearing down that huge
>> executable (with a lot of copy-on-write overhead too), with the kernel
>> side of that being another 15%. The cost of that is likely also fairly
>> directly linked to all the dynamic linking costs, which brings in all
>> that data.
>>
>> Just to compare, btw, this is the symbol lookup overhead for the gcc case:
>>
>>    1.43%  ld-2.33.so             do_lookup_x
>>    0.96%  ld-2.33.so             _dl_relocate_object
>>    0.69%  ld-2.33.so             _dl_lookup_symbol_x
>>
>> so it really does seem to be something very odd going on with the clang binary.
>>
>> Maybe the Fedora binary is built some odd way, but it's likely just
>> the default clang build.
>>
>>              Linus
>>
>> ----
>>   23.59%  ld-2.33.so          _dl_lookup_symbol_x
>>   11.41%  ld-2.33.so          _dl_relocate_object
>>    9.95%  ld-2.33.so          do_lookup_x
>>    4.00%  [kernel.vmlinux]    copy_page
>>    3.98%  [kernel.vmlinux]    next_uptodate_page
>>    3.05%  [kernel.vmlinux]    zap_pte_range
>>    1.81%  [kernel.vmlinux]    clear_page_rep
>>    1.68%  [kernel.vmlinux]    asm_exc_page_fault
>>    1.33%  ld-2.33.so          strcmp
>>    1.33%  ld-2.33.so          check_match
>
>47.61% spent in symbol table lookup. Nice. (Not counting probably a
>fair amount of the libc calls below).
>
>>    0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor
>
>^ wait a minute; notice how in your profile the `Shared Object` is
>attributed to `libLLVM-12.so` while mine is `clang-13`?  Clang can be
>built as either having libllvm statically linked or dynamically; see
>the cmake variables
>LLVM_BUILD_LLVM_DYLIB:BOOL
>LLVM_LINK_LLVM_DYLIB:BOOL
>BUILD_SHARED_LIBS:BOOL
>https://llvm.org/docs/CMake.html
>
>I think those are frowned upon; useful for cutting down on developers
>iteration speed due to not having to relink llvm when developing
>clang. But shipping that in production? I just checked and it doesn't
>look like we do that for AOSP's build of LLVM.
>
>Tom, is one of the above intentionally set for clang builds on Fedora?
>I'm guessing it's intentional that there are packages for
>libLLVM-12.so and libclang-cpp.so.12, perhaps they have other
>dependents?

LLVM_LINK_LLVM_DYLIB (linking against libLLVM.so instead of libLLVM*.a)
has been around for a while.

Tom added CLANG_LINK_CLANG_DYLIB in 2019
(https://reviews.llvm.org/D63503 link against libclang-cpp.so instead of
libclang*.a or libclang*.so) :) So I'd guess this is a concious decision
for Fedora.

Arch Linux has switched to -DCLANG_LINK_CLANG_DYLIB=on as well
https://github.com/archlinux/svntogit-packages/blob/packages/clang/trunk/PKGBUILD
This is useful to make the total size of LLVM/clang dependent packages
(ccls, zig, etc) small.

If we don't let distributions use libLLVM.so libclang-cpp.so, hmmmm, I guess
their only choice will be crunchgen[1]-style
clang+lld+llvm-objcopy+llvm-objdump+llvm-ar+llvm-nm+llvm-strings+llvm-readelf+...+clang-format+clang-offload-bundler+...
(executables from packages which are usually named llvm, clang, and clang-tools)

[1]: https://www.freebsd.org/cgi/man.cgi?query=crunchgen&sektion=1

>>    0.83%  [kernel.vmlinux]    rmqueue_bulk
>>    0.77%  conf                yylex
>>    0.75%  libc-2.33.so        __gconv_transform_utf8_internal
>>    0.74%  libc-2.33.so        _int_malloc
>>    0.69%  libc-2.33.so        __strlen_avx2
>>    0.62%  [kernel.vmlinux]    pagecache_get_page
>>    0.58%  [kernel.vmlinux]    page_remove_rmap
>>    0.56%  [kernel.vmlinux]    __handle_mm_fault
>>    0.54%  [kernel.vmlinux]    filemap_map_pages
>>    0.54%  libc-2.33.so        __strcmp_avx2
>>    0.54%  [kernel.vmlinux]    __free_one_page
>>    0.52%  [kernel.vmlinux]    release_pages
>-- 
>Thanks,
>~Nick Desaulniers
