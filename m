Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E204437FEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 23:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhJVVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 17:24:39 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:37666 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhJVVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 17:24:37 -0400
Received: by mail-ot1-f50.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso5972521otl.4;
        Fri, 22 Oct 2021 14:22:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CgddvVUw2mXha4aQsq+joAmwB7SJYgDFFKT+so5ZqWc=;
        b=JQCVp1KS9zpEbmwidHs4K+8Rpusw6NT77tNNCyHLPf6EZi7e6G05qLp4GxmLGaYG/w
         1gAA6q1V1lqOKFOdpBOKYDD5ug58MDSLNcdNonvLnBj42tEaGejJh7RAoLApegliFH/s
         EAoKoeqZlljUVWS1DiqH7Gqq6clKGtTbT5tRskEvjy5NfwegCkbml4wqGASxc2UXIbgC
         firpehLNOMZmCD8S5DtIY6+AYes9CPt+/kH82pnViK6OgW6IocAUzOPYpH7zcsedIpXd
         o/4tsJ7Hq3CpaHc8xzJhVmBgcQAqD4ou6RoaCPTxWb5vXF+Bb/X4Tp4iYmoKTdNgp9Ui
         e1eg==
X-Gm-Message-State: AOAM5313lJ75E/3AF+lCK2q4fR/quypsJd9uxUNOFVJb+T+Jg7TlIKh6
        Yc14VNycN24YAEgvDyh2LQ==
X-Google-Smtp-Source: ABdhPJy7J9nmIVAe1bK/WZgWHoAJVBT7jB213B2rYjuD6+bYmXBfbpTY0lKSrdEPyaGLpGGsaIT6/w==
X-Received: by 2002:a9d:d52:: with SMTP id 76mr1825166oti.350.1634937739427;
        Fri, 22 Oct 2021 14:22:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm1858976otl.19.2021.10.22.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 14:22:18 -0700 (PDT)
Received: (nullmailer pid 3192660 invoked by uid 1000);
        Fri, 22 Oct 2021 21:22:17 -0000
Date:   Fri, 22 Oct 2021 16:22:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Guo Ren <guoren@linux.alibaba.com>,
        Bin Meng <bmeng.cn@gmail.com>, Xiang W <wxjstz@126.com>,
        Samuel Holland <samuel@sholland.org>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        opensbi@lists.infradead.org
Subject: Re: [PATCH 1/1] dt-bindings: T-HEAD CLINT
Message-ID: <YXMriYWcOcgJSpKj@robh.at.kernel.org>
References: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020093603.28653-1-heinrich.schuchardt@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 11:36:03AM +0200, Heinrich Schuchardt wrote:
> The CLINT in the T-HEAD 9xx CPUs is similar to the SiFive CLINT but does
> not support 64bit mmio access to the MTIMER device.
> 
> OpenSBI currently uses a property 'clint,has-no-64bit-mmio' to indicate the
> restriction and the "sifive,cling0" compatible string. An OpenSBI
> patch suggested to use "reg-io-width = <4>;" as the reg-io-width property
> is generally used in the devicetree schema for such a condition.
> 
> As the design is not SiFive based it is preferable to apply a compatible
> string identifying T-HEAD instead.
> 
> Add a new yaml file describing the T-HEAD CLINT.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> @Palmer, @Anup
> I copied you as maintainers from sifive,clint.yaml. Please, indicate if
> this should be changed.
> 
> For the prior discussion see:
> https://lore.kernel.org/all/20211015100941.17621-1-heinrich.schuchardt@canonical.com/
> https://lore.kernel.org/all/20211015120735.27972-1-heinrich.schuchardt@canonical.com/
> 
> A release candidate of the ACLINT specification is available at
> https://github.com/riscv/riscv-aclint/releases
> ---
>  .../bindings/timer/thead,clint.yaml           | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/thead,clint.yaml
> 
> diff --git a/Documentation/devicetree/bindings/timer/thead,clint.yaml b/Documentation/devicetree/bindings/timer/thead,clint.yaml
> new file mode 100644
> index 000000000000..02463fb2043a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/thead,clint.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/timer/thead,clint.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SiFive Core Local Interruptor
> +
> +maintainers:
> +  - Palmer Dabbelt <palmer@dabbelt.com>
> +  - Anup Patel <anup.patel@wdc.com>
> +
> +description:
> +  T-HEAD (and other RISC-V) SOCs include an implementation of the T-HEAD
> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inter-processor
> +  interrupts. It directly connects to the timer and inter-processor interrupt
> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU) local
> +  interrupt controller is the parent interrupt controller for CLINT device.
> +  The clock frequency of the CLINT is specified via "timebase-frequency" DT
> +  property of "/cpus" DT node. The "timebase-frequency" DT property is
> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - const:
> +          - allwinner,sun20i-d1-clint
> +      - const:
> +          - thead,clint0
> +
> +    description:
> +      Should be "<vendor>,<chip>-clint" and "thead,clint<version>" for
> +      the T-HEAD derived CLINTs.
> +      Supported compatible strings are -
> +      "allwinner,sun20i-d1-clint" for the CLINT in the Allwinner D1 SoC
> +      and "thead,clint0" for the T-HEAD IP block with no chip
> +      integration tweaks.

T-HEAD uses the same versioning as SiFive? If you use version numbers in 
compatible strings, the numbering needs to be documented and correlate 
back to the h/w design. See [1]. IP release numbers for FPGA IP for 
example. What it should not be is the binding author making up 0, 1, 2, 
etc. versions.

Rob

[1] Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt

