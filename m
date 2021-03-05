Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F07132DF2E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 02:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhCEBlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 20:41:32 -0500
Received: from regular1.263xmail.com ([211.150.70.195]:43698 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCEBlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 20:41:31 -0500
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 3D5101CB9;
        Fri,  5 Mar 2021 09:41:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P32477T140679609587456S1614908485904547_;
        Fri, 05 Mar 2021 09:41:29 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <eff9c719a74490addbfecb5f059ec3c5>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: finley.xiao@rock-chips.com
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v3 1/4] dt-binding: clock: Document rockchip,rk3568-cru
 bindings
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        robh+dt@kernel.org, sboyd@kernel.org, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        cl@rock-chips.com, huangtao@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com
References: <20210301064749.10392-1-zhangqing@rock-chips.com>
 <20210301064749.10392-2-zhangqing@rock-chips.com>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <db38c068-651e-edd6-fb3f-4768fab91ad7@rock-chips.com>
Date:   Fri, 5 Mar 2021 09:41:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210301064749.10392-2-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2021/3/1 下午2:47, Elaine Zhang wrote:
> Document the device tree bindings of the rockchip Rk3568 SoC
> clock driver in Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml.
>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

Patch looks good to me.

Reviewed-by: Kever Yang <kever.yang@rock-chips.com 
<mailto:kever.yang@rock-chips.com>>

Thanks,
- Kever
> ---
>   .../bindings/clock/rockchip,rk3568-cru.yaml   | 60 +++++++++++++++++++
>   1 file changed, 60 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
>
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> new file mode 100644
> index 000000000000..b2c26097827f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3568-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROCKCHIP rk3568 Family Clock Control Module Binding
> +
> +maintainers:
> +  - Elaine Zhang <zhangqing@rock-chips.com>
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +description: |
> +  The RK3568 clock controller generates the clock and also implements a
> +  reset controller for SoC peripherals.
> +  (examples: provide SCLK_UART1\PCLK_UART1 and SRST_P_UART1\SRST_S_UART1 for UART module)
> +  Each clock is assigned an identifier and client nodes can use this identifier
> +  to specify the clock which they consume. All available clocks are defined as
> +  preprocessor macros in the dt-bindings/clock/rk3568-cru.h headers and can be
> +  used in device tree sources.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-cru
> +      - rockchip,rk3568-pmucru
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  "#reset-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"
> +  - "#reset-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  # Clock Control Module node:
> +  - |
> +    pmucru: clock-controller@fdd00000 {
> +      compatible = "rockchip,rk3568-pmucru";
> +      reg = <0xfdd00000 0x1000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +  - |
> +    cru: clock-controller@fdd20000 {
> +      compatible = "rockchip,rk3568-cru";
> +      reg = <0xfdd20000 0x1000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };


