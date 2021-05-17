Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCCD386B90
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 22:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239728AbhEQUqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 16:46:32 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46986 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhEQUqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 16:46:30 -0400
Received: by mail-oi1-f175.google.com with SMTP id x15so7672287oic.13;
        Mon, 17 May 2021 13:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=gH68QCHkSHL5ITXi+xv/iLpD2+qdAQaA6vMcJS+K9MQ=;
        b=EUWOU4xChONkUo/YqF6d6v34ENzUwOPjHf9FcOXMcmzK3RHqtdyUmcPyDvt9cFy7Cy
         FJicQhxtVfGMHoYKKD4rz/8mpFTu5Id7PAIG+r5O676+XqicGUHMNXJ5Un3LROCQQyY+
         TLJ+yUJ+uJBHiC6iZQApf6R+uBDD8K2cfChrkoAIkuGDlZzfatwQ0LDWwWD29uQmVUQM
         o2s1CuKkDbp/SsXWpkVS9Yshj7L2r42XDqyfHY1tJ9NLz9IFiB36Kv+8jP/asxAQWRSK
         7LncQD/djDq1Q0gXOre1AbzlyBvO8elJ2h3w1cVssv7QuZC8ZneuwapF0GFlcazE1d44
         cRAA==
X-Gm-Message-State: AOAM53189K+ZwPpnp6lkAAyBtDselrBfbaY+aGrHFyyjA/jVQC9verTq
        ZRZSDiTzwk9ZNtQgLdxEQA==
X-Google-Smtp-Source: ABdhPJziioyL4CvftTGDP1cACEY1cuK4nhq7k/3hoUWgb7XiipAw8OuAyJ5KilFhuY7TdaX7R66ArQ==
X-Received: by 2002:a54:4501:: with SMTP id l1mr1218644oil.19.1621284312592;
        Mon, 17 May 2021 13:45:12 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a7sm3367649ooo.9.2021.05.17.13.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 13:45:12 -0700 (PDT)
Received: (nullmailer pid 3157709 invoked by uid 1000);
        Mon, 17 May 2021 20:45:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hector Yuan <hector.yuan@mediatek.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20210517155458.1016707-1-sudeep.holla@arm.com>
References: <20210517155458.1016707-1-sudeep.holla@arm.com>
Subject: Re: [PATCH v4] dt-bindings: dvfs: Add support for generic performance domains
Date:   Mon, 17 May 2021 15:45:11 -0500
Message-Id: <1621284311.383362.3157708.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 May 2021 16:54:58 +0100, Sudeep Holla wrote:
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
> Hi All,
> 
> Sorry for yet another delay, I don't want to mist this for v5.14 as Mediatek
> cpufreq driver was depending on this IIRC.
> 
> v3[3]->v4:
> 	- Dropped unnecessary phandle-array reference
> 	- Added maxItems = 1 for the property
> 
> v2[2]->v3[3]:
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

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml:0:0: /example-0/performance-controller@12340000: failed to match any schema with compatible: ['qcom,cpufreq-hw']

See https://patchwork.ozlabs.org/patch/1479615

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

