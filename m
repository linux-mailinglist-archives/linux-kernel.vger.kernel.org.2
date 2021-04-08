Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A37C5358EA5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 22:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhDHUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 16:44:14 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45922 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbhDHUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 16:44:09 -0400
Received: by mail-ot1-f44.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so3592985oty.12;
        Thu, 08 Apr 2021 13:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XBBWatDedME9VyLo4T5IHFnIvoyrnrBYPGAfSuhqOXk=;
        b=AvuLvZDdTpRgZxj0Y+NWGBunISj+nuhBQrFbbe+oCLP51mCAFPJM5I9aln7vjTQFAJ
         08j0RaooP0PGw5jMNwQ+UDhCqLDHaWgt4Zh8xJqCQNm2LuE0p/oSJSOc2e/tlDiF0LGE
         pahU1Q8lAAnDlIGGETvX8jRs4QYw+iCUV/vuWdQsNTlaDiq205eHxP8gdMl/V9rBZEZv
         Vr1Kf9IuzRsxuYWh2/caibAecd1ZOMGTf8sRy+wv0k9Mnde7faPVaah6yLzy2VNlgIBK
         1Mo0FFvWU/GMfcb4Z7ohqjW94ugClRaqY6RSU9z71LIM51uDGIzqKp8ZmoftNbbqFaD9
         3QWA==
X-Gm-Message-State: AOAM531sm22DgLnUSfpOkkSWZ1ibdVhxb6q1rfwhdujV0qLH3Bly0UG6
        V28B0oQaOoDI3YWwPG9s3w==
X-Google-Smtp-Source: ABdhPJxwQ73CtdR2JuZH2FV4YaDwVXoMQhPH7akp4CbOyMrNAslj3Uw/VM1upErlyrG9GQqMt6FHww==
X-Received: by 2002:a05:6830:144e:: with SMTP id w14mr9442181otp.0.1617914635873;
        Thu, 08 Apr 2021 13:43:55 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e20sm104197otl.15.2021.04.08.13.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 13:43:55 -0700 (PDT)
Received: (nullmailer pid 1927882 invoked by uid 1000);
        Thu, 08 Apr 2021 20:43:54 -0000
Date:   Thu, 8 Apr 2021 15:43:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nina Wu <nina-cm.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Neal Liu <neal.liu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Jackson-kt.Chang@mediatek.com
Subject: Re: [PATCH v2 1/6] dt-bindings: devapc: Update bindings
Message-ID: <20210408204354.GA1926089@robh.at.kernel.org>
References: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617259087-5502-1-git-send-email-nina-cm.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 02:38:02PM +0800, Nina Wu wrote:
> From: Nina Wu <Nina-CM.Wu@mediatek.com>

Every change is an 'update'. Perhaps mention mt8192 in the subject.

> 
> To support newer hardware architecture of devapc,
> update device tree bindings.
> 
> Signed-off-by: Nina Wu <Nina-CM.Wu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/soc/mediatek/devapc.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> index 31e4d3c..42b284e 100644
> --- a/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
> @@ -20,11 +20,17 @@ properties:
>    compatible:
>      enum:
>        - mediatek,mt6779-devapc
> +      - mediatek,mt8192-devapc
>  
>    reg:
>      description: The base address of devapc register bank
>      maxItems: 1
>  
> +  vio-idx-num:

Needs a vendor prefix.

> +    description: The number of the devices controlled by devapc
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maxItems: 1
> +
>    interrupts:
>      description: A single interrupt specifier
>      maxItems: 1
> @@ -40,6 +46,7 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - vio-idx-num
>    - interrupts
>    - clocks
>    - clock-names
> @@ -54,6 +61,7 @@ examples:
>      devapc: devapc@10207000 {
>        compatible = "mediatek,mt6779-devapc";
>        reg = <0x10207000 0x1000>;
> +      vio-idx-num = <511>;
>        interrupts = <GIC_SPI 168 IRQ_TYPE_LEVEL_LOW>;
>        clocks = <&infracfg_ao CLK_INFRA_DEVICE_APC>;
>        clock-names = "devapc-infra-clock";
> -- 
> 2.6.4
> 
