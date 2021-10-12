Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2B42ABF1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 20:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhJLSbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 14:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhJLSbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 14:31:04 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F17C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:29:02 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a7so552764yba.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 11:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0j5ViPa8JOR3UpqB5rh54uhlCKgBclmUScArWlGBF58=;
        b=oSBsdEeWv+DN5zAyzjr4bx37dTkhPFpUDTuw0YG8l/7DaoLwXKmbCqCe6bCw9KpnzJ
         rybWt+juTODrKhPgyOcs7xQx3iAsn418kY1mj7fceg1nbrM53Jgt1D5oqZ9zEpGEe9Ld
         EUNrSoLoK46A3ipPlqKmq9+a86W0I83HhuGGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0j5ViPa8JOR3UpqB5rh54uhlCKgBclmUScArWlGBF58=;
        b=AB7He20LMb61XmLCPF9OvJ1SdUUOooqIK/C+/r86gDudNhUV6CncajnbMX6wEfOOl4
         5c+ERYO7DGgEccO7dLRpaTzX5eyj+BjBcFqKx9CcmXQbEWxB6JcjE8FmfXqg4CIT/YXV
         I+nTQ+OqLDTIzlC+aj8NIDk2CyGhyEzmiN8Srm91A2PXh0og8gGLCDzQarCicUl0BDPe
         0/mB7QN9Gc/K70wwyYM3GKRwH5rX4HBCxubIuwV6GnxLB46ikbe+TLt0s/i8LeN438hE
         S1eNEivuTEo7kmwAabhy3POmrdFvJpyGzuBfEJv3WABFij52AWTsGRTvLKLDpTs2i2CQ
         DypQ==
X-Gm-Message-State: AOAM531R/XI0JCARq+kyKfAJZqGU+dpFzQD/+YOlTORxWcy8pRnQY8Ft
        kyAztrFyk6apu/ABFbYpQKZcyD6EuNVajY//PSB4EcP3aPvl
X-Google-Smtp-Source: ABdhPJyE/49JgvtXgB89DwKy5L7vD0ETkMChhFXkBXvvEhsu2bgmx/1+S8hBgtSRHyEamqLLY6mwWnzzh8tVVyUJ7NI=
X-Received: by 2002:a25:d47:: with SMTP id 68mr29552470ybn.204.1634063340918;
 Tue, 12 Oct 2021 11:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20211012153432.2817285-1-guoren@kernel.org>
In-Reply-To: <20211012153432.2817285-1-guoren@kernel.org>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 12 Oct 2021 11:28:49 -0700
Message-ID: <CAOnJCUK9brNWCBxS3NVDv81t+0eZNA90rpq2XLw_megKHN6uFA@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: update riscv plic compatible string
To:     Guo Ren <guoren@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 8:35 AM <guoren@kernel.org> wrote:
>
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

I think it would be better to document the difference between sifive
plic and thead plic in
the description section.

>        - const: sifive,plic-1.0.0
>
>    reg:
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
