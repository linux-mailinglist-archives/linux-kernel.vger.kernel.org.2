Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA42D36283A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238278AbhDPTGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:06:15 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:41648 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235868AbhDPTGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:06:13 -0400
Received: by mail-oi1-f176.google.com with SMTP id r186so1093890oif.8;
        Fri, 16 Apr 2021 12:05:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NUrzL79B0A/EanBTqoVHqtTWMOAGqMbXYSjniUhAP8w=;
        b=Edst7TXNKPip9Js0VN54nXOhIWGdw+e6f17b4S8cJp7RF5n30Kj52dpMPCCoHud6hn
         PO8Z5O2phA0tenOXPyAbj4tzc4eI+sHVNbgdBY70qx01MUI5C++haL8yBjMjFo1sf0rl
         soKM1EUFtSIzWER9iSmCAmvN/g1LY1GFxk0pnKSNGjTil64W9W7aG353zdGS0/NVV6wS
         yvXPYz30vfw7uUHxRx2+9WVWQP6k8GPzSHU4Khg6rBpiDZhFjaXWlSIekNbd6jvj+QAd
         8/QO6yEGWcSFAzmT+F0xiuA0DnyY32GkVSlzBXhJ4y+HIevmMQ2RVW93TPT6idexnmhv
         5VhQ==
X-Gm-Message-State: AOAM531twRn322/mNMKpjMRiJJfDbvOt37dMW7FIUjp6Ud1EA3wqij9I
        A36Fx50ivCGp1hL8AkDeJw==
X-Google-Smtp-Source: ABdhPJyYy6dvtN9IHkna8RxcKD+wGfD+qlTT63XKPKzhLIkzEiuzzVTHCYpiW2SAP/vjjP8w7kiakg==
X-Received: by 2002:aca:c78b:: with SMTP id x133mr7712818oif.24.1618599946882;
        Fri, 16 Apr 2021 12:05:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y67sm1555380otb.1.2021.04.16.12.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:05:46 -0700 (PDT)
Received: (nullmailer pid 3767749 invoked by uid 1000);
        Fri, 16 Apr 2021 19:05:44 -0000
Date:   Fri, 16 Apr 2021 14:05:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 13/15] dt-bindings: power: rockchip: Convert to
 json-schema
Message-ID: <20210416190544.GA3752460@robh.at.kernel.org>
References: <20210416080342.18614-1-jbx6244@gmail.com>
 <20210416080342.18614-14-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416080342.18614-14-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 10:03:40AM +0200, Johan Jonker wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Convert the soc/rockchip/power_domain.txt binding document to
> json-schema and move to the power bindings directory.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Note for rob+dt:
> A tag was not added on purpose, because:
>   Add "rockchip," prefix to the qos compatible name
>   in example.
>   Changed maintainers.
>   Size reg description is reduced.
>   Little style changes '' to ""
> Please have a look at it again.
> 
> For some SoC nodes this patch serie generates notifications
> for undocumented "assigned-clocks" and "assigned-clock-parents"
> properties till there is consensus of what to do with it.
> ---
> Changed V8:
>   Add pd-node ref schema
> Changed V7:
>   Fix commit message and author format
>   Changed SPDX-License-Identifier back to GPL-2.0
>   Remove "clocks", "assigned-clocks" and "assigned-clock-parents"
>   Fix indent example
> Changed V6:
>   Changed author
> Changed V5:
>   Change SPDX-License-Identifier to  GPL-2.0-only OR BSD-2-Clause
>   Remove a maintainer
>   Changed patternProperties to power-domain
>   Add "clocks", "assigned-clocks" and "assigned-clock-parents"
> Changed V4:
>   Remove new compatible string
>   Style changes '' to ""
> Changed V3:
>   Use Enric's conversion with rk3399 example
> Changed V2:
>   Convert power_domain.txt to YAML with rk3568 example
> ---
>  .../bindings/power/rockchip,power-controller.yaml  | 257 +++++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt         | 136 -----------
>  2 files changed, 257 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> new file mode 100644
> index 000000000..2b9950fd6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
> @@ -0,0 +1,257 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/rockchip,power-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Power Domains
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  Rockchip processors include support for multiple power domains
> +  which can be powered up/down by software based on different
> +  application scenarios to save power.
> +
> +  Power domains contained within power-controller node are
> +  generic power domain providers documented in
> +  Documentation/devicetree/bindings/power/power-domain.yaml.
> +
> +  IP cores belonging to a power domain should contain a
> +  "power-domains" property that is a phandle for the
> +  power domain node representing the domain.
> +
> +properties:
> +  $nodename:
> +    const: power-controller
> +
> +  compatible:
> +    enum:
> +      - rockchip,px30-power-controller
> +      - rockchip,rk3036-power-controller
> +      - rockchip,rk3066-power-controller
> +      - rockchip,rk3128-power-controller
> +      - rockchip,rk3188-power-controller
> +      - rockchip,rk3228-power-controller
> +      - rockchip,rk3288-power-controller
> +      - rockchip,rk3328-power-controller
> +      - rockchip,rk3366-power-controller
> +      - rockchip,rk3368-power-controller
> +      - rockchip,rk3399-power-controller
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^power-domain@[0-9a-f]+$":
> +    properties:
> +
> +      "#power-domain-cells":
> +        enum: [0, 1]
> +        description:
> +          Must be 0 for nodes representing a single PM domain and 1 for nodes
> +          providing multiple PM domains.

Can't this and 'required' go into pd-node?

> +
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    $ref: "#/definitions/pd-node"

Move this and 'unevaluatedProperties' above 'properties'. It's a bit 
easier to read than trying to follow the indentation.

> +
> +    patternProperties:
> +      "^power-domain@[0-9a-f]+$":
> +        properties:
> +
> +          "#power-domain-cells":
> +            enum: [0, 1]
> +
> +          "#address-cells":
> +            const: 1
> +
> +          "#size-cells":
> +            const: 0
> +
> +        $ref: "#/definitions/pd-node"
> +
> +        patternProperties:
> +          "^power-domain@[0-9a-f]+$":
> +            properties:
> +
> +              "#power-domain-cells":
> +                const: 0

You can keep this one since it adds additional constraints.

> +
> +            $ref: "#/definitions/pd-node"
> +
> +            required:
> +              - "#power-domain-cells"
> +
> +            unevaluatedProperties: false
> +
> +        required:
> +          - "#power-domain-cells"
> +
> +        unevaluatedProperties: false
> +
> +    required:
> +      - "#power-domain-cells"
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - "#power-domain-cells"
> +
> +additionalProperties: false
> +
> +definitions:

'$defs' rather than 'definitions'. The former is in the json-schema 
spec, the latter was only convention.

> +  pd-node:
> +    type: object
> +    description: |
> +      Represents the power domains within the power controller node.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +        description: |
> +          Power domain index. Valid values are defined in
> +          "include/dt-bindings/power/px30-power.h"
> +          "include/dt-bindings/power/rk3036-power.h"
> +          "include/dt-bindings/power/rk3066-power.h"
> +          "include/dt-bindings/power/rk3128-power.h"
> +          "include/dt-bindings/power/rk3188-power.h"
> +          "include/dt-bindings/power/rk3228-power.h"
> +          "include/dt-bindings/power/rk3288-power.h"
> +          "include/dt-bindings/power/rk3328-power.h"
> +          "include/dt-bindings/power/rk3366-power.h"
> +          "include/dt-bindings/power/rk3368-power.h"
> +          "include/dt-bindings/power/rk3399-power.h"
> +
> +      clocks:
> +        minItems: 1
> +        maxItems: 30
> +        description: |
> +          A number of phandles to clocks that need to be enabled
> +          while power domain switches state.
> +
> +      pm_qos:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: |
> +          A number of phandles to qos blocks which need to be saved and restored
> +          while power domain switches state.
> +
> +    required:
> +      - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3399-cru.h>
> +    #include <dt-bindings/power/rk3399-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        qos_hdcp: qos@ffa90000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffa90000 0x0 0x20>;
> +        };
> +
> +        qos_iep: qos@ffa98000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffa98000 0x0 0x20>;
> +        };
> +
> +        qos_rga_r: qos@ffab0000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffab0000 0x0 0x20>;
> +        };
> +
> +        qos_rga_w: qos@ffab0080 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffab0080 0x0 0x20>;
> +        };
> +
> +        qos_video_m0: qos@ffab8000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffab8000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_r: qos@ffac0000 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffac0000 0x0 0x20>;
> +        };
> +
> +        qos_video_m1_w: qos@ffac0080 {
> +            compatible = "rockchip,rk3399-qos", "syscon";
> +            reg = <0x0 0xffac0080 0x0 0x20>;
> +        };
> +
> +        power-management@ff310000 {
> +            compatible = "rockchip,rk3399-pmu", "syscon", "simple-mfd";
> +            reg = <0x0 0xff310000 0x0 0x1000>;
> +
> +            power-controller {
> +                compatible = "rockchip,rk3399-power-controller";
> +                #power-domain-cells = <1>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                /* These power domains are grouped by VD_CENTER */
> +                power-domain@RK3399_PD_IEP {
> +                    reg = <RK3399_PD_IEP>;
> +                    clocks = <&cru ACLK_IEP>,
> +                             <&cru HCLK_IEP>;
> +                    pm_qos = <&qos_iep>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_RGA {
> +                    reg = <RK3399_PD_RGA>;
> +                    clocks = <&cru ACLK_RGA>,
> +                             <&cru HCLK_RGA>;
> +                    pm_qos = <&qos_rga_r>,
> +                             <&qos_rga_w>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_VCODEC {
> +                    reg = <RK3399_PD_VCODEC>;
> +                    clocks = <&cru ACLK_VCODEC>,
> +                             <&cru HCLK_VCODEC>;
> +                    pm_qos = <&qos_video_m0>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_VDU {
> +                    reg = <RK3399_PD_VDU>;
> +                    clocks = <&cru ACLK_VDU>,
> +                             <&cru HCLK_VDU>;
> +                    pm_qos = <&qos_video_m1_r>,
> +                             <&qos_video_m1_w>;
> +                    #power-domain-cells = <0>;
> +                };
> +                power-domain@RK3399_PD_VIO {
> +                    reg = <RK3399_PD_VIO>;
> +                    #power-domain-cells = <1>;
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +
> +                    power-domain@RK3399_PD_HDCP {
> +                        reg = <RK3399_PD_HDCP>;
> +                        clocks = <&cru ACLK_HDCP>,
> +                                 <&cru HCLK_HDCP>,
> +                                 <&cru PCLK_HDCP>;
> +                        pm_qos = <&qos_hdcp>;
> +                        #power-domain-cells = <0>;
> +                    };
> +                };
> +            };
> +        };
> +    };
