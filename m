Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C4F361415
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 23:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhDOVZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 17:25:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235093AbhDOVZ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 17:25:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9867761026;
        Thu, 15 Apr 2021 21:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618521902;
        bh=wAzWz1t/6xImauPcT3XLaMkS802uQtcKstpMe9mSozY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E/51QtVt+JZLl5YJKUji4jjUv0dBmA0cmazs/5w6+Bc4wZzO5QnL2dejEJKPWm3Nz
         blOgsYGjclj6JlD5IGboMfeGiQ+yiXB0FaNPitc6n+Pgc/BPT4z4QUAn8LElc43w2p
         DW0iYl09HZIPMm0/dSBmP6P7h0NNhw9kIp61XrB2T4R+z31rL4dpIhDyAXI0P+/egD
         PKDC65q1VxcwFiaRYagT0Ob/+o2VdMqInrUvQpaSh8X9S4oseMskkKhQEu7aHiu4Pa
         Rjns9bJQt/R4aYcJnf1arUZqeetP5o8esJ0rxv9BXDiQWIGv52jx2HETOIhpRi/JxD
         Q8daW7WZwkObA==
Received: by mail-qk1-f174.google.com with SMTP id d23so14764484qko.12;
        Thu, 15 Apr 2021 14:25:02 -0700 (PDT)
X-Gm-Message-State: AOAM532oaoYr97VvPhYbqYexx/1nCp6yi/SOQ48uIT9z1T6UsVsFY9+Y
        5rOkD7/DhlCDcmL/6ElHSLh6id0keRcF7d6Eug==
X-Google-Smtp-Source: ABdhPJwEOtVU/PBX8pl5Ub9lOQ0rQ9elsjO6RSPqK7TVDKWJEeKEiIDMHMw6Ipuhxv6/Qi8T03BgwK/XvLFUmMN9Nds=
X-Received: by 2002:a37:84b:: with SMTP id 72mr5665420qki.464.1618521901808;
 Thu, 15 Apr 2021 14:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <1617766086-5502-1-git-send-email-flora.fu@mediatek.com>
 <1617766086-5502-5-git-send-email-flora.fu@mediatek.com> <20210409182538.GA3913794@robh.at.kernel.org>
 <1618209895.25062.11.camel@mtksdccf07>
In-Reply-To: <1618209895.25062.11.camel@mtksdccf07>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 15 Apr 2021 16:24:50 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLKaYY=NHm1hD=YaQgvDOBTtraoUqcycA7tu7n-f2GVDw@mail.gmail.com>
Message-ID: <CAL_JsqLKaYY=NHm1hD=YaQgvDOBTtraoUqcycA7tu7n-f2GVDw@mail.gmail.com>
Subject: Re: [PATCH 4/8] dt-bindings: arm: mediatek: Add new document bindings
 for APU
To:     Flora Fu <flora.fu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chiawen Lee <chiawen.lee@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 1:45 AM Flora Fu <flora.fu@mediatek.com> wrote:
>
> On Fri, 2021-04-09 at 13:25 -0500, Rob Herring wrote:
> > On Wed, Apr 07, 2021 at 11:28:02AM +0800, Flora Fu wrote:
> > > Document the apusys bindings.
> > >
> > > Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> > > ---
> > >  .../arm/mediatek/mediatek,apusys.yaml         | 56 +++++++++++++++++++
> > >  1 file changed, 56 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
> > > new file mode 100644
> > > index 000000000000..dc04a46f1bad
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
> > > @@ -0,0 +1,56 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: https://urldefense.com/v3/__http://devicetree.org/schemas/arm/mediatek/mediatek,apusys.yaml*__;Iw!!CTRNKA9wMg0ARbw!3ryKFTA2CvsVss4Pt2ZOG7wv4jgR-2LPxuGn30IxFmpxoxSRdzNdf8FrAYYvZWcw$
> > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!3ryKFTA2CvsVss4Pt2ZOG7wv4jgR-2LPxuGn30IxFmpxoxSRdzNdf8FrARlhCQ0w$
> > > +
> > > +title: MediaTek APUSYS Controller
> > > +
> > > +maintainers:
> > > +  - Flora Fu <flora.fu@mediatek.com>
> > > +
> > > +description:
> > > +  The Mediatek apusys controller provides functional configurations and clocks
> > > +  to the system.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - enum:
> > > +          - mediatek,mt8192-apu_mbox
> > > +          - mediatek,mt8192-apu_conn
> > > +          - mediatek,mt8192-apu_vcore
> >
> > s/_/-/
> >
>
> OK. I will update expression strings in the next version.
>
> > > +      - const: syscon
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#clock-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    apu_mbox: apu_mbox@19000000 {
> >
> > mailbox@...? Is this a mailbox provider?
> >
>
> Yes, the apu_mbox is the for setup mailbox in the APU hardware.

Then you need #mbox-cells here.

And in that case, what makes it a syscon?

>
> > > +        compatible = "mediatek,mt8192-apu_mbox", "syscon";
> > > +        reg = <0x19000000 0x1000>;
> > > +    };
