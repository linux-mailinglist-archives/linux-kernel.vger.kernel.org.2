Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7565D42D790
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhJNK7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbhJNK7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 06:59:30 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E21EC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:57:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id j21so25475375lfe.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 03:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ma08bvDadRdvRvgbZtqFit3zzSDqXJrS+2FBtySKRxU=;
        b=cazHXUBdAQyBuFmFhsy9XkDETVnSAk8yNl57LhdM/2YL28eSrRXfS58kKGeNV5KUIi
         FlFAlz0pElKm4hNqV8xtJHkB9fHDRIiH1tr4ZWeK/JJuP2xD/Nha2hAHY11QY4O1YYGb
         rq9GHr+5FQmGCf/6x+GLgJt7eAPRZ1FGo9R30wBMX0x6AICY69fzL4ya3b8Yt1+UXoGb
         0teZUUa36b7SwU+USGomMvuWu7aLFkobH/Pip4n4woY1P+EWfy4shQq7qTD+cxfC8pIa
         CIzgrjq0bRcvfDRu+qce1F0Ay10+ELllrZumW1KEckyU5IT+/8rakwH2MZe8oDz8amDI
         6o4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ma08bvDadRdvRvgbZtqFit3zzSDqXJrS+2FBtySKRxU=;
        b=aCKYGzvxfC74+lkvINi2V31vPFk0ynEYO4Vk1JMBob/DZrdANzAKUeEAkO3k0BTTHa
         AzBmtwNtq2kwRyHW0d7EXg9LYCbd9Jm3UwQJ4cIJS+7rW2ufVxiFIeeVoRDblvLajl3j
         3UizOuJf3WdjwIBikgjtwN2NMSYoZQ74gu1s0314RbtFZGOqrBnKjnGYENVbdHcj71Z+
         XldC702W9l6hAyNz24nR97/AaqI5nzPqB5uP+oqJJV6YOqOGcqX6HBRjLHvYBinldvL2
         LTIQlRUPoRMKdBsdUSfocy8XzsvRW05OPf17GnSHvpSlMUEnkFoBztFS9dV63WsyB3oV
         BaVw==
X-Gm-Message-State: AOAM533wz5hns0I3RGnIVZcyg5WIYyFZ+QTNqPt0lhnrtj0xOqfJMONZ
        gg07zTEyVvrItFfZmoJpQ8ZHLfTGzmexIFQlnsYcbg==
X-Google-Smtp-Source: ABdhPJzDAHuKVlcnDqyOJuGpNsQIygzy9EU9xzAOTUoW9JQ1UcjzGNS+dQu9a/MW/yHlYPvy2uTc41FmE0Rq4Ayo428=
X-Received: by 2002:a05:6512:4029:: with SMTP id br41mr4551434lfb.233.1634209043477;
 Thu, 14 Oct 2021 03:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
In-Reply-To: <20210517155458.1016707-1-sudeep.holla@arm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Oct 2021 12:56:46 +0200
Message-ID: <CAPDyKFr=pf-0JbkiD6rkzeWwPZmDxEE_R=ovhzRUHfVjO9S0tw@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 at 18:14, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> The CLKSCREW attack [0] exposed security vulnerabilities in energy management
> implementations where untrusted software had direct access to clock and
> voltage hardware controls. In this attack, the malicious software was able to
> place the platform into unsafe overclocked or undervolted configurations. Such
> configurations then enabled the injection of predictable faults to reveal
> secrets.
>
> Many Arm-based systems used to or still use voltage regulator and clock
> frameworks in the kernel. These frameworks allow callers to independently
> manipulate frequency and voltage settings. Such implementations can render
> systems susceptible to this form of attack.
>
> Attacks such as CLKSCREW are now being mitigated by not having direct and
> independent control of clock and voltage in the kernel and moving that
> control to a trusted entity, such as the SCP firmware or secure world
> firmware/software which are to perform sanity checking on the requested
> performance levels, thereby preventing any attempted malicious programming.
>
> With the advent of such an abstraction, there is a need to replace the
> generic clock and regulator bindings used by such devices with a generic
> performance domains bindings.
>
> [0] https://www.usenix.org/conference/usenixsecurity17/technical-sessions/presentation/tang
>
> Link: https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
> Cc: Rob Herring <robh+dt@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Hi Sudeep/Viresh/Rob,

I noticed this binding recently got accepted, so I guess I have missed
the opportunity to provide you with a few comments.

In any case, I would like to ask a few questions. In particular, am I
trying to understand why the power-domains bindings [1] can't be used
for this?

The power-domains are capable of dealing with "performance" through
the "operating-points-v2" DT property, which maps to the generic OPP
bindings [2]. I wonder why that isn't sufficient here? Can you please
elaborate?

[1]
Documentation/devicetree/bindings/power/power-domain.yaml

[2]
Documentation/devicetree/bindings/opp/opp-v2-base.yaml

Kind regards
Uffe

> ---
> Hi All,
>
> Sorry for yet another delay, I don't want to mist this for v5.14 as Mediatek
> cpufreq driver was depending on this IIRC.
>
> v3[3]->v4:
>         - Dropped unnecessary phandle-array reference
>         - Added maxItems = 1 for the property
>
> v2[2]->v3[3]:
>         - Dropped required properties
>         - Added non cpu device example
>         - Updated cpu bindings too
>
> v1[1]->v2[2]:
>         - Changed to Dual License
>         - Added select: true, enum for #performance-domain-cells and
>           $ref for performance-domain
>         - Changed the example to use real existing compatibles instead
>           of made-up ones
>
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/r/20201105173539.1426301-1-sudeep.holla@arm.com
> [2] https://lore.kernel.org/r/20201116181356.804590-1-sudeep.holla@arm.com
> [3] https://lore.kernel.org/r/20210407135913.2067694-1-sudeep.holla@arm.com
>
>  .../devicetree/bindings/arm/cpus.yaml         |  7 ++
>  .../bindings/dvfs/performance-domain.yaml     | 74 +++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index f3c7249c73d6..9a2432a88074 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -257,6 +257,13 @@ description: |+
>
>        where voltage is in V, frequency is in MHz.
>
> +  performance-domains:
> +    maxItems: 1
> +    description:
> +      List of phandles and performance domain specifiers, as defined by
> +      bindings of the performance domain provider. See also
> +      dvfs/performance-domain.yaml.
> +
>    power-domains:
>      description:
>        List of phandles and PM domain specifiers, as defined by bindings of the
> diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> new file mode 100644
> index 000000000000..c8b91207f34d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dvfs/performance-domain.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic performance domains
> +
> +maintainers:
> +  - Sudeep Holla <sudeep.holla@arm.com>
> +
> +description: |+
> +  This binding is intended for performance management of groups of devices or
> +  CPUs that run in the same performance domain. Performance domains must not
> +  be confused with power domains. A performance domain is defined by a set
> +  of devices that always have to run at the same performance level. For a given
> +  performance domain, there is a single point of control that affects all the
> +  devices in the domain, making it impossible to set the performance level of
> +  an individual device in the domain independently from other devices in
> +  that domain. For example, a set of CPUs that share a voltage domain, and
> +  have a common frequency control, is said to be in the same performance
> +  domain.
> +
> +  This device tree binding can be used to bind performance domain consumer
> +  devices with their performance domains provided by performance domain
> +  providers. A performance domain provider can be represented by any node in
> +  the device tree and can provide one or more performance domains. A consumer
> +  node can refer to the provider by a phandle and a set of phandle arguments
> +  (so called performance domain specifiers) of length specified by the
> +  \#performance-domain-cells property in the performance domain provider node.
> +
> +select: true
> +
> +properties:
> +  "#performance-domain-cells":
> +    description:
> +      Number of cells in a performance domain specifier. Typically 0 for nodes
> +      representing a single performance domain and 1 for nodes providing
> +      multiple performance domains (e.g. performance controllers), but can be
> +      any value as specified by device tree binding documentation of particular
> +      provider.
> +    enum: [ 0, 1 ]
> +
> +  performance-domains:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> +    maxItems: 1
> +    description:
> +      A phandle and performance domain specifier as defined by bindings of the
> +      performance controller/provider specified by phandle.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    performance: performance-controller@12340000 {
> +        compatible = "qcom,cpufreq-hw";
> +        reg = <0x12340000 0x1000>;
> +        #performance-domain-cells = <1>;
> +    };
> +
> +    // The node above defines a performance controller that is a performance
> +    // domain provider and expects one cell as its phandle argument.
> +
> +    cpus {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +
> +        cpu@0 {
> +            device_type = "cpu";
> +            compatible = "arm,cortex-a57";
> +            reg = <0x0 0x0>;
> +            performance-domains = <&performance 1>;
> +        };
> +    };
> --
> 2.25.1
>
