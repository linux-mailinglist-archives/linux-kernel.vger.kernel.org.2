Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738B03AA0D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhFPQII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:08:08 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:40601 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhFPQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:08:08 -0400
Received: by mail-io1-f42.google.com with SMTP id l64so3587745ioa.7;
        Wed, 16 Jun 2021 09:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xRaK/HqldpKsuXqXX/IP9Ew0ihcv+zDkFzYH6GPtjCU=;
        b=npXk7Y3QF0ZWMgAz6F1k1XWeKzNMsgmE3/ENFgTIxidv9UM0Gi10GcZxnGhlzlcMs4
         51RallnMhr4i/PO8qPfpqN6A95Fk2dPr48GaI1mYSPnvOTkIvG4xkej4M0iINcvZSe6q
         1SPs6cQR0JjcLLbql5XkXMPtu992WJ5mER+D5kyt7d7QYc5f9I7drnWCNkaJUKMXkJIj
         VI3O38FsXzgGAhl+vYODAhBcihFfxpg+/mkRSGpj6n1e/AsvwqcKvi/gbSDopk2MtREL
         VvV5hRU7nBihWv7VKfFtGppNWSiIJ7B8W2+LGyz3WZsUHgBTE6wY5FkHK3VkYHadu6hV
         DyzQ==
X-Gm-Message-State: AOAM533Pvi2S2bmOvshk2URNDB63EjS6jFUWfh44kD4LM++HiyV6RAG8
        O3Okb4CPCm6njj0u5yJ8YHvBVwzyeQ==
X-Google-Smtp-Source: ABdhPJywaPLOJlF56TRwmhGsnmf2dAL99dx9Y5w5diskFgOsh3SbgIZFVCBnoL+OuvJBkl9bKGTcoQ==
X-Received: by 2002:a02:a41a:: with SMTP id c26mr134176jal.87.1623859560712;
        Wed, 16 Jun 2021 09:06:00 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id v15sm1388366ioq.39.2021.06.16.09.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:06:00 -0700 (PDT)
Received: (nullmailer pid 3474948 invoked by uid 1000);
        Wed, 16 Jun 2021 16:05:57 -0000
Date:   Wed, 16 Jun 2021 10:05:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 3/7] dt-bindings: arm: optee: add interrupt property
Message-ID: <20210616160557.GB3472903@robh.at.kernel.org>
References: <20210616103649.2662395-1-jens.wiklander@linaro.org>
 <20210616103649.2662395-4-jens.wiklander@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616103649.2662395-4-jens.wiklander@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 12:36:45PM +0200, Jens Wiklander wrote:
> Adds an optional interrupt property to the optee binding.
> 
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index c931b030057f..3efbe11b637d 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -24,6 +24,9 @@ properties:
>              for the reference implementation maintained by Linaro.
>            const: linaro,optee-tz
>  
> +  interrupts:
> +    maxItems: 1
> +
>    method:
>      description: The method of calling the OP-TEE Trusted OS.
>      $ref: /schemas/types.yaml#/definitions/string-array
> @@ -37,6 +40,10 @@ properties:
>            in drivers/tee/optee/optee_smc.h
>          const: hvc
>  
> +required:
> +  - compatible
> +  - method
> +

This should go in the first patch.

>  additionalProperties: false
>  
>  examples:
> @@ -45,5 +52,6 @@ examples:
>        optee {
>          compatible = "linaro,optee-tz";
>          method = "smc";
> +        interrupts = <0 187 4>;
>        };
>      };
> -- 
> 2.31.1
