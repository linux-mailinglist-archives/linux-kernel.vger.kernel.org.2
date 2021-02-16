Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6493D31C89E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 11:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhBPKUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 05:20:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:56818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhBPKTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 05:19:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4744164DE0;
        Tue, 16 Feb 2021 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613470753;
        bh=eY3mTlj51VDYTzN/HdqXV4UVbM576klVPmjNaB7BtAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rh+goMEe6guEquXfbwF4p/banP+VlKviFUn9KeZpAkmv8y3GfNI82iVu6B1a0WUIE
         yJXvBuYad7dsukXs4KvDRmvXIVsDfZ2sejfXfi6+ftkhGMG4DMhIPUAwPqwRBZRAJi
         ebWB2ntvXZXlfawafzxB6dth2N7fvOd1RLc4p1UBmcX9mAw4yMy5Ti60xRd+kESDKV
         eTOKRF3HYietQXaMe4/gAyeyoGuZ+sYPvKg1bvfg1nKDEURdM8dHeMcmbLM+Ee+dLY
         u+/8w2/vM+CRK1ouUKeGOsAmYKxkQifPC9ZSdDVRPnP9JZsMRdP2eCXEpyVlHJkDHn
         ugTurxEvzFh5g==
Received: by mail-ot1-f43.google.com with SMTP id q4so8538998otm.9;
        Tue, 16 Feb 2021 02:19:13 -0800 (PST)
X-Gm-Message-State: AOAM533Cw8RUVddswmW23uki/i7swCFFjVZ4QejdSv+x+ih+PvJNQr2Q
        sxno6rzhQQ0TSYvEb1DkUz+NULfZ2ORh9g9VzQk=
X-Google-Smtp-Source: ABdhPJzeQJWVf1L+wYwbHinVXK9KvU0k5wankDGEsyl+37JLP8P0mp30rvYs7XPlpwchpnDqw4uCBBoiq7ecsbMHDRU=
X-Received: by 2002:a9d:6c11:: with SMTP id f17mr14202610otq.210.1613470752538;
 Tue, 16 Feb 2021 02:19:12 -0800 (PST)
MIME-Version: 1.0
References: <20210215121713.57687-1-marcan@marcan.st> <20210215121713.57687-24-marcan@marcan.st>
 <20210215191748.uhus2e6gclkwgjo5@kozik-lap>
In-Reply-To: <20210215191748.uhus2e6gclkwgjo5@kozik-lap>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 16 Feb 2021 11:18:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0YzRVa+fa_7xFxR8f+pwSCo5w5kuaPsSSQscR10jwPww@mail.gmail.com>
Message-ID: <CAK8P3a0YzRVa+fa_7xFxR8f+pwSCo5w5kuaPsSSQscR10jwPww@mail.gmail.com>
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

On Mon, Feb 15, 2021 at 8:19 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Feb 15, 2021 at 09:17:11PM +0900, Hector Martin wrote:

> > +
> > +/* Apple S5L */
> > +static int __init apple_s5l_early_console_setup(struct earlycon_device *device,
> > +                                             const char *opt)
> > +{
> > +     /* Close enough to S3C2410 for earlycon... */
> > +     device->port.private_data = &s3c2410_early_console_data;
> > +
> > +#ifdef CONFIG_ARM64
>
> if IS_ENABLED()
> (unless it cannot be used due to missing symbol?)
>
> > +     /* ... but we need to override the existing fixmap entry as nGnRnE */
> > +     __set_fixmap(FIX_EARLYCON_MEM_BASE, device->port.mapbase,
> > +                  __pgprot(PROT_DEVICE_nGnRnE));
> > +#endif

It has to be a preprocessor conditional because PROT_DEVICE_nGnRnE
is only defined on arm64. We could add a FIXMAP_PAGE_NONPOSTED
alias for it that defaults to FIXMAP_PAGE_IO, but in the end this is
really an architecture specific thing and I think leaving it guarded by
the architecture is appropriate.

> > +     return samsung_early_console_setup(device, opt);
>
> Don't you need to handle the error code - set PROT_DEFAULT() or whatever
> was there before?

__set_fixmap() has no return value, it just writes a page table entry and
does not fail.

      Arnd
