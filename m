Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2371B36542D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhDTIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhDTIdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:33:20 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02DC061763
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:32:48 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id d16-20020a4a3c100000b02901f0590a614eso509071ooa.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 01:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1T8M/4Hes3NzluLQXBUJj6LcT4nx2E+5/+ymNCi9rc=;
        b=ednZnGG6fwzO6JD8Iu0xjnPY9PBOnCxmbRtJXT5RpgtoGAE21UQyh6whya2/H0Yo4q
         NRqYrxQL1FGM+4oaNfUzQv/K0iLxeorhv1irOU7PwJqZHfeF6lmQLSzXgALQJZpPutfb
         MBYvAn1iOUQmRdcugUOAX0DN/kiZuOBrnD4jbarZ3NaAHVXk+snwzBDuNT6dxvYRXqOT
         CEVDB+YVnvTTiFUkk5kNNb2yN7ANz4m7tdxSk+Hu/ZG2RFVBWzVJRBBcqBq0woNjCuIj
         apNPLT3YzRHIxQeyjuSulaUzuTqT4SdC2Zg/j/EQLzHQt/sIhnXN2evYU3NVRNpFryLY
         QAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1T8M/4Hes3NzluLQXBUJj6LcT4nx2E+5/+ymNCi9rc=;
        b=bXlHKSY9lxJzyls//bfkr7hbg1IkZfyjwf6BfzDFJk9XTjggNEXVJeEkdLmTkObuC9
         XJ2Qm2J8p2DZ9puvFdkk8zO0bcWc9cwyTLJ7rMsdrULYxe4ep8BMCFw4Fg5/WpnqBD7T
         EwLRxEB9eFv5ok5BraSrHuTFPVGAa5pKdzwcbHz1WJ6VUNi653/ni9FH+PLUMNfRrMFY
         PlN/JGIvi7b8gI5zWxwPLZaZxqqO0yhmhF4L1h3YW7dNOlfoHMeaI4793Rxlk25ouBy6
         IDLcAC7yznZ/ZMvExqXTLZeXpTM2ddneSR4IHIoxslPMw13mdW3l4c/2ZIG13LG6kUxV
         Q5Jg==
X-Gm-Message-State: AOAM5305EvQJtqTVISSCFsxVCEecslhMI3Jte9YiPbkJzpvSSfYKheUT
        MHkTqUf4ojljoY0TGp8gPZ1FOjzwMqqguKn7QuKzeA==
X-Google-Smtp-Source: ABdhPJzx0AqbEbHfxy4WRTGw1GawrenTKJY7KmD+6guym0U5AIFEhAhHoBBVpomiPa0aA5zba/krjXiksupaaF95ezg=
X-Received: by 2002:a4a:e153:: with SMTP id p19mr16412764oot.52.1618907567900;
 Tue, 20 Apr 2021 01:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210416222518.15801-1-nm@ti.com>
In-Reply-To: <20210416222518.15801-1-nm@ti.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 20 Apr 2021 10:32:37 +0200
Message-ID: <CAHUa44GZenrwVWRZW6BKB8cktfXvktJ4OCF0AgPKanYGV01m5g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: firmware: Convert linaro,optee-tz to
 json schema
To:     Nishanth Menon <nm@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2021 at 12:25 AM Nishanth Menon <nm@ti.com> wrote:
>
> Convert linaro,optee-tz to json schema format for better documentation
> and error checks.
>
> NOTE:
> 1. This change does introduce a stricter naming convention for
>    optee nodes.
> 2. We do have false positive checkpatch warning with this patch:
>    "DT binding docs and includes should be a separate patch"
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  .../bindings/arm/firmware/linaro,optee-tz.txt | 31 ----------
>  .../arm/firmware/linaro,optee-tz.yaml         | 62 +++++++++++++++++++
>  2 files changed, 62 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
>
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> deleted file mode 100644
> index d38834c67dff..000000000000
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -OP-TEE Device Tree Bindings
> -
> -OP-TEE is a piece of software using hardware features to provide a Trusted
> -Execution Environment. The security can be provided with ARM TrustZone, but
> -also by virtualization or a separate chip.
> -
> -We're using "linaro" as the first part of the compatible property for
> -the reference implementation maintained by Linaro.
> -
> -* OP-TEE based on ARM TrustZone required properties:
> -
> -- compatible     : should contain "linaro,optee-tz"
> -
> -- method         : The method of calling the OP-TEE Trusted OS. Permitted
> -                   values are:
> -
> -                   "smc" : SMC #0, with the register assignments specified
> -                          in drivers/tee/optee/optee_smc.h
> -
> -                   "hvc" : HVC #0, with the register assignments specified
> -                          in drivers/tee/optee/optee_smc.h
> -
> -
> -
> -Example:
> -       firmware {
> -               optee {
> -                       compatible = "linaro,optee-tz";
> -                       method = "smc";
> -               };
> -       };
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> new file mode 100644
> index 000000000000..6513b5ac8b2c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/firmware/linaro,optee-tz.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#

Are these links supposed to work?

Thanks,
Jens


> +
> +title: OP-TEE Device Tree Bindings
> +
> +maintainers:
> +  - Jens Wiklander <jens.wiklander@linaro.org>
> +
> +description: |
> +  OP-TEE is a piece of software using hardware features to provide a Trusted
> +  Execution Environment. The security can be provided with ARM TrustZone, but
> +  also by virtualization or a separate chip.
> +
> +  We're using "linaro" as the first part of the compatible property for
> +  the reference implementation maintained by Linaro.
> +
> +properties:
> +  $nodename:
> +    const: 'optee'
> +
> +  compatible:
> +    const: linaro,optee-tz
> +
> +  method:
> +    description: The method of calling the OP-TEE Trusted OS.
> +    oneOf:
> +      - description: |
> +          SMC #0, with the register assignments specified
> +          in drivers/tee/optee/optee_smc.h
> +        items:
> +          - const: smc
> +      - description: |
> +          HVC #0, with the register assignments specified
> +          in drivers/tee/optee/optee_smc.h
> +        items:
> +          - const: hvc
> +
> +required:
> +  - compatible
> +  - method
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    firmware  {
> +        optee  {
> +            compatible = "linaro,optee-tz";
> +            method = "smc";
> +        };
> +    };
> +
> +  - |
> +    firmware  {
> +        optee  {
> +            compatible = "linaro,optee-tz";
> +            method = "hvc";
> +        };
> +    };
> --
> 2.31.0
>
