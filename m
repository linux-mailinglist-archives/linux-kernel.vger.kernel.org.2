Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A1F42B46D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 07:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbhJMFOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 01:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhJMFOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 01:14:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35D2C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:11:59 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m22so4192254wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 22:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oEFV0or7PHUMQMd5+/L2xMc0OUI7R/fEGHl3NgZeoE=;
        b=P6BmYB+k8phnQzRTC3McT5TXQ8SpqX/hpEQgWN3LcU8BGs0jrFnydtG6bmNfoEuK3v
         cosAys/VatlzBRzIkb9in8GJt4YcCKeQeUott/GfXHGoNDxCAv6nMOU6yg9mW+d6TmKv
         iH1IxjgFVNeRJsRcFwvtLuusAhjniK8m2krvcsvLmmvFUtGnR11DbNzQZfpurHHXzQFI
         p2oKSpijSJ3Kt2Qh4bhcZnChgUHkqBC34WIzr5TdBJ9ZGPZd/iqEGbi5LiT9gP5TXtlQ
         ipyxeI5zNq33H8eFNddXucBXn7mCJJMETWx5qBJTUVt/PwQB9qkNaC+jcEfD0jYSKFY/
         378w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oEFV0or7PHUMQMd5+/L2xMc0OUI7R/fEGHl3NgZeoE=;
        b=6Gqew3fB6xb31ZtLSgGunyW4rRhG49zcHEMIA5V2jON5wafubj7bXomR+O5rgufVed
         HtBJV4Urq/Zcdpmynxy+I/IFViZFlXP7DDSbhGjcLzMOJlCxEDOwLhuXjCKdVaZElSfw
         +mRgrsABLDu1SRkVetpHU+syno5/EYGIQtrTUKyZBUX8uckaPUA58RAirjHykVil/c1+
         34qCgJ6OE+OH3PB3hLHZt+EwXXYLhtBZ6k9O13YcZRZivSVehGBu6gHSOwxYtcUOhDYB
         MDY32J5fKx4kopqivHBtk/PO3kGnYNg3maDc+8nrtDqlNrvDr+tXhPV2V9YoJOORc4fS
         NyGA==
X-Gm-Message-State: AOAM531QmZammUraBE5Z4vULt5d91AP3eTHkIrozvODpOP78AwAfHeIP
        YqUXw9nIPqTcRJ8F5gh52Nn5Gwku+vDe1mYFweKLGw==
X-Google-Smtp-Source: ABdhPJzdApIqxACjaRv7O7yKEyaAFN2tRl4Gnw+yyNwEBbof7YhRHdzOv5Ct31NM/qV+9/G7APIy6OKxcza/LQfShAc=
X-Received: by 2002:a05:600c:4111:: with SMTP id j17mr10363683wmi.59.1634101918493;
 Tue, 12 Oct 2021 22:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org>
In-Reply-To: <20211013012149.2834212-1-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 13 Oct 2021 10:41:46 +0530
Message-ID: <CAAhSdy042JY_Vm2j_d5t4jweS3gf51h30j1O9LXDnE6KkB8AEg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
To:     Guo Ren <guoren@kernel.org>
Cc:     Atish Patra <atish.patra@wdc.com>, Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 6:52 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add the compatible string "thead,c900-plic" to the riscv plic
> bindings to support SOCs with thead,c9xx processor cores.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <atish.patra@wdc.com>
>
> ---
>
> Changes since V3:
>  - Rename "c9xx" to "c900"
>  - Add thead,c900-plic in the description section
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml    | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 08d5a57ce00f..82629832e5a5 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -35,6 +35,11 @@ description:
>    contains a specific memory layout, which is documented in chapter 8 of the
>    SiFive U5 Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>
> +  While the "thead,c900-plic" would mask IRQ with readl(claim), so it needn't
> +  mask/unmask which needed in RISC-V PLIC. When in IRQS_ONESHOT & IRQCHIP_EOI_THREADED
> +  path, unnecessary mask operation would cause a blocking irq bug in thead,c900-plic.
> +  Because when IRQ is disabled in c900, writel(hwirq, claim) would be invalid.

This is a totally incorrect description of the errata required for C9xx PLIC.

Please don't project non-compliance as a feature of C9xx PLIC.

> +
>  maintainers:
>    - Sagar Kadam <sagar.kadam@sifive.com>
>    - Paul Walmsley  <paul.walmsley@sifive.com>
> @@ -46,6 +51,7 @@ properties:
>        - enum:
>            - sifive,fu540-c000-plic
>            - canaan,k210-plic
> +          - thead,c900-plic
>        - const: sifive,plic-1.0.0

The PLIC DT node requires two compatible string:
<implementation_compat>, <spec_compat>

The C9xx PLIC is not RISC-V PLIC so, the DT node should
be: "thead,c900-plic", "thead,c9xx-plic"

You need to change "- const: sifive,plic-1.0.0" to
- enum:
    - sifive,plic-1.0.0
    - thead,c9xx-plic

>
>    reg:
> --
> 2.25.1
>

Regards,
Anup
