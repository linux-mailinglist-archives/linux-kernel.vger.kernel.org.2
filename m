Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD4C31839E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 03:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbhBKCgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 21:36:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229763AbhBKCgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 21:36:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D41B64D99;
        Thu, 11 Feb 2021 02:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613010920;
        bh=v8bnfr01qoRgepjTuxBUnO7nuRYf3dj3a/nVOU1suSE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=qYfoTtaxvmOiQHh023iVb2E8XdaobfFp7s0UX4qs54ldDVndXnCiS1MHJ9pg4+Jj9
         LfQIvrF5rspkyBd6FMwbVpjaUs9QwykYzrXSkVB4fup3KLVBXM4pPZyxVejfwX0EFL
         vdB9GUEiHlgoseTlw9jzZ+l7ximE2RKy1aKKVJUo+bpJEv0SG2fWZbgdRyeNPOx38i
         rShBIKbnYFKGV6IC22QwoobbwmAFki0YkL8WZNLfI3vjz8Y9dVm9Tds+8IuT8uiRIE
         p1HthOFuYvfKgqHyF+5KymQ+yEA/ULbr3a4OCqshLihqpxk7f9xdyxoE95tomIwe50
         4e4Hq7gL7IlJg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHCN7xJwd=u8O33j0Gkaw7=5-k5F=pEuSxqoe+hV=LxAPMk_vQ@mail.gmail.com>
References: <20210207185140.3653350-1-aford173@gmail.com> <20210210201841.GA2688439@robh.at.kernel.org> <CAHCN7xJwd=u8O33j0Gkaw7=5-k5F=pEuSxqoe+hV=LxAPMk_vQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: clk: versaclock5: Add optional load capacitance property
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>
Date:   Wed, 10 Feb 2021 18:35:19 -0800
Message-ID: <161301091931.1254594.4205475968584073017@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2021-02-10 12:40:38)
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
> > > diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.=
yaml b/Documentation/devicetree/bindings/clock/idt,versaclock5.yaml
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
>=20
> If I remove that line, the binding check fails.
>=20

Is your dt-schema up to date?
