Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22B5940112B
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 20:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbhIESXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbhIESXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 14:23:13 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D499C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 11:22:10 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g14so7318458ljk.5
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LuzVizyAuYqHM0AliftUFw5ek+vQ04sENoGLph3J4G8=;
        b=AIFCfiSSpGgY7MUaHEa3Qj4MKzCJxCu0f6raW0F39EQvOva5pXNOooqwk5WLrYzBfM
         NuO+/AshqrQSL9zlmUOYTsetjWA2F16etVq3ZYxSdEu7BRnbZxAH0vF2j9gSHIJrzVz9
         ZkOeBSiFuWw/3g0HD+rnzcW/qkb65bbSttM54=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LuzVizyAuYqHM0AliftUFw5ek+vQ04sENoGLph3J4G8=;
        b=LVNH8xVpu8iT1efEfQF1tOuP1m2NRbplY+i98zOsjj3ncH91euJPYsqwgcp4MX2Lxl
         w06GtZ0uAhZxF6UK88ZxabekjQR5L/Oe6/6EjuXv1Xw1KtBkjT5l57+XLBVhSA+9AF6k
         LR24HnGm8XQqLkGnMf7Ly/jFPDEDCwvdqVGapvVVjyg1bGfi4N7TY0jaxI76W3ShQhXk
         xfabAhKCVt/hVB8hiZ/AguZrwSm97nvaJojDoW7vzPBMq9vAycuHm6SZsrVBq8ZeGr5a
         1+AVjH221QXERdGelFRizTd3ROx8qEEGz/kbuPOpGUEurKtNffPvqTfzbO1J64oXAEBw
         dNyw==
X-Gm-Message-State: AOAM533pFe+iPO2q4Dg+sdU4spMb4uAP+tFqOyUteoKBkMU980ixs4aO
        qWluA3DIfudH/HTADGH+RAIp8aqQFeKDbv/ef84=
X-Google-Smtp-Source: ABdhPJxSF3QqO294LjKKknZ+WVw4guIdiYindh7KgIMd2YQ2ZdelXDnb4BGh22caM7+hnENewFWFHQ==
X-Received: by 2002:a2e:a225:: with SMTP id i5mr7622399ljm.64.1630866126950;
        Sun, 05 Sep 2021 11:22:06 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k11sm567820lfg.300.2021.09.05.11.22.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 11:22:06 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id d16so7341927ljq.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 11:22:05 -0700 (PDT)
X-Received: by 2002:a2e:96c7:: with SMTP id d7mr7555806ljj.191.1630866125415;
 Sun, 05 Sep 2021 11:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <202109022012.756B6B5B79@keescook> <CAHk-=wiPOXS2f90Ykk3V76sJLx0wMVywke8pc=88r1trmDuhmw@mail.gmail.com>
 <45312958-B844-4B4C-9808-8205866675A1@chromium.org> <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
In-Reply-To: <CAHk-=widUkzjVMW99L6OZpJc1wDnZbBbnOOzgXOMypOPoV6mjg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Sep 2021 11:21:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4EG=kCOaqyPEq5VXa97kyUHsBpBn3DWwE91qcnDytOQ@mail.gmail.com>
Message-ID: <CAHk-=wj4EG=kCOaqyPEq5VXa97kyUHsBpBn3DWwE91qcnDytOQ@mail.gmail.com>
Subject: Re: [GIT PULL] overflow updates for v5.15-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Daniel Vetter <daniel@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithp@keithp.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 5, 2021 at 10:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Sadly, I don't think linux-next checks for warnings.
>
> I really want to enable -Werror at some point, but every time I think
> I should, I just end up worrying about another random new compiler (or
> a random old one).
>
> We do have -Werror in various configurations (and in some sub-trees).

Whatever. I'll just make a new config option, make it 'default y', and
it will be on for anybody doing allmodconfig builds etc.

And if people have new compilers, or odd configurations that still
cause warnings, they can turn it off, but hopefully this will make
compiler warnings in linux-next (or any other automated builds) cause
a lot more noise.

              Linus
