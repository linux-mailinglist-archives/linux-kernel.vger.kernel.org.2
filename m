Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3607844EA39
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhKLPiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234365AbhKLPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:38:53 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3772C06127A
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 07:36:02 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id f9so11515490ioo.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 07:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L6/KQ1RFxJPQ4chq26FdZA+80ab2qqgCfkSi6AoO2sM=;
        b=NKtAXmwald5E66M/zVscXACD4q1FMAJhx1nlyseZ50GgN+Bw+kDCkkay5O09Ug3x/K
         5k/sp05EECQxr04ywYgZqmFoegzqJ4T1YiRsyLK+1AuDxyngV1KX3jJXCzglBuE/g7As
         apzoHZcnmgGHxqswXB2vcTFM2plomMPL7TU1UL1bIzMptaTF4teerdDKV732rsWxcm3D
         MbQ6QZjaVu7+9KUQhzFNTLN4MYZxMo7j4E+CnNqmwV7+BSQIJICHA3hHQzHtktvCuPKU
         dIZqleP5yDVLNr+/ild/d/D7nVMaAt+80LTXASQ/9t4W34NYurDEfcZo7tkdjlMzZmW+
         jOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L6/KQ1RFxJPQ4chq26FdZA+80ab2qqgCfkSi6AoO2sM=;
        b=LYlW63zbXQ9gyb+6j3JYgVHSySHl1qUoVyxUUcjjXISGHPN3Lj/htPmWnswIbrTyW1
         i/6P7hZqakaWMSjZHzPAFDWejNX6nlHdxaQNEMW0/LWtKc4MiIGmrSFmJsBRpQkZFKe5
         E3OUnaQbQAMhajoTZ6AxcwCS/gqjb4My8WHUWI1fI3HSdSeiFsGNDka7GjGn+vsgthB3
         k0QejVAy9oGi6MOAmrLJ09xeWjuLFVKFyd3ghdq11vh+dAqNJPPKxr/1QFirnBTNS//X
         7lm2ijbypsuxMy4XUgCZfYoEb92AEKKt5e7y7a0Kkyzr6e91BO56/5uP9uJv+XZhLLH7
         IXXg==
X-Gm-Message-State: AOAM531U2De+eYe6yhsPw8EiIkwQTouBIt7IcSbnzbP4j6E1i3L3oyak
        xrOOWHKzuxIzzT4PhjU27AxsaQ99mal0VGZi9eyqJg==
X-Google-Smtp-Source: ABdhPJzjOBZfnEL1w9tiRLgepxRohZjmF3gM9Boh2m0xIc20HfSmCkou7fsiaE50e1kIKnIXtoawisgKa6a88Sh1K4s=
X-Received: by 2002:a05:6638:2055:: with SMTP id t21mr12599294jaj.90.1636731362002;
 Fri, 12 Nov 2021 07:36:02 -0800 (PST)
MIME-Version: 1.0
References: <1fcb636d-71ab-12e8-aa7f-c7ca4f89a5ed@intel.com>
In-Reply-To: <1fcb636d-71ab-12e8-aa7f-c7ca4f89a5ed@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 12 Nov 2021 07:35:49 -0800
Message-ID: <CAP-5=fXv7oxrxBnHqXNAdwK4ULPUcAVR5aFh1RV1NsTX3JuYxg@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf clang: Fixes for more recent LLVM/clang
To:     Ma Xinjian <xinjianx.ma@intel.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        daniel@iogearbox.net, jolsa@redhat.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, mark.rutland@arm.com, mingo@redhat.com,
        mpetlan@redhat.com, namhyung@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, peterz@infradead.org,
        sedat.dilek@gmail.com, philip.li@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 2:34 AM Ma Xinjian <xinjianx.ma@intel.com> wrote:
>
> Hi
>
> We build perf with clang also recently, but unlucky that failed with
> following errors:
>
>
> ```
> In file included from /usr/lib/llvm-7/include/llvm/ADT/STLExtras.h:21,
>                   from /usr/lib/llvm-7/include/llvm/ADT/StringRef.h:13,
>                   from /usr/lib/llvm-7/include/clang/Basic/Version.h:20,
>                   from test-clang.cpp:2:
> /usr/lib/llvm-7/include/llvm/ADT/SmallVector.h: In instantiation of
> 'void llvm::SmallVectorTemplateBase<T, true>::push_back(const T&) [with
> T = clang::driver::OffloadUnbundlingJobAction::DependentActionInfo]':
> /usr/lib/llvm-7/include/clang/Driver/Action.h:579:61:   required from here
> /usr/lib/llvm-7/include/llvm/ADT/SmallVector.h:313:11: error: 'void*
> memcpy(void*, const void*, size_t)' writing to an object of type 'struct
> clang::driver::OffloadUnbundlingJobAction::DependentActionInfo' with no
> trivial copy-assignment; use copy-initialization instead
> [-Werror=class-memaccess]
>       memcpy(this->end(), &Elt, sizeof(T));
>       ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from /usr/lib/llvm-7/include/clang/Driver/Driver.h:15,
>                   from test-clang.cpp:6:
> /usr/lib/llvm-7/include/clang/Driver/Action.h:549:10: note: 'struct
> clang::driver::OffloadUnbundlingJobAction::DependentActionInfo' declared
> here
>     struct DependentActionInfo final {
>            ^~~~~~~~~~~~~~~~~~~
> cc1plus: all warnings being treated as errors
> ```
>
> llvm version: 7
> rootfs: Debian10
> kernel: v5.8 v5.11 v5.15
> reproduce:
> $ cd linux/tools/perf
> $ make LIBCLANGLLVM=1 ARCH= EXTRA_CFLAGS='-fno-omit-frame-pointer
> -fsanitize=undefined -fsanitize=address'
>
> Would you please kindly point out what's wrong with our steps? Or can
> you give us your command to make perf with clang?

Hi Xinjian,

As the bug is in LLVM 7 there is little we can do in Linux perf to fix
the issue. I haven't got LLVM 7 on my machine to test with, but I see
the same problem with LLVM 6 - both of which are of course quite old.
My workaround is to add to the make command line
"CXXFLAGS=-Wno-error=class-memaccess". My full command line is:

make -C tools/perf O=/tmp/perf DESTDIR=/tmp/perf-install  DEBUG=1
LIBPFM4=1 NO_LIBBFD=1 LIBCLANGLLVM=1
LLVM_CONFIG=/usr/lib/llvm-6.0/bin/llvm-config
CXXFLAGS=-Wno-error=class-memaccess

I know Intel is keen on testing. Related to this code are the BPF
tests in "perf test". I frequently see flakes on these tests that
count the number of times a system call is called. The flakes are an
under or over count by 1. The over count by 1 I can explain if during
the test another process happens to use the same system call. The
under counting is harder to explain and is possibly an indication of a
data race. I'd be happy for any suggestions to fix these flakes.

Thanks,
Ian

> Thanks
> Ma Xinjian
