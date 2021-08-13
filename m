Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3AB3EBC50
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbhHMS6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:58:19 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:41939 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbhHMS6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:58:06 -0400
Received: by mail-oi1-f179.google.com with SMTP id be20so17259349oib.8;
        Fri, 13 Aug 2021 11:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nadjUsMmA1Qaeso04cq+sY3Yg6kOqWs+HX5nofVhdc4=;
        b=ExX2g/BpjM0idb5KQXtWbQ+4rLCQIfboDMRN8aY2wkyRRblLLOm/mF35cx/3fIVL3G
         NZvqse8CaeNzyo7IJ22CGlFXnJAFKGCgMWmCND2aNOuoCE7s2uowjyicLLOykAW9sDk3
         UhNX1/e/290Ytbha9vfx2+RQ0aAjL8iljDr07w2n9H0RFvRGK9KecXz7KgZTL+BINoqv
         fYUC0nTigE1uNLkueiglWDHwoNjuIGpTQCoIy8wGB/djJ+EQQy44MxPY/Y7U9HoHLhHh
         +tZO3Tzp4YPVBm8YQBVd2arLaWX/xTkkYhotkTcKg8jIzTuG/1DRkKxKeb3ygLI71ywk
         nNpw==
X-Gm-Message-State: AOAM530IvYI0m8WgmW5r0ROEPQSkqdx5Q2CN5ClyzEs/BDyI9E1FvvPr
        DRqO5q+pvjcO+aZNkh80XA==
X-Google-Smtp-Source: ABdhPJzyRiyGkIpBy2JkscVZbJCtVPJ+y43xMPYyDEJK+adrJsMiNWm12CDeKvo5ane5KqcSgPG+WQ==
X-Received: by 2002:aca:230f:: with SMTP id e15mr672375oie.154.1628881058944;
        Fri, 13 Aug 2021 11:57:38 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm421828ooh.8.2021.08.13.11.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 11:57:38 -0700 (PDT)
Received: (nullmailer pid 3863381 invoked by uid 1000);
        Fri, 13 Aug 2021 18:57:37 -0000
Date:   Fri, 13 Aug 2021 13:57:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] dt-bindings: ARM: at91: document CalAmp LMU5000 board
Message-ID: <YRbAocukLCTrlRVE@robh.at.kernel.org>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
 <20210805155357.594414-7-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805155357.594414-7-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 06:53:56PM +0300, Claudiu Beznea wrote:
> Document CalAmp LMU5000.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.yaml b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> index a9ab18510fef..08efb259a947 100644
> --- a/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> +++ b/Documentation/devicetree/bindings/arm/atmel-at91.yaml
> @@ -132,6 +132,12 @@ properties:
>            - const: atmel,at91sam9g20
>            - const: atmel,at91sam9
>  
> +      - description: Exegin Q5xR5 board
> +        items:
> +          - const: exegin,q5xr5

You've got your commit msg and diff swapped.

> +          - const: atmel,at91sam9g20
> +          - const: atmel,at91sam9
> +
>        - items:
>            - enum:
>                - atmel,sama5d31
> -- 
> 2.25.1
> 
> 
