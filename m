Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3608E44E9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 16:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbhKLPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 10:22:33 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:33471 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhKLPWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 10:22:30 -0500
Received: by mail-oi1-f182.google.com with SMTP id q25so12881627oiw.0;
        Fri, 12 Nov 2021 07:19:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4yel1hd+kqu0GBbGBGX3XHvXpWBPzRQA3xBOJv/VtNs=;
        b=GT+sTwhFv2xRBZfoEg8F2hH7IFaksDiLqcn4rJq95RpYyAiaYBbjsnNlETmPra6och
         leMs2Yi5npN0bofzdFfx7mZo9+dB4W5FH4piklosIl7njZUSYWpej+tdBvU3NSEjSFEq
         ovke62olqcF+NWvye1b1D5r5Y2tv0iAJypbiB5MRDeIIHJtzed5R1qZs4WXxo1kFHAXa
         faeTiF9q0whUOgNum/gFMdOAVHbkPVQAuRxPrk+OXCYhpVtb+xGHj1eU9D1yL3i2os0t
         I5fO2IpUGB4iEuBD7hSQRJJimYwkHjWESGZgT1ItCbzBdzUKpQUlcGC9omFH+ui8wUTx
         XnEg==
X-Gm-Message-State: AOAM532ZiYPMJzqNq+dLWYO0dITHDNj611i+3HmEBVWYm5Z8DP3+Jd7u
        byKnqt5kX8WqEAbolbr2nQ==
X-Google-Smtp-Source: ABdhPJxQ+VudnSViJNi+5YOF/wy3/DfPOdoi5jO3AL2BMG9xkI0fZG9NZYIjiv6etRC7ulNfdpKqsg==
X-Received: by 2002:a05:6808:180c:: with SMTP id bh12mr14006813oib.152.1636730378271;
        Fri, 12 Nov 2021 07:19:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g1sm1150075ooq.2.2021.11.12.07.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 07:19:37 -0800 (PST)
Received: (nullmailer pid 2870844 invoked by uid 1000);
        Fri, 12 Nov 2021 15:19:36 -0000
Date:   Fri, 12 Nov 2021 09:19:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     James Lo <james.lo@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [RESEND, v14 1/3] dt-bindings: spmi: modify the constraint of
 reg property
Message-ID: <YY6GCA9pu3p0p3fy@robh.at.kernel.org>
References: <20211112055410.21418-1-james.lo@mediatek.com>
 <20211112055410.21418-2-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112055410.21418-2-james.lo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2021 at 01:54:08PM +0800, James Lo wrote:
> The constraint of reg may larger than 1, so we modify to
> 'minItem: 1' and 'maxItem: 2'.
> And adds documentation for the SPMI controller found on
> Mediatek SoCs.
> 
> Merge [RESEND,v13,2/4] into [RESEND,v13,1/4] for fix yaml
> error.
> [RESEND,v13,1/4] :
> dt-bindings: spmi: modify the constraint of reg property
> [RESEND,v13,2/4] :
> dt-bindings: spmi: document binding for the Mediatek SPMI
> controller

Combining is not the right thing to do.

> 
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  .../devicetree/bindings/spmi/spmi.yaml        |  3 +-
>  2 files changed, 78 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> new file mode 100644
> index 000000000000..2445c5e0b0ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spmi/mtk,spmi-mtk-pmif.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spmi/mtk,spmi-mtk-pmif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek SPMI Controller Device Tree Bindings
> +
> +maintainers:
> +  - Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> +
> +description: |+
> +  On MediaTek SoCs the PMIC is connected via SPMI and the controller allows
> +  for multiple SoCs to control a single SPMI master.
> +
> +allOf:
> +  - $ref: "spmi.yaml"
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt6873-spmi
> +      - mediatek,mt8195-spmi
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: pmif
> +      - const: spmimst
> +
> +  clocks:
> +    minItems: 3
> +    maxItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: pmif_sys_ck
> +      - const: pmif_tmr_ck
> +      - const: spmimst_clk_mux
> +
> +  assigned-clocks:
> +    maxItems: 1
> +
> +  assigned-clock-parents:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - clocks
> +  - clock-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +
> +    spmi: spmi@10027000 {
> +        compatible = "mediatek,mt6873-spmi";
> +        reg = <0x10027000 0xe00>,
> +              <0x10029000 0x100>;
> +        reg-names = "pmif", "spmimst";
> +        clocks = <&infracfg CLK_INFRA_PMIC_AP>,
> +                 <&infracfg CLK_INFRA_PMIC_TMR>,
> +                 <&topckgen CLK_TOP_SPMI_MST_SEL>;
> +        clock-names = "pmif_sys_ck",
> +                      "pmif_tmr_ck",
> +                      "spmimst_clk_mux";
> +        assigned-clocks = <&topckgen CLK_TOP_PWRAP_ULPOSC_SEL>;
> +        assigned-clock-parents = <&topckgen CLK_TOP_OSC_D10>;
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/spmi/spmi.yaml b/Documentation/devicetree/bindings/spmi/spmi.yaml
> index 1d243faef2f8..f29183a45adc 100644
> --- a/Documentation/devicetree/bindings/spmi/spmi.yaml
> +++ b/Documentation/devicetree/bindings/spmi/spmi.yaml
> @@ -25,7 +25,8 @@ properties:
>      pattern: "^spmi@.*"
>  
>    reg:
> -    maxItems: 1
> +    maxItems: 2
> +    minItems: 1

'reg' is controller specific so we shouldn't even be specifying it here. 
Just remove it.

>  
>    "#address-cells":
>      const: 2
> -- 
> 2.18.0
> 
> 
