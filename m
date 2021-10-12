Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B267A429CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 06:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhJLE64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 00:58:56 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34220
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbhJLE6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 00:58:53 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 678374000F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634014611;
        bh=BCyxVEf5Gp0uM4KfbTjyQDlhtbT74n2HOTEb9vV8RKU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=kJzFlPBr9mJMYAVwHtyZqTcK5biSO9T2/leTNQxyCcgVzcV0np6RH0hWYuzTCXoqJ
         rs0kFDJ2aXrtxwimQZOAGLcV5g2mQ1yIbKYZFgO9oDTh9h17S06YN5CsgU7AacVcVz
         J+ODNeFbBvcGHOvgzOVxbsqXBRZx+spAcQxVdQvjEXVyrUqXYs4W7IH/gSULdt5AS5
         0K6a8o8o11m76Hl7uxsB2Mu0nJYIKtwMoTtOxlbr4hCIMdf3dptJSig4S0NnGTwcVc
         Cu/6CfPnDc3T6k3gvcGXnGk3mi0HwZaZxlTjiykRWTmaDmNUhSKeI048ZNZ9Iqogzf
         DJlY9305aYjyg==
Received: by mail-ed1-f69.google.com with SMTP id p13-20020a056402044d00b003db3256e4f2so17885162edw.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 21:56:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BCyxVEf5Gp0uM4KfbTjyQDlhtbT74n2HOTEb9vV8RKU=;
        b=Ddw46qoSaTx48xuvLcbBTbDVT2KQorXLigkDFfcvwywEimELQeAl1eMHaSmm3d3uXm
         ujODEInB0TZqpfPYGLpZE21vwSbJf/E3rqobT7KEpvxDL5fswSp7lrQR3HMrEfPDI4Ed
         Tr0TzFQOEawoR3avdpjgmhu1Gkn4c2GM/17VhV6HGDEvUkx6gUKHFxNoMbY53r2AX1hb
         oHOI5sSR5qLDr4Mg+v8zMuM9iBX8c/RiKwKMFY7mX5cU/HY3ehIlIwFkYy1fNiUc+BL1
         lnAsu1WQceAF/zld+eNCORE3O9E0yBC9BmXIyYpr3VP0mq9GLl/gJ/wBKjIRV5emb0nY
         bGzw==
X-Gm-Message-State: AOAM530V6oniy5Zs880jZhUiG4zGRfzUow33vANRxfVcL46+mjqbev51
        uUlzKDVCafTBnKI1jf2NXQMyY0SHGy8zmhSLW5NdHyLl0TSC1ieN9Xs67mPa4ShGjxWbx8oe5l5
        CkV9yU8pMzUXBHSbOLypVG9SNjoz2WP/J5dnk/ipiqoqht+lXLByZMZQ1+g==
X-Received: by 2002:a17:906:9414:: with SMTP id q20mr31344875ejx.241.1634014609951;
        Mon, 11 Oct 2021 21:56:49 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfX0PyiKdpuHUayAwncldug3i/rdZwjBSq4PyX9ATI6GhXFboX9vjkwh4+o6rNFZcu+ZPtQZmAMuoSunAduXw=
X-Received: by 2002:a17:906:9414:: with SMTP id q20mr31344867ejx.241.1634014609793;
 Mon, 11 Oct 2021 21:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com> <20210920130248.145058-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920130248.145058-3-krzysztof.kozlowski@canonical.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 12 Oct 2021 06:56:38 +0200
Message-ID: <CA+zEjCvhBYW5-QSRtanQjUsbB2Oqx79WaVpmRWnb+qOLU9pZqg@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 3/5] riscv: dts: sifive: drop duplicated nodes
 and properties in sifive
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 3:05 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The DTSI file defines soc node and address/size cells, so there is no
> point in duplicating it in DTS file.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> ---
>
> Changes since v1:
> 1. None
> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 5 -----
>  arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 -----
>  2 files changed, 10 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 2b4af7b4cc2f..ba304d4c455c 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -8,8 +8,6 @@
>  #define RTCCLK_FREQ            1000000
>
>  / {
> -       #address-cells = <2>;
> -       #size-cells = <2>;
>         model = "SiFive HiFive Unleashed A00";
>         compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000",
>                      "sifive,fu540";
> @@ -27,9 +25,6 @@ memory@80000000 {
>                 reg = <0x0 0x80000000 0x2 0x00000000>;
>         };
>
> -       soc {
> -       };
> -
>         hfclk: hfclk {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> index 9b0b9b85040e..4f66919215f6 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
> @@ -8,8 +8,6 @@
>  #define RTCCLK_FREQ            1000000
>
>  / {
> -       #address-cells = <2>;
> -       #size-cells = <2>;
>         model = "SiFive HiFive Unmatched A00";
>         compatible = "sifive,hifive-unmatched-a00", "sifive,fu740-c000",
>                      "sifive,fu740";
> @@ -27,9 +25,6 @@ memory@80000000 {
>                 reg = <0x0 0x80000000 0x4 0x00000000>;
>         };
>
> -       soc {
> -       };
> -
>         hfclk: hfclk {
>                 #clock-cells = <0>;
>                 compatible = "fixed-clock";
> --
> 2.30.2
>
>

This looks good to me, you can add:

Reviewed-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
Tested-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>

Thanks,

Alex

> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
