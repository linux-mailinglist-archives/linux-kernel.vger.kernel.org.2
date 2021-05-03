Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E457371CB0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbhECQ4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41907 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234345AbhECQuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620060552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yu8qvLbcCAvAnFk4XShMevVgYK+FRf9Q7zPytdY+pxs=;
        b=ej0Ky9MIlmNHxHQB9eq3HyhMduY9dCUOxkJ8Didgao2FUnVZP42Gz/OodckMRwbRUnJh/L
        3m+VNYnfbf/WFR+ekVHw1AN4IxmaIRIX/foRO60QU9TBldCvFveEuxuD27gie7ewNxN2rS
        45t7LO/rVL7FtIfJ9+zTF71/p0ENX/M=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-NdpJuQ0hNfG3HqZJdUHOYQ-1; Mon, 03 May 2021 12:49:00 -0400
X-MC-Unique: NdpJuQ0hNfG3HqZJdUHOYQ-1
Received: by mail-qv1-f69.google.com with SMTP id l5-20020a0ce0850000b02901c37c281207so5351340qvk.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 May 2021 09:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Yu8qvLbcCAvAnFk4XShMevVgYK+FRf9Q7zPytdY+pxs=;
        b=bNnDp6ab1f/3HqPl85Kf9Rap78pXS98YXYWoR3ooIVZGXqp3yF84TNRc0Tr0uUo8Vx
         roQiV93ikv6JZG9gThs7TFWIeyI+cbIaheUqV7NRU4pPZF3Mwhiz04V+AHwSkClrMSR6
         qhl4ZU7jJb8YnPqSKz7c3umEJl0bKg/jAKcukbCevHLy2uG1X2jjeP7OV7ItsesuqLQX
         VTFyunK5s36IZQKDnXrS8DOPGDOgIYDVhBIMiVq/6RN9DkNNawXNxUT9ZDJacz7iVvZZ
         IAOnhUjLmO+3aVuEP8nrYEiglnZx0Jsdcic8w0yyndEsWDfN2dCBxvkIeEjk5BfdrFS5
         fdsQ==
X-Gm-Message-State: AOAM5337dCe8d2jGuStkKeRy9KyENgmhzlD+dXRTCunosdWyY4fS899N
        RbRSThCIPdviOdfKrmsRmjGi214QxTyCYSTVttd7HJmstsXugRGxwTlsixFRH+9IBrwgOGBai0w
        xT2abx4fV3AXwG1CZpPd9PLzO
X-Received: by 2002:a05:620a:389:: with SMTP id q9mr11102365qkm.16.1620060540315;
        Mon, 03 May 2021 09:49:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSuxiLKU67DxP9/bQQSV42FrEMmUAy+CPtpsTDJ84wjpgtFRGRfnPVaVZfE/oG41iJe416ww==
X-Received: by 2002:a05:620a:389:: with SMTP id q9mr11102350qkm.16.1620060540143;
        Mon, 03 May 2021 09:49:00 -0700 (PDT)
Received: from tstellar.remote.csb (97-120-191-206.ptld.qwest.net. [97.120.191.206])
        by smtp.gmail.com with ESMTPSA id s25sm8447596qkj.34.2021.05.03.09.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 May 2021 09:48:59 -0700 (PDT)
Subject: Re: Very slow clang kernel config ..
To:     Dan Aloni <dan@kernelim.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
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
 <20210502051909.pac2pycninc7fl53@gmail.com>
From:   Tom Stellard <tstellar@redhat.com>
Message-ID: <6c4febd7-f826-9935-4163-138b1fed8278@redhat.com>
Date:   Mon, 3 May 2021 09:48:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210502051909.pac2pycninc7fl53@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/21 10:19 PM, Dan Aloni wrote:
> On Fri, Apr 30, 2021 at 06:48:11PM -0700, Nick Desaulniers wrote:
>> On Fri, Apr 30, 2021 at 6:22 PM Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>>     0.92%  libLLVM-12.so       llvm::StringMapImpl::LookupBucketFor
>>
>> ^ wait a minute; notice how in your profile the `Shared Object` is
>> attributed to `libLLVM-12.so` while mine is `clang-13`?  Clang can be
>> built as either having libllvm statically linked or dynamically; see
>> the cmake variables
>> LLVM_BUILD_LLVM_DYLIB:BOOL
>> LLVM_LINK_LLVM_DYLIB:BOOL
>> BUILD_SHARED_LIBS:BOOL
>> https://llvm.org/docs/CMake.html
>>
>> I think those are frowned upon; useful for cutting down on developers
>> iteration speed due to not having to relink llvm when developing
>> clang. But shipping that in production? I just checked and it doesn't
>> look like we do that for AOSP's build of LLVM.
> 
> There's also `-DLLVM_ENABLE_LTO=Thin` that enables LTO for building LLVM
> and Clang themselves, considered they can be bootstrapped like this
> using a previous version of Clang. Combining that with a non-shared
> library build mode for both Clang and LLVM, the result is possibly the
> fastest and most optimized build that is achievable.  Unfortunately I
> see distributions neglecting to enable this in packaging this as well.
> 
> On a side note, I'm also a Fedora user and agree with Linus about this.
> I'd like to see an opt-in bypass of the shared library policy via
> something like `dnf install clang-optimized` that would install the
> fastest and most optimized Clang build regardless of RPM install size.
> 

I have experimented with creating a static version of clang in the past,
but never really found a solution I liked enough to upstream into Fedora.
e.g. This solution[1] that we're using to bootstrap clang in our internal
clang-as-the-default-cc Fedora buildroots that we use for testing.

If someone could file a bug[2] against the clang package in Fedora (or RHEL even)
with some data or other information that shows the downsides of the shared
build of of clang, that would be really helpful.

-Tom

[1] https://src.fedoraproject.org/fork/tstellar/rpms/clang/c/dea2413c6822cc7aa7a08ebe73d10abf8216259f?branch=clang-minimal
[2] https://bugzilla.redhat.com/

