Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACCBB42A8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237507AbhJLPnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:43:45 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37328 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237246AbhJLPnf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:43:35 -0400
Received: from ip5f5a6e92.dynamic.kabel-deutschland.de ([95.90.110.146] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1maJu8-0006eg-Og; Tue, 12 Oct 2021 17:41:24 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     guoren@kernel.org, anup@brainfault.org, atish.patra@wdc.com,
        maz@kernel.org, tglx@linutronix.de, palmer@dabbelt.com,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>, guoren@kernel.org
Subject: Re: [PATCH V2 1/2] dt-bindings: update riscv plic compatible string
Date:   Tue, 12 Oct 2021 17:41:23 +0200
Message-ID: <3384738.8kAFQ6LgSR@diego>
In-Reply-To: <20211012153432.2817285-1-guoren@kernel.org>
References: <20211012153432.2817285-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Dienstag, 12. Oktober 2021, 17:34:31 CEST schrieb guoren@kernel.org:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add the compatible string "thead,c9xx-plic" to the riscv plic
> bindings to support SOCs with thead,c9xx processor cores.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 08d5a57ce00f..202eb7666f9b 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -46,6 +46,7 @@ properties:
>        - enum:
>            - sifive,fu540-c000-plic
>            - canaan,k210-plic
> +          - thead,c9xx-plic

Devicetree bindings shouldn't use asterisks (the xx-part).
Instead you want (probably)

+          - thead,c906-plic
+          - thead,c910-plic

to name the specific SoCs that plic is used on


Heiko

>        - const: sifive,plic-1.0.0
>  
>    reg:
> 




