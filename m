Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B7C40732B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 00:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbhIJWDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 18:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbhIJWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 18:03:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:02:26 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t19so6828630lfe.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 15:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XzTacFlQd7pif6s0lDv2nVF3UGfbv5X0f4QzGq7JY6M=;
        b=nj5BB3n4tQuIomz/YF1qyd+W4wEyIBpb8zOqx3lknPoJdYdBtjbp+3VHQUBmg8Xohc
         EYlTaOGXNLYlgm7aRC0J1k/THz6nUngkcE+BdLMA814w7/fp0UHk+2tvnuWvS30jvCUl
         wmPzTzamoYLxOI23CbrMy2RHZUI32BKXf3vmLtI2PUanKn6IE9a7xtic3c3eZtLW9yno
         QlBTWvX/cXJLYXfsJ6vSg9ZRn1d+K/49wHZAwo/T06gFZ5ilZ4OLJ3VI5H56ocAplCOk
         +X9rzURxp7mqAC/Sq4FQ9n6z/zGe2OufCudyg/xqyKUr8YVaxUrBZ5joTlll8FQ4T5y3
         d+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XzTacFlQd7pif6s0lDv2nVF3UGfbv5X0f4QzGq7JY6M=;
        b=swKAkcJmQmY2rTb8Gpn6d5xN9PXCPMYhGTOLPdx7RG1nTUbHLH2Ej2GtHFeSLe8Iwx
         KzCPGXy1rHvV0zr5HAhA8WHBQxW4bACH1ngJmVRoB2nZalJDyvgqAkz4MyHmq3w1dA6u
         bzjhqp4AzBJWzOiq4pGBAo/oc3y1hSZJXdlRnz0m9B3MgvDvaoV/2ypQAUBkHW929H0b
         98NoCl7rVp3+fK8LoMILg5aL7U27rljkcgJWamEUb8Fbpr87cIGQA1M4n5xBRfHmkbo+
         5fOCxkNQPsAaUp6zbj/b470ouKtXvRYgd1P0bYb14NM71+juPsEc+ZY+uGDT8bcP6tYW
         zzhw==
X-Gm-Message-State: AOAM532ZIC2xDJxiCbi2kFca7TrvoM0GobVXbope9ORhnxYN3aJwR8r9
        NKr+XYt3yOshEb7cIpDf3pcItoXBB3+eVGBuApLKRw==
X-Google-Smtp-Source: ABdhPJxRSAswcTLSTRIm3Ln0tP+kh58D4WocDBHslc4pK17UXELI+pvmrXYzZ+/esbPWxbohgrhx2wncU72Gbi2Wt7o=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr5208446lfa.523.1631311344797;
 Fri, 10 Sep 2021 15:02:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210909182525.372ee687@canb.auug.org.au> <20210909225035.3990728-1-ndesaulniers@google.com>
In-Reply-To: <20210909225035.3990728-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 10 Sep 2021 15:02:14 -0700
Message-ID: <CAKwvOd=hoPv2GMZws6UsnMHop6+662wer=Hfo2Tw2=1XXCY2JA@mail.gmail.com>
Subject: Re: linux-next: build failure while building Linus' tree
To:     sfr@canb.auug.org.au
Cc:     axboe@kernel.dk, josef@toxicpanda.com, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        llvm@lists.linux.dev, Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 9, 2021 at 3:50 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> + Rasmus
>
> This was introduced in
> commit f0907827a8a91 ("compiler.h: enable builtin overflow checkers and add
> fallback code")
> which added division using the `/` operator, which is problematic when checking
> for overflows of 64b operands on 32b targets.
>
> We'll probably need helpers from linux/math64.h and some combination of
> __builtin_choose_expr/__builtin_types_compatible_p.
>
> That will help us fix another compiler bug for older clang releases, too.
> https://github.com/ClangBuiltLinux/linux/issues/1438.

Ok, I have something hacked up that I think will work:
https://gist.github.com/nickdesaulniers/2479818f4983bbf2d688cebbab435863
This incomplete diff is a little hacked up to reproduce the issue with
a known-bad revision of clang that demonstrates a similar issue to GCC
4.9.  You can ignore the movement of check_mul_overflow and friends in
include/linux/overflow.h.

I think I'm going to break that up into 2 or 3 patches:
1. move is_signed_type from include/linux/overflow.h to perhaps
include/linux/typecheck.h.
2. add div64_x64, div_x64, and div_64 to include/linux/math64.h, use
them in include/linux/overflow.h to fix GCC 4.9
3. move multiply fallbacks out of
COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW for clang < 14.
-- 
Thanks,
~Nick Desaulniers
