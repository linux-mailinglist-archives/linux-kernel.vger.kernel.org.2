Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54243415178
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237669AbhIVUhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:45290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236860AbhIVUhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:37:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7B8B260FC1;
        Wed, 22 Sep 2021 20:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632342967;
        bh=C+ju3SHP5Uenov8Y+HFErFOymkbRCzcFMjsRizW1tuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UYJpJfe8LoqYQafTaViwHocFDGKv9jOi4IAv7hs7ev2QdVGQPtOPvfQ1Qw9NTOxVp
         83w+r3ic455kujmPS5fBxIOIHbTRNtV8PtLsi3gTbEM6Ft0KzUedwPGqFhoMx4+IHI
         3Hy73EnahX+p9RZKs9CnC3yfjHzFQTEuMELUZJpT/T7khIiIfoayfdAvUR8TbKc7DU
         bXXoLQJevnvYol1GSNc55oZCnXCSTLnRJqHTye7WXLb4BNKV8p+uegADCzPKSFFgCx
         HW7DKz4JJMOCeDIdVBWzdSsLLDAgGe/V1dx/YcOSFeEQR9ekOAR0pQdjIy07tKhHO0
         tUW0THZ+E1dMQ==
Received: by mail-qk1-f182.google.com with SMTP id 194so14043661qkj.11;
        Wed, 22 Sep 2021 13:36:07 -0700 (PDT)
X-Gm-Message-State: AOAM530oIuduZ4Lew46TLc6n0krwRpLxq8wCP/2Bg2q0cbD3+z4cYd3h
        4wPA8LlVKfAxgb957u8bCLbJ5FbY9V3fm4Uqgg==
X-Google-Smtp-Source: ABdhPJzAfTw2IrpOPx8N93ujEb5kXuu/0Cl68qtcrEnIqLUY1n/tKaEJHldLo8YsiQqRKDd9IykEerH1GuxKSU0JbW4=
X-Received: by 2002:a05:620a:1911:: with SMTP id bj17mr1295518qkb.202.1632342966710;
 Wed, 22 Sep 2021 13:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210916084714.311048-1-zhang.lyra@gmail.com> <20210916084714.311048-3-zhang.lyra@gmail.com>
 <YUNUyolr6ksEoZI3@robh.at.kernel.org> <CAAfSe-vYMUb8wGUJG7Fzehjkj8gAq1QOdgCdsTvcNyMuVeEW8g@mail.gmail.com>
 <CAL_JsqKmznCOk+qHFccnG1b5xuoNHY2vmqyv=WAjB9d=0AW70Q@mail.gmail.com> <CAAfSe-sruhCCZopyserimaTYnxGmXv87nkd+T4v1uzbjCz1C7A@mail.gmail.com>
In-Reply-To: <CAAfSe-sruhCCZopyserimaTYnxGmXv87nkd+T4v1uzbjCz1C7A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Sep 2021 15:35:55 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ6u-teqZRgu3x9iJAuAKimdmu9s2GfkFwMO0GEtq1kMw@mail.gmail.com>
Message-ID: <CAL_JsqJ6u-teqZRgu3x9iJAuAKimdmu9s2GfkFwMO0GEtq1kMw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 10:33 PM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Mon, 20 Sept 2021 at 20:42, Rob Herring <robh@kernel.org> wrote:
> >
> > On Fri, Sep 17, 2021 at 3:41 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> > >
> > > On Thu, 16 Sept 2021 at 22:29, Rob Herring <robh@kernel.org> wrote:
> > > >
> > > > On Thu, Sep 16, 2021 at 04:47:12PM +0800, Chunyan Zhang wrote:
> > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > >
> > > > > Add a new bindings to describe ums512 clock compatible strings.
> > > > >
> > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > ---
> > > > >  .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
> > > > >  1 file changed, 106 insertions(+)
> > > > >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > > >
> > > > > diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..be3c37180279
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > > > @@ -0,0 +1,106 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +# Copyright 2019-2021 Unisoc Inc.
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> > > > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > > > +
> > > > > +title: UMS512 Clock Control Unit Device Tree Bindings
> > > > > +
> > > > > +maintainers:
> > > > > +  - Orson Zhai <orsonzhai@gmail.com>
> > > > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > > > +
> > > > > +properties:
> > > > > +  "#clock-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - sprd,ums512-apahb-gate
> > > > > +      - sprd,ums512-ap-clk
> > > > > +      - sprd,ums512-aonapb-clk
> > > > > +      - sprd,ums512-pmu-gate
> > > > > +      - sprd,ums512-g0-pll
> > > > > +      - sprd,ums512-g2-pll
> > > > > +      - sprd,ums512-g3-pll
> > > > > +      - sprd,ums512-gc-pll
> > > > > +      - sprd,ums512-aon-gate
> > > > > +      - sprd,ums512-audcpapb-gate
> > > > > +      - sprd,ums512-audcpahb-gate
> > > > > +      - sprd,ums512-gpu-clk
> > > > > +      - sprd,ums512-mm-clk
> > > > > +      - sprd,ums512-mm-gate-clk
> > > > > +      - sprd,ums512-apapb-gate
> > > > > +
> > > > > +  clocks:
> > > > > +    minItems: 1
> > > > > +    maxItems: 4
> > > > > +    description: |
> > > > > +      The input parent clock(s) phandle for this clock, only list fixed
> > > > > +      clocks which are declared in devicetree.
> > > > > +
> > > > > +  clock-names:
> > > > > +    minItems: 1
> > > > > +    maxItems: 4
> > > > > +    items:
> > > > > +      - const: ext-26m
> > > > > +      - const: ext-32k
> > > > > +      - const: ext-4m
> > > > > +      - const: rco-100m
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - '#clock-cells'
> > > > > +
> > > > > +if:
> > > > > +  properties:
> > > > > +    compatible:
> > > > > +      enum:
> > > > > +        - sprd,ums512-ap-clk
> > > > > +        - sprd,ums512-aonapb-clk
> > > > > +        - sprd,ums512-mm-clk
> > > > > +then:
> > > > > +  required:
> > > > > +    - reg
> > > > > +
> > > > > +else:
> > > > > +  description: |
> > > > > +    Other UMS512 clock nodes should be the child of a syscon node in
> > > > > +    which compatible string should be:
> > > > > +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> > > > > +
> > > > > +    The 'reg' property for the clock node is also required if there is a sub
> > > > > +    range of registers for the clocks.
> > > >
> > > > In which cases is this not true?
> > >
> > > Seems not needed, I will remove 'reg' property for this kind of cases.
> >
> > Wrong direction. Please keep 'reg'. My question is why can't you
> > always have it? That is the preference.
>
> Ok. I will address. BTW, do we need 'reg' even though the driver
> doesn't read this property? Does that because DT should reflect
> hardware topology?

Yes and yes.

Rob
