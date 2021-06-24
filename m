Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5D63B388F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 23:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbhFXVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 17:24:29 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:34632 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbhFXVYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 17:24:25 -0400
Received: by mail-io1-f51.google.com with SMTP id g22so10118014iom.1;
        Thu, 24 Jun 2021 14:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IjYln7/CWaQLlpNjEcHcKJVMwo4CKVakMcfjJuaqkT8=;
        b=X0UA/iAOOdRALyNUe2lDcLAMXJn550DtI8vMhGquwiaehI+5w7IHGizwh0UG8yjEvf
         OS53ponMhY3UsXQiRWuvb/tI+2SZ7m1zU2uoQtXsXW+g6KwU+ZwUHnOLQEk7IvTphDLT
         AWftiC7hV14viIgvGbRbGp3l3bj25MMeDG4Hfa2SB7KGvgp+WAQIVkPDjfqRD1x3DvCn
         OskyMEnhM4sN8izzzrSBELFJltdyC1ZF1AEKcVfhAvPjE3DzVrPB4q7Z/JLOBtoT0UD/
         W9Ifr+nYIDKViv/TPrqN1I0g4OkEY2Q9kULq5R+mSvr774IFXdXkt3UInYXLwNMfP+qu
         im1A==
X-Gm-Message-State: AOAM531d0MHpbCpR4i1Ch6gp9xjXzFt4klIDCDnJv1ymFDXJqcgQOw+G
        5LCSyGfj1j7IAW+9v4Yngg==
X-Google-Smtp-Source: ABdhPJxY7LVDeDJUcuupR3ORKvKxfaqDvWjHt+12T65JRLfVwAsqXRCuBS/7Kqc+3sQFOLfMwHy8uQ==
X-Received: by 2002:a5e:8a41:: with SMTP id o1mr5642355iom.92.1624569725445;
        Thu, 24 Jun 2021 14:22:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z12sm2028180iop.46.2021.06.24.14.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 14:22:04 -0700 (PDT)
Received: (nullmailer pid 2007687 invoked by uid 1000);
        Thu, 24 Jun 2021 21:21:58 -0000
Date:   Thu, 24 Jun 2021 15:21:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 01/22] dt-bindings: ARM: Mediatek: Add new document
 bindings of MT8195 clock
Message-ID: <20210624212158.GA2005899@robh.at.kernel.org>
References: <20210616224743.5109-1-chun-jie.chen@mediatek.com>
 <20210616224743.5109-2-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616224743.5109-2-chun-jie.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:47:22AM +0800, Chun-Jie Chen wrote:
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8195.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8195-clock.yaml   | 287 ++++++++++++++++++
>  .../mediatek/mediatek,mt8195-sys-clock.yaml   |  66 ++++
>  2 files changed, 353 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> new file mode 100644
> index 000000000000..21554b3515cf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml
> @@ -0,0 +1,287 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek Functional Clock Controller for MT8195
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek functional clock controller provides various clocks on MT8195.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:

Drop 'oneOf' and 'items'.

> +              - mediatek,mt8195-nnasys
> +              - mediatek,mt8195-scp_adsp
> +              - mediatek,mt8195-audsys
> +              - mediatek,mt8195-audsys_src
> +              - mediatek,mt8195-imp_iic_wrap_s
> +              - mediatek,mt8195-imp_iic_wrap_w
> +              - mediatek,mt8195-mfgcfg
> +              - mediatek,mt8195-vppsys0
> +              - mediatek,mt8195-wpesys
> +              - mediatek,mt8195-wpesys_vpp0
> +              - mediatek,mt8195-wpesys_vpp1
> +              - mediatek,mt8195-vppsys1
> +              - mediatek,mt8195-imgsys
> +              - mediatek,mt8195-imgsys1_dip_top
> +              - mediatek,mt8195-imgsys1_dip_nr
> +              - mediatek,mt8195-imgsys1_wpe
> +              - mediatek,mt8195-ipesys
> +              - mediatek,mt8195-camsys
> +              - mediatek,mt8195-camsys_rawa
> +              - mediatek,mt8195-camsys_yuva
> +              - mediatek,mt8195-camsys_rawb
> +              - mediatek,mt8195-camsys_yuvb
> +              - mediatek,mt8195-camsys_mraw
> +              - mediatek,mt8195-ccusys
> +              - mediatek,mt8195-vdecsys_soc
> +              - mediatek,mt8195-vdecsys
> +              - mediatek,mt8195-vdecsys_core1
> +              - mediatek,mt8195-apusys_pll
> +              - mediatek,mt8195-vencsys
> +              - mediatek,mt8195-vencsys_core1
> +              - mediatek,mt8195-vdosys0
> +              - mediatek,mt8195-vdosys1
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
> +    nnasys: clock-controller@10211000 {
> +        compatible = "mediatek,mt8195-nnasys";
> +        reg = <0x10211000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    scp_adsp: clock-controller@10720000 {
> +        compatible = "mediatek,mt8195-scp_adsp";
> +        reg = <0x10720000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    audsys: clock-controller@10890000 {
> +        compatible = "mediatek,mt8195-audsys";
> +        reg = <0x10890000 0x10000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    audsys_src: clock-controller@108a0000 {
> +        compatible = "mediatek,mt8195-audsys_src";
> +        reg = <0x108a0000 0x2000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_s: clock-controller@11d03000 {
> +        compatible = "mediatek,mt8195-imp_iic_wrap_s";
> +        reg = <0x11d03000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imp_iic_wrap_w: clock-controller@11e05000 {
> +        compatible = "mediatek,mt8195-imp_iic_wrap_w";
> +        reg = <0x11e05000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    mfgcfg: clock-controller@13fbf000 {
> +        compatible = "mediatek,mt8195-mfgcfg";
> +        reg = <0x13fbf000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vppsys0: clock-controller@14000000 {
> +        compatible = "mediatek,mt8195-vppsys0";
> +        reg = <0x14000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    wpesys: clock-controller@14e00000 {
> +        compatible = "mediatek,mt8195-wpesys";
> +        reg = <0x14e00000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    wpesys_vpp0: clock-controller@14e02000 {
> +        compatible = "mediatek,mt8195-wpesys_vpp0";
> +        reg = <0x14e02000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    wpesys_vpp1: clock-controller@14e03000 {
> +        compatible = "mediatek,mt8195-wpesys_vpp1";
> +        reg = <0x14e03000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vppsys1: clock-controller@14f00000 {
> +        compatible = "mediatek,mt8195-vppsys1";
> +        reg = <0x14f00000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys: clock-controller@15000000 {
> +        compatible = "mediatek,mt8195-imgsys";
> +        reg = <0x15000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys1_dip_top: clock-controller@15110000 {
> +        compatible = "mediatek,mt8195-imgsys1_dip_top";
> +        reg = <0x15110000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys1_dip_nr: clock-controller@15130000 {
> +        compatible = "mediatek,mt8195-imgsys1_dip_nr";
> +        reg = <0x15130000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    imgsys1_wpe: clock-controller@15220000 {
> +        compatible = "mediatek,mt8195-imgsys1_wpe";
> +        reg = <0x15220000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    ipesys: clock-controller@15330000 {
> +        compatible = "mediatek,mt8195-ipesys";
> +        reg = <0x15330000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys: clock-controller@16000000 {
> +        compatible = "mediatek,mt8195-camsys";
> +        reg = <0x16000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_rawa: clock-controller@1604f000 {
> +        compatible = "mediatek,mt8195-camsys_rawa";
> +        reg = <0x1604f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_yuva: clock-controller@1606f000 {
> +        compatible = "mediatek,mt8195-camsys_yuva";
> +        reg = <0x1606f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_rawb: clock-controller@1608f000 {
> +        compatible = "mediatek,mt8195-camsys_rawb";
> +        reg = <0x1608f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_yuvb: clock-controller@160af000 {
> +        compatible = "mediatek,mt8195-camsys_yuvb";
> +        reg = <0x160af000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    camsys_mraw: clock-controller@16140000 {
> +        compatible = "mediatek,mt8195-camsys_mraw";
> +        reg = <0x16140000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    ccusys: clock-controller@17200000 {
> +        compatible = "mediatek,mt8195-ccusys";
> +        reg = <0x17200000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdecsys_soc: clock-controller@1800f000 {
> +        compatible = "mediatek,mt8195-vdecsys_soc";
> +        reg = <0x1800f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdecsys: clock-controller@1802f000 {
> +        compatible = "mediatek,mt8195-vdecsys";
> +        reg = <0x1802f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdecsys_core1: clock-controller@1803f000 {
> +        compatible = "mediatek,mt8195-vdecsys_core1";
> +        reg = <0x1803f000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    apusys_pll: clock-controller@190f3000 {
> +        compatible = "mediatek,mt8195-apusys_pll";
> +        reg = <0x190f3000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vencsys: clock-controller@1a000000 {
> +        compatible = "mediatek,mt8195-vencsys";
> +        reg = <0x1a000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vencsys_core1: clock-controller@1b000000 {
> +        compatible = "mediatek,mt8195-vencsys_core1";
> +        reg = <0x1b000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdosys0: clock-controller@1c01a000 {
> +        compatible = "mediatek,mt8195-vdosys0";
> +        reg = <0x1c01a000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    vdosys1: clock-controller@1c100000 {
> +        compatible = "mediatek,mt8195-vdosys1";
> +        reg = <0x1c100000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> new file mode 100644
> index 000000000000..ea379452ba91
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8195-sys-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MediaTek System Clock Controller for MT8195
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:
> +  The Mediatek system clock controller provides various clocks and system configuration
> +  like reset and bus protection on MT8195.
> +
> +properties:
> +  compatible:
> +    oneOf:

Drop oneOf.

> +      - items:
> +          - enum:
> +              - mediatek,mt8195-topckgen
> +              - mediatek,mt8195-infracfg_ao
> +              - mediatek,mt8195-apmixedsys
> +              - mediatek,mt8195-pericfg_ao
> +          - const: syscon
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
> +    topckgen: syscon@10000000 {
> +        compatible = "mediatek,mt8195-topckgen", "syscon";
> +        reg = <0x10000000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    infracfg_ao: syscon@10001000 {
> +        compatible = "mediatek,mt8195-infracfg_ao", "syscon";
> +        reg = <0x10001000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    apmixedsys: syscon@1000c000 {
> +        compatible = "mediatek,mt8195-apmixedsys", "syscon";
> +        reg = <0x1000c000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> +
> +  - |
> +    pericfg_ao: syscon@11003000 {
> +        compatible = "mediatek,mt8195-pericfg_ao", "syscon";
> +        reg = <0x11003000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> -- 
> 2.18.0
> 
> 
