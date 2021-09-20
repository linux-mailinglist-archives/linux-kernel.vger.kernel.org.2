Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83AB4114C0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 14:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbhITMoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 08:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234162AbhITMoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 08:44:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D905660F43;
        Mon, 20 Sep 2021 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632141763;
        bh=LJd326Onj4XtLEwt35NMphBK1paSjnbTcGe5Aoy65Mg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DeJ1xOEstl5+CzNf5BKwpkGnrbneFDGVk5At3W8ysipTWc8z+u9S1YNrQkNsV0TMQ
         oZ2q5CrK92h44aq6/Lm8db0Pyk9wuAVYuYAyl4gqBhUhT7xS+bkHpq8COsHw33o8QK
         aYO3l9R/XW5AnHhK+zuDV4Q2vX9D2C70wTOeDgE8aBWqXcgiWn5bl+GDG851KP00Gb
         ndatDskBGCB87CDK8SsejrzEgTsvRw9MJxVpOHynCqsSWAIj++R/8ff6P1fcfPXMwn
         GCrw8K7/eFZOxlJxz8aSwLaYfYesetfUVro0ijMII/5EQ/Lb3fuNHpe0+bcI012RSv
         kBjlThj7ZBJyQ==
Received: by mail-ed1-f41.google.com with SMTP id bx4so16080361edb.4;
        Mon, 20 Sep 2021 05:42:43 -0700 (PDT)
X-Gm-Message-State: AOAM532XEH6RvcE1qnczsi2PchEXyvXf8DkRbTvqX80OxfMKxJY2rYrB
        roTmHAPhdq5gmtxGWX8Yr11sWsxegHBjvHlifg==
X-Google-Smtp-Source: ABdhPJxe0pzq32S+O6qzUtsUF2LFq6WiPntxr4KAmr/C6XTVEYsfFTdYU9uZ2o/8Mg9Se/FqIR+u8ERaaUAWpNgzCo0=
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr27972643ejk.466.1632141762450;
 Mon, 20 Sep 2021 05:42:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210916084714.311048-1-zhang.lyra@gmail.com> <20210916084714.311048-3-zhang.lyra@gmail.com>
 <YUNUyolr6ksEoZI3@robh.at.kernel.org> <CAAfSe-vYMUb8wGUJG7Fzehjkj8gAq1QOdgCdsTvcNyMuVeEW8g@mail.gmail.com>
In-Reply-To: <CAAfSe-vYMUb8wGUJG7Fzehjkj8gAq1QOdgCdsTvcNyMuVeEW8g@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Sep 2021 07:42:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKmznCOk+qHFccnG1b5xuoNHY2vmqyv=WAjB9d=0AW70Q@mail.gmail.com>
Message-ID: <CAL_JsqKmznCOk+qHFccnG1b5xuoNHY2vmqyv=WAjB9d=0AW70Q@mail.gmail.com>
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

On Fri, Sep 17, 2021 at 3:41 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Thu, 16 Sept 2021 at 22:29, Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Sep 16, 2021 at 04:47:12PM +0800, Chunyan Zhang wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > Add a new bindings to describe ums512 clock compatible strings.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
> > >  1 file changed, 106 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > new file mode 100644
> > > index 000000000000..be3c37180279
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > > @@ -0,0 +1,106 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2019-2021 Unisoc Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: UMS512 Clock Control Unit Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - Orson Zhai <orsonzhai@gmail.com>
> > > +  - Baolin Wang <baolin.wang7@gmail.com>
> > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > +
> > > +properties:
> > > +  "#clock-cells":
> > > +    const: 1
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - sprd,ums512-apahb-gate
> > > +      - sprd,ums512-ap-clk
> > > +      - sprd,ums512-aonapb-clk
> > > +      - sprd,ums512-pmu-gate
> > > +      - sprd,ums512-g0-pll
> > > +      - sprd,ums512-g2-pll
> > > +      - sprd,ums512-g3-pll
> > > +      - sprd,ums512-gc-pll
> > > +      - sprd,ums512-aon-gate
> > > +      - sprd,ums512-audcpapb-gate
> > > +      - sprd,ums512-audcpahb-gate
> > > +      - sprd,ums512-gpu-clk
> > > +      - sprd,ums512-mm-clk
> > > +      - sprd,ums512-mm-gate-clk
> > > +      - sprd,ums512-apapb-gate
> > > +
> > > +  clocks:
> > > +    minItems: 1
> > > +    maxItems: 4
> > > +    description: |
> > > +      The input parent clock(s) phandle for this clock, only list fixed
> > > +      clocks which are declared in devicetree.
> > > +
> > > +  clock-names:
> > > +    minItems: 1
> > > +    maxItems: 4
> > > +    items:
> > > +      - const: ext-26m
> > > +      - const: ext-32k
> > > +      - const: ext-4m
> > > +      - const: rco-100m
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - '#clock-cells'
> > > +
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      enum:
> > > +        - sprd,ums512-ap-clk
> > > +        - sprd,ums512-aonapb-clk
> > > +        - sprd,ums512-mm-clk
> > > +then:
> > > +  required:
> > > +    - reg
> > > +
> > > +else:
> > > +  description: |
> > > +    Other UMS512 clock nodes should be the child of a syscon node in
> > > +    which compatible string should be:
> > > +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> > > +
> > > +    The 'reg' property for the clock node is also required if there is a sub
> > > +    range of registers for the clocks.
> >
> > In which cases is this not true?
>
> Seems not needed, I will remove 'reg' property for this kind of cases.

Wrong direction. Please keep 'reg'. My question is why can't you
always have it? That is the preference.

Rob
