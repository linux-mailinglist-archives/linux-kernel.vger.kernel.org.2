Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF79444CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 02:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhKDBJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 21:09:10 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:45772 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhKDBJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 21:09:08 -0400
Received: by mail-oi1-f169.google.com with SMTP id u2so6518839oiu.12;
        Wed, 03 Nov 2021 18:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YocbHtB0WKCVpaPIwIN4Bz/405kKtFB5GzeTgkMKUbU=;
        b=1VkAe1HtunpbGuHkSr+bAYcm482cbSV0LJnwqLrm656WOnCmcuKvvIuj/PweOOmypb
         VYZdi2C4Gy9qBpviT5+ConHJY0GSKdsZwSe71hFEYJ4hOwbS2tTgOpDAg0lBvrOha4yq
         3P6mlAbTWY7EuvlRMoGJEoQK/pz8CjBrqHtS+MFvueiVjCHeLEfOFza26ARf2NIeAQyM
         hSjMO+7HDqFebpUSf2AeSG9q+gQWofKVy2jyHCEs+2qzAMmXrpMQ0MWlYq4GZeST3sVs
         Bogu5DcPrG/1irEANyd2Ju5Yrzw59AxywPl/7PIqFcmWXAMlGozcBZRpkVUyWyXcMc3B
         jtww==
X-Gm-Message-State: AOAM531ZIn1wtfaUGmh7RATAymsywHDooSM40y8jSvftoF0CrH2iI7NM
        vDbC4imQo3U59LyyIQGEgQ==
X-Google-Smtp-Source: ABdhPJxGo+5iN/O5yvgisGFrxVAxyW+CSOOK9/Uinje5TIMZuC9rnFykfXySd0UhCxBTW5qolr+fcQ==
X-Received: by 2002:aca:280d:: with SMTP id 13mr11393821oix.116.1635987991262;
        Wed, 03 Nov 2021 18:06:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r24sm524554otc.12.2021.11.03.18.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 18:06:30 -0700 (PDT)
Received: (nullmailer pid 2116973 invoked by uid 1000);
        Thu, 04 Nov 2021 01:06:29 -0000
Date:   Wed, 3 Nov 2021 20:06:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     James Lo <james.lo@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [RESEND, v13 2/4] dt-bindings: spmi: document binding for the
 Mediatek SPMI controller
Message-ID: <YYMyFT94l56iuEbo@robh.at.kernel.org>
References: <20211103081021.9917-1-james.lo@mediatek.com>
 <20211103081021.9917-3-james.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103081021.9917-3-james.lo@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 04:10:19PM +0800, James Lo wrote:
> This adds documentation for the SPMI controller found on Mediatek SoCs.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>

Missing author S-o-b. checkpatch.pl will tell you this.

> ---
>  .../bindings/spmi/mtk,spmi-mtk-pmif.yaml      | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
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
> -- 
> 2.18.0
> 
> 
