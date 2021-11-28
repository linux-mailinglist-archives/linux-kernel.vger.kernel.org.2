Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71531460B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 00:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359641AbhK1Xgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 18:36:49 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33369 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359589AbhK1Xer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 18:34:47 -0500
Received: by mail-oi1-f182.google.com with SMTP id q25so31198156oiw.0;
        Sun, 28 Nov 2021 15:31:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QET+jdkbVPh/SQ0E0SV6gfyzyI+VzCHBKFph86iBVuI=;
        b=KZ+KiMeJX4HrxHAKxoV+ck2bY9Yvl7foAujrou3ESmR+fUbHqRRyNX4t6OKFvdHbf1
         VsQnP/rzsgRFHfzk50x5+cJpABURRx2DPf46IGgMQbnFZrhXr0ESC7sPNESwQOWv1XYK
         ExrPC4vsI45E9Z82x7NodaAbWQtdV6mByvzssCyzoBulLgouUNMlm7nYSdFNHA8DqKp/
         WoqXHQ85BbO+hquScYH6VSQOvzLGsiNhoN+xfY15TJHaWoAfDWlpiSkyiAQE1lsF90Lq
         341OCHuiKiLy6x3+BcYd/zidvhb9JwtIScKlFL3RqAz7AGIuDIW6u6w7m824oBnr2tik
         5MTg==
X-Gm-Message-State: AOAM530VU33pjPb6caGCrfmMFhn1N0J2bk7wWmhHMaXhLaRTLlFEPs80
        kGeXq52L/F2Y/9rrjghVFw==
X-Google-Smtp-Source: ABdhPJzslttEOkuwy/oleEd5Ys0yMUiNW7c+Qbcm4LL8SNl/R6L/JzsSUm7brAh5VfBYY0PToz5q1Q==
X-Received: by 2002:a05:6808:f15:: with SMTP id m21mr37776303oiw.68.1638142290840;
        Sun, 28 Nov 2021 15:31:30 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fe7:4487:4f99:dbc0:75d1:3e27])
        by smtp.gmail.com with ESMTPSA id o2sm2733175oik.11.2021.11.28.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 15:31:30 -0800 (PST)
Received: (nullmailer pid 2819138 invoked by uid 1000);
        Sun, 28 Nov 2021 23:31:26 -0000
Date:   Sun, 28 Nov 2021 17:31:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, john@phrozen.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/12] dt-bindings: Add en7523-scu device tree binding
 documentation
Message-ID: <YaQRTokEwL4H0ehW@robh.at.kernel.org>
References: <20211125110738.41028-1-nbd@nbd.name>
 <20211125110738.41028-7-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211125110738.41028-7-nbd@nbd.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25, 2021 at 12:07:32PM +0100, Felix Fietkau wrote:
> From: John Crispin <john@phrozen.org>
> 
> Adds device tree binding documentation for clocks in the EN7523 SOC.
> 
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> Signed-off-by: John Crispin <john@phrozen.org>
> ---
>  .../bindings/clock/airoha,en7523-scu.yaml     | 58 +++++++++++++++++++
>  include/dt-bindings/clock/en7523-clk.h        | 17 ++++++
>  2 files changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
>  create mode 100644 include/dt-bindings/clock/en7523-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> new file mode 100644
> index 000000000000..79660f8126fa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/airoha,en7523-scu.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/airoha,en7523-scu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EN7523 Clock Device Tree Bindings
> +
> +maintainers:
> +  - Felix Fietkau <nbd@nbd.name>
> +  - John Crispin <nbd@nbd.name>
> +
> +description: |
> +  This node defines the System Control Unit of the EN7523 SoC,
> +  a collection of registers configuring many different aspects of the SoC.
> +
> +  The clock driver uses it to read and configure settings of the
> +  PLL controller, which provides clocks for the CPU, the bus and
> +  other SoC internal peripherals.
> +
> +  Each clock is assigned an identifier and client nodes use this identifier
> +  to specify which clock they consume.
> +
> +  All these identifiers can be found in:
> +  [1]: <include/dt-bindings/clock/en7523-clk.h>.
> +
> +  The clocks are provided inside a system controller node.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: airoha,en7523-scu
> +
> +  reg:
> +    maxItems: 2
> +
> +  "#clock-cells":
> +    description:
> +      The first cell indicates the clock number, see [1] for available
> +      clocks.
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#clock-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/en7523-clk.h>
> +    scu: scu@1fa20000 {
> +      compatible = "airoha,en7523-scu";
> +      reg = <0x1fa20000 0x400>,
> +            <0x1fb00000 0x1000>;
> +      #clock-cells = <1>;
> +    };
> diff --git a/include/dt-bindings/clock/en7523-clk.h b/include/dt-bindings/clock/en7523-clk.h
> new file mode 100644
> index 000000000000..7c8414a7cb66
> --- /dev/null
> +++ b/include/dt-bindings/clock/en7523-clk.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

Using DT with non-GPL OS? Dual license header and dts files.

> +
> +#ifndef _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_
> +#define _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_
> +
> +#define EN7523_CLK_GSW		0
> +#define EN7523_CLK_EMI		1
> +#define EN7523_CLK_BUS		2
> +#define EN7523_CLK_SLIC		3
> +#define EN7523_CLK_SPI		4
> +#define EN7523_CLK_NPU		5
> +#define EN7523_CLK_CRYPTO	6
> +#define EN7523_CLK_PCIE		7
> +
> +#define EN7523_NUM_CLOCKS	8
> +
> +#endif /* _DT_BINDINGS_CLOCK_AIROHA_EN7523_H_ */
> -- 
> 2.30.1
> 
> 
