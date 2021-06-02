Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0083993E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbhFBTwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:52:13 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:36621 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBTwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:52:10 -0400
Received: by mail-ot1-f51.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so3559686otl.3;
        Wed, 02 Jun 2021 12:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUWpmv8NyLUpVOwTkWcNjRzPnLFgadVxSly1gM51pJ4=;
        b=RCc1BlwBI7a7S2/4ey4AbEAbnlmcctjA67rodie6R8tbAw3SGeNVZIkSHJp/vVoHsu
         kRJpxfN5S8RKUtK/jZ3EMkekIbyYEhuhsUtGybdWlrj+DhxZUFN79sqSYfz4d2kMRsxx
         UDBuxiXMd+a6vO5yn++hBZRElyK9jbnYWSbbMsRQaas2F1cNCw7o46dukyj90Uwni7yg
         4xC7niHu0zbBDD295uSHuwq2AKgveYRu7Kqy+b0BUTzhiXvOetWtHVhz7I1K8P8sIgUM
         0fg+uKudO1Tjf4C/2pkN7Do/ah3OKyoyfq+LOivXbtGtptiuHQzgN+FTOtHcKk2sldbb
         HOog==
X-Gm-Message-State: AOAM532ohCR5at+MWEAwZG6zZ6Ms2zy08mfC7/lgb0gdiNW0YU+U0FrX
        Hflask08XduRFQnQ7YYOPw==
X-Google-Smtp-Source: ABdhPJwNzfmaJMe3pyCXt76BAd3dBGxl7RBQK0yyIv7ohyjx5Db9CBZx6lUWeAp45W1AoXlRQiaMaA==
X-Received: by 2002:a9d:1d49:: with SMTP id m67mr9340022otm.76.1622663411410;
        Wed, 02 Jun 2021 12:50:11 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v19sm189648otk.22.2021.06.02.12.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:50:10 -0700 (PDT)
Received: (nullmailer pid 3872156 invoked by uid 1000);
        Wed, 02 Jun 2021 19:50:09 -0000
Date:   Wed, 2 Jun 2021 14:50:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        kernel@dh-electronics.com
Subject: Re: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
Message-ID: <20210602195009.GA3870858@robh.at.kernel.org>
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 04:30:01PM +0200, Christoph Niedermaier wrote:
> Add DH electronics DHCOM PicoITX and DHCOM DRC02 boards.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: robh+dt@kernel.org
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: kernel@dh-electronics.com
> To: devicetree@vger.kernel.org
> ---
> V2: Remove line with fsl,imx6s on the DRC02 Board
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index fce2a8670b49..3c4ff79a3be7 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -407,6 +407,12 @@ properties:
>            - const: dfi,fs700e-m60
>            - const: fsl,imx6dl
>  
> +      - description: i.MX6DL DHCOM PicoITX Board
> +        items:
> +          - const: dh,imx6dl-dhcom-picoitx
> +          - const: dh,imx6dl-dhcom-som
> +          - const: fsl,imx6dl
> +
>        - description: i.MX6DL Gateworks Ventana Boards
>          items:
>            - enum:
> @@ -458,6 +464,12 @@ properties:
>            - const: toradex,colibri_imx6dl          # Colibri iMX6 Module
>            - const: fsl,imx6dl
>  
> +      - description: i.MX6S DHCOM DRC02 Board
> +        items:
> +          - const: dh,imx6s-dhcom-drc02
> +          - const: dh,imx6s-dhcom-som
> +          - const: fsl,imx6dl

fsl,imx6s?

> +
>        - description: i.MX6SL based Boards
>          items:
>            - enum:
> -- 
> 2.11.0
