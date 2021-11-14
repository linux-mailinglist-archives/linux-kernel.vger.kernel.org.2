Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA2A44F79F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Nov 2021 12:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhKNLfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 06:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhKNLfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 06:35:12 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD0FC061746;
        Sun, 14 Nov 2021 03:32:16 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x15so58306743edv.1;
        Sun, 14 Nov 2021 03:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jMpO00fQSAGgs3AAQFzgC0Z6+dFUEVFO1UcxCxkgGWk=;
        b=KLVeWW0pOuFMMqq2BvEM7o+qdnZPFGrOmf3kp4EopAfDpMpqqeyuAFZRg39WFQCjAd
         7W37U5Zd71BXRQhPrv0OpfPybRwnlBatPkfEZDtsnlP66jMNUUAifM1rdqSsw/f4EPJY
         gIUi7Pw0yfJkbO0p/hS8XymbaJbY10JiZytxnBMjummJVD13HN4tyM3tjOn/yCFHyxFA
         slx8KlF55aNlNIt1Sv0KUzR9wztGRxWMZmtEsf3EeLlWNtCN4ytSSFFJL1ugiPTpfMK2
         xDk05p4fyJiW5AXrgsfjvOu7I5QGtMxjA3V1fNrZNA2NjuahLH72IuNe/oBUnlinBcnX
         F3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jMpO00fQSAGgs3AAQFzgC0Z6+dFUEVFO1UcxCxkgGWk=;
        b=gvFDnbqPHAMbqdMkfwZnA/qCag5+dpdwKs+ajY8kj0x+iPKgkOC2eGYaxqYoi1bzXp
         1gXZYhHPl3xApIn9P0F7fRVfYggQYt6y637ZAyhHl/Pe8ZtJmYhxik5ZM04gMpMEMenI
         KHf3TaTcdJieWuNeK4N4d8Xtrvrg6Zm5NgohogigzMV3r9ftn6aLqzcOvNxSx+pil4Wh
         ONX4+oiCyn1bckR5zxV1mZFtPkucH5gVcSoiVxTNw5SzfIW0SURfo52lDrMzN0J6nk0e
         R/c1tD4HQB6lE9+OpTK3iyHWa8TWqaE5tfr8B7VAdDdxb/iWHJ31JiLwMLXKqDkivawB
         iSAg==
X-Gm-Message-State: AOAM533D6zmPgi6v+siw5lSJvYUKzdPybwor6JdGkmSraA+PXpYUMlYc
        j8j+rV1t0pUif3CZTaflgzI=
X-Google-Smtp-Source: ABdhPJylw6UR7VQYQs/K8Ri2n++AJNzRkJTcfwxgjU/ayv5BtP+6nEV6P7d2KG5IZ11BnLJq0xyU0A==
X-Received: by 2002:a50:ff10:: with SMTP id a16mr26571013edu.275.1636889534910;
        Sun, 14 Nov 2021 03:32:14 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id bo20sm5797581edb.31.2021.11.14.03.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Nov 2021 03:32:14 -0800 (PST)
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: rockchip: Add Naneng combo PHY
 bindings
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, heiko@sntech.de,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, vkoul@kernel.org,
        michael.riesch@wolfvision.net, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, kishon@ti.com,
        p.zabel@pengutronix.de, cl@rock-chips.com
References: <20211025080632.32063-1-yifeng.zhao@rock-chips.com>
 <20211025080632.32063-2-yifeng.zhao@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <bca2238b-9f51-2afb-b58f-5844709c4355@gmail.com>
Date:   Sun, 14 Nov 2021 12:32:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025080632.32063-2-yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yifeng,

Driver and documents don't match.
Add a separate patch before this one to add to syscon.yaml:

"rockchip,rk3568-pipe-phy-grf", "syscon"
"rockchip,rk3568-pipe-grf", "syscon"

On 10/25/21 10:06 AM, Yifeng Zhao wrote:
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Fix dtschema/dtc warnings/errors
> 
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> new file mode 100644
> index 000000000000..55ad33d902ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/phy-rockchip-naneng-combphy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip SoC Naneng Combo Phy Device Tree Bindings
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3568-naneng-combphy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:

> +    minItems: 1

Remove.
DT node has 3 clocks and not 1.

> +    items:
> +      - description: reference clock
> +      - description: apb clock
> +      - description: pipe clock
> +
> +  clock-names:

> +    minItems: 1

dito

> +    items:
> +      - const: ref
> +      - const: apb
> +      - const: pipe
> +
> +  '#phy-cells':
> +    const: 1
> +
> +  resets:

> +    minItems: 1

Remove.
DT node has 2 resets and not 1.

> +    items:
> +      - description: exclusive apb reset line
> +      - description: exclusive PHY reset line
> +
> +  reset-names:

> +    minItems: 1

dito

There are 2 resets. When the reset order does matter then use
devm_reset_control_array_get() to get the resets.
The use of reset-names is then not needed.

> +    items:
> +      - const: combphy-apb
> +      - const: combphy
> +

Missing properties.

rockchip,dis-u3otg0-port

rockchip,dis-u3otg1-port

rockchip,enable-ssc

rockchip,ext-refclk

rockchip,sgmii-mac-sel


> +  rockchip,pipe-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:

> +      Some additional phy settings are access through GRF regs.

are accessed

> +
> +  rockchip,pipe-phy-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:

> +      Some additional pipe settings are access through GRF regs.


are accessed

> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - '#phy-cells'
> +  - resets

> +  - reset-names

dito

> +  - rockchip,pipe-grf
> +  - rockchip,pipe-phy-grf
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +
> +    #include <dt-bindings/clock/rk3568-cru.h>
> +
> +    pipegrf: syscon@fdc50000 {


compatible = "rockchip,rk3568-pipe-grf", "syscon";

> +      reg = <0xfdc50000 0x1000>;
> +    };
> +
> +    pipe_phy_grf0: syscon@fdc70000 {

compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";

> +      reg = <0xfdc70000 0x1000>;
> +    };
> +
> +    combphy0_us: phy@fe820000 {
> +      compatible = "rockchip,rk3568-naneng-combphy";
> +      reg = <0xfe820000 0x100>;
> +      #phy-cells = <1>;
> +      clocks = <&pmucru CLK_PCIEPHY0_REF>, <&cru PCLK_PIPEPHY0>,
> +        <&cru PCLK_PIPE>;
> +      clock-names = "ref", "apb", "pipe";
> +      assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
> +      assigned-clock-rates = <100000000>;
> +      resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;

> +      reset-names = "combphy-apb", "combphy";

dito

> +      rockchip,pipe-grf = <&pipegrf>;
> +      rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
> +    };
> 
