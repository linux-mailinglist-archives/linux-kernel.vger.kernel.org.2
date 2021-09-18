Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9934107B2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 19:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbhIRRGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 13:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233741AbhIRRGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 13:06:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4762C061757
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:04:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t10so40612365lfd.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=StUaahVx5e7+NokI5/qGGzRBPBdQYp4qliDoUWcQ+NI=;
        b=O2VVgZ/0BYoSNWucGr1isvjpQO49OJDF6pzVPSwvw//fNoDVP6xUldb1YiKIncajMB
         iQJJAmxcMdy4SuMhhkT7Zk59C6pD0MGNxyFFsrHY6L3H6c56+67tvszfXITs496M24VY
         8lGb3v+QzA+t9z0ONhrXILrIVYnVmAonIk2YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=StUaahVx5e7+NokI5/qGGzRBPBdQYp4qliDoUWcQ+NI=;
        b=LPesANOh8GVp4/eU5KS90cs45t+i00YT9YGWVO3a8Exa+VlTfwY8bm9RcaHr/ZJCbf
         IpxcehUoJkLlmVDExrVZEIr/jfsTd/HjMiS/M81z9fTqZX2kyfdgWDOb/+bKFIvlPZQQ
         ckLd82TuKBOSJEPoEgc8kUvMs/k8T2S0rJpnBLW/JwiAS1YUiLRpj2wFkGHHPjtXiwgg
         MWk/Sc4P8LxONlad264MH23ZAoKcgY7gBzKV5MScDHgI6I+bDmR+9IswPOoZ+S46cUoN
         pYW20JoqwbGjorNTupp1vQO0JRmeTMh4xFUf1KmqikCNGIUByXLpaZC6E7FEjWm94jIq
         380g==
X-Gm-Message-State: AOAM532UnwUjw14OGDBRHeyh++8gkizYpMG5mO4Wpb8cJy0Pt6jYRnFU
        XhTTlXLTayG1P9+3vMFhQTE3Z5rsZVagIiuYW90=
X-Google-Smtp-Source: ABdhPJy5hwLZx6P/t2Y5E8BgsbR4NiZwBOjX2Ty87fwZ7Xg6Kabkzn2prs2vXHh0Y3HPwGUc0D7onw==
X-Received: by 2002:a2e:3514:: with SMTP id z20mr15033182ljz.459.1631984680166;
        Sat, 18 Sep 2021 10:04:40 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u16sm1180130ljj.0.2021.09.18.10.04.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 10:04:37 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id i4so47170828lfv.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 10:04:37 -0700 (PDT)
X-Received: by 2002:a2e:7f1c:: with SMTP id a28mr14383582ljd.56.1631984677088;
 Sat, 18 Sep 2021 10:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210918095134.GA5001@tower> <202109181311.18IDBKQB005215@valdese.nms.ulrich-teichert.org>
In-Reply-To: <202109181311.18IDBKQB005215@valdese.nms.ulrich-teichert.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Sep 2021 10:04:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
Message-ID: <CAHk-=whY5mLggPSr2U00mqgUbRJYnYSxtNZm4FnEtQrHftYr8Q@mail.gmail.com>
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

On Sat, Sep 18, 2021 at 6:11 AM Ulrich Teichert
<krypton@ulrich-teichert.org> wrote:
>
> Hi,
>
> >
> > On Thu, Sep 16, 2021 at 11:35:36AM -0700, Linus Torvalds wrote:
> > > Naah. I think the Jensen actually had an ISA slot. Came with a
> > > whopping 8MB too, so the ISA DMA should work just fine.
> > >
> > > Or maybe it was EISA only? I really don't remember.
>
> It's EISA only. I've made some pictures of a somewhat dusty inside of
> a Jensen with 4 EISA cards (from bottom to top: SCSI, video, 2x network):

Ok.

Looking around the config options, there _are_ systems with ISA slots,
but it's not the old Jensen one. It's apparently some evaluation
boards but also the "AlphaPC64" one.

So we do want CONFIG_ISA for alpha, even if not Jensen.

(I forget which alpha I had. For some reason I want to think I had an
EISA machine and probably Jensen. Maybe upgraded to a 164 later?)

> I could not get a recent kernel to boot, but it's booting ancient kernels
> just fine:
>
> Linux version 2.4.27-2-generic (tretkowski@bastille) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #1 Sun May 29 18:40:58 UTC 2005

Ouch. Without having some kind of bisection, I guess we'll never know.
And I assume it's not really been tested since, so it could be
multiple reasons, including compiler updates causing dodgy code to not
work etc etc.

> While we're at it, during my vain attempts to get new kernels to boot,
> I tried to disable PCI support to make the kernels smaller (after all,
> the Jensen has only EISA, so what good would PCI support for?) and
> got it to compile with the attached patch (which fixes some warnings,
> too).

Can you send me your Jensen config?

I do not see why you should be using that horrible __EXERN_INLINE. It
will cause gcc to sometimes not inline at all, and not generate the
out-of-line body either.

Sometimes that is what you want: you want to generate one single body
of the function, and particularly one that is _different_ from the
inlining case (ie for inlining you want to do the simple thing, for
out-of-line you do something fancier).

But that isn't the case here, so this looks like a workaround for
something else. But this code does end up using preprocessor
concatenation etc, so I might be missing some case.

             Linus
