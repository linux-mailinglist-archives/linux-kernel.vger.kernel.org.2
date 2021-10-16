Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B908A4302FF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 16:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244400AbhJPO1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 10:27:10 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:45819 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhJPO1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 10:27:09 -0400
Received: by mail-oi1-f172.google.com with SMTP id z126so17499339oiz.12;
        Sat, 16 Oct 2021 07:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IMEr857ybnfV1ZK0e8VgyEcWE2UwvgOJLqJmvj+tNHk=;
        b=cqQDWx2KbbLzmw/Ui/JFcTMJqLQmM80beXtZT6QHyfAdFOhJEbPvkZP9tLSEhg/ayF
         e+MXMIgiS/+vJfYb9v/ZVaJQ8ODiqo5i4/o3FKWi/UiR6QWsTH44OBLkp4DEm6Ac67qn
         fwRU99Q3NBuCQvpHaxbd5duqJ2SPoDLDEYEZv9h66MYi6AWkL1xOU5wB0Fqi0C77wGk1
         A8bMdDGO0eurJqpwpJ2oJw1b2xQyOjNl+9Q61u1RIC6TQ7rRfBWz16i6afkyzVmcGf0/
         2gRv/vWGA+W0GDKwi6dCs7FAUwxIyOAmDgnXlv8tyNyysENdSkoXgOpHKLxHI1zwtF8L
         /Spw==
X-Gm-Message-State: AOAM5326eEHJiQqIcyMHQueUKOr0Hi4uwKLgThanwZQ7I6MyOv8lXFiR
        stdqr0iiIMLn01nPPjmLhg==
X-Google-Smtp-Source: ABdhPJyEM94SDVlFukwVuTu7eDYUPvrA7F9pIbzTXxzzyDN5KCNDxlTPICJhqd4FmqJc4B6FXJpBxQ==
X-Received: by 2002:aca:b385:: with SMTP id c127mr10593016oif.128.1634394300725;
        Sat, 16 Oct 2021 07:25:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i205sm1881723oih.54.2021.10.16.07.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 07:25:00 -0700 (PDT)
Received: (nullmailer pid 3882883 invoked by uid 1000);
        Sat, 16 Oct 2021 14:24:59 -0000
Date:   Sat, 16 Oct 2021 09:24:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     devicetree@vger.kernel.org, john@phrozen.org, neil@brown.name,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bus: add palmbus device tree bindings
Message-ID: <YWrgu42kSW/rpijq@robh.at.kernel.org>
References: <20211015191741.12963-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015191741.12963-1-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 09:17:41PM +0200, Sergio Paracuellos wrote:
> Add device tree bindings for palmbus controller present in all the MIPS
> ralink based SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../devicetree/bindings/bus/palmbus.yaml      | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/palmbus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/bus/palmbus.yaml b/Documentation/devicetree/bindings/bus/palmbus.yaml
> new file mode 100644
> index 000000000000..d5159a4f3cf8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/palmbus.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/palmbus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Ralink PalmBus Device Tree Bindings
> +
> +maintainers:
> +  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
> +
> +description: |
> +  The ralink palmbus controller can be found in all ralink MIPS
> +  SoCs. It provides an external bus for connecting multiple
> +  external devices to the SoC.
> +
> +properties:
> +  $nodename:
> +    pattern: "^palmbus(@[0-9a-f]+)?$"
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +  compatible:
> +    const: palmbus
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +patternProperties:
> +  # All other properties should be child nodes with unit-address and 'reg'
> +  "^[a-zA-Z][a-zA-Z0-9,+\\-._]{0,63}@[0-9a-fA-F]+$":

The node name pattern is already checked elsewhere. You only need to 
define the unit-address part which should be lowercase hex. So just:

'@[0-9a-f]+$'

> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    palmbus@1e000000 {
> +        compatible = "palmbus";
> +        reg = <0x1e000000 0x100000>
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x1e000000 0x0fffff>;
> +
> +        syscon@0 {
> +            compatible = "mediatek,mt7621-sysc", "syscon";
> +            reg = <0x0 0x100>;
> +            #clock-cells = <1>;
> +            #reset-cells = <1>;
> +            ralink,memctl = <&memc>;
> +            clock-output-names = "xtal", "cpu", "bus",
> +                                 "50m", "125m", "150m",
> +                                 "250m", "270m";
> +        };
> +
> +        wdt@100 {
> +            compatible = "mediatek,mt7621-wdt";
> +            reg = <0x100 0x100>;
> +        };
> +    };
> +
> +...
> -- 
> 2.33.0
> 
> 
