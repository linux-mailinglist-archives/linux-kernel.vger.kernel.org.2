Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A5836E244
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhD1XqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 19:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229624AbhD1XqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 19:46:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51A9D61447;
        Wed, 28 Apr 2021 23:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619653518;
        bh=I79ZC7AZVIIkS9ShL3T6gNk53VBIdRm+AdopwB8OBG4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aRE8FVRNlA2wtlfDV75WqxlLFT6t+ZEtq796cuyX6sJHA6dQ8aIp95XbcfUGWP3EL
         dSg5ZLyelQEZKYi6S9glgS8bXsEExGaMeBvLFiCdFdglRi0YrR/f12JGRbE3INz4xF
         S1IYSlQbRf5SvLK6lw3mEwnsFfNGsj3pXLU13vxpnZeuNrNgEXEQrf36y3Yi4u4Ybz
         595R53ZSXA5KiUqT04j45WNfbyK1OirOVBRHSVPmft1TLppvr5N9iaKYm1ahkbLEab
         36OXezAbGJs8DxVyLcgVPImqpWQeGRnM6cc/Uhzr8c9Y204cwvby3EBUAqALk+urua
         6iru2b/5SGJRw==
Received: by mail-ej1-f43.google.com with SMTP id n2so97094081ejy.7;
        Wed, 28 Apr 2021 16:45:18 -0700 (PDT)
X-Gm-Message-State: AOAM531SjVCA/Qr050FE89XS5ER3eR310MTloDbyTrbRYL27KTQKaWpQ
        fTyaVj1BofiFrIa7DVSefIGWx7zHdj16KyI9ng==
X-Google-Smtp-Source: ABdhPJyUXDPrPkP95AbaN8U5c6px341NM0LbXe54TEstmADdjI3CJ+D969j3oZSk3Ru76SChDWWyoYeliTNHJDWzXlE=
X-Received: by 2002:a17:906:1984:: with SMTP id g4mr31197846ejd.525.1619653516979;
 Wed, 28 Apr 2021 16:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210427224201.32285-1-tsbogend@alpha.franken.de>
 <1619648109.762240.4061025.nullmailer@robh.at.kernel.org> <20210428224153.GA15709@alpha.franken.de>
In-Reply-To: <20210428224153.GA15709@alpha.franken.de>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 28 Apr 2021 18:45:03 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKvL0tT=NG6nu1uuzzF_2ce2RNTJxR5iz4VmfTq3iTz2g@mail.gmail.com>
Message-ID: <CAL_JsqKvL0tT=NG6nu1uuzzF_2ce2RNTJxR5iz4VmfTq3iTz2g@mail.gmail.com>
Subject: Re: [PATCH] dt-binding: interrupt-controller: Add missing interrupts property
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 5:42 PM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Apr 28, 2021 at 05:15:09PM -0500, Rob Herring wrote:
> > On Wed, 28 Apr 2021 00:42:00 +0200, Thomas Bogendoerfer wrote:
> > > Interrupts property is required, so add it.
> > >
> > > Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > > ---
> > >  .../bindings/interrupt-controller/idt,32434-pic.yaml          | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-a10-ic.example.dt.yaml: interrupt-controller@1c20400: 'oneOf' conditional failed, one must be fixed:
> >       'interrupts' is a required property
> >       'interrupts-extended' is a required property
> >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun4i-a10-ic.yaml
>
> now I'm confused... is this a problem of your test ? make dt_binding_check
> was ok with that change...

You and me both. I'll look into it when I apply.

Rob
