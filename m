Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30AB13FC0C5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 04:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239423AbhHaCPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 22:15:30 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:58600 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbhHaCP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 22:15:28 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 17V2EUa2022033; Tue, 31 Aug 2021 11:14:30 +0900
X-Iguazu-Qid: 34trdvrI75kL3fQ1Yi
X-Iguazu-QSIG: v=2; s=0; t=1630376070; q=34trdvrI75kL3fQ1Yi; m=enqtohIq2eRDuL61o6eYoKfPFuSw91zMK8OV2c3zi3A=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
        by relay.securemx.jp (mx-mr1510) id 17V2EUbk016230
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Aug 2021 11:14:30 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1866310009F;
        Tue, 31 Aug 2021 11:14:30 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.toshiba.co.jp  with ESMTP id 17V2ETgh024714;
        Tue, 31 Aug 2021 11:14:29 +0900
Date:   Tue, 31 Aug 2021 11:14:28 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: Add DT bindings for PLL of
 Toshiba Visconti TMPV770x SoC
X-TSB-HOP: ON
Message-ID: <20210831021428.rsjzi6vtv2q3wnkb@toshiba.co.jp>
References: <20210804092244.390376-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210804092244.390376-2-nobuhiro1.iwamatsu@toshiba.co.jp>
 <163021379431.2676726.15668763072935534900@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163021379431.2676726.15668763072935534900@swboyd.mtv.corp.google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review.

On Sat, Aug 28, 2021 at 10:09:54PM -0700, Stephen Boyd wrote:
> Quoting Nobuhiro Iwamatsu (2021-08-04 02:22:41)
> > Add device tree bindings for PLL of Toshiba Visconti TMPV770x SoC series.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../clock/toshiba,tmpv770x-pipllct.yaml       | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> > new file mode 100644
> > index 000000000000..7b7300ce96d6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> > @@ -0,0 +1,57 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/toshiba,tmpv770x-pipllct.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Toshiba Visconti5 TMPV770X PLL Controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > +
> > +description:
> > +  Toshia Visconti5 PLL controller which supports the PLLs on TMPV770X.
> > +
> > +properties:
> > +  compatible:
> > +    const: toshiba,tmpv7708-pipllct
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  clocks:
> > +    description: External reference clock (OSC2)
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
> > +  - clocks
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +
> > +    osc2_clk: osc2-clk {
> > +      compatible = "fixed-clock";
> > +      clock-frequency = <20000000>;
> > +      #clock-cells = <0>;
> > +    };
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pipllct: clock-controller@24220000 {
> > +            compatible = "toshiba,tmpv7708-pipllct";
> 
> The driver makes it look like this is actually part of a syscon node. Is
> that right? It's not clear to me that this is a syscon. But then looking
> at the binding it seems that one device has been split up into PLL and
> "not PLL" parts sort of arbitrarily.

This is the driver that controls the PIPLLCT device that produces the
PLL. This device only has the ability to generate his PLL, no other
features.

I have received similar comments in the driver patch from you, so I will
check that as well.

> 
> > +            reg = <0 0x24220000 0 0x820>;
> > +            #clock-cells = <1>;
> > +            clocks = <&osc2_clk>;
> > +        };
> > +    };
> > +...
> 

Best regards,
  Nobuhiro

