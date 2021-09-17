Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70EAC40F450
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 10:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhIQImt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 04:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhIQIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:42:48 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB26C061574;
        Fri, 17 Sep 2021 01:41:26 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id o66so10340053oib.11;
        Fri, 17 Sep 2021 01:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeZGDq8ylzh0OWJzXB6+CtfSipSUr15SxgokLFW4ZVI=;
        b=WaymPEyRLqNpvKq6QKWcZQuFRxGbIlHlFC5742NkQMVBtfx60uoTSYM5jlUNRoD7oW
         q9amg37w+jLi3kcMqCyQyv+Kc49G5ljBNfEyWm9QPiSpEeS7EHAUBJoAz5zMRAeQ88CO
         9qYON5/tbRVZcuU3DFs8MBdSWOt+XoMmtOU9VxwfOl3lVDdjPW00E0aOW0acpOxw7CeY
         Eny41KXEeNuwqzPk+bYvyWd3gvewUOuuv/FpLZ3rSslqJBejf+lBRLj3hSn/yrkxqQSz
         bMufkCWsZE3THwurq28MEqJI4KYNfzSQdnqVM5B4aHnXSkoZKZebJqcpV8s330Z8q4Kd
         l8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeZGDq8ylzh0OWJzXB6+CtfSipSUr15SxgokLFW4ZVI=;
        b=lde1zudQVN1rFj0d/B18LCvQDqFlzngOs9aFtSlRY3s6q/XRbK/Z0LnZy76TwNF8F8
         VT07hJ/n8lEYm+X1yIqP1rCNs3DckvHVeemREo8blgggf6bXAwajvd9GlTI+1Im20/HC
         RrdhkYPPg83HQj33s8rfM3qpYAzw4kW9nU1THlw0oUGsEdL2wq7AYaVbIMmiTdhyvbsO
         ms66FUCtgS02+3HYpNC2wWMMVsczExWW3VE3rH2ALDlBrr7tMghkIRfA0jt67k3T2Te6
         O2KV/WLGBXA3zth4uYcL96d+BgmlVlwNa8ju5bniRaIXwlVHT6Cl+Zf54Wjl1wzJ/Ox3
         8oRA==
X-Gm-Message-State: AOAM532AiRhdM1miwA36n3bXYIKcUM8fJwjKqQnsl8md0kfl6fXxLu+v
        bYynPqxvjiV9oiXGlCmIVCzl5rUThWZOBgGOODs=
X-Google-Smtp-Source: ABdhPJz7V7FeVpl5yX3RqCVrs3KwlTNT4jU+AaBexgzmZmDAnC7p+czNAUHGaQAgpSSO8kbpBYA/y8BafRDFGo/48Hc=
X-Received: by 2002:aca:1717:: with SMTP id j23mr3076167oii.43.1631868085306;
 Fri, 17 Sep 2021 01:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210916084714.311048-1-zhang.lyra@gmail.com> <20210916084714.311048-3-zhang.lyra@gmail.com>
 <YUNUyolr6ksEoZI3@robh.at.kernel.org>
In-Reply-To: <YUNUyolr6ksEoZI3@robh.at.kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 17 Sep 2021 16:40:49 +0800
Message-ID: <CAAfSe-vYMUb8wGUJG7Fzehjkj8gAq1QOdgCdsTvcNyMuVeEW8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
To:     Rob Herring <robh@kernel.org>
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

On Thu, 16 Sept 2021 at 22:29, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 16, 2021 at 04:47:12PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > Add a new bindings to describe ums512 clock compatible strings.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../bindings/clock/sprd,ums512-clk.yaml       | 106 ++++++++++++++++++
> >  1 file changed, 106 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > new file mode 100644
> > index 000000000000..be3c37180279
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> > @@ -0,0 +1,106 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2019-2021 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/clock/sprd,ums512-clk.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: UMS512 Clock Control Unit Device Tree Bindings
> > +
> > +maintainers:
> > +  - Orson Zhai <orsonzhai@gmail.com>
> > +  - Baolin Wang <baolin.wang7@gmail.com>
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  compatible:
> > +    enum:
> > +      - sprd,ums512-apahb-gate
> > +      - sprd,ums512-ap-clk
> > +      - sprd,ums512-aonapb-clk
> > +      - sprd,ums512-pmu-gate
> > +      - sprd,ums512-g0-pll
> > +      - sprd,ums512-g2-pll
> > +      - sprd,ums512-g3-pll
> > +      - sprd,ums512-gc-pll
> > +      - sprd,ums512-aon-gate
> > +      - sprd,ums512-audcpapb-gate
> > +      - sprd,ums512-audcpahb-gate
> > +      - sprd,ums512-gpu-clk
> > +      - sprd,ums512-mm-clk
> > +      - sprd,ums512-mm-gate-clk
> > +      - sprd,ums512-apapb-gate
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 4
> > +    description: |
> > +      The input parent clock(s) phandle for this clock, only list fixed
> > +      clocks which are declared in devicetree.
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    maxItems: 4
> > +    items:
> > +      - const: ext-26m
> > +      - const: ext-32k
> > +      - const: ext-4m
> > +      - const: rco-100m
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - '#clock-cells'
> > +
> > +if:
> > +  properties:
> > +    compatible:
> > +      enum:
> > +        - sprd,ums512-ap-clk
> > +        - sprd,ums512-aonapb-clk
> > +        - sprd,ums512-mm-clk
> > +then:
> > +  required:
> > +    - reg
> > +
> > +else:
> > +  description: |
> > +    Other UMS512 clock nodes should be the child of a syscon node in
> > +    which compatible string should be:
> > +            "sprd,ums512-glbregs", "syscon", "simple-mfd"
> > +
> > +    The 'reg' property for the clock node is also required if there is a sub
> > +    range of registers for the clocks.
>
> In which cases is this not true?

Seems not needed, I will remove 'reg' property for this kind of cases.

>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ap_clk: clock-controller@20200000 {
> > +      compatible = "sprd,ums512-ap-clk";
> > +      reg = <0x20200000 0x1000>;
> > +      clocks = <&ext_26m>;
> > +      clock-names = "ext-26m";
> > +      #clock-cells = <1>;
> > +    };
> > +
> > +  - |
> > +    ap_apb_regs: syscon@71000000 {
> > +      compatible = "sprd,ums512-glbregs", "syscon", "simple-mfd";
> > +      reg = <0x71000000 0x3000>;
> > +      #address-cells = <1>;
> > +      #size-cells = <1>;
> > +      ranges = <0 0x71000000 0x3000>;
> > +
> > +      apahb_gate: clock-controller@0 {
> > +        compatible = "sprd,ums512-apahb-gate";
> > +        reg = <0x0 0x2000>;
> > +        #clock-cells = <1>;
> > +      };
>
> We have this example in the MFD schema, so drop it here.

Ok.

Thanks for your review and comments,
Chunyan
