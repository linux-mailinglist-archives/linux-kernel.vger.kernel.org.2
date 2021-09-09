Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD498405B58
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 18:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240366AbhIIQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbhIIQxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 12:53:17 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689E0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 09:52:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a4so4958585lfg.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6u9UXBJqq0DvpwbwzhX2UgLgOMc73mPLE0iuNkQUyLg=;
        b=c3sO1BQBDxCW8APZUbAlW9nwWGjPxn+LQp0JgfliDLXRZzDRVo3j7/1R4pPWKE+xNx
         UbgmU4XAmaM891Bx14LElamvax9VI3JEUCFywjuYbWwv0nvT93I+fRhltOoT4VSe8vnz
         QPRBUEbBxEv21a9fqhAw650AWuxptlmMiPwqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6u9UXBJqq0DvpwbwzhX2UgLgOMc73mPLE0iuNkQUyLg=;
        b=G8cuW607K6KGROwNgMXfVk+pWIL2j/u/RuTT5Y8CZbBtWJguwW84cSU/cKg+0n0NYx
         sYg6TC5vEy3lsQS3pHUb0c7AemX1ue4sC/JgHbxgJICCgE798TXG5fATXcgw+K7nZsax
         8s5YyJujiplvsZqC1tr3B8MKYrPxtQKp5YKDjTI1Ihg4sey7MLlRS0KswV5wsO4Q3/Rk
         TNxl/Yls3SbRgcCmXG99VRW/MF0l2ZSspp/ECPULyHzp5r0wB0fs1HHPbiITe8m8CUD2
         drRIwK252/FKG3VaY6H6MFuIg9tWMkQ/25qX0EeviUPcHh3H7u4aQGPyQYoahS3GLvTB
         JsWg==
X-Gm-Message-State: AOAM531rJWbhiHILmisgm47tONHNtj5POHPE0FDVFRCnkn/1h00bOvD/
        kDhN/JRaOBpk7wyWAkwqsbI4SIZh3vBjBB9sAhs=
X-Google-Smtp-Source: ABdhPJxQuZDaugmf9/mbIpkV1V1SOvqbM0JezxH2NTao+LLODoBU1gHqUyhfHC6+NhI0sBR84jy+nA==
X-Received: by 2002:a05:6512:2089:: with SMTP id t9mr568443lfr.529.1631206325406;
        Thu, 09 Sep 2021 09:52:05 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id v22sm254297lfd.79.2021.09.09.09.52.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Sep 2021 09:52:05 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id m28so4980147lfj.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 09:52:04 -0700 (PDT)
X-Received: by 2002:a05:6512:1112:: with SMTP id l18mr609222lfg.402.1631206001151;
 Thu, 09 Sep 2021 09:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210906142615.GA1917503@roeck-us.net> <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain> <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <YTkjJPCdR1VGaaVm@archlinux-ax161> <75a10e8b-9f11-64c4-460b-9f3ac09965e2@roeck-us.net>
 <YTkyIAevt7XOd+8j@elver.google.com> <YTmidYBdchAv/vpS@infradead.org>
In-Reply-To: <YTmidYBdchAv/vpS@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Sep 2021 09:46:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsicuPaicXWh5je6unQYRKwoazuNLzB-9PRXpSY3CZ-g@mail.gmail.com>
Message-ID: <CAHk-=whsicuPaicXWh5je6unQYRKwoazuNLzB-9PRXpSY3CZ-g@mail.gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Marco Elver <elver@google.com>, Guenter Roeck <linux@roeck-us.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 10:59 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> While we're at it, with -Werror something like this is really futile:

Yeah, I'm thinking we could do

 -Wno-error=cpp

to at least allow the cpp warnings to come through without being fatal.

Because while they can be annoying too, they are most definitely under
our direct control, so..

I didn't actually test that, but I think it should work.

That said, maybe they should just be removed. They might be better off
just as Kconfig rules, rather than as a "hey, you screwed up your
Kconfig" warning after the fact.

             Linus
