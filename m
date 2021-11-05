Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E172446987
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 21:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbhKEUUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 16:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbhKEUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 16:20:07 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEBBC061205
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 13:17:27 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 1so16858934ljv.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 13:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vuayPgK0AFa+ecEYX+ZQ8vgmFv5JEOwxSTm6d2kZs78=;
        b=RnLKexsrCAjWUIWwBZJfog7vhfH5WjN0Y7/YF3zs2wOqmrQE9nWihazTTbqcXtgNEP
         RNPZtzuvVpldX7fSo1DnFucJJy1OYubefmnOlOt62AtxzoQyyuWnY71JVUAnromuH+6B
         N9fAHe3RZqI/7+KL0cN3xwUnWjmvCjq0uiXvBd01XwM5XDotom9RHn19Q3GfLb/Fz1Xj
         gOIBEpcBsM2uNBBCVwGUov8nM49RQuzGEFZDgDlRddmnis4ves7gWRZyct12HUIsbO5G
         OFgp9Opri3GuuIE9wu8qeSYA5SeB7XS7Q+62+kZaBUEXN8LB9OD9gHn5BtjBTXCkuwtx
         2/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vuayPgK0AFa+ecEYX+ZQ8vgmFv5JEOwxSTm6d2kZs78=;
        b=EZQvFA6Zfj5D/g8TP206FM7naJYiFFEaWq+UCyPNcfDhliAsGcsyzgCTMmP8CcKKu2
         1FycpyPysc3fXTOtfnFe5j22QSPZJ77I5Z1Jh10GlImlpuRh5nTP3c2UwkA05UiDFu3R
         wH3yKqhPW/Ijhl17Q0LYxjxoq2mEyTWG8k8w1ivvI3Wiif/K9tHjClok2a+hyr5MMxmR
         WB+QLi879ubpxUvRQ/Z4O8o02oolcMIdRqiO55WArBnlY1dwCRhEd1NdIUxx0OQrGF7O
         jp0KCqV9DtqDtchxSh+FAnwjLT7WosUaBGTLZZIkXxXG6ZlIuXdxiIVug9dPynTz0U2N
         bHVQ==
X-Gm-Message-State: AOAM532a0kjRAtFOZsm6/+YZs85cDsNoLrzJFOTOG8kg9p4JLR7kmDZs
        vtMA4eHnjgUxoyH9K+D0UwMshNiuUuClqhrSsFTaDN8ocmo=
X-Google-Smtp-Source: ABdhPJwZM39NYLp6cBlt7OdvlReYZCF5U9ViiH0CM54S+pnKkPT65t3gV5XP9lM1W9YaFAsOziYunWIWhRBIKNm1sZI=
X-Received: by 2002:a2e:9192:: with SMTP id f18mr5264789ljg.220.1636143445722;
 Fri, 05 Nov 2021 13:17:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211105162756.3314148-1-anders.roxell@linaro.org>
In-Reply-To: <20211105162756.3314148-1-anders.roxell@linaro.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 5 Nov 2021 13:17:14 -0700
Message-ID: <CAKwvOd=dtb98Ue1xYz0gQmRGeQWdH6sBEkpXioevPQ94envK8A@mail.gmail.com>
Subject: Re: [PATCH] selftests: vDSO: parse: warning: fix assignment as a condition
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     shuah@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 5, 2021 at 9:28 AM Anders Roxell <anders.roxell@linaro.org> wrote:
>
> When building selftests/vDSO with clang the following warning shows up:
>
> clang -std=gnu99 -Wno-pointer-sign    vdso_test_gettimeofday.c parse_vdso.c  -o /home/anders/.cache/tuxmake/builds/current/kselftest/vDSO/vdso_test_gettimeofday
> parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
>                 if (g = h & 0xf0000000)
>                     ~~^~~~~~~~~~~~~~~~
>
> Rework to a parentheses before doing the check.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..b47b721a4ea4 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -62,7 +62,7 @@ static unsigned long elf_hash(const unsigned char *name)
>         while (*name)
>         {
>                 h = (h << 4) + *name++;
> -               if (g = h & 0xf0000000)
> +               if ((g = (h & 0xf0000000)))
>                         h ^= g >> 24;
>                 h &= ~g;
>         }
> --
> 2.33.0
>


-- 
Thanks,
~Nick Desaulniers
