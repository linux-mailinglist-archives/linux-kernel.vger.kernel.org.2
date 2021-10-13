Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABFE42CD41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhJMWGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:06:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229754AbhJMWGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:06:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12E24610CF;
        Wed, 13 Oct 2021 22:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634162674;
        bh=Pz99xJwgUWewDS8SG1vh0092WbkfB7AaUfBLNp1rW8w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=X9z6/fQttyLF/h9MxZe8D69kQI/BbTueoj86dTFnYOyjq7ppzSyp9CtZaCfZbwQAx
         0Ad8PPb6vN/JujhvZviDsuUe+O1QExqyohHomM34w7HNoXuwtddCO23Z1BhPGo3AWx
         Jb+qMQLT1kAuPwTTMz/YHmnhmGUODFsh66LoXzLCCskWFJmFfxve5DlB8EnQu3Z8iV
         xqzgpv9p1hZ8Pf+RRLndcOP/wQEF38Udsden9pshcE8RTKWI27N/EC8Iuxj3X003Fq
         GvMNko80oPQuOXNvmPhIP0XeB9ww4F36FDvoW/nitoqbIJzRf6xTPo7hOzJrVKHysP
         b/LRlYY7v15Dg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210923064137.60722-3-zhang.lyra@gmail.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512 global registers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 13 Oct 2021 15:04:32 -0700
Message-ID: <163416267274.936110.2784588823311275089@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2021-09-22 23:41:35)
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yam=
l b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> new file mode 100644
> index 000000000000..3522f3d2d8de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc System Global Register Device Tree Bindings
> +
> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description:
> +  Unisoc system global registers provide register map
> +  for clocks and some multimedia modules of the SoC.
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:
> +    items:
> +      - const: sprd,ums512-glbregs
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  ranges:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    # Child node
> +    type: object
> +    $ref: "../clock/sprd,ums512-clk.yaml"
> +    description:
> +      Clock controller for the SoC clocks.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ap_apb_regs: syscon@71000000 {
> +      compatible =3D "sprd,ums512-glbregs", "syscon", "simple-mfd";
> +      reg =3D <0x71000000 0x3000>;
> +      #address-cells =3D <1>;
> +      #size-cells =3D <1>;
> +      ranges =3D <0 0x71000000 0x3000>;
> +
> +      clock-controller@0 {
> +        compatible =3D "sprd,ums512-apahb-gate";

Why is this a subnode of a syscon and simple-mfd? Why not put the
clock-controller@71000000 directly onto the bus? Does making it a child
node help somehow?

> +        reg =3D <0x0 0x2000>;
> +        #clock-cells =3D <1>;
> +      };
> +    };
