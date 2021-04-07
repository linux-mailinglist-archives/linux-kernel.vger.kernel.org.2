Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EBE3573BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354987AbhDGR5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 13:57:19 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:46751 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhDGR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 13:57:13 -0400
Received: by mail-oi1-f170.google.com with SMTP id m13so19617378oiw.13;
        Wed, 07 Apr 2021 10:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QNzMVzWilCW7GFTxLzRY3CP4tmq1W5icoQKlT8/AnWk=;
        b=Z6TtqcoFi7PQaIOj33YC9aYv3kVPCQAiskqeHpf3tuHFfXsxObOliyES43FyiWygay
         OOfxHoBACoA1Z4+iHb1Cps5azG6hMSDSt4S1kwhpN4YnThmqwv6HSqDc1piFTRrubxUO
         jZyHaKnoX6puNLaA4bdNGxqw+wNtlworYRRqHqcdOOncOBgmwr6bZRLMvMLZUUJxUXq7
         aAyghzy4O1FcdOEs5S8jeoSVdciPRBRwRSqGiegIAlA9mnW4WsU02ez1lzD9YvC+aM1O
         u3WYJ8gya/SI0nqcpWUltYHHLY78yDVGAWwr1OfHjYMn02QSTaOdY2uqyLUDMunZoUfa
         iNGA==
X-Gm-Message-State: AOAM530RZdve3zgcaRb5o4V0fNZmVyqt+B4SI6fISTS4YNqjZIFtfm5G
        MspdKFJhZc0xDyPlqDP9gdSopiPCDg==
X-Google-Smtp-Source: ABdhPJyh+dZAA4LSnKxmF0EOEA4uSe+tbhoQ5Wxz7RY90APCrr0Og407DSjgRv5tgOdIep9D8EsfHA==
X-Received: by 2002:aca:3152:: with SMTP id x79mr3249066oix.154.1617818210978;
        Wed, 07 Apr 2021 10:56:50 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h23sm5434980ots.0.2021.04.07.10.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 10:56:50 -0700 (PDT)
Received: (nullmailer pid 3971004 invoked by uid 1000);
        Wed, 07 Apr 2021 17:56:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hector Yuan <hector.yuan@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
In-Reply-To: <20210407135913.2067694-1-sudeep.holla@arm.com>
References: <20210407135913.2067694-1-sudeep.holla@arm.com>
Subject: Re: [PATCH v3] dt-bindings: dvfs: Add support for generic performance domains
Date:   Wed, 07 Apr 2021 12:56:49 -0500
Message-Id: <1617818209.066751.3971003.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Apr 2021 14:59:13 +0100, Sudeep Holla wrote:
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml:0:0: /example-0/performance-controller@12340000: failed to match any schema with compatible: ['qcom,cpufreq-hw']
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: gpu@2d000000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,mali-t624'] is too short
	'arm,mali-t624' is not one of ['samsung,exynos5250-mali']
	'arm,mali-t624' is not one of ['samsung,exynos5420-mali']
	'arm,mali-t624' is not one of ['allwinner,sun50i-h6-mali']
	'arm,mali-t624' is not one of ['amlogic,meson-gxm-mali', 'realtek,rtd1295-mali']
	'arm,mali-t624' is not one of ['arm,juno-mali']
	'arm,mali-t624' is not one of ['rockchip,rk3288-mali', 'samsung,exynos5433-mali']
	'arm,mali-t624' is not one of ['rockchip,rk3399-mali']
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: gpu@2d000000: 'interrupt-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: gpu@2d000000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: gpu@2d000000: 'performance-domains' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: gpu@2d000000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpu/arm,mali-midgard.yaml

See https://patchwork.ozlabs.org/patch/1463354

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

