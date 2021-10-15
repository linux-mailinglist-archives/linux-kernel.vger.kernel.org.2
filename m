Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E899E42F107
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhJOMjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235537AbhJOMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:39:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E65C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:37:08 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id j8so6933050ila.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 05:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OBCobx1elChS3S72aWgPkS35OCuA3QaSZD8Frtc45ag=;
        b=iJTMVr8H9Pc1mfOZ3QaqwqH7z0uikzveNVHw3RlNcVIO4ADVpV26rzeDIpkQyb3Xin
         bOMAyTKd8pebx+gbZO51dAmO6ur/GHab1k25f/GHBfUBmbgNkwoiIDnDaCbLWlmMaWR5
         ohmjzl5q0NHxwOPkAFojgY8uwWcwJ1t6a5z42UnNYkEgitm/43iz88WfL9CbC/pB7dVY
         gRhjuGrgocpww19juqupsYVoTGAngXYV3WyAlOolzz26L6Pe7/MQANlEY75dWARdjhgU
         QxMCD3H498TL3YOPUFzN2RK5urlwBRfkFYBmM/Gs7b6vg4+7ikucU1WyNq6xq6spH5RC
         hDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OBCobx1elChS3S72aWgPkS35OCuA3QaSZD8Frtc45ag=;
        b=3nZh4OtsoB2McQ73hzaPtoWaDFZwm7k/Z7Y24+X08Poce2Jn6iiFRTD1MLsAkgOHvE
         h85jXFnljYsEcQKLLfkiaEW2d7KLXgToalMMKO20TIFlnsQ6RXaUqkvGncQd59pXCZHg
         zKLHTlcbUdf+XO8RuvX3shm+K82xnwrMo7NriGL477QSpTNBWRBBY1e4JV3z4129CsCZ
         FcC39608nLniXT0mJr+JO5cSHWGenDda5xuwxHTYmx2RmVrC6s/ZRBqOXM5/VxOdS55h
         Uf8jOHnVPrVoBMeDzqSiZBuIpl2JikFNszjyTSWxgh5Yq9IrW4Y6dR9iokcWbkAn10DZ
         7jXw==
X-Gm-Message-State: AOAM530n0xd9/Kpthe179NKT8poqCYeN7QLpwOgbt2pABj/+BYkyckdO
        8AMi2Z7ISE+r0TlV5xWTSCNYUafo1UWwfMZADOw=
X-Google-Smtp-Source: ABdhPJy08tjEX/TX/biV5oNsvhja4qA/4EvwJCIrAXxvtOgtJmRKi6+IKCsjW5Z5vwGkurS7u2XPMLAkgUrh0ierg9k=
X-Received: by 2002:a05:6e02:1688:: with SMTP id f8mr3667088ila.72.1634301427629;
 Fri, 15 Oct 2021 05:37:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211014132331.GA4811@kernel.org> <YWhGQLHnA9BIVBpr@hirez.programming.kicks-ass.net>
 <CAKwvOdnkDUfRKzmLThQGW02Ew6x=KM0MQyHge7=kc673NYxo2g@mail.gmail.com> <d1c957c4-a2df-935c-2992-3540f05fb110@rasmusvillemoes.dk>
In-Reply-To: <d1c957c4-a2df-935c-2992-3540f05fb110@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 15 Oct 2021 14:36:56 +0200
Message-ID: <CANiq72ne8m4q1rRToJsH1A+b1_7FAk1wYtcwvKc9zH_8sR2-gQ@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: mark __compiletime_assert failure as __noreturn
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:11 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> A yakshave that would be worthwhile is to kill off the macro
> compiletime_assert() completely - three is a crowd. It sounds like it
> would be implemented in terms of _Static_assert, but it's actually
> __attribute__(error). We can fold the definition of compiletime_assert
> into BUILD_BUG_ON_MSG.

Agreed, two should be enough.

> Why do we even have a no-op version if !__OPTIMIZE__? AFAIK there's no
> CONFIG_O0 option, and such a build wouldn't be interesting at all - it
> can't be expected to boot, and it would likely throw warnings left and
> right.

Yeah, I don't think it would compile as it is anyway.

Perhaps it is there for some kind of tooling? For a static analyzer or
something like sparse (if it didn't have its own define)...

But yeah, every use of it should have a comment explaining why it is
there, like crypto/jitterentropy.c does. There are a couple without
it.

Cheers,
Miguel
