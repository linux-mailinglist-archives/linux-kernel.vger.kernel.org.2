Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A9A3EEEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhHQO7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhHQO7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:59:54 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C850DC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:59:20 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id n11so18511766qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=86RDE8t49nfJXJnwRo5mekUUSUCPQ5KzPYvEB9EKLrY=;
        b=b0lhNsvSnO9jLlfIEG8rNqQYdjidUAqphYNQOjsDrLry3LHCTiXXaX/QNiqXCakBAE
         K3AItf2iYzrF+rCo3lqN6NUcV9bRbHfCHZpcz6UW2utKuvOoMYu0wmpC89z8wzXBEMPS
         d2NY2xaY5kn1PmOcg7s8s2MWLlnXAQuvpjpf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=86RDE8t49nfJXJnwRo5mekUUSUCPQ5KzPYvEB9EKLrY=;
        b=fr6E3HTqH19hSzwWIB8SpbMbm+gqF51ZlAUjB2ZaGjoHtCOL5WT0Le5uT43aCyjuhe
         q419V/lsKIt1Mq4CEvShpE2IzMsrIjlkLvQ89q54LzZo5BGIOq1LdqMTR6dhqwu0cjHT
         NBWTsqCE7T1JSQ0LHpIy78q49Oh9I+Q6QNzDRU0x+AkBzcSFA34niKwroxZEiSevUbRD
         oK6qKJJ5yQ9t904R2wiTLloTORfOKSVK1eJ9F7zeN78DcG2U41MRrAj3c4IpDn+Gmr4a
         PwJPWDuwZr//+TaIA6bzqPcBkkORbCdv6oxglw5/g0YSDg0xJngFhddq34UjZJKzCMLP
         nRCA==
X-Gm-Message-State: AOAM533fwEpPbW7CRZdyjtgOkgkyduadEWgmwVGQ9y9jJpYBy28SLCDx
        I6iAZPd2UGOGvulR/SQ3hL3EnADnTtA6YamqOFgt7g==
X-Google-Smtp-Source: ABdhPJx9ThHtRgsLOGVNe4Zf2azxZL7oN3Q/nNJhL13iXQKr218AWZFzMM3mD4YA4CjCrN+vmOaeX1+9adBRB0mlQUM=
X-Received: by 2002:a05:620a:1651:: with SMTP id c17mr4274481qko.170.1629212359777;
 Tue, 17 Aug 2021 07:59:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210817080617.14503-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210817080617.14503-1-krzysztof.kozlowski@canonical.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Tue, 17 Aug 2021 07:59:08 -0700
Message-ID: <CAGt4E5t8oGcjw=q1UeKZcGk=XuYyw-=8LCMjxHDKgKLedd31hw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: memory: convert Broadcom DPFE to dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Device Tree <devicetree@vger.kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for updating this.

> +++ b/Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-controllers/brcm,dpfe-cpu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: DDR PHY Front End (DPFE) for Broadcom STB
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +  - Markus Mayer <mmayer@broadcom.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - brcm,bcm7271-dpfe-cpu
> +          - brcm,bcm7268-dpfe-cpu
> +      - const: brcm,dpfe-cpu
> +
> +  reg:
> +    items:
> +      - description: DCPU register space
> +      - description: DCPU data memory space
> +      - description: DCPU instruction memory space
> +
> +  reg-names:
> +    items:
> +      - const: dpfe-cpu
> +      - const: dpfe-dmem
> +      - const: dpfe-imem
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dpfe-cpu@f1132000 {
> +        compatible = "brcm,bcm7271-dpfe-cpu", "brcm,dpfe-cpu";
> +        reg = <0xf1132000 0x180>,
> +              <0xf1134000 0x1000>,
> +              <0xf1138000 0x4000>;
> +        reg-names = "dpfe-cpu", "dpfe-dmem", "dpfe-imem";
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 36aee8517ab0..be8e4af8ed64 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3855,7 +3855,7 @@ M:        Markus Mayer <mmayer@broadcom.com>
>  M:     bcm-kernel-feedback-list@broadcom.com
>  L:     linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:     Maintained
> -F:     Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.txt
> +F:     Documentation/devicetree/bindings/memory-controllers/brcm,dpfe-cpu.yaml
>  F:     drivers/memory/brcmstb_dpfe.c
>
>  BROADCOM STB NAND FLASH DRIVER
> --
> 2.30.2
>

Acked-by: Markus Mayer <mmayer@broadcom.com>

Regards,
-Markus
