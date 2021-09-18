Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA27C4108B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 23:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhIRVUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 17:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhIRVUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 17:20:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE140C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 14:19:15 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c22so44081536edn.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVZJu4t/IugUGV+W6kU+ykKkbEaLVPP4RIQU42du5mE=;
        b=NO0esR917j83JwTOpZQWYClId3457L6NJIf6fJ7Evei4pDJ6w9tdhLXDN3IinOEvW+
         VMthkeYirKlrzLR7LCf4USQHGLJ9wmo5a/QkxpfY9+CPatz4XjsnDZX+q2dIqcXYIANe
         4/RbL5IIz9wKXWQ+bU6E9Y8mF2Wc3GAB8iq/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVZJu4t/IugUGV+W6kU+ykKkbEaLVPP4RIQU42du5mE=;
        b=sJ6w94klytXSDYOAjwg1dd2NRtSU0ke2s4pir/qn/TKNs0HK9Ukmo3NXNwg7uN79zS
         OvA3sqFsq6o7Dq54U5c98IfFyE0hJ9UTyhP4+PHJeog0Sm7d6DjpU0cWQ/D+vXdQJWIf
         u9w5IStCGal+JSr1bVQ80dCR2NH1NIzL5zSmHobHta7KBmn7KPHu8UoIfBpC86o6FJX/
         g7cEcjyCGdm/XubG0pZDWXVoRU9Kh6ahzzwQ5C/3xWHrrIjZaLWYsXuE/qT7KGFzZFVs
         xuiaY8Lso+X6DW6XxrUOZkiygrrcQBzaBw13P8PwWXqaf6PsEcXVfb4BH9EmUUXCWfb4
         3W9g==
X-Gm-Message-State: AOAM531x8Rp3V/SRSpTiqg5ZR1ATU60wxRmCN7dnaaQ9NNv76e2cA88G
        vslBUfCS6J+3prAVnG2U0HogTnYWANu3790sN4Y=
X-Google-Smtp-Source: ABdhPJyNdhUhJ6tb24ndbhnHIxZnwMzlFCkWcegYulIAZZyvSkDj3COL+M7odtGq2sHGMcL7Y78rkw==
X-Received: by 2002:a17:906:e20e:: with SMTP id gf14mr20241035ejb.244.1631999954227;
        Sat, 18 Sep 2021 14:19:14 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id h10sm4843284edf.85.2021.09.18.14.19.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 14:19:14 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id t8so21239799wrq.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 14:19:14 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr16412051ljg.68.1631999551766;
 Sat, 18 Sep 2021 14:12:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
 <202109182026.18IKQLng003683@valdese.nms.ulrich-teichert.org> <CAHk-=wjZukwHDpm6PUP=cFTi8wWQs6Z5Np7xv7SRphNqvm0FPw@mail.gmail.com>
In-Reply-To: <CAHk-=wjZukwHDpm6PUP=cFTi8wWQs6Z5Np7xv7SRphNqvm0FPw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 14:12:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whswL8vPtdVphebUwdDd2Y-9j2d8XAd35bB+mqrhc0YTA@mail.gmail.com>
Message-ID: <CAHk-=whswL8vPtdVphebUwdDd2Y-9j2d8XAd35bB+mqrhc0YTA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Ulrich Teichert <krypton@ulrich-teichert.org>
Cc:     Michael Cree <mcree@orcon.net.nz>,
        Guenter Roeck <linux@roeck-us.net>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-parisc@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 1:46 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But your config shows _other_ errors with the IO functions, so I guess
> I'll need to look at that one too.

Oh, and all those games with

   #define __EXTERN_INLINE
   #include <asm/io.h>
   #include <asm/jensen.h>
   #undef  __EXTERN_INLINE

don't actually work, because there's the usual multiple-inclusion
protection on top of asm/jensen.h:

   #ifndef __ALPHA_JENSEN_H
   #define __ALPHA_JENSEN_H

and this include of <asm/jensen.h> is entirely unused, because we
ended up getting the one *without* that empty __EXTERN_INLINE #define
from an earlier include of

  #include <linux/interrupt.h>

that caused asm/io.h and asm/jensen.h to be included earlier.

The *other* machine files know to do their includes at the top of the file.

But then I end up getting

     ERROR: modpost: "__udiv_qrnnd" [lib/mpi/mpi.ko] undefined!

because CONFIG_MATHEMU wasn't set and the crypto stuff wants the MPI code.

So there seems to be other alpha Kconfig issues in there, and they
aren't all actually Jensen-specific.

Oh well. I guess can fix things up, since I did get tthe
cross-compiler environment..

          Linus
