Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D386429C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 06:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhJLEiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 00:38:51 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:33896
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232690AbhJLEik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 00:38:40 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3DDCD40013
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634013398;
        bh=cFDVYMnrfSERHChsUSOafRsFEi1MyUR6LNHqzOlq5OI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=mGWC7i+nYnKJ26isJGMXP4rXSRW2pbFAfkAFCqJ9GBQ0O0itnbo3Ix5dYljYEQ5gC
         ZFMUA1qOtNv6s10jcZRTfKTxem0MdgxJwNj44r/9mTu5eof5NJ3OUJX5gNyXQF487J
         GGTcDki+Bj1nCX4ZKDSOW7/401fX4kPzKk+PfQQ+020gaO0sjzrH0yevrOtaIZaWuw
         RB/nH7/gvcRc/rdNr3J/ww7KXZyoRTzB5WIQXF7+7EgHHXVO7awPf0c49gQq5Erfnk
         HwIErTAQb8BxrLN8Hf+A9JSb1NymNg9RqLT8iOd8XfxSyPl/PE5rZFiVZp8paUyesl
         VCBvMFwi/s31g==
Received: by mail-ed1-f70.google.com with SMTP id i7-20020a50d747000000b003db0225d219so17834019edj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 21:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFDVYMnrfSERHChsUSOafRsFEi1MyUR6LNHqzOlq5OI=;
        b=XFIXl4JcUeAcnOrCRQs4M6MFfQfHxScjG4SsVKQ08SZ0zwIhtYH2e+W5upoTUk+f++
         MfG57DneTLkJqNk8FuxjrB6x38l2dxv65BLV4cZWtFE+wZsNLx8YdfoRHYvW0tLA2/69
         lURj68DYJywDyOYFJnFPOMRWXJzuAsBOLu/FdUH+mBj88AOWPi1crcyumEErgY9etsdv
         VgBlSnaErGLWmLDoj7XqcuaDWbERN804V6tQ1isgcHddeMulu4VsFTSTtRsDni0hn2wD
         KXNTU3Pk+FFH+v0aNdNWaZsD9KY5BKwVuT5Rv0BCa0PKJEtCP5UWexD0PuqdCUv6eNyn
         HltA==
X-Gm-Message-State: AOAM533yiLt/PMdezD8F5/cMzOr+R4cyV9L79ErzQ9jdbERZ36zsXOX/
        TFZgdybCP1SA/zt5Zx3nlTc0g7vcA0/cug0mG6WOg8q7kgt/sAEMJSi90d22O2T9GWvVCNAxt6L
        HiWcy4Bia1jy2A4vlL2qx77yis1C/GbXklrZ9Ij55qlpTlDdNoiqwsha4MA==
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr8901006edz.20.1634013397730;
        Mon, 11 Oct 2021 21:36:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDAwwNTxVTuAVNY2n7n4y7mjZ5+Vt7PQuywm97RBU9A4oXQFDeAQroJkl9fWjqHzLrLVVabbYnoGObk9MrsVI=
X-Received: by 2002:a05:6402:190e:: with SMTP id e14mr8900996edz.20.1634013397600;
 Mon, 11 Oct 2021 21:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com> <20210920130248.145058-2-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210920130248.145058-2-krzysztof.kozlowski@canonical.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Tue, 12 Oct 2021 06:36:25 +0200
Message-ID: <CA+zEjCtE6OQEcgV3GG3OxdKL0JB+dBWCij35MMd-XVZnTcbsrA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 2/5] riscv: dts: sifive: fix Unleashed board compatible
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
> Add missing sifive,fu540 compatible to fix dtbs_check warnings:
>
>   arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dt.yaml: /: compatible: 'oneOf' conditional failed, one must be fixed:
>   ['sifive,hifive-unleashed-a00', 'sifive,fu540-c000'] is too short
>   'sifive,hifive-unleashed-a00' is not one of ['sifive,hifive-unmatched-a00']
>   'sifive,fu740-c000' was expected
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>
> ---
>
> Changes since v1:
> 1. None
> ---
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 633b31b6e25c..2b4af7b4cc2f 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -11,7 +11,8 @@ / {
>         #address-cells = <2>;
>         #size-cells = <2>;
>         model = "SiFive HiFive Unleashed A00";
> -       compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000";
> +       compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000",
> +                    "sifive,fu540";
>
>         chosen {
>                 stdout-path = "serial0";
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
