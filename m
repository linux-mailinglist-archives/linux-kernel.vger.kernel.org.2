Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4313FD0BE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 03:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241633AbhIABcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 21:32:51 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:40932 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbhIABcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 21:32:50 -0400
Received: by mail-ot1-f47.google.com with SMTP id 107-20020a9d0bf4000000b0051b8be1192fso1585042oth.7;
        Tue, 31 Aug 2021 18:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Lw5wEyGLhFKN1QsSuNkTilRQwhSnI+fgJb5cuuXVMA=;
        b=qzlR88AvwZWM3mke2etOVCfK61avXAxOUKQyVS043B3CpOEP9FBWotwiPR/CvfD4kb
         5jH+HfOR5Ygrxe+9+2/srUaYGijXjF5A04F301mpkKI6onAw0MBrhK0XzsMDegLICKBy
         JxG3YcLA2F2AiAYv75CETBM6ksZy38EaadBZZK8MBgThKywjSoQhvptIxWnEvAYEUGSW
         bV+mEP9EjpAPclR02FSMSkusiNq4+XQeN23PWRKbAHOmzuZ03Bk6QEWw61PKSjAojG4V
         g1c051g/wXcaLoOHiMYz9FNARFt3Is6NvxsC+BJH8DNWP93bW2No7Vx7gXedfgdF7JW8
         qg5g==
X-Gm-Message-State: AOAM5300QTwVvi1Vx9XcgisqTlpKhlHiiM0UqNYh6OjmCuBCUB2SjaWc
        Xekc7uiOoiFJ7TiKYr8a8Q==
X-Google-Smtp-Source: ABdhPJyjvKiaj7dwS+oiz1y+frWjK2mfZjwgC5T3Qjj7iYAC0upO1xYLYbObjJYp8+UT7d10Mod7gw==
X-Received: by 2002:a05:6830:1355:: with SMTP id r21mr26477741otq.11.1630459914307;
        Tue, 31 Aug 2021 18:31:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f5sm4039042oij.6.2021.08.31.18.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 18:31:53 -0700 (PDT)
Received: (nullmailer pid 1000001 invoked by uid 1000);
        Wed, 01 Sep 2021 01:31:52 -0000
Date:   Tue, 31 Aug 2021 20:31:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [RFC PATCH v3 09/11] dt-bindings: timer: Add ACLINT MTIMER
 bindings
Message-ID: <YS7YCLy2bc3g4avj@robh.at.kernel.org>
References: <20210830041729.237252-1-anup.patel@wdc.com>
 <20210830041729.237252-10-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830041729.237252-10-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30, 2021 at 09:47:27AM +0530, Anup Patel wrote:
> We add DT bindings documentation for the ACLINT MTIMER device
> found on RISC-V SOCs.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>  .../bindings/timer/riscv,aclint-mtimer.yaml   | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> new file mode 100644
> index 000000000000..b0b2ee6c761c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/riscv,aclint-mtimer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V ACLINT M-level Timer
> +
> +maintainers:
> +  - Anup Patel <anup.patel@wdc.com>
> +
> +description:
> +  RISC-V SOCs include an implementation of the M-level timer (MTIMER) defined
> +  in the RISC-V Advanced Core Local Interruptor (ACLINT) specification. The
> +  ACLINT MTIMER device is documented in the RISC-V ACLINT specification found
> +  at https://github.com/riscv/riscv-aclint/blob/main/riscv-aclint.adoc.
> +
> +  The ACLINT MTIMER device directly connects to the M-level timer interrupt
> +  lines of various HARTs (or CPUs) so the RISC-V per-HART (or per-CPU) local
> +  interrupt controller is the parent interrupt controller for the ACLINT
> +  MTIMER device.
> +
> +  The clock frequency of ACLINT is specified via "timebase-frequency" DT
> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +properties:
> +  compatible:
> +    enum:
> +      - riscv,aclint-mtimer
> +
> +    description:
> +      Should be "riscv,aclint-mtimer" or "<vendor>,<chip>-aclint-mtimer".

Again, should be AND.

> +
> +  reg:
> +    description: |
> +      Specifies base physical address(s) of the MTIME register and MTIMECMPx
> +      registers. The 1st region is the MTIME register base and size. The 2nd
> +      region is the MTIMECMPx registers base and size.
> +    minItems: 2
> +    maxItems: 2
> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 4095
> +
> +  mtimer,no-64bit-mmio:
> +    type: boolean
> +    description: If present, the timer does not support 64-bit MMIO accesses
> +      for both MTIME and MTIMECMP registers.

This should be implied by the compatible.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts-extended
> +
> +examples:
> +  - |
> +    timer@2000000 {
> +      compatible = "riscv,aclint-mtimer";
> +      reg = <0x2000000 0x8>,
> +            <0x2004000 0x7ff8>;
> +      interrupts-extended = <&cpu1intc 7>,
> +                            <&cpu2intc 7>,
> +                            <&cpu3intc 7>,
> +                            <&cpu4intc 7>;
> +    };
> +...
> -- 
> 2.25.1
> 
> 
