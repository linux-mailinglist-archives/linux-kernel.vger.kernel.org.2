Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEEC332ADB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 16:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbhCIPoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 10:44:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhCIPon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 10:44:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9EC365279;
        Tue,  9 Mar 2021 15:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615304683;
        bh=F6sLrQc6A133M6TKwbXu0Bde8uGEs5tBN2d2E39D7h0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PxzD6yqe+HlDZzX8dZdj3WMjEiStNwR9PKXMEGPKRRGTZwiIzELfDb/OAZKsmmwxS
         kVM162ViBvNxfydpoqp+XVAnJQWRHQDECiH2DKQtccGeF1I9zYuEByhaJEtGtIv2Ro
         wL2Psi9DqMn8c0bokF5HBjvOaqhX3/p+o0uY8XOkmwnycNqHCDZmWOWHvgCoCIQXjh
         v+FhBMQoo+bLqO4qGQqIevcv404ba4SlrErZ6sDF3qYISKI14k898VtGSF1onGZrDk
         /Vw0soApdpXxmEwoiCnq8+QGXs5t2ldoFCXD6Ub8vKG/nBenCDD5dPy/6ou4/lKm3a
         qX2hZOGhTEE0w==
Received: by mail-ej1-f46.google.com with SMTP id mm21so28873486ejb.12;
        Tue, 09 Mar 2021 07:44:42 -0800 (PST)
X-Gm-Message-State: AOAM530AeXHa37+wKkHMplUw6NlM5B4pn/f+V0d1UP2haTE/zR/fYrND
        H1scpXuN1E6PPdiRlKGtoqHwZoTz0bRoACYlAg==
X-Google-Smtp-Source: ABdhPJw2iDp9uMT9RSu865E9aEUm8iR3HOOYNsjo4uwY6hOq2aYgQTezI0+ACByEzPk2X5WtrEFNpkY6PIaUKNItCxM=
X-Received: by 2002:a17:906:25c4:: with SMTP id n4mr21099636ejb.359.1615304681326;
 Tue, 09 Mar 2021 07:44:41 -0800 (PST)
MIME-Version: 1.0
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210226141411.2517368-2-linux@rasmusvillemoes.dk> <20210308172153.GA2505339@robh.at.kernel.org>
 <12be138b-631a-4f82-aae9-6bbdc7bc2bcf@rasmusvillemoes.dk> <20210308213834.GA2973251@robh.at.kernel.org>
 <11a604cc-6f81-7d26-06a4-3e338b051c5a@prevas.dk>
In-Reply-To: <11a604cc-6f81-7d26-06a4-3e338b051c5a@prevas.dk>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 9 Mar 2021 08:44:29 -0700
X-Gmail-Original-Message-ID: <CAL_JsqKEGaFpiFV_oAtE+S_bnHkg4qry+bhx2EDs=NSbVf_giA@mail.gmail.com>
Message-ID: <CAL_JsqKEGaFpiFV_oAtE+S_bnHkg4qry+bhx2EDs=NSbVf_giA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: misc: add binding for generic ripple counter
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-clk <linux-clk@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 9, 2021 at 12:39 AM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 08/03/2021 22.38, Rob Herring wrote:
> > On Mon, Mar 08, 2021 at 09:02:29PM +0100, Rasmus Villemoes wrote:
> >> On 08/03/2021 18.21, Rob Herring wrote:
> >>> On Fri, Feb 26, 2021 at 03:14:10PM +0100, Rasmus Villemoes wrote:
> >>>> While a ripple counter can not usually be interfaced with (directly)
> >>>> from software, it may still be a crucial component in a board
> >>>> layout. To prevent its input clock from being disabled by the clock
> >>>> core because it apparently has no consumer, one needs to be able to
> >>>> represent that consumer in DT.
> >>>
> >>> I'm okay with this as it is describing h/w, but we already
> >>> 'protected-clocks' property which should work.
> >>
> >> Hm. Unless
> >> https://lore.kernel.org/lkml/20200903040015.5627-2-samuel@sholland.org/
> >> gets merged, I don't see how this would work out-of-the-box.
> >
> > Hum, no really clear what the hold up is there given it seems it was
> > asked for. Letting it sit for 5 months is certainly not the way
> > to get it merged. Anyways, that's the kernel's problem, not mine as far
> > as DT bindings are concerned.
> >
> >>
> >> Note that I sent a completely different v2, which made the gpio-wdt the
> >> clock consumer based on feedback from Guenter and Arnd, but that v2
> >> isn't suitable for our case because it post-poned handling of the
> >> watchdog till after i2c is ready, which is too late. Somewhat similar to
> >> https://lore.kernel.org/lkml/20210222171247.97609-2-sebastian.reichel@collabora.com/
> >> it seems.
> >
> > Now at that one in my queue... I think 'protected-clocks' is the best
> > way to avoid any driver probe ordering issues. It's the only thing that
> > really captures don't turn off this clock.
>
> Agreed, and I did start by looking for a generic way to mark the clock
> as either "hands off, kernel" (relying on the bootloader to enable it),
> or better "make sure it's enabled". The closest I found was
> of_clk_detect_critical(), but the comment above that one says not to use
> it, so adding a call to some random RTC driver to support the
> clock-critical property just for my use case didn't seem like the right
> way to go.
>
> I didn't know about protected-clocks until you mentioned it, and it does
> seem to be the right way to handle these situations (which are
> apparently more common than I thought).
>
> The ripple counter binding
> > doesn't really capture that or what it is related to.
>
> Agreed, it was a "hail mary" and why I explained what I was really
> trying to achieve in the cover letter.
>
> Also, the
> > ripple-counter driver could be a module and you'd still have the same
> > issue as v2.
>
> Well, not quite. First of all, for a board like this, one always uses a
> tailor-made .config, where one would never set that to be a module (and
> even more obviously one wouldn't make the gpio-wdt driver a module).

Yes, I'd expect so in this case, but in general we really should try
to avoid things dependent on being built-in (and ordering of
initcalls).

The whole notion of disabling resources in late_initcall is also kind
of broken IMO and doesn't account for modules.

> Second, it wouldn't be the same issue as v2. Rather, if the clock only
> gets enabled later when the ripple counter module would get loaded,
> there would be a period of time where the watchdog was rendered useless
> - the problem with v2 was that the watchdog wouldn't be petted in time,
> so the board would be reset before it booted completely.
>
> >>>> +Required properties:
> >>>> +- compatible: Must be "linux,ripple-ctr".
> >>>
> >>> Nothing linux specific about this.
> >>
> >> True, but I was following the lead of the existing gpio-wdt binding. Is
> >> there some other "vendor" name one can and should use for completely
> >> generic and simple components like these? "generic"?
> >
> > Most 'generic' and GPIO based interfaces have no vendor prefix.
>
> Ah, I see. Can we add just plain "wdt-gpio" to the gpio-wdt binding, and
> deprecate the "linux,wdt-gpio"? It's a little awkward to handle a
> "linux,wdt-gpio" compatible in a U-Boot driver.

No, just leave it. We have a few of these, but let's just not add new
ones. In the end, it's just a string identifier.

Rob
