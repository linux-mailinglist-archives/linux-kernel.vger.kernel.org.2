Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EEA318E23
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 16:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbhBKPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 10:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231341AbhBKOxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 09:53:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9463864E7E;
        Thu, 11 Feb 2021 14:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613055171;
        bh=y9W1QoA11D/YlFhp7AxmUd3UQsfGyTGGB4b+xoKvpDw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E1IqgqsO4b5AXFtD7WsZkQRJS1/AHZL2t36GzJjggnGdE22TKkvR+jmIibh4A1xZ0
         4lSnt50ezkumgvmdhcFspKes6vONqmnQQT4dn9jrzexA/b94OAh/TWuzYGh0Ebx2h/
         XRZkZHdmwGsDpykWFwbquiIEv6WoC1R/G5bWoC48U9Nw6VA8psLepDHwIm49ibD4ZG
         GQIQuf5RUQtnEeP6HG1OtoqS2tUyZu2tW9qRiCXVbGGT516p/0Znc3Fa77Hri6rZns
         P65jHZl5iPs1UEY5Vohiq3NX97au7ubTFmPPWvuMYVjt4veXp8IITN1V2UncoKXdqa
         /ms+UZgNQFG8A==
Received: by mail-ej1-f42.google.com with SMTP id a9so10485807ejr.2;
        Thu, 11 Feb 2021 06:52:51 -0800 (PST)
X-Gm-Message-State: AOAM530QS+omPy3z+IUHCjFrBc5TcD1Q+URxbWTp1sNGW6DuZmrS6mlM
        QOh7pUIH/X+tnnGBXpA3FYKyKSrypwuQnWrSXw==
X-Google-Smtp-Source: ABdhPJzbMfh6cditDQ2L4N8t5L52D9PUJSbfLo3iVj5V1td26kANC6HGLI+jOPHwx42tG+2V29psrF71rJAhFg4JZhU=
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr8757682ejj.108.1613055170111;
 Thu, 11 Feb 2021 06:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20210207185140.3653350-1-aford173@gmail.com> <20210210201841.GA2688439@robh.at.kernel.org>
 <CAHCN7xJwd=u8O33j0Gkaw7=5-k5F=pEuSxqoe+hV=LxAPMk_vQ@mail.gmail.com>
In-Reply-To: <CAHCN7xJwd=u8O33j0Gkaw7=5-k5F=pEuSxqoe+hV=LxAPMk_vQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 11 Feb 2021 08:52:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKXrax2GAzNR5UUUdY60PzBMKSMPB32AyP+YKPEtSvOhw@mail.gmail.com>
Message-ID: <CAL_JsqKXrax2GAzNR5UUUdY60PzBMKSMPB32AyP+YKPEtSvOhw@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: clk: versaclock5: Add optional load
 capacitance property
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 2:40 PM Adam Ford <aford173@gmail.com> wrote:
>
> On Wed, Feb 10, 2021 at 2:18 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, Feb 07, 2021 at 12:51:38PM -0600, Adam Ford wrote:
> > > There are two registers which can set the load capacitance for
> > > XTAL1 and XTAL2. These are optional registers when using an
> > > external crystal.  Since XTAL1 and XTAL2 will set to the same value,
> > > update the binding to support a single property called
> > > xtal-load-femtofarads.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > > V3:  No Change
> > > V2:  No Change
> > >
> > > A couple people suggested that I not use the $ref, but without it,
> > > the bindings check failed with errors.
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > > index 2ac1131fd922..c268debe5b8d 100644
> > > --- a/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
> > > @@ -59,6 +59,12 @@ properties:
> > >      minItems: 1
> > >      maxItems: 2
> > >
> > > +  idt,xtal-load-femtofarads:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> >
> > Don't need a type with standard unit suffix.
>
> If I remove that line, the binding check fails.

Ah, looks like femtofarads got added to property-units.txt but not the
schemas. I'll add it, but fine to leave this as-is for now.

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
