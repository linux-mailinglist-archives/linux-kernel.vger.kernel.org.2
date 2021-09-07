Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A64402EA3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhIGTB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:01:29 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:36477 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:01:24 -0400
Received: by mail-oi1-f170.google.com with SMTP id s20so197149oiw.3;
        Tue, 07 Sep 2021 12:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=28J5NqHJoIWycs1WnAlqhhwUzGeH7r7CUaTUyO/3C1k=;
        b=1by2DxMreWINzCbnCgZ5M5WtN0LIFIO89hin2P7Z0OoWDGooWVSPnYOnNi/IO4e/2j
         suOl9ep/+HvOESVbFNuDOA1vZcuSyRHjBL5LutQlE8P1VEVYgVHpe3jaRR8ttk6QM0SK
         NoaC8lRUOc9yN6bKRgS9o5DAfVRGZpa+AU5XPjY7Wn9giVSakX6o9SKQktfppszNV9TV
         7Hp1QiLuaYF/ve5nq2iG3CChT4VcJMgaGI7efGbHt6QIJpKHN1rXg19Jz/RzJYDcHAxy
         ZCbncBoo4fZ/b5ke+y/Yd+3x50r/a/dxkEQyp539+J/huCDeQxUoYa6m1sKMt86CslHf
         O6RQ==
X-Gm-Message-State: AOAM531AiBlDzDzuTDJYTcaFnBTl2hBwi63ZHWg4iFBiAbqNxUyzx/bX
        R570/20yeEL6FpK/03pHTA==
X-Google-Smtp-Source: ABdhPJxaBFDeFwzsjjBkCpki7FtUmqcjjzggNGWp09FvQmLQsm3jRkeiE7brTaTT6NVtVDEtEWaY6A==
X-Received: by 2002:aca:3b85:: with SMTP id i127mr4164230oia.28.1631041217526;
        Tue, 07 Sep 2021 12:00:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh25sm2299231oib.40.2021.09.07.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:00:16 -0700 (PDT)
Received: (nullmailer pid 159066 invoked by uid 1000);
        Tue, 07 Sep 2021 19:00:15 -0000
Date:   Tue, 7 Sep 2021 14:00:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     kavyasree.kotagiri@microchip.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eugen.Hristev@microchip.com, Manohar.Puri@microchip.com
Subject: Re: [PATCH 3/3] dt-bindings: clock: lan966x: Add LAN966X Clock
 Controller
Message-ID: <YTe2v8nQt36NyC/s@robh.at.kernel.org>
References: <20210902092954.28359-1-kavyasree.kotagiri@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902092954.28359-1-kavyasree.kotagiri@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:59:54PM +0530, kavyasree.kotagiri@microchip.com wrote:
> From: Kavyasree Kotagiri <Kavyasree.Kotagiri@microchip.com>

Ah, here's the rest. The threading of your series is broken.

> 
> This adds the DT bindings documentation for lan966x SoC
> generic clock controller.
> 
> Signed-off-by: Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>

Please make your author and Sob name and email match.

> ---
>  .../bindings/clock/microchip,lan966x-gck.yaml | 46 +++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> new file mode 100644
> index 000000000000..0df765f628c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> @@ -0,0 +1,46 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/microchip,lan966x-gck.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN966X Generic Clock Controller
> +
> +maintainers:
> +  - Kavya Sree Kotagiri <kavyasree.kotagiri@microchip.com>
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
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clks: clock-controller@e00c00a8 {
> +        compatible = "microchip,lan966x-gck";
> +        #clock-cells = <1>;
> +        clocks = <&cpu_clk>;
> +        reg = <0xe00c00a8 0x38>;

Looks like this is part of some other block?

> +    };
> +...
> --
> 2.17.1
> 
> 
