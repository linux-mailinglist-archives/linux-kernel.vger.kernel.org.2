Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53A4432816
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 21:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhJRUBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 16:01:41 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:38619 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhJRUBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 16:01:38 -0400
Received: by mail-oi1-f171.google.com with SMTP id t4so1362997oie.5;
        Mon, 18 Oct 2021 12:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/KO8MvppjA9yDmahjXb0FodhN5V5+dS+Knni3+3rua8=;
        b=OXISQ3XbPzCnnBtuWo578IOOJ9k/ITgw6iv5dA0EBkqypyRNRJ6ur8It/vaxhgMcAD
         hZG4FOlbCAn7SXuF/sZ+dsPyF8LmQ/lCfo+JztGCu8l/KB3Hm1oO49iLWnAcLyBXIkH1
         I0X6T6YiYvJtG9xZs4qzmU8+p+nU+rCjBt3ygUnmA2KAGE/cq7k3mbxR8ns4o4R/AxZz
         5FFB8ju/bxh1BlHLHORH0SZUCslC9BJdrxcCiXn9uIvqwNNGkCZ46wxcwxcx5YKJ9jZc
         GKbuMOTiyM8XN50aDXYwt1ViVi4Vfk+wuONjHEhotVLvXY1fKV4JlJITOrwfC4TUq4ap
         uvwQ==
X-Gm-Message-State: AOAM531BBvwrKsZnnSlfdj0qVL0Oaajajq/txqpDMpfoNP6AMt5uerK7
        bS2kOd6gew/fYuqGlS7Q1g==
X-Google-Smtp-Source: ABdhPJxJBK2iXYAuAaPiu+Bn51zOnUYWqFsKlnTyUsyakCVVxNcpPMq+Uxw4DmwcsHfAnJAn+lhUEQ==
X-Received: by 2002:a05:6808:300a:: with SMTP id ay10mr820353oib.36.1634587166105;
        Mon, 18 Oct 2021 12:59:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l1sm1691404oic.30.2021.10.18.12.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 12:59:25 -0700 (PDT)
Received: (nullmailer pid 2853247 invoked by uid 1000);
        Mon, 18 Oct 2021 19:59:24 -0000
Date:   Mon, 18 Oct 2021 14:59:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2] dt-bindings: mediatek: add adsp-mbox document
Message-ID: <YW3SHDBj2Q1dS8Wp@robh.at.kernel.org>
References: <20211008084030.2439-1-Allen-KH.Cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008084030.2439-1-Allen-KH.Cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 08, 2021 at 04:40:30PM +0800, Allen-KH Cheng wrote:
> This patch adds document for mediatek adsp mbox
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  .../bindings/mailbox/mtk,adsp-mbox.yaml       | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> new file mode 100644
> index 000000000000..9028e403ceda
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/mtk,adsp-mbox.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/mtk,adsp-mbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek ADSP mailbox
> +
> +maintainers:
> +  - Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> +
> +description: |
> +  The MTK ADSP mailbox Inter-Processor Communication (IPC) enables the SoC
> +  to ommunicate with ADSP by passing messages through two mailbox channels.
> +  The MTK ADSP mailbox IPC also provides the ability for one processor to
> +  signal the other processor using interrupts.
> +
> +  mbox0 is handling ipc reply
> +  mbox1 is handling ipc request
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-adsp-mbox
> +
> +  "#mbox-cells":
> +    const: 1
> +
> +  reg:
> +    description: 
> +      Physical address base for dsp mbox base registers.
> +    maxItems: 2
> +    minItems: 2
> +
> +  reg-names:
> +    items:
> +      - const: reg_mbox0 
> +      - const: reg_mbox1

'reg_' is redundant.

> +
> +  interrupts:
> +    description: 
> +      adsp mbox interrupt
> +    maxItems: 2
> +    minItems: 2
> +
> +  interrupt-names:
> +    items:
> +      - const: irq_mbox0 
> +      - const: irq_mbox1

'irq_' is redundant.


Is this really 1 h/w block? Kind of looks like 2 instances of a block.

> +
> +required:
> +  - compatible
> +  - "#mbox-cells"
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    adsp_mailbox:adsp_mailbox@10816000 {
> +        compatible = "mediatek,mt8195-adsp-mbox";
> +        #mbox-cells = <1>;
> +        reg = <0x10816000 0x1000>,
> +              <0x10817000 0x1000>;
> +        reg-names = "reg_mbox0", "reg_mbox1";
> +        interrupts = <GIC_SPI 702 IRQ_TYPE_LEVEL_HIGH 0>,
> +                     <GIC_SPI 703 IRQ_TYPE_LEVEL_HIGH 0>;
> +        interrupt-names = "irq_mbox0", "irq_mbox1";
> +    };
> +
> -- 
> 2.18.0
> 
> 
