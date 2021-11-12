Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821B144EDC2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhKLUSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 15:18:07 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33497 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbhKLUSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 15:18:06 -0500
Received: by mail-ot1-f54.google.com with SMTP id h12-20020a056830034c00b0055c8458126fso15631011ote.0;
        Fri, 12 Nov 2021 12:15:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=keLT6GqkBxKBg5E7mpziqAGsje8UnIi4oJ/70fWYsOk=;
        b=tveqlObCh9TbDyJaO6cOspfelQJTt91QWYN+597Ne2+hRe5uTRlHTNTnD2l4fm8c87
         WUSOi5G2QouNpVHh6Jm79fh/yibIytLFjLa/QEvQ3S5EeElipARW4TLSwD4dDbWUiu19
         lJczJR+YSs/17FP4TLH7mdOfg+hzGyBYEfBQiK+GCBxJ4syTZbfasgCqBePYmzWMoYxJ
         qBspArOEXN/IRnrkaUvtdiJKUb/dQ1YqziUrkkGGWZk+fzmNwj+5aeCyjH/VjPiWvzWb
         4xYXOOSP2Z9+5a4AMt2mELwmf4DIwhM7QrQXxdrc+PUi5ELFcllDj+S16VMEwpBMvJxt
         9QpA==
X-Gm-Message-State: AOAM532bcSMGZOU39lScu+NXbXDyizm7DkfqDD4AsbIcGUTyCfb6ske+
        KV3580jxk8kAgcBemV9iVA==
X-Google-Smtp-Source: ABdhPJz0IgudO9I+dADfCJrqhnAcSXUvXv7srFOWzM/tpxDv/VcAcn13Yy2W70rZqXpm+7Y/UoSzNQ==
X-Received: by 2002:a9d:6307:: with SMTP id q7mr14945920otk.83.1636748115023;
        Fri, 12 Nov 2021 12:15:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y9sm1235608oon.8.2021.11.12.12.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 12:15:14 -0800 (PST)
Received: (nullmailer pid 3294254 invoked by uid 1000);
        Fri, 12 Nov 2021 20:15:13 -0000
Date:   Fri, 12 Nov 2021 14:15:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel.baluta@nxp.com,
        trevor.wu@mediatek.com, allen-kh.cheng@mediatek.com,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v5] dt-bindings: dsp: mediatek: Add mt8195 DSP binding
 support
Message-ID: <YY7LUWS5YDBBl/Kp@robh.at.kernel.org>
References: <20211103102607.12277-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103102607.12277-1-yc.hung@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2021 at 06:26:08PM +0800, YC Hung wrote:
> From: "yc.hung" <yc.hung@mediatek.com>
> 
> This describes the mt8195 DSP device tree node.
> 
> Signed-off-by: yc.hung <yc.hung@mediatek.com>
> ---
> Changes since v4:
>   - remove patch 1 with clocks as it will be reviewed and merged to SOF tree.
>     https://github.com/thesofproject/linux/pull/3237
>   - refine DT file binding files with Rob's comments.
> 
>  .../bindings/dsp/mtk,mt8195-dsp.yaml          | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> new file mode 100644
> index 000000000000..aeeb7af69625
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> @@ -0,0 +1,142 @@
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
> +    items:
> +      - description: Address and size of the DSP Cfg registers
> +      - description: Address and size of the DSP SRAM
> +
> +  reg-names:
> +    items:
> +      - const: cfg
> +      - const: sram
> +
> +  interrupts:
> +    items:
> +      - description: watchdog interrupt
> +
> +  interrupt-names:
> +    items:
> +      - const: wdt
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
> +    items:
> +      - description: a mailbox is ised for ipc reply between host and audio DSP.
> +      - description: a mailbox is ised for ipc reuqest between host and audio DSP.
> +
> +  mbox-names:
> +    items:
> +      - const: mbox0
> +      - const: mbox1
> +
> +  memory-region:      
> +    items:
> +      - description: A phandle to a reserved memory region is used for dma buffer between host and DSP.   
> +      - description: A phandle to a reserved memory region is used for DSP system memory.
> +
> +  sound:
> +    description:
> +      Sound subnode includes ASoC platform, DPTx codec node, and
> +      HDMI codec node.
> +
> +    type: object

Same question as v4, why do you need a sub-node here. Just move these 
properties up a level.

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
