Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2B37200F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhECTBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 15:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhECTBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 15:01:16 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3170C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 May 2021 12:00:22 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id q2so4871901pfh.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 12:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q6rKBqfbWpNRJxPhhgqP74nxWxLm0jUmEd6rteF8gEQ=;
        b=RsH4uqpOxk2qYwp8eioXSAIwuHlB86nRQUZMVBohHAkBRLZg2Ab2DbqKanWYdNb4fk
         rUs63WLNdxOrlujAtwD6e+eJ7p7fWBF4RLxXCGYedto785RmlC6hUNSS2IRbvzwiSIFh
         InGSf25NU/LyTZUNwOw0t7WAahx2JOP1pZ6v5F5qhAb6mK+9JpO2ZJE62WI1KSiOmnhO
         beeMA03NznJGXEvr3Kn9rs88IUXo4RpJQiADWXYIBzESl9GffQDhhr9E0/yUdaNT5lLK
         EcOcpJMPafyGWZSrHt9FpzsRuBMm5NBDNsw1EdK4hsOE80dolwAlqpBJF2VOCDLey2ra
         nngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q6rKBqfbWpNRJxPhhgqP74nxWxLm0jUmEd6rteF8gEQ=;
        b=lLet1mbE/Sy3OD3DO2mjY6AJGsPG4hIaIzKgDg7qdoa2VILvCZMuBrOGiBlWXIaO+z
         O0cYPhZobWnbW46CfLfEc4LLCel2KwDkywX5nmC4ug2EAavVqfjtyU2LUyt6J6jdppbc
         pxxkPEAiA3CPWFLu9JfJJN5qj/pMs9ed71lvshBeKjLHU6GM7JkWSsz95Y6i4Za22xAg
         DYJlidzXc837JOCKaL9wTHHBsqygKYk9cyegxEG7X2sd7iMmNq3Qmf30CXD5CK1YQTHa
         XwZ4r5yBaPLC2YoOIVVAibexfPr77KDEaWo9HJm1LNnM1hEosSGeNs7if4IWj07pty/R
         g6VA==
X-Gm-Message-State: AOAM530NKuJx5J76Kx7pPOCmuTUa8lIBxLWaS4I45ciZpNjYiFMd9ks8
        SCc54Kc3jPKXem1FvoWwO8sZFSPBzpiXtQ==
X-Google-Smtp-Source: ABdhPJxh8gdpIzjAZL46P8/m949jc8dnmMpt0vMcKVWaQwGW0mPad0HQMxdPTRne2z7dO3YOUouv7A==
X-Received: by 2002:a17:90a:1d44:: with SMTP id u4mr140512pju.46.1620068421951;
        Mon, 03 May 2021 12:00:21 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:b55f:a57:7a3c:5bf7])
        by smtp.gmail.com with ESMTPSA id a185sm9629161pfd.70.2021.05.03.12.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 12:00:21 -0700 (PDT)
Date:   Mon, 3 May 2021 12:00:17 -0700
From:   Fangrui Song <maskray@google.com>
To:     Tom Stellard <tstellar@redhat.com>
Cc:     Dan Aloni <dan@kernelim.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Subject: Re: Very slow clang kernel config ..
Message-ID: <20210503190017.3r6mzy7xqx2bfwmk@google.com>
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <20210502051909.pac2pycninc7fl53@gmail.com>
 <6c4febd7-f826-9935-4163-138b1fed8278@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6c4febd7-f826-9935-4163-138b1fed8278@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-03, Tom Stellard wrote:
>On 5/1/21 10:19 PM, Dan Aloni wrote:
>>On Fri, Apr 30, 2021 at 06:48:11PM -0700, Nick Desaulniers wrote:
>>>On Fri, Apr 30, 2021 at 6:22 PM Linus Torvalds
>>><torvalds@linux-foundation.org> wrote:
>>>>    0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor
>>>
>>>^ wait a minute; notice how in your profile the `Shared Object` is
>>>attributed to `libLLVM-12.so` while mine is `clang-13`?  Clang can be
>>>built as either having libllvm statically linked or dynamically; see
>>>the cmake variables
>>>LLVM_BUILD_LLVM_DYLIB:BOOL
>>>LLVM_LINK_LLVM_DYLIB:BOOL
>>>BUILD_SHARED_LIBS:BOOL
>>>https://llvm.org/docs/CMake.html
>>>
>>>I think those are frowned upon; useful for cutting down on developers
>>>iteration speed due to not having to relink llvm when developing
>>>clang. But shipping that in production? I just checked and it doesn't
>>>look like we do that for AOSP's build of LLVM.
>>
>>There's also `-DLLVM_ENABLE_LTO=Thin` that enables LTO for building LLVM
>>and Clang themselves, considered they can be bootstrapped like this
>>using a previous version of Clang. Combining that with a non-shared
>>library build mode for both Clang and LLVM, the result is possibly the
>>fastest and most optimized build that is achievable.  Unfortunately I
>>see distributions neglecting to enable this in packaging this as well.
>>
>>On a side note, I'm also a Fedora user and agree with Linus about this.
>>I'd like to see an opt-in bypass of the shared library policy via
>>something like `dnf install clang-optimized` that would install the
>>fastest and most optimized Clang build regardless of RPM install size.
>>
>
>I have experimented with creating a static version of clang in the past,
>but never really found a solution I liked enough to upstream into Fedora.
>e.g. This solution[1] that we're using to bootstrap clang in our internal
>clang-as-the-default-cc Fedora buildroots that we use for testing.
>
>If someone could file a bug[2] against the clang package in Fedora (or RHEL even)
>with some data or other information that shows the downsides of the shared
>build of of clang, that would be really helpful.
>
>-Tom
>
>[1] https://src.fedoraproject.org/fork/tstellar/rpms/clang/c/dea2413c6822cc7aa7a08ebe73d10abf8216259f?branch=clang-minimal
>[2] https://bugzilla.redhat.com/
>

I have filed https://bugzilla.redhat.com/show_bug.cgi?id=1956484 with
information from my previous reply https://lore.kernel.org/lkml/20210501235549.vugtjeb7dmd5xell@google.com/

-fpic (.so) -fno-semantic-interposition -Wl,-Bsymbolic-functions is very
close to -fpic/-fpie (.a) in terms of performance.


(
If Fedora is willing to use -fprofile-use (profile guided optimization)
or ThinLTO, that's great as well, with the cost of much longer build time.)
