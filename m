Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5AC32618B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 11:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbhBZKs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 05:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhBZKs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 05:48:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393FBC061574;
        Fri, 26 Feb 2021 02:47:46 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id jt13so14080876ejb.0;
        Fri, 26 Feb 2021 02:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SptuCNRcrUMOBsIkdiojrMBwnefuMhsLcusFLvnTYHM=;
        b=UgSKhLA/akkZKJAnrE3pT9d3/SWj3FfXTsU89UOw2ByYa5QnkTfotOA5ZGuVt9+iUH
         Lrg7CvpMMJFShGGw2pKdbipBfggmG8uvRm8p/UNQfS5qU0h7F2f+L9rPosdyhthGtETn
         Awm1eaMOGFK8XQc2JQCKqAYhaomkI1YOIMyMmzOGtEDOR32qunRy0D0HDB3raPKSP8G5
         uKlyZc0ltu0yzY9ka1i45OLdpy3LrekHK4KQTMS3HOq10u4WuEHUqVZUuKlc5eD4Itti
         elUUEeZtujxzrO678Hq+v5A7EPuVAvrFQzQaqAC225bjs51lf6H1pftHTqNuYVW0nvYK
         EnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SptuCNRcrUMOBsIkdiojrMBwnefuMhsLcusFLvnTYHM=;
        b=Bgzjijm6DvWkMvG6awdjwUL5EuND5LlqCMDpyMyNuXAqP8iTikcWkH2l76EjYyOgSw
         IF8OFKi/T9JOdXmHBd/OPRNww6auhnABJwJru10OjjtAsGkWGniGKQvJdC5o9bXjqWNM
         +s01RzvoHMPpiwBP4OaFqMU+zktudnEuR9FnzsOdIn9Z193RlRiRp/UJOAsz8ApDirh3
         BoF8lNXdtprXuviX/wt6nr42kO4wV2tPQLgTtheYCSuEc9r0wJr4Igv9SYN/lgis/BZv
         VwRHj/TxZ7KK+NngYr+OzB3LTlexSQTy65pf7V/RPhGVnkl0Xk/6lkFjti0Gn7vkaAc4
         QPKQ==
X-Gm-Message-State: AOAM531espbVf2eQDHp7TMpJkNyV0fErS8wXlVLhcJofa55JmnDdNDIn
        DyPFi/+2q9Cm3Y2OBNqk+D8Y9EmYK7c=
X-Google-Smtp-Source: ABdhPJyjvz1ZN0qOnMiud13/4Wv+lXyvHJx5mrK55lKgzUoPEYrCzOmGlSZWKFac1fz7+nrC6hCCfg==
X-Received: by 2002:a17:906:63c2:: with SMTP id u2mr2604960ejk.346.1614336464970;
        Fri, 26 Feb 2021 02:47:44 -0800 (PST)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id x21sm4892801eje.118.2021.02.26.02.47.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 02:47:44 -0800 (PST)
Subject: Re: [PATCH v2 1/4] dt-binding: clock: Document rockchip, rk3568-cru
 bindings
To:     Elaine Zhang <zhangqing@rock-chips.com>, mturquette@baylibre.com,
        robh+dt@kernel.org, sboyd@kernel.org, heiko@sntech.de
Cc:     huangtao@rock-chips.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kever.yang@rock-chips.com,
        linux-rockchip@lists.infradead.org, tony.xie@rock-chips.com,
        finley.xiao@rock-chips.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, cl@rock-chips.com
References: <20210226082234.1733-1-zhangqing@rock-chips.com>
 <20210226082234.1733-2-zhangqing@rock-chips.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <04bca26f-080f-384a-11c5-6fc51f82e359@gmail.com>
Date:   Fri, 26 Feb 2021 11:47:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20210226082234.1733-2-zhangqing@rock-chips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elaine,

On 2/26/21 9:22 AM, Elaine Zhang wrote:
> Document the device tree bindings of the rockchip Rk3568 SoC
> clock driver in Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../bindings/clock/rockchip,rk3568-cru.yaml   | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> 
> diff --git a/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> new file mode 100644
> index 000000000000..612da341ea67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml
> @@ -0,0 +1,55 @@

> +# SPDX-License-Identifier: GPL-2.0

This is a new document.
Use GPL-2.0 only for a conversion of an existing document in the main
kernel.

./scripts/checkpatch.pl --strict
0001-dt-binding-clock-Document-rockchip-rk3568-cru-bindin.patch

WARNING: DT binding documents should be licensed (GPL-2.0-only OR
BSD-2-Clause)
#21: FILE:
Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml:1:
+# SPDX-License-Identifier: GPL-2.0

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/rockchip,rk3568-cru.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ROCKCHIP rk3568 Family Clock Control Module Binding
> +
> +maintainers:

> +  - Elaine Zhang <zhangqing@rock-chips.com>

     - Heiko Stuebner <heiko@sntech.de>

Add the maintainer of the clock drivers as well.

> +
> +description: |

> +  The RK3568 clock controller generates and supplies clock to various

supplies clock

This phrase could be improved a bit.
(?? generates the clocks signals for ??)

> +  controllers within the SoC and also implements a reset controller for SoC
> +  peripherals.
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
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
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

> +      reg = <0x0 0xfdd00000 0x0 0x1000>;

Method 1 (easier):

reg = <0xfdd00000 0x1000>;

This example is 64 bit.
The dt_binding_check uses standard 32 bit.


Method 2:

Add both examples in a subnode.

example {
  #address-cells = <2>;
  #size-cells = <2>;

  pmucru {}

  cru {}
}

make ARCH=arm64 dt_binding_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.yaml

/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.example.dt.yaml:
example-1: clock-controller@fdd20000:reg:0: [0, 4258398208, 0, 4096] is
too long
	From schema: ~/.local/lib/python3.5/site-packages/dtschema/schemas/reg.yaml
/Documentation/devicetree/bindings/clock/rockchip,rk3568-cru.example.dt.yaml:
example-0: clock-controller@fdd00000:reg:0: [0, 4258267136, 0, 4096] is
too long
	From schema: ~/.local/lib/python3.5/site-packages/dtschema/schemas/reg.yaml

> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> +  - |
> +    cru: clock-controller@fdd20000 {
> +      compatible = "rockchip,rk3568-cru";

> +      reg = <0x0 0xfdd20000 0x0 0x1000>;

dito

> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +    };
> 

