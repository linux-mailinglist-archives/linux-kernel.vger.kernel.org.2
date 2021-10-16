Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D043020F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 12:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244069AbhJPKhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 06:37:19 -0400
Received: from gloria.sntech.de ([185.11.138.130]:44226 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhJPKhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 06:37:18 -0400
Received: from p508fce7c.dip0.t-ipconnect.de ([80.143.206.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mbh1o-0006T3-F9; Sat, 16 Oct 2021 12:35:00 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        robh@kernel.org, guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH V4 2/3] dt-bindings: update riscv plic compatible string
Date:   Sat, 16 Oct 2021 12:34:59 +0200
Message-ID: <2216787.nSqPeTNalD@phil>
In-Reply-To: <20211016032200.2869998-3-guoren@kernel.org>
References: <20211016032200.2869998-1-guoren@kernel.org> <20211016032200.2869998-3-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guo,

Am Samstag, 16. Oktober 2021, 05:21:59 CEST schrieb guoren@kernel.org:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add the compatible string "thead,c900-plic" to the riscv plic
> bindings to support allwinner d1 SOC which contains c906 core.

The compatible strings sound good now, but some things below

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>
> 
> ---
> 
> Changes since V4:
>  - Update description in errata style
>  - Update enum suggested by Anup, Heiko, Samuel
> 
> Changes since V3:
>  - Rename "c9xx" to "c900"
>  - Add thead,c900-plic in the description section
> ---
>  .../interrupt-controller/sifive,plic-1.0.0.yaml       | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 08d5a57ce00f..272f29540135 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -35,6 +35,12 @@ description:
>    contains a specific memory layout, which is documented in chapter 8 of the
>    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>  
> +  The C9xx PLIC does not comply with the interrupt claim/completion process defined
> +  by the RISC-V PLIC specification because C9xx PLIC will mask an IRQ when it is
> +  claimed by PLIC driver (i.e. readl(claim) and the IRQ will be unmasked upon
> +  completion by PLIC driver (i.e. writel(claim). This behaviour breaks the handling
> +  of IRQS_ONESHOT by the generic handle_fasteoi_irq() used in the PLIC driver.
> +
>  maintainers:
>    - Sagar Kadam <sagar.kadam@sifive.com>
>    - Paul Walmsley  <paul.walmsley@sifive.com>
> @@ -46,7 +52,10 @@ properties:
>        - enum:
>            - sifive,fu540-c000-plic
>            - canaan,k210-plic
> -      - const: sifive,plic-1.0.0
> +      - enmu:

	^ spelling enum

> +          - sifive,plic-1.0.0
> +          - thead,c900-plic
> +          - allwinner,sun20i-d1-plic

but in general I'd think that you want something like

  compatible:
    oneOf:
      - items:
          - enum:
              - sifive,fu540-c000-plic
              - canaan,k210-plic
          - const: sifive,plic-1.0.0
      - items:
          - enum:
              - allwinner,sun20i-d1-plic
          - const: thead,c900-plic

Having only one item list would allow as valid combinations like
"sifive,fu540-c000-plic", "thead,c900-plic" when checking the schema.

With the oneOf and separate lists we can make sure that such
"illegal" combinations get flagged by the dtbs_check

[the enum with the single allwinner entry already leaves
 room for later addition to the c900-plic variant]

Heiko



