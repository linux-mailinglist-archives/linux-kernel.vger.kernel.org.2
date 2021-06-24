Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E737C3B3885
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhFXVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:22:48 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:36628 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXVWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:22:44 -0400
Received: by mail-io1-f54.google.com with SMTP id s19so10042250ioc.3;
        Thu, 24 Jun 2021 14:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SdE3QH9IH0zgQ0o6AzU3ezQaPTbrlo0dJaYPuQ4zJMg=;
        b=eppqgrSk2ud2Ge6nnth0+VnlK7yJQPXGLmaYpNsEWE+uzOLRN2hIqFnJDGPoMWEoC/
         7u0LQBBrh+XEhTRPv1Xaxx3eWDE16081P1Nk6Yn29+6g5bacjD4Mz8DaoqcaTVN+pNDx
         49TvmzqQ0gxbtmSnx7d4QPbJUeYJMMkzlKPMYg65j7DaGSXrbTdmFr0Gwrh19c8eR4lY
         m6jdj/CJEufQNX2Mik9XkIvcrbMdAntVlz+kqFSsd1w8KnsPXpF23iItVk4nmJavV6zw
         i9Teuo/ZyzfTyDApVYNr99KaTi97zFJTyhZBi9lv1N+1fAcWbw/5Qxa2b9usMCg89A8M
         gHsg==
X-Gm-Message-State: AOAM530C9MNll+ChtU8q0SfFBxgzCZl8JYCZg99N49n8WCcz5faS4qAJ
        YaJyszFiYb4zRuiKn8ODzw==
X-Google-Smtp-Source: ABdhPJxZn6wIu1x3OXf+DxLhKGIb9idVzloiuJ8I/aNonOKkgdSNXb3w3PydCIFU7xhWnnkRbvhcPQ==
X-Received: by 2002:a02:cf82:: with SMTP id w2mr6452503jar.3.1624569623451;
        Thu, 24 Jun 2021 14:20:23 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l11sm2452159ilo.77.2021.06.24.14.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:20:22 -0700 (PDT)
Received: (nullmailer pid 2005523 invoked by uid 1000);
        Thu, 24 Jun 2021 21:20:18 -0000
Date:   Thu, 24 Jun 2021 15:20:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Fu Wei <tekkamanninja@gmail.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: riscv: add starfive jh7100 compatibles
Message-ID: <20210624212018.GA2003868@robh.at.kernel.org>
References: <20210616202654.578870-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616202654.578870-1-drew@beagleboard.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 01:27:00PM -0700, Drew Fustini wrote:
> Add DT binding documentation for the StarFive JH7100 Soc [1] and the
> BeagleV Starlight JH7100 board [2].
> 
> [1] https://github.com/starfive-tech/beaglev_doc
> [2] https://github.com/beagleboard/beaglev-starlight
> 
> Signed-off-by: Drew Fustini <drew@beagleboard.org>
> ---
> Note: my patch to add 'starfive' to vendor-prefixes.yaml was applied by
> Rob back on June 2:
> https://lore.kernel.org/linux-devicetree/20210602163200.GA3513985@robh.at.kernel.org/
> 
> I ran dt_binding_check and dtbs_check: 
> 
>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dt_binding_check \
>   DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml 
>   CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
>   DTC     Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/riscv/starfive.example.dt.yaml
> 
>   $ make -j8 ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- dtbs_check \
>   DT_SCHEMA_FILES=Documentation/devicetree/bindings/riscv/starfive.yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTC     arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
>   CHECK   arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dt.yaml
> 
> The files jh7100.dtsi and jh7100-beaglev-starlight.dts are in the
> process of being cleaned up for submission. The current downstream is:
> https://github.com/starfive-tech/linux/tree/beaglev/arch/riscv/boot/dts/starfive
> 
>  .../devicetree/bindings/riscv/starfive.yaml   | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/starfive.yaml
> 
> diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
> new file mode 100644
> index 000000000000..4deae9f5c60d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/riscv/starfive.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive SoC-based boards
> +
> +maintainers:
> +  - Michael Zhu <michael.zhu@starfivetech.com>
> +  - Drew Fustini <drew@beagleboard.org>
> +
> +description:
> +  SiFive SoC-based boards
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: beagle,beaglev-starlight-jh7100
> +          - const: starfive,jh7100
> +
> +      - items:
> +          - const: starfive,jh7100

This alone shouldn't be valid.

> +
> +additionalProperties: true
> +
> +...
> -- 
> 2.27.0
> 
> 
