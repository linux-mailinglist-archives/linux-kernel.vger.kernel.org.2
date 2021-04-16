Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF03A362C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 01:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbhDPXzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 19:55:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229719AbhDPXzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 19:55:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E912A61152;
        Fri, 16 Apr 2021 23:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618617313;
        bh=E2d1BqEFKaCE3MiFwEpfVs4ZtEN4+OGip5ZcAjHFTEk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eWHyUqii3l4ZDB8TDLG9zHPcmRehniBQy7CBG7NTofQxvnRdsHbR3sEmdumVtL8FU
         vhFTJuihDrX6nALpc44cUGoGysPv+VliyJ1vtttZk1nMrWvTtHgs8iBLF2hQ6JuuWh
         E25JBHtJceYTmledkjRKQ4p1VXYV26LS/NKHNnoPWtmoW+/7PR0dkJb4Lt2gPVuZB6
         ERMDKkuE8KPOIzY4/5RdkNmKOQ8RCOYgrYbm6kEUo1lwykG8NmBaYw6FWR9YsQJwbQ
         +AHOwaH/4TfN1uNVpGLIbeGWzUgq7mK32VunQtMxZ5Zcmht2sdnVNszGHY8FnLbb7b
         fGHsmf67w3+bA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210416063721.20538-3-nm@ti.com>
References: <20210416063721.20538-1-nm@ti.com> <20210416063721.20538-3-nm@ti.com>
Subject: Re: [PATCH 2/4] dt-bindings: clock: Convert ti,sci-clk to json schema
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>
Date:   Fri, 16 Apr 2021 16:55:11 -0700
Message-ID: <161861731160.46595.786611690053722257@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nishanth Menon (2021-04-15 23:37:19)
> diff --git a/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml b/Do=
cumentation/devicetree/bindings/clock/ti,sci-clk.yaml
> new file mode 100644
> index 000000000000..72633651f0c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti,sci-clk.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/ti,sci-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI-SCI clock controller node bindings
> +
> +maintainers:
> +  - Nishanth Menon <nm@ti.com>
> +
> +allOf:
> +  - $ref: /schemas/clock/clock.yaml#

Is this needed?

> +
> +description: |
> +  Some TI SoCs contain a system controller (like the Power Management Mi=
cro
> +  Controller (PMMC) on Keystone 66AK2G SoC) that are responsible for con=
trolling
> +  the state of the various hardware modules present on the SoC. Communic=
ation
> +  between the host processor running an OS and the system controller hap=
pens
> +  through a protocol called TI System Control Interface (TI-SCI protocol=
).
> +
> +  This clock controller node uses the TI SCI protocol to perform various=
 clock
> +  management of various hardware modules (devices) present on the SoC. T=
his
> +  node must be a child node of the associated TI-SCI system controller n=
ode.
> +
> +properties:
> +  $nodename:
> +    pattern: "^clock-controller$"

Is this nodename pattern check required?

> +
> +  compatible:
> +    const: ti,k2g-sci-clk

I thought most things keyed off the compatible string.

> +
> +  "#clock-cells":
> +    const: 2
> +    description:
> +      The two cells represent values that the TI-SCI controller defines.
> +
> +      The first cell should contain the device ID.
> +
> +      The second cell should contain the clock ID.
> +
> +      Please see  http://processors.wiki.ti.com/index.php/TISCI for
> +      protocol documentation for the values to be used for different dev=
ices.
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    k3_clks: clock-controller {
> +        compatible =3D "ti,k2g-sci-clk";
> +        #clock-cells =3D <2>;
> +    };
