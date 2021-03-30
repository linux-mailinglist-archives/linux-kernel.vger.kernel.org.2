Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD1A34E9C1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 15:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhC3N6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 09:58:48 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:36707 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbhC3N6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 09:58:18 -0400
Received: by mail-ot1-f49.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso15656173otq.3;
        Tue, 30 Mar 2021 06:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oE0RHINGOkrAhMuN+EDn+2x2x/JU6fqWc3MSjm6Mpgg=;
        b=XTuBkkB0XRP6SKROmqGOiNdESVgqxHCglGDSRRLRc/1yzvSoZEtylkF5w92IwY7fyY
         U9S59Al0L4czC0hnNTVHbuNv/TQh5PmNFKURIItKR9LmLZPi8t6oN+KjRJH/m6dIyFnI
         bZtG2+w+qEsicw6EaT5J40n+o77PTATDxnlTkFV7XG6Cw6axZwz5OrsPH2n3nIfpqUBk
         K3QNn+0YZKJJ22Maj9fIzD4aCcL/xq6wPMHbkeF94SDazKCqPuJWMY9FMk7MrZ5EC+SW
         RjTmHk+on6l00lpayciQaYadzpJibUNr8k/H+PmSgyX6u5UAstKavkco4GJv6uH1KCH+
         ZpgQ==
X-Gm-Message-State: AOAM532VWBSdEHxyBnkTSlNfpuT20/hF9BaHXSkS9Xeg1yyVVTK0bcRf
        QCsg7QGRrc51YMt74DtQkQ==
X-Google-Smtp-Source: ABdhPJwdk3X0YnGo9PphS+OE9pC3LG6IUB4vf009cllFj5x/3WRr6jQQnkKvfu5mxBrMwEaDbVTseQ==
X-Received: by 2002:a05:6830:1e14:: with SMTP id s20mr28670725otr.199.1617112697070;
        Tue, 30 Mar 2021 06:58:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h18sm4432750oov.43.2021.03.30.06.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 06:58:15 -0700 (PDT)
Received: (nullmailer pid 238595 invoked by uid 1000);
        Tue, 30 Mar 2021 13:58:14 -0000
Date:   Tue, 30 Mar 2021 08:58:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Po-Kai Chi <pk.chi@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH v1 1/4] dt-bindings: memory: Add binding for MediaTek
 Common DRAM Controller
Message-ID: <20210330135814.GA224111@robh.at.kernel.org>
References: <1617081731-7408-1-git-send-email-pk.chi@mediatek.com>
 <1617081731-7408-2-git-send-email-pk.chi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617081731-7408-2-git-send-email-pk.chi@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 01:22:08PM +0800, Po-Kai Chi wrote:
> This patch adds the documentation of the device-tree binding for
> MediaTek Common DRAM Controller.
> 
> Signed-off-by: Po-Kai Chi <pk.chi@mediatek.com>
> ---
>  .../memory-controllers/mediatek,dramc.yaml         |  155 ++++++++++++++++++++
>  1 file changed, 155 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml b/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
> new file mode 100644
> index 0000000..0217ce0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,dramc.yaml
> @@ -0,0 +1,155 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2021 MediaTek Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/mediatek,dramc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek DRAM Controller
> +
> +maintainers:
> +  - Po-Kai Chi <pk.chi@mediatek.com>
> +
> +description: |
> +  MediaTek DRAM controller (DRAMC) provides an interface to query information
> +  about DRAM which collected from bootloader and device tree.
> +  This is mainly used by MediaTek Extended Memory Interface (EMI) and DVFS Resource
> +  Control (DVFSRC).
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt6779-dramc
> +
> +  reg:
> +    description:
> +      Base address of MediaTek DRAM related hardware modules, each channel has
> +      its own base address in order of
> +      DRAMC_AO_{CH}, DRAMC_NAO_{CH}, DDRPHY_AO_{CH}.
> +    minItems: 3            # 3 * N channels
> +    maxItems: 6
> +
> +  dram_type:

These need to be either common or have a vendor prefix.

Also, s/_/-/

> +    description:
> +      The DRAM type of current DRAM chip.
> +      This property is filled in by bootloader according to the board hardware
> +      configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 7
> +
> +  support_channel_cnt:
> +    description:
> +      The maximum DRAM channel count supported by SoC.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 4
> +
> +  channel_cnt:
> +    description:
> +      The DRAM channel count of current DRAM chip.
> +      This property is filled in by bootloader according to the board hardware
> +      configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 4
> +
> +  rank_cnt:
> +    description:
> +      The DRAM rank count of current DRAM chip.
> +      This property is filled in by bootloader according to the board hardware
> +      configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +    maximum: 2
> +
> +  rank_size:
> +    description:
> +      The size of each DRAM rank.
> +      This property is filled in by bootloader according to the board hardware
> +      configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint64
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      minimum: 0x0
> +      maximum: 0x100000000    # support up to 4GB in single rank
> +
> +  mr_cnt:
> +    description:
> +      Specifies how many sets of DRAM mode register information to provide.
> +      This property is filled in by bootloader according to the board hardware
> +      configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 40    # total 40 MRs for JEDEC LPDDR4X
> +
> +  mr:
> +    description:
> +      Pair of DRAM mode register information.
> +      This property is filled in by bootloader according to the board hardware
> +      configuration.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    maxItems: 40    # align with mr_cnt
> +    items:
> +      items:
> +        - description:
> +            Mode register index
> +        - description:
> +            Mode register value
> +
> +  freq_cnt:
> +    description:
> +      Specifies how many sets of DRAM data clock rate supported by SoC.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +  freq_step:
> +    description:
> +      The DRAM data clock rate may be slightly different from those defined
> +      by the specification due to errors in multiples of the base frequency.
> +      This describe the mapping from real data clock rate measured by
> +      frequency meter to JEDEC data clock rate.
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    items:
> +      items:
> +        - description:
> +            Real data rate
> +        - description:
> +            Spec data rate

Looks like an OPP table.

> +
> +required:
> +  - compatible
> +  - reg
> +  - dram_type
> +  - support_channel_cnt
> +  - channel_cnt
> +  - rank_cnt
> +  - mr_cnt
> +  - freq_cnt
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dramc@10230000 {
> +        compatible = "mediatek,mt6779-dramc";
> +        reg = <0 0x10230000 0 0x2000>, /* DRAMC AO CHA */
> +            <0 0x10240000 0 0x2000>,   /* DRAMC AO CHB */
> +            <0 0x10234000 0 0x1000>,   /* DRAMC NAO CHA */
> +            <0 0x10244000 0 0x1000>,   /* DRAMC NAO CHB */
> +            <0 0x10238000 0 0x2000>,   /* DDRPHY AO CHA */
> +            <0 0x10248000 0 0x2000>;   /* DDRPHY AO CHB */
> +        dram_type = <0>;
> +        support_channel_cnt = <2>;
> +        channel_cnt = <2>;
> +        rank_cnt = <2>;
> +        rank_size = <0x40000000 0x40000000>;

You defined this as 64-bit, so this is a single value?

> +        mr_cnt = <1>;
> +        mr = <0x5 0xff>;
> +        freq_cnt = <6>;
> +        freq_step = <3718 3733>,
> +                <3094 3200>,
> +                <2392 2400>,
> +                <1534 1600>,
> +                <1196 1200>,
> +                <754 800>;
> +    };
> -- 
> 1.7.9.5
> 
