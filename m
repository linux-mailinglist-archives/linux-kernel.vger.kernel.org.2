Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981613B37F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 22:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbhFXUi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 16:38:29 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:34530 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFXUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 16:38:28 -0400
Received: by mail-il1-f178.google.com with SMTP id s19so7676303ilj.1;
        Thu, 24 Jun 2021 13:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IeekNEyohZN6MzkTx+KjqVqtCEsePcgyWKrRxyLzyeU=;
        b=WY/+YOQc1wG50T6XHnSqSwmleYWO7OgdbOI+qtPBTZjLSjiieJ/pjN4QLaBIH5xcdB
         WBjAUxQ+rOYUL37oZ7qfy3pNZV/HfrttqtIE5GVnhr6yK+zChW9LYDF+dF/MOh4NrQnE
         qLLnhBtCBtunhaBRKCNupfNb8LLyp1e+uAFHqz0lWZezMdSRqDW6V0F7kKQSsfJTKZK1
         o4ID27TX6xCHpn1Pm9A9DsXNHQcGEIZyKcOJ60jrXivXdscN5C7UmK06ROf+HysWBBdy
         /rwjE/AtPnuMY2eebOL+kNRJV8H1lGdRR1asetd7CYxJERaJShafGa+lDNoCtcAJ8cFX
         N7sg==
X-Gm-Message-State: AOAM531HePhgTLGiNh+KcEpvDRcPT7AsnEsQoSLy+HmndS1fZWniHZZr
        +Dk8+oWTX7MOrTIshj+uFw==
X-Google-Smtp-Source: ABdhPJz4oc9MraAAsoi//hl+eNtAShBWVt6pwObPCXgdsqt1R0tzuLvf3l3gYVGV9xs0YZaYlwG22g==
X-Received: by 2002:a92:cbd0:: with SMTP id s16mr4891741ilq.19.1624566968324;
        Thu, 24 Jun 2021 13:36:08 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z19sm1870730ioc.29.2021.06.24.13.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 13:36:07 -0700 (PDT)
Received: (nullmailer pid 1945446 invoked by uid 1000);
        Thu, 24 Jun 2021 20:36:04 -0000
Date:   Thu, 24 Jun 2021 14:36:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 33/33] arm64: zynqmp: Add support for Xilinx Kria SOM
 board
Message-ID: <20210624203604.GA1938341@robh.at.kernel.org>
References: <cover.1623684253.git.michal.simek@xilinx.com>
 <97588ccfcdc21c53f732d3948ae85abed6539256.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <97588ccfcdc21c53f732d3948ae85abed6539256.1623684253.git.michal.simek@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 05:25:41PM +0200, Michal Simek wrote:
> There are couple of revisions of SOMs (k26) and associated carrier cards
> (kv260).
> SOM itself has two major versions:
> sm-k26 - SOM with EMMC
> smk-k26 - SOM without EMMC used on starter kit with preprogrammed firmware
> in QSPI.
> 
> SOMs are describing only devices available on the SOM or connections which
> are described in specification (for example UART, fwuen).
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> - Use sugar syntax - reported by Geert
> - Update copyright years
> - Fix SD3.0 comment alignment
> - Remove one newline from Makefile
> 
> https://www.xilinx.com/products/som/kria.html
> ---
>  .../devicetree/bindings/arm/xilinx.yaml       |  31 ++
>  arch/arm64/boot/dts/xilinx/Makefile           |  10 +
>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts  | 335 ++++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts  | 318 +++++++++++++++++
>  .../boot/dts/xilinx/zynqmp-sm-k26-revA.dts    | 289 +++++++++++++++
>  .../boot/dts/xilinx/zynqmp-smk-k26-revA.dts   |  21 ++

It does not appear to me that the schema matches the dts files. You did 
check that, right?

>  6 files changed, 1004 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revB.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dts
>  create mode 100644 arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.yaml b/Documentation/devicetree/bindings/arm/xilinx.yaml
> index a0b1ae6e3e71..1a4a03dfaf7f 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.yaml
> +++ b/Documentation/devicetree/bindings/arm/xilinx.yaml
> @@ -116,6 +116,37 @@ properties:
>            - const: xlnx,zynqmp-zcu111
>            - const: xlnx,zynqmp
>  
> +      - description: Xilinx Kria SOMs
> +        items:
> +          - const: xlnx,zynqmp-sm-k26-rev1
> +          - const: xlnx,zynqmp-sm-k26-revB
> +          - const: xlnx,zynqmp-sm-k26-revA

So rev1 is compatible with revB is compatible with revA, but revA and 
revB don't exist on their own?

> +          - const: xlnx,zynqmp-sm-k26
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx Kria SOMs (starter)
> +        items:
> +          - const: xlnx,zynqmp-smk-k26-rev1
> +          - const: xlnx,zynqmp-smk-k26-revB
> +          - const: xlnx,zynqmp-smk-k26-revA
> +          - const: xlnx,zynqmp-smk-k26
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx Kria Carrier Cards (revA/Y/Z)
> +        items:
> +          - const: xlnx,zynqmp-sk-kv260-revZ
> +          - const: xlnx,zynqmp-sk-kv260-revY
> +          - const: xlnx,zynqmp-sk-kv260-revA
> +          - const: xlnx,zynqmp-sk-k260
> +          - const: xlnx,zynqmp
> +
> +      - description: Xilinx Kria Carrier Cards (revB/1)
> +        items:
> +          - const: xlnx,zynqmp-sk-kv260-rev1
> +          - const: xlnx,zynqmp-sk-kv260-revB
> +          - const: xlnx,zynqmp-sk-k260
> +          - const: xlnx,zynqmp
> +
>  additionalProperties: true
>  
>  ...
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 083ed52337fd..8e43bef2c57e 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -17,3 +17,13 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu104-revC.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu106-revA.dtb
>  dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-zcu111-revA.dtb
> +
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
> +
> +som-AA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
> +som-AB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
> +starter-AA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
> +starter-AB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
> +
> +dtb-$(CONFIG_ARCH_ZYNQMP) += som-AA.dtb som-AB.dtb starter-AA.dtb starter-AB.dtb
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
> new file mode 100644
> index 000000000000..59d5751e0634
> --- /dev/null
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-sck-kv-g-revA.dts
> @@ -0,0 +1,335 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dts file for KV260 revA Carrier Card
> + *
> + * (C) Copyright 2020 - 2021, Xilinx, Inc.
> + *
> + * SD level shifter:
> + * "A" – A01 board un-modified (NXP)
> + * "Y" – A01 board modified with legacy interposer (Nexperia)
> + * "Z" – A01 board modified with Diode interposer
> + *
> + * Michal Simek <michal.simek@xilinx.com>
> + */
> +
> + #include <dt-bindings/gpio/gpio.h>
> + #include <dt-bindings/net/ti-dp83867.h>
> + #include <dt-bindings/phy/phy.h>
> + #include <dt-bindings/pinctrl/pinctrl-zynqmp.h>
> +
> +/dts-v1/;
> +/plugin/;
> +
> +&{/} {
> +	compatible = "xlnx,zynqmp-sk-kv260-revA",
> +		     "xlnx,zynqmp-sk-kv260-revY",
> +		     "xlnx,zynqmp-sk-kv260-revZ",

The order above is Z, Y, A.

> +		     "xlnx,zynqmp-sk-kv260", "xlnx,zynqmp";
> +};
