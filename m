Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B64415135
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237475AbhIVUMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:12:39 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:35547 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237325AbhIVUMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:12:38 -0400
Received: by mail-oi1-f177.google.com with SMTP id r26so6313668oij.2;
        Wed, 22 Sep 2021 13:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oh1GCZM5dUTph3yDqFQtj2T4C/Cn9j3K4e4lsvOCfK8=;
        b=rLJPVkIYXx7D2MzJengMVKBnR5sBMOQGaZva0KzPjVW3zT0SjrebU9YAEFTR0F6X9B
         wcFe26h5XXVSMQGmDo3G+3s4UXYF76NIe/LWPYDqjDXD9T+YhYnvKJDBuXKGet0ge9Yi
         OAqev3lqdvWgfuq4784Ve9px5QrtAO2PLpGDocRCI31cHlvJTFxfMQCORyTIb8U4kkiR
         K2EKXj3uAudh0aZyxq/D77eISP25A0/K54TGI6JXyW+aRsQ9vkcvnEpt00w5ZObIBWLs
         Tw0zNpRXWtRdySeBXoQ4mhIoO0A0ZMBKmDskJ8yTtiQv/s8+Sqo50/TvQCtXgNqordCj
         nAKA==
X-Gm-Message-State: AOAM530Mud5ZHwzVadeLvUudc9s+1EWVRI8P5wUhoptxHNj9RNTYSSJc
        UfWU6Wk0IyZVBcLVgG25qQ==
X-Google-Smtp-Source: ABdhPJxB04SrAr3My4MhjbJhQuOo63xON3evPknQzkXmjb1Lubg7ZrL6tNv4aaW7+wLfUENPGGPcuA==
X-Received: by 2002:aca:1215:: with SMTP id 21mr9845091ois.141.1632341467793;
        Wed, 22 Sep 2021 13:11:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p21sm762115oip.28.2021.09.22.13.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:11:07 -0700 (PDT)
Received: (nullmailer pid 1210651 invoked by uid 1000);
        Wed, 22 Sep 2021 20:11:06 -0000
Date:   Wed, 22 Sep 2021 15:11:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eugen.Hristev@microchip.com, Manohar.Puri@microchip.com
Subject: Re: [PATCH v5 2/3] dt-bindings: clock: lan966x: Add LAN966X Clock
 Controller
Message-ID: <YUuN2o1G1ETkf/Zx@robh.at.kernel.org>
References: <20210917135142.9689-1-kavyasree.kotagiri@microchip.com>
 <20210917135142.9689-3-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917135142.9689-3-kavyasree.kotagiri@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 07:21:41PM +0530, Kavyasree Kotagiri wrote:
> This adds the DT bindings documentation for lan966x SoC
> generic clock controller.
> 
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---
> v4 -> v5:
> - In v4 dt-bindings, missed adding "clock-names" in required
>   properties and example. So, added them.
> 
> v3 -> v4:
> - Updated "clocks" description.
> - Added "clock-names".
> 
> v2 -> v3:
> - Fixed dt_binding_check errors.
> 
> v1 -> v2:
> - Updated example provided for clk controller DT node.
> 
>  .../bindings/clock/microchip,lan966x-gck.yaml | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> new file mode 100644
> index 000000000000..e6b4ed3b0c88
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/microchip,lan966x-gck.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN966X Generic Clock Controller
> +
> +maintainers:
> +  - Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> +
> +description: |
> +  The LAN966X Generic clock controller contains 3 PLLs - cpu_clk,
> +  ddr_clk and sys_clk. This clock controller generates and supplies
> +  clock to various peripherals within the SoC.
> +
> +properties:
> +  compatible:
> +    const: microchip,lan966x-gck
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: CPU clock source
> +      - description: DDR clock source
> +      - description: System clock source
> +
> +  clock-names:
> +    items:
> +      - const: cpu_clk
> +      - const: ddr_clk
> +      - const: sys_clk

'_clk' is redundant. Drop.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clks: clock-controller@e00c00a8 {
> +        compatible = "microchip,lan966x-gck";
> +        #clock-cells = <1>;
> +        clocks = <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> +        clock-names = "cpu_clk", "ddr_clk", "sys_clk";
> +        reg = <0xe00c00a8 0x38>;
> +    };
> +...
> -- 
> 2.17.1
> 
> 
