Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B09137052B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 05:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbhEADeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 23:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55923 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231254AbhEADeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 23:34:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619839994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ic6WLfM9JZHskkeRs9yuPGyluIWG+pwNAwtsEHdTo4=;
        b=X0LKGRF2qvuQcyM13BynnkEccgmrnu9FPAG+2eECo5Z1m1uJID6di12hlLq4Qw050tR6ZL
        DQ6f2KjGalru8PuDxPBhZRQXPWaBwJry72ghPP6wmRQui7VQN6Ev7lzp5CoRfvujDVYtsD
        I38M9CA4+w3QoLxRyr0zft84bmjhMgY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-uRFXHhPwNHGvnK0T7bZBQQ-1; Fri, 30 Apr 2021 23:32:33 -0400
X-MC-Unique: uRFXHhPwNHGvnK0T7bZBQQ-1
Received: by mail-qk1-f197.google.com with SMTP id v15-20020a05620a090fb02902e4d7d50ae2so258684qkv.19
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 20:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ic6WLfM9JZHskkeRs9yuPGyluIWG+pwNAwtsEHdTo4=;
        b=XQfMSe/n32xDT3uC5+cErNLCCt8EQI32eJu8Ect3H3xytTnXBnztKJ1il37I+3n3io
         WVD6aGlJBYOosIkFTGKfEjXbCpsWcu9Aw7iQrh8+aUuIfyBP+4Gqa7/nIpVC45goZ8/D
         cJ7Ec62rbpPbL/FCocKq/1Gg2k9yBuTcViQIlaCgIJNYBrzm1dsffFT/plxEL6H6MC+O
         JCCQSNh3SzFurApaXcjtvwfeUX4p1k1GbQqenPRjo7KHIrFKH+Rdzt1or0l+oZLtVwTW
         u94/lfXdQAvUJFjkFqs2sIszZLS+gmsJzNgKjJ8jBPbqwnhU62sjGA4/HbEwvOMvdSBF
         qo6A==
X-Gm-Message-State: AOAM530iN0fo4vhAHCmsEG4ovMfsINV6VKHgHK1AQL9pR8ZFc+GXFbTT
        L7baH3m+L35PdjFU+aS/iwrH8AOrQLrCLu/J1UczZ5NhJo3CXW3hNI+w5ZEqvz/aPheQB3ibBf7
        dqNbkBRZhfM/RlrH6CbpAaysu
X-Received: by 2002:a05:620a:29cc:: with SMTP id s12mr8967722qkp.72.1619839952683;
        Fri, 30 Apr 2021 20:32:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzoQZRBhgDlkMQkLiePnLzsscqed2S/BQ6KhNTgSknNpL4+tfXta1FUf85j9VeRtgyUIXKQ7g==
X-Received: by 2002:a05:620a:29cc:: with SMTP id s12mr8967712qkp.72.1619839952465;
        Fri, 30 Apr 2021 20:32:32 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-157-68.ptld.qwest.net. [97.120.157.68])
        by smtp.gmail.com with ESMTPSA id r18sm3668831qtn.90.2021.04.30.20.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Apr 2021 20:32:32 -0700 (PDT)
Subject: Re: Very slow clang kernel config ..
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
From:   Tom Stellard <tstellar@redhat.com>
Message-ID: <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
Date:   Fri, 30 Apr 2021 20:32:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/21 6:48 PM, Nick Desaulniers wrote:
> On Fri, Apr 30, 2021 at 6:22 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Fri, Apr 30, 2021 at 5:25 PM Nick Desaulniers
>> <ndesaulniers@google.com> wrote:
>>>
>>> Ah, no, sorry, these are the runtime link editor/loader. So probably
>>> spending quite some time resolving symbols in large binaries.
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
>>     1.43%  ld-2.33.so             do_lookup_x
>>     0.96%  ld-2.33.so             _dl_relocate_object
>>     0.69%  ld-2.33.so             _dl_lookup_symbol_x
>>
>> so it really does seem to be something very odd going on with the clang binary.
>>
>> Maybe the Fedora binary is built some odd way, but it's likely just
>> the default clang build.
>>
>>               Linus
>>
>> ----
>>    23.59%  ld-2.33.so          _dl_lookup_symbol_x
>>    11.41%  ld-2.33.so          _dl_relocate_object
>>     9.95%  ld-2.33.so          do_lookup_x
>>     4.00%  [kernel.vmlinux]    copy_page
>>     3.98%  [kernel.vmlinux]    next_uptodate_page
>>     3.05%  [kernel.vmlinux]    zap_pte_range
>>     1.81%  [kernel.vmlinux]    clear_page_rep
>>     1.68%  [kernel.vmlinux]    asm_exc_page_fault
>>     1.33%  ld-2.33.so          strcmp
>>     1.33%  ld-2.33.so          check_match
> 
> 47.61% spent in symbol table lookup. Nice. (Not counting probably a
> fair amount of the libc calls below).
> 
>>     0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor
> 
> ^ wait a minute; notice how in your profile the `Shared Object` is
> attributed to `libLLVM-12.so` while mine is `clang-13`?  Clang can be
> built as either having libllvm statically linked or dynamically; see
> the cmake variables
> LLVM_BUILD_LLVM_DYLIB:BOOL
> LLVM_LINK_LLVM_DYLIB:BOOL
> BUILD_SHARED_LIBS:BOOL
> https://llvm.org/docs/CMake.html
> 
> I think those are frowned upon; useful for cutting down on developers
> iteration speed due to not having to relink llvm when developing
> clang. But shipping that in production? I just checked and it doesn't
> look like we do that for AOSP's build of LLVM.
> 

BUILD_SHARED_LIBS is the only one that is discouraged and we don't use
that in Fedora any more.  We just use LLVM_LINK_LLVM_DYLIB and the
clang equivalent.

> Tom, is one of the above intentionally set for clang builds on Fedora?
> I'm guessing it's intentional that there are packages for
> libLLVM-12.so and libclang-cpp.so.12, perhaps they have other
> dependents?
> 

Yes, it's intentional.  Dynamic linking libraries from other packages is
the Fedora policy[1], and clang and llvm are separate packages (in Fedora).

- Tom

[1] https://docs.fedoraproject.org/en-US/packaging-guidelines/#_statically_linking_executables

>>     0.83%  [kernel.vmlinux]    rmqueue_bulk
>>     0.77%  conf                yylex
>>     0.75%  libc-2.33.so        __gconv_transform_utf8_internal
>>     0.74%  libc-2.33.so        _int_malloc
>>     0.69%  libc-2.33.so        __strlen_avx2
>>     0.62%  [kernel.vmlinux]    pagecache_get_page
>>     0.58%  [kernel.vmlinux]    page_remove_rmap
>>     0.56%  [kernel.vmlinux]    __handle_mm_fault
>>     0.54%  [kernel.vmlinux]    filemap_map_pages
>>     0.54%  libc-2.33.so        __strcmp_avx2
>>     0.54%  [kernel.vmlinux]    __free_one_page
>>     0.52%  [kernel.vmlinux]    release_pages

