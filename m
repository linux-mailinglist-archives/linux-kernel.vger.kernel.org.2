Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC103EF407
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 22:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbhHQU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 16:28:19 -0400
Received: from mail-oo1-f42.google.com ([209.85.161.42]:33423 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbhHQU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 16:28:18 -0400
Received: by mail-oo1-f42.google.com with SMTP id e3-20020a4ab9830000b029026ada3b6b90so40507oop.0;
        Tue, 17 Aug 2021 13:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pfMSBfRo6y4lD0HSYI6UuaPcJLWtNKVFgziILtRY1Q8=;
        b=Hu857/Y24vsK2Q/Y5WS9PTrImpwXGBaSRb557oXEnmIk6ZEEqiTg6KyQnFdPjJC2B+
         1IT6FaA2Stxp7+SeQhO51dR4suHUKH8F0Oc6ml/GZYZiP2dZlXZOpiUXv8wDjucxckXr
         H/xYiug+mBCsxNlpaadZWBOlPpJHyKd8nvxN263RR26w4JElA+FVV3Q8KtwG8M4SCOuI
         fK1a/g7Bk5npxKXhg1rFIDT7zrJ4df6/s6kRK5sLVNr4s1z5c7Nrt5E63jidEG5MWCXR
         52ZCr6Yay9LHqwsycIkR10AgNQHGM240MC4tAd5EVOb2egxGxpRAreJif3h0wsX8wpKV
         ZfHw==
X-Gm-Message-State: AOAM532N4X0WmrEoQJ1rnlwPA/4n6Iz2JBFoMEMF2zmcEfqBNXdnSQBD
        mVCM80CNAs4CnSawLknGHQ==
X-Google-Smtp-Source: ABdhPJxkFl9a5TIMvDkCD52dDtA9Qt3+/KCJuyspWzddVJx6G0d0mO8PN7ycZ29QfQIgBzOje5KcRg==
X-Received: by 2002:a4a:b6ca:: with SMTP id w10mr3884650ooo.17.1629232064261;
        Tue, 17 Aug 2021 13:27:44 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u126sm635932ooa.23.2021.08.17.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 13:27:43 -0700 (PDT)
Received: (nullmailer pid 783570 invoked by uid 1000);
        Tue, 17 Aug 2021 20:27:41 -0000
Date:   Tue, 17 Aug 2021 15:27:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bharat Bhushan <bbhushan2@marvell.com>
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: perf: marvell: cn10k ddr performance
 monitor
Message-ID: <YRwbvfCYl94UDseY@robh.at.kernel.org>
References: <20210810094307.29595-1-bbhushan2@marvell.com>
 <20210810094307.29595-2-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810094307.29595-2-bbhushan2@marvell.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:13:04PM +0530, Bharat Bhushan wrote:
> Add binding documentation for the Marvell CN10k DDR
> performance monitor unit.
> 
> Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> ---
> v1->v2:
>  - DT binding changed to new DT Schema
> 
>  .../bindings/perf/marvell-cn10k-ddr.yaml      | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> new file mode 100644
> index 000000000000..2a335444cf53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/perf/marvell-cn10k-ddr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell CN10K DDR performance monitor
> +
> +maintainers:
> +  - Bharat Bhushan <bbhushan2@marvell.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - marvell,cn10k-ddr-pmu
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        ddrcpmu@1 {

pmu@87e1c0000000

> +            compatible = "marvell,cn10k-ddr-pmu";
> +            reg = <0x87e1 0xc0000000 0x0 0x10000>;
> +        };
> +    };
> -- 
> 2.17.1
> 
> 
