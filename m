Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713D839DC0D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbhFGMSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:18:04 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:37717 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFGMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:17:57 -0400
Received: by mail-pj1-f41.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so11801338pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZlPSAb86itZAxkrg5NlJlGLE/FrBJ6atWcYjJxvcO0c=;
        b=Xs6c5JKEBrJs6okzeDPBUJ4ttibOErxihn8Q46SW0vEjnoFFH9B/lslLEZibXT0SnL
         Mil8Fg4Ay0DBGHeKzyDvb99Ie1rvLLlylyyBtA9zoTZyJQNiH8QH2jCYDxiRZPuRWNEF
         zcs4x+IPc1uApWqB0rUi/PAkDO2DuLvUd4KfozcWj2T1i6nL02CFyYPpw6kJhSxovQxN
         nvo53NSa6Oh9vr52VDMJIZiIPPBe5zFZnyzOvL1VzHMO/krTL/Ba5Hg1/ugMKccyIMWl
         iG3mG1mWY0/HREQ9SunYG5ESYsTZByXYVmQxKPQ7VN/44UXUSq99A/Q4+ckAel57vQtZ
         4zbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlPSAb86itZAxkrg5NlJlGLE/FrBJ6atWcYjJxvcO0c=;
        b=eb2h3CY/qCI3Cg04m2wDz4D3GBHzpkcsVeGMFc4B5yf+tsQomfLXaQUUPH3p/wqDKA
         TsCKYfOQDgFRVebRbj1Y0rUbzJitqEQLVvFQbcM+3Oye3Og7MBr1kLRsoGMH87FKdwlp
         YlE1TdzlEyE2qHh6qQtCVrLOnxiDxR/+J8dLISgGYPhSIpoui++3vVH0gZqf/j9nUk2I
         La50TLe1LNbHJ686VJ20aC/XT1Gha9jZ0BVH3bbDm9vMauB352VSguKM3HB/19L1JBMi
         nV8wLq/axVyjqm4lv6Q6rQeMHVPMpIGYEzHExExfyPzz12IIzD4lsHxdrTYJ9fuDzEBl
         0kUQ==
X-Gm-Message-State: AOAM531muWnLPGJ42daCi6iYbiSemE1kxmojBztvFbJa+pCwk8XH/28W
        VDLxDjhYsptorif9uu2YrSbR+eJKnURmIqibZjQ=
X-Google-Smtp-Source: ABdhPJw6dHWx0InuufZxrkVxcSkUKkz41UjTbToeoLYrtKz2IeX9ty0vIII3ifxkZFK+39FKPkZukTmqJ27iYvhz8D4=
X-Received: by 2002:a17:90a:af8b:: with SMTP id w11mr20130814pjq.228.1623068095933;
 Mon, 07 Jun 2021 05:14:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622743333.git.sander@svanheule.net> <20210604172515.GG4045@sirena.org.uk>
 <8899fbf306051fa3cdd8bde92634de8134bce0fb.camel@svanheule.net> <20210607115448.GB5705@sirena.org.uk>
In-Reply-To: <20210607115448.GB5705@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Jun 2021 15:14:39 +0300
Message-ID: <CAHp75VcsZqitqjdPkQMrssTS43Kh=rMnXDxa4yGnF_UAC+3NbQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Clause-22/Clause-45 MDIO regmap support
To:     Mark Brown <broonie@kernel.org>
Cc:     Sander Vanheule <sander@svanheule.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 2:55 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jun 04, 2021 at 08:16:53PM +0200, Sander Vanheule wrote:
> > On Fri, 2021-06-04 at 18:25 +0100, Mark Brown wrote:
>
> > > I think these registers are in practice going to either need to be
> > > volatile (how most of them work at the minute) or otherwise handled in
> > > regmap (eg, the page support we've got).  Having two different names for
> > > the same register feels like it's asking for bugs if any of the higher
> > > level functions of regmap get used.
>
> > This is actually an issue with a GPIO chip that I'm trying to implement [1]. To
> > set an output, data is written to the register. To get an input value, data is
> > read from the register. Since a register contains data for 16 GPIO lines, a
> > regular read-modify-write could erroneously overwrite output values. A pin
> > outside of the RMW mask could've changed to an input, and may now be reading a
> > different value. The issue I was running into, had to do with a RMW not being
> > written because the pin value apparently hadn't changed.
>
> If the hardware isn't able to read back the status of the pins in output
> mode (even if it's always reading back from the input circuit where is
> it getting other inputs from?) you're probably better off with just
> having an open coded cache separately than trying to make up fake
> registers that rely on current implementation details to work.

Isn't it a disadvantage of regmap APIs? The hardware that uses the
same offset for R and W with different semantics is quite normal. I
think it is a good exercise to implement regmap-8250 as an example of
how to deal with such hardware.


-- 
With Best Regards,
Andy Shevchenko
