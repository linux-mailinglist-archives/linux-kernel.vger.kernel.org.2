Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6D73CF1E3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 04:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243508AbhGTB23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 21:28:29 -0400
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:58570 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243342AbhGTBM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 21:12:58 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 16K1rOiW010794; Tue, 20 Jul 2021 10:53:25 +0900
X-Iguazu-Qid: 34trdvrI5wL6V4xAkw
X-Iguazu-QSIG: v=2; s=0; t=1626746004; q=34trdvrI5wL6V4xAkw; m=qWIDuXWqrJ+8ImDtKgQtACT4BETEY+WGKe6oDzsPh8Q=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
        by relay.securemx.jp (mx-mr1513) id 16K1rNeR039833
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 20 Jul 2021 10:53:24 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 035BF1000C3;
        Tue, 20 Jul 2021 10:53:23 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 16K1rL8E026676;
        Tue, 20 Jul 2021 10:53:22 +0900
Date:   Tue, 20 Jul 2021 10:53:21 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, punit1.agrawal@toshiba.co.jp,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: clock: Add DT bindings for SMU of
 Toshiba Visconti TMPV770x SoC
X-TSB-HOP: ON
Message-ID: <20210720015321.6gndhnblrv54ncy3@toshiba.co.jp>
References: <20210624034337.282386-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210624034337.282386-4-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20210714192447.GA3059664@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714192447.GA3059664@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

Thanks for your review.

On Wed, Jul 14, 2021 at 01:24:47PM -0600, Rob Herring wrote:
> On Thu, Jun 24, 2021 at 12:43:36PM +0900, Nobuhiro Iwamatsu wrote:
> > Add device tree bindings for SMU (System Management Unit) controller of
> > Toshiba Visconti TMPV770x SoC series.
> > 
> > Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > ---
> >  .../clock/toshiba,tmpv770x-pismu.yaml         | 50 +++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
> > new file mode 100644
> > index 000000000000..18fdf4f2831b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/toshiba,tmpv770x-pismu.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/toshiba,tmpv770x-pismu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Toshiba Visconti5 TMPV770x SMU controller Device Tree Bindings
> > +
> > +maintainers:
> > +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > +
> > +description:
> > +  Toshia Visconti5 SMU (System Management Unit) which supports the clock
> > +  and resets on TMPV770x.
> > +
> > +properties:
> > +  compatible:
> > +    const: toshiba,tmpv7708-pismu
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  '#reset-cells':
> > +    const: 1
> 
> Is there a connection to the PLLs? What are the clock inputs?

The PLL used by this driver is created by the pll driver, and these
relationships are held by the structures within this driver.
Should I move these from driver to DT?

> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#clock-cells"
> > +  - "#reset-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        pismu: pismu@24200000 {
> 
> clock-controller@...

I will fix.

> 
> > +            compatible = "toshiba,tmpv7708-pismu";
> > +            reg = <0 0x24200000 0 0x2140>;
> > +            #clock-cells = <1>;
> > +            #reset-cells = <1>;
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

