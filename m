Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45363CF1A7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 03:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243071AbhGTBGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:06:08 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:39028 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239460AbhGTBAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:00:38 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 16K1ex4i005390; Tue, 20 Jul 2021 10:40:59 +0900
X-Iguazu-Qid: 34trVrK14ucJhjGiJJ
X-Iguazu-QSIG: v=2; s=0; t=1626745259; q=34trVrK14ucJhjGiJJ; m=Oya6wUYGgRkFnZBYvcTTTizHb3L4LMBWBExjnqk/5/I=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 16K1evRR003637
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Jul 2021 10:40:58 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 2963E10008E;
        Tue, 20 Jul 2021 10:40:57 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 16K1euAt014420;
        Tue, 20 Jul 2021 10:40:56 +0900
Date:   Tue, 20 Jul 2021 10:40:54 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: clock: Add DT bindings for PLL of
 Toshiba Visconti TMPV770x SoC
X-TSB-HOP: ON
Message-ID: <20210720014054.fvgncx4dacojrl6q@toshiba.co.jp>
References: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210624034337.282386-3-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210714192339.GA3052504@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714192339.GA3052504@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review.

On Wed, Jul 14, 2021 at 01:23:39PM -0600, Rob Herring wrote:
> On Thu, Jun 24, 2021 at 12:43:35PM +0900, Nobuhiro Iwamatsu wrote:
> > Add device tree bindings for PLL of Toshiba Visconti TMPV770x SoC series.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../clock/toshiba,tmpv770x-pipllct.yaml       | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> > new file mode 100644
> > index 000000000000..e88c9e4c4982
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pipllct.yaml
> > @@ -0,0 +1,49 @@
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
> > +  osc2-clk-frequency:
> > +    description: Frequency of the OSC2 oscillator.
> 
> This is an external input? This should be a fixed-clock and this node 
> needs 'clocks' to connect it.

OK, I will rewrite using fixed-clock.

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
> > +  - osc2-clk-frequency
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pipllct: pipllct@24220000 {
> 
> clock-controller@...

I will fix.

> 
> > +            compatible = "toshiba,tmpv7708-pipllct";
> > +            reg = <0 0x24220000 0 0x820>;
> > +            #clock-cells = <1>;
> > +            osc2-clk-frequency = <20000000>;
> > +        };
> > +    };
> > +...
> > -- 
> > 2.32.0
> > 
> > 
> 

Best regards,
  Nobuhiro

