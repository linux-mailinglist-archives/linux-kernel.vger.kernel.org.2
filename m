Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EE431C8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBPKaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:30:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229771AbhBPKaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:30:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5634064E08;
        Tue, 16 Feb 2021 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613471372;
        bh=hWGJmDQWT8XgcDBQ7FWNZP9vnjZM2snhaJfPI32QkRc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h9KXzI+VQK8eKmwWqRrnq3PhV8yv3jLCPH9kG4q5pjmm1Lz1ejBNgrfEKqh7m+9cJ
         QDvDnNyYYoFl0N4Gnz8gHV2/n2+AedJBtShvMhSN1PFNRaKky1Uv+sqPGHFYHiRJ2X
         jSpDta2pTJn61wx29CEpNdP9fvnQ59LE9Ehulvk/jDDWsQiBTNIwgK2BGFwlEFzhA7
         sTL5llVU+0UKv4K0+359uJKDamyucH+YWWE4Pj+TM6A8581pmqALdJ0rb5Mjn6yhQF
         5YX13knYFdSFX00M/6WSQh7VkVKjN6i3z9RAqLAGz01/ZvM8pjD4AIN4LW4DB7rjyW
         5KUKJUrRnXo/w==
Received: by mail-oi1-f179.google.com with SMTP id y199so10723708oia.4;
        Tue, 16 Feb 2021 02:29:32 -0800 (PST)
X-Gm-Message-State: AOAM533IjMiM8d6IQ+SdixLgOsEE0GhLII4KOPo0WoJcRKzMe7wfNNbu
        m9qQfuLs3xm8TzErcqHTuSQAT7ZuQRwrKnQcnP4=
X-Google-Smtp-Source: ABdhPJzLU0yXwpa8zo0VJ9pnLMzT5igdBQF/kLq0nZ5rs/I3kZXxM3I1bGcFbavHO/jgFFGo6VIGqtHL1dM1HGNJFLc=
X-Received: by 2002:aca:2117:: with SMTP id 23mr2141331oiz.4.1613471371347;
 Tue, 16 Feb 2021 02:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-24-marcan@marcan.st>
 <20210215191748.uhus2e6gclkwgjo5@kozik-lap> <CAK8P3a0YzRVa+fa_7xFxR8f+pwSCo5w5kuaPsSSQscR10jwPww@mail.gmail.com>
 <CAJKOXPc+j9F_TVq2ir0ehVvph96UgkjRRCK7Df4KR0tVgWOAng@mail.gmail.com>
In-Reply-To: <CAJKOXPc+j9F_TVq2ir0ehVvph96UgkjRRCK7Df4KR0tVgWOAng@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 16 Feb 2021 11:29:15 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2mOCfVhR3aeey38sDudJovfz23OOMMHREd8bmy=9-5yw@mail.gmail.com>
Message-ID: <CAK8P3a2mOCfVhR3aeey38sDudJovfz23OOMMHREd8bmy=9-5yw@mail.gmail.com>
Subject: Re: [PATCH v2 23/25] tty: serial: samsung_tty: Add earlycon support
 for Apple UARTs
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Tony Lindgren <tony@atomide.com>,
        Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Stan Skowronek <stan@corellium.com>,
        Alexander Graf <graf@amazon.com>,
        Will Deacon <will@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 11:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 16 Feb 2021 at 11:19, Arnd Bergmann <arnd@kernel.org> wrote:
> > > > +     return samsung_early_console_setup(device, opt);
> > >
> > > Don't you need to handle the error code - set PROT_DEFAULT() or whatever
> > > was there before?
> >
> > __set_fixmap() has no return value, it just writes a page table entry and
> > does not fail.
>
> I meant, handle samsung_early_console_setup() error code (NULL).

Ah, I see.

I don't think it makes a difference -- if ->setup() fails, the page table entry
is just left in place unused, and the type of the unused mapping doesn't
matter. If earlycon tried to unmap the page, the type also would not
change anything.

With earlycon, I'd generally lean towards keeping things as simple as possible,
in order to increase the chance of seeing anything at all. It clearly wouldn't
hurt to try to add minimal error handling here.

       Arnd
