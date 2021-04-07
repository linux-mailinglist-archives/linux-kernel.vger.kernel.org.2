Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A62363574CD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 21:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355565AbhDGTIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 15:08:22 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38511 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhDGTIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:08:20 -0400
Received: by mail-ot1-f48.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so19120620otk.5;
        Wed, 07 Apr 2021 12:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S68NotWKb2lyzTl0j+peAEwPYTHC/ZyjaiZ9vEXerEM=;
        b=pYp/aJ1YMMqD/TlTZIo/NjvHFGYUF3dF/6ruTvQjfPMsaPQF87Wgb4z31KZisqdEph
         WKIybhl2/+JErZjQ+4rewX6QaplvW0iQo9n8na5dvVOrm7rYvrPozyeY7QR95VX2VLns
         uoNpyZZpWE3CrMf9EtqTimWCL/v/Jh+2CRu0C3Znjhuk+kzmd+BBMqe1F9pD/rLm56W/
         us1j0pnS9TGHfUYqIC/j/q4mMv4pU2sRf7EfNJTvZATDXndWkAQSRIniQPI7lNykSwbx
         ZVmV0r493/5khF+loAbluiCVjbuTmsteM8dg5/SGamDia2czPBjfhYEZz+74ewI++aoV
         I7fw==
X-Gm-Message-State: AOAM530WWytpdpW0xxXY/rkVsAR6tjzRvbf0r01442megZhZXhZbsKaW
        nNpIcw+vFDTsKi1xRYNtvw==
X-Google-Smtp-Source: ABdhPJzS71L7Yzhk1J5gel0DrGglgjRJxmM9zG5q7ZDde/G63WHvQLB2OdxwNidBYgt7w0ZlLgx9sw==
X-Received: by 2002:a9d:6f04:: with SMTP id n4mr4145323otq.33.1617822490404;
        Wed, 07 Apr 2021 12:08:10 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p3sm5659472otk.9.2021.04.07.12.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 12:08:09 -0700 (PDT)
Received: (nullmailer pid 4062674 invoked by uid 1000);
        Wed, 07 Apr 2021 19:08:08 -0000
Date:   Wed, 7 Apr 2021 14:08:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] dt-bindings: dvfs: Add support for generic
 performance domains
Message-ID: <20210407190808.GA4053148@robh.at.kernel.org>
References: <20210407135913.2067694-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407135913.2067694-1-sudeep.holla@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 02:59:13PM +0100, Sudeep Holla wrote:
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
> ---
> 
> Hi All,
> 
> Sorry for the delay, I thought I had sent this out last week and it turns
> out that I had dry-run in my git email command and never removed it. Just
> noticed now looking for response for this patch on the list to find out
> that I never sent it out :(.
> 
> v2[2]->v3:
> 	- Dropped required properties
> 	- Added non cpu device example
> 	- Updated cpu bindings too
> 
> v1[1]->v2[2]:
> 	- Changed to Dual License
> 	- Added select: true, enum for #performance-domain-cells and
> 	  $ref for performance-domain
> 	- Changed the example to use real existing compatibles instead
> 	  of made-up ones
> 
> [1] https://lore.kernel.org/lkml/20201105173539.1426301-1-sudeep.holla@arm.com
> [2] https://lore.kernel.org/lkml/20201116181356.804590-1-sudeep.holla@arm.com
> 
>  .../devicetree/bindings/arm/cpus.yaml         |  7 ++
>  .../bindings/dvfs/performance-domain.yaml     | 80 +++++++++++++++++++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
> index 26b886b20b27..98590a2982d0 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.yaml
> +++ b/Documentation/devicetree/bindings/arm/cpus.yaml
> @@ -255,6 +255,13 @@ description: |+
>  
>        where voltage is in V, frequency is in MHz.
>  
> +  performance-domains:
> +    $ref: '/schemas/types.yaml#/definitions/phandle-array'

Can drop as it already has a type def.

Does more than 1 entry make sense for a CPU? If not, 'maxItems: 1'. It 
can always be extended later if the need arises.

> +    description:
> +      List of phandles and performance domain specifiers, as defined by
> +      bindings of the performance domain provider. See also
> +      dvfs/performance-domain.yaml.
> +
>    power-domains:
>      $ref: '/schemas/types.yaml#/definitions/phandle-array'
>      description:
> diff --git a/Documentation/devicetree/bindings/dvfs/performance-domain.yaml b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> new file mode 100644
> index 000000000000..640e676ed228
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dvfs/performance-domain.yaml
> @@ -0,0 +1,80 @@
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
> +    description:
> +      A phandle and performance domain specifier as defined by bindings of the
> +      performance controller/provider specified by phandle.

This implies there is only 1.

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
> +    gpu@2d000000 {
> +        compatible = "arm,mali-t624";
> +        reg = <0x2d000000 0x10000>;
> +        power-domains = <&power_devpd 2>;
> +        performance-domains = <&performance 4>;
> +    };
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
> +
> -- 
> 2.25.1
> 
