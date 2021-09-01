Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66E43FD0B9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 03:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241620AbhIABaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 21:30:55 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:42864 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhIABax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 21:30:53 -0400
Received: by mail-ot1-f47.google.com with SMTP id c19-20020a9d6153000000b0051829acbfc7so1569487otk.9;
        Tue, 31 Aug 2021 18:29:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e7d5LjRjv/FxWQd5I6d33tUIdmNpt47w5kqmkdntcuc=;
        b=MZlJ8GYdJawuHS+NLt10lzZ/UftSf83tIGNl2I6Z1MJulUp6U6Ha1pu4wjRlolLkx6
         pJBkZYA4PmZTw52xp5Mb9GJQ+Xl0IEH8rofpSbarqnmlLrHLOz0YZXdtEO+8nf9AHpM0
         2x4myIiGSeki+6M13bdC/5CZo0XcqzPKttop5ltKOBPtPtFzloubGR2yKS5MYvGshlOs
         8T6FjseaRCE00UWwgOcdPxhwz1dalC6VkXmzqDa7F26jdjCyRumFLedR6fr9jBcKZ+0E
         thHn1Dgu4mUwwWkTSGcwQhZSqW6qg0NQ4qykoOTV8DGwNBgkzr4Pubc9QUP+dEtl13LX
         UxsA==
X-Gm-Message-State: AOAM533Yj6cmzhpMlgrcYSqgfyZnMpPjx2G/s8viBl8mffnaVK2rpmcC
        4R7N2T2hP5LMyJxgbNsmUA==
X-Google-Smtp-Source: ABdhPJzBDFJDVzRlaPUw+CRMfKPXCEl+gtanjAG1ln+T+b5zLvTvzhoVApRz+cSE4BL+u8dcr+Urwg==
X-Received: by 2002:a9d:5e05:: with SMTP id d5mr28375862oti.61.1630459797200;
        Tue, 31 Aug 2021 18:29:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v11sm4356634oto.22.2021.08.31.18.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:29:56 -0700 (PDT)
Received: (nullmailer pid 997400 invoked by uid 1000);
        Wed, 01 Sep 2021 01:29:55 -0000
Date:   Tue, 31 Aug 2021 20:29:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v3 06/11] dt-bindings: timer: Update SiFive CLINT
 bindings for IPI support
Message-ID: <YS7Xk/Np2yc1/wrb@robh.at.kernel.org>
References: <20210830041729.237252-1-anup.patel@wdc.com>
 <20210830041729.237252-7-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830041729.237252-7-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 09:47:24AM +0530, Anup Patel wrote:
> The Linux RISC-V now treats IPIs as regular per-CPU IRQs. This means
> we have to create a IPI interrupt domain to use CLINT IPI functionality
> hence requiring a "interrupt-controller" and "#interrupt-cells" DT
> property in CLINT DT nodes.
> 
> Impact of this CLINT DT bindings change only affects Linux RISC-V
> NoMMU kernel and has no effect of existing M-mode runtime firmwares
> (i.e. OpenSBI).

It appears to me you should fix Linux to not need these 2 useless 
properties. I say useless because #interrupt-cells being 0 is pretty 
useless.

> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  .../bindings/timer/sifive,clint.yaml          | 20 ++++++++++++++-----
>  arch/riscv/boot/dts/canaan/k210.dtsi          |  2 ++
>  .../boot/dts/microchip/microchip-mpfs.dtsi    |  2 ++
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a35952f48742..9c8ef9f4094f 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -43,6 +43,12 @@ properties:
>  
>    interrupts-extended:
>      minItems: 1
> +    maxItems: 4095
> +
> +  "#interrupt-cells":
> +    const: 0
> +
> +  interrupt-controller: true
>  
>  additionalProperties: false
>  
> @@ -50,15 +56,19 @@ required:
>    - compatible
>    - reg
>    - interrupts-extended
> +  - interrupt-controller
> +  - "#interrupt-cells"
>  
>  examples:
>    - |
>      timer@2000000 {
>        compatible = "sifive,fu540-c000-clint", "sifive,clint0";
> -      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
> -                             &cpu2intc 3 &cpu2intc 7
> -                             &cpu3intc 3 &cpu3intc 7
> -                             &cpu4intc 3 &cpu4intc 7>;
> -       reg = <0x2000000 0x10000>;
> +      interrupts-extended = <&cpu1intc 3>, <&cpu1intc 7>,
> +                            <&cpu2intc 3>, <&cpu2intc 7>,
> +                            <&cpu3intc 3>, <&cpu3intc 7>,
> +                            <&cpu4intc 3>, <&cpu4intc 7>;
> +      reg = <0x2000000 0x10000>;
> +      interrupt-controller;
> +      #interrupt-cells = <0>;
>      };
>  ...
> diff --git a/arch/riscv/boot/dts/canaan/k210.dtsi b/arch/riscv/boot/dts/canaan/k210.dtsi
> index 5e8ca8142482..67dcda1efadb 100644
> --- a/arch/riscv/boot/dts/canaan/k210.dtsi
> +++ b/arch/riscv/boot/dts/canaan/k210.dtsi
> @@ -105,6 +105,8 @@ clint0: timer@2000000 {
>  			reg = <0x2000000 0xC000>;
>  			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
>  					      &cpu1_intc 3 &cpu1_intc 7>;
> +			#interrupt-cells = <0>;
> +			interrupt-controller;
>  		};
>  
>  		plic0: interrupt-controller@c000000 {
> diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> index b9819570a7d1..67fb41439f20 100644
> --- a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> +++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
> @@ -168,6 +168,8 @@ &cpu1_intc 3 &cpu1_intc 7
>  						&cpu2_intc 3 &cpu2_intc 7
>  						&cpu3_intc 3 &cpu3_intc 7
>  						&cpu4_intc 3 &cpu4_intc 7>;
> +			#interrupt-cells = <0>;
> +			interrupt-controller;
>  		};
>  
>  		plic: interrupt-controller@c000000 {
> -- 
> 2.25.1
> 
> 
