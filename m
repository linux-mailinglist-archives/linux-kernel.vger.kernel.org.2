Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296554433FA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 17:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhKBQyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 12:54:14 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37412 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKBQwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 12:52:20 -0400
Received: by mail-ot1-f52.google.com with SMTP id v40-20020a056830092800b0055591caa9c6so22612566ott.4;
        Tue, 02 Nov 2021 09:49:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w7OCrf7rifBBMWTmL311h+DC3U5MFxTs2snFaNj8QNE=;
        b=LM3y2a7JI1YhOrIDZ59kMtb9ut+/k6UC3Ag0Moa17StwNXEco7Ha2WwvVqpk996jez
         IAAbXnSh4mr6hgO3jmqgHWe+8FGRrxfiuslDFpDxcTHRALQ6mtwmvo5jdo9Q8oYCjYRm
         dj1HT34FhTCl7U4r+atYZSJfc2rrKlAR8XAUvsgY6BSc707wnJYp5XijHE2eLc750DqJ
         8F2GlTv1qfZrlqqhKpisJTg5F2Zzq4IM7rS1slPPdILIE5tIXIatvu90t33qCaUiO/42
         Qh59RMFdIkqKnyOA8ftZ+iz4+ubCMAYSqFnZiJcfrIqx6oZFrCPdbsEktqI5ihYKOoZ3
         0Ctg==
X-Gm-Message-State: AOAM531r+PU7+6xSCB+rUxmT8yz3n2NqMvHEvNVGS8m6iR9Cv+defe/U
        PHfX70RJ1usM3Te0GPFFkA==
X-Google-Smtp-Source: ABdhPJxNkprmX4LIkrnpupfOPtMxMkApEBcH/bSyncViTFJO8577qI0GbUK13qW17fKIYl7dW5ZQaw==
X-Received: by 2002:a9d:6e16:: with SMTP id e22mr27466399otr.77.1635871785382;
        Tue, 02 Nov 2021 09:49:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q5sm5218662otg.1.2021.11.02.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 09:49:44 -0700 (PDT)
Received: (nullmailer pid 3049381 invoked by uid 1000);
        Tue, 02 Nov 2021 16:49:43 -0000
Date:   Tue, 2 Nov 2021 11:49:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v4 2/2] dt-bindings: dsp: mediatek: Add mt8195 DSP
 binding support
Message-ID: <YYFsJ+J9m7QBGpmB@robh.at.kernel.org>
References: <20211028135737.8625-1-yc.hung@mediatek.com>
 <20211028135737.8625-3-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028135737.8625-3-yc.hung@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 09:57:37PM +0800, YC Hung wrote:
> This describes the mt8195 DSP device tree node.
> 
> Signed-off-by: YC Hung <yc.hung@mediatek.com>
> ---
>  .../bindings/dsp/mtk,mt8195-dsp.yaml          | 139 ++++++++++++++++++
>  1 file changed, 139 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> new file mode 100644
> index 000000000000..f113f71ca094
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> @@ -0,0 +1,139 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dsp/mtk,mt8195-dsp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek mt8195 DSP core
> +
> +maintainers:
> +  - YC Hung <yc.hung@mediatek.com>
> +
> +description: |
> +  Some boards from mt8195 contain a DSP core used for
> +  advanced pre- and post- audio processing.
> +properties:
> +  compatible:
> +    const: mediatek,mt8195-dsp
> +
> +  reg:
> +    maxItems: 2
> +
> +  reg-names:
> +    maxItems: 2

Need to define what each entry is and the names for them.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-names:
> +    maxItems: 1

Need to define the name. Though -names with 1 entry is not that useful.

> +
> +  clocks:
> +    items:
> +      - description: mux for audio dsp clock
> +      - description: 26M clock
> +      - description: mux for audio dsp local bus
> +      - description: default audio dsp local bus clock source
> +      - description: clock gate for audio dsp clock
> +      - description: mux for audio dsp access external bus
> +
> +  clock-names:
> +    items:
> +      - const: adsp_sel
> +      - const: clk26m_ck
> +      - const: audio_local_bus
> +      - const: mainpll_d7_d2
> +      - const: scp_adsp_audiodsp
> +      - const: audio_h
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  mboxes:
> +    maxItems: 2
> +
> +  mbox-names:
> +    description:
> +      Specifies the mailboxes used to communicate with audio DSP
> +    items:
> +      - const: mbox0
> +      - const: mbox1

Is there not a specific function for each mailbox? You already have an 
index implicitly.

> +
> +  memory-region:
> +    description:
> +      phandle to a node describing reserved memory (System RAM memory)
> +      used by DSP (see bindings/reserved-memory/reserved-memory.txt)
> +    maxItems: 2

1 phandle or 2? If 2, what is each one for?

> +
> +  sound:
> +    description:
> +      Sound subnode includes ASoC platform, DPTx codec node, and
> +      HDMI codec node.
> +
> +    type: object

       additionalProperties: false

Though why do you need a child node here in the first place?

> +
> +    properties:
> +      mediatek,platform:
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +        description: The phandle of MT8195 ASoC platform.
> +
> +      mediatek,dptx-codec:
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +        description: The phandle of MT8195 Display Port Tx codec node.
> +
> +      mediatek,hdmi-codec:
> +        $ref: "/schemas/types.yaml#/definitions/phandle"
> +        description: The phandle of MT8195 HDMI codec node.
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - clocks
> +  - clock-names
> +  - memory-region
> +  - power-domains
> +  - mbox-names
> +  - mboxes
> +  - sound
> +
> +

Extra blank line.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    adsp: adsp@10803000 {

dsp@...

> +       compatible =  "mediatek,mt8195-dsp";
> +       reg = <0x10803000  0x1000>,
> +             <0x10840000  0x40000>;
> +       reg-names = "cfg", "sram";
> +       interrupts = <GIC_SPI 694 IRQ_TYPE_LEVEL_HIGH 0>;
> +       interrupt-names = "wdt";
> +       clocks = <&topckgen 10>, //CLK_TOP_ADSP
> +                <&clk26m>,
> +                <&topckgen 107>, //CLK_TOP_AUDIO_LOCAL_BUS
> +                <&topckgen 136>, //CLK_TOP_MAINPLL_D7_D2
> +                <&scp_adsp 0>, //CLK_SCP_ADSP_AUDIODSP
> +                <&topckgen 34>; //CLK_TOP_AUDIO_H
> +       clock-names = "adsp_sel",
> +                     "clk26m_ck",
> +                     "audio_local_bus",
> +                     "mainpll_d7_d2",
> +                     "scp_adsp_audiodsp",
> +                     "audio_h";
> +       memory-region = <&adsp_dma_mem_reserved>,
> +                       <&adsp_mem_reserved>;
> +       power-domains = <&spm 6>; //MT8195_POWER_DOMAIN_ADSP
> +       mbox-names = "mbox0", "mbox1";
> +       mboxes = <&adsp_mailbox 0>, <&adsp_mailbox 1>;
> +       status = "disabled";

Don't disable your example. Drop status.

> +       sound {
> +              mediatek,dptx-codec = <&dp_tx>;
> +              mediatek,hdmi-codec = <&hdmi0>;
> +              mediatek,platform = <&afe>;
> +             };
> +       };
> -- 
> 2.18.0
> 
> 
