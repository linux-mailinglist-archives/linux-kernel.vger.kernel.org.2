Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6E42715C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 21:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240700AbhJHTXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 15:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231316AbhJHTW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 15:22:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F20261168;
        Fri,  8 Oct 2021 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633720862;
        bh=J3eo4Tu7qrOc2MiIoucmmx1WpNLGsUtlgBPNto2aiUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aMgdTZipDf/D9JrNtQ1hae/jIFbuVzrHOHObvkCzN0PwN+MUX7wX4b7y5RYryzZNb
         k7R9VKUyNPE9KsFDyCCSr2oUlWcnSmXAxnpG20J2RVSM6Fouk1/VFHupXpnRjZrIy3
         5JrDaRemtKNzcf6Db4fApIKyePuqWYXlDtzFjefd6OSvz/DmYUjpNwTr0btuHDrNle
         eIovcmW/7ab9LvyCocUjL7r8J3PbWc9oNX2DCOESIgyB1FceTnabR6bXlTbS7efQ/p
         Lw87suge/FKKtJcNvhl2UOUY5a6A0ENS77hje9aLYncDTfp0+7MOC20HzX+F6wrGO5
         iWJsr4VitJT/w==
Received: by mail-ed1-f49.google.com with SMTP id g10so39333737edj.1;
        Fri, 08 Oct 2021 12:21:02 -0700 (PDT)
X-Gm-Message-State: AOAM531+AaJ+rp7zz7OE5sZ6o7fCzkw4QQDbohX9bT2KDkYwHHGYxriD
        ijFmtjHFqmcL80JqhY587Zc//TgPb5JovtIHeA==
X-Google-Smtp-Source: ABdhPJwsjP40w5LS3Pe0FI+JbwaB1t8n80TdqFlA4RgJ+smCkKocJH5RCRmN8VKIUMTL96V/wG4XUpUzCKI4Hk9FSP8=
X-Received: by 2002:a50:da06:: with SMTP id z6mr17576606edj.355.1633720860729;
 Fri, 08 Oct 2021 12:21:00 -0700 (PDT)
MIME-Version: 1.0
References: <1633518555-8195-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1633518555-8195-5-git-send-email-hayashi.kunihiko@socionext.com>
 <YV395BTH/gqcuDJH@robh.at.kernel.org> <f2138a98-9740-d1de-5dc9-e14a68fa509b@socionext.com>
In-Reply-To: <f2138a98-9740-d1de-5dc9-e14a68fa509b@socionext.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Oct 2021 14:20:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL8N+h7bciDt=4fMHyAP=DL=YikpaTh2v4q383XVXH2AA@mail.gmail.com>
Message-ID: <CAL_JsqL8N+h7bciDt=4fMHyAP=DL=YikpaTh2v4q383XVXH2AA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: clock: uniphier: Add clock binding
 for SoC-glue
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 7, 2021 at 3:50 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Hi Rob,
>
> On 2021/10/07 4:49, Rob Herring wrote:
> > On Wed, Oct 06, 2021 at 08:09:14PM +0900, Kunihiko Hayashi wrote:
> >> Update binding document for clocks implemented in SoC-glue.
> >>
> >> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> >> ---
> >>   .../bindings/clock/socionext,uniphier-clock.yaml         | 16
> > ++++++++++++++++
> >>   1 file changed, 16 insertions(+)
> >>
> >> diff --git
> > a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> > b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> >> index ee8d16a8019e..05a9d1f89756 100644
> >> ---
> > a/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> >> +++
> > b/Documentation/devicetree/bindings/clock/socionext,uniphier-clock.yaml
> >> @@ -46,6 +46,9 @@ properties:
> >>             - socionext,uniphier-ld20-peri-clock
> >>             - socionext,uniphier-pxs3-peri-clock
> >>             - socionext,uniphier-nx1-peri-clock
> >> +      - description: SoC-glue clock
> >> +        enum:
> >> +          - socionext,uniphier-pro4-sg-clock
> >>
> >>     "#clock-cells":
> >>       const: 1
> >> @@ -95,3 +98,16 @@ examples:
> >>
> >>           // other nodes ...
> >>       };
> >> +
> >> +  - |
> >> +    soc-glue@5f800000 {
> >> +        compatible = "socionext,uniphier-sysctrl", "simple-mfd",
> > "syscon";
> >> +        reg = <0x5f800000 0x2000>;
> >> +
> >> +        clock {
> >> +            compatible = "socionext,uniphier-pro4-sg-clock";
> >> +            #clock-cells = <1>;
> >> +        };
> >> +
> >> +        // other nodes ...
> >> +    };
> >
> > What's the value of this 2nd example? It's just a different compatible
> > string.
> Following the previous three examples in the document, it describes the
> difference between the parent nodes that place the clock.
>
> They are common to be child nodes of "syscon", and the definition of the
> parent node is not in this document.
> Should I put them together in a common example?

I'd just drop the example.

Rob
