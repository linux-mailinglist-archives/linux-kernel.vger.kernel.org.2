Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11948438743
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Oct 2021 09:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhJXHhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 03:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhJXHhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 03:37:41 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4314C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 00:35:21 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5-20020a1c0405000000b0032cb5539960so508552wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRIE383vJ698wFSfRg03sNhcy6U9VEEBxhS9bVA3ruI=;
        b=2wdtSeVNGcC/Sq/OZxMtMFcS0g8vqaownUF5dmjDU3fCv7l1R2zIR2362HFm2QvGqL
         veYW9G1TlYOd538YOmhuUIzCxh8seWgHzRZmnYwPjUeuufYIxI33lKpEOdmrC1oiw69M
         37d0Ih2mXnpXphTbjZa9yQpIfPUvddXJRJyQ93RiJnglDrxtbAowydCdDWs7zHcJmb4Q
         rXCPEoCXVKZc8bNOdzEJjYErDpIJuznrXaBOZIEn6+NNU7ddMsg5/4AupIPv4KMgMgwQ
         i3x8I7x5SHYiB/pGTj+D9jN6a/BJGy/k2udCTEYJhXuKNMNcE2FbQvvvuJdVqVNIdBgb
         FLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRIE383vJ698wFSfRg03sNhcy6U9VEEBxhS9bVA3ruI=;
        b=uN5Rk9FLE6W0L4LZzfyLiH9JaYh2iqwDPwtJFAvLVVgI59eLxniN2D78+pTVX37hiY
         OXLWgTSeMICDmMZ+mdIXRKPi9pB+b4KYoI93XNbELUefPZVkkeuBw4JwQY3/YC8UTDsE
         +db+Lun4A/xzJDM8otjLcBMyVRMJ63pfKpnGIauibXjAw6Vl4CDMnu319kAQKXRW4pcL
         a9yvBCLSp9PEsn9aOrwaK12Jjh7WagTNWqAHowX5+kaVfpIdtJWLwSS9nTOCsRiKF0dm
         fvB33P8iw4cmbb5HH6KtyqOjCWRsuoVSCN0cf1PdgAU9JveccbXzKxk9AOKuIRB0Qqmk
         bjtg==
X-Gm-Message-State: AOAM530O92tjx+TZDAw6I8d3PJXa+0cd4AtJzs2MELhx8eNMi/iBtVEK
        n5LyCvJ4ryRboBYNKwVqMk/VbJZ4m2jKxKj8IuVVug==
X-Google-Smtp-Source: ABdhPJzoIR/OM0dQJ3Lg7NvMpsZq65ugnqjiaD36e/5z4YMD47mYsLKL+ZwN2SOfBg5479U8bWBd1r1MuQK+SRFUKbI=
X-Received: by 2002:a1c:7201:: with SMTP id n1mr40201749wmc.176.1635060920075;
 Sun, 24 Oct 2021 00:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211024013303.3499461-1-guoren@kernel.org> <20211024013303.3499461-3-guoren@kernel.org>
In-Reply-To: <20211024013303.3499461-3-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Sun, 24 Oct 2021 13:05:08 +0530
Message-ID: <CAAhSdy2a2XgjOpezoq=SvX2XTcAWhceKF9X9v3z7xyO9Z4DMPQ@mail.gmail.com>
Subject: Re: [PATCH V5 2/3] dt-bindings: update riscv plic compatible string
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 7:03 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add the compatible string "thead,c900-plic" to the riscv plic
> bindings to support allwinner d1 SOC which contains c906 core.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
>
> ---
>
> Changes since V5:
>  - Add DT list
>  - Fixup compatible string
>  - Remove allwinner-d1 compatible
>  - make dt_binding_check
>
> Changes since V4:
>  - Update description in errata style
>  - Update enum suggested by Anup, Heiko, Samuel
>
> Changes since V3:
>  - Rename "c9xx" to "c900"
>  - Add thead,c900-plic in the description section
> ---
>  .../interrupt-controller/sifive,plic-1.0.0.yaml   | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 08d5a57ce00f..18b97bfd7954 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -35,6 +35,10 @@ description:
>    contains a specific memory layout, which is documented in chapter 8 of the
>    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>
> +  The thead,c900-plic couldn't complete masked irq source which has been disabled in
> +  enable register. Add thead_plic_chip which fix up c906-plic irq source completion
> +  problem by unmask/mask wrapper.
> +

This is an incomplete description about how T-HEAD PLIC is different from
RISC-V PLIC.

I would suggest the following:

The T-HEAD C9xx SoC implements a modified/custom T-HEAD PLIC specification
which will mask current IRQ upon read to CLAIM register and will unmask the IRQ
upon write to CLAIM register. The thead,c900-plic compatible string
represents the
custom T-HEAD PLIC specification.

Regards,
Anup

>  maintainers:
>    - Sagar Kadam <sagar.kadam@sifive.com>
>    - Paul Walmsley  <paul.walmsley@sifive.com>
> @@ -42,11 +46,16 @@ maintainers:
>
>  properties:
>    compatible:
> -    items:
> +   oneOf:
> +    - items:
>        - enum:
> -          - sifive,fu540-c000-plic
> -          - canaan,k210-plic
> +        - sifive,fu540-c000-plic
> +        - canaan,k210-plic
>        - const: sifive,plic-1.0.0
> +    - items:
> +      - enum:
> +        - allwinner,sun20i-d1-plic
> +      - const: thead,c900-plic
>
>    reg:
>      maxItems: 1
> --
> 2.25.1
>
