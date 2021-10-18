Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A57430EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhJREf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbhJREf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:35:28 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8937C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 21:33:17 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o20so38941004wro.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 21:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FtUBtWA90x+Pb9HFP4uoXiLc4o2TxeGhqR6fwQbYKb8=;
        b=8FITqn9K5KfRz8Ss1x15c/E4gIyXjugA04x7iNdNUejiXgz2555yzSJAAogSzeqS7q
         q7PQ64fPTE7OmgI+KE4+63vBXNG4t75ylGCguocaJ6W9ts3/Z1BzDET5FIoc2I0p573S
         nMV1YdamHEgyQ8bjZKH1qaKYLQpK/1souUpEJWopgjAFcAIaKWe90l9Yg/iheEyLtPaO
         nXfg1S4L/hDNCIp7SPKlZHganpou+0uiJ/IhRAu8zr1ObxfsGE2/es/iP0LCvWlVHVW+
         1tkyy3NLORkCqIBvtpdUCdzdyiHfetUE4MxNWl8QmpFlJYamaRoNqlJfWNs1c0s3QA7f
         2WuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FtUBtWA90x+Pb9HFP4uoXiLc4o2TxeGhqR6fwQbYKb8=;
        b=ISJw37ZuXfYbEXT01hjwKKXkI7M50qsxrEO4ORCjEKg8nTZbyo+3IzexgRJbVgc6Yf
         vqWPSFh3vCa966p1Wzr2q23TLpZLLl/dpxvA/upF7H6V7A+Xkykzd9yGKRm6/sW4RtgQ
         OWeoUGAQPRdxLEJtwfwJX0gRN140cMxoH9Z8VB2pxLlPzOTLMdgYMJTvDMWKth6WCzln
         SnD8LFKir/RZ1YareSn0ZY9KhTmbg/jq+/38I5H7+ZLCPjxlCjuxjFiNjoMxR9aPwWw0
         L0LD7xZ9YSi22E7RXeeqIYn6wAqQYsXP065v+qRl6pBWPzl3/mQopHevveeKqvubx+cw
         XvNg==
X-Gm-Message-State: AOAM531L91G8uViwAJvCT88GQrGj0+W7CNXgyVgr2Xw51pLwTHZm3mqm
        o9TCxiKkCfvZ+r7M/zGCNF/e8ndEZeR/9AXdQQ9jDg==
X-Google-Smtp-Source: ABdhPJydk0ydbDmFLt6u8ok8LYEytDSxAqGGTqx/OVzL0U1AcEhdOHzFxvIrItXho4WDm+C9oH+N3RJyq1U48OoRJwM=
X-Received: by 2002:a5d:6dce:: with SMTP id d14mr32967521wrz.363.1634531595601;
 Sun, 17 Oct 2021 21:33:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211015120735.27972-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20211015120735.27972-1-heinrich.schuchardt@canonical.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 18 Oct 2021 10:03:04 +0530
Message-ID: <CAAhSdy3JU6jitTWFk4CVRG5Xc7P7ueZzd=xmnKBNpx8eGaR6hw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dt-bindings: reg-io-width for SiFive CLINT
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
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        OpenSBI <opensbi@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 5:37 PM Heinrich Schuchardt
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
> Add a new compatible string "allwinner,sun20i-d1-clint" for the CLINT of
> the Allwinner D1 SoC.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  .../devicetree/bindings/timer/sifive,clint.yaml     | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index a35952f48742..d3b4c6844e2f 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -26,6 +26,7 @@ properties:
>        - enum:
>            - sifive,fu540-c000-clint
>            - canaan,k210-clint
> +          - allwinner,sun20i-d1-clint
>        - const: sifive,clint0
>
>      description:
> @@ -33,14 +34,22 @@ properties:
>        Supported compatible strings are -
>        "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integrated
>        onto the SiFive FU540 chip, "canaan,k210-clint" for the SiFive
> -      CLINT v0 as integrated onto the Canaan Kendryte K210 chip, and
> -      "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
> +      CLINT v0 as integrated onto the Canaan Kendryte K210 chip,
> +      "allwinner,sun20i-d1-clint" for the CLINT in the Allwinner D1 SoC,
> +      and "sifive,clint0" for the SiFive CLINT v0 IP block with no chip
>        integration tweaks.
>        Please refer to sifive-blocks-ip-versioning.txt for details
>
>    reg:
>      maxItems: 1
>
> +  reg-io-width:
> +    description: |
> +      Some CLINT implementations, e.g. on the T-HEAD 9xx, only support
> +      32bit access for MTIMER.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    const: 4
> +

Please drop the "reg-io-width" DT property.

Based on discussion on ACLINT MTIMER DT bindings, Rob suggested
using implementation specific compatible string for detecting register IO
width. We should follow the same strategy here as well.

Regards,
Anup

>    interrupts-extended:
>      minItems: 1
>
> --
> 2.32.0
>
