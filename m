Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD6A40CEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhIOVVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbhIOVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:21:20 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E26C061764
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:20:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so9800117lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3BMwFy0chXS7YMqLdf36Rg6yUUlp6nBZba3YILPvA0=;
        b=WsNqD0Opa3lPgwayobITOeBYzY09REebVD84cTigbwiVy8RERoiSXisEu8y+Nk+bfI
         rwr6ffFTpZComKTqahfaOR7CdEVqoy7csTG2SKHpEYZNr9AVK2EZciaTVWrgEw6jv2ed
         w803wR6rUWc2E3pW5t7Ag7qcjFS9X02JepaeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3BMwFy0chXS7YMqLdf36Rg6yUUlp6nBZba3YILPvA0=;
        b=XLi4RMVuSgVbY6cdKauSFypkkYeCTtlmkglj4cmr/xOJ+uSW/8Va6NuBip9u0CuG3V
         AeSKKKKus0snqrGKtbBVrLhaqOaf1VuxIyAUt7w72e3iSOwNF15T+QNOzkatGwb+E89J
         ljxJR8SOfhEz2FU/vAX/b0UwtQGuBTB5tNbVhSS42VIUfuhCpFFAYfBuzopHAmp6HNTZ
         6r+yPToWhZ4z66HXgqiMg+nR+ppSo3t0vOfDax0qShcX3uT7FxsajI3/T77WNemU678Q
         GP8/gBqQAg+qzNEyeuUvsJNEEtRad1H16FB7IKp28TZEzKcnwQyzRT+dG1KoeZBk/jsc
         0T5w==
X-Gm-Message-State: AOAM530Uc7S67vNIoHNAYnhw3REk7wJ6m8q5VzMn8hmPY5U5LFRa3OQH
        Gqq0JS9A+ja97/lTb4rtj2R2u2l7Ob4Vq8qg
X-Google-Smtp-Source: ABdhPJysrv32MlcKcHD2X9HQQCZOv2vsI6J4aNOvlkmAY28UvY/8Q7zZxi5N9x3cJ+8r/bMfp/E/4w==
X-Received: by 2002:a05:6512:6c4:: with SMTP id u4mr1456031lff.284.1631740798987;
        Wed, 15 Sep 2021 14:19:58 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id y35sm116138lje.127.2021.09.15.14.19.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Sep 2021 14:19:57 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id i25so9822319lfg.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:19:56 -0700 (PDT)
X-Received: by 2002:a2e:bc1e:: with SMTP id b30mr1593765ljf.191.1631740795868;
 Wed, 15 Sep 2021 14:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210915035227.630204-1-linux@roeck-us.net> <CAHk-=wjXr+NnNPTorhaW81eAbdF90foVo-5pQqRmXZi-ZGaX6Q@mail.gmail.com>
 <47fcc9cc-7d2e-bc79-122b-8eccfe00d8f3@roeck-us.net> <CAHk-=wgdEHPm6vGcJ_Zr-Q_p=Muv1Oby5H2+6QyPGxiZ7_Wv+w@mail.gmail.com>
 <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
In-Reply-To: <CAHk-=whSkMh9mc7+OSBZZvpoEEJmS6qY7kX3qixEXTLKGc=wgw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Sep 2021 14:19:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjynK7SSgTOvW7tfpFZZ0pzo67BsOsqtVHYtvju8F_bng@mail.gmail.com>
Message-ID: <CAHk-=wjynK7SSgTOvW7tfpFZZ0pzo67BsOsqtVHYtvju8F_bng@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Introduce and use absolute_pointer macro
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Richard Henderson <rth@twiddle.net>,
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

On Wed, Sep 15, 2021 at 12:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Sep 15, 2021 at 12:47 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > What other notable issues end up being still live? I sent out that one
> > patch for sparc, but didn't get any response to it. I'm inclined to
> > just apply it (the 'struct mdesc_hdr' pointer misuse one).
>
> Oh, I forgot about the qnx4 one. That happens on sparc, possibly
> others, but not on x86-64.
>
> I'll go look at that patch too.

Ok, I didn't love any of the patches I saw for the qnx4 problem, so I
silenced that warning with a new patch of my own. Like the sparc64
case, the fix is to describe more extensively to the compiler what the
code is actually doing.

I think it ended up making it clearer what is going on to humans too.
Although that may be the old "peeing in the snow" effect - it looks
more understandable to me only because I spent so much time trying to
understand what it does, and then wrote the fix based on that possibly
flawed understanding. So of course I find it more understandable.

Looking at the qnx4 code-base history, I don't think it has gotten any
actual development outside of cleanups in the git history timeframe,
which makes me suspect nobody uses this code.

But hey, maybe it just works so well for the very specialized user base ...

Anyway, I pushed it out. I have a clean "allmodconfig" build on all
the architectures I tested, but I didn't test _that_ many.  sparc64,
arm64, powerpc64.

Lots of dts warnings (which aren't fatal), though. Particularly for
the powerpc64 build.

             Linus
