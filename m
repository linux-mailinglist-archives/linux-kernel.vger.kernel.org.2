Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26669376C3F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 00:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhEGWNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 18:13:13 -0400
Received: from mail-oo1-f47.google.com ([209.85.161.47]:33390 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhEGWNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 18:13:02 -0400
Received: by mail-oo1-f47.google.com with SMTP id j17-20020a4ad6d10000b02901fef5280522so2296831oot.0;
        Fri, 07 May 2021 15:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/rvNcQv5ALxrR0naTewdJhe0quQ9LN/bF0ysksseIEY=;
        b=JFiol2ATVfbdQJ6Ul05oLyjvemORvggdq0sGn1meurQjaycpIvDPO6uRc7XmMxynD6
         7Dx/vhrqbTAmaxrRmkywegyJe7PTQOPS/Em1/sW6TP7Oedn0gxdbnXdXtZE1YWOMjayy
         SqUl7o2nzhL6mDF1YHbrq6sYL5Ik2ibBXi/vC0ggOXzKGXnNISNQ3NmAfExikoEKjjyW
         L7/5AE3YqatbeUVSPW07DkcoFP8W5vVQ2lx9LzKkg8ZzQfpX032wF16nSiWjzkU658OE
         7IdxUrjqbrTRVGjvByiYfR6kDIZND1VoqZa8Rqgk8esGKO1+xDNA2NI8EEH68Opnz+JP
         a7Mg==
X-Gm-Message-State: AOAM5307c1EPGui7WdM7xmNizF/nE7w3NVkMBbvMyCEXWGNtvv/xiruC
        4Mk/AvecfaDI2VUd5Bd4StjpPt40wA==
X-Google-Smtp-Source: ABdhPJzvPtsvbac2Jn5WYp0UEmz6zR4DRNDm3TNvPg3pBSSYiFtETu2wQBHRtLL52BozFDBoXwU57A==
X-Received: by 2002:a4a:d98a:: with SMTP id k10mr9444899oou.51.1620425522176;
        Fri, 07 May 2021 15:12:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k8sm1212467oig.6.2021.05.07.15.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 15:12:01 -0700 (PDT)
Received: (nullmailer pid 2987891 invoked by uid 1000);
        Fri, 07 May 2021 22:12:00 -0000
Date:   Fri, 7 May 2021 17:12:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     vkoul@kernel.org, linux-phy@lists.infradead.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com
Subject: Re: [PATCH 2/5] dt-bindings: phy: mediatek,mt7621-pci-phy: add clock
 entries
Message-ID: <20210507221200.GA2984128@robh.at.kernel.org>
References: <20210506111531.21978-1-sergio.paracuellos@gmail.com>
 <20210506111531.21978-3-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506111531.21978-3-sergio.paracuellos@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 01:15:28PM +0200, Sergio Paracuellos wrote:
> MT7621 SoC clock driver has already mainlined in
> 'commit 48df7a26f470 ("clk: ralink: add clock driver for mt7621 SoC")'
> Hence update schema with the add of the entries related to
> clock.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>  .../bindings/phy/mediatek,mt7621-pci-phy.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
> index 0ccaded3f245..d8614ef8995c 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml
> @@ -16,6 +16,14 @@ properties:
>    reg:
>      maxItems: 1
>  
> +  clocks:
> +    maxItems: 1
> +    description:
> +      PHY reference clock. Must contain an entry in clock-names.
> +
> +  clock-names:
> +    const: sys_clk

You don't really need -names when there is only 1.

> +
>    "#phy-cells":
>      const: 1
>      description: selects if the phy is dual-ported
> @@ -23,6 +31,8 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - clocks
> +  - clock-names

Technically, you can't add new properties and make them required as that 
breaks the ABI. If that's okay here, explain it in the commit message. 

>    - "#phy-cells"
>  
>  additionalProperties: false
> @@ -32,5 +42,7 @@ examples:
>      pcie0_phy: pcie-phy@1e149000 {
>        compatible = "mediatek,mt7621-pci-phy";
>        reg = <0x1e149000 0x0700>;
> +      clocks = <&sysc 0>;
> +      clock-names = "sys_clk";
>        #phy-cells = <1>;
>      };
> -- 
> 2.25.1
> 
