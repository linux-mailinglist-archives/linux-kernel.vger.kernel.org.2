Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09174364BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhJUOvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbhJUOvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:51:46 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE1C061348
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:49:30 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id r6so1175792oiw.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kMERyPmOcWXzgvq2qA9UPJ8hmaCYbxO5TYPP3bQCa7w=;
        b=MiKHpAAvOXWZVet2m4e+gw7ARFUVky/boatQib7dqM+urndcHhx8bkTpTkrDf5Lg+9
         27OFK2Hmazzlns4RcSSxuRE/O2D60E+4/6o39vl6FtPA7yqK6eInwQz3Z516ZtW4gQ4O
         Dpv0DhhNtE6FMsGB9q9+vA5CSMPoQdqvvOJc+KXghiB4RDd2z1a2eoyuvBk/5xWeVuQV
         srHjO+VdNk1xemgINIyaMjMkhSNMv8gX2rSXM8458PtHBxrrsfFGf+mNaILbyp2kYB8v
         WGkG+/i2omimT/PgX7Mc3tbtBV5Ldj5H6x4A5Eo1seK5dzOwVX36aon7dj8mCmfiUM38
         STJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kMERyPmOcWXzgvq2qA9UPJ8hmaCYbxO5TYPP3bQCa7w=;
        b=Oof8M79kuDsVxfsnWYLnfbO5TccSfy+2SP06/Ux7MvOL7+0TX8MGiVnnvYouBUjBDC
         R/4U9mcGn2NPOC8IzcZOekA/9PCf+IJRY9cUIJ/scHDzySzCYDx65MG/ia2iCUiU19mV
         XIl6VikRnoZOCN7MjYAa0srDi0tQF0S6llmxQ+kar8ilwTA6nimJBC+v0kAso0wxjgQ7
         ReC4W/hVK5W/yjQxDCoVbLCkniR6WOMoCRQxMWCfqtgepoZI2t9++8C5yXOGflsUiegp
         7k61WgiyfD7t1gM8GWZ801Ig8mp8YgRgYCOwbcKsrzxlDlN1CKGJPiYiCQUy9ySgIZ4K
         dvhg==
X-Gm-Message-State: AOAM531rc3+tfaimQ9j4M816XPOghi0gXXBtWYgBmPPWJ1TPNJUOKcuw
        VXNfuMb/MGfaIcirPy8uOzneOQ==
X-Google-Smtp-Source: ABdhPJxVBOoZntHPKwDJDY5kiIJMBaWqLeQlrGVdtmaXG890YNpOxGQY6JUwlGvprhgsiRGSco4xyQ==
X-Received: by 2002:a05:6808:221e:: with SMTP id bd30mr5444472oib.174.1634827769499;
        Thu, 21 Oct 2021 07:49:29 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id l10sm1091096otj.9.2021.10.21.07.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:49:29 -0700 (PDT)
Date:   Thu, 21 Oct 2021 07:51:12 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        abhinavk@codeaurora.org, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: phy: Introduce Qualcomm eDP/DP PHY
 binding
Message-ID: <YXF+YELFaQk+ouyH@ripper>
References: <20211016232128.2341395-1-bjorn.andersson@linaro.org>
 <YW3PqhQHauDYRlwN@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW3PqhQHauDYRlwN@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 18 Oct 12:48 PDT 2021, Rob Herring wrote:

> On Sat, Oct 16, 2021 at 04:21:27PM -0700, Bjorn Andersson wrote:
> > Introduce a binding for the eDP/DP PHY hardware block found in several
> > different Qualcomm platforms.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v2:
> > - None
> > 
> >  .../devicetree/bindings/phy/qcom,edp-phy.yaml | 69 +++++++++++++++++++
> >  1 file changed, 69 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > new file mode 100644
> > index 000000000000..c258e4f7e332
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
> > @@ -0,0 +1,69 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/phy/qcom,edp-phy.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm DP/eDP PHY
> > +
> > +maintainers:
> > +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> > +
> > +description:
> > +  The Qualcomm DP/eDP PHY is found in a number of Qualcomm platform and
> > +  provides the physical interface for DisplayPort and Embedded Display Port.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - qcom,sc8180x-dp-phy
> > +      - qcom,sc8180x-edp-phy
> 
> Is there a difference between DP and eDP?
> 

It's the same hardware block, with the same inputs, but the two modes
requires different programming sequences. So I need some way to describe
which one this is.

> Perhaps note what that is if so.
> 

What are you suggesting?

Regards,
Bjorn

> > +
> > +  reg:
> > +    items:
> > +      - description: PHY base register block
> > +      - description: tx0 register block
> > +      - description: tx1 register block
> > +      - description: PLL register block
> > +
> > +  clocks:
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    items:
> > +      - const: aux
> > +      - const: cfg_ahb
> > +
> > +  "#clock-cells":
> > +    const: 1
> > +
> > +  "#phy-cells":
> > +    const: 0
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - clocks
> > +  - clock-names
> > +  - "#clock-cells"
> > +  - "#phy-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    phy@aec2a00 {
> > +      compatible = "qcom,sc8180x-edp-phy";
> > +      reg = <0x0aec2a00 0x1c0>,
> > +            <0x0aec2200 0xa0>,
> > +            <0x0aec2600 0xa0>,
> > +            <0x0aec2000 0x19c>;
> > +
> > +      clocks = <&dispcc 0>, <&dispcc 1>;
> > +      clock-names = "aux", "cfg_ahb";
> > +
> > +      #clock-cells = <1>;
> > +      #phy-cells = <0>;
> > +    };
> > +...
> > -- 
> > 2.29.2
> > 
> > 
