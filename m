Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769F6368480
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 18:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237504AbhDVQNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 12:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236637AbhDVQNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 12:13:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8432361424;
        Thu, 22 Apr 2021 16:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619107988;
        bh=CTXfhvk5l5o8y23WTouJh4NFstFgPZaYNx707CJkgRY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dBRkBR5K7ew9Cs+0GBpGOHJJx8Ls2JKc/rXQpLnR3XZcSp4GP6b8Ex/cOtjoY2AOx
         HjMZgzJoXMTiKWmvVDj/8WYE+xjhSofM/nysylbt2bNIWIgDZdP0Ul3GjMlBcA1XUG
         iit82Ls5XREtj2E996yXb6flkxmbdd5URMIrnjJatNSkfbauvveg1CnnnjW6nsrjNl
         4wwKSu2UNgX5AIDJjQbSCMQyVdh/dwSZYJIkaIL2Vt/GNN1M9e/eBfOa1OUYvVe1+O
         9Xx/9TVdfoqTe9nSiLlWc06axYR8WH7fsmOQr6bCj/Y2SMkXLrQ6Z6L1D5PHXeAsHm
         eV5eUC3oAkpZA==
Received: by mail-ed1-f44.google.com with SMTP id s15so54179442edd.4;
        Thu, 22 Apr 2021 09:13:08 -0700 (PDT)
X-Gm-Message-State: AOAM533OJVB9TixTfr/k9S4RpYtII1wojzMEf9CZeTKljVrewP4blPyk
        tKuvhc/jGB4FvN2lnH0WX5dayRmP3VyIkm60vw==
X-Google-Smtp-Source: ABdhPJy86k/lVzKmYorlkCTNn/k5N3eXentVbvefOiS4tQ+ryNWj1vLiiLDdpaIL9WV7uMacqtCAgFrwi2fMCOhoghk=
X-Received: by 2002:a05:6402:212:: with SMTP id t18mr4841703edv.165.1619107986950;
 Thu, 22 Apr 2021 09:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210416063721.20538-1-nm@ti.com> <20210416063721.20538-5-nm@ti.com>
 <20210421224041.GA1740292@robh.at.kernel.org> <20210422141744.2imrochbzzt26wx4@slush>
In-Reply-To: <20210422141744.2imrochbzzt26wx4@slush>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Apr 2021 11:12:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJFRdrffKbuBqt6hKks4jQFAm5X9yTji9O6q3UKsOVO3g@mail.gmail.com>
Message-ID: <CAL_JsqJFRdrffKbuBqt6hKks4jQFAm5X9yTji9O6q3UKsOVO3g@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: arm: keystone: Convert ti,sci to json schema
To:     Nishanth Menon <nm@ti.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 9:17 AM Nishanth Menon <nm@ti.com> wrote:
>
> On 17:40-20210421, Rob Herring wrote:
>
> [..]
>
> > > +allOf:
> > > +  - $ref: /schemas/mbox/mbox-consumer.yaml#
> >
> > Drop.
> >
>
> OK.
>
> > > +  reg-names:
> > > +    description: |
> > > +      Specifies the debug messages memory mapped region that is optionally
> > > +      made available from TI-SCI controller.
> > > +      - const: debug_messages
> >
> > Drop the '-' and fix the indent so it's an actual schema.
>
> OK.
>
> [..]
> > > +patternProperties:
> > > +  # All other properties should be a power, clock or reset controller
> > > +  "^(power-controller|clock-controller|reset-controller)$":
> > > +    type: object
> > > +    oneOf:
> > > +      - $ref: /schemas/soc/ti/sci-pm-domain.yaml#
> > > +      - $ref: /schemas/clock/ti,sci-clk.yaml#
> > > +      - $ref: /schemas/reset/ti,sci-reset.yaml#
> >
> > I'd prefer you separate these with a property for each node.
>
> Hmm... I am not sure I completely understand your comment here.
> I assume we dont want to duplicate each of those node yamls, so,
> did you mean something like:
>
> ti,sci-clk as a bool property in the tisci node and if present, then
> expect the node ti,sci-clk node?
>
> Can you give me a hint of similar yaml usage elsewhere that I can refer
> to?

Just do:

properties:
  power-controller:
    type: object
    $ref: /schemas/soc/ti/sci-pm-domain.yaml#

And so on for clock-controller and reset-controller.

Rob
