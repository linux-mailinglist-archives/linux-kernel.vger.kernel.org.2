Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCBA42EE9C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbhJOKRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbhJOKRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:17:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74092C061753;
        Fri, 15 Oct 2021 03:14:58 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id s64so21439515yba.11;
        Fri, 15 Oct 2021 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZTDCpxGbeuWo2eDKtm3bA2A8qW6ZaIJb8O6pyREdQeA=;
        b=Oo9miBv8zvbpx9UbpKzN5puJZy7wQq6nWt4BuBIXYZZsDZdwKmPGjKeWxVig0J0J9U
         YxS1NeNWePdLu5ro2hpjheWwl8/9D3MzSDN7kgjxKsWmqACP+Xn4VjDjo7ORtN6k6dPW
         Xxo0nmVPM2kgaurX2RqeHG5G6g8GieY2Os26DwcIzmUS6hZUibUnDR17MY2zow2pjE8Z
         FBWyGIbVergDurjvgN353Lkvqd8vrFGmSlMY0NdnyvIZRYh5syMm/4uyfwpnFgklCMjy
         8MwzKjWKuVJ3qeCThCp0GayV9E4ktFP/WuzdV/OsZ3FtuqZttx1oVitCV4+G4vf5BDDf
         IaSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZTDCpxGbeuWo2eDKtm3bA2A8qW6ZaIJb8O6pyREdQeA=;
        b=iFI631cLog/RT9XsKBKekdb4ptbdBTTyqrLAziawH253DZ5HJ/P8JqilZiFfiODBTB
         MEjBesJiiZMe246zsVIdae7sjrDluoaQBdxwJJBwWlZ1IiJw4VUbcRXM/KMMqU8d4HYZ
         LsXMmjb18O6AP10wJ9WLSFg5Bm6nm1Xx7Rp4aAr6GNOWaj2ZHJsHXCrzrSxcFUE3opx8
         iI9H0dw5iQQoMtFPHple2oOsd9vc0GMgrqflrAhEuOLtFlzQvqtjUeuctU6svc95ONYe
         u+DwmcSJ9iiGHqVBT1TSaD3jqQZHHsOevRH8Ux6LTLTZ/p68eCsc6+G2uGkksw2cQS0l
         lzlQ==
X-Gm-Message-State: AOAM5316XOkuJLm6mmJFZFsME7SDEws3k6SUeDrmASH0vQnuu7h7ayjC
        Zv7OVuGHo/BEgXN62eeHWVCVso+LlMPPqPA/sqg=
X-Google-Smtp-Source: ABdhPJxZCLP+mddS3lhVDgJN0jp2gMO9M1+8VzhY+veemJYIZYG/1ydxrTn3ALlotQ5/YbUymtiyTdwL1VhxymGR2FE=
X-Received: by 2002:a25:346:: with SMTP id 67mr11229803ybd.345.1634292897782;
 Fri, 15 Oct 2021 03:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Fri, 15 Oct 2021 18:14:46 +0800
Message-ID: <CAEUhbmUSmi9mbiHpatBjGgRjrtyJPms9BRmyBPs5BWeVb7n1Nw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: reg-io-width for SiFive CLINT
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 6:09 PM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The CLINT in the T-HEAD 9xx processors do not support 64bit mmio access to
> the MTIMER device. The current schema does not allow to specify this.
>
> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
> restriction. Samuael Holland suggested in
> lib: utils/timer: Use standard property to specify 32-bit I/O
> https://github.com/smaeul/opensbi/commit/b95e9cf7cf93b0af16fc89204378bc59ff30008e
> to use "reg-io-width = <4>;" as the reg-io-width property is generally used
> in the devicetree schema for such a condition.
>
> A release candidate of the ACLINT specification is available at
> https://github.com/riscv/riscv-aclint/releases
>
> Add reg-io-width as optional property to the SiFive Core Local Interruptor.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a35952f48742..266012d887b5 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -41,6 +41,13 @@ properties:
>    reg:
>      maxItems: 1
>
> +  reg-io-width:
> +    description: |
> +      Some CLINT implementations, e.g. on the T-HEAD 9xx, only support
> +      32bit access for MTIMER.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    const: 4

But this is not a "sifive,clint" anyway. Should there be a new
dt-bindings for T-Head clint variant?

> +
>    interrupts-extended:
>      minItems: 1

Regards,
Bin
