Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6503A4A05
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 22:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbhFKUTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 16:19:01 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:47099 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 16:18:59 -0400
Received: by mail-io1-f47.google.com with SMTP id b14so17438319iow.13;
        Fri, 11 Jun 2021 13:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q0+x2SqoxWiaPifmKrDxHGfFMZV2vnASbAUPISmleOI=;
        b=BbnnJgvhZNQGoqumgKHeJROhZEvWywVJAnOUFH8J4eHclstVdE2uNxN8/fgk5ICsRE
         Cu3NpSwsjhvbET+H4JC9x08bNo6TQ7Vz5I93jZ3Px6x/2sJrloEOrVFJ4mGdUE5XeneF
         seKlqaY8Jkopd9kcdNJbw6/ehix7Vb3XrkCty5+n7E5dxueZyxME4PnEhlRtRpgqfHOQ
         5PrTDPJjI04a7khlN29Nn5Exntjja6fRb+UPDgPT+R9bgv8vYBAvz2yhpQ0fikKFLNrK
         V7bsSKT1I7IxlJSxGks9WxSt0QoiPMA1R1diqsrJs5dXcH5fUw9OpHXGZjUcOQ06lyuy
         HNeA==
X-Gm-Message-State: AOAM530mn94Cnl+NLYGQfxJOE3eIqOQhnO6lIzJJoq4hiEf8YpTj8Y+J
        gUDqcqM8cu7aOs0/OPfIgLsjjgNjoA==
X-Google-Smtp-Source: ABdhPJzQIm/BqMSQwWzSA9z9gs+k22W0KTiGbehcPSKI8jfx8c3oJlpVku2pmx/4kzLFd1YTq5DgtA==
X-Received: by 2002:a05:6602:29d0:: with SMTP id z16mr4427962ioq.207.1623442606182;
        Fri, 11 Jun 2021 13:16:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id i13sm3833718ilr.16.2021.06.11.13.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:16:45 -0700 (PDT)
Received: (nullmailer pid 1608484 invoked by uid 1000);
        Fri, 11 Jun 2021 20:16:43 -0000
Date:   Fri, 11 Jun 2021 14:16:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, matthias.bgg@gmail.com,
        gene_chen@richtek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        cy_huang@richtek.com, gene.chen.richtek@gmail.com
Subject: Re: [PATCH 1/2] regulator: mt6360: Add optional
 mediatek.power-off-sequence in bindings document
Message-ID: <20210611201643.GA1583875@robh.at.kernel.org>
References: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622616875-22740-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 02:54:34PM +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add optional mediatek.power-off-sequence in bindings document.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Hi,
> 
> Originally, we think it must write in platform dependent code like as bootloader.
> But after the evaluation, it must write only when system normal HALT or POWER_OFF.
> For the other cases, just follow HW immediate off by default.

Wouldn't this be handled by PSCI implementation?

> ---
>  .../devicetree/bindings/regulator/mt6360-regulator.yaml       | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
> index a462d99..eaf36e2 100644
> --- a/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/mt6360-regulator.yaml
> @@ -24,6 +24,16 @@ properties:
>    LDO_VIN3-supply:
>      description: Input supply phandle(s) for LDO6/7
>  
> +  mediatek,power-off-sequence:
> +    description: |
> +      Power off sequence time selection for BUCK1/BUCK2/LDO7/LDO6, respetively.
> +      Cause these regulators are all default-on power. Each value from 0 to 63,
> +      and step is 1. Each step means 2 millisecond delay.
> +      Therefore, the power off sequence delay time range is from 0ms to 126ms.
> +    $ref: "/schemas/types.yaml#/definitions/uint8-array"
> +    minItems: 4
> +    maxItems: 4

So this is the delay between BUCK1 and BUCK2, then BUCK2 to LDO7, etcc? 
If we wanted to express this in DT, we'd made this generic which would 
need to be more flexible. A poweroff delay in each regulator (similar to 
the existing power on delay) would be sufficient for what you need I 
think.

Rob
