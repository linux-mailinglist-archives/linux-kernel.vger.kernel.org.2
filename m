Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3240EB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 22:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238480AbhIPUUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 16:20:38 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:45620 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhIPUUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 16:20:15 -0400
Received: by mail-oo1-f54.google.com with SMTP id m14-20020a4ad50e000000b002912a944a47so2445070oos.12;
        Thu, 16 Sep 2021 13:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ofqDCzJVJ7CG7oCu1wZMMmGlXuT7MezSEWFRzUjJBXM=;
        b=oVwdF7BfebzC6/kDupKnWPSG61RtPZjODvuvvaCAc/FOLsjyx6MyusGNSZGglP+EMp
         eT/HMlV6oGPdZgfXrzeeFfdx471w5wfHCGIHH36MjyQ4K2WfiOxJl2NZ2KoRbioaMdXS
         v8aToqM2gzf1cQ9b9f+Ql6Bbukrh5aT6fRxI5uBB9mN0fd8JPTP7UbPoF46s2mAXNAOw
         DUoTf1G7T8reDtSKKvovf1z1t/He1L33xoF7dcFuVUp6V/R2mwyLZL9yyicVJpbWsP6L
         57d6i7NX5pytNFbi7PBEpGeYgVeGP/BtqOGuhi+EXdf41RHLBS23bJ7yomtxbnZo4NfA
         xUcQ==
X-Gm-Message-State: AOAM531flBYlsExZvuFCq+N9MO5RbsbUA1lDQ6YWGM3qYRXH048c0Gua
        +Rr0bmD16hvXG12h7VJfWg==
X-Google-Smtp-Source: ABdhPJwo9TXcC5oMk0jmObTfxCKEHKU6py7NTfYcL2KNnjSNHzC/7WpXjYyYx7EIeF4CtCmvg4x5Vw==
X-Received: by 2002:a4a:984b:: with SMTP id z11mr5915240ooi.76.1631823534247;
        Thu, 16 Sep 2021 13:18:54 -0700 (PDT)
Received: from robh.at.kernel.org (107-211-252-53.lightspeed.cicril.sbcglobal.net. [107.211.252.53])
        by smtp.gmail.com with ESMTPSA id s8sm954281otd.76.2021.09.16.13.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 13:18:53 -0700 (PDT)
Received: (nullmailer pid 1429271 invoked by uid 1000);
        Thu, 16 Sep 2021 20:18:51 -0000
Date:   Thu, 16 Sep 2021 15:18:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, andrew@aj.id.au,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org,
        osk@google.com, yulei.sh@bytedance.com
Subject: Re: [PATCH v5 2/4] dt-bindings: aspeed: Add UART routing controller
Message-ID: <YUOmq4hLoP2ds18w@robh.at.kernel.org>
References: <20210916092515.10553-1-chiawei_wang@aspeedtech.com>
 <20210916092515.10553-3-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916092515.10553-3-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 05:25:13PM +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed UART routing controller.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++
>  .../bindings/soc/aspeed/uart-routing.yaml     | 70 +++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> index 54f080df5e2f..697331d840a0 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.yaml
> @@ -142,6 +142,10 @@ patternProperties:
>        - interrupts
>        - snoop-ports
>  
> +  "^uart-routing@[0-9a-f]+$":
> +    $ref: /schemas/soc/aspeed/uart-routing.yaml#
> +    description: The UART routing control under LPC register space
> +
>  required:
>    - compatible
>    - reg
> diff --git a/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> new file mode 100644
> index 000000000000..534b2a9340ce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# # Copyright (c) 2018 Google LLC
> +# # Copyright (c) 2021 Aspeed Technology Inc.
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/aspeed/uart-routing.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Aspeed UART Routing Controller
> +
> +maintainers:
> +  - Oskar Senft <osk@google.com>
> +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> +
> +description:
> +  The Aspeed UART routing control allow to dynamically route the inputs for
> +  the built-in UARTS and physical serial I/O ports.
> +
> +  This allows, for example, to connect the output of UART to another UART.
> +  This can be used to enable Host <-> BMC communication via UARTs, e.g. to
> +  allow access to the Host's serial console.
> +
> +  This driver is for the BMC side. The sysfs files allow the BMC userspace
> +  which owns the system configuration policy, to configure how UARTs and
> +  physical serial I/O ports are routed.
> +
> +  Two types of files, uart* and io*, are presented in sysfs. The uart*
> +  configures the input signal of a UART controller whereas io* configures
> +  that of a physical serial port.
> +
> +  When read, each file shows the list of available options with currently
> +  selected option marked by brackets "[]". The list of available options
> +  depends on the selected file.
> +
> +  e.g.
> +  cat /sys/bus/platform/drivers/aspeed-uart-routing/*.uart_routing/uart1
> +  [io1] io2 io3 io4 uart2 uart3 uart4 io6
> +
> +  In this case, UART1 gets its input from IO1 (physical serial port 1).

This is about documenting the hardware, not an OS driver.

sysfs files have their own documentation.

> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - aspeed,ast2400-uart-routing
> +          - aspeed,ast2500-uart-routing
> +          - aspeed,ast2600-uart-routing
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    lpc: lpc@1e789000 {
> +        compatible = "aspeed,ast2600-lpc-v2", "simple-mfd", "syscon";
> +        reg = <0x1e789000 0x1000>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        ranges = <0x0 0x1e789000 0x1000>;
> +
> +        uart_routing: uart-routing@98 {
> +            compatible = "aspeed,ast2600-uart-routing";
> +            reg = <0x98 0x8>;
> +        };
> +    };
> -- 
> 2.17.1
> 
> 
