Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C489405EA8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 23:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345906AbhIIVRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 17:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235679AbhIIVRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 17:17:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C6827610C8;
        Thu,  9 Sep 2021 21:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631222186;
        bh=1zKplqZ0G0KHOO4HMxQj4yyWZEL9m7uzSjCtGE2W4GI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=syES9dK7Kyxtwj3sj6zx5BLb04NzBj1028mwPMRuBxKwhr4bFAxI+4WOHAvzkhg3Z
         cH4EjoKf1cEi4OZp7rgaSx6xlhHkHQdYl6rA31nEUJ9w75exHejYZ/zCGFHaXXc3fq
         3AHPu5JSEVs9qNHuOv0ZW1lpiEAnG1BOpBfKjmMynYTolc5LZAxndiETySauliQE8j
         YLXzYBNSsHc7WZyMo24guEBHgXxMVCjgkl6oG75Sq+XxPOajGD/MgL50SpfyLUbwDi
         Og8kYXOMSaldAbrY6rSF1VReHw8sH3G3WZtiGgNi6R03QgsyqMcdCfibP7aH90JoNv
         bymUDXJhZdFgA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210909073947.17438-4-kavyasree.kotagiri@microchip.com>
References: <20210909073947.17438-1-kavyasree.kotagiri@microchip.com> <20210909073947.17438-4-kavyasree.kotagiri@microchip.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: clock: lan966x: Add LAN966X Clock Controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, UNGLinuxDriver@microchip.com,
        Eugen.Hristev@microchip.com, Kavyasree.Kotagiri@microchip.com,
        Manohar.Puri@microchip.com
To:     Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        mturquette@baylibre.com, robh+dt@kernel.org
Date:   Thu, 09 Sep 2021 14:16:25 -0700
Message-ID: <163122218554.1821005.1994463033743814126@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kavyasree Kotagiri (2021-09-09 00:39:47)
> This adds the DT bindings documentation for lan966x SoC
> generic clock controller.
>=20
> Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> ---

This should come before the driver patch.

> v2 -> v3:
> - Fixed dt_binding_check errors.
>=20
> v1 -> v2:
> - Updated example provided for clk controller DT node.
>=20
>  .../bindings/clock/microchip,lan966x-gck.yaml | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan=
966x-gck.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/clock/microchip,lan966x-gc=
k.yaml b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> new file mode 100644
> index 000000000000..d353d42c3dc8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
> @@ -0,0 +1,64 @@
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
> +    maxItems: 3

The order matters to the binding too so please indicate which clock goes
into which index, or use clock-names, or both.

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
> +    cpu_clk: cpu_clk {

node names should have dash in them, whereas labels should have
underscores.

> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <600000000>;
> +    };
> +
> +    ddr_clk: ddr_clk {
> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <300000000>;
> +    };
> +
> +    sys_clk: sys_clk {
> +        compatible =3D "fixed-clock";
> +        #clock-cells =3D <0>;
> +        clock-frequency =3D <162500000>;
> +    };

The fixed clks aren't necessary to put in the binding as they're just
used as phandles below. Please remove them from the example and leave
the node below intact with the phandles referencing "nothing".

> +
> +    clks: clock-controller@e00c00a8 {
> +        compatible =3D "microchip,lan966x-gck";
> +        #clock-cells =3D <1>;
> +        clocks =3D <&cpu_clk>, <&ddr_clk>, <&sys_clk>;
> +        reg =3D <0xe00c00a8 0x38>;
> +    };
> +...
