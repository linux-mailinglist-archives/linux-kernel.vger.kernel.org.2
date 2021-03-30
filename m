Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4060E34E92E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbhC3NdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:57384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229633AbhC3Ncw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:32:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F2633619AA;
        Tue, 30 Mar 2021 13:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617111172;
        bh=/yYVLyWKvVv26LpgYeLhvM6MKeIL7ldoxvnatHWYBX0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LcJC6V3rPnUajNCPMG/kGH6wcUNJf9XrAJlfdwZBsJ19StZukprioXGfWoTO7umNk
         BhqyRzrIv7O9oL/NFO6KR5KPcsyADTaYmjny0ONDyfTnYAt6ec+qz+hlG9lJdoILXL
         aOJ0mr6Y1sDFv3BVRSb6wE/xVIujRe9/EvemtWXqK0TFe6bEOxy5iuMs4q09esOTHu
         JJ/NIb4auGXVfCindKzwRfVxRDVhviexxcNrs09k0Hf95hWR1jtlMdcMxHuhzcCBEr
         yp1hj24JV6xF+GZJNzZNB+TzyI4PqQKHBevoWuiFpDRX1Q+b3VyQJUvhbBhus0Fbt2
         FsQvKxpOrVvFA==
Received: by mail-ej1-f45.google.com with SMTP id u5so24868626ejn.8;
        Tue, 30 Mar 2021 06:32:51 -0700 (PDT)
X-Gm-Message-State: AOAM532speMBVau2lhQWGypqSSvHHXKnSYgHkrpkAOk9Z7ubLkKC7KRb
        x5OjOoJAfEmFHTdciwI68470diq7zZrNHhz+iQ==
X-Google-Smtp-Source: ABdhPJw2XSH8K0e1LCw1wsvMysjFzSIZpjF4qrrslkHVgsX12VDBjHZfrQi/aLSHNt33dFsmoCDrtgyu3OtbR+n0wo4=
X-Received: by 2002:a17:906:c405:: with SMTP id u5mr33600338ejz.341.1617111170598;
 Tue, 30 Mar 2021 06:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201116181356.804590-1-sudeep.holla@arm.com> <20201118212009.GB1827746@bogus>
In-Reply-To: <20201118212009.GB1827746@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 30 Mar 2021 08:32:38 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+ODJ7o0h-v0cdxxPKwe_O3dwsM=HteL7RV7pbf6gSyXA@mail.gmail.com>
Message-ID: <CAL_Jsq+ODJ7o0h-v0cdxxPKwe_O3dwsM=HteL7RV7pbf6gSyXA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: dvfs: Add support for generic performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 3:20 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Nov 16, 2020 at 06:13:56PM +0000, Sudeep Holla wrote:
> > The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> > implementations where untrusted software had direct access to clock and
> > voltage hardware controls. In this attack, the malicious software was able to
> > place the platform into unsafe overclocked or undervolted configurations. Such
> > configurations then enabled the injection of predictable faults to reveal
> > secrets.
> >
> > Many Arm-based systems used to or still use voltage regulator and clock
> > frameworks in the kernel. These frameworks allow callers to independently
> > manipulate frequency and voltage settings. Such implementations can render
> > systems susceptible to this form of attack.
> >
> > Attacks such as CLKSCREW are now being mitigated by not having direct and
> > independent control of clock and voltage in the kernel and moving that
> > control to a trusted entity, such as the SCP firmware or secure world
> > firmware/software which are to perform sanity checking on the requested
> > performance levels, thereby preventing any attempted malicious programming.
> >
> > With the advent of such an abstraction, there is a need to replace the
> > generic clock and regulator bindings used by such devices with a generic
> > performance domains bindings.
> >
> > [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
> >
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  .../bindings/dvfs/performance-domain.yaml     | 76 +++++++++++++++++++
> >  1 file changed, 76 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> >
> > v1[1]->v2:
> >       - Changed to Dual License
> >       - Added select: true, enum for #performance-domain-cells and
> >         $ref for performance-domain
> >       - Changed the example to use real existing compatibles instead
> >         of made-up ones
> >
> > [1] https://lore.kernel.org/lkml/20201105173539.1426301-1-sudeep.holla@arm.com
> >
> > diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> > new file mode 100644
> > index 000000000000..29fb589a5192
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> > @@ -0,0 +1,76 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dvfs/performance-domain.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic performance domains
> > +
> > +maintainers:
> > +  - Sudeep Holla <sudeep.holla@arm.com>
> > +
> > +description: |+
> > +  This binding is intended for performance management of groups of devices or
> > +  CPUs that run in the same performance domain. Performance domains must not
> > +  be confused with power domains. A performance domain is defined by a set
> > +  of devices that always have to run at the same performance level. For a given
> > +  performance domain, there is a single point of control that affects all the
> > +  devices in the domain, making it impossible to set the performance level of
> > +  an individual device in the domain independently from other devices in
> > +  that domain. For example, a set of CPUs that share a voltage domain, and
> > +  have a common frequency control, is said to be in the same performance
> > +  domain.
> > +
> > +  This device tree binding can be used to bind performance domain consumer
> > +  devices with their performance domains provided by performance domain
> > +  providers. A performance domain provider can be represented by any node in
> > +  the device tree and can provide one or more performance domains. A consumer
> > +  node can refer to the provider by a phandle and a set of phandle arguments
> > +  (so called performance domain specifiers) of length specified by the
> > +  \#performance-domain-cells property in the performance domain provider node.
> > +
> > +select: true
>
> So apply to every node and...
>
> > +
> > +properties:
> > +  "#performance-domain-cells":
> > +    description:
> > +      Number of cells in a performance domain specifier. Typically 0 for nodes
> > +      representing a single performance domain and 1 for nodes providing
> > +      multiple performance domains (e.g. performance controllers), but can be
> > +      any value as specified by device tree binding documentation of particular
> > +      provider.
> > +    enum: [ 0, 1 ]
> > +
> > +  performance-domains:
> > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > +    description:
> > +      A phandle and performance domain specifier as defined by bindings of the
> > +      performance controller/provider specified by phandle.
> > +
> > +required:
> > +  - "#performance-domain-cells"
>
> Every node must have this!
>
> It can only be required in actual users.

If I wasn't clear, you need to drop 'required' as 'select: true' means
apply the schema to every node.

Rob
