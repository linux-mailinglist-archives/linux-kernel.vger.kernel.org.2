Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6318317393
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhBJWpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:45:00 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:39296 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhBJWo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:44:57 -0500
Received: by mail-oi1-f176.google.com with SMTP id l19so3966092oih.6;
        Wed, 10 Feb 2021 14:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3M0msBaL9p/7nJ6GlqMOEs3GDwMywxHD5jz1IJHrbdE=;
        b=RxKbdr1Oanjt+axrW26lPwXeDsJhnCnnSJ7qzQL0bUHiIf2Q0mCH8vKSutudhYUFIP
         i81GobnoIGNv/R73y2uB/sN0cEq84BaChnLtpZKClevkcLSKnACkWUGoWQoRl+j+WJhT
         LrPIdSy2uJXEvk2G1ZDB3e1qUhuPXy4L03u+kMvu4vqBFwbzC/+HM+zcbXdu8AVowqMP
         DkvTm9zMQj9x10PRunB4+NuVix8zJVKXpOI5XNNm+8sZL+PVHHmdDpw8ULQjHp6amJMI
         kSWXj9nOFfixIFfC0UNlPeGSM4BhLJvT/KYaC+AnpodY718WMykQseNn4rr+kcwRufI7
         kX0w==
X-Gm-Message-State: AOAM532Q0eCzBdrZXb/SvoJ8lVTFj92viSUb/upyszZmZIGab9WVUX3e
        zq2mWR5wkszULqTKKmSRqQ==
X-Google-Smtp-Source: ABdhPJxy+3o6WWoRuZXvNqoGfKln05oXvoDI2zQTSg/JoBEmpJWdCKyHSLC63mr2/0y9Tg4Ezi62HQ==
X-Received: by 2002:aca:4d55:: with SMTP id a82mr883173oib.23.1612997056503;
        Wed, 10 Feb 2021 14:44:16 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i20sm644411otl.78.2021.02.10.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:44:15 -0800 (PST)
Received: (nullmailer pid 2949448 invoked by uid 1000);
        Wed, 10 Feb 2021 22:44:13 -0000
Date:   Wed, 10 Feb 2021 16:44:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        wahrenst@gmx.net, linux-arm-kernel@lists.infradead.org,
        mripard@kernel.org, eric@anholt.net, devicetree@vger.kernel.org
Subject: Re: [RFC/PATCH v2 02/16] dt-bindings: soc: bcm: bcm2835-pm:
 Introduce reg-names
Message-ID: <20210210224413.GA2919056@robh.at.kernel.org>
References: <20210209125912.3398-1-nsaenzjulienne@suse.de>
 <20210209125912.3398-3-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209125912.3398-3-nsaenzjulienne@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 01:58:58PM +0100, Nicolas Saenz Julienne wrote:
> Anticipating the introduction of BCM2711, of which we'll need to support
> its new Argon ASB, introduce reg-names into bcm2835-pm's binding. This
> will help to have a consistent mapping between resources and their
> meaning.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml  | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> index 8bc65e5f62a7..1dbe3657c690 100644
> --- a/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> +++ b/Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-pm.yaml
> @@ -26,8 +26,13 @@ properties:
>    reg:
>      minItems: 1
>      maxItems: 2
> -    description: Specifies base physical address and size of the two register
> -                 ranges, "PM" and "ASYNC_BRIDGE" in that order.

Ah, it's okay this way if you have -names. Or have items to give a bit 
more detail.

> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: pm
> +      - const: rpivid_asb

Not really clear how this corresponds to 'ASYNC_BRIDGE'. 'asb' I guess?

>  
>    "#power-domain-cells":
>      const: 1
> @@ -54,6 +59,7 @@ properties:
>  required:
>    - compatible
>    - reg
> +  - reg-names

You can't really make added properties required.

>    - "#power-domain-cells"
>    - "#reset-cells"
>    - clocks
> @@ -70,6 +76,7 @@ examples:
>          #reset-cells = <1>;
>          reg = <0x7e100000 0x114>,
>                <0x7e00a000 0x24>;
> +        reg-names = "pm", "rpivid_asb";
>          clocks = <&clocks BCM2835_CLOCK_V3D>,
>          	 <&clocks BCM2835_CLOCK_PERI_IMAGE>,
>          	 <&clocks BCM2835_CLOCK_H264>,
> -- 
> 2.30.0
> 
