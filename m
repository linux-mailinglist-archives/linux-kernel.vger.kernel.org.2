Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5751232C34E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353806AbhCDAGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 19:06:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388059AbhCCUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 15:48:21 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375C9C061756
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 12:47:41 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a17so30507946ljq.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24KhvMDb+89hqpiv9wi+VawtF0GyMftFsFrma/aYUMs=;
        b=Zl/HI38KDrtJilTvcl7lr2IPBWLLsYYRmjGn0HjrQDShjMtfufPPc0aNfKypd3tsCB
         MwUl4k7OuvxKG7NRUAkkcAnqIXp11ShogUgX5SA75DOfZ2x2yqQWznNGVxTngeBgF4+9
         VM/KudWxxk5YLDV4xswMOM0fAPOizLrsuAq4jpCGVqsHCBKw8C/fVUCRg7zwxg5NJA9I
         10h0s9BjMo33yEUC+7u0+VoKHm7tegIGzJpxAkdaNqU5f87h5Adk+mclH6qw9EXScMFN
         qzavxTNjK5Zj3PY0Hsd8CVvncz3eW8LUwqDnh+6iqQZeet898rSFp813lLN3MBoOi3Wg
         +MGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24KhvMDb+89hqpiv9wi+VawtF0GyMftFsFrma/aYUMs=;
        b=ZYiK9GyxmiZ9SRCuVEXt3mITCwIIS31t04g76Yn8xyvp++jWPSQLutfRGX1HrImjfz
         bmZ1HQYMg14IXQs9sFucOcwtqhjS1KuDHK7DVLFZ00ssjzdCPtiDq5aX7W4naPBmxxra
         OUkHPObraVPXSsqdmCEFbCvHbJHLp7l7VNufU3wNzyNFilqpPyn8XbKnhzUF0zlsonJ9
         YYj2tgrliXeuzJg527/oVq5ylCuzfVTj9X+891my8851bdhXUziOmajpVs10977hVZry
         QNneJ7WmAJ5pBsGYa1CDy3mGzHqwfe46IlbQ9/PxQqAl2syFqxYzUAFobzmdmTKNyD3T
         yflQ==
X-Gm-Message-State: AOAM530w3X+ztCwJ7H14eFwy0Od7gELEP0ttwn0VzmNa7wWnzJHKCMqi
        2Z64mYfGFxPj6IZXlsA/AFGFvh/LaEiMSRM94hN3iQ==
X-Google-Smtp-Source: ABdhPJxUmbxkkFZEVJfN4risvm7ty621iogBEJK4xDuAzpBtw9T3FMlhTvd/n1j8jnPB6FV9BAAWk7topgvKtb5q7qg=
X-Received: by 2002:a2e:92d6:: with SMTP id k22mr427625ljh.244.1614804459313;
 Wed, 03 Mar 2021 12:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20210303183333.46543-1-masahiroy@kernel.org>
In-Reply-To: <20210303183333.46543-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 3 Mar 2021 12:47:27 -0800
Message-ID: <CAKwvOdkhZGv_q9vgDdYY44OrbzmMD_E+GL3SyOk-jQ0kdXtMzg@mail.gmail.com>
Subject: Re: [PATCH 1/4] kbuild: remove LLVM=1 test from HAS_LTO_CLANG
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Sami

On Wed, Mar 3, 2021 at 10:34 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This guarding is wrong. As Documentation/kbuild/llvm.rst notes, LLVM=1
> switches the default of tools, but you can still override CC, LD, etc.
> individually.
>
> BTW, LLVM is not 1/0 flag. If LLVM is not passed in, it is empty.

Do we have the same problem with LLVM_IAS?  LGTM otherwise, but wanted
to check that before signing off.

(Also, the rest of the patches in this series seem more related to
DWARFv5 cleanups; this patch seems orthogonal while those are a
visible progression).

>
> Non-zero return code is all treated as failure anyway.
>
> So, $(success,test $(LLVM) -eq 1) and $(success,test "$(LLVM)" = 1)
> works equivalently in the sense that both are expanded to 'n' if LLVM
> is not given. The difference is that the former internally fails due
> to syntax error.
>
>   $ test ${LLVM} -eq 1
>   bash: test: -eq: unary operator expected
>   $ echo $?
>   2
>
>   $ test "${LLVM}" -eq 1
>   bash: test: : integer expression expected
>   $ echo $?
>   2
>
>   $ test "${LLVM}" = 1
>   echo $?
>   1
>
>   $ test -n "${LLVM}"
>   $ echo $?
>   1
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 2bb30673d8e6..2af10ebe5ed0 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -632,7 +632,6 @@ config HAS_LTO_CLANG
>         def_bool y
>         # Clang >= 11: https://github.com/ClangBuiltLinux/linux/issues/510
>         depends on CC_IS_CLANG && CLANG_VERSION >= 110000 && LD_IS_LLD
> -       depends on $(success,test $(LLVM) -eq 1)

IIRC, we needed some other LLVM utilities like llvm-nm and llvm-ar,
which are checked below. So I guess we can still support CC=clang
AR=llvm-ar NM=llvm-nm, and this check is redundant.

>         depends on $(success,test $(LLVM_IAS) -eq 1)
>         depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
>         depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
> --
> 2.27.0
>


--
Thanks,
~Nick Desaulniers
