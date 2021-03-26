Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3EB34AFAF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 20:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhCZT6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 15:58:09 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:38576 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbhCZT6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 15:58:06 -0400
Received: by mail-io1-f41.google.com with SMTP id e8so6607015iok.5;
        Fri, 26 Mar 2021 12:58:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tJ6yYkB8BxpQIVI/MgIQdvEwTp9s8g0HFbgujThHtvI=;
        b=o7Ztnb0JXzS7gmaplxq1P2B/lR+Rp2U6ainv7XF2VfIvV35Czh21Or75O6sLUFi85t
         0a2QMxUFFVnSzPTZodIOMqNiziBAeTcfK7OfTIawJQAVviJC5ex08af1XdaGzMBqb2nw
         nqhlR2TuoZmIQHHVg2HhlIdX9CHjf+gpSaX5urxDKB+QfVrdSgbboIiNARmgrb84fe1Q
         06Y2d0OydspcvNconmLXUZ9Na8eO146L+fuU/m1OPdIiRjnG+STiq/6xMnLvkVMcvozh
         Qg50QxxozaLpkfo+tXKjF7hZF9C/xSSTU7lpKDP6JFyVdVbCiXo61AfPAIVQvJhfjzOt
         /hTg==
X-Gm-Message-State: AOAM5328vD2l446I9CZ2PTL+H5go5Nboja9TH6M8Hpsj3gBpDpfh7Uus
        5V29fOUfsy+JkzxyhGyzDQ==
X-Google-Smtp-Source: ABdhPJzoPGekUw69MEfjx/t0Uxf+AmBWsQx/rdpQFEmNh+AM5RTSSKpEuYh9fsWBvUQEF2YKhLS0fA==
X-Received: by 2002:a6b:c881:: with SMTP id y123mr11110588iof.152.1616788685731;
        Fri, 26 Mar 2021 12:58:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o19sm4829061ioh.47.2021.03.26.12.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 12:58:04 -0700 (PDT)
Received: (nullmailer pid 3767758 invoked by uid 1000);
        Fri, 26 Mar 2021 19:58:02 -0000
Date:   Fri, 26 Mar 2021 13:58:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nina Wu <nina-cm.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
Subject: Re: [PATCH 1/2] dt-bindings: devapc: Update bindings
Message-ID: <20210326195802.GA3761703@robh.at.kernel.org>
References: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616743871-8087-1-git-send-email-nina-cm.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 03:31:10PM +0800, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>
> 
> To support newer hardware architecture of devapc,
> update device tree bindings.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/devapc.yaml   | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> index 31e4d3c..489f6a9 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> @@ -20,9 +20,27 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt6779-devapc
> +      - mediatek,mt8192-devapc
> +
> +  version:
> +    description: The version of the hardware architecture

This should be implied by the compatible string.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2]
> +    maxItems: 1
> +
> +  slave_type_num:

vendor prefix needed and s/_/-/

> +    description: The number of the devapc set

What?

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 4]
> +    maxItems: 1
>  
>    reg:
>      description: The base address of devapc register bank
> +    maxItems: 4

Need to define what each region is.

> +
> +  vio_idx_num:

vendor prefix needed and s/_/-/

> +    description: The number of the devices controlled by devapc

No need to know which devices?

> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>      maxItems: 1

uint32-array with 'maxItems: 1' is just 'uint32'

>  
>    interrupts:
> @@ -39,7 +57,10 @@ properties:
>  
>  required:
>    - compatible
> +  - version
> +  - slave_type_num
>    - reg
> +  - vio_idx_num
>    - interrupts
>    - clocks
>    - clock-names
> @@ -53,8 +74,28 @@ examples:
>  
>      devapc: devapc@10207000 {
>        compatible = "mediatek,mt6779-devapc";
> +      version = <1>;
> +      slave_type_num = <1>;
>        reg = <0x10207000 0x1000>;
> +      vio_idx_num = <511>;
>        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
>        clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
>        clock-names = "devapc-infra-clock";
>      };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +
> +    devapc: devapc@10207000 {
> +        compatible = "mediatek,mt8192-devapc";
> +        version = <2>;
> +        slave_type_num = <4>;
> +        reg = <0 0x10207000 0 0x1000>,
> +            <0 0x10274000 0 0x1000>,
> +            <0 0x10275000 0 0x1000>,
> +            <0 0x11020000 0 0x1000>;
> +        vio_idx_num = <367 292 242 58>;

Is the length of this the same as the value of slave_type_num? If so, 
don't need both.

> +        interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
> +        clock-names = "devapc-infra-clock";
> +    };
> -- 
> 2.6.4
> 
