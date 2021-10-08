Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC94271C6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241790AbhJHUEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:04:47 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39816 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241464AbhJHUEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:04:45 -0400
Received: by mail-oi1-f174.google.com with SMTP id a3so15163391oid.6;
        Fri, 08 Oct 2021 13:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9nQoap1ULuQK7iVLoWAeKBBSs/JkNcbSL7NwgshzBsI=;
        b=76jz620uxpB74RJiWUA7QzzU3RJYvvjCjp9m44RDS4ZXi4jrTRzdQP0NvZSBq6DFRE
         zIogCLLrRXZgy+SQJbl/APu3yWgXHzVBi2QrBO8/vA5mbHk7+SqrYUsKgMwd0vTjPctx
         LJkV+N6pSMbpHPXtDPs5Ce/4bXJHTuqviCHyxyDfgL5ygY9KYZujnjXYFypzv0HRUCJC
         2P+r4vAA6xFSdTqUqUgcFkanG6SzuJRzm2l1J68JY+Mdzd2iIOsJ/UnHBtYMOOwrL22X
         tMslEHQ65WgIJO3TOy714SMSgFw8K6O74gxKSNrgamPcaUCqyYfIsfv1lJYQpNterky0
         2Slw==
X-Gm-Message-State: AOAM531nt4wWRwvkc8kIXhTr7y6MVKZeDln9+yMtm4hYSyFen0/VubGv
        BzvIM3GfNz7XRI5Z03/XSQ==
X-Google-Smtp-Source: ABdhPJzqK1YBt9O2Wf7HyQiPYRdY2MRV8ungwnGt9QUq/jioAb4R17CLgfe9r5Mc3Vqd8WKz58zv1A==
X-Received: by 2002:a05:6808:14d6:: with SMTP id f22mr18407990oiw.132.1633723369981;
        Fri, 08 Oct 2021 13:02:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l2sm81700otu.23.2021.10.08.13.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:02:49 -0700 (PDT)
Received: (nullmailer pid 3230980 invoked by uid 1000);
        Fri, 08 Oct 2021 20:02:48 -0000
Date:   Fri, 8 Oct 2021 15:02:48 -0500
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
Subject: Re: [RFC PATCH v4 08/10] dt-bindings: timer: Add ACLINT MTIMER
 bindings
Message-ID: <YWCj6CcB29fEQkFI@robh.at.kernel.org>
References: <20211007123632.697666-1-anup.patel@wdc.com>
 <20211007123632.697666-9-anup.patel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211007123632.697666-9-anup.patel@wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 06:06:30PM +0530, Anup Patel wrote:
> We add DT bindings documentation for the ACLINT MTIMER device
> found on RISC-V SOCs.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> ---
>  .../bindings/timer/riscv,aclint-mtimer.yaml   | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> new file mode 100644
> index 000000000000..ebb7e81a5a12
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/riscv,aclint-mtimer.yaml
> @@ -0,0 +1,67 @@
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

You need '|' if you want to maintain the paragraphs.

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
> +    items:
> +      - enum:
> +         - sifive,fu540-c000-aclint-mtimer
> +      - const: riscv,aclint-mtimer
> +
> +    description:
> +      Should be "<vendor>,<chip>-aclint-mtimer" and "riscv,aclint-mtimer".
> +
> +  reg:
> +    description: |
> +      Specifies base physical address(s) of the MTIME register and MTIMECMPx
> +      registers. The 1st region is the MTIME register base and size. The 2nd
> +      region is the MTIMECMPx registers base and size.
> +    minItems: 2
> +    maxItems: 2

All this can be expressed as:

items:
  - description: The MTIME registers
  - description: The MTIMECMPx registers

'reg' is always the physical address and size, so no need to redefine 
common properties.


> +
> +  interrupts-extended:
> +    minItems: 1
> +    maxItems: 4095
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
> +      compatible = "sifive,fu540-c000-aclint-mtimer", "riscv,aclint-mtimer";
> +      reg = <0x200bff8 0x8>,
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
