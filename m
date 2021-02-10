Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4F13316687
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 13:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231380AbhBJMWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 07:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbhBJMUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 07:20:02 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD77C06174A;
        Wed, 10 Feb 2021 04:19:22 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r21so2234048wrr.9;
        Wed, 10 Feb 2021 04:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ssW9O/eIVkXR6kVLbH1uKgyKlATY5TEX9NDvAFBdzbU=;
        b=IDkESL79YgL6x6coqRDxvQiawlwVxIIJSkN/pWkDyFQ6rCgvQBzz1rNjapBgEr8r/b
         qwwR2dYQtbSvZJdpWtLYMPKBAkCVuWeeoL8rEKP6XFyLLDPZPh7/T5Gv6WQubDLPO45N
         BaJKfEJqbVlPONqfx+TTAN4uhIlbcWy2zYMeylp6b4/nPhLV3vMwQ/vKe1VMDZycNBQN
         IofAdahVA++bpV9GrzBSO3R8iP5rmeuL4duwJ+38E4eJOt15ZXK5LEb2ACg7k6dLWbrL
         Qtz7zl4p9J/FDbIl39/aWJvYy0+zksaYAQMK173lDu6FL38ZXfLjwU+AB3sD31KUnH5l
         gGkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ssW9O/eIVkXR6kVLbH1uKgyKlATY5TEX9NDvAFBdzbU=;
        b=iYVgdWyfFKNgvlAmwTPYdaW2b9q5uzAJRIbQ8A0MoU73PRmu6g1TNbEid+/QIk3Flg
         n4nNNECc5t0fN4y7/fkil9Z4M6V5C/i+HtXGspjd22adxr0XjyOAbSi/6hK1gcVH4FJC
         3xIiBXLZWp6mrw3OOGH3yeNdTjnJHVZ6KLiOjXV2x+6nWO9qUkEh3GH2UONwbvca54H5
         QCPnlOWN8VvmUsKpfYgvbQ6O4k2Mo+3dv8msx1I9xfEM21OfP6072qfurOiPOAMS9Fc5
         UMAWBk8HBtSRLI+AuQ5pjsJxEyxJggFWjvjuwcFV6u+AaAlYWWLiIixW6iFyAI1AXc3G
         0Hzg==
X-Gm-Message-State: AOAM532MqT/4/RH3zqlBcEj3P4Tahw5FVeyKeF1Uln/++/GK+R+rXB2/
        VfnHysYIdYfFV++7VzhT+sY=
X-Google-Smtp-Source: ABdhPJzuBlWj2KkjFfITOd5oA3b+7UPXGC+dYSAbizJbvSvcTU7UhE5sy9dOB6iNL20qS/uuzHmUHQ==
X-Received: by 2002:adf:ab18:: with SMTP id q24mr3376501wrc.80.1612959561029;
        Wed, 10 Feb 2021 04:19:21 -0800 (PST)
Received: from ziggy.stardust (static-188-169-27-46.ipcom.comunitel.net. [46.27.169.188])
        by smtp.gmail.com with ESMTPSA id g15sm2831049wrx.1.2021.02.10.04.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Feb 2021 04:19:20 -0800 (PST)
Subject: Re: [PATCH v6 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of imp i2c wrapper controller
To:     Weiyi Lu <weiyi.lu@mediatek.com>, Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1608642587-15634-1-git-send-email-weiyi.lu@mediatek.com>
 <1608642587-15634-2-git-send-email-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <010e346c-961b-88bb-aa48-398b23a7fb7a@gmail.com>
Date:   Wed, 10 Feb 2021 13:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1608642587-15634-2-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/12/2020 14:09, Weiyi Lu wrote:
> This patch adds the new binding documentation of imp i2c wrapper controller
> for Mediatek MT8192.

The wrapper controller has only clock parts, or are the clock register mapped
into the i2c wrapper block. In that case we might want to probe the clock driver
through the i2c wrapper driver.

Regards,
Matthias

> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,imp_iic_wrap.yaml        | 78 ++++++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
> new file mode 100644
> index 0000000..5d0cf37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imp_iic_wrap.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,imp_iic_wrap.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek IMP I2C Wrapper Controller
> +
> +maintainers:
> +  - Weiyi Lu <weiyi.lu@mediatek.com>
> +
> +description:
> +  The Mediatek imp i2c wrapper controller provides functional configurations and clocks to the system.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-imp_iic_wrap_c
> +          - mediatek,mt8192-imp_iic_wrap_e
> +          - mediatek,mt8192-imp_iic_wrap_s
> +          - mediatek,mt8192-imp_iic_wrap_ws
> +          - mediatek,mt8192-imp_iic_wrap_w
> +          - mediatek,mt8192-imp_iic_wrap_n
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    imp_iic_wrap_c: syscon@11007000 {
> +        compatible = "mediatek,mt8192-imp_iic_wrap_c", "syscon";
> +        reg = <0 0x11007000 0 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_e: syscon@11cb1000 {
> +        compatible = "mediatek,mt8192-imp_iic_wrap_e", "syscon";
> +        reg = <0 0x11cb1000 0 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_s: syscon@11d03000 {
> +        compatible = "mediatek,mt8192-imp_iic_wrap_s", "syscon";
> +        reg = <0 0x11d03000 0 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_ws: syscon@11d23000 {
> +        compatible = "mediatek,mt8192-imp_iic_wrap_ws", "syscon";
> +        reg = <0 0x11d23000 0 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_w: syscon@11e01000 {
> +        compatible = "mediatek,mt8192-imp_iic_wrap_w", "syscon";
> +        reg = <0 0x11e01000 0 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_n: syscon@11f02000 {
> +        compatible = "mediatek,mt8192-imp_iic_wrap_n", "syscon";
> +        reg = <0 0x11f02000 0 0x1000>;
> +        #clock-cells = <1>;
> +    };
> 
