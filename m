Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DFA3A6800
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 15:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbhFNNgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 09:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234034AbhFNNgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 09:36:25 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33984C061574;
        Mon, 14 Jun 2021 06:34:22 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id e10so15450694ybb.7;
        Mon, 14 Jun 2021 06:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l2CANvuphZSrzl0ZTCZbinBRhj4LvztQqqmEWaSRDg0=;
        b=KoTUuvNEyzlt2nSv9fHlcQl1VR8vNBR53V5fjD/wMvcVrjHpjDE8ogcm0GylBPv/Xd
         6d62ELoGaKGuuPP4XC0t3L+RyxfBDZwfhqMuJYJYXYS1fOY/IVjGCmayExV6mvM2Hbo2
         IKGYsN0NBXbjnEBxr+1hRKFA1+TH+7AMAcMB5EPiZVYgQeAhBM7Ofl5Wjn5MnpcNq1Ke
         /4W3pF8BK0nbtJAPpua0gZH+g0fxBVSei4ust/PtbGCNGzBEQa6DBNfig64IZacds1US
         1rtsLY3oEzmc2uKHdcpIN54kzreRwv5Y95j8tiyJrrvcBbeVDepjxyF8Wx6LN6bx5UL9
         Gifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l2CANvuphZSrzl0ZTCZbinBRhj4LvztQqqmEWaSRDg0=;
        b=byEZor27/5Y1CLGaxbmq/RMGh1iBm+VlaFpVtcreZrzOISG0gmuxXXi7GaqCRE0siV
         dfvHEXgDPMskLRIDmh0u4J6EHO7mM5wlXc6TuJdKBeUaludyPOFIkfJMui/0NbxaWGci
         fOwbk3+lDhfeftTAdoMHNMAk7HXg3nWLyzNHKMOdnQ7DNghKl3S417tnNlT/cJsG9IAs
         kjJUXdZsHQbj3ZTg7PxJt7oPzYBEsrp7cA+zqFg4KNRyCJD/HdcpwB+eVhpjEbYvrL+S
         95uXKMOu9/H2Afg6mChgAlvHDZRsVeJkyrf9fFhOwm1TVDjwLemuLUzmvOwAgAJ8XOGp
         eeug==
X-Gm-Message-State: AOAM533g0fVr16wzwiy9ocaWzOSUdB/g7WOPu2ANCBGBed2td1B9X/zo
        kYEwM3HLQi+d9xGxk/zlh+YUrYthtEZG2Zh3d1c=
X-Google-Smtp-Source: ABdhPJyZWnm9HbeF+owrkleXq8g4uqtOD8ehLmaqnul69zdhZmFi+FmN5c76jOrf062uljYtnDWZj55qRTYSncryD7Y=
X-Received: by 2002:a25:389:: with SMTP id 131mr25399003ybd.306.1623677661526;
 Mon, 14 Jun 2021 06:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210612160422.330705-1-anup.patel@wdc.com> <20210612160422.330705-9-anup.patel@wdc.com>
In-Reply-To: <20210612160422.330705-9-anup.patel@wdc.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Mon, 14 Jun 2021 21:34:08 +0800
Message-ID: <CAEUhbmV0CXuFvyDtiTXsV-S_qRa8r-yX_=CU8xDdqneNcxnOiw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 08/10] dt-bindings: timer: Add ACLINT MTIMER bindings
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2021 at 12:09 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> We add DT bindings documentation for the ACLINT MTIMER device
> found on RISC-V SOCs.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  .../bindings/timer/riscv,aclint-mtimer.yaml   | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
>
> diff --git a/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> new file mode 100644
> index 000000000000..21c718f8ab4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> @@ -0,0 +1,55 @@
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
> +  The ACLINT MTIMER device directly connect to the M-level timer interrupt

connects

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
> +    items:
> +      - const: riscv,aclint-mtimer
> +
> +    description:
> +      Should be "<vendor>,<chip>-aclint-mtimer" and "riscv,aclint-mtimer".
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts-extended:
> +    minItems: 1
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
> +    timer@2004000 {
> +      compatible = "riscv,aclint-mtimer";
> +      interrupts-extended = <&cpu1intc 7 &cpu2intc 7 &cpu3intc 7 &cpu4intc 7>;
> +      reg = <0x2004000 0x8000>;
> +    };
> +...

Otherwise,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
