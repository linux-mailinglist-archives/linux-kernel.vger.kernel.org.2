Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133673DDCA5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbhHBPpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbhHBPpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:45:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB6C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:45:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d6so17465555edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cMN4yc6Yg7k+g95Y7UmZLiL/P6GU424U+ZDesgvhHgU=;
        b=cQd6eHU1xNXbRSjFnHyZg5KKJ8qwmS312QYTIhTlKOvZHVz+vU5I1tTgW2BB0RFmES
         Z4EHxLLnIiMwBth28LK4Ahje7aFFktra/pnP5cFCug4SnUwmR6zGodWlrj8VYbluAqwQ
         YJi6LnO/Ryc3z7LAq+QKYt/TWmkRz5mZvE24aY7yFfW1JyXLaItJHEt86+y67qOOSTgE
         mt1yMy2iPuaKgK7CcNnSNx9YTscgoOCJgITwkVx9FihmNPRfqw5HHHBcqiZE9PhLGbYK
         lT1UqDwf/AQYapSCuVZ3aNLNUS30d0WEkBVdFHWhYEwB6rusx/Ph3bHdvZGhEx6h+usA
         nqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cMN4yc6Yg7k+g95Y7UmZLiL/P6GU424U+ZDesgvhHgU=;
        b=jz1P4Q4kX83Otc1N1HfQyLwvYN/yEVxiCJ6DpMoKsnibs+5S6ksLKR/xs6STGW9rXF
         AUbzh+5zgkDZehwLuQNwb8EbqkkNIIWtOfhtFy9FQI5zVITfxbnZ/Z58M7QQOsW0J0Qf
         hM/iJnyZa2hx7EPNPQDQ5/VMpfBz/sOUIgjrtwfMWSeAh7yJrhGJyPoh/5v7jgrsHC4u
         +Z9xCf0654/Lz1MuqEgagE85isSKZi9wEdlV6mTuBgpL3f9EwhUs4qKpmo5PCPOx1n2t
         R+6+1V6B7PIyKxHZhdmkoHcCtQLJZ7uJ0pD2PDiS7sFwameGx+VBrBBxn5UyQrigljIn
         uNMA==
X-Gm-Message-State: AOAM530BxxfzlIUX9Ki4j27eqarNOHP1iG5jliiN11FCmVVXSrvpCb1V
        GT5dObHO7L9agv+RVhDqM4a9LOre0+kKmDBc7IU=
X-Google-Smtp-Source: ABdhPJxT71L+T05yz/hq+Tsn15GIbWhZTIbquxkVkxucO5ulY894g/8MmOt6pCNq9/8xQxw7L9Urp1FEelq55p0lqoU=
X-Received: by 2002:a05:6402:274f:: with SMTP id z15mr20502581edd.21.1627919118096;
 Mon, 02 Aug 2021 08:45:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:3018:0:0:0:0 with HTTP; Mon, 2 Aug 2021 08:45:17
 -0700 (PDT)
In-Reply-To: <20210802141245.1146772-1-arnd@kernel.org>
References: <20210802141245.1146772-1-arnd@kernel.org>
From:   Martin Guy <martinwguy@gmail.com>
Date:   Mon, 2 Aug 2021 17:45:17 +0200
Message-ID: <CAL4-wQqCL1S-GYu7VKJeTT37wh=rR=SMUuwgKiXnnn_Y=uydOA@mail.gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: remove MaverickCrunch support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        soc@kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2021, Arnd Bergmann <arnd@kernel.org> wrote:
> The MaverickCrunch support for ep93xx never made it into glibc

This is true, but is not needed except for preserving FP registers in
catch/throw exeptions or longjmps.

> was removed from gcc in its 4.8 release in 2012.

I was sad about that, as I had managed to get it working correctly in
4.2 4.3 and 4.4.
Unfortunately the GCC ARM maintainer at the time was paid by ARM, and
they had no interest in it, as I gather the ARM-Cirrus partnership
ended up disappointingly.

> It is now one of
> the last parts of arch/arm/ that fails to build with the clang
> integrated assembler

Even if crunch support is not configured?

> According to Hartley Sweeten:
>
>  "Martin Guy did a lot of work trying to get the maverick crunch working
>   but I was never able to successfully use it for anything.

>   It "kind" of works but depending on the EP93xx silicon revision

It works fine on all production revisions except D0 (the first one)
which is so rare as to be unfindable. All the others from D1 on have
the exact same HW bugs.

>   there are still a number of hardware bugs that either give imprecise or garbage results.

Not my experience, See http://martinwguy.net/crunch/#CorrectnessTests
If "imprecise" means "doesn't handle unnormalized FP values correctly"
then yes, that's a feature if you need the 2.5 to 4gimes speedup it
provides.
But I would be interested (Hartley) if you have a concrete example.

> This touches mostly the ep93xx platform,

The ep93xx is the only chip series it was ever included in.

> If there are remaining users of MaverickCrunch, they can use LTS
> kernels for at least another five years before kernel support ends.

The only user ! am aware of is the HEAT deep space telescope in the Antarctic
http://martinwguy.blogspot.com/2015/10/maverickcrunch-code-runs-on-heat-deep.html

Personally I have no problem with removing kernel support if that
makes people's lives easier in some way.

  M

   M
