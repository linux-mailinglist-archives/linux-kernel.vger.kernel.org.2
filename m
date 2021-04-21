Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA15D3662EC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 02:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbhDUAMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 20:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbhDUAMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 20:12:09 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568E5C061763
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:11:36 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id x9so5013844uao.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 17:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nr8WfPTD0ymzHIbs2kjYSoWUK3mdmT/dSasQxodVNi4=;
        b=GI0ovTiZqm8iMDijT4AKKjtlbOiJDgwVXdcalz+E7xX62mEZJ37VWi/mWslqbVug/r
         HTOUNI+5vJnyoE73eJbkyqOggquJwm2Loj79niLY//q6M1JrIAk+Mn3llXaADlbTjTxk
         gXyqJcylyjURRI7oYreUxNV7uQgdWHUO/ZYeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nr8WfPTD0ymzHIbs2kjYSoWUK3mdmT/dSasQxodVNi4=;
        b=P1ku7uVmPbUsI/5ca+RnrpZEvZDp+4916DR5hK1QPPWnUzIysC58NJkaKIElI06uaR
         PsY8B6suJ6o8Kwn4+LQt9xUl5nuJi3wzl1oK83FJQM9wnMLK1HaZbU0YWmB1LUjis88k
         LKNVXmXQZsOX5jVAYVQMfa1ZyTF8QeI5CksL3GKHOkhifTZF4eZg81R8Vu6oKNSDVaSO
         ZtCryGvO+mwvbYUdpRm49cp7gpYVwp9gZq2jVGh+7NgTSjx23J8ZJd9xva088MxjdFj4
         1y3RA58LbG7lTx+B9c/bJkS/tXmXpYqTGnviWKu+dAJ9eQffXeDEiJxHbaMEsdO/5t1K
         7npw==
X-Gm-Message-State: AOAM531JQpFiOSy3fUAWg64Hdw2bnljepSGdQkY45Kk+3GFX3FKncrWG
        StSmuqLFdQzNDtfNlI3qLrJIFW57i2879tGjBdfBog==
X-Google-Smtp-Source: ABdhPJxUAnIDoIjMJ4cqmCiIvJa73yvdSkT6+oLpfc5i3QoBtmDV3PFojekJpmrhUyBafr5ivJ6qVjyvOPNT7jFjNAk=
X-Received: by 2002:ab0:380e:: with SMTP id x14mr15131536uav.27.1618963895533;
 Tue, 20 Apr 2021 17:11:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210126011759.1605641-1-drinkcat@chromium.org>
 <20210126091747.v11.1.Ie74d3355761aab202d4825ac6f66d990bba0130e@changeid> <CAL_Jsq+gWm+94zF1XN2KiRYgAZewiDkCk5B5bhLB=M+-HbD=fA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+gWm+94zF1XN2KiRYgAZewiDkCk5B5bhLB=M+-HbD=fA@mail.gmail.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Wed, 21 Apr 2021 08:11:24 +0800
Message-ID: <CANMq1KCNMx4hS02ZFd0NSOwvw3Xaqm13v8aHO6UMP5Nn3_uX-Q@mail.gmail.com>
Subject: Re: [PATCH v11 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
To:     Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Fei Shao <fshao@chromium.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 9:01 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jan 25, 2021 at 7:18 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> >
> > Define a compatible string for the Mali Bifrost GPU found in
> > Mediatek's MT8183 SoCs.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > ---
> >
> > Changes in v11:
> >  - binding: power-domain-names not power-domainS-names
> >
> > Changes in v10:
> >  - Fix the binding to make sure sram-supply property can be provided.
> >
> > Changes in v9: None
> > Changes in v8: None
> > Changes in v7: None
> > Changes in v6:
> >  - Rebased, actually tested with recent mesa driver.
> >
> > Changes in v5:
> >  - Rename "2d" power domain to "core2"
> >
> > Changes in v4:
> >  - Add power-domain-names description
> >    (kept Alyssa's reviewed-by as the change is minor)
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> >  .../bindings/gpu/arm,mali-bifrost.yaml        | 28 +++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > index 184492162e7e..3e758f88e2cd 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
> > @@ -17,6 +17,7 @@ properties:
> >      items:
> >        - enum:
> >            - amlogic,meson-g12a-mali
> > +          - mediatek,mt8183-mali
> >            - realtek,rtd1619-mali
> >            - rockchip,px30-mali
> >        - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
> > @@ -41,6 +42,8 @@ properties:
> >
> >    mali-supply: true
> >
> > +  sram-supply: true
> > +
> >    operating-points-v2: true
> >
> >    power-domains:
> > @@ -87,6 +90,31 @@ allOf:
> >      then:
> >        required:
> >          - resets
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: mediatek,mt8183-mali
> > +    then:
> > +      properties:
> > +        power-domains:
> > +          description:
> > +            List of phandle and PM domain specifier as documented in
> > +            Documentation/devicetree/bindings/power/power_domain.txt
> > +          minItems: 3
> > +          maxItems: 3
>
> This won't work because the top level schema restricts this to 1. The
> top level needs to say:
>
> power-domains:
>   minItems: 1
>   maxItems: 3
>
> And you need just 'minItems: 3' here and 'maxItems: 1' in the else clause.
>
> And drop the description. That's every 'power-domains' property.
>
> > +        power-domain-names:
> > +          items:
> > +            - const: core0
> > +            - const: core1
> > +            - const: core2
>
> Blank line

Thanks, hopefully all fixed in v12.

> > +      required:
> > +        - sram-supply
> > +        - power-domains
> > +        - power-domain-names
> > +    else:
> > +      properties:
> > +        sram-supply: false
> >
> >  examples:
> >    - |
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
