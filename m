Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2313271C1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 10:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhB1Jec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Feb 2021 04:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhB1JeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Feb 2021 04:34:24 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FFCC06174A;
        Sun, 28 Feb 2021 01:33:44 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id b21so9150575pgk.7;
        Sun, 28 Feb 2021 01:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CQcNXul42OdjZ/11X+dsEbe6I5ZkvgAlKEhd5f4JttI=;
        b=YseBDxj1XmfQfRHJIiRpyFyEQaAdJ1XSqsmj/a3cNrAH4rTo05OqSEqN709gYJZ7nj
         CL8zUmadfUm/18uH9fwD6EiJ9wxI9Wey8/+vTEkO62Y245p88m1WSQNwUy1fHQtvlY98
         vaARp4jdXcxYHuVpfJcqLhw266NtjaJzK4ohEQD8T3B47414tJaU4KcWeayRc/Ru9aq1
         sl7XFi6RFKKuZCJKAs/opsBVTYTZce1MlhkMiMTWRM1rx8D+bpoyVB8c/8423919doqb
         nq/R0st/DzAX8fB2Ff60aEgD4UtjOCMG2P5MfyxFKJROPsTQ7GMrGJnizh6y2rGijJSA
         S9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQcNXul42OdjZ/11X+dsEbe6I5ZkvgAlKEhd5f4JttI=;
        b=D3ryjpc6vDKtIGWrnwup5puN0LkrQEbUbFuUdqog0VBX2H3bJWoTZAIepZzmUgDj59
         9APoU6N6Ycs1b1sffzI48bDewYA4T1SDOqPSs42BVAN/5oX04f9kICblxXv93Wr5QGhU
         6iQVrfPzPhQ3TY0/ro8XVhb/TCwWrdrPHxtChqE3zhrNJfG32dcait05uAw5ANXRNb/M
         CPegHA/976FbEFwHJnz4W7GtPQ7o8s0C0z6uALX/owTaSYy7vrCwDXDxyiMgFDkv0ndQ
         m8n4atwW5XaNjGhzSgrGeNKF/0sfXBRuph+IkIMizWKZT85TqVnCdRnV8j2f444Wn47T
         lpKQ==
X-Gm-Message-State: AOAM531jtQ5yl0RjxtsyyxdRzgja8ogo5oVujLuOhOKvDpE2Tqcmqmox
        Xi14iCKCR/wkydnZ0cF2q1v4mxS4s8F2qfbYjms=
X-Google-Smtp-Source: ABdhPJwxr7BtwuTnM0O+LoVoUmW80xOoplvQc9dCHbDauAAnMHRzRq8Hjjo0tErujsvqMSbphiXZXNKmnSyMu9aq6lI=
X-Received: by 2002:a65:5ac9:: with SMTP id d9mr9365056pgt.74.1614504824125;
 Sun, 28 Feb 2021 01:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-3-linux@rasmusvillemoes.dk> <CAHp75Vc8S2E0vWFcqK-jO9Nhd-Us_7t-aWNj-7k+fWDcqR1XkQ@mail.gmail.com>
 <CAHp75VfNHkJp-SMacKdaSuy3gDECs=u4BNMNe2KjYkrDiwb8jg@mail.gmail.com>
In-Reply-To: <CAHp75VfNHkJp-SMacKdaSuy3gDECs=u4BNMNe2KjYkrDiwb8jg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 28 Feb 2021 11:33:28 +0200
Message-ID: <CAHp75Vdrsr8zJzuovUEd6RtSHOmdASrQa1--A6HBVmj8mx8+Kw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: misc: add ripple counter driver
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 28, 2021 at 11:29 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sun, Feb 28, 2021 at 11:07 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Friday, February 26, 2021, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
> >>
> >> The only purpose of this driver is to serve as a consumer of the input
> >> clock, to prevent it from being disabled by clk_disable_unused().
> >
> > We have a clock API to do the same (something like marking it used or so) why do you need a driver?
>
> Example:
> https://elixir.bootlin.com/linux/latest/source/drivers/platform/x86/pmc_atom.c#L365
>
> If it's a DT based platform I think you can make it somehow work thru DT.

Okay, briefly looking at the state of affairs [1] seems like you need
to hack it into clock provider.

[1]: https://elixir.bootlin.com/linux/latest/C/ident/CLK_IS_CRITICAL

-- 
With Best Regards,
Andy Shevchenko
