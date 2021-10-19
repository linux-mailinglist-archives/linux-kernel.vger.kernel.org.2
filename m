Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F49432DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 08:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233992AbhJSGMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 02:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229649AbhJSGMn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 02:12:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 612F761212;
        Tue, 19 Oct 2021 06:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634623831;
        bh=u+Ilu8ZfCIk/SAHfeUMLovFRamhqskc32+yAIxg0U+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DPkhJySxmCpIUk2eNWQTLHbFcR/tyojuHdM5zdK1mzRiPsABPFMPgPdyoofQ4PXoW
         1X9pjj0vKQPh2ZAmyX/XwOkFYdV6BcAF3NF/qv62c5vQom2zOVFjfWoUIFnG1S4YJ2
         yCg/AzSW6lH4RJ0QQRD8ZbOhYhgx3d4jkPNCeB4ER92YGvWNkkspjD84sEDQgogBro
         dTR5qWEA4HzD5CEl97TPb3vhfgJveiREpUXFRlYpmDdKczpRuUlrTiHFWkdr1E4w5B
         yk7ToI331G1T7wzyaBLL6AX/vL5yqf4euyHJMToJG1YqxXZwAeDXnxzcZ1yjPeCT3E
         XX3bEM/JDdoNQ==
Received: by mail-ua1-f48.google.com with SMTP id f4so1298041uad.4;
        Mon, 18 Oct 2021 23:10:31 -0700 (PDT)
X-Gm-Message-State: AOAM530kZvh4U7x+d5qqX6BNsKv6Gvrah90alHRNxx52CQFurqCNdkKy
        0DzsjXIf5BN5qDDm/c+Qx5N4X8B6bgkDQmr7GL8=
X-Google-Smtp-Source: ABdhPJw3Mc6SqA6Eam+0sVztf/Pclmbs4aaAoLiGe4ywO9oP8nSkm4l+4xes/yIXIaU/1wxduBlytApEX0jhxhKslZk=
X-Received: by 2002:ab0:6797:: with SMTP id v23mr31062668uar.97.1634623830411;
 Mon, 18 Oct 2021 23:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20211015100941.17621-1-heinrich.schuchardt@canonical.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 19 Oct 2021 14:10:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTjhc2JvC9xdXf6DagMNR_sg41txjnw5Wn2NfJLXd7woA@mail.gmail.com>
Message-ID: <CAJF2gTTjhc2JvC9xdXf6DagMNR_sg41txjnw5Wn2NfJLXd7woA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: reg-io-width for SiFive CLINT
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bin Meng <bmeng.cn@gmail.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 6:10 PM Heinrich Schuchardt
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

         ^^^^^^^^^^^ -> allwinner d1, new version of our processors
would support 64bit access
> +      32bit access for MTIMER.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    const: 4
> +
>    interrupts-extended:
>      minItems: 1
>
> --
> 2.32.0
>
>
> --
> opensbi mailing list
> opensbi@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/opensbi



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
