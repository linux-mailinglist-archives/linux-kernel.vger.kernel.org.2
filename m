Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC1399150
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhFBRUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:20:10 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:43976 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhFBRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:20:09 -0400
Received: by mail-oo1-f41.google.com with SMTP id e27-20020a056820061bb029020da48eed5cso720320oow.10;
        Wed, 02 Jun 2021 10:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nIOAi6NGVLlsemIL0TG75iCzb5F9XFdTz3HwPbCx7Gs=;
        b=n5NAYUAQ0Y7kSxdV5jCv4HMjg3sZcCthvSK5bM9X3nEytYUnN84ZeMxgiZV7paIc2Y
         n1VpJy8cAZfBXfo5172GXyEMhaSga44LYLJBdhFyCd2/BbJdOE5pwbZKcb/Uws6sOEKy
         Ju9Jh9gfARiOhmRKqfFksB4fsNc2say41NLGCdYbceQSMhZV6TlLdDRbkLC3yULTP7Ht
         T3sNBrfOQPHvrUzoa2lAdlDCaju4WWRPSautWiWx+G5rShIRIUF5kkFFuyMIQJS896nS
         ODJgB0eJfs6M4czFBXmePivgaxs+msOih+NMvxoHsvHsgt8UE9UDBO72MIWOShjLjKFT
         Gjcw==
X-Gm-Message-State: AOAM531NceNtHvswMh68rl9ntyVKQCNuEX43h9yCnntfu//9xevm4qXh
        bqYyvUMnM0glNvAAt0oa4A==
X-Google-Smtp-Source: ABdhPJyeIWdhxbSCxtVdSzG3l0YklSQ69PhjwvvmKsi7IJAS3cEWrG6NjcwMLFresI/dnUfLc4458w==
X-Received: by 2002:a4a:ac04:: with SMTP id p4mr25569614oon.70.1622654289975;
        Wed, 02 Jun 2021 10:18:09 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id w186sm92622oib.58.2021.06.02.10.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:18:09 -0700 (PDT)
Received: (nullmailer pid 3600851 invoked by uid 1000);
        Wed, 02 Jun 2021 17:18:07 -0000
Date:   Wed, 2 Jun 2021 12:18:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [PATCH v9 04/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of scp adsp controller
Message-ID: <20210602171807.GA3599942@robh.at.kernel.org>
References: <20210524122053.17155-1-chun-jie.chen@mediatek.com>
 <20210524122053.17155-5-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524122053.17155-5-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2021 at 08:20:35PM +0800, Chun-Jie Chen wrote:
> This patch adds the new binding documentation of scp adsp controller
> for Mediatek MT8192.

Same comment here.

> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: chun-jie.chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,scp-adsp.yaml       | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml
> new file mode 100644
> index 000000000000..1b4335c054f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,scp-adsp.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/mediatek/mediatek,scp-adsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek SCP ADSP Controller
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek scp adsp controller provides functional configurations and clocks to the system.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8192-scp_adsp
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
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    scp_adsp: syscon@10720000 {
> +        compatible = "mediatek,mt8192-scp_adsp", "syscon";
> +        reg = <0x10720000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> -- 
> 2.18.0
