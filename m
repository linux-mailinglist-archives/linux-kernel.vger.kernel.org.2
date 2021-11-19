Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB49E456750
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 02:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbhKSBOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 20:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbhKSBOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 20:14:03 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6C0C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:11:02 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id l22so34919636lfg.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 17:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x50jM6pG1zOVTOkOckDcnqbrEYWJvq1YZ9GgThuybmM=;
        b=LnFuJ6GGDFKUBGHDotmBDPpidrdMYO7qSi+dbFiGNHOZ1yH1kiSUv+OIy6u/UTv3rv
         zyPxiEljS5zJlO38S5PNAVs16qHUHeDoXMrVuMVjjmgDx5YqOFVekYafSZ4YR3zf6Yga
         Xr5T8h21knWiZ0bsZnJ3HPb2SR66tnPPRYvcvLNpPPiXcyIYCe9W0MEIoL28YIzyMUee
         UY0gagpDJlyINCYnDEmJp/9p7tA3C0hp6PavO5ejhL4vWtJBTrxqLxdeQX9LgHN1CAjX
         l8W8XZEzJVMoQnbGwEk2IfnKFu1unQufwi/PBIl0hZo9M8hKp8Dva+GqCJOOeo1+BXYC
         qdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x50jM6pG1zOVTOkOckDcnqbrEYWJvq1YZ9GgThuybmM=;
        b=mDpc4IOv0aiLsfOkKrQVEXDcIlQRsNvXGmaa86NyLux68P8Ei25XfPPFWt8Lhx9Iv2
         ahMDB1icr5GQYBpthtAKgr66ciH3lAbq+wsGR70t5Rma4CEK0jI1pstB5qJD28d/WX72
         pwfLWM9i3yMwQem9G0s+I+7eMwHzH97u3ofXKFskV/39GOFcbpoG6333Iozh2CvwI+Na
         azHZl6rfB8bFk8ATSXwUVs3hLjkmUyF2a8PkeaEsBeuK/cHppPWhQqO6cpgEeDG2dHDu
         ZcWZqkqXv4Qy/Dgm9u2xraxZhdWc+F3wPtQa25bmmv9UHzZHXTn84D5SCKoHpAUbYtS0
         sB+Q==
X-Gm-Message-State: AOAM533RZpF1Y8APv1UOrQw88IyRXsBhY0s9ynUKbKshpcBPgIu7DDXj
        vz8kjErcy4GrIXC74FTIrToyk8Wxlw/KHvAI9sRuWrhG2gSGfg==
X-Google-Smtp-Source: ABdhPJzF60VCgIXOgoMT0JlxAr4h5sGo54t98q/f/v4/msXsJrdVT3pwUqhpV5SbV0W4z3FADWYSFJ+6mYSAM6KxLJk=
X-Received: by 2002:a05:6512:3b9c:: with SMTP id g28mr28619869lfv.651.1637284260284;
 Thu, 18 Nov 2021 17:11:00 -0800 (PST)
MIME-Version: 1.0
References: <20211117174822.3632412-1-ilie.halip@gmail.com>
In-Reply-To: <20211117174822.3632412-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Nov 2021 17:10:48 -0800
Message-ID: <CAKwvOd=9tsHHhPBOx2ORZoJP09VsX5dRZn58qj3MzCc2vmVosg@mail.gmail.com>
Subject: Re: [PATCH] s390/test_unwind: use raw opcode instead of invalid instruction
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Mete Durlu <meted@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, llvm@lists.linux.dev,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 9:48 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> Building with clang & LLVM_IAS=1 leads to an error:
>     arch/s390/lib/test_unwind.c:179:4: error: invalid register pair
>                         "       mvcl    %%r1,%%r1\n"
>                         ^
>
> The test creates an invalid instruction that would trap at runtime, but the
> LLVM inline assembler tries to validate it at compile time too.
>
> Use the raw instruction opcode instead.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1421
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

Ilie, thanks for the patch!

So if I understand
https://sourceware.org/binutils/docs/as/s390-Directives.html#s390-Directives
https://sourceware.org/binutils/docs/as/s390-Formats.html
that `e,` prefix is for 16B opcodes?

LGTM, thanks again.
Suggested-by: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I triple checked that GAS, clang, and GNU objdump are in agreement in
terms of encoding here.

> ---
>  arch/s390/lib/test_unwind.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
> index cfc5f5557c06..d342bc884b94 100644
> --- a/arch/s390/lib/test_unwind.c
> +++ b/arch/s390/lib/test_unwind.c
> @@ -176,7 +176,7 @@ static noinline int unwindme_func4(struct unwindme *u)
>                  * trigger specification exception
>                  */
>                 asm volatile(
> -                       "       mvcl    %%r1,%%r1\n"
> +                       "       .insn e,0x0e11\n"       /* mvcl %%r1,%%r1" */
>                         "0:     nopr    %%r7\n"
>                         EX_TABLE(0b, 0b)
>                         :);
> --
> 2.25.1
>


-- 
Thanks,
~Nick Desaulniers
