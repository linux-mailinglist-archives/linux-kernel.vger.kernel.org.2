Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DC43EA0E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbhJ1VPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 17:15:03 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:37790 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbhJ1VO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 17:14:59 -0400
Received: by mail-oi1-f179.google.com with SMTP id o83so10211044oif.4;
        Thu, 28 Oct 2021 14:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GF/QKgWHePUF0ztiRXZtM8u7QRJ7KFD1ma0iq8wQWWU=;
        b=ASpp4np0RJ7tK2HKoSLqzFu0T8gAyCue7RtUamSJsqYk9Up5HIFcy+s0y7O1C6vBAw
         Cdyi7+oHefZyybOJcD9YflYPI1odiF1y0qXuuBWgT32QkRaMPLTXGms6uwcILMl/BSit
         g5VJPE7tyYrbrpTMwxNGUi9/xArfatYLhJoJjlFDC+64tG4bfsRNX04nctiDTfOBg65e
         oR1Fui7mCYF7A8BDYedkO1IGsUbmeC1mxG6LUVAEKDppSWksJkORCPiNT/H10pxbnrrK
         ftNVVzKAiyFl+irm2XKgpanasztPQUu37btzA4ORPHwY0P4GsHQCH8/p8wNVgzaBBs2u
         5tNQ==
X-Gm-Message-State: AOAM530pmHfRT17uLuXX8hN6WbOUCtZeCOFwC44IdrIV4l3zpUua1ACR
        iboVBhWeH/48TjTVz8LQcg==
X-Google-Smtp-Source: ABdhPJxH9evASEn/c1tJsj0UAND2Xw+iRVZEN7IqIc5V72yz/Fv7Y4DcBiL1q7UGs9KDS/bTcCePJw==
X-Received: by 2002:a54:4d89:: with SMTP id y9mr4939486oix.22.1635455551788;
        Thu, 28 Oct 2021 14:12:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k22sm1397540otn.44.2021.10.28.14.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 14:12:31 -0700 (PDT)
Received: (nullmailer pid 595084 invoked by uid 1000);
        Thu, 28 Oct 2021 21:12:30 -0000
Date:   Thu, 28 Oct 2021 16:12:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] dt-bindings: phy: uniphier-ahci: Add bindings for
 Pro4 SoC
Message-ID: <YXsSPm1SdvaeDwbq@robh.at.kernel.org>
References: <1634687888-23900-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1634687888-23900-8-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1634687888-23900-8-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:58:07AM +0900, Kunihiko Hayashi wrote:
> Update AHCI-PHY binding document for UniPhier Pro4 SoC. Add a compatible
> string, clock and reset lines for the SoC to the document.
> 
> Pro4 AHCI-PHY needs to control additional GIO clock line and reset lines
> ("pm", "tx", and "rx").
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/phy/socionext,uniphier-ahci-phy.yaml    | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> index 745c525ce6b9..67415f7ebe8c 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> @@ -16,6 +16,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - socionext,uniphier-pro4-ahci-phy
>        - socionext,uniphier-pxs2-ahci-phy
>        - socionext,uniphier-pxs3-ahci-phy
>  
> @@ -30,6 +31,9 @@ properties:
>  
>    clock-names:
>      oneOf:
> +      - items:          # for Pro4
> +          - const: gio
> +          - const: link

Add new entries on the end...

>        - items:          # for PXs2
>            - const: link

So add 'gio' here.

And add 'minItems: 1' in this entry.

There's also an error in 'clocks' as it needs 'minItems: 1'


>        - items:          # for others
> @@ -37,12 +41,20 @@ properties:
>            - const: phy
>  
>    resets:
> -    maxItems: 2
> +    minItems: 2
> +    maxItems: 5
>  
>    reset-names:
> -    items:
> -      - const: link
> -      - const: phy
> +    oneOf:
> +      - items:          # for Pro4
> +          - const: gio
> +          - const: link
> +          - const: pm
> +          - const: tx
> +          - const: rx
> +      - items:          # for others
> +          - const: link
> +          - const: phy
>  
>  required:
>    - compatible
> -- 
> 2.7.4
> 
> 
