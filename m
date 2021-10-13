Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDCA42B87A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhJMHKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbhJMHKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:10:48 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D33C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:08:45 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so7385109lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rbFd7l7OPLHgXRJICYP8l1mW+A0fzKcfJuJ8PN2v19w=;
        b=BG3aG9KlVB5A9ZOP7wH1qeWhP06GfhbAFZMthjgoj0Lj9Yv0RVv0dKVSSTJRe9vTB1
         JhwuTEHrmB0SJvLJrb9hh7tFpL0dHIi7rpDC/nteRqzpQtstorHgnEhlqDCMXr3LbCcm
         xHOdmI5Du2v40dyQKAIdt0yIOLEQ26EISzElMKhXfSLBYEVcprXzMKHXsxjmv7Q4ScvI
         f0zKydFzxu1eMd2aX6eUuMKlF/NbQ9/8vXdFhd2WVCtQS3SOSo5wXisGFF7uNfE6uHj8
         QxRMyxL8D+h8Xsc2yO/MshrP86FFkL8NwVtWUOYjlcfnxCfYFMdM06ixsUrC+l2NHAky
         J/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rbFd7l7OPLHgXRJICYP8l1mW+A0fzKcfJuJ8PN2v19w=;
        b=TUxFSOZfgWshht9tRG8yE1ApUuc+GoPCYE28FhVTBk/1FN07yn2vBKqVes/Tlqj9T4
         et/4o9t+HdNh1i2OyVBZrSmh8Vcf9Bz2QVwK/iFWGbEFtf+6qEsMXbFBE3y6dweM06vU
         SllvUbyLwEi5lfTGer+VSQOd2XGJ0vb27CRZ4zcxl63Ikvm0knnW6YERGnI9vSsG7xY+
         f8mtfIsgcZ92NXjtMAHM1NjkzUYGPh4uzwtfyOhr5YPYgmqAXhBUE2SwHdztYX2uBf8X
         DvkvL6ugX1bxYvIPTpGU9kPllEHZu7m79+2W2BMK7VMVOcijKH086dcqHumdqNS/mVeh
         L/aQ==
X-Gm-Message-State: AOAM533rF+vnNx9Q8ofH5I5OCZhmQ+Zzuk9FMkRpU+mTfxbQ6AG0BEJo
        YF4Zg/WKaKnfQhz78VFesEMm9aMbh6aAJHQ1egB+3He5zzmDuya7
X-Google-Smtp-Source: ABdhPJynzKQwjKgkzPCDa8pU63yuWYeEJqPHNUZnxOJNTMhMhI8EtV4ZXja63WcqbXvpOpf/FNWUjpsXp239RBIkdUk=
X-Received: by 2002:a05:6512:10d6:: with SMTP id k22mr37775857lfg.327.1634108924140;
 Wed, 13 Oct 2021 00:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20211006071546.2540920-1-jens.wiklander@linaro.org> <20211006071546.2540920-3-jens.wiklander@linaro.org>
In-Reply-To: <20211006071546.2540920-3-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 13 Oct 2021 12:38:33 +0530
Message-ID: <CAFA6WYN0ke7YbbJZjA9Hnvy_xSMUg27Y-SOziF1Gjgng+DeZ0Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/6] dt-bindings: arm: optee: add interrupt property
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 at 12:45, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds an optional interrupt property to the optee binding.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  .../devicetree/bindings/arm/firmware/linaro,optee-tz.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Apart from minor nit below:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index c24047c1fdd5..40c9f1901e3f 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -24,6 +24,12 @@ properties:
>    compatible:
>      const: linaro,optee-tz
>
> +  interrupts:
> +    maxItems: 1
> +    description: |
> +      This interrupt which is used to signal an event by the secure world
> +      software is expected to be edge-triggered.
> +
>    method:
>      enum: [smc, hvc]
>      description: |
> @@ -46,6 +52,7 @@ examples:
>          optee  {
>              compatible = "linaro,optee-tz";
>              method = "smc";
> +            interrupts = <0 187 1>;

nit: It would be better to use macros here:

 +            interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;

-Sumit

>          };
>      };
>
> --
> 2.31.1
>
