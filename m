Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EC334F504
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 01:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhC3X1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 19:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbhC3X1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 19:27:09 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7526BC061574;
        Tue, 30 Mar 2021 16:27:09 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id 1so12574143qtb.0;
        Tue, 30 Mar 2021 16:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3/mQcvUwNsY/UJc2jxu3Abaa2D2bXGCJS30gIHPjEs=;
        b=Q8okifF2x7Cis24xXyTCsqdK6HSPnuU+16cgfbDheWc8gugJ8X+B/ISr+bIh+Jo4GJ
         Ft5oK8XVv+9fMVUiuGcSdRLYEpDj1o5+MvtnoxIxsauXhAGJwhviS9YUW6ZgMidlx1UW
         GGxnpmetsT/F4eGykAZdpSBR/TkVjXqfxF7Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3/mQcvUwNsY/UJc2jxu3Abaa2D2bXGCJS30gIHPjEs=;
        b=LZF9HvZR6TzT/AKxrNHNslic1XNUrnY9plaCw3b/0jtl7RY+FbQbze8BU2grMIJhg/
         /SjhZ7qGj3BSIVfXiKq0nJAuy1PcHgRrf8bb8tfT+SsSv8nH6ndHJwaLMFFVutDDigCP
         PvqtV+KrKaz9As7j0p2sCPnEdINJUxM8/3eZQJAOPODQ5qTS4T0gv4BhHgxGVd2ZeZ4z
         aUyFYIfKGIaVqW68Z5D7Z1V8q2BQESx2ut5HeaJoOHW+8D/raASu1YvLc+uFbp/cTov8
         sG+tkmw7FaV9adwzKUWp3rQB4mCZgWdrKt8IkTp06qV7e5Dd4nMlIY0LCFZwJZocrGBp
         nD8A==
X-Gm-Message-State: AOAM533JRmffKMhdtqDKgzhccezQnTzP3nIqppAuiQvtbvKlAujePUwM
        UMe7w3Et6LC6cDSOhdMBVUyCZBy2kISqsGv2RI8=
X-Google-Smtp-Source: ABdhPJzEEpS2qBWaoDRJ4nevrrO4IATNTcu8uGU7/niHD9Gdp4fHrFKbwgSR99OPio8OGSwp13rYrGb8mGgTwFaYaCE=
X-Received: by 2002:ac8:7547:: with SMTP id b7mr235856qtr.176.1617146828454;
 Tue, 30 Mar 2021 16:27:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210330002338.335-1-zev@bewilderbeest.net> <20210330002338.335-3-zev@bewilderbeest.net>
 <20210330223902.GA837825@robh.at.kernel.org>
In-Reply-To: <20210330223902.GA837825@robh.at.kernel.org>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 30 Mar 2021 23:26:56 +0000
Message-ID: <CACPK8Xcfcsz7KCdfLuweGGbaxVKczhMb7+nxA9TMbsAbAbhi3g@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: serial: 8250: update for aspeed,sirq-active-high
To:     Rob Herring <robh@kernel.org>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        - <devicetree@vger.kernel.org>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 at 22:39, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Mar 29, 2021 at 07:23:37PM -0500, Zev Weiss wrote:
> > Update DT bindings documentation for the new incarnation of the
> > aspeed,sirq-polarity-sense property.
>
> Why?
>
> This isn't a compatible change.

We want to depreciate support for this property. It should have never
been added to the bindings; in it's current form it describes a
relationship that afaict doesn't exist ("This unrelated register over
here dictates the polarity of your virtual serial port IRQ"). See
https://lore.kernel.org/lkml/20200812112400.2406734-1-joel@jms.id.au/

The intent is to remove it from both the bindings and the code.
There's already no users of it in any device tree.

How would you like Zev to go about doing this?

Cheers,

Joel

>
> >
> > Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> > ---
> >  Documentation/devicetree/bindings/serial/8250.yaml | 14 ++++++--------
> >  1 file changed, 6 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> > index f54cae9ff7b2..0bbb7121f720 100644
> > --- a/Documentation/devicetree/bindings/serial/8250.yaml
> > +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> > @@ -13,7 +13,7 @@ allOf:
> >    - $ref: /schemas/serial.yaml#
> >    - if:
> >        required:
> > -        - aspeed,sirq-polarity-sense
> > +        - aspeed,sirq-active-high
> >      then:
> >        properties:
> >          compatible:
> > @@ -181,13 +181,11 @@ properties:
> >    rng-gpios: true
> >    dcd-gpios: true
> >
> > -  aspeed,sirq-polarity-sense:
> > -    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +  aspeed,sirq-active-high:
> > +    type: boolean
> >      description: |
> > -      Phandle to aspeed,ast2500-scu compatible syscon alongside register
> > -      offset and bit number to identify how the SIRQ polarity should be
> > -      configured. One possible data source is the LPC/eSPI mode bit. Only
> > -      applicable to aspeed,ast2500-vuart.
> > +      Set to indicate that the SIRQ polarity is active-high (default
> > +      is active-low).  Only applicable to aspeed,ast2500-vuart.
> >
> >  required:
> >    - reg
> > @@ -227,7 +225,7 @@ examples:
> >          interrupts = <8>;
> >          clocks = <&syscon ASPEED_CLK_APB>;
> >          no-loopback-test;
> > -        aspeed,sirq-polarity-sense = <&syscon 0x70 25>;
> > +        aspeed,sirq-active-high;
> >      };
> >
> >  ...
> > --
> > 2.31.1
> >
