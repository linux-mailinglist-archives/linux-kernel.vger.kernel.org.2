Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4324A3E5A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 14:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240819AbhHJMtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 08:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbhHJMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 08:49:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F76C061798
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:48:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id x7so17294706ljn.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrcMLWtfOeCXSMGpjMYNY3zEn4WCrRn/aqSB39sMZio=;
        b=eD3vQDsassz7bEN0mNbQhZAijheRKwqU+oK96s9ut4efsxy/pfcMMgLfN/39mBcNzA
         CWcAVe/mxoYkiw5lw9HAubl20qZcNVos3RgWK1m2BARdzZAuLzG/CDkcJg/YoPg6pxSO
         6pWektyrqQeFMs+3mYXfOkCXNiN4k44T+Av9Xfx5y9PLMvke9N7nIVdxG7ov3uqszD0G
         s+pKlKviR2OdDnoh4hi918VXhjTAb4W2zC/pe4xpQmBAlIe5/uu0nqio9njHt6C5sx0A
         nTPOCui2hn2g9N2pRraqtmMEHWvGpHUdOCSzjrh2QSS7U+ahTai2W/biKy52JtUBdbgL
         rUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrcMLWtfOeCXSMGpjMYNY3zEn4WCrRn/aqSB39sMZio=;
        b=jx22IRN540lk69bcQwmue3PNb58VWjQuzgh3mhbJ08rToBJ+U/YUzoNzZcakNT59uU
         7Xe2eU9alcjgueeDHdvaOdQ3z7yPGUJjE/l2oxZekCLQ4sNBDmVpkZHbcuZ7VeWI03sh
         P0yY6EZWLzvsSFIQdJYt6u++3LsMJSNjEHJL6blK3GsiX97hE8sZJrPUELI2bsI9U+0a
         a9h+6jK4ERXrbsYLLYXF2jrbt2BDdzcqRevJurstz8a/X/zz3He9a9HoxKJUMruJnquA
         B01KoIh4UgjO+H8pp//ryGknkCNVQDPFakxQtep5DVwgrgW4s9gxMR7s7m2DDzfzGu0s
         5mtw==
X-Gm-Message-State: AOAM5327a7g41bYGNYhjPpgvok3Zv678CAvvKYAulIvEfNJTyLKffSs/
        PgPzlhahJAm9A4zy6+dBDIXCdJzohUW8ckl+eT6HtQ==
X-Google-Smtp-Source: ABdhPJyLep687DdIq4Uf7xmhfsYa46ZEV2mhNzCv+q7NsAgri4IdNPReJB6X5A+3utEOR+kjh7KGMkjlhyQd0vAmS5A=
X-Received: by 2002:a2e:a231:: with SMTP id i17mr9037133ljm.467.1628599717797;
 Tue, 10 Aug 2021 05:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210725180830.250218-1-maz@kernel.org>
In-Reply-To: <20210725180830.250218-1-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Aug 2021 14:48:26 +0200
Message-ID: <CACRpkdbAnvk2AyT=Gom=AHZacm7sDJONR=6EnHLZ+cEySqQ4KQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: stmfx: Fix hazardous u8[] to unsigned long cast
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        stable <stable@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 25, 2021 at 8:08 PM Marc Zyngier <maz@kernel.org> wrote:

> Casting a small array of u8 to an unsigned long is *never* OK:
>
> - it does funny thing when the array size is less than that of a long,
>   as it accesses random places in the stack
> - it makes everything even more fun with a BE kernel
>
> Fix this by building the unsigned long used as a bitmap byte by byte,
> in a way that works across endianess and has no undefined behaviours.
>
> An extra BUILD_BUG_ON() catches the unlikely case where the array
> would be larger than a single unsigned long.
>
> Fixes: 1490d9f841b1 ("pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver")
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org
> Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>

Patch applied!

Yours,
Linus Walleij
