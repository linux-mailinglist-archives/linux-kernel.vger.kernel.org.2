Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9BC3DEDA5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 14:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbhHCMM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 08:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233906AbhHCMM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 08:12:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1D3C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 05:12:46 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p38so24412606lfa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjwFLstJrPnRmXg/rZRQYNcQZixdp2USEJZj3tF3f38=;
        b=QZvsRYa5PI0EjkNxpFJt0PjnkZl/KzLMkb06EW7T3tkTDAe4SGOPJhjWDkxfPWHvtP
         bXdVGwpVKHTCyVg74Io3kBqhbco3yndRvKndVVFP1tHO789dMj3mi3/UKGHCbUs+ZydN
         oqwUFqGcDgydpFFlJRoUTPa8ExjIjwY2nex7pkICvVHbSkG56SCi7BVTrYd1c5GPKxnu
         WYIuFov9/lUOjKg/fB7OpjVWR72yCX91lvbLkibrUvmaZovNuqrdFJE9FOkNSzdV86PG
         ffLRdFMBmEjJrK1qId5SfGLKqHKBDClc9krcDn3h9GL2lJhJ9kmrWkaIFG/sn/8eVOt3
         Qofg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjwFLstJrPnRmXg/rZRQYNcQZixdp2USEJZj3tF3f38=;
        b=sQL5L+oJhVUEm3BpK/juIHjDsiEwgZX3cOJZ2meYoh941L9Q/3hGZJD28ls3iXaPbM
         pldfABWf3Sf/LCQlrfcQ6SXcchOqO+3NXu56FCygvXB5280RPq0cn29xejbQWTf9WzBJ
         lNN1UaKgyUEhAKRvPpGnST3O0H+IGdWmqO+si0rQi86gm3uPTzoqgCm8XINVzyLRaxYe
         /luG/HdJoCONNA4GkgWS2JC2/6GnapfBFdIyE3fkhPqjbCB2jfrvsrDqWtmHPM6wbJjd
         s8Lnphp9RGHM6h+OO9MUMJ5UE49Krfr1WB+n43UsGPFKPB3su3HxIl6jCJit+0e+2R9v
         8qvw==
X-Gm-Message-State: AOAM533Vf6kPc2ju+5YTsi+Emw0Xq7oA927aJZc73AUel7jgeuYNYOh4
        Od4oBFJqkzdnpFcKcez1HLb5EiG5auqPgdFoBpncOg==
X-Google-Smtp-Source: ABdhPJz782mMUx2DQxPgWR7w25+Ro1pQSWnX/5zTyOK3W2u5RXz/AhlGd1Pib3weOa5vmkxj00IAN8QgYUu3dBYZqNw=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr15849594lfu.291.1627992764702;
 Tue, 03 Aug 2021 05:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210802141245.1146772-1-arnd@kernel.org> <CAL4-wQqCL1S-GYu7VKJeTT37wh=rR=SMUuwgKiXnnn_Y=uydOA@mail.gmail.com>
In-Reply-To: <CAL4-wQqCL1S-GYu7VKJeTT37wh=rR=SMUuwgKiXnnn_Y=uydOA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 3 Aug 2021 14:12:33 +0200
Message-ID: <CACRpkdbRbgjo1AkZVd0J1nhuo601o8=20rKR+ccaJR1+vqn6qg@mail.gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: remove MaverickCrunch support
To:     Martin Guy <martinwguy@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        SoC Team <soc@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 5:45 PM Martin Guy <martinwguy@gmail.com> wrote:

> > was removed from gcc in its 4.8 release in 2012.
>
> I was sad about that, as I had managed to get it working correctly in
> 4.2 4.3 and 4.4.
> Unfortunately the GCC ARM maintainer at the time was paid by ARM, and
> they had no interest in it, as I gather the ARM-Cirrus partnership
> ended up disappointingly.

Political issues aside, have you considered contributing support
to LLVM instead?

It currently doesn't even support ARMv4 AFAIK but reportedly
has an easier to use and maintain back-end. (I do not know if
this is true, I just browsed this:
https://llvm.org/docs/WritingAnLLVMBackend.html )
Current ARM Targets are here:
https://github.com/llvm/llvm-project/tree/main/llvm/lib/Target/ARM
And they have a very clear and straight-forward developer policy:
https://llvm.org/docs/DeveloperPolicy.html

If ARMv4 support could be added to LLVM, that would solve
a lot of my headaches for ARM32, where we have things like
SA110 being actively maintained.

Yours,
Linus Walleij
