Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D58315B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhBJAjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:39:48 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:43411 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbhBIU75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:59:57 -0500
Received: by mail-oi1-f172.google.com with SMTP id d20so20924002oiw.10;
        Tue, 09 Feb 2021 12:59:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1pFQxRqA7pwwbpDRPrTabjXC5pKxQglsd9mMJ/rVkfA=;
        b=BUqr8XUT8/Is7VrFtdHRdvdgWN6EzhaMTXCHDLD+U+usbzv78RSjGlzZtON3Y8Jkdx
         8S9KPQYcmGx7yysXVlXFvVj3mYlJjY39+OyX4m4/c09XvDhpUvxaMJHpPRKkxWibK1XR
         q1NlaNfeAzkU1yIUsGzL4Rz9ngWFaRxe+wDO+9kbEu0U6RZzvdkp/YeOhhe54lw0xdGQ
         +wNK4OvegVDmgZdvfKdFIyeHdq41teKzhPI8XIQ1qEJG5HgqOcBEeHEcXs0zviBH7IHV
         r+UMZMAYc4PeOMe5Vw5LfiYJxm23GuByyDQTJgONBCSmwlQl0hi2Ejjre+pfPeOBVHgp
         0A/A==
X-Gm-Message-State: AOAM533jSFWiCWmiiyVYSsJ3bGDRrTteh8Fzs7qYzxYzdoD4lmZiljpZ
        BP90LpQ7V3SaBJigm6VdHMI49Cpf8A==
X-Google-Smtp-Source: ABdhPJzXDZLzbrCk09AaBERqSNisnXCLkNA0Hm1UCP6W7w4JBoDw6xivdV4L/wUJtJTwvoiX6lMWOg==
X-Received: by 2002:aca:d14:: with SMTP id 20mr3633257oin.157.1612897233375;
        Tue, 09 Feb 2021 11:00:33 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y10sm2197802otq.71.2021.02.09.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:00:32 -0800 (PST)
Received: (nullmailer pid 4153442 invoked by uid 1000);
        Tue, 09 Feb 2021 19:00:31 -0000
Date:   Tue, 9 Feb 2021 13:00:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, lcherian@marvell.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH V3 06/14] dts: bindings: Document device tree bindings
 for ETE
Message-ID: <20210209190031.GA4102836@robh.at.kernel.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-7-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611737738-1493-7-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:25:30PM +0530, Anshuman Khandual wrote:
> From: Suzuki K Poulose <suzuki.poulose@arm.com>
> 
> Document the device tree bindings for Embedded Trace Extensions.
> ETE can be connected to legacy coresight components and thus
> could optionally contain a connection graph as described by
> the CoreSight bindings.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V3:
> 
> - Fixed all DT yaml semantics problems
> 
>  Documentation/devicetree/bindings/arm/ete.yaml | 74 ++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/ete.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/ete.yaml b/Documentation/devicetree/bindings/arm/ete.yaml
> new file mode 100644
> index 0000000..edc1fe2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/ete.yaml
> @@ -0,0 +1,74 @@
> +# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
> +# Copyright 2021, Arm Ltd
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/ete.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: ARM Embedded Trace Extensions
> +
> +maintainers:
> +  - Suzuki K Poulose <suzuki.poulose@arm.com>
> +  - Mathieu Poirier <mathieu.poirier@linaro.org>
> +
> +description: |
> +  Arm Embedded Trace Extension(ETE) is a per CPU trace component that
> +  allows tracing the CPU execution. It overlaps with the CoreSight ETMv4
> +  architecture and has extended support for future architecture changes.
> +  The trace generated by the ETE could be stored via legacy CoreSight
> +  components (e.g, TMC-ETR) or other means (e.g, using a per CPU buffer
> +  Arm Trace Buffer Extension (TRBE)). Since the ETE can be connected to
> +  legacy CoreSight components, a node must be listed per instance, along
> +  with any optional connection graph as per the coresight bindings.
> +  See bindings/arm/coresight.txt.
> +
> +properties:
> +  $nodename:
> +    pattern: "^ete([0-9a-f]+)$"
> +  compatible:
> +    items:
> +      - const: arm,embedded-trace-extension
> +
> +  cpu:

We've already established 'cpus' for this purpose.

> +    description: |
> +      Handle to the cpu this ETE is bound to.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  out-ports:
> +    type: object

Replace with: $ref: /schemas/graph.yaml#/properties/ports

> +    description: |
> +      Output connections from the ETE to legacy CoreSight trace bus.
> +    properties:
> +      port:
> +        $ref: /schemas/graph.yaml#/properties/port

Actually, if only 1 port ever, you can drop 'out-ports' and just have 
'port'. Not sure though if the coresight stuff depends on 'out-ports'.

> +
> +required:
> +  - compatible
> +  - cpu
> +
> +additionalProperties: false
> +
> +examples:
> +
> +# An ETE node without legacy CoreSight connections
> +  - |
> +    ete0 {
> +      compatible = "arm,embedded-trace-extension";
> +      cpu = <&cpu_0>;
> +    };
> +# An ETE node with legacy CoreSight connections
> +  - |
> +   ete1 {
> +      compatible = "arm,embedded-trace-extension";
> +      cpu = <&cpu_1>;
> +
> +      out-ports {        /* legacy coresight connection */
> +         port {
> +             ete1_out_port: endpoint {
> +                remote-endpoint = <&funnel_in_port0>;
> +             };
> +         };
> +      };
> +   };
> +
> +...
> -- 
> 2.7.4
> 
